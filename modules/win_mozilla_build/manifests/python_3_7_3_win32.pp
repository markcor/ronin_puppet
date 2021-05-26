# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::python_3_7_3_win32 {

    $py3_dir = "${facts['custom_win_systemdrive']}\\mozilla-build\\python3"
    $python_exe = "${py3_dir}\\python.exe"

    #win_packages::win_zip_pkg { 'python_3_7_3_win32':
    #   pkg         => 'python-3.7.3-embed-win32.zip',
    #  creates     => $python_exe,
    # destination => $py3_dir,
    #}
    #exec { 'copy_python3_exe':
    #   command  => "Copy-Item ${python_exe} -Destination  ${py3_dir}\\python3.exe",
    #   provider => powershell,
    #   creates  => "${py3_dir}\\python3.exe",
    #}

    #exec { 'install_py3_pip':
    #   command => "${py3_dir}\\python3.exe get-pip.py"
    #}
    win_packages::win_exe_pkg  { 'python-3.7.3':
        pkg                    => 'python-3.7.3.exe',
        install_options_string => "/quiet /repair InstallAllUsers=1 TargetDir=${py3_dir}",
        creates                => $python_exe,
    }
    exec { 'copy_python3_exe':
        command  => "Copy-Item ${python_exe} -Destination  ${py3_dir}\\python3.exe",
        provider => powershell,
        creates  => "${py3_dir}\\python3.exe",
    }
}
