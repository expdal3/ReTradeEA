//+------------------------------------------------------------------+
//|                                                    ReTradeEA.mq4 |
//|                                       Copyright 2021, BlueStone. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, BlueStone."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern string _INTRO = "|---- FILTER DEALS -----|
extern string acceptListOfMagic = "";  // List of magic numbers
extern string acceptListOfComment = "";  // List of magic numbers

extern string _REPEATINGINFO = "|---- _REPEATINGINFO -----|
extern int numberRepeat = 3;
extern enum slaveLotSize
         {Fixed=1,
         Multiplier=2,
         RiskPctBalance=3
         };
extern int eaMagicNumber = 112233 ; // EA Magic number
extern int eaComment = "repeater" ; // EA Slave comment

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+

void WriteToDatabase(int ticketnumber, 
                     ,string symbol
                     ,enum ENUM_ORDER_TYPE
                     ,double entry
                     ,double tp
                     ,double sl
                     ,int magicnumber
                     ,string comment
                     ){

int counter;
   

}