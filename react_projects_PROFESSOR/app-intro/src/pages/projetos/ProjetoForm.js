import React, { useState, useEffect } from 'react';
import { Button } from 'primereact/button';
import { InputText } from 'primereact/inputtext';
import { InputTextarea } from 'primereact/inputtextarea';
import { Calendar } from 'primereact/calendar';

import { AutoComplete } from 'primereact/autocomplete';
import UsuarioSrv from "../../services/UsuarioSrv";

const ProjetoForm = (props) => {

    const [responsaveis, setResponsaveis] = useState([])
    const [responsaveisFiltrados, setResponsaveisFiltrados] = useState([])

    useEffect(() => {
        listarResponsaveis();
    }, []);

    const listarResponsaveis = () => {
        UsuarioSrv.listar().then(response => {
           setResponsaveis(response.data)
        }).catch(e => { });
    }

    const filtrarResponsavel = (event) => {
        setTimeout(() => {
            let filtrados;
            if (!event.query.trim().length) {
                filtrados = [...responsaveis];
            }
            else {
                filtrados = responsaveis.filter((resp) => {
                    return resp.nome.toLowerCase().startsWith(event.query.toLowerCase());
                });
            }
            setResponsaveisFiltrados(filtrados);
        }, 500);
    }

    const handleSubmit = (event) => {
        event.preventDefault();
        props.salvar();
    }
    const handleInputChange = (event) => {
        const { name, value } = event.target
        props.setProjeto({ ...props.projeto, [name]: value })
    }

    return (
        <form onSubmit={handleSubmit} >
            <div className="p-fluid">
                <div className="p-field">
                    <label htmlFor="titulo">Título</label>
                    <InputText name="titulo" value={props.projeto.titulo} onChange={handleInputChange} required />
                </div>

                <div className="p-field">
                    <label htmlFor="descricao">Descrição</label>
                    <InputTextarea name="descricao" rows={5} cols={30} value={props.projeto.descricao} onChange={handleInputChange} autoResize />
                </div>

                <div className="p-field">
                    <label htmlFor="dataInicio">Data Início</label>
                    <Calendar name="dataInicio" dateFormat="dd/mm/yy" value={new Date(props.projeto.dataInicio)} onChange={handleInputChange} showIcon />
                </div>

                <div className="p-field">
                    <label htmlFor="dataTermino">Data Término</label>
                    <Calendar name="dataTermino" dateFormat="dd/mm/yy" value={new Date(props.projeto.dataTermino)} onChange={handleInputChange} showIcon />
                </div>

                <div className="p-field">
                    <label htmlFor="nomeDemandante">Nome Demandante</label>
                    <InputText name="nomeDemandante" value={props.projeto.nomeDemandante} onChange={handleInputChange} />
                </div>

                <div className="p-field">
                    <label htmlFor="responsavel">Usuário Responsavel</label>
                    <AutoComplete dropdown name="responsavel" value={props.projeto.responsavel} suggestions={responsaveisFiltrados}
                        completeMethod={filtrarResponsavel} field="nome" onChange={handleInputChange} />
                </div>

            </div>


            <Button icon="pi pi-save" className="p-button-outlined" label="Salvar"></Button>
            <Button type="button" icon="pi pi-undo" className="p-button-outlined" label="Cancelar" onClick={props.cancelar}></Button>


        </form>
    )
}
export default ProjetoForm