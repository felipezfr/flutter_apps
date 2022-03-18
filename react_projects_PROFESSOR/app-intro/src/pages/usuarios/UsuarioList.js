const UsuarioList = (props) => (
    <div>
        <h4>Listar Usuários</h4>

        <button type="button" onClick={props.onClickAtualizar} class="btn btn-primary btn-sm">Atualizar</button>
        <button type="button" onClick={props.inserir} class="btn btn-primary btn-sm">Inserir</button>

        <table className="table">
            <thead>
                <tr>
                    <th>Index</th>
                    <th>Id</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Celular</th>
                    <th>Operações</th>
                </tr>
            </thead>
            {props.usuarios.map((o, index) => (
                <tr key={index}>
                    <td>{index}</td>
                    <td>{o._id}</td>
                    <td>{o.nome}</td>
                    <td>{o.email}</td>
                    <td>{o.celular}</td>
                    <td>
                        <button onClick={() => props.definirSenha(o._id)} /*className="btn btn-primary btn-sm"*/>Definir Senha</button>
                        <button onClick={() => props.editar(o._id)} /*className="btn btn-primary btn-sm"*/>Editar</button>
                        <button onClick={() => props.excluir(o._id)} /*className="btn btn-danger btn-sm"*/>Excluir</button>
                    </td>
                </tr>
            ))
            }
        </table>
    </div>
)
export default UsuarioList