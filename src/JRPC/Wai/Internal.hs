{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE OverloadedStrings #-}

module JRPC.Wai.Internal where

import Data.ByteString.Lazy
import Network.Wai
import Network.HTTP.Types
import Data.Aeson

makeApplication :: (forall a . m a -> IO a) -> (ByteString -> m (Maybe Value)) -> Application
makeApplication runServer server = \req rcvd -> do
  strictRequestBody req >>= runServer . server >>= rcvd . responseLBS ok200 headers . getBody
  where
    headers = [("content-type", "application/json")]
    getBody = maybe "" encode
