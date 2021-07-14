
// 02a. People, Organizations, Affiliations

LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/people.csv" AS row

MERGE (p:Person{id:row.PersonId, name:row.PersonName})
MERGE (o:Organization{id:row.OrganizationId, name:row.OrganizationName})
MERGE (a:Affiliation{id:row.AffiliationId, name:row.AffiliationName})
MERGE (p) -[:HAS_EMPLOYER]-> (o)
MERGE (p) -[:HAS_AFFILIATION]-> (a);


//02b. Person to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/person_to_resp.csv" AS row
WITH row
WHERE row.PersonId IS NOT NULL
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (p:Person{id:row.PersonId, name:row.PersonName})
MERGE (p)-[:HAS_RESPONSE]->(r);

//03. Affiliation to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/aff_to_resp.csv" AS row
WITH row
WHERE row.AffiliationId IS NOT NULL
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (a:Affiliation{id:row.AffiliationId})
MERGE (a)-[:IS_ASSOCIATED_WITH]->(r);


//04. Response to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/resp_to_resp.csv" AS row

MERGE (r:Response{id:row.RespIdParent, name:row.RespNameParent})
MERGE (rc:ResponseChild{id:row.RespIdChild, name:row.RespNameChild})
MERGE (r)-[:HAS_CHILD]->(rc);


//05. JLB to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/jlb_to_resp.csv" AS row

MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (r)-[:HAS_INTERPRETATION]->(j);


//06. JLB to Paraphrased
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/jlb_to_para.csv" AS row

MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (para)-[:IS_CLASSIFIED_AS]->(j);


//07. Paraphrased to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/para_to_resp.csv" AS row

MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (r)-[:IS_PARAPHRASED_AS]->(para);


//08. Response to Paraphrased
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/resp_to_para.csv" AS row

MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (r)-[:HAS_CHILD]->(para);


//09. Response to JLB
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/resp_to_jlb.csv" AS row

MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (r)-[:HAS_CHILD]->(j);


//10. EUTS to JLB
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/euts_to_jlb.csv" AS row

MERGE (e:`End User Type`{id:row.EutsId, name:row.EutsName})
MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (j)-[:IS_USER_TYPE]->(e);


//11. EUTS to Paraphrased
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/euts_to_para.csv" AS row

MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (e:`End User Type`{id:row.EutsId, name:row.EutsName})
MERGE (p)-[:IS_USER_TYPE]->(e);


//12. Response to Question Type
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/question_to_resp.csv" AS row

MERGE (q:Question{id:row.QuestionId, name:row.QuestionName})
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (r)-[:ANSWERS_QUESTION]->(q);
