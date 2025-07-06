import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/auth/auth_client.dart';
import 'package:simple_auth/components/my_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<AuthClient>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              "Your Tasks",
              style: TextStyle(color: Colors.grey[700], fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const MyTask(
              name: "Call Mom",
              description:
                  "Take time to call Mom and check in on how she’s doing. Ask about her day, her health, and anything she might need help with. Share any personal updates, big or small — she’ll appreciate hearing from you. Even if there’s no special reason, just making the effort to stay connected strengthens the relationship and shows you care. Aim for a relaxed, unhurried conversation where she feels heard and appreciated.",
              left: true,
            ),
            const MyTask(
              name: "Call Mom",
              description:
                  "Take time to call Mom and check in on how she’s doing. Ask about her day, her health, and anything she might need help with. Share any personal updates, big or small — she’ll appreciate hearing from you. Even if there’s no special reason, just making the effort to stay connected strengthens the relationship and shows you care. Aim for a relaxed, unhurried conversation where she feels heard and appreciated.",
              left: false,
            ),
            const MyTask(
              name: "Call Mom",
              description:
                  "Take time to call Mom and check in on how she’s doing. Ask about her day, her health, and anything she might need help with. Share any personal updates, big or small — she’ll appreciate hearing from you. Even if there’s no special reason, just making the effort to stay connected strengthens the relationship and shows you care. Aim for a relaxed, unhurried conversation where she feels heard and appreciated.",
              left: true,
            ),
            const MyTask(
              name: "Call Mom",
              description:
                  "Take time to call Mom and check in on how she’s doing. Ask about her day, her health, and anything she might need help with. Share any personal updates, big or small — she’ll appreciate hearing from you. Even if there’s no special reason, just making the effort to stay connected strengthens the relationship and shows you care. Aim for a relaxed, unhurried conversation where she feels heard and appreciated.",
              left: false,
            ),
          ],
        ),
      ),
    );
  }
}
