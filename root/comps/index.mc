<%args>
    $.data
</%args>

<table>

<tr><th>key</th><th>Dest</th><th>Compatible</th>
<th>ImageVersion</th><th>SoftwareVersion</th>
<th><em>ps3-updatelist.txt Last-Modified</em></th>
<th><em>PS3UPDAT.PUP Last-Modified</em></th></tr>

% for my $key ( keys %{$self->data} ) {
%   my $row = $self->data->{$key};
<tr>
<td>
    <a href="<% $row->{url} | HTML %>">
    <% $key | HTML %>
    </a>
</td><td>
    <% $row->{Dest} | HTML %>
</td><td>
    <% $row->{CompatibleSystemSoftwareVersion} | HTML %>
</td><td>
    <% $row->{ImageVersion} | HTML %>
</td><td>
    <% $row->{SystemSoftwareVersion} | HTML %>
</td><td>
    <% $row->{response}->header('last-modified') | HTML %>
</td><td>
    <a href="<% $row->{CDN} | HTML %>">
    <% $row->{cdnresponse}->header('last-modified') | HTML %>
    </a>
</td>
<tr>
% }

</table>

<br/><br/>
<a href="http://github.com/pnu/PS3UpdateStatus">Fork me at Github</a>

