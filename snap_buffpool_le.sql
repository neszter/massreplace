with bpsnap as
(
select substr(bp_name,1,20) as bp_name,
float(pool_data_p_reads) as dp_read,
float(pool_data_l_reads) as dl_read,
float(pool_index_p_reads) as ip_read,
float(pool_index_l_reads) as il_read,
float(pool_temp_data_l_reads) as dtl_read,
float(pool_temp_index_l_reads) as itl_read,
float(pool_temp_data_p_reads) as dtp_read,
float(pool_temp_index_p_reads) as itp_read,
float(POOL_ASYNC_DATA_WRITES) as da_write,
float(POOL_ASYNC_INDEX_WRITES) as ia_write, 
float(POOL_DATA_WRITES) as dp_write,
float(POOL_INDEX_WRITES) as ip_write,
float(POOL_ASYNC_DATA_READS) as da_read,
float(POOL_ASYNC_INDEX_READS) as ia_read,
float(POOL_NO_VICTIM_BUFFER) as No_Victim_Buffer_Avl,
snapshot_timestamp
from sysibmadm.snapbp
)
select bp_name as BuffPool_Name
,dec((1 -(dp_read / dl_read))*100,4,1) as Data_Hit_Ratio
,dec((1 -(ip_read / il_read))*100,4,1) as Index_Hit_Ratio
--,dec((1 -(dtp_read / dtl_read))*100,4,1) as Temp_Data_Hit_Ratio
--,dec((1 -(itp_read / itl_read))*100,4,1) as Temp_Index_Hit_Ratio
--,dec((1-((dp_read+ip_read+dtp_read+itp_read)/(dl_read+il_read+dtl_read+itl_read)))*100,4,1) as BufferPool_HitRatio
,dec((1-((dp_read+ip_read)/(dl_read+il_read)))*100,4,1) as BufferPool_HitRatio 
,dec(((da_write+ia_write)/(dp_write+ip_write))*100,4,1) as AWP
--,dec(da_read) as Data_Async_Read
--,dec(dp_read) as Data_Phys_Read
--,dec(dl_read) as Data_Logic_Read
--,dec(da_write) as Data_Async_Writes
--,dec(ia_write) as Index_Async_Write
--,dec(dp_write) as Data_Write
--,dec(ip_write) as Index_Write
,dec(No_Victim_Buffer_Avl) as No_Victim_Buff_Avl
--,dec((((da_read+ia_read)/(dl_read+il_read))*100),4,2) as PreFetch_Ratio
--,snapshot_timestamp
from bpsnap 
where dl_read > 0 and il_read > 0 
--and dtl_read > 0 and itl_read > 0 
and (dp_write+ip_write) > 0 
--and bp_name in ('ICMLSFREQBP4','ICMLSMAINBP32','ICMLSVOLATILEBP4','ICMLSIDXBP4')
--order by BuffPool_Name 
--order by AWP ASC 
--order by Data_Hit_Ratio  asc
order by BufferPool_HitRatio desc
;
select 
--COMMIT_SQL_STMTS, SELECT_SQL_STMTS, UID_SQL_STMTS,
dec(((float(POOL_DATA_P_READS) + float(POOL_INDEX_P_READS) + float(POOL_TEMP_DATA_P_READS) + float(POOL_TEMP_INDEX_P_READS))/ float(
COMMIT_SQL_STMTS)),9,2) as avg_phys_read_per_txn,
dec(((float(POOL_DATA_L_READS) + float(POOL_INDEX_L_READS) + float(POOL_TEMP_DATA_L_READS) + float(POOL_TEMP_INDEX_L_READS))/ float(
COMMIT_SQL_STMTS)),9,2) as avg_logical_read_per_txn,
--dec(((float(POOL_DATA_WRITES) + float(POOL_INDEX_WRITES))/ float(COMMIT_SQL_STMTS)),9,2) as avg_write_per_txn,
dec(((float(total_sort_time)/float(COMMIT_SQL_STMTS))*1000),9,2) as time_ms_spent_on_sort_per_1000_txn,
dec(((float(lock_wait_time)/float(commit_sql_stmts))*1000),9,2) as time_ms_spent_on_lck_wait_per_1000_txns,
dec(((float(deadlocks)+float(lock_timeouts))/float(commit_sql_stmts)),9,2) as avg_dlock_timeot_per_txns
from sysibmadm.snapdb
where COMMIT_SQL_STMTS > 0
;
