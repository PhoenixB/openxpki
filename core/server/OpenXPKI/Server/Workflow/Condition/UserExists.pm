package OpenXPKI::Server::Workflow::Condition::UserExists;
use OpenXPKI;

use parent qw( OpenXPKI::Server::Workflow::Condition );

use OpenXPKI::Server::Context qw( CTX );
use Workflow::Exception qw( workflow_error );


sub _evaluate
{
    my ( $self, $workflow ) = @_;
    my $param = {};


    $param->{username} = $self->param("username") if ($self->param("username"));
    $param->{mail} = $self->param("mail") if ($self->param("mail"));

    workflow_error("Neither username nor mail given") if (!keys %$param);

    my $res=CTX('api2')->search_users_count(%$param);

    if ($res==0) {
        workflow_error("No user was found for the given search criteria");
    }
    return 1;
}

1;

__END__


=head1 NAME

OpenXPKI::Server::Workflow::Condition::UserExists

=head1 DESCRIPTION

This condition checks whether at least one user with the username or
mail provided as parameter exists.