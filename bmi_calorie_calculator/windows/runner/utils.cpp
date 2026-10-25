#include "utils.h"

#include <flutter_windows.h>
#include <io.h>
#include <stdio.h>
#include <windows.h>

#include <iostream>

bool AttachControlPlayer() {
  return ::AttachConsole(ATTACH_PARENT_PROCESS);
}

void CreateAndAttachConsole() {
  if (::AllocConsole()) {
    FILE* unused;
    if (freopen_s(&unused, "CONOUT$", "w", stdout)) {
      _dup2(_fileno(stdout), 1);
    }
    if (freopen_s(&unused, "CONOUT$", "w", stderr)) {
      _dup2(_fileno(stderr), 2);
    }
    std::ios::sync_with_stdio();
    FlutterDesktopResyncOutputStreams();
  }
}

std::vector<std::string> GetCommandLineArguments() {
  int argc;
  wchar_t** argv = ::CommandLineToArgvW(::GetCommandLineW(), &argc);
  if (argv == nullptr) {
    return std::vector<std::string>();
  }

  std::vector<std::string> command_line_arguments;
  for (int i = 1; i < argc; ++i) {
    command_line_arguments.push_back(Utf8FromUtf16(argv[i]));
  }

  ::LocalFree(argv);
  return command_line_arguments;
}

std::wstring Utf16FromUtf8(const std::string& string) {
  int size_needed =
      MultiByteToWideChar(CP_UTF8, 0, string.c_str(), -1, nullptr, 0);
  if (size_needed == 0) {
    return std::wstring();
  }
  std::wstring result(size_needed, 0);
  MultiByteToWideChar(CP_UTF8, 0, string.c_str(), -1, &result[0], size_needed);
  result.resize(size_needed - 1);
  return result;
}

std::string Utf8FromUtf16(const std::wstring& utf16_string) {
  int size_needed = WideCharToMultiByte(
      CP_UTF8, 0, utf16_string.c_str(), -1, nullptr, 0, nullptr, nullptr);
  if (size_needed == 0) {
    return std::string();
  }
  std::string result(size_needed, 0);
  WideCharToMultiByte(CP_UTF8, 0, utf16_string.c_str(), -1, &result[0],
                      size_needed, nullptr, nullptr);
  result.resize(size_needed - 1);
  return result;
}
