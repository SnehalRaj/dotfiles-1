module Keys where

import qualified Data.Map as M
import Graphics.X11.ExtraTypes
import System.Exit

import XMonad
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.Navigation2D
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet as W
import XMonad.Util.Scratchpad

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X())
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $
    -- launch a terminal
    [ ((modm, xK_Return), spawnHere $ XMonad.terminal conf)
    -- launch rofi
    , ((modm, xK_d), spawnHere "rofi -combi-modi drun,run -show combi")
    -- launch window switcher
    , ((mod1Mask, xK_Tab), spawnHere "rofi -show window")
    -- close focused window
    , ((modm .|. shiftMask, xK_q), kill)
     -- Rotate through the available layout algorithms
    , ((modm, xK_space), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    -- Directional navigation of windows
    , ((modm, xK_Right), windowGo R False)
    , ((modm, xK_l), windowGo R False)
    , ((modm, xK_Left ), windowGo L False)
    , ((modm, xK_h ), windowGo L False)
    , ((modm, xK_Up   ), windowGo U False)
    , ((modm, xK_k   ), windowGo U False)
    , ((modm, xK_Down ), windowGo D False)
    , ((modm, xK_j ), windowGo D False)
    -- Move focus to the master window
    , ((modm, xK_m), windows W.focusMaster)
    -- Swap the focused window and the master window
    , ((modm, xK_Tab), windows W.swapMaster)
    -- Swap adjacent windows
    , ((modm .|. shiftMask, xK_Right), windowSwap R False)
    , ((modm .|. shiftMask, xK_l), windowSwap R False)
    , ((modm .|. shiftMask, xK_Left ), windowSwap L False)
    , ((modm .|. shiftMask, xK_h ), windowSwap L False)
    , ((modm .|. shiftMask, xK_Up   ), windowSwap U False)
    , ((modm .|. shiftMask, xK_k), windowSwap U False)
    , ((modm .|. shiftMask, xK_Down ), windowSwap D False)
    , ((modm .|. shiftMask, xK_j ), windowSwap D False)
    -- Shrink the master area
    , ((modm, xK_minus), sendMessage Shrink)
    -- Expand the master area
    , ((modm, xK_equal), sendMessage Expand)
    -- Push window back into tiling
    , ((modm, xK_e), withFocused $ windows . W.sink)
    -- scratchpad
    , ((modm, xK_s), scratchpadSpawnActionCustom "st -n scratchpad")
    -- Find Next Empty Workspace
    , ((modm, xK_n), viewEmptyWorkspace)
    , ((modm .|. shiftMask, xK_n), tagToEmptyWorkspace)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_e), io exitSuccess)
    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r), spawn "xmonad --recompile && xmonad --restart")
    ]
    ++
    -- Brightness Up/Down
    [ ((noModMask, xF86XK_MonBrightnessUp), spawn "light -A 10")
    , ((noModMask, xF86XK_MonBrightnessDown), spawn "light -U 10")
    -- Volume Up/Down/Mute
    , ((noModMask, xF86XK_AudioLowerVolume), spawn "/home/yash/.i3/bin/volume.sh down")
    , ((noModMask, xF86XK_AudioRaiseVolume), spawn "/home/yash/.i3/bin/volume.sh up")
    , ((noModMask, xF86XK_AudioMute), spawn "/home/yash/.i3/bin/volume.sh mute")
    -- Song Toggle/Play/Pause
    , ((noModMask, xF86XK_AudioNext), spawn "/home/yash/.i3/bin/song next")
    , ((noModMask, xF86XK_AudioPrev), spawn "/home/yash/.i3/bin/song prev")
    , ((noModMask, xF86XK_AudioPlay), spawn "/home/yash/.i3/bin/song toggle")
    -- Screenshot
    , ((noModMask, xK_Print), spawnHere "teiler")
    -- Emacs
    , ((modm .|. shiftMask, xK_Return), spawnHere "emacsclient -nc")
    -- Lock Screen
    , ((modm .|. shiftMask, xK_l), spawn "/home/yash/.i3/bin/lock")
    ]
    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    -- Directional Screen Navigation
    [ ((modm, xK_p), screenGo R False)
    , ((modm, xK_o), screenGo L False)
    , ((modm, xK_bracketleft), windows W.focusUp)
    , ((modm, xK_bracketright), windows W.focusDown)

    -- Swap workspaces on adjacent screens
    , ((modm .|. controlMask, xK_p), screenSwap R False)
    , ((modm .|. controlMask, xK_o), screenSwap L False)

    -- Send window to adjacent screen
    , ((modm .|. shiftMask, xK_p), windowToScreen R False)
    , ((modm .|. shiftMask, xK_o), windowToScreen L False)
    ]



