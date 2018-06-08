#include <iostream>
#include <string>
#include <time.h>
#include <stdlib.h>

using namespace std;

void Array(int* &array, int n);//создание массива 
void randArray(int &One, int &Two, int &C);//заполнение случайными числами и знаками
void plus_minus(int number1, int number2, int sign, int &plus, int &minus, int &kolP, int &kolM, int *ArrOne, int *ArrTwo, int *ArrSign, int *True_False, int i, int &k); //решение примеров на сложение и вычитание
void result(int plus, int kolP, int minus, int kolM); //вывод результат 
void Neprav(int &plus, int &minus, int &kolP, int &kolM, int *ArrOne, int *ArrTwo, int *ArrSign, int *True_False, int num); //неправильные примеры
void delArray(int* &array);  //очистка массива
void mark(int kolP, int num); //оценка

int main(){
	setlocale(LC_ALL, "Russian");
	cout << "Проверка знаний арифметики на сложение и вычитание."<<endl;
    /*while(1){*/ //цикл повтора программы (2 вариант)
	do{   //цикл повтора программы (1 вариант)

	int num= 0; //количество примеров
	int plus= 0; //счетчик сложения
	int minus=0; //счетчик вычитания
	int k=0; //номер неверного примера
    int *ptrOne= NULL;  //1 число
	int *ptrTwo = NULL; //2 число
	int *ptrSign = NULL; //знак
	int *ptrTrue_False = NULL;  //определитель- правда или ложь
	int kolP=0; //количество правильных ответов (+)
    int kolM=0; //количество правильных ответов (-)
    int kol = 0; //количество правильных ответов (+ и -)
   
	cout <<"Напишите количество примеров." << endl; 
    cin >> num;
	
	Array (ptrOne, num);  //создание в массиве 1 чисел
    Array (ptrTwo, num);  //создание в массиве 2 чисел
    Array (ptrSign, num);  //создание в массиве знаков
    Array (ptrTrue_False, num);  

    for (int i=0; i < num; i++) {
    	int One=0;
    	int Two=0;
    	int Sign=0;
        randArray(One, Two, Sign); //заполнение числами и знаками
		plus_minus(One, Two, Sign, plus, minus,  kolP,  kolM, ptrOne, ptrTwo, ptrSign, ptrTrue_False, i, k); //создание примеров
    }
    
    result(plus, kolP, minus,  kolM);  
	kol=kolP+kolM;  //количество правильных на + и -
	mark(kol, num); //оценка
    while ((plus!=kolP) || (minus!=kolM)) {  //вывод неправильных ответов
        plus = 0;
        kolP = 0;
        minus = 0;
        kolM = 0;
        Neprav(plus, minus , kolP, kolM, ptrOne, ptrTwo, ptrSign, ptrTrue_False, num);
        result(plus, kolP,  minus, kolM);

    }
    
    delArray (ptrOne);	//очистка массива 1 чисел
    delArray (ptrTwo);  //очистка массива 2 чисел
    delArray (ptrSign);  //очистка массива знаков
    delArray (ptrTrue_False);  //очистка массива правда-ложь

	/*char answ;         // цикл повтора программы (2 вариант)
    cout<<"Повторить? y||n";
    cin>>answ;
    if (answ!='y' && answ!='Y') break;
}*/
	cout << "Для повтора программы введите любой символ, иначе введите 'z' " << endl; //цикл повтора программы (1 вариант)
	cin.get();
    }while (cin.get() != 'z' );

	system("pause");
    return 0;
}



void Array(int* &array, int n){ //создание массива 
	array = new int[n];    
}

void delArray(int* &array){   //очистка массива
    delete [] array;   
}

void mark(int kol, int num){ //оценка
	double m = ((double)kol/(double)num)*100;
	if (m < 60)
		cout << "Ваша оценка: неудовлетворительно "<< m << "%"<< endl;
	if ((m >= 60) && (m < 71))
		cout << "Ваша оценка: удовлетворительно "<<m << "%"<<endl;
	if ((m >= 71) && (m < 86))
		cout << "Ваша оценка: хорошо "<< m << "%"<<endl;
    if (m >= 86)
		cout << "Ваша оценка: отлично "<< m << "%"<<endl;
}

void randArray(int &One, int &Two, int &Sign){ //заполнение массива случайными числами и знаками
        srand(time(NULL)); //функция для различного заполнения чисел (без повторений)
        One=rand()%100; //первое число
		Sign=rand()%2; //знак
		if (Sign==0) //знак (+)
			Two=rand()%100; //второе число
       	if (Sign==1) //знак (-)
			Two=rand()%One; //второе число, которое меньше первого  
}

 void plus_minus(int number1, int number2, int sign, int &plus, int &minus, int &kolP, int &kolM, int *ArrOne, int *ArrTwo, int *ArrSign, int *True_False, int i, int &k){
	int AnswerPrav = 0; //правильные ответы
	int Answer = 0; //ответы пользователя
	if (sign == 0) {
		plus++;
		AnswerPrav = number1 + number2;
		cout << i + 1 << ".) " << number1 << "+" << number2 << "= ";
		cin >> Answer;
		if (AnswerPrav == Answer) {
			kolP++;
			True_False[k] = 1; //правда
			k++;
		}
		else {
			ArrOne[k] = number1;
			ArrTwo[k] = number2;
			ArrSign[k] = sign;
			True_False[k] = 0; //ложь
			k++;
		}
	}
	if (sign == 1) {
		plus++;
		AnswerPrav = number1  - number2 ;
		cout << i + 1 << ".) " << number1  << "-" << number2 << "= ";
		cin >> Answer ;
		if (AnswerPrav == Answer) {
			kolM++;
			True_False[k] = 1; //правда
			k++;
		}
		else {
			ArrOne[k] = number1 ;
			ArrTwo[k] = number2 ;
			ArrSign[k] = sign;
			True_False[k] = 0; //ложь
			k++;
		}
	}
}

void result(int plus, int kolP, int minus, int kolM){//вывод результата
    if ((plus==kolP) && (minus==kolM)) //все верно
    	cout << "Все верно"<<endl;
    if ((plus>kolP) && (minus>kolM)) { //ошибки в примерах со сложением и вычетанием
    	plus -= kolP;
		minus -= kolM;
		cout << plus << endl;
    	cout << minus << endl;
    }
}

void  Neprav(int &plus, int &minus, int &kolP, int &kolM, int *ArrOne, int *ArrTwo, int *ArrSign, int *True_False, int num){  //неправильные примеры
    for (int i=0; i < num; i++) { 
        int AnswerPrav = 0;
        int Answer= 0;
        if (True_False[i] == 0) { 
        	if (ArrSign[i] == 0) {
        		plus++;
        		AnswerPrav = ArrOne[i] + ArrTwo[i];
        		cout << i + 1 << ".) " << ArrOne[i] << "+" << ArrTwo[i] << "= ";
        		cin >> Answer;
        		if (AnswerPrav == Answer) {
        			kolP++;
        			True_False[i] = 1;
        	    }
        	}
        	if (ArrSign[i] == 1) {
        		minus++;
        		cout << i + 1 << ".) " << ArrOne[i] << "-" << ArrTwo[i] << "= ";
        		cin >> Answer;
        		AnswerPrav = ArrOne[i] - ArrTwo[i];
        		if (AnswerPrav == Answer) {
        			kolM++;
        			True_False[i] = 1;
        		}
        	}    
        }
	}
}
