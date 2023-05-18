SELECT * FROM portfolio_projects.athlete_events;

# 1 write an sql query to find in which sport or event India has won the highest medals ?

SELECT Year, Event , count(Medal)
FROM portfolio_projects.athlete_events
WHERE TEAM= 'India'
AND Medal <> 'NA'
GROUP BY Year,Event
ORDER BY Count(Medal) desc;

# 2 Identify the sports or events which was played most consecutively in the summer olympic games 

SELECT Event, count(Event)
FROM portfolio_projects.athlete_events
WHERE Season = 'Summer'
GROUP BY  Event 
ORDER BY Count(Event) desc;

# 3 write an sql query to fetch the details of all the countries which have most number of silver and bronze and at least one gold medal

SELECT Team, Sum(silver),
sum(Bronze),
Sum(Gold)
FROM (
SELECT * ,
Case Medal When 'Silver' then 1 else 0 end as Silver,
Case Medal When 'Bronze' then 1 else 0 end as Bronze,
Case Medal When 'Gold' then 1 else 0 end as Gold
FROM portfolio_projects.athlete_events
) innerT
GROUP BY Team
Having sum(Gold) >0 
ORDER BY sum(Silver) desc;

# 4 which player has the maximum  number of gold

SELECT Name,
SUM(Gold)
FROM(
SELECT * ,
Case Medal when'Gold' then 1 else 0 end as Gold
FROM Portfolio_projects.athlete_events) innerT
GROUP BY Name
ORDER BY sum(Gold)desc;

# 5 Which Sport has maximum events

SELECT Sport, count(*)
FROM athlete_events
GROUP BY Sport
ORDER BY Count(*)desc;

#6 Which Year has maximum events

SELECT Year, count(*)
FROM athlete_events
GROUP BY Year
ORDER BY Count(*) desc;