
use covid;

CREATE TABLE covid_deaths 
(   id INT not null, 
    iso_code	varchar(300),
    continent	varchar(300),
    location	varchar(300),
    total_cases	int,
    Total_deaths int
);

select * from covid_deaths;

use covid;

CREATE TABLE covid_vacc 
(   id INT not null, 
    iso_code	varchar(300),
    continent	varchar(300),
    location	varchar(300),
    total_tests	int,
    population int
);


-- Using join

select * from covid_vacc;


-- Joining

select covid_deaths.id, covid_deaths.continent, covid_deaths.total_cases, covid_vacc.population
from covid_deaths
join covid_vacc
    on covid_deaths.id = covid_vacc.id
order by 3 desc;



-- Partiion by

select covid_deaths.id, covid_deaths.continent, covid_deaths.total_cases, covid_vacc.population, 
sum(covid_deaths.total_cases) over (Partition by covid_vacc.population)
from covid_deaths
join covid_vacc
    on covid_deaths.id = covid_vacc.id
order by 3 desc;


-- CTE--- ignore this, maybe imessed it up

With T (id, continent, total_cases, population)
as
(
select covid_deaths.id, covid_deaths.continent, covid_deaths.total_cases, covid_vacc.population, 
sum(covid_deaths.total_cases) over (Partition by covid_vacc.population) as Total_popu
from covid_deaths
join covid_vacc
    on covid_deaths.id = covid_vacc.id
order by 3 desc)

select *, (Total_popu.Population)*100
from T;




-- create view

create view Test_view as
select covid_deaths.id, covid_deaths.continent, covid_deaths.total_cases, covid_vacc.population, 
sum(covid_deaths.total_cases) over (Partition by covid_vacc.population)
from covid_deaths
join covid_vacc
    on covid_deaths.id = covid_vacc.id
order by 3 desc;


SELECT * FROM covid.test_view;