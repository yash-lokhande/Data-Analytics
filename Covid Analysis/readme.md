
## Analysis of Covid data based on total cases, total deaths and vaccinations

# Author - Yash Lokhande
# Date - 02/08/2021

This analysis was made on covid-19 data, which was downloaded from [here](https://ourworldindata.org/covid-deaths).<br />
The tools used in the analysis are Microsoft Excel, MySQL, Tableau.

<br />
<br />

'''sql
-- 1) To get the total cases and total deaths worldwide and to get the death percentage --

select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from PortfolioProjects..covid_deaths
where continent is not null
order by 1,2;
'''