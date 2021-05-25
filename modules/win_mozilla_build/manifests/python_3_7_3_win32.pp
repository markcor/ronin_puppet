# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::python_3_7_3_win32 {

    win_packages::win_zip_pkg { 'python_3_7_3_win32':
        pkg         => 'python-3.7.3-embed-win32.zip',
        creates     => "${facts['custom_win_systemdrive']}\\mozilla-build\\fake",
        destination => "${facts['custom_win_systemdrive']}\\mozilla-build\\python3",
    }
}
