Генератор оттисков поверительных и калибровочных клейм
======================================================

[![Build status](https://ci.appveyor.com/api/projects/status/github/Metrolog/marks?branch=master&svg=true)](https://ci.appveyor.com/project/sergey-s-betke/marks/branch/master)
[![Build status](https://circleci.com/gh/Metrolog/marks/tree/master.svg?&style=shield&circle-token=7e53954cd6f7704d6897c3f8b21502e6d0e920d7)](https://circleci.com/gh/Metrolog/marks)

[![GitHub release](https://img.shields.io/github/release/Metrolog/marks.svg)](https://github.com/Metrolog/marks/releases)

[![Присоединиться к обсуждению на https://gitter.im/Metrolog/marks](https://badges.gitter.im/Metrolog/marks.svg)](https://gitter.im/Metrolog/marks?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Данный проект - библиотека [PostScript][] функций и примеры сценариев для генерациии
цифрового негатива для производства полимерных клише для поверительных и
калибровочных клейм.

Подготовка среды
----------------

Для внесения изменений в пакет и повторной сборки проекта потребуются следующие продукты:

- [CygWin][]
- [CygWin make][]
- [GhostScript][]
- текстовый редактор, рекомендую [Notepad++][]

Существенно удобнее будет работать с репозиторием, имея установленный `git`.
Если работа с `git` в командной строке вызывает сложности, рекомендую установить
[SourceTree][].

Далее следует скопировать репозиторий проекта либо как zip архив из [последнего
релиза](https://github.com/Metrolog/marks/releases), либо клонировав git репозиторий.
Последнее - предпочтительнее.

Для подготовки среды (установки необходимых приложений)
следует воспользоваться сценарием `install.ps1` (запускать от имени администратора):

    install\install.ps1 -Scope Machine -GUI -Verbose

либо

    install\install.cmd

Указанный сценарий установит все необходимые компоненты.

Для интерактивного контроля процесса установки можно использовать параметр `-Confirm`:

    install\install.ps1 -Scope Machine -GUI -Verbose -Confirm

Указанный параметр вынуждает сценарий перед внесением любых изменений запрашивать
подтверждение у пользователя.

Для дальнейшей работы необходимо включить в переменную `PATH`
каталоги с исполняемыми файлами установленных средств.
Если Вы работаете не под учётной записью администратора, тогда Вам так же
потребуется выполнить `install.ps1` для изменения переменной окружения `PATH` для
Вашей учётной записи:

    install\install.ps1 -Scope User -Verbose

либо

    install\install_for_user.cmd

Сборка проекта
--------------

Сборка проекта осуществляется следующим образом:

    make

либо

    make all

Внесение изменений
------------------

Репозиторий проекта размещён по адресу [github.com/Metrolog/marks](https://github.com/Metrolog/marks).
Стратегия ветвления - [GitHub Flow](http://githubflow.github.io/). В качестве GUI
к локальному репозиторию рекомендую
[SourceTree](https://www.sourcetreeapp.com/).

Для внесения изменений в проект подготовьте собственный fork проекта, в соответствии
с GitHub Flow добавляйте свои файлы в ветку master.
При необходимости внесения изменений в сам проект предложите Pull Request в основной
репозиторий.

Файл заказа с оттисками клейм
-----------------------------

Собственно [PostScript файл](sources/stamps/test.ps) должен быть сохранён в кодировке Windows-1251.

Для подготовки файла с оттисками клейм для фотовывода
[файл test.ps](sources/stamps/test.ps) следует скопировать в ту же папку
и внести изменения в область, отмеченную комментариями:

    %------------------------------------------------------------------------------
    % для подготовки оттисков править код ниже !!!
    %------------------------------------------------------------------------------
      [
          2017
          [ [ 3 ] quarters ]
          (СП)
          [ 1 256 range ]
          18.0 mm
          /verification_stamp_upath
        create_stamps
          2017
          [ [ 1 12  range ] months  [ 1 4 range ] quarters year ]
          (СП)
          [ 1 ]
          18.0 mm
          /calibration_stamp_upath
        create_stamps
      ]
      GetPageBBox
      2 mm
    draw_stamps
    %------------------------------------------------------------------------------
    % конец области для кода генерации оттисков
    %------------------------------------------------------------------------------

Выше приведён пример, генерирующий поверительные клейма
на 3ий квартал 2017 года, с шифром поверительного клейма "СП",
диаметром 18 мм, для индивидуальных знаков поверителя от 1 до 256.
А так же - квадратные калибровочные клейма
на все месяцы, кварталы и год 2017 года, с шифром клейма "СП",
размером 18 мм, для индивидуального знака поверителя с номером 1.

Во втором аргументе функции `create_stamps` должен быть указан
массив, определяющий периоды года, для которых будут сформированы
оттиски клейм.

Если требуется только годовое клеймо, укажите:

    [ year ]

Для конкретного квартала:

    [ [ 3 ] quarters ]

Для нескольких кварталов:

    [ [ 1 2 3 ] quarters ]

Либо то же самое, но - диапазоном:

    [ [ 1 3 range ] quarters ]

Аналогично для месяцев:

    [ [ 1 ] months ]
    [ [ 1 2 3  7 8 9 10 11 12 ] months ]
    [ [ 1 3 range 7 12 range ] months ]

А теперь - для месяцев, кварталов и года вместе:

    [ [ 1 12  range ] months  [ 1 4 range ] quarters year ]

4ый аргумент - массив номеров индивидуального знака.
Так же, либо перечисляем номера:

    [ 1 2 3 4 5 6 7 10 256 ]

либо то же самое, используя диапазоны:

    [ 1 7 range 10 256 ]

Раскладка на листе выполняется автоматически,
разбиение на страницы - так же.

При раскладке анализируются:

- форма оттиска (на текущий момент определяется только
  круглая форма)
- размеры оттисков

Используется раскладка в строки.
Если возможна оптимизация при шахматной раскладке -
используется шахматная раскладка. Она будет использована
в следующих случаях:

- в двух соседних строках все оттиски одного размера
- и все - одинаковой формы, поддерживающей шахматную раскладку
  (на сегодня - только круглая форма поддерживает).

Если хотя бы одно из условий не выполняется - используется
раскладка в строки.

Для каждого заказа рекомендую создавать отдельный postscript файл.

Для преобразования .ps файлов в .pdf следует выполнить

    make

из корневого каталога репозитория проекта.
Файлы будут .pdf будут созданы в каталоге sources/stamps/release.

Благодарности
-------------

- [Илья Никуленко](mailto:nikulenko_iliy@rambler.ru): при подготовке знаков
  поверителей в формате Type 3 использованы в качестве основы файлы
  True Type шрифта ГОСТ 2930-62, подготовленные Ильёй Никуленко.

Лицензионное соглашение
-----------------------

Полный текст лицензионного соглашения приведён в файле [LICENSE](LICENSE).

[PostScript]: https://ru.wikipedia.org/wiki/PostScript
[PostScript Language reference manual]: http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/postscript/pdfs/psrefman.pdf
[CygWin]: http://cygwin.com/install.html "Cygwin"
[CygWin make]: http://cygwin.com/install.html "make"
[GhostScript]: https://www.ghostscript.com/ "GhostScript"
[Notepad++]: https://notepad-plus-plus.org/ "Notepad++"
[SourceTree]: https://www.sourcetreeapp.com/ "SourceTree"
