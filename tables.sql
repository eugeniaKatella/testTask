CREATE TABLE `customers` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `name` varchar(40) NOT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `departments` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `customerId` int(11) NOT NULL,
                             `name` varchar(40) NOT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `employees` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `departmentId` int(11) NOT NULL,
                             `name` varchar(40) NOT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `shifts` (
                        `id` int(11) NOT NULL AUTO_INCREMENT,
                        `departmentId` int(11) NOT NULL,
                        `employeeId` int(11) NOT NULL,
                        `shiftType` tinyint(1) NOT NULL DEFAULT '1', -- can be 1,2,3,4
                        `shiftStart` datetime NOT NULL,
                        `shiftEnd` datetime NOT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `workPunches` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `shiftId` int(11) NOT NULL DEFAULT '0',
                             `employeeId` int(11) NOT NULL,
                             `punchIn` datetime NOT NULL,
                             `punchOut` datetime NOT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `leaveApplications` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `employeeId` int(11) NOT NULL,
                                  `leaveStart` date NOT NULL,
                                  `leaveEnd` date NOT NULL,
                                  `status` tinyint(1) NOT NULL DEFAULT '0', -- can be 0,1
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;











