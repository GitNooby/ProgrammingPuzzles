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
    
};

class DoublyLinkedList {
private:
    ListNode *head;
    ListNode *tail;
    int currSize;
    int maxSize;
    
    void removeLast();
public:
    DoublyLinkedList(int size) {
        tail = head = nullptr;
        currSize = 0;
        maxSize = size;
    }
    ~DoublyLinkedList();
    void insertFront(string k, string v);
    void deleteNode(ListNode* node);
    ListNode *findNode(string k);
    void deleteNode(string k);
    ListNode* getNode(string k);
    ListNode* peekNode(string k);
    void setMaxSize(int newMaxSize);
    vector<ListNode> printAllWithKeyAlphabetical();
    void printDLL();
};

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
    ListNode *aNode = new ListNode(k, v);
    
    if (this->head == nullptr) {
        this->head = aNode;
        this->tail = aNode;
        this->currSize++;
    } else {
        ListNode *frontNode = head;
        this->head = aNode;
        aNode->next = frontNode;
        frontNode->prev = aNode;
        this->currSize++;
    }
    
    while (this->currSize > this->maxSize) {
        this->deleteNode(this->tail);
    }
}

ListNode* DoublyLinkedList::findNode(string k) {
    ListNode *iter = this->head;
    while (iter != nullptr) {
        if (iter->key.compare(k) == 0) {
            break;
        }
        iter = iter->next;
    }
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
    while (this->currSize > this->maxSize) {
        this->deleteNode(this->tail);
    }
}

vector<ListNode> DoublyLinkedList::printAllWithKeyAlphabetical() {
    vector<ListNode> vectList;
    
    ListNode *aNode = this->head;
    while (aNode != nullptr) {
        vectList.push_back(ListNode(aNode->key, aNode->value));
        aNode = aNode->next;
    }
    
//    sort(vectList.begin(), vectList.end());
    
    return vectList;
}


std::vector<std::string> &split(const std::string &s, char delim, std::vector<std::string> &elems) {
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}


std::vector<std::string> split(const std::string &s, char delim) {
    std::vector<std::string> elems;
    split(s, delim, elems);
    return elems;
}

#define DEBUGME 1
#define PRINTALL 0

int main() {
    
#if DEBUGME
    ifstream infile("/Volumes/SecondaryHDD/PersonalProjectsHDD/project_repos/ProgrammingPuzzles/challenges/BoxChallenge001/BoxChallenge001/test.txt");
    if (infile.is_open() == false) {
        return -1;
    }
#endif
    
    DoublyLinkedList *dll = new DoublyLinkedList(0);
    
    string numCommands;
#if DEBUGME
    getline(infile, numCommands);
#else
    getline(cin, numCommands);
#endif
    int cmdsSize = atoi(numCommands.c_str());

#if PRINTALL
    cout << "cmdsSize " << cmdsSize << endl;
#endif
    
    string line;
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
                cout << "NULL" << endl;
            } else {
                cout << aNode->value << endl;
            }
        }
        else if (command[0].compare("PEEK") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << " " << command[1] << endl;
#endif
            ListNode *aNode = dll->peekNode(command[1]);
            if (aNode == nullptr) {
                cout << "NULL" << endl;
            } else {
                cout << aNode->value << endl;
            }
        }
        else if (command[0].compare("DUMP") == 0) {
#if PRINTALL
            cout << "cmd: " << command[0] << endl;
#endif
            vector<ListNode> vectList = dll->printAllWithKeyAlphabetical();
            for (int i=0; i<vectList.size(); i++) {
                cout << vectList[i].key + " " + vectList[i].value << endl;
            }
        }
        else {
#if PRINTALL
            cout << "bad command" << endl;
            return -1;
#endif
        }
        
#if PRINTALL
//        dll->printDLL();
#endif
        
        
    }
    
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

