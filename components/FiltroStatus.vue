<template>
  <div>
    <label>Filtrar por status:</label>
    <select v-model="filtroStatus">
      <option value="">Todos</option>
      <option value="pendente">Pendente</option>
      <option value="concluida">Concluída</option>
    </select>
  </div>
</template>

<script>
export default {
  data() {
    return {
      filtroStatus: ''
    };
  },
  watch: {
    filtroStatus: function(newStatus) {
      this.$emit('atualizarFiltro', newStatus);
    }
  }
};
</script>
