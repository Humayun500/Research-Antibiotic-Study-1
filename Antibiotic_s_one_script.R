save.image ("C:/Users/humay/Dropbox/Forward Research Team/KAP Study/Antibiotic/Study-1 (NA)/Data/Antibiotic_s_one.RData")


#Making map
Antibiotic_s_one$Devision
levels (Antibiotic_s_one$Devision)

library (tidyverse)
options (scipen=999)

library(cartography)
library(sf)
library(tidyverse)

library(maps)
library(ggplot2)

adm1<- read_sf("C:/Users/humay/Dropbox/Personal Drive/Own project/Nursing students/Main data/Map/Practice/BD/BGD_ADM1.shp")

adm1$NAME
class (adm1$NAME)
levels (Antibiotic_s_one$Devision)

Antibiotic_s_one$Devision.map= recode (Antibiotic_s_one$Devision,
                             "Dhaka"="Dhaka Division",
                             "Chattogram"= "Chittagong Division",
                             "Khulna"= "Khulna Division",
                             "Rajshahi" = "Rajshahi Division",
                             "Rangpur" = "Rangpur Division",
                             "Sylhet" = "Sylhet Division",
                             "Barishal" = "Barisal Division",
                             "Mymensingh" = "Mymensingh Division")
Antibiotic_s_one$Devision.map
class (Antibiotic_s_one$Devision.map)

levels (Antibiotic_s_one$Devision.map)

Antibiotic_s_one$Devision.map= as.character(Antibiotic_s_one$Devision.map)
Antibiotic_s_one$Devision.map

Antibiotic_s_one$NAME=Antibiotic_s_one$Devision.map

Antibiotic_s_one$NAME

class (Antibiotic_s_one$NAME)

levels (Antibiotic_s_one$NAME)

#merging two data
Antibiotic_s_one_map.data<-merge(adm1, Antibiotic_s_one, by="NAME")
Antibiotic_s_one_map.data$NAME

Antibiotic_s_one_map.data$NAME_new= recode (Antibiotic_s_one_map.data$NAME,
                          "Dhaka Division"="Dhaka",
                          "Chittagong Division"="Chattogram",
                          "Khulna Division"="Khulna",
                          "Rajshahi Division"="Rajshahi",
                          "Rangpur Division"="Rangpur",
                          "Sylhet Division"="Sylhet",
                          "Barisal Division"= "Barishal",
                          "Mymensingh Division"="Mymensingh")

head (Antibiotic_s_one_map.data$NAME_new)
Antibiotic_s_one_map.data$NAME_new
Antibiotic_s_one_map.data$Division.Antibiotic.pv= Antibiotic_s_one_map.data$NAME_new

Antibiotic_s_one_map.data$Division.Antibiotic.pv

Antibiotic_s_one_map.data$Division.Antibiotic.pv= recode (Antibiotic_s_one_map.data$Division.Antibiotic.pv,
                                   "Dhaka"="35.34",
                                   "Chattogram"= "38.46",
                                   "Khulna"= "30.00",
                                   "Rajshahi" = "47.83",
                                   "Rangpur" = "39.39",
                                   "Sylhet" = "48.15",
                                   "Barishal" = "86.67",
                                   "Mymensingh" = "60.00")
Antibiotic_s_one_map.data$Division.Antibiotic.pv
Antibiotic_s_one_map.data$Division.Antibiotic.pv= as.integer(Antibiotic_s_one_map.data$Division.Antibiotic.pv)

#Map
map_Antibiotic_s_one=ggplot(data=Antibiotic_s_one_map.data)+
  geom_sf(aes(fill=Division.Antibiotic.pv), color="black", alpha = 0.2)+
  scale_fill_viridis_c(option = "viridis", trans = "sqrt")+
  geom_sf_text (data=Antibiotic_s_one_map.data,
                aes (label= NAME_new),
                color = "#00FFFF",
                size=3.5,
                fontface = "bold")+
  xlab("")+ ylab("")+
  labs(  
    fill = "Prevalence") + 
  theme(plot.title =  
          element_text(hjust = 0.5)) +  
  theme(plot.subtitle =
          element_text(hjust = 0.5))+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        rect = element_blank())

map_Antibiotic_s_one

#mx for age_cat

head (Antibiotic_s_one$age_cat)
levels (Antibiotic_s_one$age_cat)
Antibiotic_s_one$age_cat.new= recode (Antibiotic_s_one$age_cat,
                                                    "<20"="<20",
                                                    ">=20 & <30"="20-29",
                                  ">=30 & <40"= "30-39",
                                  ">=40"= "≥40"
                                  )


# Bar chart by age
Antibiotic_s_one$antibiotics_use_by_doctor= recode (Antibiotic_s_one$antibiotics_use_by_doctor,
                                            "no"="No",
                                            "yes"="Yes")

ggplot(Antibiotic_s_one, aes (x=  age_cat.new   , 
                    fill= antibiotics_use_by_doctor,
                    show.values = F,
                    value.offset = 0.02,
                    size=4))+
  geom_bar(position = "dodge", width=0.80)+
  labs (x= "Age", y= "Administration of antibiotic without prescription", fill= "", size="0.5")+
  theme_minimal()+
  guides(size = FALSE)

# Bar chart by  Gender
library(ggplot2)
library(gcookbook)

ggplot(Antibiotic_s_one, aes (x=  Gender   , 
                              fill= antibiotics_use_by_doctor,
                              show.values = F,
                              value.offset = 0.02,
                              just=0.5,
                              size=4))+
  geom_bar(position = "dodge", width=0.80,binwidth = 0.5)+
  labs (x= "Sex", y= "Administration of antibiotic without prescription", fill= "", size="0.5")+
  theme_minimal()+
  guides(size = FALSE)

# 95% CI by the categorical variables (table 2)
library(freqtables)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$age_cat, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$Gender, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$Marital_status_new, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$Educational_status_new, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$Devision, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)


# 95% CI by the categorical variables (table 3)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotic_a_1, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotic_a_2, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotic_a_3, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$take_antibiotics, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

# 95% CI by the categorical variables (table 4)
Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k1_a_Covid19, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k1_e_Dengue, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k1_c_Diabetics, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k1_b_Pneumonia, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k1_d_Tuberculosis, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k3_bacterial, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k3_viral, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k3_paracitic, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k3_fungal, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k3_helminth, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k2_a_Penicillin, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k2_f_Amoxicillin, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k2_b_Cefixime, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k2_d_Azithromycin, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k2_e_Remdisivir, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)

Antibiotic_s_one %>%
  freq_table(Antibiotic_s_one$antibiotics_k2_c_Albendazole, antibiotics_use_by_doctor) %>% 
  freq_format(
    recipe = "percent_row (lcl_row - ucl_row)",
    name = "percent_95",
    digits = 2
  ) %>%
  select(1:6, percent_95)



