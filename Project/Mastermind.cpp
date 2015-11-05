/* 
* File:   main.cpp 
* Author: Adam Wright 
* Project 1 - Assembly Programming
* 
* Created on November 5th, 2015, 2:05 PM 
* Playing a simplified version of the game "Mastermind". 
*/ 

#include <cstdlib> 
#include <iostream> 
#include <ctime> 
using namespace std; 
 
void fillArray(int *, int); 
void print(int *, int); 
void guess(int *, int ); 
int correct(int *, int *, int); 
int incorrect(int *, int *, int); 
 
int main(int argc, char** argv) { 
    srand(static_cast<unsigned int>(time(0))); 
    /// Create a pseudo-2D 3x3 array 
    /// Initialize elements to zero 
    const int SIZE = 3; 
    int R0[SIZE]; 
    fillArray(R0, SIZE); 
    int guessArray[SIZE]; 
     
    //print(R0, SIZE); 
    //print(guessArray, SIZE); 
     
    while (correct(R0, guessArray, SIZE) != SIZE) { 
        guess(guessArray, SIZE); 
        cout << correct(R0, guessArray, SIZE) << " in correct position.\n"; 
        cout << incorrect(R0, guessArray, SIZE) << " in incorrect position.\n"; 
        cout << endl; 
    } 
    return 0; 
} 

 
// R1 is the number of elements to guess 
void fillArray(int *R0, int R1) { 
    for (int R2 = 0; R2 != R1; ++R2) { 
        int R3 = rand() % 7 + 1; 
        *(R0 + R2) = R3; 
    } 
} 

 
// R1 is the number of elements to guess 
void  guess(int *array, int R1) { 
    cout << "Enter numbers between 1 and 7\n"; 
    for (int R2 = 0; R2 != R1; ++R2) { 
        cout << "Enter guess " << R2+1 << ": "; 
        int R3; 
        cin >> R3; 
        *(array+R2)=R3; 
    } 
} 

 
int correct(int *R1, int *R2, int size) { 
    int count = 0; 
    for (int i = 0; i != size; ++i) 
        if (*(R1+i) == *(R2+i)) 
            ++count; 
    return count; 
} 

 
int incorrect(int *R1, int *R2, int size) { 
    int count = 0; 
    for (int i = 0; i != size; ++i) 
        if (*(R1+i) != *(R2+i)) 
            ++count; 
    return count; 
} 

 
void print(int * R1, int SIZE) { 
    for (int i = 0; i != SIZE; ++i) { 
        cout << *(R1+i) << " "; 
    } 
    cout << endl; 
} 
