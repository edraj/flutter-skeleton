final msisdnREGEX = RegExp(r'^[1-9]\d{9}$');
final passwordREGEX =
    RegExp(r'^(?=.*\d)(?=.*[A-Z])[a-zA-Z\d_#@%\*\-!?$^]{8,24}$');
final emailREGEX = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);
