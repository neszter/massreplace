with locklist as
( select float(int(value)*4096) as locklist
from sysibmadm.dbcfg
where name = 'locklist'
),
maxlocks as
( select float(int(value)) as maxlocks
from sysibmadm.dbcfg
where name = 'maxlocks'
),
dbsnap as
( select lock_list_in_use
,appls_cur_cons as NumCons
,lock_escals as Tot_Lock_escalation
,lock_timeouts as Tot_Lock_Timeout
,deadlocks as Tot_Deadlock
from sysibmadm.snapdb
)
select dec((lock_list_in_use/locklist)*100,4,1) as LockListUsePct
,dec((lock_list_in_use/(locklist*(maxlocks/100))*100),4,1) as Pct_of_MaxLocks                  
,NumCons as Tot_Num_Connections 
,lock_list_in_use/numcons as Avg_Lock_Mem_Per_Conn_Bytes
,Tot_Lock_Timeout
,Tot_Lock_escalation
,Tot_Deadlock
from locklist,maxlocks,dbsnap
;
