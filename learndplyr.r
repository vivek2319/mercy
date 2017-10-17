install.packages("tidyverse")
library(tidyverse)
data(mtcars)
head(mtcars)

#Output
#mpg cyl disp  hp drat    wt  qsec vs am gear carb
#Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

str(mtcars)
#'data.frame':	32 obs. of  11 variables:
#  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#$ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
#$ disp: num  160 160 108 258 360 ...
#$ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
#$ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#$ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
#$ qsec: num  16.5 17 18.6 19.4 17 ...
#$ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
#$ am  : num  1 1 1 0 0 0 0 0 0 0 ...
#$ gear: num  4 4 4 3 3 3 3 4 4 4 ...
#$ carb: num  4 4 1 1 2 1 4 2 2 4 ...

summary(mtcars)

#mpg             cyl             disp             hp             drat      
#Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0   Min.   :2.760  
#1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080  
#Median :19.20   Median :6.000   Median :196.3   Median :123.0   Median :3.695  
#Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7   Mean   :3.597  
#3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920  
#Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0   Max.   :4.930  
#wt             qsec             vs               am              gear      
#Min.   :1.513   Min.   :14.50   Min.   :0.0000   Min.   :0.0000   Min.   :3.000  
#1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:3.000  
#Median :3.325   Median :17.71   Median :0.0000   Median :0.0000   Median :4.000  
#Mean   :3.217   Mean   :17.85   Mean   :0.4375   Mean   :0.4062   Mean   :3.688  
#3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:4.000  
#Max.   :5.424   Max.   :22.90   Max.   :1.0000   Max.   :1.0000   Max.   :5.000  
#carb      
#Min.   :1.000  
#1st Qu.:2.000  
#Median :2.000  
#Mean   :2.812  
#3rd Qu.:4.000  
#Max.   :8.000  


myselect <- mtcars%>%
  select(mpg, cyl, disp, hp, drat)

head(myselect)

#mpg cyl disp  hp drat
#Mazda RX4         21.0   6  160 110 3.90
#Mazda RX4 Wag     21.0   6  160 110 3.90
#Datsun 710        22.8   4  108  93 3.85
#Hornet 4 Drive    21.4   6  258 110 3.08
#Hornet Sportabout 18.7   8  360 175 3.15
#Valiant           18.1   6  225 105 2.76

mywhere <- mtcars%>%
  select(mpg, cyl)%>%
  filter(mpg >=15.0 | cyl <=10)

head(mywhere)  
#mpg cyl
#1 21.0   6
#2 21.0   6
#3 22.8   4
#4 21.4   6
#5 18.7   8
#6 18.1   6

myarrange <- mtcars%>%
  arrange(mpg)

head(myarrange)
#mpg cyl disp  hp drat    wt  qsec vs am gear carb
#1 10.4   8  472 205 2.93 5.250 17.98  0  0    3    4
#2 10.4   8  460 215 3.00 5.424 17.82  0  0    3    4
#3 13.3   8  350 245 3.73 3.840 15.41  0  0    3    4
#4 14.3   8  360 245 3.21 3.570 15.84  0  0    3    4
#5 14.7   8  440 230 3.23 5.345 17.42  0  0    3    4
#6 15.0   8  301 335 3.54 3.570 14.60  0  1    5    8


#But we just want mpg column, so let's select it first
myselarra <- mtcars%>%
  select(mpg)%>%
  arrange(mpg)

head(myselarra)
#mpg
#1 10.4
#2 10.4
#3 13.3
#4 14.3
#5 14.7
#6 15.0
