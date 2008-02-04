<WebUI:PageTop>
<table align="center">
<tr>
<%
my $map = $Request->QueryString("map");
my $url = "./maps.asp";
my $website = Octopussy::WebSite() . "/dokuwiki/doku.php";
my @maps = Octopussy::Map::List();
$map = $maps[0]	if ($#maps == 0);
foreach my $m (@maps)
{
	%><td><a href="<%= $url . "?map=$m" %>"><%= $m %></a></td><%
}
if ($#maps < 0)
{
	%><td><a href="<%= $website %>?id=config#maps" target="_blank">
	<%= AAT::Translation("_MSG_MAP_CREATION_INFO") %>
	</a></td><%
}
%>
</tr>
</table>
<%
if (defined $map)
{
	my $conf = Octopussy::Map::Configuration($map);
	%>
	<img src="./img_map.asp?map=<%= $map %>" usemap="#<%= $map %>" border=0>
	<map name="<%= $map %>">
	<%
	my $link = "./device_dashboard.asp?device=";
	foreach my $a (AAT::ARRAY($conf->{area}))
	{
	%><area shape="rect" 
			coords="<%= $a->{x1} %>,<%= $a->{y1} %>,<%= $a->{x2} %>,<%= $a->{y2} %>"
			href="<%= $link . $a->{device} %>" target="main"><%
	}
	%></map><%

	foreach my $a (AAT::ARRAY($conf->{area}))
	{
		my @alerts = Octopussy::Alert::From_Device($a->{device}, "Opened");
		if ((defined $a->{device}) && ($#alerts >= 0))
		{
%>
<div style="position: absolute; left: <%= ($a->{x1} + ($a->{x2} - $a->{x1})/2) %>px; top: <%= $a->{y1} + 20 %>px;">
<a href="./alerts_viewer.asp?device=<%= $a->{device} %>&status=Opened" target="main">
<img src="IMG/dialogs/dialog-warning.png" border="0"></a>
</div>
<%
		}
	}
}
%>
</AAT:Page>