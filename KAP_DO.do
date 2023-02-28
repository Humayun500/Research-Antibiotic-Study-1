gen knowledge_score = antibiotics_k1_a_Covid19+ antibiotics_k1_b_Pneumonia+ antibiotics_k1_c_Diabetics+ antibiotics_k1_d_Tuberculosis+ antibiotics_k1_e_Dengue+ antibiotics_k1_f_Urinarytract+ antibiotics_k2_a_Penicillin+ antibiotics_k2_b_Cefixime+ antibiotics_k2_c_Albendazole+ antibiotics_k2_d_Azithromycin+ antibiotics_k2_e_Remdisivir+ antibiotics_k2_f_Amoxicillin+ antibiotics_k3_bacterial+ antibiotics_k3_viral+ antibiotics_k3_paracitic+ antibiotics_k3_fungal+ antibiotics_k3_helminth+ antibiotic_k4_heard+ antibiotic_k5_a_Incomplete+ antibiotic_k5_b_Over+ antibiotic_k5_c_livestock+ antibiotic_k5_d_hygiene+ antibiotic_k6_affected

*************************
p5_antibiotics_proper_time (as a binary outcome) (1st study- do you use always?) + all will be predictors
 
Title: Prevalence and determinants of appropreate antibiotics use by registered doctor among Bangladeshi urban population: A cross sectionl study


******
Study-1: 
*outcome: appropreate antibiotics use by registered doctor (p3_antibiotics_by_doc)

*predictors: knowledge, background charecteristics

(skip attitude if possible in this study)

table-1: background charecteristics   

table-2: knowledge(95% CI) (good vs poor knowledge) (hide questions to do another study, the questions no need to given as supplementary file)

score 16 up good knowledge (75th percentile)


table-3: a chi by appropreate antibiotics use

table-4: logistic regression (crud & adjusted)


****
Study-2 on taken antibiotics (n= 304) by who_advised_antibiotic (find the self administered in last two month)

Prevalence and determinanets of self-administered antibiotics use among the antibiotics taken people in last two year (Yes/No) 

backgroup  t-1

t-2 knowledge + attitude t-2 (95% CI)

a chi by appropreate antibiotics use

Logistic regression


******************

who_advised_antibiotic Vs. who_advised_antibiotic Not

******************************************
*analysis of study-1

* Data management for study -1

gen Educational_status_new = 7 if Educational_status ==1
replace Educational_status_new = 7 if Educational_status ==2
replace Educational_status_new = 8 if Educational_status ==3
replace Educational_status_new = 9 if Educational_status ==4
replace Educational_status_new = 9 if Educational_status ==5
replace Educational_status_new = 9 if Educational_status ==6

recode Educational_status_new 7=1 8=2 9=3

label define Educational_status_new 1 "graduate" 2 "HSC" 3 "upto SSC"

*

gen age_cat =1 if age_cont <20
replace age_cat=2 if age_cont >=20 & age_cont <30
replace age_cat=3 if age_cont >=30 & age_cont <40
replace age_cat=4 if age_cont >=40 

label define age_cat 1 "<20" 2">=20 & <30" 3">=30 & <40" 4">=40"
label value age_cat age_cat

label define Marital_status_new 1"married" 2"unmarried"
label value Marital_status_new Marital_status_new

****

gen antibiotic_attitude_1 = 4 if antibiotic_a1==1
replace antibiotic_attitude_1 = 5 if antibiotic_a1 ==2
replace antibiotic_attitude_1 = 6 if antibiotic_a1 ==3

gen antibiotic_a_1=3 if antibiotic_attitude_1==4
replace antibiotic_a_1=2 if antibiotic_attitude_1==5
replace antibiotic_a_1=1 if antibiotic_attitude_1==6

*creat binary outcome variable 
#main variable: p3_antibiotics_by_doc

gen antibiotics_use_by_doctor= 1 if p3_antibiotics_by_doc == 1
replace antibiotics_use_by_doctor= 0 if p3_antibiotics_by_doc == 2
replace antibiotics_use_by_doctor= 0 if p3_antibiotics_by_doc == 3
replace antibiotics_use_by_doctor= 0 if p3_antibiotics_by_doc == 4

label define antibiotics_use_by_doctor 1 "yes" 0 "no"
label value antibiotics_use_by_doctor antibiotics_use_by_doctor
label var antibiotics_use_by_doctor "appropreate antibiotics use by registered doctor"

*management of attitude score
label define antibiotic_a_1 1"disagree" 2 "neutral" 3 "agree"
label value antibiotic_a_1  antibiotic_a_1 

*
gen antibiotic_attitude_2 = 4 if antibiotic_a2==1
replace antibiotic_attitude_2 = 5 if antibiotic_a2 ==2
replace antibiotic_attitude_2 = 6 if antibiotic_a2 ==3

gen antibiotic_a_2=3 if antibiotic_attitude_2==4
replace antibiotic_a_2=2 if antibiotic_attitude_2==5
replace antibiotic_a_2=1 if antibiotic_attitude_2==6

*
gen antibiotic_attitude_3 = 4 if antibiotic_a3==1
replace antibiotic_attitude_3 = 5 if antibiotic_a3 ==2
replace antibiotic_attitude_3 = 6 if antibiotic_a3 ==3

gen antibiotic_a_3=3 if antibiotic_attitude_3==4
replace antibiotic_a_3=2 if antibiotic_attitude_3==5
replace antibiotic_a_3=1 if antibiotic_attitude_3==6
*
gen antibiotic_attitude_4 = 4 if antibiotic_a4==1
replace antibiotic_attitude_4 = 5 if antibiotic_a4 ==2
replace antibiotic_attitude_4 = 6 if antibiotic_a4 ==3

gen antibiotic_a_4=3 if antibiotic_attitude_4==4
replace antibiotic_a_4=2 if antibiotic_attitude_4==5
replace antibiotic_a_4=1 if antibiotic_attitude_4==6

*
gen sum_antibiotic_attitude = antibiotic_a_4 + antibiotic_a_3+antibiotic_a_2+antibiotic_a_1

*gen knowledge_binary based on mean of 14
gen knowledge_binary = 0 if sum_knowledge_score < 15
replace knowledge_binary = 1 if sum_knowledge_score > 14
label define knowledge_binary 0"poor" 1 "good", replace
label value knowledge_binary knowledge_binary
 
* gen attitude_binary based on mean 11
gen attitude_binary = 0 if sum_antibiotic_attitude < 12
replace attitude_binary = 1 if sum_antibiotic_attitude > 11
label define attitude_binary 0"negative" 1 "positive", replace 
label value attitude_binary attitude_binary

*final analysis 
logistic antibiotics_use_by_doctor i.knowledge_binary

logistic antibiotics_use_by_doctor i.attitude_binary

#demoghraphic information 
logistic antibiotics_use_by_doctor i.age_cat
logistic antibiotics_use_by_doctor ib2.Gender
logistic antibiotics_use_by_doctor i.Marital_status_new
logistic antibiotics_use_by_doctor ib2. Educational_status


#antibiotic use related information
logistic antibiotics_use_by_doctor ib2.take_antibiotics

logistic antibiotics_use_by_doctor i.antibiotic_a_1
logistic antibiotics_use_by_doctor i.antibiotic_a_2
logistic antibiotics_use_by_doctor i.antibiotic_a_3
logistic antibiotics_use_by_doctor i.antibiotic_a_4
*

*logistic model (does not fit well)

logistic antibiotics_use_by_doctor i.knowledge_binary i.attitude_binary i.age_cat ib2.Gender i.Marital_status_new ib2.Educational_status i.antibiotic_a_1 i.antibiotic_a_2 i.antibiotic_a_3 i.antibiotic_a_4 

**

*chi squire test (best model) for study-1 of antibiotic


*title: Prevalence and determinants of appropriate antibiotics use by registered doctor among Bangladeshi urban population: A post-pandemic study

antibiotic_use_without_pres age_cat Gender Marital_status_new Educational_status_new Devision take_antibiotics antibiotic_a_1 antibiotic_a_2 antibiotic_a_3 antibiotic_a_4 antibiotics_k1_a_Covid19 antibiotics_k1_e_Dengue antibiotics_k1_c_Diabetics antibiotics_k1_b_Pneumonia antibiotics_k1_d_Tuberculosis antibiotics_k3_bacterial antibiotics_k3_viral antibiotics_k3_paracitic antibiotics_k3_fungal antibiotics_k3_helminth antibiotics_k2_a_Penicillin antibiotics_k2_f_Amoxicillin antibiotics_k2_b_Cefixime antibiotics_k2_d_Azithromycin antibiotics_k2_e_Remdisivir antibiotics_k2_c_Albendazole
*data set: antibiotic_use_without_pres
gen antibiotics_use_by_doctor_re= 2 if antibiotics_use_by_doctor==0
replace antibiotics_use_by_doctor_re= 3 if antibiotics_use_by_doctor==1

gen antibiotic_use_without_pres= 0 if antibiotics_use_by_doctor_re==2
replace antibiotic_use_without_pres= 1 if antibiotics_use_by_doctor_re==3
label define antibiotic_use_without_pres 0 "No" 1"Yes"
label value antibiotic_use_without_pres antibiotic_use_without_pres


*Background charecteristics (table-1)
tab age_cat
tab Gender 
tab Marital_status_new
tab Educational_status_new 
tab antibiotics_use_by_doctor

*Table 2: Background characteristics and the appropriate use of antibiotics by registered doctor

tab  age_cat antibiotics_use_by_doctor, chi row
tab Gender antibiotics_use_by_doctor, chi row
tab Marital_status_new antibiotics_use_by_doctor, chi row
tab Educational_status_new antibiotics_use_by_doctor, chi row

tab Devision antibiotics_use_by_doctor, exact row

*Table 3: Attitudes towards use of antibiotics and the appropriate use of antibiotics by registered doctor

tab take_antibiotics antibiotics_use_by_doctor, chi row
tab antibiotic_a_1 antibiotics_use_by_doctor, chi row
tab antibiotic_a_2 antibiotics_use_by_doctor, chi row
tab antibiotic_a_3 antibiotics_use_by_doctor, chi row
tab antibiotic_a_4 antibiotics_use_by_doctor, chi row

*Table 4: Knowledge on antibiotics treatable diseases specification and the appropriate use of antibiotics by registered doctor

tab antibiotics_k1_a_Covid19 antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k1_e_Dengue antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k1_c_Diabetics antibiotics_use_by_doctor, chi row
*
tab antibiotics_k1_b_Pneumonia antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k1_d_Tuberculosis antibiotics_use_by_doctor, chi row



* Table 5: Knowledge on types of diseases specification that can be treated by antibiotics and the appropriate use of antibiotics by registered doctor
*
tab antibiotics_k3_bacterial antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k3_viral antibiotics_use_by_doctor, chi row

*
tab antibiotics_k3_paracitic antibiotics_use_by_doctor, chi row
*
tab antibiotics_k3_fungal antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k3_helminth antibiotics_use_by_doctor, chi row

*Table 6: Knowledge on antimicrobials drugs specification and the appropriate use of antibiotics by registered doctor
*
tab antibiotics_k2_a_Penicillin antibiotics_use_by_doctor, chi row

*
tab antibiotics_k2_f_Amoxicillin antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k2_b_Cefixime antibiotics_use_by_doctor, chi row

*sig
tab antibiotics_k2_d_Azithromycin antibiotics_use_by_doctor, chi row

*
tab antibiotics_k2_e_Remdisivir antibiotics_use_by_doctor, chi row

tab antibiotics_k2_c_Albendazole antibiotics_use_by_doctor, chi row


***************
*analysis for figure
* Figure 1: Prevalence of antibiotics use in last two months
tab take_antibiotics 

*Figure 2: Distribution of items of attitudes towards use of antibiotics 
tab1 antibiotic_a_1 antibiotic_a_2 antibiotic_a_3 antibiotic_a_4

*Short form/key words of items of attitudes towards use of antibiotics 
# antibiotic_a_1 = aware of use
# antibiotic_a_2 = adverse health outcome
# antibiotic_a_3 = major health concern
# antibiotic_a_4 = affect global health

*Figure 3: Distribution of items of knowledge on antibiotics treatable diseases specification 
tab1 antibiotics_k1_a_Covid19 antibiotics_k1_e_Dengue antibiotics_k1_c_Diabetics antibiotics_k1_b_Pneumonia antibiotics_k1_d_Tuberculosis antibiotics_k1_f_Urinarytract


*Figure 4: Distribution of items of knowledge on types of diseases specification that can be treated by antibiotics
tab1 antibiotics_k3_bacterial antibiotics_k3_viral antibiotics_k3_paracitic antibiotics_k3_fungal antibiotics_k3_helminth


*Figure 5: Distribution of items of knowledge on antimicrobials drugs specification
tab1 antibiotics_k2_a_Penicillin antibiotics_k2_f_Amoxicillin antibiotics_k2_b_Cefixime antibiotics_k2_d_Azithromycin antibiotics_k2_e_Remdisivir





















 
 
 
 
 