import Vue from 'vue/dist/vue.esm.js';

import IOList from './components/journals/IOList';
import store  from '../store';

new Vue({
    store,
    render: h => h(IOList),
}).$mount('#app');
