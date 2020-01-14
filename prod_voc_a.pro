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
    blocks_data_model.cpp \
    block.cpp \
    yandex_api_connection.cpp \
    yandex_api_parser.cpp \
    words_data_model.cpp \
    word.cpp \
    basefilesdatamodel.cpp \
    filemanager.cpp \
    settings.cpp \
    client.cpp \
    localfilesdatamodel.cpp \
    jsonhelper.cpp \
    remotefilesdatamodel.cpp \
    test_words.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
    blocks_data_model.h \
    block.h \
    yandex_api_connection.h \
    yandex_api_parser.h \
    words_data_model.h \
    word.h \
    basefilesdatamodel.h \
    filemanager.h \
    settings.h \
    client.h \
    jsonhelper.h \
    localfilesdatamodel.h \
    remotefilesdatamodel.h \
    test_words.h

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        C:/Users/dimal/Documents/prod_voc_a/../../Desktop/dll/android_ssl_2/libcrypto.so \
        C:/Users/dimal/Documents/prod_voc_a/../../Desktop/dll/android_ssl_2/libssl.so \
        $$PWD/../../Desktop/dll/android_ssl/libcrypto.so \
        $$PWD/../../Desktop/dll/android_ssl/libssl.so
}
