//A. fill in the missing relationships between affiliation and responses
MATCH (a)-[]->(p)-[]->(r)
WHERE NOT (a)-[:IS_ASSOCIATED_WITH]->(r)
MERGE (a)-[:IS_ASSOCIATED_WITH]-(r)

//B. Count number of relatiomnship
MATCH (a)-[x:IS_ASSOCIATED_WITH]-(r)
RETURN COUNT(x)

