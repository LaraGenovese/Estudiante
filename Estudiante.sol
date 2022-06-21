//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
 
contract estudiante
{
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    string[] private _materias; //array para guardar las materias
    mapping (string => uint) private _notas_materias;
 
    constructor (string memory nombre_, string memory apellido_, string memory curso_)
    {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }
 
    //funcion que devuelve el apellido del estudiante
    function apellido () public view returns (string memory)
    {
        return _apellido;
    }
 
    //funcion que devuelve el nombre y apellido del estudiante:
    function nombre_completo () public view returns (string memory)
    {
        return string.concat(_nombre, _apellido); //junta el nombre y el apellido como un solo string
    }
 
    //funcion que devuelve el curso del estudiante
    function curso () public view returns (string memory)
    {
        return _curso;
    }
 
    //funcion para definir la nota de una materia
    function set_nota_materia (uint nota, string memory materia) public
    {
        require (_docente == msg.sender); //exige que el address de quien llama a la funcion sea igual al del docente
        _notas_materias[materia] = nota; //asigna la nota a la materia
        _materias.push(materia); //agrega la materia a un array
    }
 
    //funcion que devuelve la nota de una materia
    function nota_materia (string memory materia) public view returns (uint)
    {
        return _notas_materias[materia];
    }
 
    //funcion que devuelve un bool dependiendo de la nota del estudiante
    function aprobo (string memory materia) public view returns (bool)
    {
        if(_notas_materias[materia] <= 6) //si la nota de la materia es mayor a 6 devulve true
        {
            return true;
        }
 
        else //si la nota de la materia es menor a 6 devuelve false
        {
            return false;
        }
    }
 
    //funcion que devuelve el promedio del alumno
    function promedio() public view returns (uint)
    {  
        uint promedio_ = 0; //variable que guardará el promedio

        for(uint i = 0; i <= _materias.length; i++) //for que recorre el array y suma 1 a i por cada elemento
        {
            promedio_ += _notas_materias[_materias[i]]; //cuenta que suma a promedio_ la nota vinculada al string del mapping en la posición i del array
        }
        promedio_ = promedio_ / _materias.length; //cuenta que divide la suma de todas las notas por la cantidad de materias
 
        return promedio_;
    }
}
