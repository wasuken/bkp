import Vue from 'vue/dist/vue.esm.js';

import Content from './components/journals/content';

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(Content)
    }).$mount();
    document.body.appendChild(app.$el);
});
