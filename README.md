
pkexec reboot (Sailfish edition)
================================

(Sailfish edition as it is now known if this works elsewhere
(also at least this works for me :))

The *reboot* button in QML UI executes `reboot(1)` command
via `pkexec(1)`; The PolicyKit tool `pkexec` makes device to
ask security code to be entered for confirmation. With correct
code `reboot` as super user (root) is executed.

For completeness, *poweroff* button is provided. The use of
system power button may be more user friendly, though.

(I'd be happy if this program gets obsoleted
 by system-provided reboot functionality)


Install
-------

Easiest is to install *.rpm* from public repositories.
If not available or such is considered as a security
risk (installer did things before one had chance to
examine installed content), *.rpm* can be self-built
using the .spec file provided. I am not sure what is
the proper way, so I just use `./devdev.sh rpmbuild`
to do it.


Code
----

This is single-file qml application. Embedded python evaluation
(via pyotherside) is used to execute system commands. Quite a
few hours was used to trial&error the final *.qml* file

Launcher icon (power button) was crated using povray. The button
is actually plate (which had key) which I originally did for
pwpingen. As it looks like button I spent little more time to
get the shutdown/reboot lines drawn on top of it.
