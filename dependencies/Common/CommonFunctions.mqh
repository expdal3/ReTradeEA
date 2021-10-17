/*
   CommonFunctions.mqh
   CopyRight 2012-2020, OrchardForex,
   http://www.orchardforex.com

*/
//---
// Simple comparisons based on trade direction
#define  _GT(v1, v2, tradeType) ((tradeType%2==ORDER_TYPE_BUY && v1>v2)  || (tradeType%2==ORDER_TYPE_SELL && v1<v2)  )
#define  _GE(v1, v2, tradeType) ((tradeType%2==ORDER_TYPE_BUY && v1>=v2) || (tradeType%2==ORDER_TYPE_SELL && v1<=v2) )
#define  _LT(v1, v2, tradeType) ((tradeType%2==ORDER_TYPE_BUY && v1<v2)  || (tradeType%2==ORDER_TYPE_SELL && v1>v2)  )
#define  _LE(v1, v2, tradeType) ((tradeType%2==ORDER_TYPE_BUY && v1<=v2) || (tradeType%2==ORDER_TYPE_SELL && v1>=v2) )
//+------------------------------------------------------------------+
//| PipsToPrice
//| PriceTopPips
//| PointsToPrice 
//+------------------------------------------------------------------+

// Pips, Points conversion for 4 or 5 digit brokers
//
double   PipSize(){return(PipSize(_Symbol));}
double   PipSize(string symbol)  {
   double   point       = MarketInfo(symbol,MODE_POINT);    // for EURUSD return 0.00001
   int      digits      =   (int) MarketInfo(symbol, MODE_DIGITS);
   return   (((digits%2)==1) ? point*10 : point);

}
//---
//---
double   PriceToPips(double price)                 {return(
                                                      (PipSize(_Symbol)!=0) ? price/PipSize(_Symbol): 0
                                                      );}
double   PriceToPips(double price, string symbol)  {return(
                                                      (PipSize(symbol)!=0) ? price/PipSize(symbol): 0
                                                      );}

//+------------------------------------------------------------------+

double   PipsToPrice(double pips)                  {return(pips*PipSize(_Symbol));}
double   PipsToPrice(double pips, string symbol)   {return(pips*PipSize(symbol));} 
//---

double   PointsToPrice(double points)                 {return(points*MarketInfo(_Symbol, MODE_POINT));}
double   PointsToPrice(double points, string symbol)  {return(points*MarketInfo(symbol, MODE_POINT));}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

double   OpenPrice(string symbol, int tradeType){
   return(OpenPrice(symbol, (ENUM_ORDER_TYPE)tradeType) );
}

double   OpenPrice(string symbol, ENUM_ORDER_TYPE tradeType){
   return( (tradeType%2==ORDER_TYPE_BUY)?
            MarketInfo(symbol,MODE_ASK) : MarketInfo(symbol,MODE_BID));
}


double   ClosePrice(string symbol, int tradeType){
      return(ClosePrice(symbol, (ENUM_ORDER_TYPE)tradeType));
}

double   ClosePrice(string symbol, ENUM_ORDER_TYPE tradeType){
      return((tradeType%2==ORDER_TYPE_BUY) ? 
               MarketInfo(symbol, MODE_BID) : MarketInfo(symbol, MODE_ASK));
}

//---Simple math based on trade direction
double   Add(double v1, double v2, int tradeType){
   return(  Add(v1,v2,(ENUM_ORDER_TYPE)tradeType));
}

double   Add(double v1, double v2, ENUM_ORDER_TYPE tradeType){
   return(  (tradeType%2 == ORDER_TYPE_BUY)? v1+v2 : v1-v2);
}

double   Sub(double v1, double v2, int tradeType){
   return( Sub(v1, v2, (ENUM_ORDER_TYPE)tradeType));
}

double   Sub(double v1, double v2, ENUM_ORDER_TYPE tradeType){
   return( (tradeType%2 == ORDER_TYPE_BUY)? v1-v2 : v1+v2);
}

