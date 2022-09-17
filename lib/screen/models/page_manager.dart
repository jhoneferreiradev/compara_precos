import 'package:flutter/material.dart';

class PageManager {
  PageManager(this._pageController);

  final PageController _pageController;

  int currentPage = 0;

  setPage(int page) {
    if (page == currentPage) return;
    currentPage = page;
    _pageController.animateToPage(currentPage, duration: Duration(milliseconds: 150), curve: Curves.easeInCirc);
  }
}
