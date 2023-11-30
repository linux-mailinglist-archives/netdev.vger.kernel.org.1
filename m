Return-Path: <netdev+bounces-52625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D87FF817
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63B8B20E5E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA456747;
	Thu, 30 Nov 2023 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrCJc+tq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE38D7D;
	Thu, 30 Nov 2023 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701364955; x=1732900955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vl2ux2yCeqF2Kuy7K73a7CxuAaBH8ffnqzbUR7E1kms=;
  b=QrCJc+tqn7MOms3qCLyfr8qSXcXWWeoqHjBQ81LoPsCsSPiykw5I422j
   7Kp+Qz6wn4SKJfwvTH/SVDVYhFtzxFr2dRGQivCQcyd1NM5FJw32vOlvA
   UO3R6QKtOuGnfOcmuNUoa7PkksFCTVjr88csOxK0GHqVnPcYDz3JVbs2/
   VBeqscdbtKV6/dV41TH2BHOsMg4NcPI0i2tgHgl7OIP6p0NBYy0JqTJ5E
   0VKowZ+FBCodjmvRoWJ5MlCuj+XCgseJ3TJbXKA5+HxP3aSB8MR1evcVa
   Tajeo645LXRcW2hYMnQmOvIbaYstztp5bgoTYaY1d6Jkqr2/6T+fqJNh8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="356665"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="356665"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="10845761"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 09:22:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 09:22:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 09:22:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 09:22:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhqtyqMWRKhnFauBRetPksG3AFBg7h3ZpdOj6sVjk02W+HxXjSs2/SfnSt6C/EKSg8XsDULifneQJx979Y2gSqW2ZtrE7m4yvddwRSEq/2BjWB4ZYOtkAo9PFwsAyQ6JmQcvYIUNw/X2cRSuCbODo7uXfdqTjLEIk5euNlkBQH79QtgqMJjHz01YKq0ukBgmIu+x++SIDixSTR/m0EVezYkWp1tGk9Q3t5mkftJWXwJnPZR+54T3/tRjQWQOIFsgyqfdAeZ1irB+0E9BlQSibnf5IyqP7NseJSIPD370zT+R7rtkZJEf6tjG/usFQHJ1ME+61vFqrx8U9z6fus33Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HBbhIWR0t3lqg+Vq2soLjHTTq4aq5TD+ovJJZxSe28=;
 b=bnKg2xR5Au2BdK60vTmiyjxdfl9ZGPPN+WESUHZcTAgYEer4wIyDmv5u+tXCsnhHVNwkkU/pxBIfMh25gqTCNEwzhylyGwR9qp40C2IL5kW1pjspi0liOEoo8eNftJzYqilr1ly2t2XjrITaSUsqVWPK2iWzI4JJxEimd1nMKDsIMktRsEj05GNuXyH/Ba9bq/ur+Vrvrnl+eSB9tuHuuf3ZqtmoeY0eljswjAsfStLJKnv9BxMXyO9qj0FZWGeluVfT1utgUBtDv6gPKFwA5Ge3a1p7foudhdDJ7JS9yPQIFGptIPpEddxwvOolEMbdBsnaRcmd/6IizSRK4zRO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 17:22:21 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 17:22:21 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH RFC net-next v4 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Topic: [PATCH RFC net-next v4 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Index: AQHaHftBRwD08uivs06NIi2OZOmCZbCH+lCAgAsmv4A=
Date: Thu, 30 Nov 2023 17:22:20 +0000
Message-ID: <CH3PR11MB841473286D5B95D43AA96A66E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
 <20231123105243.7992-2-michal.michalik@intel.com>
 <20231123144127.GJ6339@kernel.org>
In-Reply-To: <20231123144127.GJ6339@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|IA0PR11MB7935:EE_
x-ms-office365-filtering-correlation-id: ecdada25-13ad-45fc-3eb9-08dbf1c8e928
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Quz7OuWvS/vn+jamNDJjMvmWcJAtLibQXiHdxrOpMZ5KVyJ+1uILkwA+ImudHpip3hBmaATIsk/kIhObDaTCO6KpOVwoO6ds3f5s9CdrKYDWjKp6iPKJHp0EiEo2r00Ws3SxzBNvxr7B1PfTS9Cch7whNownpwbyvbOiGKbvZ0kWgx3JlI1SW0qNegR7ewOUEyhJQMGmgk8hZuAyFaPPk8wBjzHNbdgDjegMHvwxDZOnJKVap1I4jKVHYcOX26DO7h8jb4AIfbM25DOEaXn3VMIclPiIS65wZikZIZjg0snepziuBL4rkvpZt1Q1UV15kJW3taCFEkRUxEFs3X/nmv5VM9vnKlf5QRzjIoHQq2ctG9OkiBQr+6igfn9j0zLsunzz7R//8h+eZ6wBVxfG/dCp1pBlVShT0RZ1Mz5tUqAVyET01BKg+Td4/4rrC7RxIzyvtnYC8mhkH/EgYZnnGjdU63EtBBYwXJovYSkktY3OIjPO9MzBtEpvFoLudagnA5CgVuv2AMCYwPflXOn5V/C0XZg1BJYKzDbVBU5FykQAb0PmqJ6onseOL5p2ZlwNuuUebxP6MfwTOXeI1SOXn7z+cxLyK6KoDeGYZIdgSnCH0BXHuMupDo9Piply/ne3lLQnbxK+XFuPzqeRYNzNI0AEIZZayvWb46I3222nSuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82960400001)(55016003)(122000001)(38100700002)(83380400001)(2906002)(5660300002)(30864003)(4326008)(86362001)(8676002)(8936002)(52536014)(66446008)(76116006)(316002)(64756008)(66946007)(6916009)(66556008)(54906003)(66476007)(7416002)(7696005)(71200400001)(9686003)(6506007)(478600001)(41300700001)(53546011)(33656002)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SkOT9GaPqYfLkbEngtf7fPloAHg+Ufsy5bMe+wHAH5nYq5y5KW45y8rS+cv4?=
 =?us-ascii?Q?HayqyHG72FUQvgNae9oBXtOW1UYMhIprh5P/wETXgtaYHnyn9dDo3wI8YppM?=
 =?us-ascii?Q?9tIZui1jALcwmclGCi4Pd4Fq+/H7LsyEFZapRJN5Nx8nK9VwthTPAB07bgeK?=
 =?us-ascii?Q?WwFal7IMTO5RMq/E0rGB7pnILkVWd7D2b3G59Y890hc9XXMlWy8EXPmBLMK8?=
 =?us-ascii?Q?cAFtFkf3LAz6Pa4JWhXV+mTvrD35aX5GSOUp3NL/IvhPdv60aXJRZi47VS9F?=
 =?us-ascii?Q?Dk53PJ2x5IHbIVnOYu5v3qUeHj9XSsHcM2PihBFJgpP2kpedjXsK9dBZgWe5?=
 =?us-ascii?Q?pow7sMCkuC9yqwMxTkg7Ppn7+22ZY87U2z4uPHo67W375O4FLa+KoX9+ghai?=
 =?us-ascii?Q?eLySbZeJrbOiDzXfYqmTOCRd/JjTR33WygpHsHO1EBz6fpQuUUFcC7+AA6zM?=
 =?us-ascii?Q?PMTZ089BzRpgvasVFk9EP/t5hw3byJz6Jcuegqb3MZVf0N9ToBvEZMg/Zvsj?=
 =?us-ascii?Q?MTu1uqkHE0WCxmak2yOGWIgFzKgRMxJtVcDVJpNMTBjmW93GQnx7f8S+2oT9?=
 =?us-ascii?Q?LXWcoxnAf+Yh1C7d34wjrupLG7vKVLZ4WUpg6CpdmRrBNDDbw8swxqJHt6eB?=
 =?us-ascii?Q?m+AmIUqdtnxZ7hbU48TjhFIkAXfdqB4S6Y3XW0wH2Ae7XTVOuFYlp5dVDSI/?=
 =?us-ascii?Q?w8XwF15QknMCtoRQB2ENC4A0lQOI2G/t38r/GjEjcyo63CWbyLsiy1PHH3zz?=
 =?us-ascii?Q?lTs9KlA6Fv/Pbo7Kxihz7dBZCCgfyrvDotV/das6ckd16NDIMTqd0KCHgu2E?=
 =?us-ascii?Q?udWWIg+IXaRZdKQWjYGW+4n9bD+nPHntrNodGnUY8bga+8f3PDTdWU8Z6PiE?=
 =?us-ascii?Q?IAZNt7uMX7VeGUjq4uCnoXqsQJGimH6hMNmLjM0ZYriCTHJi+XBmry18ehfj?=
 =?us-ascii?Q?QODDaMgiIl3d12P/cUYtLOsI+8B5MAzI4P6pFV+ugQaVKcgZgR3NWnBkyoxW?=
 =?us-ascii?Q?ZCcI8VNXl0a2zaVe1smYxiwCIQPle7Jcv21yzRrynmjKcikCPGvGvxnoZLwH?=
 =?us-ascii?Q?HlcINwU/WW/f5Pk2gTITaIt9xiHX7bE44TZD4JWmPNRR0ZFsivNG1TKmU8on?=
 =?us-ascii?Q?zNLf6bF9Cw6mkAk78CBxsH/Ex7rB0VL40IArtlNKNBX2b96aRz55yM0bO9fY?=
 =?us-ascii?Q?HyuytwPpbzZzvwm3rFy2dMzTAQmTYAh1r50jQcWzDNU0kwR/lKXsjNWX+y9n?=
 =?us-ascii?Q?WoY3n3iN6BS5dBcRCkGtUpKBvw1X91eExUnTx9HStZYFZVB0GuQAvpE+tVzK?=
 =?us-ascii?Q?kPhJqxqdYNGOtAVmKjJG1Aw7FLgiFl9ktDFTjv4vGmnzpBsaGN1et9QiG3Uf?=
 =?us-ascii?Q?P9ZN6CefxA9gWKEnK+F+vi9eOU3P0EBcROGDajpYbyOIy8vvuMfjBsxoePGy?=
 =?us-ascii?Q?C9ANg3n1kO4p28j1q3kZm2+l/dxpVlAZmBcmb3FCN6k7R/iV1SQu7qfL4vYM?=
 =?us-ascii?Q?XjcHqyf3eGpZOjXFH0XwLsQC57Ch3+f0v2Ve8WZz8DKI65iIBYkVchvltix9?=
 =?us-ascii?Q?kDQ9VFyHGctVMk5FgdsEab8PtjQ01u4jY9OkgeDf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdada25-13ad-45fc-3eb9-08dbf1c8e928
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 17:22:21.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37cMeYFJSlU7ttZlRv3Y63gwHVQg6iEpiAoV3KjDbNeKypGR9P9L7niEjOjXuE6FZvj7xbSzLESYl9IUkXpBFOGTwXMk3nJGlu5xbYmCkSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
X-OriginatorOrg: intel.com

On 23 November 2023 3:41 PM CET, Simon Horman wrote:
>=20
> On Thu, Nov 23, 2023 at 05:52:42AM -0500, Michal Michalik wrote:
>> DPLL subsystem integration tests require a module which mimics the
>> behavior of real driver which supports DPLL hardware. To fully test the
>> subsystem the netdevsim is amended with DPLL implementation.
>>=20
>> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>=20
> ...
>=20
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index b4d3b9cde8bd..76da4e8aa9af 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -342,6 +342,17 @@ static int nsim_dev_debugfs_init(struct nsim_dev *n=
sim_dev)
>>  	debugfs_create_file("max_vfs", 0600, nsim_dev->ddir,
>>  			    nsim_dev, &nsim_dev_max_vfs_fops);
>> =20
>> +	debugfs_create_u64("dpll_clock_id", 0600,
>> +			   nsim_dev->ddir, &nsim_dev->dpll.dpll_e_pd.clock_id);
>> +	debugfs_create_u32("dpll_e_status", 0600, nsim_dev->ddir,
>> +			   &nsim_dev->dpll.dpll_e_pd.status);
>> +	debugfs_create_u32("dpll_p_status", 0600, nsim_dev->ddir,
>> +			   &nsim_dev->dpll.dpll_p_pd.status);
>> +	debugfs_create_u32("dpll_e_temp", 0600, nsim_dev->ddir,
>> +			   &nsim_dev->dpll.dpll_e_pd.temperature);
>> +	debugfs_create_u32("dpll_p_temp", 0600, nsim_dev->ddir,
>> +			   &nsim_dev->dpll.dpll_p_pd.temperature);
>> +
>>  	nsim_dev->nodes_ddir =3D debugfs_create_dir("rate_nodes", nsim_dev->dd=
ir);
>>  	if (IS_ERR(nsim_dev->nodes_ddir)) {
>>  		err =3D PTR_ERR(nsim_dev->nodes_ddir);
>> @@ -1601,14 +1612,21 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus=
_dev)
>>  	if (err)
>>  		goto err_psample_exit;
>> =20
>> -	err =3D nsim_dev_port_add_all(nsim_dev, nsim_bus_dev->port_count);
>> +	err =3D nsim_dpll_init_owner(&nsim_dev->dpll, nsim_bus_dev->port_count=
);
>>  	if (err)
>>  		goto err_hwstats_exit;
>> =20
>> +	err =3D nsim_dev_port_add_all(nsim_dev, nsim_bus_dev->port_count);
>> +	if (err)
>> +		goto err_teardown_dpll;
>> +
>>  	nsim_dev->esw_mode =3D DEVLINK_ESWITCH_MODE_LEGACY;
>>  	devl_unlock(devlink);
>> +
>>  	return 0;
>> =20
>> +err_teardown_dpll:
>> +	nsim_dpll_free_owner(&nsim_dev->dpll);
>>  err_hwstats_exit:
>>  	nsim_dev_hwstats_exit(nsim_dev);
>>  err_psample_exit:
>> @@ -1656,6 +1674,7 @@ static void nsim_dev_reload_destroy(struct nsim_de=
v *nsim_dev)
>>  	}
>> =20
>>  	nsim_dev_port_del_all(nsim_dev);
>> +	nsim_dpll_free_owner(&nsim_dev->dpll);
>>  	nsim_dev_hwstats_exit(nsim_dev);
>>  	nsim_dev_psample_exit(nsim_dev);
>>  	nsim_dev_health_exit(nsim_dev);
>> diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c
>> new file mode 100644
>> index 000000000000..26a8b0f3be16
>> --- /dev/null
>> +++ b/drivers/net/netdevsim/dpll.c
>> @@ -0,0 +1,489 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2023, Intel Corporation.
>> + * Author: Michal Michalik <michal.michalik@intel.com>
>> + */
>> +#include "netdevsim.h"
>> +
>> +#define EEC_DPLL_DEV 0
>> +#define EEC_DPLL_TEMPERATURE 20
>> +#define PPS_DPLL_DEV 1
>> +#define PPS_DPLL_TEMPERATURE 30
>> +
>> +#define PIN_GNSS 0
>> +#define PIN_GNSS_CAPABILITIES DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
>> +#define PIN_GNSS_PRIORITY 5
>> +
>> +#define PIN_PPS 1
>> +#define PIN_PPS_CAPABILITIES                          \
>> +	(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE | \
>> +	 DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |  \
>> +	 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
>> +#define PIN_PPS_PRIORITY 6
>> +
>> +#define PIN_RCLK 2
>> +#define PIN_RCLK_CAPABILITIES                        \
>> +	(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE | \
>> +	 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
>> +#define PIN_RCLK_PRIORITY 7
>> +
>> +#define EEC_PINS_NUMBER 3
>> +#define PPS_PINS_NUMBER 2
>> +
>> +static int nsim_fill_pin_properties(struct dpll_pin_properties *pp,
>> +				    const char *label, enum dpll_pin_type type,
>> +				    unsigned long caps, u32 freq_supp_num,
>> +				    u64 fmin, u64 fmax)
>> +{
>> +	struct dpll_pin_frequency *freq_supp;
>> +
>> +	freq_supp =3D kzalloc(sizeof(*freq_supp), GFP_KERNEL);
>> +	if (!freq_supp)
>> +		goto freq_supp;
>> +	freq_supp->min =3D fmin;
>> +	freq_supp->max =3D fmax;
>> +
>> +	pp->board_label =3D kasprintf(GFP_KERNEL, "%s_brd", label);
>> +	if (!pp->board_label)
>> +		goto board_label;
>> +	pp->panel_label =3D kasprintf(GFP_KERNEL, "%s_pnl", label);
>> +	if (!pp->panel_label)
>> +		goto panel_label;
>> +	pp->package_label =3D kasprintf(GFP_KERNEL, "%s_pcg", label);
>> +	if (!pp->package_label)
>> +		goto package_label;
>> +	pp->freq_supported_num =3D freq_supp_num;
>> +	pp->freq_supported =3D freq_supp;
>> +	pp->capabilities =3D caps;
>> +	pp->type =3D type;
>> +
>> +	return 0;
>> +
>> +package_label:
>> +	kfree(pp->panel_label);
>> +panel_label:
>> +	kfree(pp->board_label);
>> +board_label:
>> +	kfree(freq_supp);
>> +freq_supp:
>> +	return -ENOMEM;
>> +}
>> +
>> +static void nsim_fill_pin_pd(struct nsim_pin_priv_data *pd, u64 frequen=
cy,
>> +			     u32 prio, enum dpll_pin_direction direction)
>> +{
>> +	pd->state_dpll =3D DPLL_PIN_STATE_DISCONNECTED;
>> +	pd->state_pin =3D DPLL_PIN_STATE_DISCONNECTED;
>> +	pd->frequency =3D frequency;
>> +	pd->direction =3D direction;
>> +	pd->prio =3D prio;
>> +}
>> +
>> +static int nsim_dds_ops_mode_get(const struct dpll_device *dpll,
>> +				 void *dpll_priv, enum dpll_mode *mode,
>> +				 struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_dpll_priv_data *pd =3D dpll_priv;
>> +	*mode =3D pd->mode;
>> +	return 0;
>> +};
>> +
>> +static bool nsim_dds_ops_mode_supported(const struct dpll_device *dpll,
>> +					void *dpll_priv,
>> +					const enum dpll_mode mode,
>> +					struct netlink_ext_ack *extack)
>> +{
>> +	return true;
>> +};
>> +
>> +static int nsim_dds_ops_lock_status_get(const struct dpll_device *dpll,
>> +					void *dpll_priv,
>> +					enum dpll_lock_status *status,
>> +					struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_dpll_priv_data *pd =3D dpll_priv;
>> +
>> +	*status =3D pd->status;
>> +	return 0;
>> +};
>> +
>> +static int nsim_dds_ops_temp_get(const struct dpll_device *dpll,
>> +				 void *dpll_priv, s32 *temp,
>> +				 struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_dpll_priv_data *pd =3D dpll_priv;
>> +
>> +	*temp =3D pd->temperature;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_frequency_set(const struct dpll_pin *pin, void *pin=
_priv,
>> +				  const struct dpll_device *dpll,
>> +				  void *dpll_priv, const u64 frequency,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	pd->frequency =3D frequency;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_frequency_get(const struct dpll_pin *pin, void *pin=
_priv,
>> +				  const struct dpll_device *dpll,
>> +				  void *dpll_priv, u64 *frequency,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	*frequency =3D pd->frequency;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_direction_set(const struct dpll_pin *pin, void *pin=
_priv,
>> +				  const struct dpll_device *dpll,
>> +				  void *dpll_priv,
>> +				  const enum dpll_pin_direction direction,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	pd->direction =3D direction;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_direction_get(const struct dpll_pin *pin, void *pin=
_priv,
>> +				  const struct dpll_device *dpll,
>> +				  void *dpll_priv,
>> +				  enum dpll_pin_direction *direction,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	*direction =3D pd->direction;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_state_on_pin_get(const struct dpll_pin *pin, void *=
pin_priv,
>> +				     const struct dpll_pin *parent_pin,
>> +				     void *parent_priv,
>> +				     enum dpll_pin_state *state,
>> +				     struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	*state =3D pd->state_pin;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_state_on_dpll_get(const struct dpll_pin *pin,
>> +				      void *pin_priv,
>> +				      const struct dpll_device *dpll,
>> +				      void *dpll_priv,
>> +				      enum dpll_pin_state *state,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	*state =3D pd->state_dpll;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_state_on_pin_set(const struct dpll_pin *pin, void *=
pin_priv,
>> +				     const struct dpll_pin *parent_pin,
>> +				     void *parent_priv,
>> +				     const enum dpll_pin_state state,
>> +				     struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	pd->state_pin =3D state;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_state_on_dpll_set(const struct dpll_pin *pin,
>> +				      void *pin_priv,
>> +				      const struct dpll_device *dpll,
>> +				      void *dpll_priv,
>> +				      const enum dpll_pin_state state,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	pd->state_dpll =3D state;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_prio_get(const struct dpll_pin *pin, void *pin_priv=
,
>> +			     const struct dpll_device *dpll, void *dpll_priv,
>> +			     u32 *prio, struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	*prio =3D pd->prio;
>> +	return 0;
>> +};
>> +
>> +static int nsim_pin_prio_set(const struct dpll_pin *pin, void *pin_priv=
,
>> +			     const struct dpll_device *dpll, void *dpll_priv,
>> +			     const u32 prio, struct netlink_ext_ack *extack)
>> +{
>> +	struct nsim_pin_priv_data *pd =3D pin_priv;
>> +
>> +	pd->prio =3D prio;
>> +	return 0;
>> +};
>> +
>> +static void nsim_free_pin_properties(struct dpll_pin_properties *pp)
>> +{
>> +	kfree(pp->board_label);
>> +	kfree(pp->panel_label);
>> +	kfree(pp->package_label);
>> +	kfree(pp->freq_supported);
>> +}
>> +
>> +static struct dpll_device_ops nsim_dds_ops =3D {
>> +	.mode_get =3D nsim_dds_ops_mode_get,
>> +	.mode_supported =3D nsim_dds_ops_mode_supported,
>> +	.lock_status_get =3D nsim_dds_ops_lock_status_get,
>> +	.temp_get =3D nsim_dds_ops_temp_get,
>> +};
>> +
>> +static struct dpll_pin_ops nsim_pin_ops =3D {
>> +	.frequency_set =3D nsim_pin_frequency_set,
>> +	.frequency_get =3D nsim_pin_frequency_get,
>> +	.direction_set =3D nsim_pin_direction_set,
>> +	.direction_get =3D nsim_pin_direction_get,
>> +	.state_on_pin_get =3D nsim_pin_state_on_pin_get,
>> +	.state_on_dpll_get =3D nsim_pin_state_on_dpll_get,
>> +	.state_on_pin_set =3D nsim_pin_state_on_pin_set,
>> +	.state_on_dpll_set =3D nsim_pin_state_on_dpll_set,
>> +	.prio_get =3D nsim_pin_prio_get,
>> +	.prio_set =3D nsim_pin_prio_set,
>> +};
>> +
>> +int nsim_dpll_init_owner(struct nsim_dpll *dpll, unsigned int ports_cou=
nt)
>> +{
>> +	u64 clock_id;
>> +	int err;
>> +
>> +	get_random_bytes(&clock_id, sizeof(clock_id));
>> +
>> +	/* Create EEC DPLL */
>> +	dpll->dpll_e =3D dpll_device_get(clock_id, EEC_DPLL_DEV, THIS_MODULE);
>> +	if (IS_ERR(dpll->dpll_e))
>> +		return -EFAULT;
>> +
>> +	dpll->dpll_e_pd.temperature =3D EEC_DPLL_TEMPERATURE;
>> +	dpll->dpll_e_pd.mode =3D DPLL_MODE_AUTOMATIC;
>> +	dpll->dpll_e_pd.clock_id =3D clock_id;
>> +	dpll->dpll_e_pd.status =3D DPLL_LOCK_STATUS_UNLOCKED;
>> +
>> +	err =3D dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &nsim_dds_op=
s,
>> +				   &dpll->dpll_e_pd);
>> +	if (err)
>> +		goto e_reg;
>> +
>> +	/* Create PPS DPLL */
>> +	dpll->dpll_p =3D dpll_device_get(clock_id, PPS_DPLL_DEV, THIS_MODULE);
>> +	if (IS_ERR(dpll->dpll_p))
>> +		goto dpll_p;
>> +
>> +	dpll->dpll_p_pd.temperature =3D PPS_DPLL_TEMPERATURE;
>> +	dpll->dpll_p_pd.mode =3D DPLL_MODE_MANUAL;
>> +	dpll->dpll_p_pd.clock_id =3D clock_id;
>> +	dpll->dpll_p_pd.status =3D DPLL_LOCK_STATUS_UNLOCKED;
>> +
>> +	err =3D dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &nsim_dds_op=
s,
>> +				   &dpll->dpll_p_pd);
>> +	if (err)
>> +		goto p_reg;
>> +
>> +	/* Create first pin (GNSS) */
>> +	err =3D nsim_fill_pin_properties(&dpll->pp_gnss, "GNSS",
>> +				       DPLL_PIN_TYPE_GNSS,
>> +				       PIN_GNSS_CAPABILITIES, 1,
>> +				       DPLL_PIN_FREQUENCY_1_HZ,
>> +				       DPLL_PIN_FREQUENCY_1_HZ);
>> +	if (err)
>> +		goto pp_gnss;
>> +	dpll->p_gnss =3D
>> +		dpll_pin_get(clock_id, PIN_GNSS, THIS_MODULE, &dpll->pp_gnss);
>> +	if (IS_ERR(dpll->p_gnss))
>> +		goto p_gnss;
>=20
> Hi Michal,
>=20
> I think that err needs to be set to something inside the if condition
> above.
>=20

Hi Simon,

You have such a good eye, thanks - fixing that. I have also fixed another p=
lace where I made the
very same mistake.

>> +	nsim_fill_pin_pd(&dpll->p_gnss_pd, DPLL_PIN_FREQUENCY_1_HZ,
>> +			 PIN_GNSS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>> +	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>> +				&dpll->p_gnss_pd);
>> +	if (err)
>> +		goto e_gnss_reg;
>> +
>> +	/* Create second pin (PPS) */
>> +	err =3D nsim_fill_pin_properties(&dpll->pp_pps, "PPS", DPLL_PIN_TYPE_E=
XT,
>> +				       PIN_PPS_CAPABILITIES, 1,
>> +				       DPLL_PIN_FREQUENCY_1_HZ,
>> +				       DPLL_PIN_FREQUENCY_1_HZ);
>> +	if (err)
>> +		goto pp_pps;
>> +	dpll->p_pps =3D
>> +		dpll_pin_get(clock_id, PIN_PPS, THIS_MODULE, &dpll->pp_pps);
>> +	if (IS_ERR(dpll->p_pps)) {
>> +		err =3D -EFAULT;
>> +		goto p_pps;
>> +	}
>> +	nsim_fill_pin_pd(&dpll->p_pps_pd, DPLL_PIN_FREQUENCY_1_HZ,
>> +			 PIN_PPS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>> +	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>> +				&dpll->p_pps_pd);
>> +	if (err)
>> +		goto e_pps_reg;
>> +	err =3D dpll_pin_register(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
>> +				&dpll->p_pps_pd);
>> +	if (err)
>> +		goto p_pps_reg;
>> +
>> +	dpll->pp_rclk =3D
>> +		kcalloc(ports_count, sizeof(*dpll->pp_rclk), GFP_KERNEL);
>> +	dpll->p_rclk =3D kcalloc(ports_count, sizeof(*dpll->p_rclk), GFP_KERNE=
L);
>> +	dpll->p_rclk_pd =3D
>> +		kcalloc(ports_count, sizeof(*dpll->p_rclk_pd), GFP_KERNEL);
>> +
>> +	return 0;
>> +
>> +p_pps_reg:
>> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>> +			    &dpll->p_pps_pd);
>> +e_pps_reg:
>> +	dpll_pin_put(dpll->p_pps);
>> +p_pps:
>> +	nsim_free_pin_properties(&dpll->pp_pps);
>> +pp_pps:
>> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>> +			    &dpll->p_gnss_pd);
>> +e_gnss_reg:
>> +	dpll_pin_put(dpll->p_gnss);
>> +p_gnss:
>> +	nsim_free_pin_properties(&dpll->pp_gnss);
>> +pp_gnss:
>> +	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
>> +p_reg:
>> +	dpll_device_put(dpll->dpll_p);
>> +dpll_p:
>> +	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
>> +e_reg:
>> +	dpll_device_put(dpll->dpll_e);
>> +	return err;
>> +}
>=20
> ...
>

