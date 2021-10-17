//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2018, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include "CommonFunctions.mqh"
#property copyright  "Copyright 2021-2020, Orchard Forex"
#property link       "https://www.orchardforex.com"
#property   version  "1.00"
#property   strict

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CCommonBase
  {

private:

protected:  // Members
   int               mDigits;
   string            mSymbol;
   ENUM_TIMEFRAMES   mTimeframe;
   
   string            mInitMessage;
   int               mInitResult;
  
protected:   // Constructors (cannot use by external function, only be used by inherited child-class

   CCommonBase()                 {  Init(_Symbol,  (ENUM_TIMEFRAMES)_Period); }
   CCommonBase(string symbol)    {  Init(symbol,  (ENUM_TIMEFRAMES)_Period); }
   CCommonBase(ENUM_TIMEFRAMES timeframe)    {  Init(_Symbol,  timeframe); }
   CCommonBase(string symbol, ENUM_TIMEFRAMES timeframe)    {  Init(symbol,  timeframe); }
   ~CCommonBase() {};
   
   int   Init(string symbol, ENUM_TIMEFRAMES timeframe);   
protected:  // Functions
   //function to expose INIT_SUCCEEDED back to EA
   int         SetInitResult(string initMessage, int initResult){
                  mInitMessage = initMessage;
                  mInitResult = initResult;
                  return (initResult);
               }

public:
   int           InitResult()    {  return(mInitResult); }
   string        InitMessage()  {  return(mInitMessage);   }

public:  // Functions
   
   bool           TradeAllowed() 
               {  return(MarketInfo(mSymbol,MODE_TRADEALLOWED)>0);   }
      
  };

int   CCommonBase::Init(string symbol, ENUM_TIMEFRAMES timeframe){
   
   SetInitResult("", INIT_SUCCEEDED);
   
   mSymbol     = symbol;
   mTimeframe  = timeframe;
   mDigits     =  (int)MarketInfo(symbol,MODE_DIGITS);
   
   return(INIT_SUCCEEDED);    // if this called by constructor, won't go back to EA so need a handler for this
}
//+------------------------------------------------------------------+
