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

*Merge complete
