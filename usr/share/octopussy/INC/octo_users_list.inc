<%
my %arg = @_;

my $url = $arg{url};
my $url_sort = $url . "?users_table_sort=";
my $sort = defined $arg{sort} ? lc($arg{sort}) : "login";
my $role = $Session->{AAT_ROLE};
my @table = ();
%>
<AAT:Box align="center" icon="buttons/bt_users" title="_USERS">
<AAT:BoxRow>
<AAT:BoxCol><AAT:Label value="_USER" style="B" /></AAT:BoxCol>
<AAT:BoxCol><AAT:Label value="_PASSWORD" style="B" /></AAT:BoxCol>
<AAT:BoxCol align="C"><AAT:Label value="_LANGUAGE" style="B" /></AAT:BoxCol>
<AAT:BoxCol><AAT:Label value="_ROLE" style="B" /></AAT:BoxCol>
<AAT:BoxCol><AAT:Label value="_TYPE" style="B" /></AAT:BoxCol>
<%
if ($role =~ /admin/i)
{ 
%><AAT:BoxCol align="C"><AAT:Label value="_ACTION" style="B" /></AAT:BoxCol><% 
}
else
	{ %><AAT:BoxCol></AAT:BoxCol><% }
%>
</AAT:BoxRow>
<AAT:BoxRow><AAT:BoxCol cspan="6"><hr></AAT:BoxCol></AAT:BoxRow>
<%
foreach my $c (AAT::User::Configurations($sort))
{
	my ($login, $r, $type) = ($c->{login}, $c->{role}, $c->{type});
	my $role_name = AAT::User::Role_Name($r);
	my $flagfile = "AAT/IMG/flags/" . lc($c->{language}) . ".png"
	%><AAT:BoxRowMenu>
	<AAT:BoxCol><AAT:Label value="$login" no_trans="1"/></AAT:BoxCol>
	<AAT:BoxCol><AAT:Label value="--------" /></AAT:BoxCol>
	<AAT:BoxCol align="C"><AAT:Picture file="$flagfile" /></AAT:BoxCol>
<%
if ($role_name =~ /restricted/i)
{
%><AAT:BoxCol><AAT:Label value="$role_name" link="./user_restrictions.asp?user=$login" /></AAT:BoxCol><%
}
else
{
%><AAT:BoxCol><AAT:Label value="$role_name" /></AAT:BoxCol><%	
}%>
	<AAT:BoxCol><AAT:Label value="$type" /></AAT:BoxCol><%
	if (($role =~ /admin/i) && ($c->{type} =~ /local/))
  {
		my $dialog = "./dialog.asp?id=delete_user&arg1=$c->{login}";
		%><AAT:BoxCol align="center">
		<AAT:Button name="remove" tooltip="_REMOVE" popup_link="$dialog" />
		</AAT:BoxCol><%
	}
	else
	{
		%><AAT:BoxCol></AAT:BoxCol><%
	}
	%></AAT:BoxRowMenu><%
}

if ($role =~ /admin/i)
{%>
<AAT:BoxRow><AAT:BoxCol cspan="6"><hr></AAT:BoxCol></AAT:BoxRow>
<AAT:Form action="$url">
<AAT:BoxRow>
	<AAT:BoxCol><AAT:Entry name="login" /></AAT:BoxCol>
	<AAT:BoxCol><AAT:Password name="password" /></AAT:BoxCol>
	<AAT:BoxCol><AAT:Selector_Language /></AAT:BoxCol>
	<AAT:BoxCol><AAT:Selector_User_Role /></AAT:BoxCol>
	<AAT:BoxCol cspan="2"><AAT:Form_Submit value="_NEW_USER" /></AAT:BoxCol>
</AAT:BoxRow>
</AAT:Form>
<%
}
%>
</AAT:Box>