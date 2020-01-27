#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Yandex_translator/blocks_data_model.h"
#include "File_models/localfilesdatamodel.h"
#include "File_models/remotefilesdatamodel.h"
#include "Words_models/words_data_model.h"
#include "Server_connection/settings.h"
#include "Server_connection/client.h"
#include "User_testing/test_words.h"
#include "Words_models/search_history_data_model.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Blocks_data_model>("Blocks_data_model_qml", 1, 0, "Blocks_data_model");
    qmlRegisterType<LocalFilesDataModel>("LocalFilesDataModel_qml", 1, 0, "LocalFilesDataModel");
    qmlRegisterType<RemoteFilesDataModel>("RemoteFilesDataModel_qml", 1, 0, "RemoteFilesDataModel");
    qmlRegisterType<Words_data_model>("Words_data_model_qml", 1, 0, "Words_data_model");
    qmlRegisterType<Settings>("Settings_qml", 1, 0, "Settings");
    qmlRegisterType<Client>("Client_qml", 1, 0, "Client");
    qmlRegisterType<Test_words>("Test_words_qml", 1, 0, "Test_words");
    qmlRegisterType<Search_history_data_model>("Search_history_data_model_qml", 1, 0, "Search_history_data_model");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml_files/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
