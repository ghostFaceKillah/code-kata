#include<iostream>
#include "sort5.h"

void display_vector(vector<int> data)
{
  for( int i = 0 ; i < data.size() ; i++ ) {
    cout << data[i];
  };
  cout << endl;
};

int main() {
  int m;
  while (true) {
    vector<int> data;
    for (int k = 0; k < 5; k++ ) {
      cin >> m;
      data.push_back(m);
    }
    // display_vector(data);
    cout <<  median_of_five( data[0], data[1], data[2], data[3], data[4] ) << endl;
  };
};
