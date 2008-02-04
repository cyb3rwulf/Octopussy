<WebUI:PageTop title="Wizard" />
<%
my $device = $Request->QueryString("device");
my $sort = $Request->QueryString("wizard_table_sort");
my $action = $Request->QueryString("action");
my $msg = $Request->QueryString("log");
my $timestamp = $Request->QueryString("timestamp");

if ($Session->{AAT_ROLE} !~ /ro/)
{
	if (!defined $device)
	{
		%><AAT:Inc file="octo_wizard" url="./wizard.asp" sort="$sort" /><%
	}
	else
	{
		my @messages = Octopussy::Message::Wizard($device);
		if ($action eq "remove")
		{
			Octopussy::Logs::Remove($device, $messages[$msg-1]->{re});
			$Response->Redirect("./wizard.asp?device=$device");
		}
		elsif ($action eq "remove_minute")
		{
			my ($year, $month, $day, $hour, $min) = ($1, $2, $3, $4, $5)
  			if ($timestamp =~ /(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})/);
			Octopussy::Logs::Remove_Minute($device, $year, $month, $day, $hour, $min);
			$Response->Redirect("./wizard.asp?device=$device");
		}
		my $i = 1;
		my $new_timestamp = "";
		my $nb_max = Octopussy::Parameter("wizard_max_msgs");
		if ($#messages+1 >= $nb_max)
		{
			my $str = sprintf(AAT::Translation("_MSG_WIZARD_MSGS_LIST_LIMITED_TO"), 
				$nb_max);
		%><AAT:Message msg="$str" level="1" /><%
		}
		foreach my $m (@messages)
		{
				if ($new_timestamp ne $m->{timestamp})
				{
					$new_timestamp = $m->{timestamp};
					%><AAT:Inc file="octo_box_remove_minute_log" 
							device="$device" timestamp="$new_timestamp" /><%
				}
			 	$Response->Include('INC/octo_wizard_new_msg.inc', 
					device => $device, name => "#" . $i++, modified => $m->{modified}, 
					orig => $m->{orig}, re => $m->{re}, nb => $m->{nb});
		}
	}
}
%>
<WebUI:PageBottom />