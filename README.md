# LensBet (with Quadratic Arbitration) 🎲

## Introduction 🌟

Welcome to the LensBet project! This innovative project integrates with the Reality.eth decentralized oracle to create a betting game on Lens Protocol using Smart Post. In this document, we'll explain how the Oracle works, the mechanics of the BettingGame, and address the challenges in the arbitration process, including our solution: Quadratic Voting During Arbitration. Additionally, we highlight that our frontend is uniquely integrated as a Lens Smart Post.

## How to depoy contracts 🌐
1. **Config env** 📝: Find lensHub Proxy Contract address and erc20 token address, config as following

```angular2html
export ERC20_TOKEN_ADDRESS=0x0
export LENS_HUB_PROXY_ADDRESS=0x0
```

2 **Deploy contracts** 📝: Execute following command deploy contracts
```angular2html
cd quadratic-social-justice/packages/foundry
forge script ./script/Deploy.s.sol:Deployer --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast -vvvv
```

## How Oracle (Reality.eth) Works 🌐

Conventional Reality.eth is a decentralized oracle for Ethereum, facilitating the verification of real-world events through a community-driven process. Here's how it operates:

1. **Question Creation** 📝: Users pose questions about real-world events, setting deadlines for answers.
2. **Answer Submission** 🗳️: Participants submit answers, each requiring a bond. Successive answers must double the bond of the previous one.
3. **Finalization** ✔️: Post-deadline, if no disputes arise, the last answer becomes final.
4. **Arbitration** ⚖️: Disputed answers are resolved by an arbitrator who provides a definitive resolution.

## How LensBet BettingGame Works 🎰

BettingGame utilizes Reality.eth to offer a decentralized betting experience:

1. **Bet Creation** 🛠️: Users create bets based on Reality.eth questions, staking ETH or ERC20 tokens.
2. **Joining Bets** 🤝: Participants join by staking on potential outcomes.
3. **Outcome Resolution** 🏆: The contract settles bets according to the resolved Reality.eth question, distributing stakes to winners proportionally.

## Arbitration and Asset-Heavy Influence 💼

The arbitration process can be skewed by asset-heavy individuals who influence outcomes through substantial bonds. This can compromise fairness.

### Quadratic Voting During Arbitration 🗳️

We address this with Quadratic Voting:

1. **Voting Power** 🔋: Voting power increases quadratically with assets, reducing the influence of wealth.
2. **Fair Representation** 🎭: This ensures democratic outcomes, limiting the dominance of wealthy individuals.
3. **Implementation** 🛠️: In Reality.eth, this could involve adjusting bonds based on participant diversity.

## Frontend Integration: Lens Smart Post 🖥️

Our project's frontend is innovatively integrated as a Lens Smart Post. Lens Protocol, known for its decentralized social media framework, allows us to leverage blockchain technology for a transparent, interactive user interface. This integration ensures:

1. **Decentralized Interaction** 🌍: Users interact with the BettingGame in a decentralized environment.
2. **Enhanced User Experience** ✨: The Lens Smart Post provides a user-friendly interface for bet creation, participation, and tracking.
3. **Community Engagement** 💬: Leveraging social media aspects, users can discuss, share, and promote bets within the Lens ecosystem.

## Credits 🏆

This project is made possible thanks to the ETHScaffold framework, which provided the foundational tools and resources for our development. A special thanks to the ETHScaffold team for their invaluable support and contributions to the Ethereum developer community.


## TODO & Future Roadmaps: Quadratic Arbitration 🎉

# Quadratic Arbitration Using Quadratic Voting 📊

## The Challenge in Conventional Arbitration 🚩

In the conventional arbitration process within systems like Reality.eth, participants can submit answers to questions, with each new answer requiring at least double the bond of the previous one. This process resets the timeout clock for each new answer. However, this system has a vulnerability:

- **Wealthy Individual Influence**: A wealthy individual or entity can potentially overwhelm the process by continuously posting higher bonds, skewing the outcome in their favor. This undermines the democratic and fair nature of the arbitration process.

## Introducing Quadratic Arbitration 🌟

To address this challenge, we can incorporate principles from Quadratic Voting into the arbitration process. Quadratic Voting is a system where the cost of each additional vote grows quadratically rather than linearly. Here's how it can be applied to arbitration:

### Principles of Quadratic Voting 📐

1. **Cost Increases Quadratically**: The cost of influencing an outcome grows quadratically with each additional unit of influence a participant wishes to exert.
2. **Democratizing Influence**: This makes it disproportionately more expensive for a single entity to dominate the outcome, ensuring a more balanced and democratic process.

### Applying Quadratic Voting to Arbitration 🗳️

1. **Bond Calculation**: Instead of simply doubling the bond for each new answer, the required bond could increase quadratically based on the number of times an entity attempts to influence the outcome.
2. **Disincentivizing Wealth Domination**: As the cost grows quadratically, it becomes financially impractical for even wealthy participants to dominate the arbitration process.
3. **Encouraging Diverse Participation**: This method encourages more participants to engage in the process, as their influence is not easily overridden by wealthier entities.

### Example 📝

- Suppose the initial bond is 1 token.
- The second bond, instead of being 2 tokens (double), could be 4 tokens (quadratic growth).
- The third bond would then be 9 tokens, and so on.

## Conclusion and Implications 🎯

Quadratic Arbitration using Quadratic Voting principles offers a more equitable and democratic approach to resolving disputes in decentralized systems. It reduces the risk of arbitration being overwhelmed by individuals with significant assets, promoting a fairer and more inclusive decision-making process.

*This approach aligns with the ethos of decentralization, ensuring that the power to influence outcomes is more evenly distributed across the participant base.* 🌍


---
