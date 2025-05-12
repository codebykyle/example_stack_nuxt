<script setup lang="ts">
const { data, pending, error } = await useFetch('/api/whoami')
</script>

<template>
  <div>


    <div class="p-4 font-mono text-sm whitespace-pre-wrap">
      <p v-if="pending">Loading headers…</p>

      <p v-else-if="error">Could not reach /api/whoami — {{ error.message }}</p>

      <pre v-else>{{ JSON.stringify(data.headers, null, 2) }}</pre>
    </div>
    <NuxtRouteAnnouncer />
    <NuxtWelcome />
  </div>
</template>
