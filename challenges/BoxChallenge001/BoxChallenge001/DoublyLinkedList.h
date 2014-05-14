////
////  DoublyLinkedList.h
////  BoxChallenge001
////
////  Created by Kai Zou on 2014-05-14.
////  Copyright (c) 2014 com.personal. All rights reserved.
////
//
//#ifndef __BoxChallenge001__DoublyLinkedList__
//#define __BoxChallenge001__DoublyLinkedList__
//
//#include <iostream>
//#include <string>
//#include <vector>
//#include <algorithm>
//
//using namespace std;
//
//class ListNode {
//public:
//    string key;
//    string value;
//    ListNode *prev;
//    ListNode *next;
//    ListNode(string k, string v) {
//        this->key = k;
//        this->value = v;
//        prev = next = nullptr;
//    }
//    bool operator<(const ListNode& a) const;
//    
//};
//
//class DoublyLinkedList {
//private:
//    ListNode *head;
//    ListNode *tail;
//    int currSize;
//    int maxSize;
//    
//    void removeLast();
//public:
//    DoublyLinkedList(int size) {
//        tail = head = nullptr;
//        currSize = 0;
//        maxSize = size;
//    }
//    ~DoublyLinkedList();
//    void insertFront(string k, string v);
//    void deleteNode(ListNode* node);
//    ListNode *findNode(string k);
//    void deleteNode(string k);
//    ListNode* getNode(string k);
//    ListNode* peekNode(string k);
//    void setMaxSize(int newMaxSize);
//    vector<ListNode> printAllWithKeyAlphabetical();
//};
//
//#endif /* defined(__BoxChallenge001__DoublyLinkedList__) */
