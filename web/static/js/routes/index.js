import { IndexRoute, Route } from 'react-router';
import React from 'react';
import MainLayout from '../layouts/main';
import RegistrationsNew from '../views/registrations/new';

export default (
  <Route component={MainLayout}>
    <Route path="/sign_up" component={RegistrationsNew} />
    <Route path="/sign_in" component={SessionNew} />

    <Route path="/" component={AuthenticatedContainer}>
      <IndexRoute component={HomeIndexView} />

      <Route path="/boards/:id" component={BoardsShowView} />
    </Route>
  </Route>
);
