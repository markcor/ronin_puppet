# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_packages::imagemagick (
    String $version
) {

    win_packages::win_exe_pkg {'imagemagick':
        pkg                    => "ImageMagick-${version}.exe",
        install_options_string => '/VERYSILENT',
        creates                => "${facts['custom_win_programfiles']}\\ImageMagick-${version}\\magick.exe",
    }
}
