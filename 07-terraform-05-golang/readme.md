# Домашнее задание к занятию "7.5. Основы golang"

## Задача 1. Установите golang.
Воспользуйтесь инструкций с официального сайта: https://golang.org/.  
Так же для тестирования кода можно использовать песочницу: https://play.golang.org/  .

```shell
[Himura@fedora ~]$  go version
go version go1.17.6 linux/amd64
```

## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль https://tour.golang.org/. Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  
  
## Задача 3. Написание кода.
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода на своем компьютере, либо использовать песочницу: https://play.golang.org/.  
  
* Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:

```go
package main

import "fmt"

func main() {
    fmt.Print("Введите число (в метрах): ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input / 0.3048

    fmt.Println("Результат в футах:", output)    
}
```

* Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

```x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}```
```go
package main
import "fmt"

func main() {
    array := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17}
    minVal := array[0]
    for _, value := range array {
            if (value < minVal) {
                    minVal = value
            }
    }
    fmt.Println(minVal)
}
```
* Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).

```go
package main

import "fmt"

func main() {
        for i:=1; i<=100; i++ {
      if i % 3 == 0 {
      fmt.Println(i)
      }
    }
}
```


## Задача 4. Протестировать код (не обязательно).
Создайте тесты для функций из предыдущего задания.