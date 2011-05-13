<%args>
    $.data
</%args>

<table>

<tr><th>key</th><th>Dest</th><th>Compatible</th>
<th>ImageVersion</th><th>SystemSoftwareVersion</th>
<th><em>Last-Modified</em></th><th><em>CDN Last-Modified</em></th></tr>

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

