-- World life Expectancy (Data Cleaning)

select *
from world_life_expectancy
;

-- Identifying duplicates 
select country,year, concat(country,year), count(concat(country,year))
from world_life_expectancy
group by country,year, concat(country,year)
having count(concat(country,year)) > 1
;


-- Identifying row_num duplicates 
select * 
from(
select row_id,
concat(country,year),
row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
from world_life_expectancy
) as row_table
where row_num > 1 
; 
delete from world_life_expectancy
where row_id in (
select row_id
from(
select row_id,
concat(country,year),
row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
from world_life_expectancy
) as row_table
where row_num > 1 )
;

-- Populating blank statuses 

select *
from world_life_expectancy
where status = '' ;

select distinct(status)
from world_life_expectancy
where status <> ''; 

select distinct(country)
from world_life_expectancy 
where status = 'developing'
;

update world_life_expectancy 
set status = 'Developing'
where country In (select distinct(country)
from world_life_expectany
where status = 'Developing')
;

update world_life_expectancy t1
join world_life_expectancy t2
on t1.country = t2.country
set t1.status = 'Developing'
where t1.status = ''
and t2.status <> ''
and t2.status = 'Developing'
; 

update world_life_expectancy t1
join world_life_expectancy t2
on t1.country = t2.country
set t1.status = 'Developed'
where t1.status = ''
and t2.status <> ''
and t2.status = 'Developed'
;

select *
from world_life_expectancy
where `life expectancy` = ''
;
select t1.country,t1.year, t1.`life expectancy`,
t2.country,t2.year, t2.`life expectancy`,
t3.country,t3.year, t3.`life expectancy`,
round((t2.`life expectancy` + t3.`life expectancy`)/2,1)
from world_life_expectancy t1
join world_life_expectancy t2
on t1.country = t2.country
and t1.year = t2.year - 1 
join world_life_expectancy t3
on t1.country = t3.country
and t1.year = t3.year + 1 
where t1.`life expectancy` =''
;
update world_life_expectancy t1
join world_life_expectancy t2
on t1.country = t2.country
and t1.year = t2.year - 1 
join world_life_expectancy t3
on t1.country = t3.country
and t1.year = t3.year + 1 
set t1.`life expectancy` = round((t2.`life expectancy` + t3.`life expectancy`)/2,1)
where t1.`life expectancy` =''

;
select *
from world_life_expectancy