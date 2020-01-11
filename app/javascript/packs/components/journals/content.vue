<template>
	<div>
		<div class="border border-primary" style="width: 50%; height: 500px; float:left;"
			 v-for="jt in journalTypes">
			<div>
				<h3>{{jt.name}}</h3>
				<ul>
					<li v-for="journal in journalByType[jt.id]">
						{{journal.name}}({{journal.jtname}})
						->
						{{journal.amount}}
						<br/>
						<small class="text-muted">{{journal.created_at}}</small>
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
									  v-on:click="postJournal(jt.id)">Post</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<script>
 export default {
	 data: function(){
		 return{
			 token: "",
			 journalByType: {},
			 journalTypes: [],
		 }
	 },
	 methods: {
		 fetchJournalTypes: function(){
			 fetch("/api/journal_types")
				 .then(response => response.json())
				 .then(json => this.journalTypes = json.journal_types);
		 },
		 fetchJournals: function(){
			 fetch("/api/journals", {
				 method: "get",
				 headers: new Headers({
					 'Authorization': 'Token ' + this.token,
				 }),
			 }).then(response => response.json())
			   .then(json => {
				   this.journalByType = json.journals.reduce((m, j) => {
					   let newm = JSON.parse(JSON.stringify(m));
					   if(!newm[j.jtid]){
						   newm[j.jtid] = [];
					   }
					   let ary = newm[j.jtid];
					   ary = ary.concat(j);
					   newm[j.jtid] = ary;
					   return newm;
				   }, {});
				   console.log(this.journalByType);
			   });
		 },
		 postJournal(jtid){
			 let name = document.getElementById("journal-name-" + jtid).value;
			 let amount = document.getElementById("journal-amount-" + jtid).value;
			 let csrf = document.getElementsByName("csrf-token")[0].content;
			 let body = "name=" + name + "&" + "amount=" + amount + "&" +
						"journal_type_id=" + jtid;
			 let that = this;
			 fetch("/api/journals", {
				 method: "post",
				 headers: new Headers({
					 'Authorization': 'Token ' + this.token,
					 'Content-Type': 'application/x-www-form-urlencoded',
					 'X-CSRF-Token': csrf,
				 }),
				 body: body,
			 }).then(resp => {
				 console.log(resp);
				 document.getElementById("journal-name-" + jtid).value = "";
				 document.getElementById("journal-amount-" + jtid).value = "";
				 setTimeout(function(){ that.fetchJournals(); }, 3000);
			 });
		 },
	 },
	 mounted: function(){
		 this.token = document.getElementById('token').value;
		 this.fetchJournalTypes();
		 this.fetchJournals();
	 },
 }
</script>
