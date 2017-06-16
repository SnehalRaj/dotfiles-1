import qualified Data.Map as M
import Data.Monoid

import XMonad
import XMonad.Actions.Navigation2D
import XMonad.Actions.SpawnOn
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import System.Taffybar.Hooks.PagerHints (pagerHints)
import qualified XMonad.StackSet as W
import XMonad.Util.Scratchpad

import Keys
import Startup (myStartup)

myTerminal :: String
myTerminal = "st"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 2

myModMask :: KeyMask
myModMask = mod4Mask

myWorkspaces :: [String]
-- myWorkspaces = ["web", "main"] ++ map ((++) "sh" . show) ([3..7] :: [Int]) ++ ["mail", "spotify", "video"]
myWorkspaces = ["\xf268 web", "\xf120 main"] ++ map ((++) "sh" . show) ([3..7] :: [Int]) ++ ["mail", "\xf1bc spotify", "video"]

myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                              >> windows W.shiftMaster)
    -- mod-button2, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                              >> windows W.shiftMaster)
    ]

myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [ className =? "mpv" --> doShift "video"
    , className =? "chromium" --> doShift (head myWorkspaces)
    , className =? "Chromium" --> doShift (head myWorkspaces)
    -- , className =? "spotify" --> doShift "spotify"
    -- , className =? "Spotify" --> doShift "spotify"
    , className =? "spotify" --> doShift "\xf1bc spotify"
    , className =? "Spotify" --> doShift "\xf1bc spotify"
    , className =? "VirtualBox"  --> doFloat
    , className =? "zenity"  --> doFloat
    , className =? "Zenity"  --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

myScratchPadManageHook :: ManageHook
myScratchPadManageHook = scratchpadManageHook (W.RationalRect 0.25 0.2 0.5 0.6)

defaults = withNavigation2DConfig def $ pagerHints $ desktopConfig
  {
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,

    -- Adds Super-b to toggle statusbar
    keys               = myKeys <+> keys desktopConfig,
    mouseBindings      = myMouseBindings,

    -- handleEventHook    = myHandleEventHook,
    manageHook         = myScratchPadManageHook <+> manageSpawn <+> myManageHook <+> manageHook desktopConfig,
    layoutHook         =  smartBorders $ smartSpacing 15 (Tall 1 (3/100) (1/2)) ||| simpleTabbed,
    startupHook        = myStartup <+> startupHook desktopConfig
  }

main :: IO()
main = xmonad =<< xmobar defaults

