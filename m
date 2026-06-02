Return-Path: <netdev+bounces-294157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FtjJw+8HmrZJgAAu9opvQ
	(envelope-from <netdev+bounces-294157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FD62D4BD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 006A930345EF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A313DA5AD;
	Tue,  2 Jun 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/1VDAJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9B3DD53E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399004; cv=fail; b=oyQGICdizbT3DpYiAuv9NBv0oSOkX8oEZIclYUytg3FvzGxnjrB+1vvsNB88RP+/k3DhIQlofRuwu2CfjfIfyCV9aVWGtV5AoZydzck0HIBxp1Lqn0cyujBu3hJ/Vs4s0Ie0QrgRyLzr34MvMj5MnaZx9mik/U9ilNy0y9KW4Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399004; c=relaxed/simple;
	bh=rSCXtPNVRNJT6G5wbouo4CBcLWO+ECFqD6Nw9jom3AU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HQy2JHd1Oeay9OtXsUC5hvcWJstYyxfRu7xK8scwTsntNkhg0ipsCtZTw+J3oOYRWTtBFB7I0We1uCWSJYClmbqDAkc9qG6G3wOHhnEbpn+V8UwFiDcFr6RF/bYL6MhIXaIgFw2nxAsvTBy3M1p/aEwxuDIICQNcw0bGSE5q638=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/1VDAJ+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780398994; x=1811934994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rSCXtPNVRNJT6G5wbouo4CBcLWO+ECFqD6Nw9jom3AU=;
  b=l/1VDAJ+bs7U+dA1NUNZ2j4v1kFRAPZvDgwvYmO9rH/sVKKVM+dqsuFn
   VFuY8pjJzzQrffkXQIsWgN7EQLeyJLLBQQCmoHuYu5Max/Mzw1TObWA6w
   +s5VvWoMHCGXNoheP+jeggx5f1yGoWZL6N5CLJbySulkh0/RJqkVT7uts
   FEiMARGpGdQj+NRCkFdPOqwlDFGkqo0E65efz/B1OSUCaAA57xwJ0cXsX
   S8ZDK74eOCiMSwXnrgYbFkaED/zglTpzLhUjxE4q/P9PPNGaC6eanepnN
   xmE2lRfW3vMziwRsIDP7uaFTGJ2VjKsRYpZvJEe7yw7adO0WIdCDrw0As
   g==;
X-CSE-ConnectionGUID: UDJsMAHzSPOvtwbOuBRCsQ==
X-CSE-MsgGUID: Life0oATTfqOofzYyCFtew==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="68725108"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="68725108"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:16:33 -0700
X-CSE-ConnectionGUID: GJCDmT4QTYyFfO3A3OQMfg==
X-CSE-MsgGUID: 7oBOi0uASaylR+kF3KXSyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267742487"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 04:16:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:16:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 04:16:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 04:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9zgKgt+i1xWMZVOD0RSTqOIsb4glVdFPqyu99V7878rzise33Oog68DReRwkIdcxsZWbE2JKQWYWNGM4WkIPlILk0rPo6a/07gWYQiufaeKbGLDdtlk2Jzcpn4YKVuDEObcpdwqFUDSfQWi9+AKFJh/sAm30WqHZ5Y9kO3h8fdPt6GxvDeyYeRtHPoMtC/xGIVo+DlKV1FDsnF/N6rtE8pTTUad5XwCdTt4VJKBeHHgIzrc/Lv0OZ6v607zNZI4DRXKPTgEn8CqlJqZJN+/Tvp2IX5w3488UJ2dMV0cVVvEnYYpcZx4VyJdIRpVVShX5+28/7gAJazPWSRF9waGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t+8Xql+Be1YX+n7SUW+F9RwwxlvF5BEOCGXvxINF+Y=;
 b=OsDwgTLg90zymklO33lSf7lWyJ+6SYOKPEGLRbNOZLJErnA81xrvL20YedojuPlOI4Gb3pSfW+cufJErnzJycK4R3dYDUD43xs36JGvtkvhoW5RjfsoATpS4z0VwVqmH2rbO5V6MuvtwNdAbIOdf+7Kk78/a7tFlV4Zn6bsdWU6B4pJVxSTs7+4BlQTRkGx7vi+Rz53VwQhSFphsBWt448Usep1OzfTA915d42/yNlOnpfqV5ZopvOlq/pwKIkE4dPqptSUUVGaFwbXbEslCSyeqMYZOhhXVHT6ZMMiZs8PVgZHWq+v79erKYrugzbW8CcHOihZ5Ga/tt1ARiy4HSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH3PPF5ACB2DC0D.namprd11.prod.outlook.com (2603:10b6:518:1::d23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 11:16:29 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 11:16:28 +0000
Date: Tue, 2 Jun 2026 13:16:17 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>, Jacob
 Keller <jacob.e.keller@intel.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Kees
 Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
 callbacks for AER recovery
Message-ID: <ah67geY9bPEbSKkX@soc-5CG4396X81.clients.intel.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-5-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601072221.2952-5-jiawenwu@trustnetic.com>
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH3PPF5ACB2DC0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc9100a-8802-41ce-1b90-08dec0986486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: E/Gg/4wP6kjkDVIotg2fpbOJ2kp8uTSZG+9NnyOe+Ri7vAtfhtMdJ3DWnf3OL9KBV1EojTRuOkwuJysJPjeAe6FURyHPpyzFTTM6z+I3eNEtNVmTbx+Ta6CG5oGX6VMoE15YKtC5GQZLpypeH83vhYUzd0BCmJNrKRxksMCueMeDqlvmd0hmtloCME8c8qkymordZmlnQG1V+pQbPdsngIrwvmdhCzdj7P/rSYcnowZMs511sLRlxe/8lixjANHrtg3HwetV7O/hXCRX7FDSjWOmcaOAzPxR6Zdd0gWdg0+Ux9nVDhDt5qz2fI9o4470w0rqLd7wOwvgQqr3PsBnR2a8NFQRs4+rvZwK6u1W0GLW2m7irpq0+kGqlEJxEfH3aCaNEzBYxpqd7OzjB58lcJ9rY2HDcdNXixCSSXPwNgw+WUuVBmz/P5VwkVWlPw6WtOLSxCDteFZF+Cew27FLQME1BlSYCNmeva0SQCrUCvgdRECz6yg+TUZKVBUZFi49MdRDJBjLq169219OrW440wolu9WThAplU77EHXtBQlsBrbqqTx4x68FP5egteCYBA7Xoe3KCVTO7kPeSvrjtd9hce5wiPz8Y1f0NjArvGaYBgYUqGbuV7467fBXNhd3dQ2AWkj6fCCVvi3TOoItvYh2eFe0ef9UvpH6xp0cFAZKcg7ovjaeW41GQxdvPqX2M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/UGHxjOALan1wHW0xIUvasYbNN45H6PCLVG9NtGKUhfrNl2/jW4cSHuop6r?=
 =?us-ascii?Q?xEUuERNx1tuLbHWMA32+wCtL8uEnlGu1SsIzjq96qmTsGkpxXP+ntbY8xLWJ?=
 =?us-ascii?Q?i7s2zxyBwWG9reg2f8E8TAqaT3Nw1y9vM0i6lgqxDC7Zjk47Z7OQVM2+087x?=
 =?us-ascii?Q?Dwsf9gUh7+tk0HqFAW3KgpiZxSMFPiCY89RT/PdCwkvqgfkY2AkC/f/uVQCS?=
 =?us-ascii?Q?MCJ8Gv5jn9RhMTU4jw2XlWQaQIXnOTE6Qs4BYQ9dCEXyScc1tozcacbJtmUi?=
 =?us-ascii?Q?PEODw/zBIzcQaqMaJXc4ZWTgPFAUKQQmxQtExlCmKScpABSOjTHfuae5RcWa?=
 =?us-ascii?Q?cmv4Y65olKQxniVCNK/P+RwoaRnRyFD7gozeJYJY5m1iB87o95i/u9LqrLQL?=
 =?us-ascii?Q?jomNQFR/HeFel+36+YhkPERD8Hs4UcEqZ+rkBeu+3NIFA0L66i92XLOf4Cg5?=
 =?us-ascii?Q?ugTJNpUMz/U3tQtSwNpaQOFgPWxBSwdEaAgF31tajL2dxfU/hyZkUJBL7qO3?=
 =?us-ascii?Q?fpFGG9z37CXeIOuVGpoJ6Iw2AYNgcSDhXhRVNn842skoVJSFjwwMCGJZWxDn?=
 =?us-ascii?Q?Nmb7SV46G2QcuTJCFG/cPN2nDwjX0UnIgKKyPQg05E1hb75NzCLLnbbr/ELw?=
 =?us-ascii?Q?cbEbX+NVY4WD8/mYJJ4i7HOlilzs+dMuw2DfPyy3szOkOlwEBpe5PRFYtZ3n?=
 =?us-ascii?Q?tjGozMZ8q6egzi42N08MpP0rUDXdkozD30UfTc3thV6LlQ2Mnrg6uz/2f8gN?=
 =?us-ascii?Q?9VXRkuYso4TvBL4gjDbJtghQ1dlY5yJI9xJLsyAinG3bNhEgtnU3swGKFFjB?=
 =?us-ascii?Q?aBZOpm2COwjaxIezyho3tg2ks5bSP/bQC6nxeceGjRrPyzLIilCfT15lIr6Z?=
 =?us-ascii?Q?wzvmu+4XQA5iuREwSFKwkwPhQTaAi6L/5tDuDxl0pEuF5JzVEvcKIUU+hWBm?=
 =?us-ascii?Q?FMTZK5wIvAWj9R9e9N6JNua8wWFJ1fRguOR32O6XvXKIA8b4TIruxchMtNcZ?=
 =?us-ascii?Q?CW74qv8EnQ9wV36bBnGG7a9dJe2ajl7I8kuFxdEjM7aKiWGp1421vBUK5GEY?=
 =?us-ascii?Q?agvZw4sidvyi7m2sVxoVvFPRkJOyqJ630MQaPr08SVG3UX3Ln/b9OvoCAAh/?=
 =?us-ascii?Q?UgxgUaI42A49980aXAQORq1uhW5lo8TnbUQzVwUMFD/ZVdDxS/MZZ8HwhoC2?=
 =?us-ascii?Q?Nod6HMs5//wN/OVGtnqW3wnOsWT+AIMMDCTPRhdkVS9MltlMwsi/y3dKtn5I?=
 =?us-ascii?Q?CQhGGnqTZX4E9+G/bAwfrSl+E/E7177c6OMldo27/S4apq9RLK3lPh4PIrd8?=
 =?us-ascii?Q?Lts2oKFFBsAnl7deAIG7e8C20PHvr9X+hkAGtfFXUVj+hywWLLyxsdmGIwFe?=
 =?us-ascii?Q?QrCOSXialPGV7K0CIWe/RSZ+p8D1aCZGEmUKxldvRRVdWrMWUr+4OkY/w6e1?=
 =?us-ascii?Q?96g/+JCb/tT9beyDQsAJLzeFgVpGgcUYdVGcSOZLvZhbJ6NMbUYWeBbc2SdT?=
 =?us-ascii?Q?NurTQ2+5flyrvOJz40hvPU+apzspJWCZ6UqO1uitUOyNiEWQmSbT0UijvIuN?=
 =?us-ascii?Q?VUPKCB45wryJfbgvg4rhm4Ni/uGlNlNhzwf72u3wzQsydVqbBE1u2svwlBEW?=
 =?us-ascii?Q?xDnRZQhY5BF/Nyyf+gZWbxWSPbYnYlapZUjWXSe1yVeDfV0LYJH2lVMKv06x?=
 =?us-ascii?Q?vrRvWqaY+wPH2Iw6pgcl4CV3Na8F/8grx9xeRo49DI3GJ0mXmRUBuoRBztre?=
 =?us-ascii?Q?3yPY+tn2lExEZYDLd7IBWZod/iApRvcfCc2db1bUsxMXSkTTSxVhXm+ri/GR?=
X-MS-Exchange-AntiSpam-MessageData-1: CxK8P5SbfGJmwMqSxyLJ1Y0Ei1LPqOaN1nw=
X-Exchange-RoutingPolicyChecked: n4PCzOX3zEJWjgixDkOC0+E0B0eM2qJb17FKCrAX0ubA3Hf64lzxPKfBmOueIkWOjdFKCdALFfyOEGsBbTxyrNNt+CLtFr8tShasjmtW93mSpDwli9w/f17czvUtIf+XZ2ilRJcWJyi7ngb0PxYQfht8CByKZ7B1PGrlThQqFXeyhFeiDzzfaH9ob7f3LEogXIxJ+cFeNKrgz60wiCWoVrNWfNL647URLuxWbHe1KORVqMCN5tHH+0PFjFFBlcrTd7wuQk7BomO8vyb7PcEMEIkRgN7AkUqAEW0dMYf4VXqmMqbS5WO+cCNHi/NfAgPOTZJIsrItqljd/Dr6j4cItw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc9100a-8802-41ce-1b90-08dec0986486
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 11:16:28.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9rz1xSS2xxWm0VVJWA+RjETZ+ZxEzXCJ+cmzFZcU87HNpc9Nkw+FPtrfaevDMUFuU0zeJ0JZvTEDsa6QznEI/dY7tlOLfPRSeGlsCifmQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5ACB2DC0D
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 4B6FD62D4BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-294157-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,trustnetic.com:email,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Mon, Jun 01, 2026 at 03:22:20PM +0800, Jiawen Wu wrote:
> Introduce device-specific soft quiesce callbacks for ngbe and txgbe to
> provide a lightweight shutdown path during PCI error recovery. It avoids
> MMIO-dependent operations in PCI error status, for the later
> implementation of PCIe error callback function in libwx.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 23 +++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 ++++++++++++++++++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index a8b4e84787f4..1b25a52188f7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1409,6 +1409,7 @@ struct wx {
>  	void (*configure_fdir)(struct wx *wx);
>  	int (*setup_tc)(struct net_device *netdev, u8 tc);
>  	void (*do_reset)(struct net_device *netdev, bool reinit);
> +	void (*soft_quiesce)(struct wx *wx);
>  	int (*ptp_setup_sdp)(struct wx *wx);
>  	void (*set_num_queues)(struct wx *wx);
>  
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 3dc8342dd3a7..2484d3177034 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -47,6 +47,28 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
>  	{ }
>  };
>  
> +static void ngbe_soft_quiesce(struct wx *wx)
> +{
> +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> +		return;

Careful about reusing the same flags for different reinit processes.

> +
> +	wx_ptp_stop(wx);
> +	phylink_stop(wx->phylink);
> +	pci_clear_master(wx->pdev);
> +	wx_napi_disable_all(wx);

Sashiko says:

 "If NAPI is not disabled yet, the NAPI poll routine wx_clean_tx_irq() can run
  concurrently. If WX_STATE_PTP_TX_IN_PROGRESS is set, wx_clean_tx_irq() might
  call ptp_schedule_worker(), leading to a dereference of the ptp_clock
  object just as it's being freed."

I am not sure, if such race actually happens, but stopping napi before any kind 
of deinit is not a terrible idea.

> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);

Same here, what if a caller needs a full reset?

> +	timer_delete_sync(&wx->service_timer);

Sashiko says:

 "The timer is stopped, but the corresponding cancel_work_sync(&wx->service_task)
  is missing."

And it does seem to me that this is the case here. I see that you have explained 
this in another thread, but you proposal does not address the case, when 
ngbe_service_task() starts, interface is not down, and after that we have a PCI 
error, and its handling interferes with service task. While this is unlikely, 
synchronization should be more robust.

> +
> +	wx_clean_all_tx_rings(wx);
> +	wx_clean_all_rx_rings(wx);
> +
> +	wx_free_irq(wx);
> +	wx_free_isb_resources(wx);
> +	wx_free_resources(wx);
> +	phylink_disconnect_phy(wx->phylink);
> +}
> +
>  /**
>   *  ngbe_init_type_code - Initialize the shared code
>   *  @wx: pointer to hardware structure
> @@ -135,6 +157,7 @@ static int ngbe_sw_init(struct wx *wx)
>  	wx->mbx.size = WX_VXMAILBOX_SIZE;
>  	wx->setup_tc = ngbe_setup_tc;
>  	wx->do_reset = ngbe_do_reset;
> +	wx->soft_quiesce = ngbe_soft_quiesce;
>  	set_bit(0, &wx->fwd_bitmask);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index b37c9ed57cf7..816aba4a9099 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -296,6 +296,27 @@ void txgbe_up(struct wx *wx)
>  	txgbe_up_complete(wx);
>  }
>  
> +static void txgbe_soft_quiesce(struct wx *wx)
> +{
> +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> +		return;
> +
> +	wx_ptp_stop(wx);
> +	phylink_stop(wx->phylink);
> +	pci_clear_master(wx->pdev);
> +	wx_napi_disable_all(wx);
> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	timer_delete_sync(&wx->service_timer);
> +
> +	wx_clean_all_tx_rings(wx);
> +	wx_clean_all_rx_rings(wx);
> +
> +	wx_free_irq(wx);
> +	txgbe_free_misc_irq(wx->priv);
> +	wx_free_resources(wx);
> +}
> +
>  /**
>   *  txgbe_init_type_code - Initialize the shared code
>   *  @wx: pointer to hardware structure
> @@ -412,6 +433,7 @@ static int txgbe_sw_init(struct wx *wx)
>  
>  	wx->setup_tc = txgbe_setup_tc;
>  	wx->do_reset = txgbe_do_reset;
> +	wx->soft_quiesce = txgbe_soft_quiesce;
>  	set_bit(0, &wx->fwd_bitmask);
>  
>  	switch (wx->mac.type) {
> -- 
> 2.51.0
> 

