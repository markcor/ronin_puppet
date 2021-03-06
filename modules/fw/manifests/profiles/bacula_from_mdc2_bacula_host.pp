# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class fw::profiles::bacula_from_mdc2_bacula_host {
    include fw::networks

    fw::rules { 'allow_infra_bacula_mdc2':
        sources =>  $::fw::networks::infra_bacula_mdc2,
        app     => 'bacula'
    }
}
