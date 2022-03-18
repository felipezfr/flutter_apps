import React from 'react';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { Button } from 'primereact/button';

const ProjetoList = (props) => {

    const actionBodyTemplate = (rowData) => {
      return (
        <React.Fragment>
          <Button type="button" icon="pi pi-pencil" className="p-button-rounded p-button-text " onClick={() => props.editar(rowData._id)}></Button>
          <Button type="button" icon="pi pi-trash" className="p-button-rounded p-button-text" onClick={() => { props.excluir(rowData._id);}}></Button>
        </React.Fragment>
      );
    }
    const header = (
        <div style={{display:'flex', alignItems:'center', justifyContent:'space-between'}}>
          Listagem de Projetos
          <Button icon="pi pi-file-o" label="Inserir" className="p-button-sm" onClick={() => props.inserir()} />
        </div>
    );
    const footer = `Total de itens: ${props.projetos ? props.projetos.length : 0}`;

    return (
    <div>
      <DataTable value={props.projetos} header={header} footer={footer} 
        paginator className="p-datatable-sm" paginatorPosition="top"
        paginatorTemplate="CurrentPageReport FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink RowsPerPageDropdown"
        currentPageReportTemplate="Listando de {first} a {last} de {totalRecords}" rows={10} rowsPerPageOptions={[10, 25, 50, 100]}
        selectionMode="single" selection={props.projeto} onSelectionChange={e => props.setProjeto(e.value)}
      >
        <Column field="titulo" header="Título" sortable filter></Column>
        <Column field="nomeDemandante" header="Nome Demandante" sortable filter></Column>
        <Column field="dataInicio" header="Data Início" sortable filter></Column>
        <Column field="responsavel.nome" header="Responsável" sortable filter></Column>
        <Column header="Operações" body={actionBodyTemplate}></Column>
      </DataTable>
    </div>
    );
}
export default ProjetoList