import 'package:flutter/material.dart';

import '../../../stories/task_story.dart';
import '../../controller/controller.dart';

class NewTaskWidget extends StatefulWidget {
  final TaskStory store;
  const NewTaskWidget({Key? key, required this.store}) : super(key: key);

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width * 1.2,
      child: Form(
        key: widget.store.controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Titulo:'),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                ),
                controller: widget.store.controller.titleTaskController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira um titulo válido';
                  }
                  return null;
                },
              ),
              const Text('Descrição:'),
              const SizedBox(height: 4),
              TextFormField(
                controller: widget.store.controller.descriptionTaskController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira uma descrição válida';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    child: const Text('escolha a data'),
                    onPressed: () async {
                      widget.store.controller.newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2026),
                      );
                      if (widget.store.controller.newDate != null) {
                        setState(() {
                          widget.store.controller.dateTime =
                              widget.store.controller.newDate!;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    child: const Text('escolha as horas'),
                    onPressed: () async {
                      widget.store.controller.newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (widget.store.controller.newTime != null) {
                        setState(() {
                          widget.store.controller.timeOfDay =
                              widget.store.controller.newTime!;
                        });
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(widget.store.controller.formatedDate()),
                  const SizedBox(width: 12),
                  Text(widget.store.controller.formatedTime()),
                  const SizedBox(width: 30),
                  // Text(widget.controller.validatorTask())
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Adicionando tarefa...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                
                  widget.store.addTask();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}