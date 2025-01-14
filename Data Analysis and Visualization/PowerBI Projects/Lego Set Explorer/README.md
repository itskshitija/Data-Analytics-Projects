<a href="https://www.linkedin.com/in/kshitija-chilbule-b98515309/" target="_blank">
  <img src="https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin" alt="LinkedIn Badge" style="height: 30px; width: auto;">
</a>

# Lego Set Explorer 🧩

## Table of Contents
- [Overview](#overview)
- [Data Dictonary](#data-dictionary)
- [Data Cleaning](#data-cleaning)
- [Important KPIs](#important-kpis)
- [Dashboard Preview](#dashboard-preview)

## Overview
The objective of this challenge is to create an interactive visual that lets users explore the history and evolution of LEGO sets from the past 50 years. The dashboard uses data from LEGO sets released from 1970 to 2022, including details on each set’s theme, pieces, recommended age, retail price, and image.
 
## Data Dictionary
<b>set_id:</b> Official LEGO item number

<b>name:</b> Name of the LEGO set

<b>year: </b> Release year

<b>theme:</b> LEGO theme the set belongs to

<b>subtheme:</b> Subtheme within the theme

<b>themeGroup:</b> Overall group the theme belongs to

<b>category:</b> Type of set pieces	Number of pieces in the set

<b>minifigs:</b>Number of mini figures included in the set

<b>agerange_min:</b> Minimum age recommended

<b>US_retailPrice:</b> US retail price at launch

<b>bricksetURL:</b> URL for the set on brickset.com

<b>thumbnailURL:</b> Small image of the set

<b>imageURL: </b> Full size image of the set

## Data Cleaning
Once the dataset is imported into Power BI, the next step is to clean it, as it often contains various inconsistencies. We will perform data cleaning using Power BI Query Editor, an inbuilt feature of Power BI that allows efficient data transformation and preparation. 

Click on the <b>Transform Data</b> tab to access the Power Query Editor.

- <b>Removing Irrelevant Columns: </b> In our analysis, certain columns are not needed, so it's important to remove them to ensure an effective analysis.
  - Columns Removed: `thumbnailURL, bricksetURL, minifigs`

- <b>Changing Type of columns: </b> Our dataset includes columns with incorrect data types that need to be corrected for accurate analysis.
  - The `agerange_min` column, initially in text format, is converted to a whole number type
  - The `US_retailPrice` column, initially in text format is converted to a fixed decimal type

- <b>Handling Missing Values: </b> Our dataset consist of columns with missing values. For this analysis, we removed empty values.
  - Columns: `pieces, agerange_min, US_retailPrice`
 
- <b>Renaming Columns: </b> For better identification of columns, we renamed some columns.
  - `agerange_min`: age
  - `US_retailPrice`: price

## Important KPIs

<b>1.Total Sets</b> 

```
Total Sets = DISTINCTCOUNT(lego_sets[set_id])
```

<b>2.Total Groups</b>

```
Total Groups = DISTINCTCOUNT(lego_sets[themeGroup])
```

<b>3. Average Age </b>

```
Avg. Age = AVERAGE(lego_sets[age])
```

<b>4. Average Price </b>

```
Avg. Price = AVERAGE(lego_sets[price])
```

<b>5. Average Pieces </b>

```
Avg. Pieces = AVERAGE(lego_sets[pieces])
```

## Dashboard Preview

![1](https://github.com/user-attachments/assets/cf167a87-ba24-4c50-9881-8caa93bba362)

![2](https://github.com/user-attachments/assets/c0b6fdbd-18cc-400b-8c84-0b56a1184de0)
