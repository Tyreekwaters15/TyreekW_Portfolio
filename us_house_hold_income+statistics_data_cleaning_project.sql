SELECT * 
FROM us_income_project.ushouseholdincome_statistics;

alter table us_income_project.ushouseholdincome_statistics rename column `ï»¿id` to `id`
;
-- Counting all id's in the tble
select count(id)
from ushouseholdincome;

select count(id)
from ushouseholdincome_statistics;

SELECT * 
FROM us_income_project.ushouseholdincome_statistics;

SELECT * 
FROM us_income_project.ushouseholdincome;


-- Finding duplicates 
select count(id), id
from ushouseholdincome
group by id
having count(id) > 1
;
select *
from (
select row_id, 
id,
row_number() over(partition by id order by id) row_num
from ushouseholdincome 
) duplicates
where row_num > 1
;

-- Removing duplicates 
delete from ushouseholdincome
where row_id in 
(
	select row_id
	from (
		select row_id, 
		id,
		row_number() over(partition by id order by id) row_num
		from ushouseholdincome 
		) duplicates
where row_num > 1
)
;
-- checking to see if duplicates were deleted
select count(concat(id,state_name)), id
from ushouseholdincome_statistics
group by id
having count(concat(id,state_name)) > 1 
;

select id, count(id)
from ushouseholdincome_statistics
group by id
having count(id) > 1;

select  distinct state_name
from ushouseholdincome
group by state_name;

Update us_income_project.ushouseholdincome
set state_name = 'Georgia'
where state_name = 'georia'
;

Update us_income_project.ushouseholdincome
set state_name = 'Alabama'
where state_name = 'alabama'
;

-- Looking for NULLS
select *
from ushouseholdincome
where county = 'Autauga County'
; 
-- updating null values
update us_income_project.ushouseholdincome
set place = 'Autaugaville'
where county = 'Autauga County' and city = 'Vinemont'
; 

select *
from ushouseholdincome
;
-- Standardizing data 
select type, count(type)
from ushouseholdincome
group by type 
;

update ushouseholdincome
set type = 'Borough'
where type = 'Boroughs'
;
select aland,awater
from ushouseholdincome
where awater in (0,null)
and aland in (0,null)









