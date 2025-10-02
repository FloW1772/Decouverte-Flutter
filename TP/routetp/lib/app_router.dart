import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'main.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final projet = state.extra as Projet;
        return ProjectDetailsPage(projet: projet);
      },
    ),
  ],
);
