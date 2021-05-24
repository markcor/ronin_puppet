# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

define win_mozilla_build::win32_python_3_7_3_component (
    String $source,
    String $install_path,
    String $pkg,
    String $display_name=$title
) {

$pkgdir = $facts['custom_win_temp_dir']



    file { "${$pkgdir}\\${pkg}.msi" :
        source => "${source}/${pkg}.msi",
    }
    package { $display_name :
        ensure          => installed,
        source          => "${pkgdir}\\${pkg}.msi",
        install_options => ['InstallAllUsers=1', "TargetDir=${install_path}" ],
        require         => File["${pkgdir}\\${pkg}.msi"],
    }
}
