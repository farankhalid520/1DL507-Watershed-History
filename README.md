# History of Watersheds

## Project Overview
This project explores trends in watershed data from Swedish lakes, focusing on how climate, hydrology, land use, and lake chemistry influence **Total Organic Carbon (TOC)** concentrations. It aims to address key questions about the environmental changes in these lakes over time.

## Data Source
The data for this analysis was sourced from:
- **[Swedish Lake Monitoring Program (2001-2022)](https://www.smhi.se/data/hydrologi)**: Lake chemistry data (TOC, metals, nutrients).
- **[Swedish Meteorological and Hydrological Institute (SMHI)](https://www.smhi.se/data/hydrologi)**: Meteorological and hydrology data (temperature, precipitation, water flow).

## Research Questions
1. **Factors affecting TOC concentrations**: What environmental variables contribute to TOC variability across lakes?
2. **Spatial patterns in TOC influence**: Are there geographical patterns affecting TOC concentrations?
3. **Water level trends**: Are lakes becoming wetter or drier over time?

## Models Used
The following models were implemented to answer the research questions:
- **Linear Mixed Effects (LME) Models**: To account for time-series data and lake-specific variations.
- **Spatial Models**: Including Geographically Weighted Regression (GWR) and Spatial Lag Models (WX), to explore spatial dependencies.
- **Generalized Additive Models (GAM)**: Used with an xGBoost ensemble to model nonlinear relationships and improve TOC prediction.
- **ARIMA (AutoRegressive Integrated Moving Average)**: For forecasting water flow trends from 2022-2025.

## Key Findings
- **TOC Influences**: Organic nitrogen, metals (Mg, Fe, Si), and forest coverage have the largest positive impact on TOC, while phosphorus (P), sulfate (SO4), and pH negatively affect it.
- **Spatial Analysis**: Limited evidence of spatial patterns, with some autocorrelation present but not substantial.
- **Water Level Trends**: No significant trend toward lakes becoming wetter or drier was found, indicating stable hydrology.
- **Forecasting**: ARIMA models struggled with limited data, showing high variance in long-term predictions.

## Conclusion
The study highlights the importance of lake chemistry and catchment area in explaining TOC levels. Future work could focus on collecting more granular land use data and leveraging advanced modeling techniques to improve predictive accuracy.

## Repository Contents
- **Data and scripts** for LME, GAM, and ARIMA models.
- **Results and visualizations** from spatial analysis and trend forecasting.

## Links
- [Data Source: SMHI Lake Monitoring](https://www.smhi.se/data/hydrologi)
