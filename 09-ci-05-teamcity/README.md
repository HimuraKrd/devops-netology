# Домашнее задание к занятию "09.05 Teamcity"

## Подготовка к выполнению

1. В Ya.Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`
2. Дождитесь запуска teamcity, выполните первоначальную настройку
3. Создайте ещё один инстанс(2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`
4. Авторизуйте агент
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity)
6. Создать VM (2CPU4RAM) и запустить [playbook](./infrastracture)

## Основная часть

1. Создайте новый проект в teamcity на основе fork
2. Сделайте autodetect конфигурации
3. Сохраните необходимые шаги, запустите первую сборку master'a
4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`
5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus
7. Запустите сборку по master, убедитесь что всё прошло успешно, артефакт появился в nexus
8. Мигрируйте `build configuration` в репозиторий
9. Создайте отдельную ветку `feature/add_reply` в репозитории
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике
12. Сделайте push всех изменений в новую ветку в репозиторий
13. Убедитесь что сборка самостоятельно запустилась, тесты прошли успешно
14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity
19. В ответ предоставьте ссылку на репозиторий

---

# Решение
Создал 2 контейнера под TC и 1 VM под нексус:  
![image](https://user-images.githubusercontent.com/68470186/160255072-c94ea4a9-ff0c-4409-a6c9-001785f8eea9.png)  
Прошёлся плейбуком для подготовки Nexus к работе:  
![image](https://user-images.githubusercontent.com/68470186/160255087-55081155-beac-490e-9dfe-381f97d65778.png)  
Убедился, что службы запустились и приступил к настройке проекта в TC мастер:  
Добавил в качестве VCS [форк](https://github.com/HimuraKrd/example-teamcity) от репозитория Алексея;  
![image](https://user-images.githubusercontent.com/68470186/160255111-83877364-5daa-481c-a102-fa898068f8b6.png)  
Запустил и убедился, что тесты прошли без проблем:  
![image](https://user-images.githubusercontent.com/68470186/160255156-4a0d9674-09d1-4e0f-9f13-cecb4f60520f.png)  
Добавил настройки Maven из папки, согласно заданию:  
![image](https://user-images.githubusercontent.com/68470186/160255169-50d0d594-de32-4bd8-b785-3883c6c8fb57.png)  
Изменил настройки для разного срабатывания билдов:  
![image](https://user-images.githubusercontent.com/68470186/160255180-35e3a872-07f7-4a8c-aceb-962f085f02fd.png)  
Получил ошибку на сборке, т.к. артифакт не мог выгрузиться в nexus:  
![image](https://user-images.githubusercontent.com/68470186/160255190-d6699507-f78a-4647-bd33-c50a66ac90b8.png)  
Понял, что забыл прикрепить файл с настройками Maven к шагам билда с деплоем:  
![image](https://user-images.githubusercontent.com/68470186/160255199-29edb7ad-99fb-4a25-94fe-d6d83f331933.png)  
Поймал ещё одну ошибку, т.к. забыл изменить в POM-нике. Но в результате файл успешно был выгружен на нексус:  
![image](https://user-images.githubusercontent.com/68470186/160255226-f9e55817-9815-4023-8b49-1b68a48c19c2.png)  
![image](https://user-images.githubusercontent.com/68470186/160255228-bf1e4ee5-1038-461a-89d4-531b60e6e077.png)  
Сделал ветку и убедился, что в автоматическом виде ТимСити начинает процесс сборки согласно шагам в билде:  
![image](https://user-images.githubusercontent.com/68470186/160255252-2cc8319c-5141-4844-a5c1-f01b03401097.png)  
По количеству тестов (было 4, стало 5) понимаю, что всё успешно проходит и вижу свой метод среди тестов:  
![image](https://user-images.githubusercontent.com/68470186/160255265-5b649bc8-b0b8-4863-a912-b200dc793959.png)  
Мержу ветку в мастер, меняя версию в POM-нике (с 0.2.6 на 0.2.7), добавляю настройку для сохранения артефактов и получаю:  
![image](https://user-images.githubusercontent.com/68470186/160255297-d2b47803-d983-4a2a-ad14-9bbff596793e.png)

Ссылка на форк [тут](https://github.com/HimuraKrd/example-teamcity). В репозитории все новые методы, включая тестовый ``saysKawabanga`` :-) 













---
