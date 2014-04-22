//
//  GraphObject.cpp
//  GraphAlgorithms
//
//  Created by Kai Zou on 2014-04-21.
//  Copyright (c) 2014 com.personal. All rights reserved.
//

#include "GraphObject.h"
#include <assert.h>

AdjListNode::AdjListNode() {
    this->nextEdge = nullptr;
    this->nextVertex = nullptr;
    this->weight = 0;
}

GraphObject::GraphObject(bool isDirected) {
    this->graphAdjacencyList = nullptr;
    this->numVertices = 0;
    this->numEdges = 0;
    this->isDirected = isDirected;
}
AdjListNode* GraphObject::getGraph() {
    return this->graphAdjacencyList;
}
bool GraphObject::getIsDirected() {
    return this->isDirected;
}

AdjListNode* GraphObject::insertSingleVertex(int uNodeName) {
    AdjListNode *uVertex = this->generateVertexWithName(uNodeName);
    return uVertex;
}

AdjListNode* GraphObject::insertEdge(int uNodeName, int vNodeName, float weight) {
    // if directed, then u is parent of v
    assert(uNodeName != 0);
    assert(uNodeName != 0);
    
    // create the vertices
    AdjListNode *uVertex = this->generateVertexWithName(uNodeName); //generates only if not found
    AdjListNode *vVertex = nullptr;
    if (vNodeName != 0) {
        vVertex = this->generateVertexWithName(vNodeName);
    }
    
    // create the edge for uv
    AdjListNode *uvEdge = this->createAndInsertEdge(uVertex, vVertex, weight);
    AdjListNode *vuEdge = nullptr;
    if (this->isDirected == false && vNodeName != 0) {
        vuEdge = this->createAndInsertEdge(vVertex, uVertex, weight);
    }
    
    if (uvEdge != nullptr) {
        this->numEdges++;
    }
    return uvEdge;
}

AdjListNode* GraphObject::getVertexWithName(int uNodeName) {
    for (AdjListNode *t=this->graphAdjacencyList; t!=nullptr; t=t->nextVertex) {
        if (t->vertexName == uNodeName) {
            return t;
        }
    }
    return nullptr;
}

AdjListNode* GraphObject::getEdgeFromUToV(AdjListNode *uVertex, AdjListNode *vVertex) {
    // returns u-v edge, null otherwise
    AdjListNode *edgeFromU = uVertex->nextEdge;
    for (; edgeFromU != nullptr; edgeFromU=edgeFromU->nextEdge) {
        if (edgeFromU->vertexName == vVertex->vertexName) {
            return edgeFromU;
        }
    }
    return nullptr;
}

/**
 ****** Private class functions *********
 */
AdjListNode* GraphObject::createAndInsertEdge(AdjListNode *uVertex, AdjListNode *vVertex, float weight) {
    // returns the created edge
    
    // determine if we have to create the edge
    AdjListNode *uvEdge = this->getEdgeFromUToV(uVertex, vVertex);
    if (uvEdge == nullptr) { // edge already inserted
        return uvEdge;
    }
    uvEdge = new AdjListNode();
    uvEdge->vertexName = vVertex->vertexName; // u is connected to v
    uvEdge->weight = weight;
    if (this->isDirected == false) {
        uvEdge->nextVertex = uVertex; // if undirected, then point back
    }
    AdjListNode *uAdjEdgeList = uVertex->nextEdge;
    if (uAdjEdgeList->nextEdge == nullptr) {
        uVertex->nextEdge = uvEdge;
        uvEdge->nextEdge = nullptr;
    } else {
        uvEdge->nextEdge = uVertex->nextEdge;
        uVertex->nextEdge = uvEdge;
    }
    return uvEdge;
}

AdjListNode* GraphObject::generateVertexWithName(int uNodeName) {
    if (uNodeName == 0) { //A vertex of name 0 is reserved
        return nullptr;
    }
    AdjListNode *u = this->getVertexWithName(uNodeName);
    if (u == nullptr) {
        u = new AdjListNode();
        u->vertexName = uNodeName;
        u->weight = 0;
        u->nextEdge = nullptr;
        if (this->graphAdjacencyList == nullptr) {
            this->graphAdjacencyList = u;
        } else {
            u->nextVertex = this->graphAdjacencyList;
            this->graphAdjacencyList = u;
        }
        this->numVertices += 1;
    }
    return u;
}

