
show tables;

use azure_company;

select * from project;

select * from works_on;


-- Consultas SQL

select * from employee;

select e.Ssn, count(*) from employee as e, dependent as d 
where e.Ssn = d.Essn
group by Ssn;

select e.Ssn, count(*) from employee as e
left join dependent as d on e.Ssn = d.Essn
group by Ssn;

SELECT count(Ssn)
FROM employee;

select * from employee;

select * from dependent;

SELECT Bdate, Address FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

select * from departament where Dname = 'Research';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

select * from project;
--
--
--
-- Expressões e concatenação de strings
--
--
-- recuperando informações dos departamentos presentes em Stafford
select Dname as Department, Mgr_ssn as Manager from departament d, dept_locations l
where d.Dnumber = l.Dnumber;

-- padrão sql -> || no MySQL usa a função concat()
select Dname as Department, concat(Fname, ' ', Lname) from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- recuperando info dos projetos em Stafford
select * from project, departament where Dnum = Dnumber and Plocation = 'Stafford';

-- recuperando info sobre os departamentos e projetos localizados em Stafford
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project, departament, employee
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND
Plocation = 'Stafford';

SELECT * FROM employee WHERE Dno IN (3,6,9);

--
--
-- Operadores lógicos
--
--

SELECT Bdate, Address
FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

--
--
-- Expressões e alias
--
--

-- recolhendo o valor do INSS-*
select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.011 as INSS from employee;
select Fname, Lname, Salary, round(Salary*0.011,2) as INSS from employee;

-- definir um aumento de salário para os gerentes que trabalham no projeto associado ao ProdutoX
select e.Fname, e.Lname, 1.1*e.Salary as increased_sal from employee as e,
works_on as w, project as p where e.Ssn = w.Essn and w.Pno = p.Pnumber and p.Pname='ProductX';

-- concatenando e fornecendo alias
select Dname as Department, concat(Fname, ' ', Lname) as Manager from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- recuperando dados dos empregados que trabalham para o departamento de pesquisa
select Fname, Lname, Address from employee, departament
	where Dname = 'Research' and Dnumber = Dno;

-- definindo alias para legibilidade da consulta
select e.Fname, e.Lname, e.Address from employee e, departament d
	where d.Dname = 'Research' and d.Dnumber = e.Dno;




-- view para quantidade total de horas gastas em cada projeto
	SELECT Pname, sum(Hours)

	FROM project

	LEFT JOIN works_on
	ON Pnumber = Pno
	GROUP BY Pname;


select * from employee;
select * from departament;
select * from dept_locations;

-- Juntando os departamentos aos colaboradores
	select t1.*, t2.Dname
    from employee as t1
	left join departament as t2 
    on t1.Dno = t2.Dnumber;

-- juntando colaboradores aos seus gerentes
	select t1.*, t2.Fname
    from employee as t1
	left join employee as t2 
    on t1.Super_ssn = t2.Ssn
    order by t2.Fname;

-- mesclar colunas de nomes em uma
	select *, concat(Fname, ' ', Minit, ' ', Lname) as 'FullName'
    from employee;

-- mesclar nome departamento e localização
	select *
    from departament as t1
    left join dept_locations as t2
    on t1.Dnumber = t2.Dnumber;

-- Agrupamento de quantidade de colaboradores por gerente
	select Super_ssn, count(Super_ssn)
    from employee
    group by Super_ssn;