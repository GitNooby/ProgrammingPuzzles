////
////  DoublyLinkedList.cpp
////  BoxChallenge001
////
////  Created by Kai Zou on 2014-05-14.
////  Copyright (c) 2014 com.personal. All rights reserved.
////
//
//#include "DoublyLinkedList.h"
//
//bool ListNode::operator<(const ListNode& a) const {
//    if (this->key.compare(a.key) <= 0) {
//        return true;
//    }
//    return false;
//}
//
//DoublyLinkedList::~DoublyLinkedList() {
//    while (this->tail != nullptr) {
//        this->deleteNode(this->tail);
//    }
//}
//
//void DoublyLinkedList::insertFront(string k, string v) {
//    ListNode *aNode = new ListNode(k, v);
//    
//    if (this->head == nullptr) {
//        this->head = aNode;
//        this->tail = aNode;
//        this->currSize++;
//    } else {
//        ListNode *frontNode = head;
//        this->head = aNode;
//        aNode->next = frontNode;
//        frontNode->prev = aNode;
//        this->currSize++;
//    }
//    
//    while (this->currSize > this->maxSize) {
//        this->deleteNode(this->tail);
//    }
//}
//
//ListNode* DoublyLinkedList::findNode(string k) {
//    ListNode *iter = this->head;
//    while (iter != nullptr) {
//        if (iter->key.compare(k) == 0) {
//            break;
//        }
//        iter = iter->next;
//    }
//    return iter;
//}
//
//void DoublyLinkedList::deleteNode(string k) {
//    ListNode *aNode = this->findNode(k);
//    this->deleteNode(aNode);
//}
//
//void DoublyLinkedList::deleteNode(ListNode *node) {
//    if (node == nullptr) {
//        return;
//    }
//    if (node == this->tail && node == this->head) {
//        this->tail = nullptr;
//        this->head = nullptr;
//        delete node;
//        currSize--;
//        return;
//    }
//    
//    ListNode *before, *after;
//    before = node->prev;
//    after = node->next;
//    if (before != nullptr) {
//        before->next = after;
//    }
//    if (after != nullptr) {
//        after->prev = before;
//    }
//    if (this->tail == node) {
//        this->tail = node->prev;
//    }
//    if (this->head == node) {
//        this->head = node->next;
//    }
//    delete node;
//    currSize--;
//}
//
//ListNode* DoublyLinkedList::getNode(string k) {
//    ListNode *aNode = this->findNode(k);
//    if (aNode == nullptr) {
//        return nullptr;
//    }
//    
//    if (aNode == this->head) {
//        return aNode;
//    }
//    
//    ListNode *before = aNode->prev;
//    ListNode *after = aNode->next;
//    if (before != nullptr) {
//        before->next = after;
//    }
//    if (after != nullptr) {
//        after->prev = before;
//    }
//    aNode->prev = nullptr;
//    aNode->next = this->head;
//    this->head = aNode;
//    return aNode;
//}
//
//ListNode* DoublyLinkedList::peekNode(string k) {
//    ListNode *aNode = this->findNode(k);
//    return aNode;
//}
//
//void DoublyLinkedList::setMaxSize(int newMaxSize) {
//    this->maxSize = newMaxSize;
//    while (this->currSize > this->maxSize) {
//        this->deleteNode(this->tail);
//    }
//}
//
//vector<ListNode> DoublyLinkedList::printAllWithKeyAlphabetical() {
//    vector<ListNode> vectList;
//    
//    ListNode *aNode = this->head;
//    while (aNode != nullptr) {
//        vectList.push_back(ListNode(aNode->key, aNode->value));
//        aNode = aNode->next;
//    }
//    
//    sort(vectList.begin(), vectList.end());
//    
//    return vectList;
//}
//
//
//
//
//
//
//
