# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::custom_win32_python_3_7_2 (
    String $source,
    String $install_path
) {

  win_mozilla_build::win32_python_3_7_2_component { 'python_3_7_3_win32_core' :
    source       => $source,
    install_path =>  $install_path,
    pkg          =>  'core',
  }
    win_mozilla_build::win32_python_3_7_2_component { 'python_3_7_3_win32_core_d' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'core_d',
    }
}
