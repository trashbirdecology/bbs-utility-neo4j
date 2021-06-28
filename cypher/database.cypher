
// 02. People, Affilations

LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/people.csv" AS row

MERGE (p:Person{id:row.PersonId, name:row.PersonName})
MERGE (o:Organization{id:row.OrganizationId, name:row.OrganizationName})
MERGE (a:Affiliation{id:row.AffiliationId, name:row.AffiliationName})
MERGE (p) -[:HAS_EMPLOYER]-> (o)
MERGE (p) -[:HAS_AFFILIATION]-> (a);



//03. Person to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/person_to_resp.csv" AS row
MERGE (r:Response{id:row.RespId, name:row.RespName})

WITH row
WHERE row.PersonId IS NOT NULL
MERGE (p:Person{id:row.PersonId})

WITH row
WHERE row.OrganizationId IS NOT NULL
MERGE (o:Organization{id:row.OrganizationId, name:row.OrganizationName})
MERGE (a:Affiliation{id:row.AffiliationId, name:row.AffiliationName})
MERGE (p)-[:HAS_RESPONSE]->(r)
MERGE (o)-[:IS_ASSOCIATED_WITH]->(r)
MERGE (a)-[:IS_ASSOCIATED_WITH]->(r);


///SOMETHIGN IS WRONG WIHT .04, but it shouldnt be needed if all responses have a person assigned.
//04. Affiliation to Response
//LOAD CSV WITH HEADERS FROM
//"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/aff_to_resp.csv" AS row

//MERGE (r:Response{id:row.RespId, name:row.RespName})
//MERGE (a:Affiliation{id:row.AffiliationId, name:row.AffiliationName})
//MERGE (a)-[:IS_ASSOCIATED_WITH]->(r);


//05. Response to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/resp_to_resp.csv" AS row

MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (rc:ResponseChild{id:row.RespChildId, name:row.RespChildName})
MERGE (r)-[:HAS_CHILD]->(rc);


//06. JLB to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/jlb_to_resp.csv" AS row

MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (r)-[:HAS_INTERPRETATION]->(j);


//07. JLB to Paraphrased
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/jlb_to_para.csv" AS row

MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (para)-[:IS_CLASSIFIED_AS]->(j);


//08. Paraphrased to Response
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/para_to_resp.csv" AS row

MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (r)-[:IS_PARAPHRASED_AS]->(para);


//09. Response to Paraphrased
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/resp_to_para.csv" AS row

MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (r)-[:HAS_CHILD]->(para);


//10. Response to JLB
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/resp_to_jlb.csv" AS row

MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (r)-[:HAS_CHILD]->(j);


//11. EUTS to JLB
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/euts_to_jlb.csv" AS row

MERGE (e:`End User Type`{id:row.EutsId, name:row.EutsName})
MERGE (j:`JLB Interpretation`{id:row.JlbId, name:row.JlbName})
MERGE (j)-[:IS_USER_TYPE]->(e);


//12. EUTS to Paraphrased
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/euts_to_para.csv" AS row

MERGE (para:Paraphrases{id:row.ParaId, name:row.ParaName})
MERGE (e:`End User Type`{id:row.EutsId, name:row.EutsName})
MERGE (p)-[:IS_USER_TYPE]->(e);


//13. Response to Question Type
LOAD CSV WITH HEADERS FROM
"file:////Users/jburnett/OneDrive%20-%20DOI/research/bbs_utility/neo4j-brain-data/data/question_to_resp.csv" AS row

MERGE (q:Question{id:row.QuestionId, name:row.QuestionName})
MERGE (r:Response{id:row.RespId, name:row.RespName})
MERGE (r)-[:ANSWERS_QUESTION]->(q);
