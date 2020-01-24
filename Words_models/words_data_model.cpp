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

bool Words_data_model::get_is_save() const
{
    return is_save;
}

void Words_data_model::set_is_save(bool v)
{
    is_save = v;
    emit is_save_changed();
}

void Words_data_model::add_word(const QString &w, const QString &tr, const QString &m, const QString &syns)
{
    beginInsertRows(QModelIndex(), words.size(), words.size());
    words.push_back(Word(w, tr, m, syns));
    endInsertRows();
}

Words_data_model::~Words_data_model()
{
    if(is_save) save_words();
}

bool Words_data_model::open_file(const QString& file_name)
{
    if(!words.isEmpty()) words.clear();
    this->file_name = file_name;
    FileManager file_manager;
    QFile file(file_manager.get_file_path(file_name));
    if(file.open(QIODevice::ReadOnly)) {
        QDataStream in(&file);
        in >> words;
        file.close();
        return true;
    }
    return false;
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

int Words_data_model::find_word(const QString &word)
{
    QString s;
    curr_index = 0;
    word_occur_indexes.clear();
    if(word.isEmpty()) return 0;
    for(int i = 0; i < words.size(); ++i) {
        s = words[i].get_word() + words[i].get_syns() + words[i].get_means();
        if(s.contains(word)) {
            word_occur_indexes.push_back(i);
        }
    }
    return word_occur_indexes.size();
}

int Words_data_model::increase_word_occur_index()
{
    if(curr_index != word_occur_indexes.size() - 1) {
        ++curr_index;
    }
    return word_occur_indexes[curr_index];
}

int Words_data_model::decrease_word_occur_index()
{
    if(curr_index != 0) {
        --curr_index;
    }
    return word_occur_indexes[curr_index];
}

int Words_data_model::get_curr_index() const
{
    return curr_index + 1;
}

int Words_data_model::get_first_occurence_index()
{
    if(!word_occur_indexes.isEmpty()) {
        return word_occur_indexes[0];
    }
    return -1;
}












