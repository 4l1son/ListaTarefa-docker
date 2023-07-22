<template>
    <div>
      <v-data-table :headers="headers" :items="tarefas" item-key="texto">
        <template v-slot:item.actions="{ item }">
          <v-btn icon small @click="excluirTarefa(item)">
            <v-icon>mdi-delete</v-icon>
          </v-btn>
          <v-btn icon small @click="abrirFormulario(item)">
            <v-icon>mdi-pencil</v-icon>
          </v-btn>
        </template>
      </v-data-table>
  
      <!-- Formulário de Edição -->
      <v-dialog v-model="formularioVisivel" persistent max-width="500px">
        <template v-slot:activator="{ on }"></template>
        <v-card>
          <v-card-title>Editar Tarefa</v-card-title>
          <v-card-text>
            <!-- Use v-select to display the three states -->
            <v-select v-model="tarefaEditada.status" :items="['pendente', 'andamento', 'concluído']" label="Status da Tarefa"></v-select>
          </v-card-text>
          <v-card-actions>
            <v-btn color="primary" @click="atualizarTarefa">Atualizar</v-btn>
            <v-btn color="secondary" @click="fecharFormulario">Cancelar</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      tarefas: {
        type: Array,
        required: true,
      },
    },
    data() {
      return {
        formularioVisivel: false,
        tarefaEditada: {
          status: '',
        },
        tarefaIndex: -1,
        headers: [
          { text: 'Tarefa', value: 'texto' },
          { text: 'Status', value: 'status' },
          { text: 'Ações', value: 'actions' },
        ],
      };
    },
    methods: {
      excluirTarefa(tarefa) {
        this.$emit('excluirTarefa', tarefa); // Emitir o evento "excluirTarefa" com a tarefa a ser excluída
      },
      abrirFormulario(tarefa) {
        this.tarefaIndex = this.tarefas.indexOf(tarefa);
        this.tarefaEditada = { ...tarefa };
        this.formularioVisivel = true;
      },
      fecharFormulario() {
        this.formularioVisivel = false;
        this.tarefaIndex = -1;
        this.tarefaEditada = {
          nome: '',
          status: '',
        };
      },
      atualizarTarefa() {
        this.$emit('atualizarTarefa', this.tarefaEditada); // Emitir o evento "atualizarTarefa" com a tarefa atualizada
        this.fecharFormulario();
      },
    },
  };
  </script>
  