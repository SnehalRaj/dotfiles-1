module Startup where

import           XMonad
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Util.SpawnOnce

import qualified XMonad.Layout.IndependentScreens as LIS

myStartup :: X ()
myStartup = do
  ewmhDesktopsStartup
  spawnOnce "st -n scratchpad"
