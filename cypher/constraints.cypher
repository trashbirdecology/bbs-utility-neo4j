//00. Clear Data and Schema
//All nodes and relationships.
MATCH (n) DETACH DELETE n;
// All indexes and constraints.
CALL apoc.schema.assert({},{},true) YIELD label, key;

//01. Set Constraints
//clear all existing constraints
CALL apoc.schema.assert({},{},true) YIELD label, key;


//set constraints
//people, org, aff
CREATE CONSTRAINT pId ON (p:Person) ASSERT p.id IS UNIQUE;
CREATE CONSTRAINT pName ON (p:Person) ASSERT p.name IS UNIQUE;

CREATE CONSTRAINT oId ON (o:Organization) ASSERT o.id IS UNIQUE;
CREATE CONSTRAINT oName ON (o:Organization) ASSERT o.name IS UNIQUE;

CREATE CONSTRAINT aId ON (a:Affiliation) ASSERT a.id IS UNIQUE;
CREATE CONSTRAINT aName ON (a:Affiliation) ASSERT a.name IS UNIQUE;

// end user type
CREATE CONSTRAINT eId ON (e:`End User Type`) ASSERT e.id IS UNIQUE;
CREATE CONSTRAINT eName ON (e:`End User Type`) ASSERT e.name IS UNIQUE;

// questions and responses
CREATE CONSTRAINT qId ON (q:Question) ASSERT q.id IS UNIQUE;
CREATE CONSTRAINT qName ON (q:Question) ASSERT q.name IS UNIQUE;
CREATE CONSTRAINT rId ON (r:Response) ASSERT r.id IS UNIQUE;
CREATE CONSTRAINT rName ON (r:Response) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT rcId ON (rc:Response) ASSERT rc.id IS UNIQUE;
CREATE CONSTRAINT rcName ON (rc:Response) ASSERT rc.name IS UNIQUE;


// JLB and Paraphrased
CREATE CONSTRAINT jId ON (j:`JLB Interpretation`) ASSERT j.id IS UNIQUE;
CREATE CONSTRAINT jName ON (j:`JLB Interpretation`) ASSERT j.name IS UNIQUE;
CREATE CONSTRAINT paraId ON (para:Paraphrases) ASSERT para.id IS UNIQUE;
CREATE CONSTRAINT paraName ON (para:Paraphrases) ASSERT para.name IS UNIQUE;
