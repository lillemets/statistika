#? Created on 2023-01-31 11:21:57 by Jyri Lillemets with R version 4.2.2 (2022-10-31).
#? This script tidys data sets.

# Load packages
library('magrittr')
library('dplyr')
library('openxlsx')

# CPUs released between 2010 and 2020
# kodutöö_01_sissejuhatus
cpus <- read.csv('assets/cpus.csv')
cpus$released %<>% substr(1,4)
write.xlsx(cpus, 'andmed/cpus.xlsx')

# Countries
# sissejuhatus
riigid <- read.csv('assets/countries.csv')
riigid[, 1] %<>% trimws
names(riigid) %<>% strsplit('\\.') %>% sapply(`[`, 1)
names(riigid) %<>% tolower
names(riigid)[names(riigid) == 'net'] <- 'netmigration'
riigid %<>% select(country, region, population, area, 
                   netmigration, gdp, literacy, phones, 
                   arable, agriculture)
riigid$region %<>% recode(
  "ASIA (EX. NEAR EAST)" = 'Asia', 
  "BALTICS" = 'Eastern Europe', 
  "C.W. OF IND. STATES" = 'Asia', 
  "EASTERN EUROPE" = 'Eastern Europe', 
  "LATIN AMER. & CARIB" = 'South America', 
  "NEAR EAST" = 'Asia', 
  "NORTHERN AFRICA" = 'Africa', 
  "NORTHERN AMERICA" = 'North America', 
  "OCEANIA" = 'Oceania', 
  "SUB-SAHARAN AFRICA" = 'Africa', 
  "WESTERN EUROPE" = 'Western Europe'
)
write.csv(riigid, 'andmed/countries.csv', row.names = F)
