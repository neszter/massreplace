select dec((float(agents_created_empty_pool)/(float(agents_from_pool)+float(agents_created_empty_pool)))*100,4,2) 
as NewAgentfromEmptyPercent,
agents_stolen,
agents_registered_top,
agents_waiting_top,
max_agent_overflows 
from sysibmadm.snapdbm
;
