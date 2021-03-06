//+------------------------------------------------------------------+
//|                                                 TradeUtility.mqh |
//|                                         Copyright 2019, Andre Le |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Andre Le"
#property link      "https://www.mql5.com"
#property version "2.10"
#property strict

#include "..\\Common\\CommonBase.mqh"


//---#include <Orchard\Common\CommonBase.mqh>

class CMaster : CCommonBase
  {
  
   protected: // Members variable
      int      mMagicNumber;
      string   mComment;
   
   protected: // Constructors
   
   public:
                     CMaster(int initMagicNumber, string initComment){ Init(initMagicNumber,  initComment); }
                    ~CMaster();
   public:
                     int Init(int magicnumber, string comment);
  };
  

int   CMaster::Init(int magicnumber, string comment){

   mMagicNumber     = magicnumber;
   mComment         = comment;
   
   SetInitResult("", INIT_SUCCEEDED);
   
   return(INIT_SUCCEEDED);    // if this called by constructor, won't go back to EA so need a handler for this
}

