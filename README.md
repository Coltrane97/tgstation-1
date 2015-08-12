﻿##Модифированный /tg/station v1.0.1
Используется сервером Infinity.

**Сайт оригинального разработчика:** http://www.tgstation13.org  
**Оригинальный код:** https://github.com/tgstation/-tg-station  
**Код**: https://bitbucket.org/infinity_team/infinity-tg  
**Сайт разработчика:** http://infinity.smforum.ru/index.php  
**IRC (На английском)**: irc://irc.rizon.net/coderbus  
**Основная карта:** TerrorStation (_maps/map_files/TerrorStation)  
**Используемая карта:** TerrorStation  
**Минимальная версия BYOND для компиляции:** 508

##ЗАГРУЗКА

Есть несколько способов скачать билд проекта.

Вариант 1:  
Скачать здесь в *.zip файле: https://bitbucket.org/infinity_team/infinity-tg/downloads

Вариант 2:  
1. Установить SourceTree (рекомендуем) или любой другой GIT-клиент.  
https://www.sourcetreeapp.com/download/  
2. Зайти в SourceTree и клонировать репозиторий по ссылке:  
https://bitbucket.org/infinity_team/infinity-tg.git

##УСТАНОВКА
0. Убедитесь, что у вас есть BYOND. Скачать можно здесь: http://www.byond.com/.  
1. Откройте файл tgstation.dme с помощью Dream Maker.
2. Нажмите Build -> Compile или нажмите Ctrl + K.
3. Дождитесь сообщения:  
...  
saving tgstation.dmb (DEBUG mode)  
tgstation.dmb - 0 errors, 0 warnings  
Если будут проблемы, пишите на форум.

##ЗАПУСК
0. Убедитесь, что у вас есть BYOND. Скачать можно здесь: http://www.byond.com/.  
1. Нажмите на Menu (Шестеренка) -> Start Dream Daemon. Или нажмите Ctrl + D.
2. Выберите с файл с помощью кнопки [...].
3. Напишите порт и нажмите кнопку [GO].
4. Как только появится строка "Initializations Complete" нажмите кнопку входа, которая обозначена стрелкой.

##ХОСТИНГ В ОС LINUX
В билде используется BYGEX для некоторых текстовых операции. К сожалению, билд имеет только библиотеку для ОС Windows. Если вы можете, то можете скачать BYGEX для Linux здесь https://github.com/optimumtact/byond-regex и скомпилировать его.  
Также можно отредактировать файл code/_compile_options.dm, и закомментировать строку: #define USE_BYGEX в начале строки таким образом: //#define USE_BYGEX и перекомпилировать билд снова.

##СОДЕЙСТВИЕ РАЗРАБОТКЕ БИЛДА.
Читать здесь:  
http://infinity.smforum.ru/index.php?topic=2630

##ЛИЦЕНЗИЯ
Весь исходный код после коммита 333c566b88108de218d882840e61928a9b759d8f, на 1-го января 2015-го года в 03:38 по Московскому времени (https://bitbucket.org/infinity_team/infinity-tg/commits/333c566b88108de218d882840e61928a9b759d8f) лицензируется на условиях лицензионного соглашения GNU AGPL v3 (http://www.gnu.org/licenses/agpl-3.0.html).  
Весь исходный код до коммита 333c566b88108de218d882840e61928a9b759d8f на 1 января 2015-го года в 03:38 по Московскому времени (https://github.com/tgstation/-tg-station/commit/333c566b88108de218d882840e61928a9b759d8f) лицензируется на условиях лицензионного соглашения GNU GPL v3 (https://www.gnu.org/licenses/gpl-3.0.html),  
в том числе и инструменты, если в их файле readme не указано другое. Подробнее в файлах LICENSE-AGPLv3.txt или LICENSE-GPLv3.txt. Все содержимое, включая иконки и звуки, лицензируется на условиях лицензионного соглашения Creative Commons 3.0 BY-SA (https://creativecommons.ru/sites/creativecommons.ru/files/docs/attribution_3.0_ss_by-sa_rus.pdf).
