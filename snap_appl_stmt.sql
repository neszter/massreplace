SELECT ELAPSED_TIME_MIN,
SUBSTR(AUTHID,1,10) AS APPL_AUTH_ID,
AGENT_ID as Long_running_APPL_Handle,
APPL_STATUS,
--SUBSTR(STMT_TEXT,1,950) AS Long_Runnning_SQL_TEXT
SUBSTR(STMT_TEXT,1,150) AS Current_Long_Runnning_SQL_TEXT
FROM SYSIBMADM.LONG_RUNNING_SQL
WHERE
ELAPSED_TIME_MIN > 0
--and
--APPL_STATUS <> 'UOWWAIT'
ORDER BY ELAPSED_TIME_MIN DESC
;
--select substr(ai.primary_auth_id,1,10) as Appl_AuthId
--,substr(ai.appl_name,1,30) as Appl_Name
--,int(ai.agent_id) as Appl_Handle
----,ai.agent_id as Appl_Handle
--,substr(ai.appl_status,1,8) as Appl_Status
--,ai.STATUS_CHANGE_TIME
----,substr(ai.appl_id,1,30) as Appl_Id
----,UOW_LOG_SPACE_USED as Log_Space_Used_Byte
----,dec(((UOW_LOG_SPACE_USED/1024)/1024),18,2) as LOG_SPACE_Used_MB
----,dec((UOW_LOG_SPACE_USED/1024),18,2) as LOG_SPACE_Used_KB
--,dec((float(rows_read)/float(rows_selected)),18,2) as  AvgRowsRd_perSelRows
----,dec(aprm.PERCENT_ROWS_SELECTED,18,2) as PERCENT_ROWS_SELECTED
----,aprm.PERCENT_ROWS_SELECTED
--from sysibmadm.snapappl ap, sysibmadm.snapappl_info ai
----,sysibmadm.APPL_PERFORMANCE aprm
--where ap.agent_id = ai.agent_id
----and ai.agent_id = aprm.agent_id 
----and rows_selected > 0
--and float(rows_selected) > 0
----and ai.appl_status <> 'UOWWAIT'
--and ai.primary_auth_id <> 'DB2INST1'
--;
----SELECT SUBSTR(STMT_TEXT,1,950) as Most_Executed_Dynamic_Stmt 
--SELECT SUBSTR(STMT_TEXT,1,100) as Most_Executed_Dynamic_Stmt
--,NUM_EXECUTIONS
--FROM SYSIBMADM.TOP_DYNAMIC_SQL
--ORDER BY NUM_EXECUTIONS DESC
--FETCH FIRST ROW ONLY
--FETCH FIRST 5 ROWS ONLY
--;
--SELECT 
----SUBSTR(STMT_TEXT,1,7550) as Longest_Avg_Exec_Time,
--SUBSTR(STMT_TEXT,1,1500) as Stmt_With_Longest_Avg_Exec_Time,
--AVERAGE_EXECUTION_TIME_S as AVERAGE_EXECUTION_TIME_in_Sec
--FROM SYSIBMADM.TOP_DYNAMIC_SQL
--ORDER BY AVERAGE_EXECUTION_TIME_in_Sec DESC
----FETCH FIRST ROW ONLY
--FETCH FIRST 15 ROWS ONLY
--;
