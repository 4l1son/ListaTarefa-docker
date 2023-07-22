<template>
    <div>
      <form @submit.prevent="addTask">
        <input type="text" v-model="tarefa" placeholder="Tarefa" />
        <button type="submit">Cadastrar</button>
      </form>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        tarefa: '',
      };
    },
    methods: {
      addTask() {
        const novaTarefa = { texto: this.tarefa, status: 'Pendente' };
  
        // Carregar as tarefas existentes do Local Storage
        const tarefasJSON = localStorage.getItem('tarefas');
        let tarefas = [];
        if (tarefasJSON) {
          tarefas = JSON.parse(tarefasJSON);
        }
  
        // Adicionar a nova tarefa ao array de tarefas
        tarefas.push(novaTarefa);
  
        // Salvar o array de tarefas no Local Storage como JSON
        localStorage.setItem('tarefas', JSON.stringify(tarefas));
  
        // Emitir o evento "addTask" com a nova tarefa
        this.$emit('addTask', novaTarefa);
  
        // Limpar o campo de entrada após cadastrar a tarefa
        this.tarefa = '';
      },
    },
  };
  </script>
  