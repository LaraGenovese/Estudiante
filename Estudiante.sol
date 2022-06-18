pragma solidity ^0.8.12;
 
contract estudiante
{
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    string[] private _materias;
    mapping (string => uint) private _notas_materias;
 
    constructor (string memory nombre_, string memory apellido_, string memory curso_)
    {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }
 
    function apellido () public view returns (string memory)
    {
        return _apellido;
    }
 
    function nombre_completo () public view returns (string memory)
    {
        return string.concat(_nombre, _apellido);
    }
 
    function curso () public view returns (string memory)
    {
        return _curso;
    }
 
    function set_nota_materia (uint nota, string memory materia) public
    {
        require (_docente == msg.sender);
        _notas_materias[materia] = nota;
        //agregar materia al array
        _materias.push(materia);
    }
 
    function nota_materia (string memory materia) public view returns (uint)
    {
        return _notas_materias[materia];
    }
 
    function aprobo (string memory materia) public view returns (bool)
    {
        if(_notas_materias[materia] <= 6)
        {
            return true;
        }
 
        else
        {
            return false;
        }
    }
 
    function promedio() public view returns (uint)
    {  
        uint promedio_ = 0;
        for(uint i = 0; i <= _materias.length; i++)
        {
            promedio_ += _notas_materias[_materias[i]];
        }
        promedio_ = promedio_ / _materias.length;
 
        return promedio_;
    }
}