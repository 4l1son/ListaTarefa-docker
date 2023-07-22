<template>
  <div>
    <!-- Filter tasks by status -->
    <v-container>
      <v-row>
        <v-col cols="12" md="6">
          <v-select v-model="filtroStatus" :items="statusDisponiveis" label="Filtrar por Status"></v-select>
        </v-col>
      </v-row>
    </v-container>

    <!-- Display filtered tasks in a data table -->
    <v-container v-if="tarefasFiltradas.length > 0">
      <v-data-table :headers="headers" :items="tarefasFiltradas" item-key="texto">
        <template v-slot:item.actions="{ item }">
          <v-btn icon small @click="excluirTarefa(item)">
            <v-icon>mdi-delete</v-icon>
          </v-btn>
          <v-btn icon small @click="abrirFormulario(item)">
            <v-icon>mdi-pencil</v-icon>
          </v-btn>
        </template>
      </v-data-table>
    </v-container>
    <v-container v-else>
      <p>Nenhuma tarefa encontrada com o status selecionado.</p>
    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tarefa: '', // The task input
      status: '', // The status input
      filtroStatus: '', // The selected status filter
      headers: [
        { text: 'Tarefa', value: 'texto' },
        { text: 'Status', value: 'status' },
        { text: 'Ações', value: 'actions' },
      ],
    };
  },
  computed: {
    // Get available statuses from the tasks
    statusDisponiveis() {
      const statuses = this.tarefas.map(tarefa => tarefa.status);
      return Array.from(new Set(statuses)); // Remove duplicates using Set and convert back to array
    },
    // Filter the tasks based on the selected status
    tarefasFiltradas() {
      if (!this.filtroStatus) {
        return this.tarefas;
      }
      return this.tarefas.filter((tarefa) => tarefa.status === this.filtroStatus);
    },
  },
  methods: {
    // ... Add your addTask, excluirTarefa, abrirFormulario, and salvarTarefas methods here

    // Load tasks from Local Storage on component mount
    carregarTarefasSalvas() {
      const tarefasSalvas = localStorage.getItem('tarefas');
      if (tarefasSalvas) {
        this.tarefas = JSON.parse(tarefasSalvas);
      }
    },
  },
  mounted() {
    // Load saved tasks from Local Storage when the component mounts
    this.carregarTarefasSalvas();
  },
};
</script>

