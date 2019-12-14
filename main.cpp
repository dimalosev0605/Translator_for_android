#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "blocks_data_model.h"
#include "localfilesdatamodel.h"
#include "words_data_model.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Blocks_data_model>("Blocks_data_model_qml", 1, 0, "Blocks_data_model");
    qmlRegisterType<LocalFilesDataModel>("LocalFilesDataModel_qml", 1, 0, "LocalFilesDataModel");
    qmlRegisterType<Words_data_model>("Words_data_model_qml", 1, 0, "Words_data_model");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}