package PS3UpdateStatus::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

has servers => ( is => 'ro', isa => 'HashRef' );
has basepath => ( is => 'ro' );
has filename => ( is => 'ro' );
has expires_in => ( is => 'ro' );

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    
    my $data;

    for my $area ( keys %{$self->servers} ) {
        my $url =
            'http://'.$self->servers->{$area}.
            $self->basepath.$area.$self->filename;

        my $res = $c->model('CHI')->compute(
            $url,
            sub { return $c->model('UserAgent')->get( $url ) },
            { expires_in => $self->expires_in }
        );
        $c->model('CHI')->remove( $url ) && next
            unless ( $res->is_success );

        $data->{$area}->{response} = $res;
        $data->{$area}->{url} = $url;
        my $content = $res->content;
        $content =~ s/^#.*$//m;
        for ( split /\s*;\s*/, $content ) {
            my ($k,$v) = split /=/, $_;
            $data->{$area}->{$k} = $v;
        }
        
        $url = $data->{$area}->{CDN};
        my $cres = $c->model('CHI')->compute(
            $url,
            sub { return $c->model('UserAgent')->head( $url ) },
            { expires_in => $self->expires_in }
        );
        $c->model('CHI')->remove( $url ) unless ( $cres->is_success );

        $data->{$area}->{cdnresponse} = $cres;
    }
    $c->stash->{data} = $data;
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;
