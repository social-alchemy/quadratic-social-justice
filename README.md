# LensBet (Quadratic Arbitration) 🎲

## Introduction 🌟

Welcome to the BettingGame project! This innovative project integrates with the Reality.eth decentralized oracle to create a betting game on Ethereum. In this document, we'll explain how Reality.eth works, the mechanics of the BettingGame, and address the challenges in the arbitration process, including our solution: Quadratic Voting During Arbitration. Additionally, we highlight that our frontend is uniquely integrated as a Lens Smart Post.

## How Reality.eth Works 🌐

Reality.eth is a decentralized oracle for Ethereum, facilitating the verification of real-world events through a community-driven process. Here's how it operates:

1. **Question Creation** 📝: Users pose questions about real-world events, setting deadlines for answers.
2. **Answer Submission** 🗳️: Participants submit answers, each requiring a bond. Successive answers must double the bond of the previous one.
3. **Finalization** ✔️: Post-deadline, if no disputes arise, the last answer becomes final.
4. **Arbitration** ⚖️: Disputed answers are resolved by an arbitrator who provides a definitive resolution.

## How BettingGame Works 🎰

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


## TODO & Future Roadmaps 🎉

BettingGame is committed to a fair, decentralized betting experience using Reality.eth. Our approach, including Quadratic Voting and Lens Smart Post integration, ensures a balanced and engaging platform. We invite community involvement for continuous improvement.

---
