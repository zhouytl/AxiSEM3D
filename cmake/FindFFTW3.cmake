# - Find the FFTW3 library (double and single precision)
#
# Usage:
#   find_package(FFTW3 [REQUIRED] [QUIET])
#
# Optional hints (any prefix containing include/fftw3.h and lib/):
#   FFTW3_DIR or FFTW3_ROOT  (-D or environment FFTW3_DIR / legacy FFTWDIR)
#
# Variables set:
#   FFTW3_FOUND
#   FFTW3_INCLUDE_DIRS
#   FFTW3_LIBRARIES

if(NOT FFTW3_ROOT)
  if(DEFINED FFTW3_DIR AND NOT "${FFTW3_DIR}" STREQUAL "")
    set(FFTW3_ROOT "${FFTW3_DIR}")
  elseif(DEFINED ENV{FFTW3_DIR} AND NOT "$ENV{FFTW3_DIR}" STREQUAL "")
    set(FFTW3_ROOT "$ENV{FFTW3_DIR}")
  elseif(DEFINED ENV{FFTWDIR} AND NOT "$ENV{FFTWDIR}" STREQUAL "")
    set(FFTW3_ROOT "$ENV{FFTWDIR}")
  endif()
endif()

find_package(PkgConfig)

if(PKG_CONFIG_FOUND AND NOT FFTW3_ROOT)
  pkg_check_modules(PKG_FFTW QUIET "fftw3")
endif()

set(CMAKE_FIND_LIBRARY_SUFFIXES_SAV ${CMAKE_FIND_LIBRARY_SUFFIXES})

if(FFTW3_USE_STATIC_LIBS)
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX})
else()
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_SHARED_LIBRARY_SUFFIX})
endif()

if(FFTW3_ROOT)
  find_library(
    FFTW3_LIB
    NAMES "fftw3"
    PATHS ${FFTW3_ROOT}
    PATH_SUFFIXES "lib" "lib64"
    NO_DEFAULT_PATH
  )

  find_library(
    FFTWF_LIB
    NAMES "fftw3f"
    PATHS ${FFTW3_ROOT}
    PATH_SUFFIXES "lib" "lib64"
    NO_DEFAULT_PATH
  )

  find_path(
    FFTW3_INCLUDE_DIR
    NAMES "fftw3.h"
    PATHS ${FFTW3_ROOT}
    PATH_SUFFIXES "include"
    NO_DEFAULT_PATH
  )

else()
  find_library(
    FFTW3_LIB
    NAMES "fftw3"
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
  )

  find_library(
    FFTWF_LIB
    NAMES "fftw3f"
    PATHS ${PKG_FFTW_LIBRARY_DIRS} ${LIB_INSTALL_DIR}
  )

  find_path(
    FFTW3_INCLUDE_DIR
    NAMES "fftw3.h"
    PATHS ${PKG_FFTW_INCLUDE_DIRS} ${INCLUDE_INSTALL_DIR}
  )

endif()

set(FFTW3_INCLUDE_DIRS "${FFTW3_INCLUDE_DIR}")
set(FFTW3_LIBRARIES ${FFTW3_LIB} ${FFTWF_LIB})

set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES_SAV})

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(FFTW3 DEFAULT_MSG
  FFTW3_INCLUDE_DIRS FFTW3_LIBRARIES
  FFTW3_LIB FFTWF_LIB)

mark_as_advanced(FFTW3_INCLUDE_DIRS FFTW3_LIBRARIES FFTW3_LIB FFTWF_LIB FFTW3_INCLUDE_DIR)
