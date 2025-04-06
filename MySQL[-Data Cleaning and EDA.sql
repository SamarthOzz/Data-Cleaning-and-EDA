#DATA CLEANING


Select*
from layoffs;

create table layoffs_2
like layoffs;

insert layoffs_2 
select*
from layoffs;

Select*,
row_number() over
(partition by company,industry,total_laid_off,percentage_laid_off,date,stage,country) as row_num
from layoffs_2;

with duplicate_cte as 
(
Select*,
row_number() over (partition by company, industry, total_laid_off, percentage_laid_off, date, stage,country) as row_num
from layoffs_2)

select*
from duplicate_cte
where row_num>1;

select*
from layoffs_2;

CREATE TABLE `layoffs_23` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from layoffs_23;

insert into layoffs_23
select*,
row_number() over (partition by company, industry, total_laid_off, percentage_laid_off, date, stage,country,funds_raised_millions) as row_num
from layoffs_2;

DELETE
from layoffs_23
WHERE row_num>1;

select*
from layoffs_23;

select company, TRIM( company)
from layoffs_23;

update layoffs_23
set company = trim(company);

select *
from layoffs_23
where industry like 'crypto%';

update layoffs_23
set industry= 'crypto'
where industry like 'crypto%';


select distinct country, trim(Trailing '.' from country)
from layoffs_23
order by 1;

update layoffs_23
set country= trim(trailing '.' from country)
where country like 'united states%';

select*
from layoffs_23
where total_laid_off is null;














