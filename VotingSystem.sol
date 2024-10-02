// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;


import './IVotingSystem.sol';


abstract contract VotingSystem is IVotingSystem {
    /// @inheritdoc IVotingSystem
    uint256 public immutable PROPOSAL_EXPIRATION;
    /// @inheritdoc IVotingSystem
    uint256 public proposalCount;
    /// @inheritdoc IVotingSystem
    mapping(uint256 _index => IVotingSystem.Proposal _proposal) public proposals;
    /// @inheritdoc IVotingSystem
    mapping(uint256 _index => mapping(address _user => bool _isVoted)) public proposalIsVoted;

    mapping(string _description => bool) public _descriptions;
    mapping(address _voter => bool) public IsVoter;
    /**
    * @notice Array of voters
    */


    address[] internal _voters;


    /**
    * @notice Constructor of the contract
    * @param _proposalExpiration The expiration time of the proposals
    */
    constructor(uint256 _proposalExpiration) {
        PROPOSAL_EXPIRATION = _proposalExpiration;
    }


    /**
    * @notice Modifier to check if the user is a voter
    */
    modifier OnlyVoter() {
        if(!IsVoter[msg.sender]) revert IVotingSystem_UserIsNotVoter();
        _;
    }


    modifier NotVoter(){
        if(IsVoter[msg.sender]) revert IVotingSystem_VoterExsit();
        _;
    }

    modifier  NotProposal(string memory _description){
        if(_descriptions[_description]) revert IVotingSystem_DescriptionExist();
        _;
    }


    /// @inheritdoc IVotingSystem
    function addVoter(address _voter) public NotVoter{
        _voters.push(_voter);
        IsVoter[_voter] = true;
    }


    /// @inheritdoc IVotingSystem
    function createProposal(string memory _description) public OnlyVoter NotProposal(_description){
        Proposal memory nuevaPropuesta = Proposal({
            description: _description,
            voteCount: 0,
            neededVotes: (50 * (_voters.length) / 100) + 1,
            finalDate: block.timestamp + PROPOSAL_EXPIRATION
        });
        proposals[proposalCount] = nuevaPropuesta;
        proposalCount ++;
    }


    /// @inheritdoc IVotingSystem
    function voteProposal(uint256 _index) public OnlyVoter {
        proposals[_index].voteCount ++;
    }


    /// @inheritdoc IVotingSystem
    function finishProposals(uint256 _startIndex, uint256 _lastIndex) public{
        
    }
}