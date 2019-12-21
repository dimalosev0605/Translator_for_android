#ifndef TEST_WORDS_H
#define TEST_WORDS_H

#include <QObject>
#include <QDataStream>
#include <QDebug>
#include "word.h"
#include "filemanager.h"

class Test_words: public QObject
{
    Q_OBJECT
    static const int count = 4;
    QVector<Word> words;
    QVector<Word> qstns; // 0 - is the right answer.
    Word qstn;
    int ran; // right answer number.
public:
    explicit Test_words(QObject* parent = nullptr);

public slots:
    bool open_file(const QString& file_name);
    void rand_generator();
    QString get(int index) const;
    QString get_qstn() const;
    int get_ran() const;
};

#endif // TEST_WORDS_H
