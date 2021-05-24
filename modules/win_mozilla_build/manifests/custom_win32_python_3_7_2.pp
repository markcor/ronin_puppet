# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::custom_win32_python_3_7_2 (
    String $source,
    String $install_path
) {

  win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Core Interpreter (32-bit)' :
    source       => $source,
    install_path =>  $install_path,
    pkg          =>  'core',
  }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Core Interpreter (32-bit debug)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'core_d',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Core Interpreter (32-bit symbols)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'core_pdb',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Development Libraries (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'dev',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Development Libraries (32-bit debug)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'dev_d',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Documentation (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'doc',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Executables (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'exe',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Executables (32-bit debug)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'exe_d',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Executables (32-bit symbols)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'exe_pdb',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python Launcher' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'launcher',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Standard Library (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'lib',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Standard Library (32-bit debug)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'lib_d',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Standard Library (32-bit symbols)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'lib_pdb',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Add to Path (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'path',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 pip Bootstrap (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'pip',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Tcl/Tk Support (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'tcltk',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Tcl/Tk Support (32-bit debug)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'tcltk_d',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Tcl/Tk Support (32-bit symbols)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'tcltk_pdb',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Test Suite (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'test',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Test Suite (32-bit debug)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'test_d',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Test Suite (32-bit symbols)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'test_pdb',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 Utility Scripts (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'tools',
    }
    win_mozilla_build::win32_python_3_7_2_component { 'Python 3.7.3 C Runtime Library (32-bit)' :
        source       => $source,
        install_path => $install_path,
        pkg          =>  'ucrt',
    }
}
