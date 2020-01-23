#include "search_history_data_model.h"

Search_history_data_model::Search_history_data_model(QObject *parent)
    : QAbstractListModel (parent)
{
    m_role_names[static_cast<int>(Role_names::word)] = "word";
    m_role_names[static_cast<int>(Role_names::transcription)] = "transcription";
    m_role_names[static_cast<int>(Role_names::most_popular_syn)] = "most_popular_syn";
    m_role_names[static_cast<int>(Role_names::date)] = "date";
    load_history_from_external_memory();
}

QHash<int, QByteArray> Search_history_data_model::roleNames() const
{
    return m_role_names;
}

void Search_history_data_model::save_history_in_external_memory()
{
    FileManager file_manager;
    QFile file(file_manager.get_search_history_file_path());
    if(file.open(QIODevice::WriteOnly)) {
        QDataStream out(&file);
        out << words_history;
        file.close();
    }
}

void Search_history_data_model::load_history_from_external_memory()
{
    FileManager file_manager;
    QFile file(file_manager.get_search_history_file_path());
    if(file.open(QIODevice::ReadOnly)) {
        QDataStream in(&file);
        QList<Word> temp;
        in >> temp;
        if(temp.isEmpty()) return;
        file.close();

//        beginInsertRows(QModelIndex(), words_history.size(), words_history.size() + temp.size() - 1);
        std::move(temp.begin(), temp.end(), std::back_inserter(words_history));
//        endInsertRows();
    }
}

int Search_history_data_model::rowCount(const QModelIndex &index) const
{
    Q_UNUSED(index);
    return words_history.size();
}

QVariant Search_history_data_model::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= words_history.size()) return QVariant();

    switch(role)
    {
    case static_cast<int>(Role_names::word):
        return words_history[row].get_word();

    case static_cast<int>(Role_names::transcription):
        return words_history[row].get_transcription();

    case static_cast<int>(Role_names::most_popular_syn):
        return words_history[row].get_means();

    case static_cast<int>(Role_names::date):
        return words_history[row].get_date().toString("d.MM.yy");

    }

    return QVariant();
}

Search_history_data_model::~Search_history_data_model()
{
    save_history_in_external_memory();
}

void Search_history_data_model::push_front(const QString &w, const QString &transcription, const QString &mean)
{
//    qDebug() << "###############\n";
//    qDebug() << w;
//    qDebug() << transcription;
//    qDebug() << mean;
//    qDebug() << "###############\n";
//    beginInsertRows(QModelIndex(), 0, 0);
    if(w.isEmpty()) return;
    words_history.push_front(Word(w, transcription, mean, QString()));
//    endInsertRows();
}

void Search_history_data_model::remove(int index)
{
    if(index < 0 || index >= words_history.size()) return;

    beginRemoveRows(QModelIndex(), index, index);
    words_history.removeAt(index);
    endRemoveRows();
}

QString Search_history_data_model::get_word_from_history(int index)
{
    if(index < 0 || index >= words_history.size()) return QString();
    Word temp = Word(words_history[index].get_word(), words_history[index].get_transcription(),
                     words_history[index].get_means(), words_history[index].get_syns());
    beginRemoveRows(QModelIndex(), index, index);
    words_history.removeAt(index);
    endRemoveRows();
    words_history.push_front(temp);
    return temp.get_word();
}
