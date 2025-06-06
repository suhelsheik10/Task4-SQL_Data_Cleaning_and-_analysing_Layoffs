-- mysql : DATA CLEANING 

-- 1. REMOVE DUPLICATES 
-- 2. STANDARDIZE DATA 
-- 3. NULL VALUES OR BLANK VALUES 
-- 4. REMOVE COLUMNS IF NOT NECESSARY 


-- 1. REMOVE DUPLICATES 


CREATE TABLE layoffs_staging                           -- We always need raw data , especially when we do mistake so we are creating another table LAYOFFS_STAGING with same data 
LIKE layoffs;

INSERT INTO layoffs_staging 
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicates_CTE AS                  -- so here window function partition by all the columns so that we could find duplicates , any row gets repeated its row_num = 2 is how we can identify duplicates 
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicates_CTE
WHERE row_num >1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- created one more table where we can delete duplicates , delete or updation doesn't work in CTE

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2;

-- 2. STANDARDIZING DATA 
SELECT DISTINCT TRIM(company)                         -- Trim company to remove whitespace and make it more appealing 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT *                                          -- industry has so many names though they belong to same industry so group them to single name crypto 
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_staging2
SET industry = 'crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT location
FROM layoffs_staging2;

SELECT DISTINCT country                                      -- one is United States other one has United States. , so we need to standardize it .
FROM layoffs_staging2
ORDER BY country ASC;

SELECT DISTINCT country , TRIM(TRAILING '.' FROM country) 
FROM layoffs_staging2
ORDER BY 1;                                                     -- ORDER BY 1 bec order based on first column in select statement that is country 

UPDATE layoffs_staging 
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT country                                      -- one is United States other one has United States. (full stop)  , so we need to standardize it .
FROM layoffs_staging2
ORDER BY country ASC;


SELECT date, STR_TO_DATE(date, '%m/%d/%Y')                   -- Date has data type text , changed to DATE now 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET date = STR_TO_DATE(date, '%m/%d/%Y') ;

ALTER TABLE layoffs_staging2
MODIFY COLUMN date DATE;

-- 3. NULL VALUES  OR BLANK VALUES 

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

SELECT * 
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2 
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = ' ')
AND t2.industry IS NOT NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

-- 4. REMOVE UNNECESSARY COLUMN 

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;



