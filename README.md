# Bitcoin Price Forecasting: Statistical vs Machine Learning Approaches

## Project Overview

This project develops predictive models for Bitcoin closing prices using historical high-frequency data, comparing statistical and machine learning approaches to identify trends and volatility patterns in cryptocurrency markets.

## Problem Statement

Despite growing Bitcoin adoption, accurately forecasting cryptocurrency prices remains challenging due to high volatility, non-stationarity, and complex temporal dynamics. This study provides systematic comparative analysis of statistical and machine learning models for Bitcoin price forecasting.

## Objectives

- Analyze temporal dynamics of Bitcoin closing prices using historical high-frequency time series data
- Design and implement predictive models employing both statistical techniques and machine learning approaches  
- Assess and compare effectiveness of different models in capturing price trends and volatility

## Dataset

- **Source**: Bitcoin Historical Data (1-minute intervals)
- **Size**: 7,337,918 observations
- **Features**: Timestamp, Open, High, Low, Close, Volume
- **Time Period**: Complete historical Bitcoin trading data
- **Frequency**: 1-minute OHLCV data

## Methodology

### CRISP-DM Framework
1. **Business Understanding**: Define forecasting objectives and success criteria
2. **Data Understanding**: Comprehensive data quality assessment and exploration
3. **Data Preparation**: Time series preprocessing, resampling, and feature engineering
4. **Modeling**: Implementation of multiple forecasting approaches
5. **Evaluation**: Quantitative metrics (MAE, MAPE, MSE) and visual validation
6. **Deployment**: Production-ready forecasting pipeline

### Models Implemented

#### Statistical Models
- **ARIMA** (AutoRegressive Integrated Moving Average)

#### Machine Learning Models
- **Random Forest** for time series

## Key Features

### Data Processing
- Timestamp conversion and indexing
- Data resampling (minute → daily aggregation)
- Stationarity testing and transformation
- Missing value handling

### Feature Engineering
- Lag features (1-7 periods)
- Rolling statistics (mean, std, volatility)
- Technical indicators
- Return calculations

### Model Evaluation
- Train/test split (80/20)
- Cross-validation for time series
- Multiple performance metrics
- Residual analysis
- Forecast error diagnostics

## Results

### Key Findings
- Bitcoin prices exhibit non-stationarity requiring differencing
- High volatility makes short-term prediction challenging
- [Additional findings to be added after analysis]

## Project Structure

```
Time Series/
├── README.md
├── index.ipynb              # Main analysis notebook
├── data/
│   └── bitcoin_historical_data.csv
```

## Usage

1. **Data Loading & Preprocessing**
```python
data = pd.read_csv('data/bitcoin_historical_data.csv')
data['Timestamp'] = pd.to_datetime(data['Timestamp'], unit='s')
daily_data = data.resample('D').agg({'Close': 'last'})
```

2. **Stationarity Check**
```python
from statsmodels.tsa.stattools import adfuller
result = adfuller(daily_data['Close'])
```

3. **Model Training**
```python
from statsmodels.tsa.arima.model import ARIMA
model = ARIMA(train_data, order=(1,1,1)).fit()
predictions = model.forecast(steps=len(test_data))
```

## Future Enhancements

- Real-time data integration
- Ensemble model combinations
- Advanced deep learning architectures
- Multi-step ahead forecasting
- Risk management integration

## Contributors

- Billy Sambasi - Data Scientist

## License

This project is licensed under the Apache License - see the LICENSE file for details.
