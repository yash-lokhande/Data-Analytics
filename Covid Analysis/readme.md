
# Analysis of *Covid-19* Data
![Image of Covid](https://phil.cdc.gov//PHIL_Images/23312/23312_lores.jpg)
## Author - Yash Lokhande
## Date - 02/08/2021

This analysis was made on covid-19 data, which was downloaded from [here](https://ourworldindata.org/covid-deaths).

* The tools used in the analysis are `Microsoft Excel`,`MySQL`,`Tableau`.
* The data was analysed in `MySQL` using aggregate functions, joins, CTE's and was later visualised in `Tableau`.



<br />
<br />
1) To get the total cases and total deaths worldwide and to get the death percentage

```sql
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
(SUM(new_deaths)/SUM(new_cases))*100 AS DeathPercentage
FROM PortfolioProjects..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;
```
<br />
2) To break the above date continent wise

```sql
select location, sum(new_deaths) as TotaldeathCount
from PortfolioProjects..covid_deaths
where continent is null and location not in ('World', 'European Union', 'International')
group by location;
```
<br />
3) What percentage of population is infected in each country, by descending order

```sql
select location, population, max(total_cases) as HighestInfectionCount, round(max(total_cases)/population * 100,4) as PercentPopulationInfected
from PortfolioProjects..covid_deaths
group by location, population
order by PercentPopulationInfected desc;
```
<br />
4) Getting deep into above query by looking at date factor

```sql
select location, population, date, max(total_cases) as HighestInfectionCount, round(max(total_cases)/population * 100,4) as PercentPopulationInfected
from PortfolioProjects..covid_deaths
group by location, population, date
order by PercentPopulationInfected desc;
```
<br />
5) Numbers on vaccination for 1 dose and both doses

```sql
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
order by 1,2;
```
### The `Tableau` dashboard can be found [here](https://public.tableau.com/app/profile/yash8475/viz/CovidDashboard_16279127165560/Dashboard1).
