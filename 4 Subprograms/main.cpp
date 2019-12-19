#include<iostream>



  int checkDigit(int number,int digit)

  {
     while(number)
     {
         std::cout << number << std::endl;
         std::cout << number%10 << std::endl;
         if(digit == number % 10)
             return 1;
         number /= 10;
     }
     return 0;
  }
  int main()

  {
      int numbertoCheck = 98796543;
      std::cout << checkDigit(numbertoCheck,5) << std::endl;
      return 0;
  }
