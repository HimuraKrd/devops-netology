# Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой."

## Задача 1. Настроить terraform cloud (необязательно, но крайне желательно).
В это задании предлагается познакомиться со средством командой работы над инфраструктурой предоставляемым разработчиками терраформа.  

* Зарегистрируйтесь на https://app.terraform.io/. (регистрация бесплатная и не требует использования платежных инструментов).
* Создайте в своем github аккаунте (или другом хранилище репозиториев) отдельный репозиторий с конфигурационными файлами прошлых занятий (или воспользуйтесь любым простым конфигом).  
* Зарегистрируйте этот репозиторий в https://app.terraform.io/.
* Выполните plan и apply.

В качестве результата задания приложите снимок экрана с успешным применением конфигурации.
### Решение.

Попытка выполнить деплой машин в YC:  
![image](https://user-images.githubusercontent.com/68470186/148061937-b01ac2af-3ab6-4106-b033-c85253797319.png)  
Статус выполнения:  
![image](https://user-images.githubusercontent.com/68470186/148061954-ed841fdb-2609-45f9-aec2-192df5f99de2.png)  
![image](https://user-images.githubusercontent.com/68470186/148061962-c5709abf-92d9-4bc6-8322-35cee9c9825f.png)  
![image](https://user-images.githubusercontent.com/68470186/148061977-8260b660-f9df-4416-870d-3f6b9f0d25ab.png)  
Удаление машин через GIU от Terraform Cloud:  
![image](https://user-images.githubusercontent.com/68470186/148062005-e68e81eb-081b-4ec2-ab60-783af3872ae5.png)  
![image](https://user-images.githubusercontent.com/68470186/148062011-a580ae44-3ea8-48e9-a094-d31429215e09.png)  
![image](https://user-images.githubusercontent.com/68470186/148062022-8496c11f-c9bc-46fc-a554-fb654f22c725.png)


## Задача 2. Написать серверный конфиг для атлантиса.
Смысл задания – познакомиться с документацией о серверной конфигурации и конфигурации уровня репозитория.  

Создай server.yaml который скажет атлантису:  

* Укажите, что атлантис должен работать только для репозиториев в вашем github (или любом другом) аккаунте.  
* На стороне клиентского конфига разрешите изменять workflow, то есть для каждого репозитория можно будет указать свои дополнительные команды.  
* В workflow используемом по-умолчанию сделайте так, что бы во время планирования не происходил lock состояния.  
* Создай atlantis.yaml который, если поместить в корень terraform проекта, скажет атлантису:  
* Надо запускать планирование и аплай для двух воркспейсов stage и prod.
* Необходимо включить автопланирование при изменении любых файлов *.tf.  

В качестве результата приложите ссылку на файлы server.yaml и atlantis.yaml.  

### Решение
Отработал согласно [инструкции на официальном сайте](https://www.runatlantis.io/guide/testing-locally.html):
Созданные файлы имеют вид:
```yml
#atlantis.yaml
version: 3
projects:
- dir: .
  workspace: stage
  autoplan:
    when_modified: [ "*.tf" ]
    enabled: true
- dir: .
  workspace: prod
  autoplan:
    when_modified: [ "*.tf" ]
    enabled: true
```
``` yml
#server.yaml
repos:
- id: https://github.com/HimuraKrd/terraform-cloud
  allowed_overrides: [workflow]

# убираем`lock` состояния.
workflows:
  default:
    plan:
      steps:
      - init:
          extra_args: ["-lock=false"]
      - plan:
          extra_args: ["-lock=false"]
    apply:
      steps: [apply]
```
В результате получается:  
![image](https://user-images.githubusercontent.com/68470186/148062493-adcb8abc-e291-4c2a-a092-0d3db7095f0d.png)


## Задача 3. Знакомство с каталогом модулей.
* В каталоге модулей найдите официальный модуль от aws для создания ec2 инстансов.
* Изучите как устроен модуль. Задумайтесь, будете ли в своем проекте использовать этот модуль или непосредственно ресурс aws_instance без помощи модуля?
* В рамках предпоследнего задания был создан ec2 при помощи ресурса aws_instance. Создайте аналогичный инстанс при помощи найденного модуля.

В качестве результата задания приложите ссылку на созданный блок конфигураций.

### Решение
К сожалению, я не нашёл никаких модулей под YC, которые можно было бы разобрать и потренироваться на них. Из-за чего пришлось некоторое время потратить на изучение AWS без регистрации на нём. Модуль имеет структуру:
```
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```
Если я правильно понял, то внутри модуля содержится блок ``aws_instance``, который можно создать напрямую, избежав дополнительного слоя абстракции:
```
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
```
Поэтому я бы не стал использовать данный модуль.
