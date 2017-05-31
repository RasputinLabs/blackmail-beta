@extends('spark::layouts.app')

@section('content')
<home :user="user" inline-template>
    <div class="container">
        <!-- Application Dashboard -->
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">Dashboard</div>

                    <div class="panel-body">
                        <h2>You have no blackmail currently.</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">Create new BlackMail</div>

                    <div class="panel-body">
                        <input type="file" class="form-control" /><br/>
                        <a href="/blackmail" class="btn btn-primary">Submit</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</home>
@endsection
