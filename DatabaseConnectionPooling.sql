/*
	What is Database Connection Pooling?
	Database Connection Pooling is a method used to keep database connections open so they can be reused by others.

	Typically, opening a database connection is an expensive operation, especially if the database is remote. You have to open up network
	sessions, authenticate, have authorization checked, and so on. Pooling keeps the connections active so that, when a connection is later
	requested, one of the active ones is used in preference to having to create another one.

	Refer to the following diagram for the next few paragraphs:

	 +-----------+
	 |           |
	 | Clients   |
	 +---------+ |
	 |         |-+  (1)   +------+   (3)    +----------+
	 | Clients | ===#===> | Open | =======> | RealOpen |
	 |         |    |     +------+          +----------+
	 +---------+    |         ^
			        |         | (2)
			        |     /------\
			        |     | Pool |
			        |     \------/
			    (4) |         ^
			        |         | (5)
			        |     +-------+   (6)   +-----------+
			        #===> | Close | ======> | RealClose |
						  +-------+         +-----------+

	In it's simplest form, it's just a similar API call:
	1. To an open-connection API call which is similar to the "real" one. This first checks the pool for a suitable connection.
	2. And, if one is available that's given to the client otherwise a new one is created.
	3. A "suitable connection" is just one that already has access to the database using the correct information (such as database instance,
	   credentials and possibly other things).
	
	Similarly there's a close API call:
	4. Which doesn't actually call the real close-connection, rather it puts the connection into the pool.
	5. For later use, at some point connections in the pool may be actually closed.

	That'a a pretty simplistic explanation. Real implementations may be able to handle connections to multiple servers and multiple user
	accounts, they may pre-allocate some baseline of connections so some are ready immediately, and they may actually close old connections
	when the usage pattern quietens down.
*/