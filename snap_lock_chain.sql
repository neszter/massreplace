select substr(ai_h.appl_name,1,10) as Lock_Holdin_AppName
--,substr(ai_h.primary_auth_id,1,10) as Holder_AuthId
,int(ai_h.agent_id) as Lock_Holder_Handle
,substr(ai_w.appl_name,1,10) as Waiting_App
--,substr(ai_w.primary_auth_id,1,10) as Waiter
--,substr(ai_w.appl_id,1,30) as Waiter_AppId
,int(ai_w.agent_id) as Waiter_Handle
,lw.lock_mode as Holding_Mode
,lw.lock_object_type as Obj_Type
,substr(lw.tabname,1,12) as TabName
,substr(lw.tabschema,1,8) as Schema
,timestampdiff(2,char(lw.snapshot_timestamp - lw.lock_wait_start_time)) as Lock_Wait_in_Sec                             
from sysibmadm.snapappl_info ai_h,
sysibmadm.snapappl_info ai_w, sysibmadm.snaplockwait lw
where lw.agent_id = ai_w.agent_id
and lw.agent_id_holding_lk = ai_h.agent_id
;
--Select substr(ai.appl_name,1,10) as ApplicationName
--,substr(ai.primary_auth_id,1,10) as Appl_AuthID
--,int(ai.agent_id) as APP_Handle
----,int(ai.COORD_AGENT_PID) as Coord_Agnt_Id
--,substr(appl_id,1,30) as Appl_Id
--,substr(appl_status,1,12) as App_Status 
--,ai.STATUS_CHANGE_TIME as This_Status_Since
--,int(ap.lock_waits) as Lock_Waits
--,int(ap.lock_wait_time/1000) as Tot_Wait_in_Sec
--,int( ap.lock_wait_time / ap.lock_waits) as Avg_Wait_in_ms
--from sysibmadm.snapappl ap, sysibmadm.snapappl_info ai
--where ap.agent_id = ai.agent_id
--and ap.lock_waits > 0
--;
