#ifndef LOCALFILESDATAMODEL_H
#define LOCALFILESDATAMODEL_H

#include "basefilesdatamodel.h"
#include "filemanager.h"

class LocalFilesDataModel: public BaseFilesDataModel
{
    Q_OBJECT
    void retrieve_user_files();

public:
    explicit LocalFilesDataModel(QObject* parent = nullptr);

public slots:
    void delete_file(int index);
    void update_data();
    bool create_file(const QString& file_name);
};

#endif // LOCALFILESDATAMODEL_H
