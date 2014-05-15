This is an implementation of a LRU cache.
The implementation uses a Doubly Linked List and the STL unorder_map (a hashmap) to maintain LRU behaviour.

Each data node is represented by a key/value pair

The DLL is used to maintain cache size, new data is added to the head, least recently used data is removed from the tail. Accessed data is promoted from the middle of the list to the head (to track most recently used data).

The Hashmap is actually not necessary, however, it is used to for O(1) search so that we won't have to traverse the DLL.

All code has been moved to a single main.mm file... I know it's messy having headers in a single file along with their definitions. The other .cpp and .h files are not maintained and are old versions of the DLL LRU cache implementation.
