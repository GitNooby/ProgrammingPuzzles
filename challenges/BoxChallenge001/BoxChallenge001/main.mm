//
//  main.m
//  BoxChallenge001
//
//  Created by Kai Zou on 2014-05-13.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

//#import <Foundation/Foundation.h>

/*
 your cache should store simple key/value strings of length up to 10 characters.
 it should also have a customizable upper bound of the number of kets that can be stored in the cache at any time. you do not have to be thread safe.
 
 BOUND : set the upper bound. if the cache size is currently greater than this number, then the extra entries must be removed following the LRU policy
 SET: set the value of the key
 GET: get the value of the key and print to stdout
 PEEK: get the value of the key but does not makr it as being used. prints the value to standard out
 DUMP: prints the current state of the cache as k/v pairs in alphabetical order by key
 
 */

#include <iostream>
#include <string>
#include <cstdio>
#include <vector>
#include <sstream>
#include <algorithm>
#include <unistd.h>
#include <fstream>
#include <unordered_map>
#include <map>
#include <ctime>

//#include "DoublyLinkedList.h"

using namespace std;

class ListNode {
public:
    string key;
    string value;
    ListNode *prev;
    ListNode *next;
    ListNode(string k, string v) {
        this->key = k;
        this->value = v;
        prev = next = nullptr;
    }
    bool operator<(const ListNode& a) const;
//    bool compare(const ListNode& a, const ListNode& b);
    
};

class DoublyLinkedList {
private:
    ListNode *head;
    ListNode *tail;
    int currSize;
    int maxSize;
    
    unordered_map<string, ListNode*> hashMap;
    
    void removeLast();
public:
    DoublyLinkedList(int size) {
        tail = head = nullptr;
        currSize = 0;
        maxSize = size;
        maxSize = maxSize < 0 ? 0 : maxSize;
    }
    ~DoublyLinkedList();
    void insertFront(string k, string v);
    void deleteNode(ListNode* node);
    ListNode *findNode(string k);
    void deleteNode(string k);
    ListNode* getNode(string k);
    ListNode* peekNode(string k);
    void setMaxSize(int newMaxSize);
//    vector<ListNode*> printAllWithKeyAlphabetical();
    map<string, ListNode*> printAllWithKeyAlphabetical();
    void printDLL();
};

bool customCompare(const ListNode *a, const ListNode *b) {
    if (a->key.compare(b->key) <= 0) {
        return true;
    }
    return false;
}

//vector<ListNode*> DoublyLinkedList::printAllWithKeyAlphabetical() {
map<string, ListNode*> DoublyLinkedList::printAllWithKeyAlphabetical() {
//    vector<ListNode*> vectList;
//    
//    ListNode *aNode = this->head;
//    while (aNode != nullptr) {
//        //        ListNode newNode = ListNode(aNode->key, aNode->value);
//        vectList.push_back(aNode);
//        //        vectList.push_back(ListNode(aNode->key, aNode->value));
//        aNode = aNode->next;
//    }
//    
//    sort(vectList.begin(), vectList.end(), customCompare);
    map<string, ListNode*> ordered(hashMap.begin(), hashMap.end());
    return ordered;
//    return hashMap;
}

void DoublyLinkedList::printDLL() {
    ListNode *aNode = this->head;
    cout << "STARTING---" << endl;
    while (aNode != nullptr) {
        cout << aNode->key << " " << aNode->value << endl;
        aNode = aNode->next;
    }
    cout << "ENDING-----" << endl;
}



bool ListNode::operator<(const ListNode& a) const {
//    printf("thiskey:%s\n", this->key.c_str());
//    printf("a key:%s\n", a.key.c_str());
    
    if (this->key.compare(a.key) <= 0) {
        return true;
    }
    return false;
}

DoublyLinkedList::~DoublyLinkedList() {
    while (this->tail != nullptr) {
        this->deleteNode(this->tail);
    }
}

void DoublyLinkedList::insertFront(string k, string v) {
    ListNode *aNode = this->findNode(k);
    
    if (aNode != nullptr) {
        aNode->value = v;
    } else {
        aNode = new ListNode(k, v);
        hashMap[aNode->key] = aNode;
        this->currSize++;
    }
    
    if (this->head == nullptr) {
        this->head = aNode;
        this->tail = aNode;
    } else {
        ListNode *frontNode = head;
        this->head = aNode;
        aNode->next = frontNode;
        frontNode->prev = aNode;
    }
    
    while (this->currSize > this->maxSize) {
        this->deleteNode(this->tail);
    }
}

ListNode* DoublyLinkedList::findNode(string k) {
//    ListNode *iter = this->head;
//    while (iter != nullptr) {
//        if (iter->key.compare(k) == 0) {
//            break;
//        }
//        iter = iter->next;
//    }
    ListNode* iter = nullptr;
    unordered_map<string, ListNode*>::iterator it = hashMap.find(k);
    if (it == hashMap.end()) {
        return nullptr;
    }
    iter = hashMap[k];
    return iter;
}

void DoublyLinkedList::deleteNode(string k) {
    ListNode *aNode = this->findNode(k);
    this->deleteNode(aNode);
}

void DoublyLinkedList::deleteNode(ListNode *node) {
    if (node == nullptr) {
        return;
    }
    if (node == this->tail && node == this->head) {
        this->tail = nullptr;
        this->head = nullptr;
        unordered_map<string, ListNode*>::iterator it = hashMap.find(node->key);
        hashMap.erase(it);
        delete node;
        currSize--;
        return;
    }
    
    ListNode *before, *after;
    before = node->prev;
    after = node->next;
    if (before != nullptr) {
        before->next = after;
    }
    if (after != nullptr) {
        after->prev = before;
    }
    if (this->tail == node) {
        this->tail = node->prev;
    }
    if (this->head == node) {
        this->head = node->next;
    }
    unordered_map<string, ListNode*>::iterator it = hashMap.find(node->key);
    hashMap.erase(it);
    delete node;
    currSize--;
}

ListNode* DoublyLinkedList::getNode(string k) {
    ListNode *aNode = this->findNode(k);
    if (aNode == nullptr) {
        return nullptr;
    }
    
    if (aNode == this->head) {
        return aNode;
    }
    if (aNode == this->tail) {
        this->tail = aNode->prev;
    }
    
    ListNode *before = aNode->prev;
    ListNode *after = aNode->next;
    if (before != nullptr) {
        before->next = after;
    }
    if (after != nullptr) {
        after->prev = before;
    }
    aNode->prev = nullptr;
    aNode->next = this->head;
    this->head->prev = aNode;
    this->head = aNode;
    return aNode;
}

ListNode* DoublyLinkedList::peekNode(string k) {
    ListNode *aNode = this->findNode(k);
    return aNode;
}

void DoublyLinkedList::setMaxSize(int newMaxSize) {
    this->maxSize = newMaxSize;
    if (this->maxSize < 0) {
        this->maxSize = 0;
    }
    while (this->currSize > this->maxSize) {
        this->deleteNode(this->tail);
    }
}

inline std::vector<std::string> &split(const std::string &s, char delim, std::vector<std::string> &elems) {
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}


inline std::vector<std::string> split(const std::string &s, char delim) {
    std::vector<std::string> elems;
    split(s, delim, elems);
    return elems;
}

#define DEBUGME 0
#define PRINTALL 0

int main() {
    
//    printf("DEBUGME %d\n", DEBUGME);
//    printf("PRINTALL %d\n", PRINTALL);
    
#if DEBUGME
    cout << "start" << endl;
    clock_t startTime = clock();
#endif
    
#if DEBUGME
    ifstream infile("/Users/kaizou/Documents/test_dir/ProgrammingPuzzles/challenges/BoxChallenge001/BoxChallenge001/manualTest.txt");
    if (infile.is_open() == false) {
        printf("file error\n");
        return -1;
    }
#endif
    
    DoublyLinkedList *dll = new DoublyLinkedList(0);
    
    // determine number of commands
    string numCommands;
#if DEBUGME
    getline(infile, numCommands);
#else
    getline(cin, numCommands);
#endif
    int cmdsSize = atoi(numCommands.c_str());

    // helper strings
    string line;
    string inputString = "";
    string finalOutputString = "";
    
    
    // get all the input here
    for (int i=0; i<cmdsSize; i++) {
#if DEBUGME
        getline(infile, line);
#else
        getline(cin, line);
#endif
        inputString += line + "\n";
    }
    
#if DEBUGME
    clock_t doneReadTime = clock();
#endif
    
    // process all the input here
    vector<string> commands = split(inputString, '\n');
    
    for (int i=0; i<commands.size(); i++) {
        string cmd = commands[i];
        vector<string> args = split(cmd, ' ');
        if (args[0].compare("BOUND") == 0) {
            int newMaxSize = atoi(args[1].c_str());
            dll->setMaxSize(newMaxSize);
        } else if (args[0].compare("SET") == 0) {
//            cout << "run SET" << endl;
            dll->insertFront(args[1], args[2]);
        } else if (args[0].compare("GET") == 0) {
//            cout << "run GET" << endl;
            ListNode *aNode = dll->getNode(args[1]);
            if (aNode == nullptr) {
                //                cout << "NULL" << endl;
                finalOutputString += "NULL\n";
            } else {
                //                cout << aNode->value << endl;
                finalOutputString += aNode->value + "\n";
            }
        } else if (args[0].compare("PEEK") == 0) {
//            cout << "run PEEK" << endl;
            ListNode *aNode = dll->peekNode(args[1]);
            if (aNode == nullptr) {
                //                cout << "NULL" << endl;
                finalOutputString += "NULL\n";
            } else {
                //                cout << aNode->value << endl;
                finalOutputString += aNode->value + "\n";
            }
        } else if (args[0].compare("DUMP") == 0) {
//            vector<ListNode*> vectList = dll->printAllWithKeyAlphabetical();
//            for (int i=0; i<vectList.size(); i++) {
//                finalOutputString += vectList[i]->key + " " + vectList[i]->value + "\n";
//            }
            map<string, ListNode*> mapList = dll->printAllWithKeyAlphabetical();
            for (map<string, ListNode*>::iterator it=mapList.begin(); it!=mapList.end(); ++it) {
                finalOutputString += it->first + " " + it->second->value + "\n";
            }
        }
    }

#if DEBUGME
    clock_t doneProcess = clock();
//    int asdfasdf = double(asdf) / CLOCKS_PER_SEC * 1000;
#endif
    
    // print the result
    cout << finalOutputString;
    
#if DEBUGME
    clock_t donePrint = clock();
    int readDeltaTime = double(doneReadTime-startTime) / CLOCKS_PER_SEC * 1000;
    int processDeltaTime = double(doneProcess - doneReadTime) / CLOCKS_PER_SEC * 1000;
    int printDeltaTime = double(donePrint - doneProcess) / CLOCKS_PER_SEC * 1000;
    cout << "read delta:" << readDeltaTime << " process delta:" << processDeltaTime << " print delta:" << printDeltaTime << endl;
    cout << "total:" << readDeltaTime + processDeltaTime + printDeltaTime << endl;
#endif
    
#if DEBUGME
    if (infile.is_open()) {
        infile.close();
    }
#endif
    
    delete dll;
    
//#if DEBUGME
//    time = clock() - doneCompute;
//    int ms = double(time) / CLOCKS_PER_SEC * 1000;
//    cout << "time spend in ms " << ms+computeTime << endl;
//    cout << "compute time " << computeTime << endl;
//    cout << "print time " << ms << endl;
//#endif
    
    return 0;
    
    /*
    for (int i=0; i<cmdsSize; i++) {
#if DEBUGME
        getline(infile, line);
#else
        getline(cin, line);
#endif
        
        vector<string> tokens = split(line, ' ');
        
        if (tokens.size() > 3 || tokens.size() == 0) {
            continue;
        }
        string command[3] = {"", "", ""};
        for (unsigned i=0; i<tokens.size(); i++) {
            command[i] = tokens.at(i);
        }
        
        // command processing
        if (command[0].compare("BOUND") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << " " << command[1] << endl;
#endif
            int newMaxSize = atoi(command[1].c_str());
            dll->setMaxSize(newMaxSize);
        }
        else if (command[0].compare("SET") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << " " << command[1] << " " << command[2] << endl;
#endif
            dll->insertFront(command[1], command[2]);
        }
        else if (command[0].compare("GET") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << " " << command[1] << endl;
#endif
            ListNode *aNode = dll->getNode(command[1]);
            if (aNode == nullptr) {
//                cout << "NULL" << endl;
                finalOutputString += "NULL\n";
            } else {
//                cout << aNode->value << endl;
                finalOutputString += aNode->value + "\n";
            }
        }
        else if (command[0].compare("PEEK") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << " " << command[1] << endl;
#endif
            ListNode *aNode = dll->peekNode(command[1]);
            if (aNode == nullptr) {
//                cout << "NULL" << endl;
                finalOutputString += "NULL\n";
            } else {
//                cout << aNode->value << endl;
                finalOutputString += aNode->value + "\n";
            }
        }
        else if (command[0].compare("DUMP") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << endl;
#endif
            vector<ListNode*> vectList = dll->printAllWithKeyAlphabetical();
//            string outputString = "";
            for (int i=0; i<vectList.size(); i++) {
//                cout << vectList[i]->key + " " + vectList[i]->value << endl;
                finalOutputString += vectList[i]->key + " " + vectList[i]->value + "\n";
            }
        }
    }
    
#if DEBUGME
    clock_t doneCompute = clock() - time;
    int computeTime = double(doneCompute) / CLOCKS_PER_SEC * 1000;
#endif
    
    cout << finalOutputString;
    
#if DEBUGME
    if (infile.is_open()) {
        infile.close();
    }
#endif
    
    delete dll;
    
#if DEBUGME
    time = clock() - doneCompute;
    int ms = double(time) / CLOCKS_PER_SEC * 1000;
    cout << "time spend in ms " << ms+computeTime << endl;
    cout << "compute time " << computeTime << endl;
    cout << "print time " << ms << endl;
#endif
    */
    
    return 0;
}

//int main(int argc, const char * argv[])
//{
//
//    @autoreleasepool {
//    
//        // insert code here...
////        NSLog(@"Hello, World!");
//    
//    }
//    return 0;
//}

