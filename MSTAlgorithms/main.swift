//
//  main.swift
//  MSTAlgorithms
//
//  Created by Ts SaM on 27/8/2023.
//

import Foundation

import Foundation

/// Minimum Spanning Tree Algorithms
public final class MST {
    
    /// Prim's MST Algorithm O(ElgV)
    /// Use Priority Queue (Binary Heap) and Adjacency List
    /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple - graph is 1-indexed
    /// - Returns: the minimum cost spanning tree
    public func primMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
        
        let vertexCount = graph.count
        var mstCost = 0
        var visited = [Bool](repeating: false, count: vertexCount + 1)
        var priorityQueue = IndexPriorityQueue<Int>({ $0 < $1 })
        
        priorityQueue.enqueue(1)
        
        while let currentVertex = priorityQueue.dequeue() {
            if visited[currentVertex] {
                continue
            }
            
            visited[currentVertex] = true
            
            for edge in graph[currentVertex] {
//                print(graph[currentVertex])
                let neighborVertex = edge.v
                let edgeWeight = edge.w
                
                if !visited[neighborVertex] {
//                    print(neighborVertex)
                    priorityQueue.enqueue(neighborVertex)
                }
            }
            mstCost += priorityQueue.elements[currentVertex]
        }
        
        return mstCost
    }
    
    /// Kruskal's MST Algorithm O(ElgE)
    /// Use Union-Find and Adjacency List (You can use Swift's built-in sort method.)
    /// - Parameter graph: adjacency list of weighted undirected graph where each edge is stored as Tuple - graph is 1-indexed
    /// - Returns: the minimum cost spanning tree
    public func kruskalMST(_ graph: [[(v: Int, w: Int)]]) -> Int {
        
        let vertexCount = graph.count
        var mstCost = 0
        var edges = [(u: Int, v: Int, w: Int)]()
        
        for u in 1..<vertexCount {
            for edge in graph[u] {
//                print("\(edge.v) , \(edge.w)")
                edges.append((u, edge.v, edge.w))
            }
        }
        edges.sort(by: { $0.w < $1.w })
        
        var uf = UF(vertexCount);
        for edge in edges {
            let u = edge.u
            let v = edge.v
            let w = edge.w
            
            if !uf.connected(u, v) {
                uf.union(u, v)
                mstCost += w
            }
        }
        return mstCost
    }
}
