Return-Path: <netdev+bounces-305409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o29bJDzZTGpTqwEAu9opvQ
	(envelope-from <netdev+bounces-305409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:47:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DB171A992
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:47:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OyZMd14T;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305409-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305409-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164A5300902C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB803ED5C7;
	Tue,  7 Jul 2026 10:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF13ED3DC;
	Tue,  7 Jul 2026 10:42:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420944; cv=fail; b=m3hCAxRRrtj5v8k1fcYhEpuRFmFP4dtPTga0a0+XERCdI1L+tt1kHayR5fxFQ+F1b4aUZ/TrORmKexdz3a9mUJTPr1T9hIhvBIkR3bc4m+ot2X/g5kvvR0KjBTS8+/lCSo1H93HnKkUXo/Nre3xYzoy6tmrUcgyE7s6eRtCfouA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420944; c=relaxed/simple;
	bh=ha3Ma3+dhCgSFrSEwIN+ND7uom5QLUpvJSWVZLdPLjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPOdTOa8iIOdu4BHyBsv8O3n+Z8v7IiUhFeeaLLr2uvRz0eny1tyVsa03cA4z8GXb279nDgtXEiSxhKcQgJn6tWMfbuI/OytOi5H3KLr1kuJOmRR0dF9vj8O/ailD0tBJ3HC5nGebdw1y3FOCy0M4MzyV2tPu1DeYpnYai6XDio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyZMd14T; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783420943; x=1814956943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ha3Ma3+dhCgSFrSEwIN+ND7uom5QLUpvJSWVZLdPLjw=;
  b=OyZMd14TpsYzRjP5kqsD8FKNPnQPcpLspaOT04hqYenPc+kn8/r/GyBR
   8mkjbKGKfWSv5Lhsh4TQX1OFRu86mnuIvyMd9SF0jleCv0Ssj24XFPsIZ
   emElUohNsuZnLuZo07uyO/TdCxn2NieJwxz57+nS7s3dvVyTer17oblOh
   HGKzIjWVeXlgqg+V6xP5ziH9DjlVASSKOuoARQ0t2kiqnjpkvZEirtqD7
   6ZV/bf/RbsLjy68TXbWWuqKY6g87HYadlgIQVqBLwj5sJAGyCq0lcYWfA
   /5madYCVKn6zgQYnuHasTHTpHSkHWO5R/3tIqLmHotlhV4czkBIYJQD4P
   g==;
X-CSE-ConnectionGUID: l7QVmJOtSqaU3HXwlt2oig==
X-CSE-MsgGUID: kky/S+dvRna2BH4vWylpfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="106863617"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="106863617"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 03:42:22 -0700
X-CSE-ConnectionGUID: AJCgyDlXTnKraD4xGu2GKw==
X-CSE-MsgGUID: +VvFGaliStelYZxQ2Mr4Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254619672"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 03:42:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 03:42:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 03:42:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 03:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmFWuzqNEPBIYrDtasMH8GYQLBf1ENTbVLlpg0BnoqXvR4k800AMQ5sm0BYH7wUs/QmEPVN8SwkOr5v+9xrsLjOGDW+09jZn2mZkAGbFn2THBLdbeXS8I0QxqOePOU/YwXagPzsQPdX1KvMIRr6n9q85RuNBqlVGeqeFktiYn3I4vu/NGX/CpfSU4sJHFE3lppxgJOS5Ob1pfZEqeRaGFTV+gcjglFNmXs89YBXQWNyIefWmwTwlQ6AE56HbJLrtfclL9qwCSXkMtkqZOUk29UIVSwuNbs10eBHr1tGe+3KUXxLkjTfEWp8YK4uCdrYyVb+ef8LEgBiI8D45/QGcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0Jmg53enkI33OQHq4HIxdbFLUoF7PEzYhewKopaB2s=;
 b=pdR1gKJCaylFoLsMTWgZwFgRhcg4jaTSs1rDEgydaTuX2O7ZwtVKx+d7Mgwqp7dWXh0qXBeOBLBLmwPC1IUt2EbBz3kO/vGEjuqHx19ke90fbOq77MTnj9VczacJAzE9BbbPY5SW6P4UaeNLJ9/m2hFKxGlzyd2qp72VSBqsGOgOAVMp8Vu80MNvzpzd64Bim1TAMulU/9rSjyDDGmcNJnzUGnGRKIoa5495siG6O/u1hY3CwD2DkDa/Bxt72eAGR70tl1/42iNPQIIkFEhKmsXiDtySpzoFLlMwkvSpHq0xGB7+P0eoAo325CRl9mEWyHymvDADqBV8zxY/Om0aXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 IA1PR11MB6346.namprd11.prod.outlook.com (2603:10b6:208:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 10:42:14 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 10:42:13 +0000
Date: Tue, 7 Jul 2026 12:42:01 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Thompson <daniel@riscstar.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Alex Elder
	<elder@riscstar.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Message-ID: <akzX+TYLtUH7EDIS@boxer>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
X-ClientProxiedBy: VI1PR03CA0077.eurprd03.prod.outlook.com
 (2603:10a6:803:50::48) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|IA1PR11MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 74883b50-5426-494d-0295-08dedc1467d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +/tU/pDW/clD+nilqtCjJ++NdkuLU8n2Z4JiA/cyQvKMoDj05QQZGUrrj8xDqDAOuNru2cyuox3XSAJtB7dif8oPiETtm9RLx5V62obu+/coN97Kj3Rh2EAqfh1z2fpd/35inAb/b5GJ+fMshvj5uy25ohOvpMki5Azph0zMlDT30Xipp/6PjG7A7Nim+VHGz7FjyIji63054AZjMg9UjEpe1t8T9lJ912qLJWzx4x+1QWSIB2PlJepbz18zmVs15KQ/LSWCjlGG1gNVwGiyJO7glmoepLNlC5BzkC5n8RQ9wzxzYTVdd1UuhUj0sg1BQhNoHFAuO+Zxp2mffzFi5S5rNbhukdTgISkb1u0UPoDhX9bfhlkIsG+twfNy3Hq3C/bjn5lhrhl4mizLR+SoqvN+ZJdWdDZQdsytXic8ASRFM3nMz7/Yh4cQm5UuENFdzNvBT2AUEP7sZ2UO+v9EdXlyOXvD8a2hXqvzGhWZe4/V/eelmIJ//3joDz9ZOsgB/aDPSuxnOFYOzkTZnnNW8m/dm6XMq7qjlqFto7FRbRaaiH+d1m90F5s14vS/kn6DVLp3cQooS6XL3DLPFcIKl2j9xqjO9/BL/Jk55N+UfOpf+RuFjSrsfHhlCKTEURwPtRsLaePfpCdCfg3QZtyxRier7sOJneVI4YlOwflLABA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBQywAeH51U0L7l9PftKbDSkR/N8PE/rRyLF1a3M2gyaVtQNQlgGa1JrI3tp?=
 =?us-ascii?Q?zFqHtTsOjDww9xQTsYXClYiELAD4K3bYMlpF/xvTSSxDr4zGKX9mLJdEamX1?=
 =?us-ascii?Q?ow6TKo92kS9/EVpPqmL81IuumeSJobQ9CTJQLAbKrfmzbZH4bP1uGlp2ehIg?=
 =?us-ascii?Q?YVSCNOCTIXccMzBHO7Id9jElJZCU+wAibQPuhQabOrqR72DdezpCH7kRmwWG?=
 =?us-ascii?Q?p5DCUUVFqoGZfUFO5yalB+AkoFS6j3u4AVj4Roo9akCDutIOLL9VhOr2ACPc?=
 =?us-ascii?Q?a+B32Iwnyn1Xb3jYNi38HgwxoXmcL3fTR3IRRc21y+9ZrVcp/+wxnypcz60x?=
 =?us-ascii?Q?yLiTLQGeBp16acRJlM6Mf3vEBY3NfJJfGAjGKAPcAXjrsfMgN7iddGrPULWJ?=
 =?us-ascii?Q?hJ7Lv9+JgOFB/I+/QOcnZUobdaaCfwqKzlPkJ5MS5bVlFyP8jAluQY+5YwAG?=
 =?us-ascii?Q?BKFFvG7zwhwdxlaHXGurXGU7eztJ0Sp0liwTFXiTac8qD1OTqoZf0mOerI3b?=
 =?us-ascii?Q?tNRjSVZuTmUZGvnGczFLUfqCfahUArL9sl8kyv8x2iu0P9yJD0KN6vhps2Kv?=
 =?us-ascii?Q?6R3505aRWpNZwTrPDJ3vS44TLSI6AvaPg23zuS10DS1b/c37P9wjvKhWPdju?=
 =?us-ascii?Q?6/jeQ89M+rWpKjVOpr1hJR1zH9cRk/gykZHvJUOYnVeFauSS69Jm9FfbfYlX?=
 =?us-ascii?Q?hzHdOyI85E8ImMJI0dU8IwGljtL4uqXLqyt0gdO7bHanojmRYIp6ODEmJCmw?=
 =?us-ascii?Q?/3fFgajf3j+j8hzWdayiOIfyukrpHphoGQGIaxq4lHmzvmonncdmeKBfS49P?=
 =?us-ascii?Q?TUUaQ7UaPVkrb6Hs8Y9tipmEApHdU6hMJeHip5a+MUxYn7+zKYwFL14/gMGL?=
 =?us-ascii?Q?IwB6WYUiJz7/uNE8mXbfDxH6P+we6T0tJrJuk1PS20lRNUh9Y5cuVKNipoEu?=
 =?us-ascii?Q?uzbrNLLN49qCILy/OdI0ihovoSfHy/v5GmhDdTHkqBHDXsCSWaGeThnG69iO?=
 =?us-ascii?Q?Xqwl7EU6dMqkrZvhN74QApNT59nRXxxJBHze0sYyNthl/XopcgVZ7s9q+PeP?=
 =?us-ascii?Q?jCBRczBuhLcneJaDp3xa7w5LyNQJtEuf+QilSN9aLQLEyaZsRNPTgWm9SozL?=
 =?us-ascii?Q?6Km2z1UsU4kHXLWz1MIjjVS4u4bpz2ovyJfIKvaZ5vzu4CbDHWNLItl68ifc?=
 =?us-ascii?Q?uXOZCnl0Ex5OMB37h8b1Zr5+SaPWqVE+9P8QOMaL6jlCZnTgthCrM2o8WtSy?=
 =?us-ascii?Q?NZYueGwSzuMkRNPScZ3bCzO6PvsnJq6z/yGB+h/N1Bm+WCkJLLWJku6o89rj?=
 =?us-ascii?Q?Ktq7MLHPMRdWwEjlxjnatP8dcsA8hqoK1jl6rwrbTa1nKgDtgaGCfuFJ9ik1?=
 =?us-ascii?Q?41Wc5vGpfbeKP1POtm4/OSwWA8qefuKIApiuWL0She8+81LShtNADUWpmRBj?=
 =?us-ascii?Q?ebhPpM6a9NFNN++ToGAa79fuOrGYauql2w/1g/4b3rCtS3vPWilQOhwbTZxC?=
 =?us-ascii?Q?IaOWNWtnfd/SjVYbxV49QX07LMlflphUrqL/4cHQpGmfW6X1hG0Ga+gHlOcV?=
 =?us-ascii?Q?I+70DO9xWBbggF7DQMWTYVFzX4zK4DzlT1Vc8E8EXRwi2bhmmGJbwWXP7ii1?=
 =?us-ascii?Q?XTV0yo24XL4oGG3nKtZhwbZQMOlkxdUeP/1NXDUC5UrBxYwqXTMXSi5IgBKZ?=
 =?us-ascii?Q?t6wEheelA+jB1xZX2ZzjuKcCnlU2MrbtwUR0J6sD0pM5BYcRLZpJmCWK9ADB?=
 =?us-ascii?Q?07H31wY+Z8rF5ilpGjJ13g2oxlOhUO4=3D?=
X-Exchange-RoutingPolicyChecked: NdeNVnCAspsmmK93Q8kGz7sa/RUIQBxQYQ+3v/wjsW8H5in7N2ShEAAmJitL2j/1wr3bo+eb3/TNjsxesy/L/V403BL2CpxlE+NwTtYojLg+KbYfkGg5f0Yf4lYoxrDgh3R0fx6XSlB9DUoyN394iWLJBUf36YkYyLEjXPLQCA6zeCLgA02pM+2Xp5UsbheVdmWu12BuZmoHrKdmQ96CevbuaPaxhaWiinIKAAxuvPrJi7Be+SdtPW6LUswL9sktkN0JxWRWjxNOUNOkI5J1lkYua9vJ2Rc+2jvBPwXtwffk7nMDauZRcYbDH3ncM1jpUlabeSCXbAAPeKj8z+KrWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74883b50-5426-494d-0295-08dedc1467d7
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:42:13.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geGkJ4VvZiGQF7jCdrjFAyTNG87xkI+0EKnKfD7/Tg8/WYALczXFSrX9J9SpsyH4uUbP8p6jzIQ/e3VGOcxo3nHSEB40t3He7aubE4pimvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6346
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@riscstar.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:elder@riscstar.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305409-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,riscstar.com:email];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,iogearbox.net,fomichev.me,riscstar.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08DB171A992

On Mon, Jul 06, 2026 at 05:17:58PM +0100, Daniel Thompson wrote:
> Currently stmmac will run a full cycle of IRQ tear down and setup when
> setting up a new XDP program. This makes tuning TSN systems difficult
> because whenever a new XDP program is installed then the irq threads will
> be stopped and restarted which will undo any thread tuning.
> 
> The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
> from stmmac_xdp_release()/stmmac_xdp_open().
> 
> stmmac_free_irq() implicitly synchronizes interrupts and, with that
> removed, I was unable to prove that later actions in
> stmmac_xdp_release() are safe when there are concurrent interrupts. To
> avoid problems let's also move the code to disable DMA interrupts earlier
> in the sequence and explicitly sync the interrupts handler(s).
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>

Is that a fix or a new feature? You need to specify the tree you're
targetting this change (net/net-next).

You've also got Sashiko review so please resolve reported issues there.

However the scope reduction of toggling interface state when loading XDP
prog seems correct approach. For intel drivers we started with resetting
whole PF and then realized it's pretty much an overkill and we can achieve
prog load via only down/up of an interface.

> ---
> This patch was developed (and tested) as part of the TC956x work that
> Alex Elder and I have been working on. However the change should work with
> any driver that uses the stmmac core so it makes sense to submit it as
> a separate patch.
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 61 ++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3ff1ffa57e224c25f9e77bc28ed10..acd145f1f3069fde6043a9118c793758c5c8f4c0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2531,6 +2531,23 @@ static void stmmac_enable_all_dma_irq(struct stmmac_priv *priv)
>  	}
>  }
>  
> +static void stmmac_disable_all_dma_irq(struct stmmac_priv *priv)
> +{
> +	u8 rx_channels_count = priv->plat->rx_queues_to_use;
> +	u8 tx_channels_count = priv->plat->tx_queues_to_use;
> +	u8 dma_csr_ch = max(rx_channels_count, tx_channels_count);
> +	u8 chan;
> +
> +	for (chan = 0; chan < dma_csr_ch; chan++) {
> +		struct stmmac_channel *ch = &priv->channel[chan];
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&ch->lock, flags);
> +		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> +		spin_unlock_irqrestore(&ch->lock, flags);
> +	}
> +}
> +
>  /**
>   * stmmac_start_all_dma - start all RX and TX DMA channels
>   * @priv: driver private structure
> @@ -3814,6 +3831,33 @@ static void stmmac_free_irq(struct net_device *dev,
>  	}
>  }
>  
> +static void stmmac_synchronize_irq(struct net_device *dev)
> +{
> +	struct stmmac_priv *priv = netdev_priv(dev);
> +	struct stmmac_msi *msi = priv->msi;
> +	int j;
> +
> +	for (j = priv->plat->tx_queues_to_use - 1; msi && j >= 0; j--) {
> +		if (msi->tx_irq[j] > 0)
> +			synchronize_irq(msi->tx_irq[j]);
> +	}
> +
> +	for (j = priv->plat->rx_queues_to_use - 1; msi && j >= 0; j--) {
> +		if (msi->rx_irq[j] > 0)
> +			synchronize_irq(msi->rx_irq[j]);
> +	}
> +
> +	if (msi && msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != dev->irq)
> +		synchronize_irq(msi->sfty_ue_irq);
> +	if (msi && msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != dev->irq)
> +		synchronize_irq(msi->sfty_ce_irq);
> +	if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
> +		synchronize_irq(priv->wol_irq);
> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
> +		synchronize_irq(priv->sfty_irq);
> +	synchronize_irq(dev->irq);
> +}
> +
>  static int stmmac_msi_init(struct stmmac_priv *priv,
>  			   struct stmmac_resources *res)
>  {
> @@ -7108,8 +7152,9 @@ void stmmac_xdp_release(struct net_device *dev)
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
> -	/* Free the IRQ lines */
> -	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
> +	/* Silence DMA interrupts */
> +	stmmac_disable_all_dma_irq(priv);
> +	stmmac_synchronize_irq(dev);
>  
>  	/* Stop TX/RX DMA channels */
>  	stmmac_stop_all_dma(priv);
> @@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
>  	stmmac_reset_queues_param(priv);
>  
>  	/* DMA CSR Channel configuration */
> -	for (chan = 0; chan < dma_csr_ch; chan++) {
> +	for (chan = 0; chan < dma_csr_ch; chan++)
>  		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> -		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> -	}
>  
>  	/* Adjust Split header */
>  	sph_en = (priv->hw->rx_csum > 0) && priv->sph_active;
> @@ -7197,10 +7240,6 @@ int stmmac_xdp_open(struct net_device *dev)
>  	/* Start Rx & Tx DMA Channels */
>  	stmmac_start_all_dma(priv);
>  
> -	ret = stmmac_request_irq(dev);
> -	if (ret)
> -		goto irq_error;
> -
>  	/* Enable NAPI process*/
>  	stmmac_enable_all_queues(priv);
>  	netif_carrier_on(dev);
> @@ -7209,10 +7248,6 @@ int stmmac_xdp_open(struct net_device *dev)
>  
>  	return 0;
>  
> -irq_error:
> -	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
> -		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> -
>  init_error:
>  	free_dma_desc_resources(priv, &priv->dma_conf);
>  dma_desc_error:
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260706-tc956x-stmmac-no_irq_teardown-8a7592b9f8c1
> 
> Best regards,
> -- 
> Daniel Thompson <daniel@riscstar.com>
> 
> 

