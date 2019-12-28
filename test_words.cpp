#include "test_words.h"

Test_words::Test_words(QObject *parent)
    : QObject (parent)
{
}

bool Test_words::open_file(const QString &file_name)
{
    FileManager file_manager;
    QFile file(file_manager.get_file_path(file_name));
    if(file.open(QIODevice::ReadOnly)) {
        words.clear();
        idxs.clear();
        w_numbers.clear();
        checked = false;
        QDataStream in(&file);
        in >> words;
        for(int i = 0; i < words.size(); ++i) {
            idxs.push_back(false);
        }
        file.close();
        return true;
    }
    return false;
}

QString Test_words::get_qstn() const
{
    return qstn.get_syns();
}

int Test_words::get_ran() const
{
    return ran;
}

bool Test_words::get_idx(int index) const
{
    return idxs[index];
}

void Test_words::set_idx(int index)
{
    if(idxs[index]) {
        idxs[index] = false;
        checked = false;
    }
    else {
        checked = true;
        idxs[index] = true;
    }
}

bool Test_words::get_checked() const
{
    return checked;
}

void Test_words::prepare()
{
    w_numbers.clear();
    for(int i = 0; i < idxs.size(); ++i) {
        if(idxs[i]) w_numbers.push_back(i);
    }
}

QString Test_words::get(int index) const
{
    return qstns[index].get_word() + '\n' + qstns[index].get_transcription();
}

void Test_words::rand_generator()
{
    qstns.clear();
    srand(time(0));
    QVector<int> arr;
    for(int i = 0; i < count; ++i)
    {
        int n = rand() % words.size();
        if(arr.contains(n)) {
            --i;
            continue;
        }
        arr.push_back(n);
        qstns.push_back(words[n]);
    }
    ran = rand() % count;
    qstn = qstns[ran];
}

void Test_words::rand_generator_2()
{
    qstns.clear();
    QVector<int> arr;
    srand(time(0));
    for(int i = 0; i < count; ++i) {
        int n = rand() % w_numbers.size();
        if(arr.contains(n)) {
            --i;
            continue;
        }
        arr.push_back(n);
        qstns.push_back(words[w_numbers[n]]);
    }
    ran = rand() % count;
    qstn = qstns[ran];
}














