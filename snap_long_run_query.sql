SELECT ELAPSED_TIME_MIN,
SUBSTR(AUTHID,1,10) AS AUTH_ID,
AGENT_ID as APP_Handle,
APPL_STATUS,
SUBSTR(STMT_TEXT,1,950) AS SQL_TEXT
FROM SYSIBMADM.LONG_RUNNING_SQL
WHERE 
--ELAPSED_TIME_MIN > 0    
--and
APPL_STATUS <> 'UOWWAIT'
ORDER BY ELAPSED_TIME_MIN DESC
;
