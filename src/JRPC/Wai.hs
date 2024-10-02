{-# LANGUAGE RankNTypes #-}

module JRPC.Wai where

import Data.ByteString.Lazy
import Network.Wai
import Data.Aeson
import qualified JRPC.Wai.Internal as I

makeApplication :: (forall a . m a -> IO a) -> (ByteString -> m (Maybe Value)) -> Application
makeApplication = I.makeApplication
{-# INLINE makeApplication #-}
