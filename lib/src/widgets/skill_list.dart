import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.dart';

class SkillList extends StatefulWidget {
  final List<Skill> skills;

  const SkillList({required this.skills});

  @override
  _SkillListState createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Skills (${widget.skills.length})",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.white,
            ),
          ],
        ),
      ),
      if (isExpanded)
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Disable scrolling
          itemCount: widget.skills.length,
          itemBuilder: (context, index) {
            final skill = widget.skills[index];
            return ListTile(
              leading: Icon(Icons.star, color: Colors.blue),
              title: Text(skill.name,
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              subtitle: Text('Level: ${skill.level}',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
              trailing: _buildSkillLevelIndicator(skill.level),
            );
          },
        )
    ]);
  }

  // Builds a progress indicator based on skill level (assuming max level is 100)
  Widget _buildSkillLevelIndicator(double level) {
    return SizedBox(
      width: 100,
      child: LinearProgressIndicator(
        value: level / 21,
        backgroundColor: Colors.grey[200],
        color: Colors.blue,
      ),
    );
  }
}
