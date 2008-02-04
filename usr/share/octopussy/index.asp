<WebUI:PageTop title="Octopussy" help="index" refresh="10" />
<%
Purge_Session();
my $action = $Request->QueryString("action");
my $rrd_mode = $Request->QueryString("rrd_mode");
Octopussy::Restart()	if ($action eq "restart");
#my $nb_alerts_max = Octopussy::Parameter("max_alerts");
my @alerts = Octopussy::Alert::Tracker("-ANY-", "-ANY-", "Opened", 
	undef, $nb_alerts_max);
my $nb_unknown = 0;
%>
<AAT:Box align="C">
<AAT:BoxRow valign="top">
	<AAT:BoxCol>
	<table>
	<tr><td align="center"><AAT:Inc file="octo_version_update" /></td></tr>
	<tr><td align="center"><AAT:Inc file="octo_warning_msg" /></td></tr>
	<tr><td align="center"><AAT:Inc file="octo_system_stats" /></td></tr>
	<tr><td align="center"><AAT:Inc file="octo_process_status" /></td></tr>
	</table>	
	</AAT:BoxCol>
	<AAT:BoxCol rspan="2" valign="top">
  <table>
	<tr><td>
	<AAT:RRD_Graph url="./index.asp" name="syslog_dtype" mode="$rrd_mode" />
	</td></tr>	
  <tr><td><AAT:Inc file="octo_events_last_minute" /></td></tr>
	</table>
	</AAT:BoxCol>
</AAT:BoxRow>
<AAT:BoxRow valign="top">
	<AAT:BoxCol align="C" valign="top">
	<AAT:Picture file="IMG/octopussy.gif" width="340" /></AAT:BoxCol>
</AAT:BoxRow>
</AAT:Box>
<WebUI:PageBottom />