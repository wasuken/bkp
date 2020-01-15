<template>
	<div>
		<div class="border border-primary" style="width: 50%; height: 500px; float:left;"
			 v-for="jt in journalTypes">
			<div>
				<h3>{{jt.name}}</h3>
				<ul>
					<li v-for="journal in journalByType[jt.id]">
						{{journal.name}}
						->
						{{journal.amount}}
						<a class="alert" href="javascript:void(0)"
						   v-on:click="dJour(journal.id)">
							[delete]
						</a>
						<br/>
						<small class="text-muted">{{
												  (new Date(journal.created_at)).toLocaleString('ja-JP')
												  }}</small>
					</li>
				</ul>
				<div style="py-4 bg-dark text-white-50">
					<div class="input-group float-left">
						<input type="text" class="form-control" placeholder="journal name"
							   aria-label="journal-name" aria-describedby="basic-addon1"
							   :id="`journal-name-${jt.id}`">
						<input type="number" class="form-control" placeholder="journal amount"
							   aria-label="journal-amount" aria-describedby="basic-addon1"
							   :id="`journal-amount-${jt.id}`">
						<button type="button" class="btn btn-primary"
								v-on:click="pJour(jt.id)">Post</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
 import { mapState } from 'vuex';
 export default {
	 name: 'IOList',
     computed: mapState([
		 "journalTypes",
         "journalByType",
     ]),
	 methods:{
		 pJour: function(jtid){
			 let name = document.getElementById("journal-name-" + jtid).value;
			 let amount = document.getElementById("journal-amount-" + jtid).value;
			 let csrf = document.getElementsByName("csrf-token")[0].content;
			 let body = "name=" + name + "&" + "amount=" + amount + "&" +
						"journal_type_id=" + jtid;
			 this.$store.dispatch('postJournal', { body });
			 document.getElementById("journal-name-" + jtid).value = "";
			 document.getElementById("journal-amount-" + jtid).value = "";
		 },
		 dJour: function(jid){
			 this.$store.dispatch('deleteJournal', { jid });
		 },
		 update: function(){
			 this.$store.commit('fetchJournalTypes');
			 this.$store.commit('fetchJournals');
		 }
	 },
	 mounted: function(){
		 this.update();
	 },
 }
</script>
