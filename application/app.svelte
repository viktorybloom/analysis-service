<!-- App.svelte -->

<script>
  async function callService(service) {
    const response = await fetch(`/api/${service}`);
    const data = await response.text();
    console.log(data);
  }
</script>

<main>
  <h1>Welcome to the Basic Web App</h1>
  <button on:click={() => callService('postgres')}>PostgreSQL Service</button>
  <button on:click={() => callService('neo4j')}>Neo4j Service</button>
  <button on:click={() => callService('jupyter')}>Jupyter Service</button>
  <button on:click={() => callService('manage_database')}>Manage Database</button>
</main>

<style>
  main {
    text-align: center;
    padding: 1em;
    max-width: 240px;
    margin: 0 auto;
  }

  h1 {
    color: #333;
  }

  button {
    margin: 0.5em;
    padding: 0.5em 1em;
  }
</style>

