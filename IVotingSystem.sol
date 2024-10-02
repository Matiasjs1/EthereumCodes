// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;


/**
 * @title Voting System
 * @notice Interface for the Voting System contract
 */
interface IVotingSystem {
  /*///////////////////////////////////////////////////////////////
                              EVENTS
  //////////////////////////////////////////////////////////////*/
  /**
   * @notice Emitted when a new proposal is created
   * @param _proposal The proposal created
   */
  event ProposalCreated(Proposal _proposal);


  /**
   * @notice Emitted when a new voter is added
   * @param _voter The address of the voter added
   */
  event VoterAdded(address _voter);


  /**
   * @notice Emitted when a voter votes
   * @param _index The index of the proposal voted
   * @param _voter The address of the voter
   */
  event ProposalVoted(uint256 _index, address _voter);


  /**
   * @notice Emitted when a proposal is approved
   * @param _proposal The proposal approved
   */
  event ProposalApproved(Proposal _proposal);


  /*///////////////////////////////////////////////////////////////
                              ERRORS
  //////////////////////////////////////////////////////////////*/


  /**
   * @notice Thrown when the user is not a voter
   */
  error IVotingSystem_UserIsNotVoter();


  /**
   * @notice Thrown when the description of the proposal is empty
   */
  error IVotingSystem_DescriptionIsRequired();


  /**
   * @notice Thrown when the proposal does not exist
   */
  error IVotingSystem_ProposalNotExists();


  /**
   * @notice Thrown when the user already voted
   */
  error IVotingSystem_UserAlreadyVoted();


  /**
   * @notice Thrown when the proposal is expired
   */
  error IVotingSystem_ProposalExpired();

  error IVotingSystem_DescriptionExist();


  error IVotingSystem_VoterExsit();
  /*///////////////////////////////////////////////////////////////
                            STRUCTS
  //////////////////////////////////////////////////////////////*/


  /**
   * @notice Struct to represent a proposal
   * @param description The description of the proposal
   * @param voteCount The number of votes of the proposal
   * @param neededVotes The number of votes needed to approve the proposal
   * @param finalDate The final date of the proposal
   */
  struct Proposal {
    string description;
    uint256 voteCount;
    uint256 neededVotes;
    uint256 finalDate;
  }
 
  /*///////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
  //////////////////////////////////////////////////////////////*/


  /**
   * @notice Returns the expiration time of the proposals
   * @return _proposalExpiration The expiration time of the proposals
   */
  function PROPOSAL_EXPIRATION() external view returns (uint256 _proposalExpiration);


  /**
   * @notice Returns the number of proposals
   * @return _proposalCount The number of proposals
   */
  function proposalCount() external view returns (uint256 _proposalCount);


  /**
   * @notice Returns the proposals
   * @param _index The index of the proposal
   * @return _description The description of the proposal
   * @return _voteCount The number of votes of the proposal
   * @return _neededVotes The number of votes needed to approve the proposal
   * @return _finalDate The final date of the proposal
   */
  function proposals(uint256 _index)
    external
    view
    returns (string memory _description, uint256 _voteCount, uint256 _neededVotes, uint256 _finalDate);


  /**
   * @notice Returns if the user voted
   * @param _index The index of the proposal
   * @param _user The address of the user
   * @return _isVoted If the user voted
   */
  function proposalIsVoted(uint256 _index, address _user) external view returns (bool _isVoted);


  /**
   * @notice Returns the proposals
   * @return _getProposals The proposals
   */
  function getProposals() external view returns (Proposal[] memory _getProposals);


  /*///////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
  //////////////////////////////////////////////////////////////*/


  /**
   * @notice Add a new voter
   * @param _voter The address of the voter
   */
  function addVoter(address _voter) external;


  /**
   * @notice Create a new proposal
   * @param _description The description of the proposal
   */
  function createProposal(string memory _description) external;


  /**
   * @notice Vote a proposal
   * @param _index The index of the proposal
   */
  function voteProposal(uint256 _index) external;
  function _voters() external;


  /**
   * @notice Finish proposal using a pagination system
   * @param _startIndex The  start index of the proposal
   * @param _lastIndex The last index of the proposal
   */
  function finishProposals(uint256 _startIndex, uint256 _lastIndex) external;
}
