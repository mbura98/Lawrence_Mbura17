create table projects(
project_id int,
project_name text,
department text,
project_name text,
start_date date,
end_date date,
project_status text
);

---Select all projects from the table---
select *
from projects;

---Count the number of projects per department---
select department, count(*) as number_of_projects
from projects
group by department
order by number_of_projects;

---Calculate the average project budget by department---
select department, round(avg(project_budget), 2) as average_project_budget
from projects
group by department;

---Find projects with a budget greater than 10,000,000---
select *
from projects
where project_budget > 10000000;

---Get the earliest and latest project start dates---
select min(start_date) as earliest_project, max(end_date) as latest_project
from projects;

---Count projects by project_status---
select project_status, count(*) as number_of_projects
from projects
group by project_status
order by number_of_projects desc;

---Find departments with more than 10 projects---
select department, count(*) as no_of_projects
from projects
group by department
having count(*) > 10;

---Calculate project duration in days for each project---
select project_name, project_budget, start_date, end_date,
case when end_date < start_date then 0
else end_date - start_date end as project_duration
from projects;

---List all delayed projects---
select *
from projects
where project_status='Delayed';

---Retrieve the top 5 highest-budget projects---
select *
from projects
order by project_budget desc
limit 5;

---Find the department with the highest total project budget---
select department, sum(project_budget) as total_budget
from projects
group by department
order by total_budget desc
limit 1;

---Count completed projects per department---
select department, project_status, count(*) as no_projects
from projects
where project_status='Completed'
group by department, project_status;

---Find projects ending after 2025---
select *
from projects
where end_date > '2025-12-31';

---Rank projects by budget within each department---
select project_id, project_name, department, sum(project_budget),
rank() over(partition by department order by sum(project_budget) desc) as ranked_budget
from projects
group by project_id, project_name, department;

---Calculate the percentage of cancelled projects---
select
(count(case when project_status = 'Cancelled' then 1 end) * 100.0) 
 / count(*) as cancelled_percentage
from projects;

