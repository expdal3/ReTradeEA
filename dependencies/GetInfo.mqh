//+------------------------------------------------------------------+
//|                                                 TradeUtility.mqh |
//|                                         Copyright 2019, Andre Le |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Andre Le"
#property link      "https://www.mql5.com"
#property version "2.10"
#property strict

#define ORDERINFO_ORDERTICKET 0
#define ORDERINFO_ORDERLOTSIZE  1
#define ORDERINFO_ORDERSYMBOL  2
#define ORDERINFO_ORDERTYPE  3
#define ORDERINFO_OPENPRICE  4
#define ORDERINFO_OPENTIME  5
#define ORDERINFO_CLOSEPRICE  6
#define ORDERINFO_CLOSETIME  7
#define ORDERINFO_MAGIC  8
#define ORDERINFO_EXPIRY  9
#define ORDERINFO_COMMENT  10

double GetOrderOpenInfo(int ordertic, int info)
  {

   for(int b=OrdersTotal()-1; b >=0; b--) // loop thru opening order
     {
      if(OrderSelect(b,SELECT_BY_POS,MODE_TRADES)) //select the order
         //if(OrderMagicNumber()==MagicNumber) //check if the selected order was opened by the EA base on the magic number
         //Note: the above line can be OrderMagicNumber()!=MagicNumber) continue; or break; to skip to next loop or break out loop
         if(OrderTicket()==ordertic)
            switch(info)
              {
               case ORDERINFO_ORDERTICKET:
                  return(OrderTicket());
                  break;
               case ORDERINFO_ORDERLOTSIZE:
                  return(OrderLots());
                  break;
               case ORDERINFO_ORDERSYMBOL:
                  return(OrderSymbol());
                  break;
               case ORDERINFO_ORDERTYPE:
                  return(OrderType());
                  break;
               case ORDERINFO_OPENPRICE:
                  return(OrderOpenPrice());
                  break;
               case ORDERINFO_OPENTIME:
                  return(OrderOpenTime());
                  break;
               case ORDERINFO_CLOSEPRICE:
                  return(OrderClosePrice());
                  break;
               case ORDERINFO_CLOSETIME:
                  return(OrderCloseTime());
                  break;
               case ORDERINFO_EXPIRY:
                  return(OrderExpiration());
                  break;
               case ORDERINFO_COMMENT:
                  return(StringToInteger(OrderComment()));
                  break;
               default:
                  break;
              }

     }
   return(0);
  }
  
 //+------------------------------------------------------------------+
 //|                                                                  |
 //+------------------------------------------------------------------+
double GetOrderCloseInfo(int ordertic, int info)
  {

   for(int b=OrdersHistoryTotal()-1; b >=0; b--) // loop thru opening order
     {
      if(OrderSelect(b,SELECT_BY_POS,MODE_HISTORY)) //select the order
         //if(OrderMagicNumber()==MagicNumber) //check if the selected order was opened by the EA base on the magic number
         //Note: the above line can be OrderMagicNumber()!=MagicNumber) continue; or break; to skip to next loop or break out loop
         if(OrderTicket()==ordertic)
            switch(info)
              {
               case ORDERINFO_ORDERTICKET:
                  return(OrderTicket());
                  break;
               case ORDERINFO_ORDERLOTSIZE:
                  return(OrderLots());
                  break;
               case ORDERINFO_ORDERSYMBOL:
                  return(OrderSymbol());
                  break;
               case ORDERINFO_ORDERTYPE:
                  return(OrderType());
                  break;
               case ORDERINFO_OPENPRICE:
                  return(OrderOpenPrice());
                  break;
               case ORDERINFO_OPENTIME:
                  return(OrderOpenTime());
                  break;
               case ORDERINFO_CLOSEPRICE:
                  return(OrderClosePrice());
                  break;
               case ORDERINFO_CLOSETIME:
                  return(OrderCloseTime());
                  break;
               case ORDERINFO_EXPIRY:
                  return(OrderExpiration());
                  break;
               case ORDERINFO_COMMENT:
                  return(StringToInteger(OrderComment()));
                  break;
               default:
                  break;
              }

     }
   return(0);
  }
