Select substr(ai.appl_name,1,10) as Application
,substr(ai.primary_auth_id,1,10) as App_AuthID
,int(ai.agent_id) as AppHandle
--,int(ai.COORD_AGENT_PID) as Coord_Agnt_Id
,substr(ai.appl_status,1,10) as App_Status
,ai.STATUS_CHANGE_TIME as Status_Since
,int(ap.locks_held) as Locks_Held
,int(ap.lock_escals) as Escalations
,int(ap.lock_timeouts) as Lock_Timeouts
,int(ap.deadlocks) as Deadlocks
,int(ap.int_deadlock_rollbacks) as Dlock_Victim
--,substr(inbound_comm_address,1,20) as IP_Address
from sysibmadm.snapappl ap, sysibmadm.snapappl_info ai
where ap.agent_id = ai.agent_id
and  ai.appl_status <> 'UOWWAIT'
order by Lock_Timeouts desc
--order by Deadlocks desc
;
