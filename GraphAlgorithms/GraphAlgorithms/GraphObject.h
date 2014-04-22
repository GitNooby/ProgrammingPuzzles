//
//  GraphObject.h
//  GraphAlgorithms
//
//  Created by Kai Zou on 2014-04-21.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#ifndef __GraphAlgorithms__GraphObject__
#define __GraphAlgorithms__GraphObject__

#include <iostream>
#include <vector>

using namespace std;

class AdjListNode {
public:
    AdjListNode *nextEdge;
    AdjListNode *nextVertex;
    int vertexName;
    float weight;
public:
    AdjListNode();
};

class GraphObject {
private:
    AdjListNode *graphAdjacencyList;
//    AdjListNode *lastVertex;
    int numVertices;
    int numEdges;
    bool isDirected;
public:
    GraphObject(bool isDirected);
    bool getIsDirected();
    AdjListNode* getGraph();
    AdjListNode* insertEdge(int uNodeName, int vNodeName, float weight);
    AdjListNode* insertSingleVertex(int uNodeName);
    AdjListNode* getVertexWithName(int uNodeName);
    AdjListNode* getEdgeFromUToV(AdjListNode *uVertex, AdjListNode *vVertex);
private:
    AdjListNode* createAndInsertEdge(AdjListNode *uVertex, AdjListNode *vVertex, float weight);
    AdjListNode* generateVertexWithName(int uNodeName);
    
};

#endif /* defined(__GraphAlgorithms__GraphObject__) */
