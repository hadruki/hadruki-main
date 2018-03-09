{-# LANGUAGE OverloadedStrings #-}
module Lib
  ( runSite
  ) where

import Control.Monad
import Happstack.Server
       (Conf(..), nullConf, ok, simpleHTTP, toResponse, Response, dir, Browsing(..), serveDirectory)

runSite :: IO ()
runSite =
  simpleHTTP nullConf {port = 3000} $ msum [ mzero 
       -- , dir "hello" $ ok "Hello, World!"
       -- , dir "goodbye" $ ok "Goodbye, World!"
       -- , dir "blah" serveBlah
       , dir "admin" $ serveDirectory DisableBrowsing ["index.html"] "/var/hadruki-admin/"
       , dir "main"  $ serveDirectory DisableBrowsing ["index.html"] "/var/hadruki-main/"
       , dir "blog"  $ serveDirectory DisableBrowsing ["index.html"] "/var/hadruki/blog/_site/"
       ]

-- serveBlah :: IO Response
serveBlah = undefined