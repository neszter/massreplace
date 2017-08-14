select
SNAPSHOT_TIMESTAMP,
--INT_COMMITS,
--INT_ROLLBACKS,
--COMMIT_SQL_STMTS,
--ROLLBACK_SQL_STMTS, 
(INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS) as TOT_NUMBER_TRANSACTIONS,
-- Assume each snapshot counter runs/sleeps for 15 minutes or 900 seconds after reset monitor
((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/900) as AVG_TXNS_PER_SECOND_15MINS
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/1800) as AVG_TXNS_PER_SECOND_30MINS
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/60) as AVG_TXNS_PER_SECOND_1MINS
from SYSIBMADM.snapdb
;
select
int(total_log_used_KB/1024) as Log_Used_MB,
int(total_log_available_KB/1024) as Log_Free_MB,
log_utilization_percent as Log_Pct_Used,
int(total_log_used_top_KB/1024) as Max_Log_Used_MB
from sysibmadm.log_utilization
;
--  If Log_Read_Hit_Ratio < 98% then consider increasing the size of LOGBUFSZ further.
--  the big win with LOGBUFSZ comes from being able to do a single write from LOGBUFSZ memory to disk to facilitate COMMIT processing.
--  When the LOGBUFSZ memory is too small, DB2 may have to do multiple physical write I/Os within the scope of a single transaction - bad for performance. 
--
--The cleaning of old pages in the buffer pool is governed by the softmax database configuration parameter.
--If the page cleaning is effective then log_held_by_dirty_pages should be less than or approximately equal to
-- (softmax / 100)  *  logfilsiz * 4096
-- If this statement is not true, increase the number of page cleaners (num_iocleaners) configuration parameter.
-- If the condition is true and it is desired that less log be held by dirty pages, then decrease the softmax configuration parameter
--
with softmax as
(select float(int(value)) as softmax
from sysibmadm.dbcfg
where name = 'softmax'
),
logfilsiz as
(select float(int(value)*4096) as logfilsiz
from sysibmadm.dbcfg
where name = 'logfilsiz'
)
select 
--COMMIT_SQL_STMTS,
--ROLLBACK_SQL_STMTS,
--(INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS) as TOT_NUM_TRANSACTIONS,
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/900) as AVG_TXNS_PER_SEC_15MINS,
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/1800) as AVG_TXNS_PER_SEC_30MINS,
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/60) as AVG_TXNS_PER_SEC_1MINS,
int(100-((NUM_LOG_READ_IO*100)/LOG_READS)) as Log_Read_Hit_Ratio,
--dec(softmax,18,2) as softmax,
--dec(logfilsiz,18,2) as logfilsiz,
dec(((float(int(LOG_HELD_BY_DIRTY_PAGES))/1024)/1024),18,2) as LOG_HELD_DRTY_PG_MB,
dec(((((softmax/100)*logfilsiz)/1024)/1024),18,2) as LOG_HELD_LIMIT_MB,
NUM_LOG_BUFFER_FULL,
NUM_LOG_READ_IO,
NUM_LOG_DATA_FOUND_IN_BUFFER,
int((NUM_LOG_READ_IO/NUM_LOG_DATA_FOUND_IN_BUFFER)*100) as Log_Disk_to_Buf_Read_Ratio
from sysibmadm.snapdb,softmax,logfilsiz
where
NUM_LOG_DATA_FOUND_IN_BUFFER > 0
and LOG_READS > 0
;
select
dec((avg(a.UOW_LOG_SPACE_USED)/1024),16,2) as AVG_Log_Space_KB_Used_Per_Appl
from SYSIBMADM.snapappl a
;
