
/*What grades are stored in the database?*/
select * from Grade
/*
What emotions may be associated with a poem?
*/

select * from Emotion

/*
How many poems are in the database?
*/

select COUNT(*) 'Number of Poems from the database'from Poem

/*
Sort authors alphabetically by name. What are the names of the top 76 authors?
*/

Select Top 76 Name from Author
Order by Name

/*Starting with the above query, add the grade of each of the authors.*/
SELECT TOP 76 a.Name, g.Name
FROM Author a left join Grade g on a.GradeId=g.Id 

/*
Starting with the above query, add the recorded gender of each of the authors.
*/

SELECT TOP 76 a.Name, g.Name, ge.Name
FROM Author a left join Grade g on a.GradeId=g.Id Left join Gender ge on a.GenderId=ge.id

/*
What is the total number of words in all poems in the database?
*/
select Count(WordCount) 'Word Count in all the poems in the database'from Poem

/*
Which poem has the fewest characters?
*/
select Min(CharCount) ,Title from Poem Group by Title

/*
How many authors are in the third grade?
*/
select Count(Id) '3rd Grade' from Author 
Where GradeId=3


/*
How many total authors are in the first through third grades?
*/
select Count(Id) 'first through third grades' from Author 
Where GradeId=3 
OR GradeId=2 
OR GradeId=1

/*
What is the total number of poems written by fourth graders?
*/
select Count(p.id) '4th graders poems' 
from Author a join Poem p on a.Id=p.AuthorId
Where GradeId=4 
/*
How many poems are there per grade?
*/
SELECT Count(p.id),g.Name  FROM Poem p left join Author a on
p.AuthorId=a.id left join Grade g on g.id=a.GradeId
Group by g.Name

/*
How many authors are in each grade? (Order your results by grade starting with 1st Grade)
*/

SELECT Count(a.id) ,g.Name  FROM Author a left join 
Grade g on a.GradeId=g.id 
group by g.name


/*
What is the title of the poem that has the most words?
*/

SELECT Top 1(WordCount), Title 
FROM Poem  Order by Poem.WordCount Desc

/*Which author(s) have the most poems? (Remember authors can have the same name.)*/
	
select a.id,a.Name, Count(p.id) NumberOfPoems from Author a  join Poem p 
on p.AuthorId=a.id
Group by a. id,a.Name
Order by NumberOfPoems Desc

/*
How many poems have an emotion of sadness?
*/

Select Count(*) from Poem p left join PoemEmotion pe 
on p.Id=pe.PoemId 
left join Emotion Em on Em.Id=pe.EmotionId 
Where Em.Name= 'Sadness'

/*
How many poems are not associated with any emotion?
*/
Select Count(*) from Poem p left join PoemEmotion pe 
on p.Id=pe.PoemId 
left join Emotion Em on Em.Id=pe.EmotionId 
Where Em.Name is Null

/*
Which emotion is associated with the least number of poems?
*/

Select min(em.Name) from Poem p left join PoemEmotion pe 
on p.Id=pe.PoemId 
left join Emotion Em on Em.Id=pe.EmotionId 


/*
Which grade has the largest number of poems with an emotion of joy?
*/

SELECT Top 1 g.Name from Grade g left join Author a 
on g.id=a.GradeId left join Poem p on a.id =p.AuthorId
left join PoemEmotion pe on pe.PoemId=p.id
left join Emotion e on e.id=pe.EmotionId
Where e.Name='Joy'
Group by g.id,g.Name
Order by Count (p.id) Desc
/*
Which gender has the least number of poems with an emotion of fear?
*/
select top 1 g.name, COUNT(p.id) as NumPoems from Gender g
Join Author a  on g.Id=a.GenderId
join Poem p on p.AuthorId=a.Id
join PoemEmotion pe on pe.PoemId=p.id
join Emotion e on e.id =pe.EmotionId
Where e.Name='Fear'
Group by g.Id,g.Name
Order by NumPoems