## OPEN BOTH CSV FILES IN NOTEPAD AND DELETE SPECIAL CHARACTER IN COLUMN TITLE, ENCODE IN UTF-8
## CREATE TABLE WITH CORRESPONDING COLUMNS WHILE STANDARDIZING NAMES AND INSERT JOIN RESULT
drop table ftest;

create table ftest( 
Long_Name text,
Nationality text, 
Positions text, 
Name1 text,
Age int, 
OVA int, 
POT int, 
Team_Contract text,
ID int,
Height text, 
Weight text, 
Foot text, 
BOV int, 
BP text, 
Growth int, 
Joined text, 
Loan_Date_End text,
Net_Value text,
Wage1 text,
Release_Clause text,
Attacking int, 
Crossing int, 
Finishing int, 
Heading_Accuracy int, 
Short_Passing int, 
Volleys int, 
Skill int, 
Dribbling int, 
Curve int, 
FK_Accuracy int, 
Long_Passing int, 
Ball_Control int, 
Movement int, 
Acceleration int, 
Sprint_Speed int, 
Agility int, 
Reactions int, 
Balance int, 
Power int, 
Shot_Power int, 
Jumping int,
Stamina int, 
Strength int, 
Long_Shots int, 
Mentality int, 
Aggression int, 
Interceptions int, 
Positioning int, 
Vision int, 
Penalties int, 
Composure int, 
Defending int, 
Marking int, 
Standing_Tackle int, 
Sliding_Tackle int, 
Goalkeeping int, 
GK_Diving int, 
GK_Handling int, 
GK_Kicking int, 
GK_Positioning int, 
GK_Reflexes int, 
Total_Stats int, 
Base_Stats int, 
Weak_Foot text,
Skill_Moves text,
PAC int, 
SHO int, 
PAS int, 
DRI int, 
DEF int, 
PHY int,
Hits text, 
ID2 int, 
Name2 text,
Long_Name2 text,
Nationality2 text,
Age2 int,
OVA2 int,
POT2 int,
Club text,
Contract2 text,
Positions2 text,
Height2 text,
Weight2 text,
Preferred_Foot text,
BOV2 int,
Best_Position2 text,
Joined2 text,
Loan_Date_End2 text,
Value2 text,
Wage text, 
Release_Clause2 text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into ftest
select*from fifa1_raw f1
join fifa2_raw f2
	on f1.ID=f2.ID;
    
alter table ftest
drop column ID2;
## COMPARING AND DROPPING DUPLICATE COLUMNS
select*from ftest
where Long_Name != Long_Name2;
alter table ftest 
drop column Long_Name2;

select*from ftest
where Name1 != Name2;
alter table ftest 
drop column Name2;

## A LOT OF DISCREPANCIES BETWEEN VALUE & WAGE BETWEEN FILES, MAKES SENSE AS PERSONAL FINANCIALS ARE OBSCURE, ASSUMING SECOND FILE HAS CORRECT NUMBERS 
select Name1,Net_Value, Value2 
from ftest
where Net_Value != Value2;
alter table ftest 
drop column Net_Value;
## WAGES ARE A LOT CLOSER, NEGLIGIBLE DIFFERENCES BETWEEN THE TWO, USING SECOND FILE TO STAY CONSISTENT.
select Name1,Wage,Wage1
from ftest
where Wage != Wage1;
alter table ftest 
drop column Wage1;

## LOAN DATE ENDS ARE IN DIFFERENT FORMATS,USING mm/dd/yyyy,NOT MANY PLAYERS ON LOAN ALL DATES LOOK CORRECT.
select distinct Loan_Date_End,Loan_Date_End2
from ftest;
select Loan_Date_End,Loan_Date_End2
from ftest
where Loan_Date_End=Loan_Date_End2;
alter table ftest
drop column Loan_Date_End;

## JOINED DATE ARE IN DIFFERENT FORMATS,USING mm/dd/yyyy.
select distinct Joined,Joined2
from ftest;
alter table ftest
drop column Joined;

select BP,Best_Position2
from ftest
where BP != Best_Position2;
alter table ftest
drop column BP;

select Age,Age2
from ftest
where Age != Age2;
alter table ftest
drop column Age2;

select BOV,BOV2
from ftest
where BOV != BOV2;
alter table ftest
drop column BOV2;

select Nationality,Nationality2
from ftest
where Nationality != Nationality2;
alter table ftest
drop column Nationality2;

select OVA,OVA2
from ftest
where OVA != OVA2;
alter table ftest
drop column OVA2;

select POT,POT2
from ftest
where POT != POT2;
alter table ftest
drop column POT2;

##POSITIONS COLUMN DIFFERS BY COMMAS BETWEEN POSITIONS
select Positions,Positions2
from ftest
where Positions!=Positions2;
alter table ftest
drop column Positions2;

select Foot,Preferred_Foot
from ftest
where Foot!=Preferred_Foot;
alter table ftest
drop column Foot;

select*from ftest
where Release_Clause != Release_Clause2;
alter table ftest 
drop column Release_Clause2;

drop table ftest2;
create table ftest2
like ftest;
insert into ftest2
select*from ftest;
###############################
##DELETE ONE DUPLICATE
select count(*) as count,Long_Name
from ftest
group by Long_Name, Nationality, Positions, Name1, Age, OVA, POT, Team_Contract, ID, Height, Weight, BOV, Growth, Release_Clause, Attacking, Crossing, Finishing, Heading_Accuracy, Short_Passing, Volleys, Skill, Dribbling, Curve, FK_Accuracy, Long_Passing, Ball_Control, Movement, Acceleration, Sprint_Speed, Agility, Reactions, Balance, Power, Shot_Power, Jumping, Stamina, Strength, Long_Shots, Mentality, Aggression, Interceptions, Positioning, Vision, Penalties, Composure, Defending, Marking, Standing_Tackle, Sliding_Tackle, Goalkeeping, GK_Diving, GK_Handling, GK_Kicking, GK_Positioning, GK_Reflexes, Total_Stats, Base_Stats, Weak_Foot, Skill_Moves, PAC, SHO, PAS, DRI, DEF, PHY, Hits, Club, Contract2, Height2, Weight2, Preferred_Foot, Best_Position2, Joined2, Loan_Date_End2, Value2, Wage
having count(*) > 1;

select*from ftest
where Long_Name='Kevin Berlaso';

drop table ftest3;
create table ftest3
like ftest2;

alter table ftest3
add count int;

insert into ftest3
	select*,row_number() over(partition by Long_Name, Nationality, Positions, Name1, Age, OVA, POT, Team_Contract, ID, Height, Weight, BOV, Growth, Release_Clause, Attacking, Crossing, Finishing, Heading_Accuracy, Short_Passing, Volleys, Skill, Dribbling, Curve, FK_Accuracy, Long_Passing, Ball_Control, Movement, Acceleration, Sprint_Speed, Agility, Reactions, Balance, Power, Shot_Power, Jumping, Stamina, Strength, Long_Shots, Mentality, Aggression, Interceptions, Positioning, Vision, Penalties, Composure, Defending, Marking, Standing_Tackle, Sliding_Tackle, Goalkeeping, GK_Diving, GK_Handling, GK_Kicking, GK_Positioning, GK_Reflexes, Total_Stats, Base_Stats, Weak_Foot, Skill_Moves, PAC, SHO, PAS, DRI, DEF, PHY, Hits, Club, Contract2, Height2, Weight2, Preferred_Foot, Best_Position2, Joined2, Loan_Date_End2, Value2, Wage) as count
	from ftest2;
    
select*from ftest3
where count>1;    

delete from ftest3
where count>1;

alter table ftest3
drop column count;

drop table ftest4;
create table ftest4
like ftest3;
insert into ftest4
select*from ftest3;
#################################
##DERIVING TEAM, ON_LOAN, CONTRACT_START, CONTRACT_END
##CLEARING WHITESPACE FROM TEAM & CONTRACT

alter table ftest4
add column Contract_End text after Team_Contract;

alter table ftest4
add column Contract_Start text after Team_Contract;

alter table ftest4
add column On_Loan text after Team_Contract;

alter table ftest4
add column Team text after Team_Contract;

update ftest4
set Team=replace(Club,'\n','');

update ftest4
set On_Loan = 'Y'
where Team_Contract like '%Loan%';

update ftest4
set On_Loan = 'N'
where Team_Contract not like '%Loan%';

update ftest4
set Contract_Start=substring_index(Contract2,'~',1)
where On_Loan='N';

update ftest4
set Contract_Start='N/A'
where Team='No Club';

update ftest4
set Contract_Start='N/A'
where On_Loan='Y';

update ftest4
set Contract_End=substring_index(Team_Contract,'~',-1)
where On_Loan='N';

update ftest4
set Contract_End='N/A'
where Team='No Club';

update ftest4
set Contract_End='N/A'
where On_Loan='Y';

select distinct Contract_Start
from ftest4;
select distinct Contract_End
from ftest4;

drop table ftest5;
create table ftest5
like ftest4;
insert into ftest5
select*from ftest4;
##########################################

alter table ftest5
drop column Team_Contract;

alter table ftest5
drop column Club;

alter table ftest5
drop column Contract2;

## CHECKING LOAN DATE END VALIDITY
select distinct(Loan_Date_End2)
from ftest5
where On_Loan='N';

##########################################
##Derive Height_inch int,Height_cm int,Weight_lbs int,Weight_kg int
alter table ftest5
add column Height_inch double after Height;
alter table ftest5
add column Height_cm double after Height_inch;
alter table ftest5
add column Weight_lbs double after Weight;
alter table ftest5
add column Weight_kg double after Weight_lbs;

update ftest5
set Height_cm = round(((substring_index(Height,"'",1))*12+(replace(substring_index(Height,"'",-1),'""',"")))*2.54);

update ftest5
set Height_inch = (substring_index(Height,"'",1))*12+(replace(substring_index(Height,"'",-1),'""',""));

update ftest5
set Weight_lbs = CAST(TRIM('lbs' from Weight) as double);

update ftest5
set Weight_kg = CAST(TRIM('kg' from Weight2) as double);
################################################
## REMOVING POUND SIGNS, STANDARDIZING, ADDING US DOLLAR EQUIVALENTS
##'€'
alter table ftest5
add column Wage_dollar double after Release_Clause;
alter table ftest5
add column Wage_pound double after Release_Clause;
update ftest5
set Wage=replace(Wage,'€','');
update ftest5
set Wage=replace(Wage,'K','000');

update ftest5
set Wage_pound=cast(Wage as double);
update ftest5
set Wage_dollar=cast((Wage*1.27) as double);

alter table ftest5
add column Net_Value_dollar double after Release_Clause;
alter table ftest5
add column Net_Value_pound double after Release_Clause;

update ftest5
set Value2=replace(Value2,'€','');
update ftest5
set Value2=replace(Value2,'K','000');
update ftest5
set Value2=(replace(Value2,'M',''))*1000000
where Value2 like '%M%';

update ftest5
set Net_Value_pound=cast(Value2 as double);
update ftest5
set Net_Value_dollar=cast((Value2*1.27) as double);

alter table ftest5
drop column Value2;
alter table ftest5
drop column Wage;
alter table ftest5
drop column Height2;
alter table ftest5
drop column Weight;
alter table ftest5
drop column Weight2;

update ftest5
set Release_Clause=replace(Release_Clause,'€','');
update ftest5
set Release_Clause=replace(Release_Clause,'K','000');
update ftest5
set Release_Clause=(replace(Release_Clause,'M',''))*1000000
where Release_Clause like '%M%';

alter table ftest5
add column Release_Clause_dollar double after Release_Clause;
alter table ftest5
add column Release_Clause_pound double after Release_Clause;

update ftest5
set Release_Clause_pound=cast(Release_Clause as double);
update ftest5
set Release_Clause_dollar=cast((Release_Clause_pound*1.27) as double);

alter table ftest5
drop column Release_Clause;

##################################################
## REMOVING STARS
##'✰'
update ftest5
set Weak_Foot=replace(Weak_Foot,'★','');
update ftest5
set Skill_Moves=replace(Skill_Moves,'★','');
##################################################
## ADDING CONTRACT LENGTH
alter table ftest5
add column Contract_Length int after Contract_End;
update ftest5
set Contract_Length=Contract_End-Contract_Start;
###################################################
## ADDING LOAN LENGTH
alter table ftest5
add column Joined_Club date after Contract_Length;

update ftest5
set Joined_Club=str_to_date(Joined2,'%m/%d/%Y');

alter table ftest5
add column Loan_End date after Joined_Club;

update ftest5
set Loan_End=str_to_date(Loan_Date_End2,'%m/%d/%Y')
where On_Loan='Y';

##ALL NON LOAN PLAYERS DON'T HAVE A LOAN END DATE
select distinct(Loan_End)
from ftest5
where On_Loan='N';

alter table ftest5
add column Loan_Length_yrs double after Loan_End;

update ftest5
set Loan_Length_yrs=round(datediff(Loan_End,Joined_Club)/31/12,2);

alter table ftest5
add column Loan_Length_mths double after Loan_End;

update ftest5
set Loan_Length_mths=round(datediff(Loan_End,Joined_Club)/31);


alter table ftest5
drop column Joined2;

alter table ftest5
drop column Loan_Date_End2;

##FIXING HITS COLUMN
update ftest5
set Hits=replace(Hits,'\n','');

update ftest5
set Hits=replace(Hits,'K','')*1000
where Hits like '%K%';

####################################################
##CREATING FINAL CLEANED TABLE
drop table fifa_cleaned;
create table fifa_cleaned
like ftest5;
insert into fifa_cleaned
select*from ftest5;
drop table ftest;
drop table ftest2;
drop table ftest3;
drop table ftest4;
drop table ftest5;
##################################################