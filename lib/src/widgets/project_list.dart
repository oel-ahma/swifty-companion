import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.dart';

class ProjectList extends StatefulWidget {
  final List<Project> projects;

  const ProjectList({Key? key, required this.projects}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final finishedProjects = widget.projects
        .where((project) => project.status == "finished")
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                "Projects (${finishedProjects.length})",
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
            itemCount: finishedProjects.length,
            itemBuilder: (context, index) {
              final project = finishedProjects[index];
              return ListTile(
                title:
                    Text(project.name, style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  'Status: ${project.status}, Mark: ${project.mark}',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            },
          ),
      ],
    );
  }
}
