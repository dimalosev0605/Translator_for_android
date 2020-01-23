QT += quick
QT += svg
QT += network
CONFIG += c++11


# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    Yandex_translator/blocks_data_model.cpp \
    Yandex_translator/block.cpp \
    Yandex_translator/yandex_api_connection.cpp \
    Yandex_translator/yandex_api_parser.cpp \
    Words_models/words_data_model.cpp \
    Words_models/word.cpp \
    File_models/basefilesdatamodel.cpp \
    File_models/filemanager.cpp \
    Server_connection/settings.cpp \
    Server_connection/client.cpp \
    File_models/localfilesdatamodel.cpp \
    Server_connection/jsonhelper.cpp \
    File_models/remotefilesdatamodel.cpp \
    test_words.cpp \
    Words_models/search_history_data_model.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

HEADERS += \
    Yandex_translator/blocks_data_model.h \
    Yandex_translator/block.h \
    Yandex_translator/yandex_api_connection.h \
    Yandex_translator/yandex_api_parser.h \
    Words_models/words_data_model.h \
    Words_models/word.h \
    File_models/basefilesdatamodel.h \
    File_models/filemanager.h \
    Server_connection/settings.h \
    Server_connection/client.h \
    Server_connection/jsonhelper.h \
    File_models/localfilesdatamodel.h \
    File_models/remotefilesdatamodel.h \
    test_words.h \
    Words_models/search_history_data_model.h

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        C:/Users/dimal/Documents/prod_voc_a/../../Desktop/dll/android_ssl_2/libcrypto.so \
        C:/Users/dimal/Documents/prod_voc_a/../../Desktop/dll/android_ssl_2/libssl.so \
        $$PWD/../../Desktop/dll/android_ssl/libcrypto.so \
        $$PWD/../../Desktop/dll/android_ssl/libssl.so
}

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
