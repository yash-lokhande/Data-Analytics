alter table PortfolioProjects..covid_deaths
alter column new_deaths int null;

-- 1) To get the total cases and total deaths worldwide and to get the death percentage --

select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from PortfolioProjects..covid_deaths
where continent is not null
order by 1,2;


-- 2) To break the above date continent wise --

select location, sum(new_deaths) as TotaldeathCount
from PortfolioProjects..covid_deaths
where continent is null and location not in ('World', 'European Union', 'International')
group by location;


--3) What percentage of population is infected in each country, by descending order

select location, population, max(total_cases) as HighestInfectionCount, round(max(total_cases)/population * 100,4) as PercentPopulationInfected
from PortfolioProjects..covid_deaths
group by location, population
order by PercentPopulationInfected desc;


-- 4) Getting deep into above query by looking at date factor

select location, population, date, max(total_cases) as HighestInfectionCount, round(max(total_cases)/population * 100,4) as PercentPopulationInfected
from PortfolioProjects..covid_deaths
group by location, population, date
order by PercentPopulationInfected desc;


-- 5) Numbers on vaccination for 1 dose and both doses -- 

Select dea.location, dea.population, max(cast(vac.people_vaccinated as bigint)) as PopulationVaccinatedOneDose, 
round(max(cast(vac.people_vaccinated as bigint))/dea.population * 100,4) as PercentPopulationVaccinated, 
max(cast(vac.people_fully_vaccinated as bigint)) as PopulationVaccinatedFully, 
round(max(cast(vac.people_fully_vaccinated as bigint))/dea.population * 100,4) as PercentPopulationFullVaccinated
From PortfolioProjects..covid_deaths dea
Join PortfolioProjects..covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
group by dea.location, dea.population
order by 1,2
