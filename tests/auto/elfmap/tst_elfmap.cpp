/****************************************************************************
**
** Copyright (C) 2017 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Milian Wolff <milian.wolff@kdab.com>
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Enterprise Perf Profiler Add-on.
**
** GNU General Public License Usage
** This file may be used under the terms of the GNU General Public License
** version 3 as published by the Free Software Foundation and appearing in
** the file LICENSE.GPLv3 included in the packaging of this file. Please
** review the following information to ensure the GNU General Public License
** requirements will be met: https://www.gnu.org/licenses/gpl.html.
**
** If you have questions regarding the use of this file, please use
** contact form at http://www.qt.io/contact-us
**
****************************************************************************/

#include <QObject>
#include <QTest>
#include <QDebug>

#include "perfelfmap.h"

class TestElfMap : public QObject
{
    Q_OBJECT
private slots:
    void testNoOverlap()
    {
        PerfElfMap map;
        QVERIFY(map.isEmpty());

        QVERIFY(!map.registerElf(100, 10, 0, 0, {}));
        QVERIFY(!map.isEmpty());

        QCOMPARE(map.constBegin().key(), 100ull);
        QCOMPARE(map.constBegin()->length, 10ull);
        QCOMPARE(map.constBegin()->timeAdded, 0ull);

        QCOMPARE(map.findElf(99, 0), map.constEnd());
        QCOMPARE(map.findElf(100, 0), map.constBegin());
        QCOMPARE(map.findElf(109, 0), map.constBegin());
        QCOMPARE(map.findElf(110, 0), map.constEnd());
        QCOMPARE(map.findElf(105, 1), map.constBegin());

        QVERIFY(!map.registerElf(0, 10, 0, 1, {}));

        QCOMPARE(map.constBegin().key(), 0ull);
        QCOMPARE(map.constBegin()->length, 10ull);
        QCOMPARE(map.constBegin()->timeAdded, 1ull);

        auto first = map.constBegin();
        auto second = first + 1;

        QCOMPARE(map.findElf(0, 0), map.constEnd());
        QCOMPARE(map.findElf(0, 1), first);
        QCOMPARE(map.findElf(5, 1), first);
        QCOMPARE(map.findElf(9, 1), first);
        QCOMPARE(map.findElf(10, 0), map.constEnd());
        QCOMPARE(map.findElf(5, 2), first);

        QCOMPARE(map.findElf(99, 0), map.constEnd());
        QCOMPARE(map.findElf(100, 0), second);
        QCOMPARE(map.findElf(109, 0), second);
        QCOMPARE(map.findElf(110, 0), map.constEnd());
        QCOMPARE(map.findElf(105, 1), second);
    }

    void testOverwrite()
    {
        QFETCH(bool, reversed);

        PerfElfMap map;
        if (!reversed) {
            QVERIFY(!map.registerElf(95, 20, 0, 0, {}));
            QVERIFY(map.registerElf(105, 20, 0, 1, {}));
            QVERIFY(map.registerElf(100, 20, 0, 2, {}));
        } else {
            QVERIFY(!map.registerElf(100, 20, 0, 2, {}));
            QVERIFY(map.registerElf(105, 20, 0, 1, {}));
            QVERIFY(map.registerElf(95, 20, 0, 0, {}));
        }

        auto first = map.findElf(110, 0);
        QCOMPARE(first.key(), 95ull);
        QCOMPARE(first->length, 20ull);
        QCOMPARE(first->pgoff, 0ull);
        QCOMPARE(first->timeAdded, 0ull);
        QCOMPARE(first->timeOverwritten, 1ull);

        auto second = map.findElf(110, 1);
        QCOMPARE(second.key(), 105ull);
        QCOMPARE(second->length, 20ull);
        QCOMPARE(second->pgoff, 0ull);
        QCOMPARE(second->timeAdded, 1ull);
        QCOMPARE(second->timeOverwritten, 2ull);

        auto third = map.findElf(110, 2);
        QCOMPARE(third.key(), 100ull);
        QCOMPARE(third->length, 20ull);
        QCOMPARE(third->pgoff, 0ull);
        QCOMPARE(third->timeAdded, 2ull);
        QCOMPARE(third->timeOverwritten, std::numeric_limits<quint64>::max());

        QCOMPARE(map.findElf(110, 3), third);

        auto fragment1 = map.findElf(97, 1);
        QCOMPARE(fragment1.key(), 95ull);
        QCOMPARE(fragment1->length, 10ull);
        QCOMPARE(fragment1->pgoff, 0ull);
        QCOMPARE(fragment1->timeAdded, 1ull);
        QCOMPARE(fragment1->timeOverwritten, 2ull);

        auto fragment2 = map.findElf(122, 2);
        QCOMPARE(fragment2.key(), 120ull);
        QCOMPARE(fragment2->length, 5ull);
        QCOMPARE(fragment2->pgoff, 15ull);
        QCOMPARE(fragment2->timeAdded, 2ull);
        QCOMPARE(fragment2->timeOverwritten, std::numeric_limits<quint64>::max());

        auto fragment3 = map.findElf(97, 2);
        QCOMPARE(fragment3.key(), 95ull);
        QCOMPARE(fragment3->length, 5ull);
        QCOMPARE(fragment3->pgoff, 0ull);
        QCOMPARE(fragment3->timeAdded, 2ull);
        QCOMPARE(fragment3->timeOverwritten, std::numeric_limits<quint64>::max());
    }

    void testOverwrite_data()
    {
        QTest::addColumn<bool>("reversed");

        QTest::newRow("normal") << false;
        QTest::newRow("reversed") << true;
    }
};

QTEST_MAIN(TestElfMap)

#include "tst_elfmap.moc"