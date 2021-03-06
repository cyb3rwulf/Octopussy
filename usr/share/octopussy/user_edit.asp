<%
$Response->Redirect("./login.asp?redirect=/user.asp")
    if ((NULL($Session->{AAT_LOGIN})) 
		|| ($Session->{AAT_ROLE} eq "restricted"));
my $f = $Request->Form();
my $login = $Request->QueryString('user');
my $type = $Request->QueryString('type');

if ((defined $f->{update}) && ($Session->{AAT_ROLE} =~ /^admin$/i))
{
 	AAT::User::Update("Octopussy", $f->{login}, $f->{type}, 
 		{ 	password => $f->{password}, 
			language => $f->{AAT_Language},
			role => $f->{user_role},
			status => $f->{status}, } 
		);
	$Response->Redirect("./user.asp");
}
%>
<WebUI:PageTop title="_USER_PREFS" help="users" />
<AAT:Inc file="octo_user_edit" user="$login" type="$type" url="./user_edit.asp" />
<WebUI:PageBottom />
