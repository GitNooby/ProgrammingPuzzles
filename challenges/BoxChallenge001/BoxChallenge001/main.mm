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
#include <cassert>

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
};

class DoublyLinkedList {
private:
    ListNode *head;
    ListNode *tail;
    int currSize;
    int maxSize;
    unordered_map<string, ListNode*> hashMap;
    
    ListNode *findNode(string k);
    void deleteNode(ListNode* node);
public:
    DoublyLinkedList(int size) {
        this->tail = this->head = nullptr;
        this->currSize = 0;
        this->maxSize = size;
        this->maxSize = this->maxSize < 0 ? 0 : this->maxSize;
    }
    ~DoublyLinkedList();
    void insertFront(string k, string v);
    void deleteNode(string k);
    ListNode* getNode(string k);
    ListNode* peekNode(string k);
    void setMaxSize(int newMaxSize);
    map<string, ListNode*> printAllWithKeyAlphabetical();
    void printDLL();
};

ListNode* DoublyLinkedList::findNode(string k) {
    ListNode* node = nullptr;
    unordered_map<string, ListNode*>::iterator it = hashMap.find(k);
    if (it == hashMap.end()) {
        return nullptr;
    }
    node = hashMap[k];
    assert(node != nullptr);
    return node;
}

map<string, ListNode*> DoublyLinkedList::printAllWithKeyAlphabetical() {
    map<string, ListNode*> ordered(hashMap.begin(), hashMap.end());
    return ordered;
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

DoublyLinkedList::~DoublyLinkedList() {
    while (this->tail != nullptr) {
        this->deleteNode(this->tail);
    }
}

void DoublyLinkedList::insertFront(string k, string v) {
    //test cases:
    // Type A: node already exists in list
    //    1. node is already at head
    //    2. node is at tail
    //    3. node is in middle
    //    4. only one node in list
    // Type B: node does not exist in list
    //    1. list is empty
    //    2. list is not empty
    
    
    ListNode *node = this->findNode(k);
    if (node != nullptr) {         // the node already exists in list
        node->value = v;
        if (node == this->head && node == this->tail) { // only one node in list
            return;
        }
        if (node == this->head && node != this->tail) { // node is already in front
            return;
        } else if (node != this->head && node == this->tail) { // node is in back, need to move to front
            ListNode *before = node->prev;
            before->next = nullptr;
            this->tail = before;
            node->prev = nullptr;
            node->next = this->head;
            this->head->prev = node;
            this->head = node;
            return;
        } else if (node != this->head && node != this->tail) { // node is in the middle
            ListNode *before = node->prev;
            ListNode *after = node->next;
            before->next = after;
            after->prev = before;
            node->prev = nullptr;
            node->next = this->head;
            this->head->prev = node;
            this->head = node;
            return;
        }
    }
    else if (node == nullptr) {         // TYPE B: the node was not found in list
        node = new ListNode(k, v);
        hashMap[node->key] = node;
        this->currSize++;
        if (this->head == nullptr) { // empty list
            assert(this->tail == nullptr);
            this->head = node;
            this->tail = node;
        } else { // list is not empty, just insert in front
            node->next = this->head;
            this->head->prev = node;
            this->head = node;
        }
    }
    
    while (this->currSize > this->maxSize) {
        this->deleteNode(this->tail);
    }
}

void DoublyLinkedList::deleteNode(string k) {
    ListNode *aNode = this->findNode(k);
    this->deleteNode(aNode);
}

void DoublyLinkedList::deleteNode(ListNode *node) {
    if (node == nullptr) {
        return;
    }
    
    // 0. only one node
    // 1. node is at back of list
    // 2. node is in middle of list
    // 3. node is at front of list
    if (node == this->tail && node == this->head) {
        this->head = nullptr;
        this->tail = nullptr;
        hashMap.erase(node->key); // note: erase() will call node's destructor, so dont call delete on node
        currSize--;
    }
    else if (this->head != node && this->tail == node) { // node to delete is at tail
        this->tail = node->prev;
        this->tail->next = nullptr;
        node->prev = nullptr;
        hashMap.erase(node->key);
        currSize--;
    }
    else if (this->head == node && this->tail != node) { // node to delete is at head
        this->head = node->next;
        this->head->prev = nullptr;
        node->next = nullptr;
        hashMap.erase(node->key);
        currSize--;
    }
    else if (this->head != node && this->tail != node) { // node to delete is in middle
        ListNode *before = node->prev;
        ListNode *after = node->next;
        before->next = after;
        after->next = before;
        hashMap.erase(node->key);
        currSize--;
    }
}

ListNode* DoublyLinkedList::getNode(string k) {
    ListNode *aNode = this->findNode(k);
    if (aNode == nullptr) {
        return nullptr;
    }
    
    // 1. node is at head
    // 2. node is at tail
    // 3. node is in middle
    
    if (aNode == this->head) { // node is at head
        return aNode;
    }
    else if (aNode == this->tail && aNode != this->head) { // node is at tail
        this->tail = aNode->prev;
        this->tail->next = nullptr;
        aNode->prev = nullptr;
        aNode->next = this->head;
        this->head->prev = aNode;
        this->head = aNode;
    }
    else if (aNode != this->tail && aNode != this->head) { // node is in middle
        ListNode *before = aNode->prev;
        ListNode *after = aNode->next;
        before->next = after;
        after->prev = before;
        aNode->prev = nullptr;
        aNode->next = this->head;
        this->head->prev = aNode;
        this->head = aNode;
    }
    return aNode;
}

ListNode* DoublyLinkedList::peekNode(string k) {
    return this->findNode(k);
}

void DoublyLinkedList::setMaxSize(int newMaxSize) {
    this->maxSize = newMaxSize;
    this->maxSize = this->maxSize < 0 ? 0 : this->maxSize;
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
    
#if DEBUGME
    cout << "start" << endl;
    clock_t startTime = clock();
#endif
    
#if DEBUGME
    ifstream infile("/Users/kaizou/Documents/test_dir/ProgrammingPuzzles/challenges/BoxChallenge001/BoxChallenge001/test.txt");
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
        if (args.size() <= 0 && args.size() > 3) {
            continue;
        }
        
        if (args[0].compare("BOUND") == 0) {
            int newMaxSize = atoi(args[1].c_str());
            dll->setMaxSize(newMaxSize);
        } else if (args[0].compare("SET") == 0) {
            dll->insertFront(args[1], args[2]);
        } else if (args[0].compare("GET") == 0) {
            ListNode *aNode = dll->getNode(args[1]);
            if (aNode == nullptr) {
                finalOutputString += "NULL\n";
            } else {
                finalOutputString += aNode->value + "\n";
            }
        } else if (args[0].compare("PEEK") == 0) {
            ListNode *aNode = dll->peekNode(args[1]);
            if (aNode == nullptr) {
                finalOutputString += "NULL\n";
            } else {
                finalOutputString += aNode->value + "\n";
            }
        } else if (args[0].compare("DUMP") == 0) {
            map<string, ListNode*> mapList = dll->printAllWithKeyAlphabetical();
            for (map<string, ListNode*>::iterator it=mapList.begin(); it!=mapList.end(); ++it) {
                finalOutputString += it->first + " " + it->second->value + "\n";
            }
        }
        
#if PRINTALL
        dll->printDLL();
#endif
    }

#if DEBUGME
    clock_t doneProcess = clock();
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

