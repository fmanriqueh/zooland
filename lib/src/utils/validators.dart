class Validators{
  static String emailValidator(String value){
    if(value.isEmpty){
      return 'Debe ingresar una dirección de correo electrónico';
    }else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)){
      return 'Debe ingresar una dirección de correo válida';
    }
    return null;
  }

  static String passwordValidator(String value) {
    if(value.isEmpty) {
      return 'Debe ingresar una contraseña';
    } else if(!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value)) {
      return 'La contraseña debe tener al menos 8 caracteres,\n una letra y un número';
    }
    return null;
  }

  static String generalValidator(String value){
    if(value.isEmpty){
      return "Este campo no puede estar vacio";
    }
    return null;
  }
}