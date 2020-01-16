#ifndef SEARCH_HISTORY_DATA_MODEL_H
#define SEARCH_HISTORY_DATA_MODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QDataStream>
#include "word.h"
#include "filemanager.h"

class Search_history_data_model: public QAbstractListModel
{
    Q_OBJECT
    enum class Role_names {
        word = Qt::UserRole,
        transcription = Qt::UserRole + 1,
        most_popular_syn = Qt::UserRole + 2,
        date = Qt::UserRole + 3
    };
    QHash<int, QByteArray> m_role_names;
    QHash<int, QByteArray> roleNames() const override;
    QList<Word> words_history;

    void save_history_in_external_memory();
    void load_history_from_external_memory();

public:
    explicit Search_history_data_model(QObject* parent = nullptr);
    virtual int rowCount(const QModelIndex &index = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex& index, int role) const override;
    virtual ~Search_history_data_model() override; // ???

public slots:
    void push_front(const QString& w, const QString& transcription, const QString& mean);
    void remove(int index);
    QString get_word_from_history(int index);
};

#endif // SEARCH_HISTORY_DATA_MODEL_H
