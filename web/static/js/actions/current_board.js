import Constants from '../constants';

const Actions = {
  connectToChannel: (socket, boardId) => {
    return dispatch => {
      const channel = socket.channel(`boards:${boardId}`);

      dispatch({ type: Constants.CURRENT_BOARD_FETCHING});

      channel.join().receive('ok', (response) => {
        dispatch({
          type: Constants.BOARDS_SET_CURRENT_BOARD,
          board: response.board
        });
      });

      channel.on('members:add', (msg) => {
        dispatch({
          type: Constants.CURRENT_BOARD_MEMBER_ADDED,
          user: msg.user
        })
      });

      dispatch({
        type: Constants.CURRENT_BOARD_CONNECTED_TO_CHANNEL,
        channel: channel
      });
    };
  },

  showMembersForm: (show) => {
    return dispatch => {
      dispatch({
        type: Constraints.CURRENT_BOARD_SHOW_MEMBERS_FORM,
        show: show
      })
    }
  },

  addNewMembers: (channel, email) => {
    return dispatch => {
      channel.push('members:add', { email: email })
        .receive('error', (data) => {
          dispatch({
            type: Constants.CURRENT_BOARD_ADD_MEMBER_ERROR,
            error: data.error
          });
        });
    };
  }
};

export default Actions;
