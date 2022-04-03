# Домашнее задание к занятию "09.01 Жизненный цикл ПО"

## Подготовка к выполнению
1. Получить бесплатную [JIRA](https://www.atlassian.com/ru/software/jira/free)
2. Настроить её для своей "команды разработки"
3. Создать доски kanban и scrum

## Основная часть
В рамках основной части необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить следующий жизненный цикл:
1. Open -> On reproduce
2. On reproduce <-> Open, Done reproduce
3. Done reproduce -> On fix
4. On fix <-> On reproduce, Done fix
5. Done fix -> On test
6. On test <-> On fix, Done
7. Done <-> Closed, Open

Остальные задачи должны проходить по упрощённому workflow:
1. Open -> On develop
2. On develop <-> Open, Done develop
3. Done develop -> On test
4. On test <-> On develop, Done
5. Done <-> Closed, Open

Создать задачу с типом bug, попытаться провести его по всему workflow до Done. Создать задачу с типом epic, к ней привязать несколько задач с типом task, провести их по всему workflow до Done. При проведении обеих задач по статусам использовать kanban. Вернуть задачи в статус Open.
Перейти в scrum, запланировать новый спринт, состоящий из задач эпика и одного бага, стартовать спринт, провести задачи до состояния Closed. Закрыть спринт.

Если всё отработало в рамках ожидания - выгрузить схемы workflow для импорта в XML. Файлы с workflow приложить к решению задания.

---

# Решение 

Создал 2 workflow, согласно задаче:  
для задач типа bug:  
![image](https://user-images.githubusercontent.com/68470186/158061438-d36a8f79-ee3a-416e-a58e-34323f95f52d.png)  
для все хостальных задач:  
![image](https://user-images.githubusercontent.com/68470186/158061485-52270f75-cc84-4291-bd36-2f70c483364f.png)  

В ``Settings -> Issues -> Workflow schemes`` добавил новух схему по названию лекции:  
![image](https://user-images.githubusercontent.com/68470186/158061544-398bdd13-7a73-4962-bac1-9c03e0a62ac1.png)
Далее в `` Project -> Settings -> Workflows`` изменил смеху по-умолчанию:  
![image](https://user-images.githubusercontent.com/68470186/158061602-e5d4385c-3a57-4380-8cce-0a6027136ca4.png)

Добавил доску ``scrum`` и прогнал задачи, согласно ТЗ. XML смехы во вложении.

---