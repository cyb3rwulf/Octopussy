<%
my %arg = @_;
my $tt = $arg{tooltip};
my $ldap = AAT::LDAP::Configuration();
my ($server, $base, $filter) =
  ($ldap->{contacts_server}, $ldap->{contacts_base}, $ldap->{contacts_filter});
%>
<AAT:Box width="100%">
<AAT:BoxRow>
  <AAT:BoxCol><AAT:Label value="LDAP" style="B" tooltip="$tt" /></AAT:BoxCol>
  <AAT:BoxCol>
  <AAT:Label value="_CONTACTS_SERVER" style="B" tooltip="$tt" /></AAT:BoxCol>
  <AAT:BoxCol>
  <AAT:Entry name="ldap_contacts_server" value="$server" size="50" />
	</AAT:BoxCol>
</AAT:BoxRow>
<AAT:BoxRow>
  <AAT:BoxCol rspan="3"><AAT:IMG name="generic_contacts" /></AAT:BoxCol>
  <AAT:BoxCol>
  <AAT:Label value="_CONTACTS_BASE" style="B" tooltip="$tt" /></AAT:BoxCol>
  <AAT:BoxCol>
  <AAT:Entry name="ldap_contacts_base" value="$base" size="50" />
	</AAT:BoxCol>
</AAT:BoxRow>
<AAT:BoxRow>
  <AAT:BoxCol>
  <AAT:Label value="_CONTACTS_FILTER" style="B" tooltip="$tt" /></AAT:BoxCol>
  <AAT:BoxCol>
  <AAT:Entry name="ldap_contacts_filter" value="$filter" size="50" />
	</AAT:BoxCol>
</AAT:BoxRow>
<%
if (AAT::NOT_NULL($server))
{
	my ($level, $msg) = ((AAT::LDAP::Contacts_Connection_Test()) 
		? (0, "LDAP Connection is OK !") : (2, "LDAP Connection is NOT OK !"));
%>
<AAT:BoxRow>
  <AAT:BoxCol cspan="2"><AAT:Message level="$level" msg="$msg" /></AAT:BoxCol>
</AAT:BoxRow>
<%
}
%>
</AAT:Box>