find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)

# Set output directories
SET(LIBRARY_OUTPUT_PATH    ${PROJECT_SOURCE_DIR}/python/pymesh/lib)
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
MAKE_DIRECTORY(${LIBRARY_OUTPUT_PATH})
MAKE_DIRECTORY(${EXECUTABLE_OUTPUT_PATH})

# Include customized FindPackage scripts
SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

# Set PIC
SET(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Include all libraries
FIND_PACKAGE(AllDependencies)

# Options
OPTION(PYMESH_USE_CARVE      "Enable Carve support"      ${CARVE_FOUND})
OPTION(PYMESH_USE_CGAL       "Enable CGAL support"       ${CGAL_FOUND})
OPTION(PYMESH_USE_CLIPPER    "Enable Clipper support"    ${CLIPPER_FOUND})
OPTION(PYMESH_USE_CHOLMOD    "Enable Cholmod support"    ${CHOLMOD_FOUND})
OPTION(PYMESH_USE_CORK       "Enable Cork support"       ${CORK_FOUND})
OPTION(PYMESH_USE_DRACO      "Enable Draco support"      ${draco_FOUND})
OPTION(PYMESH_USE_GEOGRAM    "Enable Geogram support"    ${GEOGRAM_FOUND})
OPTION(PYMESH_USE_LIBIGL     "Enable libigl support"     ${LIBIGL_FOUND})
OPTION(PYMESH_USE_METIS      "Enable Metis support"      ${METIS_FOUND})
OPTION(PYMESH_USE_MMG        "Enable MMG support"        ${MMG_FOUND})
OPTION(PYMESH_USE_MKL        "Enable Intel MKL support"  ${MKL_FOUND})
OPTION(PYMESH_USE_QHULL      "Enable QHull support"      ${QHULL_FOUND})
OPTION(PYMESH_USE_QUARTET    "Enable Quartet support"    ${QUARTET_FOUND})
OPTION(PYMESH_USE_TETGEN     "Enable TetGen support"     ${TETGEN_FOUND})
OPTION(PYMESH_USE_TETWILD    "Enable TetWild support"    ${TETWILD_FOUND})
OPTION(PYMESH_USE_TINYXML2   "Enable TinyXML2 support"   ${TINYXML2_FOUND})
OPTION(PYMESH_USE_TRIANGLE   "Enable Triangle support"   ${TRIANGLE_FOUND})
OPTION(PYMESH_USE_UMFPACK    "Enable Umfpack support"    ${UMFPACK_FOUND})
OPTION(PYMESH_USE_SPARSEHASH "Enable SparseHash support" ${SPARSEHASH_FOUND})
OPTION(PYMESH_USE_FastWindingNumber "Enable Fast Winding Number support"
    ${FAST_WINDING_NUMBER_FOUND})
INCLUDE(GenerateDependencyTargets)

# Need support for C++14.
SET(CMAKE_CXX_STANDARD 14)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_CXX_EXTENSIONS OFF)

# Add pybind11
ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/third_party/pybind11)

## Setup RPath
SET(CMAKE_MACOSX_RPATH ON)
EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} ${PROJECT_SOURCE_DIR}/cmake/SetInstallRpath.py)
INCLUDE(SetInstallRpath)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
