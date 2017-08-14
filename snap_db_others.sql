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
select 
int(100-((NUM_LOG_READ_IO*100)/LOG_READS)) as Log_Read_Hit_Ratio,
dec(((float(int(LOG_HELD_BY_DIRTY_PAGES))/1024)/1024),18,2) as LOG_HELD_DRTY_PG_MB,
--NUM_LOG_BUFFER_FULL,
--(INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS) as TOT_NUM_TRANSACTIONS,
((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/900) as AVG_TXNS_PER_SEC_15MINS,
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/1800) as AVG_TXNS_PER_SEC_30MINS,
--((INT_COMMITS+INT_ROLLBACKS+COMMIT_SQL_STMTS+ROLLBACK_SQL_STMTS)/60) as AVG_TXNS_PER_SEC_1MINS,
--int(total_cons) as Total_Cons,
smallint(appls_cur_cons) as Current_Cons,
smallint(appls_in_db2) as Appls_In_DB2,
smallint(connections_top) as Max_Conncurent_Cons,
int(agents_top) as Max_Agents
--,date(db_conn_time) as DB_Start_Date
from sysibmadm.snapdb
where LOG_READS > 0
;
