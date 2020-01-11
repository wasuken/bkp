<template>
	<div>
		<div class="jumbotron d-inline-flex border border-primary" style="width: 50%;heigth: 60%;"
			 v-for="jtKey in Object.keys(journalByType)">
			<ul>
				<h3>{{jtKey}}</h3>
				<li v-for="journal in journalByType[jtKey]">
					<small class="text-muted">{{journal.created_at}}</small>
					{{journal.name}}({{journal.jtname}})
					->
					{{journal.amount}}
				</li>
			</ul>
		</div>
	</div>
</template>
<script>
 export default {
	 data: function(){
		 return{
			 token: "",
			 journalByType: {},
		 }
	 },
	 methods: {
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
					   if(!newm[j.jtname]){
						   newm[j.jtname] = [];
					   }
					   let ary = newm[j.jtname];
					   ary = ary.concat(j);
					   newm[j.jtname] = ary;
					   return newm;
				   }, {});
				   console.log(this.journalByType);
			   });
		 }
	 },
	 mounted: function(){
		 this.token = document.getElementById('token').value;
		 this.fetchJournals();
	 },
 }
</script>
