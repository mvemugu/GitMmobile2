fetch = function(){
            var a= {};
            a = new SObjectModel.Account();
            a.retrieve({where: {Id: {eq: "0011a000002nC8X"}}}, function(err, records){
                if(err) alert(err.message);
                else {
                    records.forEach(function(record) {
                        console.log(JSON.stringify(record));
                    });
                }
            });
        };
