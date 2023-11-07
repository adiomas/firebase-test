// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "add_todo": MessageLookupByLibrary.simpleMessage("Add Todo"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enter_your_email": MessageLookupByLibrary.simpleMessage(
            "Please enter your email to continue."),
        "enter_your_password": MessageLookupByLibrary.simpleMessage(
            "Please enter your password to continue."),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "login_with_firebase":
            MessageLookupByLibrary.simpleMessage("Login with Firebase"),
        "login_with_supabase":
            MessageLookupByLibrary.simpleMessage("Login with Supabase"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "not_valid_email":
            MessageLookupByLibrary.simpleMessage("Not a valid e-mail address"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "permission_denied": MessageLookupByLibrary.simpleMessage(
            "Permission has been denied, please enable it in device settings"),
        "required_field":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "title": MessageLookupByLibrary.simpleMessage("Title*"),
        "unknown_error_occurred":
            MessageLookupByLibrary.simpleMessage("Unknown error occurred"),
        "write_here": MessageLookupByLibrary.simpleMessage("Write here"),
        "your_email": MessageLookupByLibrary.simpleMessage("Your email"),
        "your_password": MessageLookupByLibrary.simpleMessage("Your password")
      };
}
