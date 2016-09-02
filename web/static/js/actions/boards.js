import Constants from '../constants';
import { routeActions } from 'react-router-redux';
import { httpGet, httpPost } from '../utils';
import CurrentBoardActions from '../current_board';

const Actions = {
  fetchBoards: () => {
    dispatch({ type: Constants.BOARDS_FETCHING});

    httpGet('/api/v1/boards')
      .then((data) => {
        dispatch({
          type: Constants.BOARDS_RECEIVED,
          ownedBoards: data.own_boards
        });
      });
  },

  showForm: (show) => {
    return dispatch => {
      dispatch({
        type: Constants.BOARDS_SHOW_FORM,
        show: show
      });
    };
  },

  create: (date) => {
    return dispatch => {
      httpPost('/api/v1/boards', { board: data})
        .then((data) => {
          dispatch({
            type: Constants.BOARDS_NEW_BOARD_CREATED,
            board: data
          });

          dispatch(routeActions.push(`/boards/${data.id}`))
        })
        .catch((error) => {
          error.response.json()
            .then((json) => {
              dispatch({
                type: Constants.BOARDS_CREATE_ERROR,
                errors: json.errors
              });
            });
        });
    };
  }
}

export defeault Actions;