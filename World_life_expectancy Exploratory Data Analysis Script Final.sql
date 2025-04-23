-- World Life Expectancy Project (Exploratory Data Analysis) 

select * from
world_life_expectancy;

-- Seeing how country have done in the pass 15 years of life expectancy

select country, min(`Life expectancy`), max(`Life expectancy`)
from world_life_expectancy
group by country
having min(`Life expectancy`) <> 0 and  max(`Life expectancy`) <> 0
order by country desc;

-- which country made biggest strides from lowest to highest point
select country, min(`Life expectancy`),
 max(`Life expectancy`),
  round(max(`Life expectancy`)- min(`Life expectancy`),2) as life_increase_over_15_years
from world_life_expectancy
group by country
having min(`Life expectancy`) <> 0 and  max(`Life expectancy`) <> 0
order by life_increase_over_15_years desc
;
-- Looking at the Year that has done really well - across the entire world
select year, round(avg(`Life expectancy`),2)
from world_life_expectancy
where `Life expectancy` <> 0 
group by year
order by year 

;
-- How gdp affects life expectancy , lower gpd lower life expectancy? Higher gdp longer life?
select country, round(avg(`Life expectancy`),1) as life_expect, round(avg(gdp),1)as gdp
 from world_life_expectancy
 group by country
 having life_expect <> 0 and gdp <> 0 
 order by gdp desc

;
-- case statements life expectancy compared to gdp averages
-- top half of countries vs lower half of countries (gdp)
select 
sum(case when gdp >= 1500 then 1 else 0 end) high_gdp_count,
avg( case when gdp >= 1500 then `life expectancy` else null end) high_gdp_life_expectancy,
sum(case when gdp <= 1500 then 1 else 0 end) low_gdp_count,
avg( case when gdp <= 1500 then `life expectancy` else null end) low_gdp_life_expectancy
    from world_life_expectancy
 
 ;
-- Developed vs developing countries life expectancy 
select * from
world_life_expectancy;

select  status, round(avg(`life expectancy`),1)
from world_life_expectancy
group by  status
;
select  status, count(distinct country), round(avg(`life expectancy`),1)
from world_life_expectancy
group by  status
;

--
select country, round(avg(`life expectancy`),1) as life_expect, round(avg(bmi),1) as BMI
from world_life_expectancy
group by country
having life_expect > 0
and bmi > 0
order by bmi desc
;
-- correlation between life expectancy and adult deaths 
select * from
world_life_expectancy;

select country, year, `life expectancy`, `Adult Mortality`,
sum(`Adult Mortality`) over(partition by country order by year) as rolling_total
from world_life_expectancy
where country like '%united%'
;




