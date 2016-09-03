import React, { PropTypes } from 'react';
import Actions from '../../actions/lists';

export default class ListForm extends React.Component {
  componentDidMount() {
    this.refs.name.focus();
  }

  _handleSubmit(e) {
    e.preventDefault();

    const { dispatch, channel } = this.props;
    const { name } = this.refs;

    const data = {
      name: name.value
    };

    dispatch(Actions.save(channel, data));
  }

  _handleCancelClick(e) {
    e.preventDefault();

    this.props.onCancelClick();
  }

  render() {
    return (
      <div className="list form">
        <div className="inner">
          <form id="new_list_form" onSubmit={::this._handleSubmit}>
            <input ref="name" id="list_name" type="text" placeholder="Add a new list..." required="true"/>
            <button type="submit">Save list</button> or <a href="#" onClick={::this._handleCancelClick}>cancel</a>
          </form>
        </div>
      </div>
    );
  }
}
