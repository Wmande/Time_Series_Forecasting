from fastapi import FastAPI 
import joblib
import pandas as pd

app = FastAPI(title="Bitcoin Price Forecast API")

model = joblib.load("model.pkl")

@app.get("/")
def home():
    return {"message": "Bitcoin Time Series Forecast API is running"}

@app.post("/predict")
def predict(features: dict):
    """
    Expected input:
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
    """
    df = pd.DataFrame([features])
    prediction = model.predict(df)
    return {"predicted_close": float(prediction[0])}