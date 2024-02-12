/* Group 10 - Homework1 */

/*Importing the Dataset*/

proc import 
datafile='E:\Users\sxg220142\Desktop\car_insurance_19.csv'
out=car_insurance
dbms=csv
replace;
getnames=yes;
run;

/* Question 1 */

proc freq;
tables Gender Vehicle_Size Vehicle_Class;
title '1. What is the distribution of gender, vehicle size, and vehicle class?';
footnote 'For Predictive Analytics Course';
run;

/* Question 2 */

proc means; var Customer_Lifetime_Value; class Gender;
proc means; var Customer_Lifetime_Value; class Vehicle_Size;
proc means; var Customer_Lifetime_Value; class Vehicle_Class;
title ' 2.What is the average customer lifetime value of each level of gender, vehicle size, and vehicle class?';
footnote 'For Predictive Analytics Course';
run;

/* Question 3 */

data a1;
	set car_insurance;
run;
proc ttest;
	class Vehicle_Size;
	var Customer_Lifetime_Value;
	where Vehicle_Size in ('Large','Medsize');
	title '3.Do large cars have a higher lifetime value than medsize cars. Do a t-test and report on your findings.';
	footnote 'For Predictive Analytics Course';
run;

/* Question 4 */

data a2; set car_insurance;
proc ttest; class Gender;
var Customer_Lifetime_Value;
title '4.Is there a significant difference between men and women in customer lifetime value?';
footnote 'For Predictive Analytics Course';
run;

/* Question 5 */

proc anova;
class Sales_Channel;
model Customer_Lifetime_Value = Sales_Channel;
means Sales_Channel;
title '5.Use ANOVA to test whether there is difference in customer lifetime value across different sales channels. Which sales channel generates the highest lifetime value?';
footnote 'For Predictive Analytics Course';
run;

/* Question 6 */

proc reg data=car_insurance;
model Customer_Lifetime_Value = Income;
title 'Impact of Income on Customer Lifetime Value';
footnote 'Regression Analysis for numerical independent variable';
run;

proc anova data=car_insurance;
class Education;
model Customer_Lifetime_Value = Education;
title 'Impact of Education on Customer Lifetime Value';
footnote 'Analysis of Variance(ANOVA) for categorical independent variable';
run;

proc anova data=car_insurance;
class Marital_Status;
model Customer_Lifetime_Value = Marital_Status;
title 'Impact of Marital Status on Customer Lifetime Value';
footnote 'Analysis of Variance(ANOVA) for categorical independent variable';
run;

/* Question 7 */

proc freq data=car_insurance;
tables Renew_Offer_Type*Response/chisq;
title '7.Is there a relationship between renew_offer_type and response (use Chi-sq test)? Which offer type generates the highest response rate?';
footnote 'For Predictive Analytics Course';
run;

/* Question 8 */

proc anova data=car_insurance;
class Renew_Offer_Type;
model Customer_Lifetime_Value = Renew_Offer_Type;
means Renew_Offer_Type;
title '8.Do different renew_offer_types have different lifetime values? Which offer type is the best?';
footnote 'For Predictive Analytics Course';
run;

/* Question 9 */

proc glm data=car_insurance;
class Renew_Offer_Type State;
model Customer_Lifetime_Value = Renew_Offer_Type|State;
title ' 9.Is the effectiveness of renew_offer_type different across different states with respect to lifetime value?';
footnote 'For Predictive Analytics Course';
run;

/* Question 10 */

title '10.What other interesting insights that are useful to the company in terms of action can be obtained from the data?';

/*Customers with higher income levels are more likely to purchase higher coverage insurance plans.*/

proc logistic data=car_insurance;
class Coverage;
model Coverage = Income / link=glogit;
title '10.Customers with higher income levels are more likely to purchase higher coverage insurance plans.';
footnote 'For Predictive Analytics Course';
run;

/*The sales channel used by customers is independent of their location code.*/

proc freq data=car_insurance;
tables Sales_Channel*Location_Code / chisq;
title '10.The sales channel used by customers is independent of their location code.';
footnote 'For Predictive Analytics Course';
run;

/*There is a significant difference in auto premiums across different location codes (Rural, Suburban, Urban).*/

proc anova;
class Location_Code;
model Monthly_Premium_Auto = Location_Code;
means Location_Code;
title '10.There is a significant difference in auto premiums across different location codes (Rural, Suburban, Urban).';
footnote 'For Predictive Analytics Course';
run;
