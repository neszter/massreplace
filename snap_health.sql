select substr(tbsp_name,1,20) as Tablespace_Name,
substr(tbsp_type,1,5) as Tbsp_Type,
substr(tbsp_state,1,12) as Tbsp_State,
int(tbsp_total_size_kb/1024) as Tbsp_Size_in_MB,
smallint(tbsp_utilization_percent) as Tbsp_Full_Percent,
int(tbsp_free_size_kb / 1024) as Tbsp_Free_space_in_MB
from sysibmadm.tbsp_utilization
;
SELECT AVG(TIMESTAMPDIFF(4,CHAR(TIMESTAMP(END_TIME) - TIMESTAMP(START_TIME)))) AS AVG_LSDB_Backup_TIME_in_Min,
MAX(TIMESTAMPDIFF(4,CHAR(TIMESTAMP(END_TIME) - TIMESTAMP(START_TIME)))) AS MAX_LSDB_Backup_TIME_in_Min
FROM SYSIBMADM.DB_HISTORY
WHERE OPERATION = 'B'
AND OPERATIONTYPE = 'F'
;
SELECT START_TIME as Failed_Cmd_start_time, SQLCODE, SUBSTR(CMD_TEXT,1,50) as Failed_Cmd_txt
FROM SYSIBMADM.DB_HISTORY
WHERE SQLCODE < 0
;
SELECT TIMESTAMP, SUBSTR(MSG,1,400) AS DB2DIAG_CRIT_AND_ERROR_MSGS
FROM SYSIBMADM.PDLOGMSGS_LAST24HOURS
WHERE MSGSEVERITY IN ('C','E')
ORDER BY TIMESTAMP DESC
;
-- Show me all the messages in the notify log from the last 3 days
--SELECT TIMESTAMP, SUBSTR(MSG,1,400) AS MSG
--FROM TABLE
--( PD_GET_LOG_MSGS( CURRENT TIMESTAMP - 3 DAYS) ) AS PD
--ORDER BY TIMESTAMP DESC
--;
--select
--int(total_log_used_KB/1024) as Log_Used_in_MB,
--int(total_log_available_KB/1024) as Log_Free_in_MB,
--log_utilization_percent as Log_Utilization_Pct,
--int(total_log_used_top_KB/1024) as Max_Log_Used_in_MB
--from sysibmadm.log_utilization
--;
