import React, { useState, useEffect, useRef } from 'react';
import UsuarioList from './UsuarioList'; 
import UsuarioForm from './UsuarioForm'; 
import UsuarioSenhaForm from './UsuarioSenhaForm'; 
import UsuarioSrv from '../../services/UsuarioSrv'; 
import { Toast } from 'primereact/toast';
import { confirmDialog } from 'primereact/confirmdialog';

function UsuarioCon() {
  // state
  const [usuarios, setUsuarios] = useState([])
  const toastRef = useRef(); // ter a referência com componente toast

  useEffect(() => {
    onClickAtualizar(); // ao inicializar execula método para atualizar
  }, []);


  const onClickAtualizar = () => {
    UsuarioSrv.listar().then(response => {
      setUsuarios(response.data);
      toastRef.current.show({ severity: 'success', summary: 'Carregou usuários', life: 1000 });
    }).catch(e => {
      toastRef.current.show({ severity: 'error', summary: e.message, life: 5000 });
    });
  }

  // operação inserir
  const initialState = { _id: null, nome: '', email: '', celular: '' }
  const [usuario, setUsuario] = useState(initialState)
  const [editando, setEditando] = useState("")
  const inserir = () => {
    setUsuario(initialState);
    setEditando("UsuarioForm");
  }

  const salvar = () => {
    if (usuario._id === null) { // inclussão
      UsuarioSrv.incluir(usuario).then(response => {
        setEditando("");
        onClickAtualizar();
        toastRef.current.show({ severity: 'success', summary: "Salvou", life: 2000 });
      })
        .catch(e => {
          toastRef.current.show({ severity: 'error', summary: e.message, life: 4000 });
        });
    } else { // alteração
      UsuarioSrv.alterar(usuario).then(response => {
        setEditando("");
        onClickAtualizar();
        toastRef.current.show({ severity: 'success', summary: "Salvou", life: 2000 });
      })
        .catch(e => {
          toastRef.current.show({ severity: 'error', summary: e.message, life: 4000 });
        });
    }
  }

  const cancelar = () => {
    toastRef.current.show({ severity: 'warn', summary: 'Cancelou', life: 2000 });
    setEditando("");
  }

  // operação editar e excluir
  const editar = (_id) => {
    setUsuario(usuarios.filter((usuario) => usuario._id === _id)[0]);
    setEditando("UsuarioForm");
  }

  const excluirConfirm = (_id) => {
    UsuarioSrv.excluir(_id).then(response => {
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

  const definirSenha = (_id) => {
    setUsuario(usuarios.filter((usuario) => usuario._id === _id)[0]);
    setEditando("UsuarioSenhaForm");   
  }

  const salvarSenha = () => {
    UsuarioSrv.alterarSenha(usuario).then(response => {
      setEditando("");   
      toastRef.current.show({ severity: 'success', summary: "Senha alterada com sucesso.", life: 2000 });
    }).catch(e => {
      toastRef.current.show({ severity: 'error', summary: e.message, life: 4000 });
    });
  }  



  if (editando === "") {
    return (
      <div className="App">
        <Toast ref={toastRef} />
        <UsuarioList usuarios={usuarios} onClickAtualizar={onClickAtualizar}
          inserir={inserir} editar={editar} excluir={excluir} definirSenha={definirSenha} />
      </div>
    );
  } else if (editando === "UsuarioForm") {
    return (
      <div className="App">
        <Toast ref={toastRef} />
        <UsuarioForm usuario={usuario} setUsuario={setUsuario}
          salvar={salvar} cancelar={cancelar} />
      </div>
    );
  } else if (editando === "UsuarioSenhaForm") {
    return (
      <div className="App">
        <Toast ref={toastRef} />
        <UsuarioSenhaForm usuario={usuario} setUsuario={setUsuario} toastRef={toastRef}
          salvarSenha={salvarSenha} cancelar={cancelar} />
      </div>
    );
  }
}

export default UsuarioCon;
