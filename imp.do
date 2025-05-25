*importing all the data from csv file to stata file
*hhrv1
import excel "C:\Users\Shruti Singh\Desktop\shrusti\nsso data raw form\hhrv.xlsx", sheet("hhrv") firstrow clear
br 

*import hhrv
import delimited "C:\Users\Shruti Singh\Desktop\shrusti\nsso data raw form\hhrv\hhrv csv.csv"
br 
save "C:\Users\Shruti Singh\Desktop\shrusti\stata file\hhrv stata.dta" *saving the data
* import prv1
import delimited "C:\Users\Shruti Singh\Desktop\shrusti\nsso data raw form\perv1 workbook.csv"
br
save "C:\Users\Shruti Singh\Desktop\shrusti\stata file\prv1 stata.dta"
*import prv 
clear


*  weights for hhrv1
use "C:\Users\Shruti Singh\Desktop\shrusti\stata file\hhrv1 stata.dta"
destring nscountforsectorxstratumxsubstra v35 subsamplewisemultiplier , replace
gen weight = subsamplewisemultiplier /100 if nscountforsectorxstratumxsubstra == v35
replace weight = subsamplewisemultiplier /200 if nscountforsectorxstratumxsubstra!= v35
gen hhid =fsu+ samplesgsbno+ secondstagestratumno+ samplehouseholdnumber
br hhid
save, replace
*weights for hhrv
use "C:\Users\Shruti Singh\Desktop\shrusti\stata file\hhrv stata.dta"
import delimited "C:\Users\Shruti Singh\Desktop\shrusti\nsso data raw form\hhrv\hhrv csv.csv"
br 
save "C:\Users\Shruti Singh\Desktop\shrusti\stata file\hhrv stata.dta" *saving the data
destring nscountforsectorxstratumxsubstra v30 subsamplewisemultiplier , replace
gen weight = subsamplewisemultiplier /100 if nscountforsectorxstratumxsubstra == v30
replace weight = subsamplewisemultiplier/200 if nscountforsectorxstratumxsubstra!= v30
gen hhid =fsu+ samplesgsbno+ secondstagestratumno+ samplehouseholdnumber
save, replace
clear

 *weights for prv1 
  use "C:\Users\Shruti Singh\Desktop\shrusti\stata file\prv1 stata.dta"
 br
 destring nscountforsectorxstratumxsubstra v141 subsamplewisemultiplier , replace
 gen weight = subsamplewisemultiplier /100 if nscountforsectorxstratumxsubstra == v141
 
 egen hhid1 = concat(quarter visit fsu samplesgsbno secondstagestratumno samplehouseholdnumber )
 label var hhid "Unique household ID - Generated"
  br hhid1
egen pid1 = concat( hhid1 personserialno )
save, replace

* weiights for prv
 use "C:\Users\Shruti Singh\Desktop\shrusti\stata file\prv stata.dta"
  destring nscountforsectorxstratumxsubstra v102 subsamplewisemultiplier , replace
 gen weight = subsamplewisemultiplier /100 if nscountforsectorxstratumxsubstra == v102
 replace weight = subsamplewisemultiplier /200 if nscountforsectorxstratumxsubstra != v102
 egen hhid1 = concat( quarter visit fsu samplesgsbno secondstagestratumno samplehouseholdnumber )
label var hhid "Unique household ID - Generated"
br hhid1
egen pid1 = concat( hhid1 personserialno)
save, replace
clear

* merge prv1 and prv
 use "C:\Users\Shruti Singh\Desktop\shrusti\stata file\prv1 stata.dta"
. merge 1:1 pid1 using "C:\Users\Shruti Singh\Desktop\shrusti\stata file\prv stata
drop _merge
save, replace

 
* merging the data hhrv 1 and hhrv
 use "C:\Users\Shruti Singh\Desktop\shrusti\stata file\hhrv1 stata.dta"
 merge 1:1 hhid1 using "C:\Users\Shruti Singh\Desktop\shrusti\stata file\hhrv 
 drop _merge
 *merge both
 merge 1:m hhid1 using "C:\Users\Shruti Singh\Desktop\shrusti\stata file\prv1 s
br

statistic
describe v45 whetherreceivedanyvocationaltech  sex age generaleducaionlevel sector earningsforregularsalaridwageact nssregion




// Gender
label define sex_lbl 1 "Male" 2 "Female" 3 "Other"
label values sex sex_lbl

// Age group (you may have to create this)
gen age_group = .
replace age_group = 1 if age >=15 & age <=18
replace age_group = 2 if age >=19 & age <=24
replace age_group = 3 if age >=25 & age <=29
label define age_lbl 1 "15-18" 2 "19-24" 3 "25-29"
label values age_group age_lbl

// Caste
//label define caste_lbl 1 "SC" 2 "ST" 3 "OBC" 4 "General"
//label values caste caste_lbl

// Religion
label define religion_lbl 1 "Hinduism" 2 "Islam" 3 "Christianity" 4 "Other"
label values religion religion_lbl

// Urban/Rural (assuming 'sector' = 1 rural, 2 urban)
label define sector_lbl 1 "Rural" 2 "Urban"
label values sector sector_lbl


gen employed = .
replace employed = 1 if inlist(statuscode, 11, 12, 21, 31, 41, 51)
replace employed = 0 if inlist(statuscode, 81, 91, 92, 93,94, 95, 97, 98, 99)
label define emp_lbl 0 "Not Employed" 1 "Employed"
label values employed emp_lb1

gen gender = .
replace gender = 1 if inlist(sex, "Male")
relace gender = 0 if inlist(sex, "Female")
lable define gender_lb1 0 "Female" 1 Male"
lavle values gender gender_lb1

