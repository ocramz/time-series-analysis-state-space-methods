{-# language OverloadedStrings #-}
module Lib.Parsers.GoogleFinance where

import Network.HTTP.Simple

import qualified Data.Attoparsec.Internal.Types as A
import Data.Attoparsec.Text hiding (space)
import Data.Text
import Data.Time (Day, TimeOfDay)




-- example qery and data

-- The URL format is: https://www.google.com/finance/getprices?i=[PERIOD]&p=[DAYS]d&f=d,o,h,l,c,v&df=cpct&q=[TICKER]

-- Example: https://www.google.com/finance/getprices?i=60&p=10d&f=d,o,h,l,c,v&df=cpct&q=IBM

-- [PERIOD]: Interval or frequency in seconds
-- [DAYS]: The historical data period, where "10d" means that we need historical stock prices data for the past 10 days.
-- [TICKER]: This is the ticker symbol of the stock

-- EXCHANGE%3DNYSE
-- MARKET_OPEN_MINUTE=570
-- MARKET_CLOSE_MINUTE=960
-- INTERVAL=60
-- COLUMNS=DATE,CLOSE,HIGH,LOW,OPEN,VOLUME
-- DATA=
-- TIMEZONE_OFFSET=-240
-- a1497879000,155.5,155.51,155.5,155.51,600
-- 1,155.83,155.86,155.48,155.55,113953
-- 2,155.47,155.82,155.47,155.82,2633

data GFHeader = {
    exchange :: String
  , mktOpenMinute :: Int
  , mktCloseMinute :: Int
  , interval :: Int
  , tzOffset :: Int } deriving (Eq, Show)

data GFRow a = GFRow {
    date :: Int
  , close :: a
  , high :: a
  , low :: a
  , open :: a
  , volume :: Int } deriving (Eq, Show)
