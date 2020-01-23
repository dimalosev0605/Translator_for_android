#ifndef TEST_WORDS_H
#define TEST_WORDS_H

#include <QObject>
#include <QDataStream>
#include <QDebug>
#include "Words_models/word.h"
#include "File_models/filemanager.h"

class Test_words: public QObject
{
    Q_OBJECT
    static const int count = 4;
    QVector<Word> words;
    QVector<Word> qstns; // 0 - is the right answer.
    Word qstn;
    int ran; // right answer number.
    QVector<bool> idxs;
    QVector<int> w_numbers;
    bool checked = false;
    bool direction = 1;
public:
    explicit Test_words(QObject* parent = nullptr);

public slots:
    bool open_file(const QString& file_name);
    void rand_generator();
    void rand_generator_2();
    QString get(int index) const;
    QString get_qstn() const;
    int get_ran() const;
    bool get_idx(int index) const;
    bool set_idx(int index);
    bool get_checked() const;
    int get_words_count() const;
    void prepare();
    void change_direction();
};

#endif // TEST_WORDS_H
