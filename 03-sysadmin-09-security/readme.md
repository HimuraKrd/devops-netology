# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

## 1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
Установил, поигрался, удалил. Возможно, для работы с браузерами и наличия базы под рукой (например, для использования с мобильного устройства) - программа представляет интерес. Много лет пользуюсь KeePass и для личного пользования программа более чем подходит. Из плюсов BitWarden и LastPass (который также потыкал) - шара данных и импорт/экспорт паролей. Больше сильных и весомых агрументов в пользу использования этих решений для не нашёл.  
![1_bitwarden](https://user-images.githubusercontent.com/68470186/134865610-6372338a-67fe-4a85-b169-68bdbdcf489a.png)

## 2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.
Также настроил, подключился, проверил, удалил. Простите, скриншотов здесь предложить не могу :-( 

## 3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
Позволю себе некоторую вольность. Для того, чтобы отработать задание из предыдущего модуля, решил заменить Apache2 на Nginx, т.к. на будущей работе также буду работать с данным программным продуктом.  
Система установилась и доступна по сетевому адресу без сертификатов:  
![3_nginx_no_cert](https://user-images.githubusercontent.com/68470186/134867492-d30b059b-3a90-4fc2-8a96-a1f61fa29cd3.png)  
Дальше работал вот по этой инструкции: [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)  
В результате получил вот такой самоподписанный сертификат:  
![3_nginx_cert_added](https://user-images.githubusercontent.com/68470186/134905649-e3ebe436-ebe4-4dd7-ac1f-09203e9428be.png)

## 4. Проверьте на TLS уязвимости произвольный сайт в интернете.
Скачиваем нужный нам баш скрипт, используя команду ``git clone --depth 1 https://github.com/drwetter/testssl.sh.git``. Заходим в скачанную папку и запускаем проверку. Для теста я решил просканить 2ip.ru:
![4_testssl_sh](https://user-images.githubusercontent.com/68470186/134906382-b545464f-77e9-4fd3-950c-65d0f813e5c8.png)


## 5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
Генерация ключей происходит при помощи команды ``ssh-keygen``. После чего копируем данные на нужный нам хост, используя ``ssh-copy-id`` и синтаксис ``ssh-copy-id username@remote_host``. После успешного выполнения команды мы можем подключаться по SSH, используя конструкцию ``ssh username@ip``:  
![5_sample_ssh](https://user-images.githubusercontent.com/68470186/134910461-1088ded7-2ce4-4b98-9ebe-bb34554fab15.png)

## 6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.
К сожалению, мой текущий компьютер слишком слаб для нормального хостинга двух виртуальных машин.. Я отработал это задание на работе, но, увы, скриншотов предоставить не могу :-( Для настройки файла-конфигурации нужно сделать следующее:  
``mkdir -p ~/.ssh && chmod 700 ~/.ssh``  
``touch ~/.ssh/config && chmod 600 ~/.ssh/config``  
После чего отредактировать файл ``config``, добавив в него переменные для подключения.

## 7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
Если воспользоваться командой ``tcpdump -c 100`` без дополнительных флагов, то результатом вывода будет сбор всех пакетов по всем интерфейсам. Если добавить флаг ``-i`` - можно определить нужный нам интерфейс, а флаг ``-w`` позволит сохранить результат вывода в файл ``.pcap``.  
![7_general](https://user-images.githubusercontent.com/68470186/134925848-e1aee5d1-a4bf-4aa9-8561-6be83c5b4df5.png)  
![7_pcap](https://user-images.githubusercontent.com/68470186/134925879-a01c340b-e886-46cb-94af-d58470bc9965.png)  
После установим и настроем smb для передачи полученного файла на рабочую станцию и откроем в WireShark:  
![7_wireshark](https://user-images.githubusercontent.com/68470186/134925964-0697feb4-feba-4d69-a10d-cdb4841c24da.png)

