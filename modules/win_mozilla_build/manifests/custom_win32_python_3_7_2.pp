# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::custom_win32_python_3_7_2 (
    String $source,
    String $install_path
) {

  win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Development Libraries (32-bit)' :
    source       => $source,
    install_path =>  $install_path,
    pkg          =>  'core',
  }
}
