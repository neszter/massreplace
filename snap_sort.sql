with dbmcfg as
( select 1 as row
,float(int(value)*4096) as sheapthres
from sysibmadm.dbcfg
where name = 'sheapthres_shr'
),
dbsnap as
( select 1 as row
,float(sort_heap_allocated*4096) as sheap_alloc
,sort_overflows as overflows
,active_sorts as active
,total_sorts as total_sorts
,POST_SHRTHRESHOLD_SORTS as POST_SHRTHRESHOLD_SORTS   
,TOTAL_HASH_JOINS as TOTAL_HASH_JOINS
,hash_join_overflows as hash_join_overflows
,ROWS_SELECTED
,ROWS_READ
from sysibmadm.snapdb
)
select
dec((sheap_alloc/sheapthres)*100,9,2) as SHeap_Alloc_Pct
--,overflows as Sort_Overflows
,dec((float(overflows)/float(total_sorts))*100,10,2) as Sort_OverflowPerct
--,active as Active_Sorts
,hash_join_overflows
--,TOTAL_HASH_JOINS
,dec((float(hash_join_overflows)/float(total_hash_joins))*100,12,2) as Hash_Join_Overflow_Pct
--,POST_SHRTHRESHOLD_SORTS
,dec((float(rows_read)/float(rows_selected)),22,2) as AvgRowsRd_perSelRows
from dbmcfg c, dbsnap s
where c.row = s.row
;
