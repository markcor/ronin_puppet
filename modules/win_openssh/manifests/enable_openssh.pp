# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_openssh::enable_openssh {

    exec { 'enable_openssh':
        command  => 'Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0',
        #unless   => 'get-service sshd',
        provider => powershell,
    }
    #service { 'sshd':
        #ensure  => running,
        #require => Exec['enable_openssh'],
    #}
}
# Bug List
# https://bugzilla.mozilla.org/show_bug.cgi?id=1527484
