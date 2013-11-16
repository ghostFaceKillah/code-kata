#include "sort5.h"
#include<iostream>

int swap (int *k, int *j) {
  int f;
  f = *k;
  *k = *j;
  *j = f;
};

int median_of_five(int n1, int n2, int n3, int n4, int n5) {
  int *a = &n1, *b = &n2, *c = &n3, *d = &n4, *e = &n5;
  int *tmp;
  if(*b < *a){
    tmp = a; a = b; b = tmp;
  }
  if(*d < *c){
    tmp = c; c = d; d = tmp;
  }
  if(*c < *a){
    tmp = b; b = d; d = tmp; 
    c = a;
  }
  a = e;
  if(*b < *a){
    tmp = a; a = b; b = tmp;
  }
  if(*a < *c){
    tmp = b; b = d; d = tmp; 
    a = c;
  }
  if(*d < *a)
    return *d;
  else
    return *a;
}

int median_of_four(int n1, int n2, int n3, int n4) {
  int a = n1;
  int b = n2;
  int c = n3;
  int d = n4;
  int tmp;
  if(b >= a){
    tmp = a; a = b; b = tmp;
  }
  if(d >= c){
    tmp = c; c = d; d = tmp;
  }
  if(c >= a){
    tmp = c; c = a; a = tmp;
  }

  return (b+c)/2;
}
