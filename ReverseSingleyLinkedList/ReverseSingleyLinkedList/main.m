//
//  main.m
//  ReverseSingleyLinkedList
//
//  Created by Kai Zou on 2014-03-04.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct node {
    int data;
    struct node *next;
} Node;

Node* reverseLinkedList(Node *root) {
    Node *new_root = NULL;
    
    Node *temp;
    while (root != NULL) {
        temp = root->next;
        root->next = new_root;
        new_root = root;
        root = temp;
    }
    
    return new_root;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Node d = {0, NULL};
        Node c = {1, &d};
        Node b = {2, &c};
        Node a = {3, &b};
        
        Node *root = &a;
        
        root = reverseLinkedList(&a);
        
    }
    return 0;
}

