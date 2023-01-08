Thessalonica Turnbull
CS-2443 SQL Server
Assignment 7

--1
SELECT TOP 1 deptMgr_startdate, deptMgrSSN AS [Longest Working Manager]
FROM Department
ORDER BY deptMgr_startdate;


--2
SELECT AVG(empSalary), SUM(empSalary)
FROM Employee;


--3
SELECT projdeptNum, COUNT(projNumber)
FROM Project
GROUP BY projdeptNum;


--4
SELECT p.projName, dl.deptlocation, d.deptName
FROM Project p
JOIN DeptLocation dl ON p.projdeptNum = dl.deptNum
JOIN Department d ON dl.Deptnum = d.deptnum
WHERE dl.deptlocation = 'Oklahoma' OR d.deptName='Production';


--5
SELECT empLName, empFName, 
FROM Employee e 
WHERE empSSN IN (
	SELECT workempSSN
	FROM Assignment
	WHERE a.workprojNumber = 10 OR a.workprojNumber = 20 OR a.workprojNumber=30
	);


--6
--for this query, I chose workHours to be the way to track if a person has done any work, but I think workProjNumber may possibly work as well?
SELECT empLName, empFName, deptName
FROM Employee e
JOIN Assignment a ON e.empSSN = a.workempSSN
WHERE workHours IS NULL;
ORDER BY empLName ASC;


--7
CREATE VIEW department_projects AS
SELECT d.deptnum, d.deptName, p.projName, p.projLocation
FROM DeptLocation d
JOIN Project p ON d.deptnum = p.projdeptNum
WHERE  d.deptlocation = 'Oklahoma' OR d.deptlocation='Texas';


--8
SELECT *
FROM department_projects
WHERE projdeptNum = 3


--9
CREATE TABLE sales_order (
	so_number int NOT NULL,
	so_value int,
	so_empSSN int
	PRIMARY KEY (so_number)
);

INSERT INTO sales_order (so_number, so_value, so_empSSN)
VALUES (1, 100, 000112222);
INSERT INTO sales_order (so_number, so_value, so_empSSN)
VALUES (2, 150, 222334444);
INSERT INTO sales_order (so_number, so_value, so_empSSN)
VALUES (3, 300, 333445555);

SELECT *
FROM sales_order


--10a
CREATE PROCEDURE replace_work_hours
@workempSSN int,
@workProjNumber int,
@workHours int,
AS
BEGIN
	UPDATE Assignment
	SET workHours = @workHours
	WHERE workempSSN = @workempSSN AND workProjNumber = @workProjNumber;
END


--10b.
EXEC replace_work_hours @workempSSN = 999555555, @workprojNumber = 20, @workHours = 15.5;


--11.
CREATE TRIGGER check_work_hours
ON Assignment
AFTER UPDATE
AS
BEGIN
	IF EXISTS (SELECT *
			FROM inserted i
			JOIN deleted d ON i.workempSSN = d.workempSSN
			AND i.workProjNumber = d.workProjNumber
			WHERE i.workHours > 250)
	BEGIN
		RAISERROR("Error: You should have no more than 250 hours per project!", 16,1);
		ROLLBACK TRANSACTION;
	END
END
