import Vue from 'vue/dist/vue.esm.js';
import Vuex from 'vuex';

Vue.use(Vuex);

const TOKEN = document.getElementById('token').value;
const CSRF = document.getElementsByName("csrf-token")[0].content;


export default new Vuex.Store({
    state: {
        journalTypes: [],
        journalByType: {},
    },
    mutations: {
        fetchJournalTypes(state){
			fetch("/api/journal_types")
				.then(response => response.json())
				.then(json => state.journalTypes = json.journal_types);
		},
		fetchJournals(state){
			fetch("/api/journals", {
				method: "get",
				headers: new Headers({
					'Authorization': 'Token ' + TOKEN,
				}),
			}).then(response => response.json())
			    .then(json => {
				    state.journalByType = json.journals.reduce((m, j) => {
					    let newm = JSON.parse(JSON.stringify(m));
					    if(!newm[j.jtid]){
						    newm[j.jtid] = [];
					    }
					    let ary = newm[j.jtid];
					    ary = ary.concat(j);
					    newm[j.jtid] = ary;
					    return newm;
				    }, {});
			    });
		},
    },
    actions: {
        postJournal(state, { body }){
			fetch("/api/journals", {
				method: "post",
				headers: new Headers({
					'Authorization': 'Token ' + TOKEN,
					'Content-Type': 'application/x-www-form-urlencoded',
					'X-CSRF-Token': CSRF,
				}),
				body: body,
			}).then(r => state.commit('fetchJournals'));
		},
		deleteJournal(state, { jid }){
			fetch("/api/journals/" + jid, {
				method: "delete",
				headers: new Headers({
					'Authorization': 'Token ' + TOKEN,
					'X-CSRF-Token': CSRF,
				}),
			}).then(r => state.commit('fetchJournals'));
		},
    },
});
