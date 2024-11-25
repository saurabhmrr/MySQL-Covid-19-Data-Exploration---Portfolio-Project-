use portfolio_project;

select location, date, total_cases, new_cases, total_deaths,population
from covid_deaths
where continent !="";

select  continent, location, date, new_vaccinations,total_vaccinations,people_vaccinated, total_tests
from covid_vaccinations
where continent !="";

--  Total Cases vs Total Deaths 
--  Shows the death_percetage of population that got covid
select location, date, total_cases, cast(total_deaths as float) as total_deaths,population, (cast(total_deaths as float)/total_cases)*100 AS death_percentage
from covid_deaths
where continent !=""
order by 1;

-- Total Cases vs Population
-- Shows the infected_percentage of popuation that got covid
select location, date, total_cases,population, (total_cases/population)*100 AS infected_percentage
from covid_deaths
order by infected_percentage desc;

-- Shows the infected_percentage of United States that got covid
select location, date, total_cases,population, (total_cases/population)*100 AS infected_percentage
from covid_deaths
where continent !="" and location like '%states%'
order by infected_percentage desc;

-- Countries with highst infection rate compared to population
select location, max(total_cases) as highest_infected_cases, population, MAX((total_cases/population))*100 as highest_infected_rate 
from covid_deaths
where continent !=""
group by location,population
order by highest_infected_rate desc;

-- Countries with highest death count as per population
select location,population, MAX(cast(total_deaths as float)) as highest_death_count
from covid_deaths
where continent !=""
group by location,population
order by highest_death_count desc;

-- Continents with highest death count
select continent as Continent, MAX(cast(total_deaths as float)) as highest_death_count
from covid_deaths
where continent !=""
group by continent
order by highest_death_count desc;

-- Global death percentage 
select sum(total_cases) as total_cases , sum(cast(total_deaths as float)) as total_death,  (sum(cast(total_deaths as float))/sum(total_cases))*100 as death_percent
from covid_deaths;

-- Number of test done per day
select vac.continent,vac.location,vac.date,dth.population,new_tests,vac.total_tests
from covid_deaths dth
join covid_vaccinations vac
on dth.location = vac.location 
and dth.date = vac.date
where dth.continent !="" and vac.total_tests !="";

-- Population vs Total tests
-- Shows Total tests Percentage of population
select vac.continent,vac.location,dth.population,max(cast(vac.total_tests as float)) as total_test, (max(cast(vac.total_tests as float))/population)*100 as percentage_of_test_on_pop
from covid_deaths dth
join covid_vaccinations vac
on dth.location = vac.location 
and dth.date = vac.date
where dth.continent !="" and vac.total_tests !=""
group by location,continent,population
order by percentage_of_test_on_pop desc;

-- People Vaccinated Vs Population 

select vac.continent,vac.location,cast(dth.population as float) as population,cast(vac.people_vaccinated as double) as People_vaccinated
from covid_deaths dth
join covid_vaccinations vac
on dth.location = vac.location 
and dth.date = vac.date
where People_vaccinated !=0;

