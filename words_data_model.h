#ifndef WORDS_DATA_MODEL_H
#define WORDS_DATA_MODEL_H

#include <QAbstractListModel>
#include <QDebug>
#include <QVector>
#include <QDataStream>
#include "word.h"
#include "filemanager.h"

class Words_data_model: public QAbstractListModel
{
    Q_OBJECT

    enum class Role_names {
        word = Qt::UserRole,
        transcription = Qt::UserRole + 1,
        means = Qt::UserRole + 2,
        syns = Qt::UserRole + 3,
        date = Qt::UserRole + 4
    };
    QHash<int, QByteArray> m_role_names;
    QHash<int, QByteArray> roleNames() const override;
    QVector <Word> words;
    QString file_name;

private:
    void save_words();

public:
    explicit Words_data_model(QObject* parent = nullptr);
    ~Words_data_model() override;
    virtual int rowCount(const QModelIndex &index = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex& index, int role) const override;

public slots:
    void add_word(const QString& w, const QString& tr, const QString& m, const QString& syns);
    void set_file_name(const QString& name);
    void open_file();
    void remove_word(int index);
    bool save_words_and_clear_internal_padding();
};

#endif // WORDS_DATA_MODEL_H
