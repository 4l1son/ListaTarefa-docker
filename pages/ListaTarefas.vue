<template>
  <div>
    <filtro-status @atualizarFiltro="atualizarFiltro" />
    <TabelaTarefas :tarefas="tarefasFiltradas" @excluirTarefa="excluirTarefa" @atualizarTarefa="atualizarTarefa" />
  </div>
</template>

<script>
import TabelaTarefas from '../components/TabelaTarefa.vue';
import FiltroStatus from '../components/FiltroStatus.vue';

export default {
  components: {
    TabelaTarefas,
    FiltroStatus
  },
  data() {
    return {
      tarefas: []
    };
  },
  created() {
    // Carregar as tarefas do Local Storage ao criar o componente
    this.carregarTarefas();
  },
  computed: {
    tarefasFiltradas() {
      if (!this.tarefas || this.tarefas.length === 0) {
        return []; // Retorna um array vazio se tarefas estiver indefinido ou vazio
      }

      // Se o filtro de status não estiver definido, retorna todas as tarefas
      if (!this.filtroStatus) {
        return this.tarefas;
      }

      // Filtra as tarefas com base no status selecionado
      return this.tarefas.filter(tarefa => tarefa.status === this.filtroStatus);
    }
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
  }
};
</script>

