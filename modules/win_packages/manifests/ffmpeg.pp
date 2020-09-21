# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_packages::ffmpeg (
    String $version
) {

    $ffmpeg_dir = "${facts['custom_win_systemdrive']}\\ffmpeg"
    $ffmpeg_bin = "${ffmpeg_dir}\\bin"

    win_packages::win_zip_pkg { "ffmpeg-${version}":
        pkg         => "ffmpeg-${version}.zip",
        creates     => "${ffmpeg_bin}\\ffmpeg.exe",
        destination => $ffmpeg_dir,
    }
    # Resource from counsyl-windows
    windows::path { $ffmpeg_bin: }
}
