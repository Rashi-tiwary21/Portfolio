SELECT * FROM dataset1;
SELECT * FROM dataset2population;

# 1 TOTAL NUBER OF ROWS IN THE DATASET

SELECT Count(*)FROM dataset1;
SELECT Count(*)FROM dataset2population;

# 2 FETCH DATA FOR JHARKHAND AND BIHAR 


SELECT * FROM dataset1
WHERE State in ('Jharkhand' , 'Bihar');

# 2 POPULATION OF INDIA 

SELECT sum(Population) as population FROM dataset2populat;

# 3 FETCH AVERAGE GROWTH RATE OF INDIA

SELECT avg(Growth)*100 as Avg_Growth_Rate FROM dataset1;

# 4 FETCH AVG GROWTH RATE AS PER STATES

SELECT State,avg(Growth)*100 as Avg_Growth_Rate FROM dataset1
GROUP BY State;

# 5 FETCH AVERAGE SEX RATIO 

SELECT Round(avg(Sex_Ratio),0) as Avg_Sex_Ratio FROM dataset1;

# 6 FETCH AVERAGE SEX RATION AS PER STATES

SELECT state,Round(avg(Sex_Ratio),0) as Avg_Sex_Ratio FROM dataset1
GROUP BY State
ORDER BY Avg_Sex_Ratio desc;

# 7 FETCH AVERAGE LITERACY RATE OF THE STATES WHERE LITERACY RATE IS GREATER THAN 90

SELECT State,round(avg(literacy),0) as Avg_Literacy_Rate FROM dataset1
GROUP BY State
HAVING round(avg(literacy),0)>90
ORDER BY Avg_Literacy_Rate desc;

# 8 SHOW TOP 3 STATES SHOWING HIGHEST AVERAGE GROWTH RATIO

SELECT State,avg(growth)*100 as Avg_Growth_Rate FROM dataset1
GROUP BY State
ORDER BY Avg_Growth_Rate DESC limit 3;

# 9 SHOW BOTTOM 3 STATES SHOWING LOWEST AVERAGE SEX RATIO

SELECT State,round(avg(sex_ratio),0) as Avg_Sex_Ratio FROM dataset1
GROUP BY State
ORDER BY Avg_Sex_Ratio ASC Limit 3 ;

# 10 TOP 3 AND BOTTOM 3 STATES IN LITERACY RATE

(SELECT State, ROUND(avg(literacy),0) AS Avg_Literacy_Rate FROM dataset1
GROUP BY State 
ORDER BY Avg_Literacy_Rate desc
 LIMIT 3 )
UNION
(SELECT State,round(avg(literacy),0) as Avg_Literacy_Rate FROM dataset1
GROUP BY State
 ORDER BY Avg_Literacy_Rate ASC 
 LIMIT 3 );
 
 # 11 SHOW STATES STARTING WITH LETTER A
 
 SELECT DISTINCT State FROM dataset1
 where lower(state) like 'a%' or lower(state) like 'b%';

# 12 SHOW STATES STARTING WITH LETTER A and ending with d

SELECT DISTINCT State FROM dataset1
 where lower(state) like 'a%' or lower(state) like '%';
 
 # 12 JOINING BOTH THE TABLE
 
 SELECT a.District,a.State,Sex_Ratio,b.Population 
 From dataset1  a INNER JOIN dataset2population b on a.District=b.District ;
 
# 13 TOTAL MALES & FEMALES

SELECT d.state, sum(d.males) total_males, sum(d.females) total_females from
  (SELECT c.District, c.State state, round(c.population/(c.sex_ratio+1), 0) males, round(c.population*c.sex_ratio/(c.sex_ratio+1), 0) females from
    (SELECT a.District, a.State, Sex_Ratio/1000 as sex_ratio, b.Population From dataset1 a INNER JOIN dataset2population b on a.District=b.District) c) d
  group by d.state; 
 
 # TOTAL LITERACY RATE 

SELECT c.State, sum(literate_people) total_literate_population, sum(illeterate_people) total_illeterate_population FROM
 (SELECT d.District,d.State,round(d.Literacy_ratio*d.Population,0) literate_people,round((1-d.Literacy_ratio)*d.Population,0)illeterate_people FROM
 (SELECT a.District,a.State,a.Literacy/100 Literacy_ratio,a.sex_ratio,b.population from dataset1 a inner join dataset2population b on a.District=b.District) d ) c
 GROUP BY c.State;
 
 # TOTAL POPULATION IN PREVIOUS CENSUS  ----------
 
 (SELECT SUM(m.previous_census_population) as previous_census_population, SUM(m.current_census_population) as current_census_population FROM (
 SELECT e.state,SUM(e.previous_census_population) as previous_census_population,SUM(e.current_census_population) as current_census_population FROM
(SELECT d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population FROM
 (SELECT a.district,a.state,a.growth growth,b.population FROM dataset1 a inner join dataset2population b on a.district=b.district) d) e
 GROUP BY e.state) m);

# FETCH TOP 3 DISTRICTS FROM EACH STATE WITH HIGHEST LITERACY RATE

SELECT a.* from
(SELECT District,State,Literacy,rank() over(partition by state order by literacy desc) ranking FROM dataset1)a
where a.ranking in (1,2,3) order by state;