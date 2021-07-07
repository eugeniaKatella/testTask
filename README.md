# Description

In the file tables.sql you can find "create" statements for 6 tables:

**customers** - list of companies - clients of product.

**departments** - list of departments belonging to these companies. 

Field `customerId` is reference to id from table `customer`.

**employees** - list of employees divided by departments. 

Field `departmentId` is is reference to id from table `departments`. 

Employee department is department he/she belongs to but theoretically can also work in other departments.   

**shifts** - schedule for employee created by manager. 
 
 Has reference to employee (`employeeId`) who is assigned to this shift and department id it belongs to.
 
 Shift cannot be longer then 1 day and should be inside one calendar date. 
 
 `shiftStart` - planned datetime when work starts.
 `shiftEnd` - planned datetime when work finishes
 
 Can be one of 4 shift types (`shiftType`): 1 - regular, 2 - on call, 3 - virtual, 4 - extra.
 
**workPunches** - actual working time of employee, which was registered in the system. 

Can be attached to shift (`shiftId`) 
or can be during time where no shifts were planned (`shiftId = 0`). 
Can be few punches for one shift.

 Has reference to employee (`employeeId`)  who register her/his working hours. 
 
 Can be in 2 statuses (`status`):  0 - not approved, 1 - approved. 
 
Punch cannot be longer then 1 day and should be inside one calendar date. 
  
 `punchIn` - datetime when work was started.
 `punchOut` - datetime when work was ended. 
 
**leaveApplications** - employee's leaves (e.g. vacation or sick leaves).
Duration of leave application can be of any length. 
`leaveStart` - date when leave starts
`leaveEnd` -  date when leave finishes

Can be in 2 statuses (`status`):  0 - not approved, 1 - approved. 

Has reference to employee (`employeeId`) who applied for leave.


### Task

#### Part 1
Based on these tables create end-point for fetching employees  actual schedule for specific customer. 

End-point should accept parameter - customer id. 
It should return json of employees with included schedule. 

You should return just: 

1. Shifts with shiftType 1 or 4 (regular or extra) which have approved punches 
(punch with status 1) or are inside dates of approved leave application period  (leave application with status = 1).  
If there no punches or no approved punches and its not inside of leave period - we dont return it. 
If shift is inside of approved leave period (status = 1) you should add leaveApplicationId, otherwise leaveApplicationId = 0.
    Example of response:
    ```json
    [
        {
            "id": 285154,
            "name": "Daniel Johanson",
            "shifts": [
                {
                    "id": 354354,
                    "departmentId": 2345,
                    "shiftStart": "2021-06-29 06:30:00",
                    "shiftEnd": "2021-06-29 15:00:00",
                    "leaveApplicationId": 0,
                    "punches": [
                        {
                            "id": 4234235235,
                            "punchIn": "2021-06-29 06:30:00",                  
                            "punchOut": "2021-06-29 12:30:00"                                 
                            
                        },
                        {
                            "id": 4323525252,
                            "punchIn": "2021-06-29 13:00:00",                  
                            "punchOut": "2021-06-29 15:00:00"                                     
    
                        }
                    ]
                },
                {
                    "id": 354567,
                    "departmentId": 2345,
                    "shiftStart": "2021-06-30 06:30:00",
                    "shiftEnd": "2021-06-30 15:00:00",
                    "leaveApplicationId": 1245,
                    "punches": []
                 }
             
            ]
        }
    ]
    ```
2. Approved Punches (status = 1) without shifts. 
Then "shiftStart" = "punchIn", "shiftEnd" = "punchOut", shift id = 0,  
"departmentId" - department from employee table.
If its inside of approved leave period (status = 1) you should add leaveApplicationId, otherwise leaveApplicationId = 0.
    Example of response:
    ```json
    [
        {
            "id": 285160,
            "name": "Anna Karlson",
            "shifts": [
                {
                    "id": 0,
                    "departmentId": 2350,
                    "shiftStart": "2021-06-29 06:30:00",
                    "shiftEnd": "2021-06-29 15:00:00",
                    "leaveApplicationId": 0,
                    "punches": [
                        {
                            "id": 4234235235,
                            "punchIn": "2021-06-29 06:30:00",                  
                            "punchOut": "2021-06-29 15:00:00"                  
                            
                        }
                    ]
                }
             
            ]
        },
        {
             "id": 2851689,
             "name": "Maria Anderson",
             "shifts": [
                 {
                     "id": 0,
                     "departmentId": 2365,
                     "shiftStart": "2021-06-29 06:30:00",
                     "shiftEnd": "2021-06-29 15:00:00",
                     "leaveApplicationId": 0,
                     "punches": [
                         {
                             "id": 4234235567,
                             "punchIn": "2021-06-29 06:30:00",                  
                             "punchOut": "2021-06-29 15:00:00"                  
                             
                         }
                     ]
                 }
              
             ]
         }
    ]
    ```
. 
#### How to do
You should send link to git **just** with classes needed for logic described in task.     
You **don't need** to implement ORM, VO, login, DB connection layer, routing so on. Just controller with end-point and needed funcions and classes for this logic. 
For repository with SQL you can use any syntax (can be "fake")

for example 
```
$sql = "SELECT * from employees where id = 1234"
$result = $this->database->get($sql);
```

#### Part 2
Adjust "create" queries in tables.sql by adding needed for your queries indexes. 
Remember that these tables can contain millions rows. 
