//+------------------------------------------------------------------+
//|                                                 TradeUtility.mqh |
//|                                         Copyright 2019, Andre Le |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Andre Le"
#property link      "https://www.mql5.com"
#property version "2.10"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
 //+==================TRADE SYSTEM MANAGEMENT========================================+
 //| 1. TimeLapseClose() module: used to closed pending order being opened after 2H  |
 //| 2. PartialClose() module: partial close losing trades                           |
 //|
 //+=================================================================================+

//------Settings for AvoidNewsChk function
extern bool AvoidNews=true;
extern int MinimumImpact=3; //Check high impact news (rank 3) only
extern int MinsBeforeNews=30; //AvoidNews
extern int MinsAfterNews=30; //number of minutes after the news
extern string FFCalPath = "CustomIndi\\CalendarFX-I-A16_18.11.19";

double AvoidNewsCurrency_arr[3][8];
double AvoidNews_arr[4][2]; //array to hold out put of IsAvoidTradingNews (2nd dimension is 0 for base currency and 1 for quote currency



enum ENUM0_CURRENCY { USD = 1,
GBP = 2,
EUR = 3,
JPY = 4,
CHF = 5, 
AUD = 6, 
CAD = 7,
NZD = 8
};

/*
double AvoidNewsUSD_arr[4]; //0 = IsAvoid= true/false, 1=starttime, 2=endtime
double AvoidNewsGBP_arr[4];
double AvoidNewsEUR_arr[4];
double AvoidNewsJPY_arr[4];
double AvoidNewsCHF_arr[4];
double AvoidNewsAUD_arr[4];
double AvoidNewsCAD_arr[4];
double AvoidNewsNZD_arr[4];
*/


/*
int MinToNews[100][8];
int ImpactToNews[100][8];
*/


void IsAvoidTradingNews(string sym)
{
   string currencyimpacted =  StringSubstr(sym,0,3) + "," + StringSubstr(sym,3,3);
   string CurrArr[]; 
   string currency;
   string sep=",";
   ushort u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(currencyimpacted,u_sep,CurrArr);
   if(k>0)
   {
      for(int i=0;i<k;i++)
      {
      //---BASE currency
      AvoidNews_arr[0,i] = AvoidNewsCurrency_arr[0, StringCurrencyToInteger(CurrArr[i])]; 
      AvoidNews_arr[1,i] = AvoidNewsCurrency_arr[1, StringCurrencyToInteger(CurrArr[i])]; 
      AvoidNews_arr[2,i] = AvoidNewsCurrency_arr[2, StringCurrencyToInteger(CurrArr[i])];
      AvoidNews_arr[3,i] = StringCurrencyToInteger(CurrArr[i]);
      }

      
      /*
      if StringCurrencyToInteger(CurrArr[i]) == AvoidNewsUSD_arr[3]{AvoidNews_arr[0,0] = AvoidNewsUSD_arr[0]; AvoidNews_arr[1,0] = AvoidNewsUSD_arr[1]; AvoidNews_arr[2,0] = AvoidNewsUSD_arr[2]; }
      if StringCurrencyToInteger(CurrArr[i]) == AvoidNewsGBP_arr[3]{AvoidNews_arr[0,0] = AvoidNewsUSD_arr[0]; AvoidNews_arr[1,0] = AvoidNewsUSD_arr[1]; AvoidNews_arr[2,0] = AvoidNewsUSD_arr[2]; }
      if StringCurrencyToInteger(CurrArr[i]) == AvoidNews_arr[3]{AvoidNews_arr[0,0] = AvoidNewsUSD_arr[0]; AvoidNews_arr[1,0] = AvoidNewsUSD_arr[1]; AvoidNews_arr[2,0] = AvoidNewsUSD_arr[2]; }
      if StringCurrencyToInteger(CurrArr[i]) == AvoidNewsUSD_arr[3]{AvoidNews_arr[0,0] = AvoidNewsUSD_arr[0]; AvoidNews_arr[1,0] = AvoidNewsUSD_arr[1]; AvoidNews_arr[2,0] = AvoidNewsUSD_arr[2]; }
      if StringCurrencyToInteger(CurrArr[i]) == AvoidNewsUSD_arr[3]{AvoidNews_arr[0,0] = AvoidNewsUSD_arr[0]; AvoidNews_arr[1,0] = AvoidNewsUSD_arr[1]; AvoidNews_arr[2,0] = AvoidNewsUSD_arr[2]; }
      if StringCurrencyToInteger(CurrArr[i]) == AvoidNewsUSD_arr[3]{AvoidNews_arr[0,0] = AvoidNewsUSD_arr[0]; AvoidNews_arr[1,0] = AvoidNewsUSD_arr[1]; AvoidNews_arr[2,0] = AvoidNewsUSD_arr[2]; }
      */
      }
   }


int StringCurrencyToInteger(string currency)
{
      if(currency=="USD") return(0);
      if(currency=="GBP") return(1);
      if(currency=="EUR") return(2);
      if(currency=="JPY") return(3);
      if(currency=="CHF") return(4);
      if(currency=="AUD") return(5);
      if(currency=="CAD") return(6);
      if(currency=="NZD") return(7);
      //----
      return(-1);
}

  //---------------------------------------------------
  // NewsFilter
  //--------------------------------------------------
void UpcomingNewsCheck( double& avoidnewscurrency_arr[3][8]
                  ,int currency
                  //int MinImpactx,
                  //int MinsBeforeNewsx,
                  //int MinAfterNewsx
                  )
{
   bool AvoidTrading=false;
   string newsAlert;
   double MinToNews_arr[51];
   double ImpactToNews_arr[51];
   ArrayInitialize(MinToNews_arr,0);
   ArrayInitialize(ImpactToNews_arr,0);
   //ArrayInitialize(MinToNews_arr,0);
   //ArrayInitialize(ImpactToNews_arr,0);
   //ArrayResize(MinToNews_arr,50);
   
      static int PrevMinute=-1;  
            
      datetime NewsWindowTimeStart=0; 
      datetime NewsWindowTimeEnd=0; //the time period threshold, define by MinsBeforNews and MinsAfterNews
      
      //get the minutes to news and News impact in the past x candles
      for(int i=0;i<=49;i++)
        { 
        //Print("i ", i);
        if(iCustom(NULL,0,FFCalPath,2,i+1) == currency + 1 && iCustom(NULL,0,FFCalPath,0,i+1) >0) 
         {
         MinToNews_arr[i]=iCustom(NULL,0,FFCalPath,0,i+1);
         ImpactToNews_arr[i]=iCustom(NULL,0,FFCalPath,1,i+1);
         }
        else 
         {
         MinToNews_arr[i]=99999;
         ImpactToNews_arr[i]=0;
         }
        }
        //for(int i=99;i>=0;i--)
        //{ Print("MinToNews[]: " MinToNew_arr[i]," || ImpactToNews[]: " ImpactToNews_arr[i]);   }
       //--- got an 2 arrays of MinToNews [0, 0, 105, 0, 0 , ....} and ImpactToNews [0, 0, 7, 0, 0....]
       
      
      //int MinToNews=iCustom(NULL,0,FFCalPath,0,1); 
      //int ImpactToNews=iCustom(NULL,0,FFCalPath,1,1);
      int MinToNews = ArrayMinimum(MinToNews_arr,WHOLE_ARRAY,0);
      int ImpactToNews = ArrayMaximum(ImpactToNews_arr,WHOLE_ARRAY,0);
      //read the time if MinToNews is only 30 minutes away from the News release
      if(MinToNews<=MinsBeforeNews)
         {
            NewsWindowTimeStart = TimeCurrent(); //record the current time
            NewsWindowTimeEnd = TimeCurrent()+(MinToNews+MinsAfterNews)*60; //Get the future time where news window end
         }


      if(Minute()!=PrevMinute)
      {
          PrevMinute=Minute();
          if((MinToNews<=MinsBeforeNews &&  ImpactToNews>=MinimumImpact) || 
            (TimeCurrent()<=NewsWindowTimeEnd))
          AvoidTrading=true;
          newsAlert = "MinToNews: " + MinToNews + ", ImpactToNews: " + ImpactToNews + " ,HIGH IMPACT NEWS, ONLY TRADE AFTER " + NewsWindowTimeEnd ;        
          Alert(newsAlert);
      }
      else {
         newsAlert =  "MinToNews: " + MinToNews + ", ImpactToNews: " + ImpactToNews + ", " + NewsWindowTimeEnd;
         AvoidTrading=false;
         Print(newsAlert);
         }
      /*
      //--- assign results to array---
      avoidnewscurrency_arr[0] = AvoidTrading;
      avoidnewscurrency_arr[1] = NewsWindowTimeStart;
      avoidnewscurrency_arr[2] = NewsWindowTimeEnd;
      avoidnewscurrency_arr[3] = currency;
      */
      avoidnewscurrency_arr[0,currency-1] = AvoidTrading;
      avoidnewscurrency_arr[1,currency-1] = NewsWindowTimeStart;
      avoidnewscurrency_arr[2,currency-1] = NewsWindowTimeEnd;
         //return(AvoidTrading);
   }


//+------------------------------------------------------------------+


/*
#define USD      0 
#define GBP      1 
#define EUR      2 
#define JPY      3 
#define CHF      4 
#define AUD      5 
#define CAD      6
#define NZD      7
*/