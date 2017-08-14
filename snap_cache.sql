with package_snap as
(
select '1' as row, pkg_cache_lookups, pkg_cache_inserts,
pkg_cache_num_overflows, pkg_cache_size_top,files_closed
from sysibmadm.snapdb
)
--,catlg_snap as
--(
--select '2' as row,CAT_CACHE_OVERFLOWS,CAT_CACHE_SIZE_TOP,CAT_CACHE_LOOKUPS,CAT_CACHE_INSERTS
--from sysibmadm.snapdb
--)
,package_size as
(
select '1' as row, int(value)*4096 as pckcachesz
from sysibmadm.dbcfg
where name = 'pckcachesz'
)
--,catlg_size as
--(
--select '2' as row,int(value)*4096 as catlgcachesz
--from sysibmadm.dbcfg
--where name = 'catlgcachesz'
--)
select int((1 - float(pkg_cache_inserts)/float(pkg_cache_lookups))*100) as Pkg_Cache_Hit_Ratio
,int(pkg_cache_num_overflows) as Pkg_Cache_Overflows
,pkg_cache_size_top * 100 / pckcachesz as Pct_of_Pkg_Cache_Used
,files_closed
from package_snap a, package_size b
where a.row = b.row
;
