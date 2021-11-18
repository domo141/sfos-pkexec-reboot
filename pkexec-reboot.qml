// -*- css -*-

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.2 // for executing process

// SPDX-License-Identifier: BSD 2-Clause "Simplified" License

ApplicationWindow {
    cover: Component {
        CoverBackground {
            Label {
                anchors.centerIn: parent
                text: "reboot\n\npoweroff"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    initialPage: Component {
        Page {
            id: page
            MouseArea {
                width: page.width
                anchors.top: page.top
                anchors.bottom: bl.top
                anchors.bottomMargin: page.height / 24 & ~1
                onClicked: Qt.quit()
            }
            ButtonLayout {
                id: bl
                rowSpacing: page.height / 12 & ~1
                anchors.centerIn: parent
                preferredWidth: Theme.buttonWidthLarge
                Button {
                    text: "<b>reboot</b>"
                    implicitHeight: page.height / 6 & ~1
                    onClicked: pkexec.reboot()
                }
                Button {
                    text: "<b>poweroff</b>"
                    implicitHeight: page.height / 6 & ~1
                    onClicked: pkexec.poweroff()
                }
            }
            MouseArea {
                width: page.width
                anchors.topMargin: page.height / 24 & ~1
                anchors.top: bl.bottom
                anchors.bottom: page.bottom
                onClicked: Qt.quit()
            }
            Python {
                id: pkexec
                Component.onCompleted: { importModule_sync("os") }
                function reboot() {
                    evaluate("
os.spawnl(os.P_NOWAIT, '/usr/bin/pkexec', 'pkexec', '/usr/sbin/reboot')")
                }
                function poweroff() {
                    evaluate("
os.spawnl(os.P_NOWAIT, '/usr/bin/pkexec', 'pkexec', '/usr/sbin/poweroff')")
                }
            }
        }
    }
}
