#include "filemanager.h"

const QString user_files_dir = "user_files";
const QString user_settings_dir = "user_settings";
const QString abk_extension = ".abk";
const QString auth_file = "auth_file";
const QString search_history = "search_history";

FileManager::FileManager()
{
    create_user_files_dir();
    create_user_settings_dir();
}

void FileManager::create_user_files_dir()
{
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::DataLocation) + QString(""));
    if(!dir.exists(user_files_dir)) {
        dir.mkdir(user_files_dir);
    }
}

void FileManager::create_user_settings_dir()
{
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::DataLocation) + QString(""));
    if(!dir.exists(user_settings_dir)) {
        dir.mkdir(user_settings_dir);
    }
}

bool FileManager::delete_file(const QString& file_name)
{
    QFile file(this->get_file_path(file_name));
    if(file.remove())
        return true;
    return false;
}

QString FileManager::get_file_path(const QString& file_name)
{
    return QStandardPaths::writableLocation(QStandardPaths::DataLocation) + '/' + user_files_dir + '/' + file_name + abk_extension;
}

QString FileManager::get_user_files_dir()
{
    return QStandardPaths::writableLocation(QStandardPaths::DataLocation) + '/' + user_files_dir;
}

QString FileManager::get_auth_file_path()
{
    return QStandardPaths::writableLocation(QStandardPaths::DataLocation) + '/' + user_settings_dir + '/' + auth_file + abk_extension;
}

QString FileManager::get_search_history_file_path()
{
    return QStandardPaths::writableLocation(QStandardPaths::DataLocation) + '/' + user_settings_dir + '/' + search_history + abk_extension;
}

QList<QFileInfo> FileManager::retrieve_user_files()
{
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::DataLocation) + '/' + user_files_dir);
    dir.setNameFilters(QStringList{'*' + abk_extension});
    dir.setSorting(QDir::SortFlag::Time);
    auto list = dir.entryInfoList();
    return list;
}

bool FileManager::create_file(const QString &file_name)
{
    QFile file(get_file_path(file_name));
    if(file.exists()) return false;
    if(file.open(QIODevice::ReadWrite)) {
        return true;
    }
    else {
        return false;
    }
}














