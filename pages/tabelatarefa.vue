<template>
    <div>
      <cadastro @addTask="addTask" />
      <TabelaTarefas :tarefas="tarefas" @excluirTarefa="excluirTarefa" @atualizarTarefa="atualizarTarefa" />
    </div>
  </template>
  
  <script>
  import TabelaTarefas from '../components/TabelaTarefa.vue';
  import cadastro from './cadastro.vue';
  
  export default {
    components: {
      TabelaTarefas,
      cadastro
    },
    data() {
      return {
        tarefas: [],
      };
    },
    created() {
      // Carregar as tarefas do Local Storage ao criar o componente
      this.carregarTarefas();
    },
    methods: {
      addTask(tarefa) {
        this.tarefas.push(tarefa);
        this.salvarTarefas(); // Salvar as tarefas após adicionar uma nova
      },
      salvarTarefas() {
        // Salvar as tarefas no Local Storage como JSON
        localStorage.setItem('tarefas', JSON.stringify(this.tarefas));
      },
      carregarTarefas() {
        // Carregar as tarefas do Local Storage
        const tarefasJSON = localStorage.getItem('tarefas');
        if (tarefasJSON) {
          this.tarefas = JSON.parse(tarefasJSON);
        }
      },
      excluirTarefa(tarefa) {
        const index = this.tarefas.indexOf(tarefa);
        if (index !== -1) {
          this.tarefas.splice(index, 1);
          this.salvarTarefas(); // Salvar as tarefas após excluir uma tarefa
        }
      },
      atualizarTarefa(tarefaAtualizada) {
        const index = this.tarefas.findIndex(tarefa => tarefa.texto === tarefaAtualizada.texto);
        if (index !== -1) {
          this.tarefas.splice(index, 1, tarefaAtualizada);
          this.salvarTarefas(); // Salvar as tarefas após atualizar uma tarefa
        }
      },
    },
  };
  </script>
  