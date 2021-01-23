class Validators{
  static String emailValidator(String value){
    if(value.isEmpty){
      return 'Debe ingresar una dirección de correo electrónico';
    }else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)){
      return 'Debe ingresar una dirección de correo válida';
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