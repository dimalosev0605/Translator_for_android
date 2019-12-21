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
        QDataStream in(&file);
        in >> words;
        file.close();
        rand_generator();
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

QString Test_words::get(int index) const
{
    return qstns[index].get_word() + '\n' + qstns[index].get_transcription();
}

void Test_words::rand_generator()
{
    qstns.clear();
    srand(time(0));
    qDebug() << "size = " << words.size();
    for(int i = 0; i < count; ++i)
    {
        int n = rand() % words.size();
        qDebug() << "n = " << n << "; i = " << i;
        qstns.push_back(words[n]);
    }
    ran = rand() % count;
    qstn = qstns[ran];
}

















