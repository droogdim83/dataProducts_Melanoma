<style type="text/css">

body, td {
   font-size: 14px;
}
code.r{
  font-size: 10px;
}
pre {
  font-size: 20px
}
</style>

Oncology for Dummies!
========================================================
author: Weston Carloss
font-family: 'Helvetica'
date: August 26, 2017
width: 1440
height: 900
  
Background
========================================================
class:  text/css
width: 1440
height: 900

**Purpose**: Provide a simple app to predict survival time for patients with 
malignant melanoma

**Training Data Source**: *"Melanoma"* dataset from R *MASS* package. Models 
survival time (in days) for 205 melatoma patients in Denmark from 1962 - 1977 
using the following predictors: 
  
- (Anticipated) Patient Health Outcome  
- Patient Gender  
- Patient Age at Time of Diagnosis  
- Year of Tumor Surgery  
- Tumor Thickness (Breslow's Thickness)  
- Presence/Absence of Tumor Ulceration  
  
App Benefits & Limitations
========================================================
width: 1440
height: 900

App Benefits 
  
- Easy to use  
- Small, lightweight  
- Offers insight into potential benefits of machine learning in cancer outcome prediction
- Built-in documentation  

***
Limitations 
  
- Training data limitations  
    + Small sample size  
    + Based on a single country  
- Greatly oversimplifies cancer prediction  

Simple Multi-Tab GUI
====================================

![Application UI](App_UI.png)  

Model Summary
========================================================
class:  text/css
width: 1440
height: 900


  

```

Call:
lm(formula = .outcome ~ ., data = dat)

Residuals:
    Min      1Q  Median      3Q     Max 
-3467.1  -215.1   -69.8   324.5  1973.1 

Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)               2162.01      55.94  38.648  < 2e-16 ***
status.Alive               822.04      71.01  11.576  < 2e-16 ***
status.Died_Other_Causes    75.01      63.02   1.190  0.23613    
sex.Male                   -59.72      59.74  -1.000  0.31929    
age                         -5.55      63.44  -0.087  0.93043    
year.1965                   88.30      74.24   1.189  0.23643    
year.1967                   45.38      79.72   0.569  0.57021    
year.1968                 -118.64      83.77  -1.416  0.15907    
year.1969                 -114.22      84.13  -1.358  0.17692    
year.1970                 -190.10      84.79  -2.242  0.02665 *  
year.1971                 -314.56      97.14  -3.238  0.00153 ** 
year.1972                 -512.55      98.03  -5.228 6.64e-07 ***
year.1973                 -675.38      93.24  -7.244 3.43e-11 ***
thickness                  -62.47      67.59  -0.924  0.35707    
ulcer.Presence             -61.72      67.67  -0.912  0.36348    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 673.6 on 130 degrees of freedom
Multiple R-squared:  0.684,	Adjusted R-squared:   0.65 
F-statistic:  20.1 on 14 and 130 DF,  p-value: < 2.2e-16
```
