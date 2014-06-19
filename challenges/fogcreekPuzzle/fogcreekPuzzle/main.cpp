//
//  main.cpp
//  fogcreekPuzzle
//
//  Created by Kai Zou on 2014-05-26.


#include <iostream>
#include <string>
#include <thread>

using namespace std;

int64_t hasher(string s) {
    int64_t h = 7;
    string letters = "acdegilmnoprstuw";
    for (int i=0; i<s.length(); i++) {
        h = (h*37 + letters.find(s.at(i)));
    }
    return h;
}

string incrementOnce(string input, const string lettersList) {
    string output = input;
    
    int length = (int)input.length();
    
    
    for (int i=length-1; i>=0; i--) {
        bool shouldIncrementNext = false;
        char c = input.at(i);
        int nextCharIdx = (int)lettersList.find(c) + 1;
        char nextChar = 'a';
        if (nextCharIdx < lettersList.length()) {
            nextChar = lettersList.at(nextCharIdx);
        } else {
            shouldIncrementNext = true;
        }
        
        output.replace(i, 1, 1, nextChar);
        
        if (shouldIncrementNext == false) {
            break;
        }
    }
    
    return output;
}

void brute(const string startGuess, const string endGuess, const int64_t targetHash, const string lettersList) {
    string guess = startGuess;
    int64_t resultHash = 0;
    unsigned long numSymbols = lettersList.length();
    unsigned long numBits = guess.length();
    
    unsigned long powerLong = 1;
    for (int i=0; i<numBits; i++) {
        powerLong = powerLong * numSymbols;
    }
    
    for (unsigned long i=0; i<powerLong; i++) {
        resultHash = hasher(guess);
        if (i % 5000000 == 0) {
            cout << guess << endl;
        }
        if (resultHash == targetHash || guess.compare(endGuess) == 0) {
            break;
        }
        
        guess = incrementOnce(guess, lettersList);
    }
    
    cout << resultHash << "   " <<guess << endl;
}

int main(int argc, const char * argv[])
{
    
    int64_t targetHash = 910897038977002;
    
    string letters = "acdegilmnoprstuw";
    
//    brute(targetHash, letters);
    
    thread t1(brute, "aaaaaaaaa", "ewwwwwwww", targetHash, letters);
    thread t2(brute, "gaaaaaaaa", "mwwwwwwww", targetHash, letters);
    thread t3(brute, "naaaaaaaa", "rwwwwwwww", targetHash, letters);
    thread t4(brute, "saaaaaaaa", "wwwwwwwww", targetHash, letters);
    
    t1.join();
    t2.join();
    t3.join();
    t4.join();
    
    return 0;
}

