import React from 'react'
import { InputText } from 'primereact/inputtext';
import { Button } from 'primereact/button';

const UsuarioSenhaForm = (props) => {
    
    const handleSubmit = (event) => {
        event.preventDefault();
        if (senha1 !== senha2) {
            props.toastRef.current.show({ severity: 'error', summary: 'Senhas não conferem', life: 4000 });
            return false;
        } else {
            props.usuario.senha = senha1
            props.salvarSenha()
        }
      
    }

    let senha1;
    let senha2;

    return (
        <form onSubmit={handleSubmit} >

           <div className="p-fluid p-formgrid p-grid">
                <div className="p-field p-col-12">
                    <label htmlFor="nome">Nome</label>
                    <InputText id="nome" type="text" name="nome"
                        value={props.usuario.nome} readOnly />
                </div>
                <div className="p-field p-col-12 p-md-6">
                    <label htmlFor="senha">Senha</label>
                    <InputText id="senha" type="password" name="senha"
                        value={senha1} onChange={e => senha1 = e.target.value} />
                </div>
                <div className="p-field p-col-12 p-md-6">
                    <label htmlFor="senha2">Confirmar Senha</label>
                    <InputText id="senha2" type="password" name="senha2"
                        value={senha2} onChange={e => senha2 = e.target.value} />
                </div>

            </div>
            <div style={{ textAlign: 'center' }}>
                <Button icon="pi pi-save" type="submit" label="Salvar" className="p-button-sm" />
                <Button icon="pi pi-undo" type="button" label="Cancelar" className="p-button-sm p-button-warning" onClick={() => props.cancelar()} />
            </div>

        </form>
    )
}
export default UsuarioSenhaForm