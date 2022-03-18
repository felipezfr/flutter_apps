import './App.css';
import React, { Suspense, lazy } from 'react';
import "bootstrap/dist/css/bootstrap.min.css";
import 'primereact/resources/themes/saga-blue/theme.css';
import 'primereact/resources/primereact.min.css';
import 'primeicons/primeicons.css';
import {BrowserRouter as Router, Switch, Route} from "react-router-dom";
import { Menubar } from 'primereact/menubar';

const Home = lazy(() => import('./pages/home/Home'));
const UsuarioCon = lazy(() => import('./pages/usuarios/UsuarioCon'));
const ProjetoCon = lazy(() => import('./pages/projetos/ProjetoCon'));

function App() {

  const items = [
    {
      label:'Home', icon:'pi pi-fw pi-home',
      command: () => { window.location = "/" }
    },
    {
       label:'Cadastro', icon:'pi pi-fw pi-file',
       items:[
          {
             label:'Usuários', icon:'pi pi-fw pi-user',
             command: () => {window.location = "/usuarios"}
          }, 
          {
            label:'Projetos', icon:'pi pi-fw pi-user',
            command: () => {window.location = "/projetos"}
         }
       ]
    },
    {
       label:'Sair', icon:'pi pi-fw pi-power-off'
    }
  ];


  return (
    <Router>
      <div>
        
       <Menubar model={items}/>

        <Suspense fallback={<div>Carregando ...</div>}>
          <Switch>
            <Route exact path="/" component={Home} />
            <Route path="/usuarios" component={UsuarioCon} />
            <Route path="/projetos" component={ProjetoCon} />
          </Switch>
        </Suspense>
      </div>
    </Router>
  );
}
export default App;
