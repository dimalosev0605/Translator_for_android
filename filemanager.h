#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QFile>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include <QDateTime>

class FileManager
{
public:
    explicit FileManager();
    void create_user_files_dir();
    void create_user_settings_dir();
    bool delete_file(const QString& file_name);
    QString get_file_path(const QString& file_name);
    QString get_user_files_dir();
    QString get_auth_file_path();
    QString get_search_history_file_path();
    QList<QFileInfo> retrieve_user_files();
    bool create_file(const QString& file_name);
};

#endif // FILEMANAGER_H
