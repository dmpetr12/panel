cmake_minimum_required(VERSION 3.16)

project(panel VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(apppanel
    main.cpp
    line.h linesmodel.h logger.h
    systemObjects.h testcontroller.h TimeAjst.h ValueProvider.h
    schedulemanager.h PasswordManager.h
    schedulemanager.cpp logger.cpp
)

qt_add_qml_module(apppanel
    URI panel
    VERSION 1.0
    RESOURCE_PREFIX "/"
    NO_RESOURCE_TARGET_PATH
    QML_FILES
        main.qml LineItem.qml
        pageAjaste.qml pageAjasteSystem.qml pageAjasteTime.qml
        pageInfo.qml pageLineEdit.qml pagePass.qml pagePassCh.qml
        pagereserv.qml pageStart.qml pageTest.qml pageTestEx.qml password.qml
        TestSettingsPage.qml SchedulePage.qml
        RESOURCES Back.png
        RESOURCES logo.png
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apppanel PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apppanel
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apppanel
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS apppanel
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
