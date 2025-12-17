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
├── deployment.ipynb         # Deployment documentation
├── app/
│   ├── Dockerfile          # Container configuration
│   ├── main.py            # FastAPI application
│   ├── model.pkl          # Trained ML model
│   └── requirements.txt   # API dependencies
├── data/
│   └── bitcoin_historical_data.csv
└── LICENSE
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

## Deployment

### REST API with FastAPI
The trained model is deployed as a REST API using FastAPI and Docker containerization.

**API Endpoints:**
- `GET /` - Health check
- `POST /predict` - Bitcoin price prediction

**Quick Start:**
```bash
# Build Docker image
docker build -t bitcoin-forecast-api ./app

# Run container
docker run -p 8000:8000 bitcoin-forecast-api

# Test API
curl http://localhost:8000/docs
```

**API Usage:**
```json
{
  "Open": 60000,
  "High": 60500,
  "Low": 59000,
  "Volume": 123456,
  "lag_1": 59800,
  "lag_2": 59000,
  "lag_3": 58500,
  "lag_4": 58000,
  "lag_5": 57500,
  "lag_7": 56000
}
```

**Response:**
```json
{
  "predicted_close": 59234.56
}
```

### Cloud Deployment Options (Next Steps)
- **AWS**: ECS, Lambda, or EC2
- **Google Cloud**: Cloud Run
- **Heroku**: Container Registry
- **Azure**: Container Instances

See `deployment.ipynb` for detailed deployment instructions.

## Future Enhancements

- Real-time data integration
- Ensemble model combinations
- Advanced deep learning architectures
- Multi-step ahead forecasting
- Risk management integration
- API authentication and rate limiting
- Model versioning and A/B testing

## Technical Stack

**Analysis & Modeling:**
- Python 3.10+
- pandas, numpy, matplotlib
- statsmodels, scikit-learn
- Jupyter Notebook

**Deployment:**
- FastAPI for REST API
- Docker for containerization
- uvicorn ASGI server
- joblib for model serialization

## Contributors

- Billy Sambasi - Data Scientist
- Project developed as part of Flatiron School Data Science Program

## License

This project is licensed under the MIT License - see the LICENSE file for details.
