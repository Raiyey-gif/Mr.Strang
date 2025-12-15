cmake_minimum_required(VERSION 3.16)

project(MrStrang_app VERSION 0.1 LANGUAGES CXX)

# --------------------
# C++ Standard
# --------------------
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --------------------
# Qt
# --------------------
find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml VirtualKeyboard)

qt_standard_project_setup(REQUIRES 6.8)

# --------------------
# Executable
# --------------------
qt_add_executable(appMrStrang_app
    main.cpp
    src/mockai.h
    src/mockai.cpp
    src/authmanager.h
    src/authmanager.cpp
    src/spotifycontroller.h
    src/spotifycontroller.cpp
    src/chatmessage.h
    src/chatmessage.cpp
    src/chatmanager.h
    src/chatmanager.cpp
)

# --------------------
# QML Module
# --------------------
qt_add_qml_module(appMrStrang_app
    URI MrStrang_app
    VERSION 1.0
    QML_FILES
        AppWindow.qml
        Landing.qml
        Login.qml
        SignIn.qml
        Main.qml
        ToolsPanel.qml
        PomodoroTimer.qml
        SpotifyMini.qml
        Background1.qml
        KeyboardChoice.qml
        ModeChoice.qml
    )


# --------------------
# Target Properties
# --------------------
set_target_properties(appMrStrang_app PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.mrstrang
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING
        ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# --------------------
# Linking
# --------------------
target_link_libraries(appMrStrang_app
    PRIVATE Qt6::Core Qt::Quick Qt6::Qml Qt6::VirtualKeyboard
)

# --------------------
# Install
# --------------------
include(GNUInstallDirs)
install(TARGETS appMrStrang_app
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
