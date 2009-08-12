var Log = {
    elem: false,
    write: function(text){
        if (!this.elem) 
            this.elem = document.getElementById('log');
        this.elem.innerHTML = text;
        this.elem.style.left = (500 - this.elem.offsetWidth / 2) + 'px';
    }
};

function addEvent(obj, type, fn) {
    if (obj.addEventListener) obj.addEventListener(type, fn, false);
    else obj.attachEvent('on' + type, fn);
};


function init() {
	var totalInitialLoan = (89 + 5333.10 + 393.44 + 299);
    //init data
    var jsonpie = {
      'id': 'root',
      'name': 'Debt',
      'data': {
          '$type': 'none'
      },
      'children':[
        {
            'id':'pie1',
            'name': 'Paint',
            'data': {
                '$aw': 89/totalInitialLoan,
                '$color': '#966'
            },
            'children': []
        },
        {
            'id':'pie2',
            'name': 'Vending Machine',
            'data': {
                '$aw': 5333.10/totalInitialLoan,
                '$color': '#933'
            },
            'children': []
        },
        {
            'id':'pie3',
            'name': 'Espresso Machine',
            'data': {
                '$aw': 393.44/totalInitialLoan,
                '$color': '#944'
            },
            'children': []
        },
        {
            'id':'pie4',
            'name': 'Initial Inventory',
            'data': {
                '$aw': 299/totalInitialLoan,
                '$color': '#955'
            },
            'children': []
        },
      ]
    };

	var amountPaidBack = 1;
    var jsonpie2 = {
      'id': 'root_2',
      'name': 'Debt Payback',
      'data': {
          '$type': 'none'
      },
      'children':[
        {
            'id':'pie2_1',
            'name': 'Paid',
            'data': {
                '$aw': amountPaidBack/totalInitialLoan,
                '$color': '#f44'
            },
            'children': []
        },
        {
            'id':'pie2_2',
            'name': 'Owed',
            'data': {
                '$aw': (totalInitialLoan-amountPaidBack)/totalInitialLoan,
                '$color': '#311'
            },
            'children': []
        },
      ]
    };

	var monthlyScale = 0.5;
    var jsonpie3 = {
      'id': 'root1',
      'name': 'Monthly Income',
      'data': {
          '$type': 'none',
          '$width': 80,
          '$height':20
      },
      'children':[
        {
            'id':'August_2009',
            'name': 'August',
            'data': {
                '$color': '#5f5',
                '$height': (0 * monthlyScale)
				//(100 * monthlyScale)
            },
            'children': [
				{
					'id':'h1_1',
					'name': 'Debt',
					'data': {
					'$color': '#f44',
					'$height':(0 * monthlyScale)
					//'$height':(75 * monthlyScale)
				},
				'children': []
				},
				{
					'id':'h1_2',
					'name': 'Inventory',
					'data': {
					'$color': '#555',
					'$height':(0 * monthlyScale)
					//'$height':(20 * monthlyScale)
				},
				'children': []
				},
				{
					'id':'h1_3',
					'name': 'LUCI',
					'data': {
					'$color': '#55f',
					'$height':(0 * monthlyScale)
					//'$height':(5 * monthlyScale)
				},
				'children': []
				},
			]
        },
//        {
//            'id':'September_2009',
//            'name': 'September',
//            'data': {
//                '$color': '#5f5',
//                '$height':(100 * monthlyScale)
//            },
//            'children': [
//				{
//					'id':'h2_1',
//					'name': 'Debt',
//					'data': {
//					'$color': '#f44',
//					'$height':(75 * monthlyScale)
//				},
//				'children': []
//				},
//				{
//					'id':'h2_2',
//					'name': 'Inventory',
//					'data': {
//					'$color': '#555',
//					'$height':(20 * monthlyScale)
//				},
//				'children': []
//				},
//				{
//					'id':'h2_3',
//					'name': 'LUCI',
//					'data': {
//					'$color': '#55f',
//					'$height':(5 * monthlyScale)
//				},
//				'children': []
//				},
//			]
//        },
      ]
    };
    //end
    
    var infovis = document.getElementById('infovis');
    var w = infovis.offsetWidth, h = infovis.offsetHeight;
    
    //create some containers for the visualizations
    var container = document.createElement('div');
    container.id = "infovis1";
    var style = container.style;
    style.left = "0px";
    style.top = "0px";
    style.width = Math.floor(w / 2) + "px";
    style.height = Math.floor(h / 2) + "px";
    style.position = 'absolute';
    infovis.appendChild(container);
    
    container = document.createElement('div');
    container.id = "infovis2";
    var style = container.style;
    style.left = Math.floor(w / 2) + "px";
    style.top = "0px";
    style.width = style.left;
    style.height = Math.floor(h / 2) + "px";
    style.position = 'absolute';
    infovis.appendChild(container);

    container = document.createElement('div');
    container.id = "infovis3";
    var style = container.style;
    style.left = "0px";
    style.top = Math.floor(h / 2) + "px";
    style.width = w + "px";
    style.height = Math.floor(h / 2) + "px";
    style.position = 'absolute';
    infovis.appendChild(container);
    
    //init canvas
    //Create new canvas instances.
    var canvas1 = new Canvas('mycanvas1', {
        'injectInto': 'infovis1',
        'width': w/2,
        'height': h/2
    });

    var canvas2 = new Canvas('mycanvas2', {
        'injectInto': 'infovis2',
        'width': w/2,
        'height': h/2
    });

    var canvas3 = new Canvas('mycanvas3', {
        'injectInto': 'infovis3',
        'width': w,
        'height': h/2,
        'backgroundColor': '#1a1a1a'
    });
    //end

    //init nodetypes
    //Here we implement custom node rendering types for the RGraph
    //Using this feature requires some javascript and canvas experience.
    RGraph.Plot.NodeTypes.implement({
        //This node type is used for plotting the upper-left pie chart
        'nodepie': function(node, canvas) {
            var span = node.angleSpan, begin = span.begin, end = span.end;
            var polarNode = node.pos.getp(true);
            var polar = new Polar(polarNode.rho, begin);
            var p1coord = polar.getc(true);
            polar.theta = end;
            var p2coord = polar.getc(true);

            var ctx = canvas.getCtx();
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(p1coord.x, p1coord.y);
            ctx.moveTo(0, 0);
            ctx.lineTo(p2coord.x, p2coord.y);
            ctx.moveTo(0, 0);
            ctx.arc(0, 0, polarNode.rho, begin, end, false);
            ctx.fill();
        },
        //This node type is used for plotting the upper-right pie chart
        'shortnodepie': function(node, canvas) {
            var ldist = this.config.levelDistance;
            var span = node.angleSpan, begin = span.begin, end = span.end;
            var polarNode = node.pos.getp(true);
            
            var polar = new Polar(polarNode.rho, begin);
            var p1coord = polar.getc(true);
            
            polar.theta = end;
            var p2coord = polar.getc(true);
            
            polar.rho += ldist;
            var p3coord = polar.getc(true);
            
            polar.theta = begin;
            var p4coord = polar.getc(true);
            
            
            var ctx = canvas.getCtx();
            ctx.beginPath();
            ctx.moveTo(p1coord.x, p1coord.y);
            ctx.lineTo(p4coord.x, p4coord.y);
            ctx.moveTo(0, 0);
            ctx.arc(0, 0, polarNode.rho, begin, end, false);

            ctx.moveTo(p2coord.x, p2coord.y);
            ctx.lineTo(p3coord.x, p3coord.y);
            ctx.moveTo(0, 0);
            ctx.arc(0, 0, polarNode.rho + ldist, end, begin, true);
            
            ctx.fill();
        }
    });
    //end
    
    //init rgraph
    //This RGraph is used to plot the upper-left pie chart.
    //It has custom *pie-chart-nodes*.
    var rgraph = new RGraph(canvas1, {
        //Add node/edge styles and set
        //overridable=true if you want your
        //styles to be individually overriden
        Node: {
            'overridable': true,
             'type': 'nodepie'
        },
        Edge: {
            'overridable': true
        },
        //Parent-children distance
        levelDistance: 135,
        
        //Add styles to node labels on label creation
        onCreateLabel: function(domElement, node){
            domElement.innerHTML = node.name;
            var style = domElement.style;
            style.fontSize = "0.8em";
            style.color = "#fff";
        },
        //Add some offset to the labels when placed.
        onPlaceLabel: function(domElement, node){
            var style = domElement.style;
            var left = parseInt(style.left);
            var w = domElement.offsetWidth;
            style.left = (left - w / 2) + 'px';
        }
    });
    //load graph.
    rgraph.loadJSON(jsonpie);
    rgraph.refresh();
    //end
    //init rgraph2
    //This RGraph instance is used for plotting the upper-right
    //pie chart.
    var rgraph2 = new RGraph(canvas2, {
        //Add node/edge styles and set
        //overridable=true if you want your
        //styles to be individually overriden
        Node: {
            'overridable': true,
             'type':'nodepie'
        },
        Edge: {
            'overridable': true
        },
        //Parent-children distance
        levelDistance: 135,
        
        //Add styles to node labels on label creation
        onCreateLabel: function(domElement, node){
            domElement.innerHTML = node.name;
            var style = domElement.style;
            style.fontSize = "0.8em";
            style.color = "#fff";
        },
        
        onPlaceLabel: function(domElement, node){
            var style = domElement.style;
            var left = parseInt(style.left);
            var w = domElement.offsetWidth;
            style.left = (left - w / 2) + 'px';
        }
    });
    //load graph.
    rgraph2.loadJSON(jsonpie2);
    rgraph2.refresh();
    //end
    //init st
    //This Spacetree nodes' heights are overriden individually
    //so that it serves as a bar chart.
    var st = new ST(canvas3, {
        //set orientarion
        orientation:'bottom',
        //set duration for the animation
        duration: 800,
        //set parent-children distance
        levelDistance: 20,
        //set node and edge styles
        //set overridable=true for styling individual
        //nodes or edges
        Node: {
            overridable: true,
            width: 30,
            type: 'rectangle',
            color: '#aaa',
            align: 'right'
        },
        
        Edge: {
            type: 'bezier',
            color: '#444'
        },
        
        //This method is called on DOM label creation.
        //Use this method to add styles to
        //your node label.
        onCreateLabel: function(label, node){
            label.id = node.id;            
            label.innerHTML = node.name;
            //set label styles
            var style = label.style;
            style.fontSize = '0.7em';
            style.textAlign= 'center';
            style.paddingTop = '3px';
            //style.height = node.data.$height + 'px';            
            style.height = 0;

            if(node.id == st.root) {
                style.color = '#eee';
                style.width = node.data.$width + 'px';
            } else {
                style.color = '#fff';
                style.width = 30 + 'px';
            }
        }
    });
    //load json data
    st.loadJSON(jsonpie3);
    //compute node positions and layout
    st.compute();
    //emulate a click on the root node and
    //add an offset position to the tree
    st.onClick(st.root, {
        Move: {
            offsetY: -110
        }
    });
    //end
}

