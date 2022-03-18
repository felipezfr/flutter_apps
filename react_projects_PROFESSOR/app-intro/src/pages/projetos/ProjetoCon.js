import React, { useState, useEffect, useRef } from 'react';
import ProjetoList from './ProjetoList'; //
import ProjetoForm from './ProjetoForm'; //
import ProjetoSrv from '../../services/ProjetoSrv'; //
import { Toast } from 'primereact/toast';
import { confirmDialog } from 'primereact/confirmdialog';

function ProjetoCon() {
  // state
  const [projetos, setProjetos] = useState([])
  const toastRef = useRef(); // ter a referência com componente toast

  useEffect(() => {
    onClickAtualizar(); // ao inicializar execula método para atualizar
  }, []);


  const onClickAtualizar = () => {
    ProjetoSrv.listar().then(response => {
      setProjetos(response.data);
      toastRef.current.show({ severity: 'success', summary: 'Carregou', life: 1000 });
    }).catch(e => {
      toastRef.current.show({ severity: 'error', summary: e.message, life: 5000 });
    });
  }

  // operação inserir
  const initialState = { _id: null, nome: '', email: '', celular: '' }
  const [projeto, setProjeto] = useState(initialState)
  const [editando, setEditando] = useState(false)
  const inserir = () => {
    setProjeto(initialState);
    setEditando(true);
  }

  const salvar = () => {
    if (projeto._id === null) { // inclussão
      ProjetoSrv.incluir(projeto).then(response => {
        toastRef.current.show({ severity: 'success', summary: "Inseriu", life: 2000 });
        setEditando(false);
        onClickAtualizar();
      }).catch(e => {
          toastRef.current.show({ severity: 'error', summary: e.message, life: 4000 });
      });
    } else { // alteração
      ProjetoSrv.alterar(projeto).then(response => {
        setEditando(false);
        onClickAtualizar();
        toastRef.current.show({ severity: 'success', summary: "Alterou", life: 2000 });
      })
        .catch(e => {
          toastRef.current.show({ severity: 'error', summary: e.message, life: 4000 });
        });
    }
  }

  const cancelar = () => {
    toastRef.current.show({ severity: 'warn', summary: 'Cancelou', life: 2000 });
    setEditando(false);
  }

  // operação editar e excluir
  const editar = (_id) => {
    setProjeto(projetos.filter((projeto) => projeto._id === _id)[0]);
    setEditando(true);
  }

  const excluirConfirm = (_id) => {
    ProjetoSrv.excluir(_id).then(response => {
      onClickAtualizar();
      toastRef.current.show({
        severity: 'success',
        summary: "Excluído",
        life: 2000
      });
    })
      .catch(e => {
        toastRef.current.show({
          severity: 'error',
          summary: e.message,
          life: 4000
        });
      });
  }

  const excluir = (_id) => {
    confirmDialog({
      message: 'Confirma a exclusão?',
      header: 'Confirmação',
      icon: 'pi pi-question',
      acceptLabel: 'Sim',
      rejectLabel: 'Não',
      acceptClassName: 'p-button-danger',
      accept: () => excluirConfirm(_id)
    });
  }


  if (!editando) {
    return (
      <div className="App">
        <Toast ref={toastRef} />
        <ProjetoList projetos={projetos} projeto={projeto}  setProjeto={setProjeto} onClickAtualizar={onClickAtualizar}
          inserir={inserir} editar={editar} excluir={excluir} />
      </div>
    );
  } else {
    return (
      <div className="App">
        <Toast ref={toastRef} />
        <ProjetoForm projeto={projeto} setProjeto={setProjeto} salvar={salvar} cancelar={cancelar} />
      </div>
    );
  }
}

export default ProjetoCon;
