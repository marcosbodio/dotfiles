import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.Submap
-- import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.ICCCMFocus
-- import XMonad.Hooks.SetWMName

import Control.Arrow
import Data.Bits
import qualified Data.Map as M

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doFloat
    ])

-- nice keybinding to use CTRL-M as Mod key! see http://versia.com/2009/10/xmonad-metacity-gnome/
main = xmonad gnomeConfig { manageHook = myManageHook
                          , keys = addPrefix (controlMask, xK_m) (keys gnomeConfig)
			  --, startupHook = setWMName "LG3D"
			  --, logHook = takeTopFocus
                          }

addPrefix p ms conf =
    M.singleton p . submap $ M.mapKeys (first chopMod) (ms conf)
    where
    mod = modMask conf
    chopMod = (.&. complement mod)
