#include "words_data_model.h"

Words_data_model::Words_data_model(QObject *parent)
    : QAbstractListModel (parent)
{
    m_role_names[static_cast<int>(Role_names::word)] = "word";
    m_role_names[static_cast<int>(Role_names::transcription)] = "transcription";
    m_role_names[static_cast<int>(Role_names::means)] = "means";
    m_role_names[static_cast<int>(Role_names::syns)] = "syns";
    m_role_names[static_cast<int>(Role_names::date)] = "date";
}

QHash<int, QByteArray> Words_data_model::roleNames() const
{
    return m_role_names;
}

void Words_data_model::save_words()
{
    if(file_name.isEmpty()) return;
    FileManager file_manager;
    QFile file(file_manager.get_file_path(file_name));
    if(file.open(QIODevice::WriteOnly)) {
        QDataStream out(&file);
        out << words;
        words.clear();
        file_name.clear();
        file.close();
    }
}

int Words_data_model::rowCount(const QModelIndex &index) const
{
    Q_UNUSED(index);
    return words.size();
}

QVariant Words_data_model::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= words.size()) return QVariant();

    switch(role)
    {
    case static_cast<int>(Role_names::word):
        return words[row].get_word();

    case static_cast<int>(Role_names::transcription):
        return words[row].get_transcription();

    case static_cast<int>(Role_names::means):
        return words[row].get_means();

    case static_cast<int>(Role_names::syns):
        return words[row].get_syns();

    case static_cast<int>(Role_names::date):
        return words[row].get_date().toString("d.MM.yy");

    }

    return QVariant();
}

void Words_data_model::add_word(const QString &w, const QString &tr, const QString &m, const QString &syns)
{
    beginInsertRows(QModelIndex(), words.size(), words.size());
    words.push_back(Word(w, tr, m, syns));
    endInsertRows();
}

void Words_data_model::set_file_name(const QString &name)
{
    file_name = name;
}


Words_data_model::~Words_data_model()
{
    save_words();
}

void Words_data_model::open_file()
{
    FileManager file_manager;
    QFile file(file_manager.get_file_path(file_name));
    if(file.open(QIODevice::ReadOnly)) {
        QDataStream in(&file);
        QVector<Word> temp;
        in >> temp;
        if(temp.isEmpty()) return;
        file.close();

        beginInsertRows(QModelIndex(), words.size(), words.size() + temp.size() - 1);
        words.reserve(words.size() + temp.size() + 50); // I estimate average user input per session in 50.
        std::move(temp.begin(), temp.end(), std::back_inserter(words));
        endInsertRows();
    }
}

void Words_data_model::remove_word(int index)
{
    if(index < 0 || index >= words.size()) return;

    beginRemoveRows(QModelIndex(), index, index);
    words.removeAt(index);
    endRemoveRows();
}

bool Words_data_model::save_words_and_clear_internal_padding()
{
    save_words();
    if(words.isEmpty()) return true;
    return false;
}












