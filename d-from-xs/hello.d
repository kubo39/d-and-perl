import core.runtime;


__gshared Counter counter;


extern(C)
{
 char* hello_from_d()
 {
   return cast(char*)"hello";
 }

 void createCounter()
 {
   if (counter is null) {
     counter = new Counter;
   }
 }

 int getCount()
 {
   if (counter is null) {
     return -1;
   }
   return counter.current;
 }

 void increment()
 {
   if (counter is null) {
     return;
   }
   counter.countup;
 }
}


class Counter
{
  int value;
  this()
  {
    value = 0;
  }

  void countup()
  {
    value++;
  }

  int current()
  {
    return value;
  }
}
