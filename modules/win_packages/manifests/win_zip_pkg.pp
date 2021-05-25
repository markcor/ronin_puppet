# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

define win_packages::win_zip_pkg (
    String $pkg,
    String $destination,
    String $creates,
    String $package=$title
){

    require win_packages::sevenzip

    $pkgdir      = $facts['custom_win_temp_dir']
    $srcloc      = lookup('windows.s3.ext_pkg_src')
    $source      = "\"${pkgdir}\\${pkg}\""
    $program_files  = $facts['os']['architecture'] ? {
        'x64'   => $facts['custom_win_programfiles'],
        default => $facts['custom_win_programfilesx86'],
    }
    $seven_zip   = "\"${program_files}\\7-Zip\\7z.exe\""



    file { "${pkgdir}\\${pkg}":
        source => "${srcloc}/${pkg}",
    }
    file { $destination:
        ensure => directory,
    }
    # Unzip resources from Forge will fail when Puppet is ran
    # as system  in a schedule task. This is because of the context
    # powershell is ran in.
    exec { $pkg:
        command => "${seven_zip} x ${source} -o${destination} -y",
        creates => $creates,
    }

}

# Bug list
# https://bugzilla.mozilla.org/show_bug.cgi?id=1520038
