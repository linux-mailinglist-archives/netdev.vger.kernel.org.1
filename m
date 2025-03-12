Return-Path: <netdev+bounces-174264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D05A5E107
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43501634FD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865324E4B1;
	Wed, 12 Mar 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJtdaN4H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401B2505CA
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794621; cv=fail; b=GC77kRTPRnq3uGxQpLnoAXQXM5oZRVXZpV2eNqAYR/lXlqLJGkNO+ztpUYg1w//JdAPKjynZxP4eXWOsqKJJF24y/beCNoddUJR61KidAdXtFkASIlcx+1cJwJoTP4HwiPOrzKpAiNfLVKclQUtDdK70fzTo9XDCjSqFLxa1XJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794621; c=relaxed/simple;
	bh=TswHSkFIHhtpKDKDPi+AW04Hxjws68JzAjiNKLrFxmg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FE9G3W5eMo43HJZ5HvZY429Mpr/cAfUcGRIp/QW5nJYELe+oBKloD6kiMIqVMGn9rhO1/6r9v6aOsEF6aHXzcybnfIwLbh/SrMUOpDracxiq/WFzPshho0VyswiusyOzoE+Hc5nNpY++YtE6kbOIiDW1DqLQ6leRXLeaygjXY08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJtdaN4H; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741794620; x=1773330620;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TswHSkFIHhtpKDKDPi+AW04Hxjws68JzAjiNKLrFxmg=;
  b=eJtdaN4HXC+fxPqtTbpXdPMXcFXU9p8ipYtdZ9eI4e8tHFNVYa/KpYMO
   iwjLtdPJ2B4gQVaXGvu+86x10ryBtEFIiAyLmav5FFCCglzrum1yXtEoL
   5jLuy5hDu/MGk8KYo6rh+efaa7H/Ii4DlUqk8FVOrXZVnNHD3zA0K6IuU
   hxNeiYgqXsllOualLOCCERqEHboxDTRvWwKwyxnojWiaXIOYAFETXGa7k
   7Kca77UjJcyBFoc6ASlnODhL7X5MCeIIN6vxLgECjgx0oLwebFk057NaI
   T7wwVh+g3/LiY1Eke2BNDDVNr9vs1hbVLAy26d3C6ZKfplbUy02495IIy
   Q==;
X-CSE-ConnectionGUID: Ctd3dlgKSRKhJo19E8l1fA==
X-CSE-MsgGUID: DjnQ4j2HQ9Kd2eVyUFtxHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43061928"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43061928"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 08:50:19 -0700
X-CSE-ConnectionGUID: xylAB8K3QyuEukMpvEqVsg==
X-CSE-MsgGUID: SIuOWalwRwK4cMWx3LYWWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120635549"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 08:50:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 08:50:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 08:50:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 08:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgZsuKMUK4/5l2K8TDJHwBKS07zGGyEPGL7NJgUHJC3v2dLgwSoKgJnWOpLW86E0yIMSwTpFr3c612erL6XEC/JR3P/4VF6ZvaBi9TCXbQvH5Nht20c9gyBgOIpMbiTHaR8KVRDXHiMbC4TyuMwZW0XvFj8tgrRczauKsCmND0DjI/7coNEfxhNlK6ABjQ6irLjwECXe6B+G/0e4ua/Alq5p1sq1HpmtjeQUV9PgSiJVsbYKhNCtlcOsta3enPEnUroAksqMyqs4r9wfgs8rczW5OUfhjptmaYbtNKJyb7cue+XF7t7ufCZtmR0L/Ol699XaqWPFZV7+84he4Ff6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3qiCFxBKDCDOiX0UzLbhK5SW7GsWoMO7qhuTxq/rco=;
 b=UDrpADmE5EcB5mK/sFiwAfa4AdePLmbqr9WQxHIIfe34awPlNeQnLrwdxxepknkz//cpIeYkI1m5tLIQkbcK3TZPd+H1zhep9RaZe10B/P/zKdJtvif+o0YbKdOiE7haI2blDeVy5YYPgrr6AAp7O43t617ukop/76gqZA/XYaTmDpCnfYXK+BQCyvxayhAF3ueOCGIM+bW51LyYJkhKggr6pPfq6iu4Np/jy5MXycIioWKSCAQEQ+Yy7xdEZShhSPtK4/3fX1Uf977i4Smg54uYuBZALy9NhVEL56ukwOyQLI55Gp3V1Ym9olsm9BOtqfAn96Z/ebzTxmsI1rEJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.33; Wed, 12 Mar 2025 15:50:15 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:50:14 +0000
Date: Wed, 12 Mar 2025 16:50:03 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z9GtKwAuEx+7HKjR@localhost.localdomain>
References: <20250312-airoha-flowtable-null-ptr-fix-v1-1-6363fab884d0@kernel.org>
 <Z9Ga7gx1u3JsOemE@localhost.localdomain>
 <Z9GgHZxkSqFCkwMg@lore-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9GgHZxkSqFCkwMg@lore-desk>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH0PR11MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 143e56a0-d6d7-44d9-52c5-08dd617d9437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jtgB5GYKlA6g5UwZnHnUK+AewVXiJogPTtJOh1LEjXGBGlqy29O4HGbvPN2K?=
 =?us-ascii?Q?3Sc9egy/Y/s1cMH3H1DRcdD4C/ulOdpi2blCl1d1Rl0TPDJ5dSuL4kxlfAzW?=
 =?us-ascii?Q?UjkQITkD7IX3y03ugaK7gvgfrLE6iV/n3WnaFrOSpQpzJ9tT58PFXIi+SLLe?=
 =?us-ascii?Q?pI5NLf2r+h3jWRSWVDVKabnRIrq9fVEPzsK8/MD+PWYw+Ynmv+OsZeDYwvbP?=
 =?us-ascii?Q?+yHH7RNQY1N4psl9aFBvv8vwrQqntwqCVc5SSniwWK31NKxLKLA7/H8Fu3RC?=
 =?us-ascii?Q?4dfgKjB15ImoOMLYA3Ghx8kYUVnMWf3RQWXxaQyHwxfeyDhOMzsmAe4ar31d?=
 =?us-ascii?Q?Vs1m3z7pto1pTA9kHC8fiaNIrlg/XnRjLDaliNoGaJnRjsrgylPyanlj/5Te?=
 =?us-ascii?Q?Yz6xjL1KQNVEbc170O8GYT9Z8yZNmc14Qn7Rw8PHqlkDfPf6/2XRfsBstJ6J?=
 =?us-ascii?Q?iDbic/z7iZ/WBVEKKwra7J+TDAZeps+EeJEcu3A0xnQb8YJuyIDTfGmJjaxN?=
 =?us-ascii?Q?Q60ZOq3jyEuJn9PhyUQOzD3JstOfeOSKEwjr0Xw5ZFPt5huuF1dfmNOahXMJ?=
 =?us-ascii?Q?WJnX8ZdaPMEl1KBte9CGEJFdL9rhLfqhQAXA82nAcXNu/O+b1fv/2KR7eeBy?=
 =?us-ascii?Q?IKfJByz+7laK+D9bBV2sOtY22ac0c8lPoIYfdlxp3RpWGGx/IGYfaJvvl9yn?=
 =?us-ascii?Q?xGGrfa5OOjKexwpdlFGqsrrUspVuMKgMsboCOLVYVOabyll5m6kmZ4z14Abs?=
 =?us-ascii?Q?vHe3MEAm8cHjWhen5l/3Trh5R4XF9xzGhbDwffqAGy5iRZaU3GlGy2iL8u4m?=
 =?us-ascii?Q?vlfpqfMH3K1HlXQoGHiueIqovuL9jlmLXKTJynawQIHuV+UM/1TckrCqmCzd?=
 =?us-ascii?Q?QUIYnniUCOZmHG3wGiu8B6hopyI2+74Ujn8LgeQnNDnU4OEgDNLNvbzisSQ6?=
 =?us-ascii?Q?XwxhFI1vCOF92iusm9t737wOfwH9PnG5D/VyHr/LfnSlwxQRzfPIn5tDLaTm?=
 =?us-ascii?Q?aVBCSCKAzRpb+K4SA9BqthBLMjCWhw3AyEsN5Zj4zAiYK4Q9psFJcdaORFGs?=
 =?us-ascii?Q?v2uVq0dARc/GvJ7oJQcHiJ1RcJt2M56MGvCt2uWkF1Kzq3P/A09pkuOx99sm?=
 =?us-ascii?Q?/GgiBGEykE2oSjDOTk/hq4yaOGDTXPR0cZNkHFwqD/VIfx+YZAVGMwPg5ThY?=
 =?us-ascii?Q?icAKQQf9kagHt/tTRBNBvyMPP3A6hTVZs4Z65cXHyQHXbObuV+LQ5RGNUBOQ?=
 =?us-ascii?Q?AQeu9WT3tikv54mWsGznEgaJUYWK9OkQCxplZI42HI5cGT/Nbpr0EQ98woyl?=
 =?us-ascii?Q?krSM88FERgc93IGKPQBJP/EGOjsZDwqz/GoeNPvCe+cC0jPuQPr82wAF8OlU?=
 =?us-ascii?Q?CsfI/v+5uBNvxaEhdlGgJkWDELNt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b76p1GMjXyaSNM/wwU1OGgwvvPd2LzhnTREI1wPKUBIOVJ1TMLEpF4Swth8k?=
 =?us-ascii?Q?fErgzqSXjKxup5xP35Sk/jJubanDuYMcnuovorBr1G42HzqeE2MHrBpnNM1B?=
 =?us-ascii?Q?eV84/ymb71DVCBQ4b3TwZi0UzCjUw+HWEK1imy4CBHTMdTSHD3IZJzziFE/m?=
 =?us-ascii?Q?XSxj8rc7FYa1OHGAk3W8QGiz4RON9cbLSLJSyHkYPZ3gMmXgVt6yf2iVX9bp?=
 =?us-ascii?Q?yz1+TAQZjfNadPtMvuh6P/mDjfmBZxUWLvpZbQ7tR2GJIhOJJIvdviWyE684?=
 =?us-ascii?Q?JDDm9J0dlJ6wpgmczzBEn7PrEgW2qBVrLJwJDVWPNYMUTYK9MC2l2BOEYr+R?=
 =?us-ascii?Q?8QVWnoUEyIUX+TKq1LANRUsBsjqG5S1rzfYwl0Sm1AVR8uBev0nBMEIXdfNO?=
 =?us-ascii?Q?2ap+H1s+aQl9HK+gt5lrPkErlJyh75ICAsjcZCBZo1W+fwFMYZCH75T/GZPr?=
 =?us-ascii?Q?3F2pSTzXIV9ytuD7RpHTWoVy2Qnf7K5ZZzHmDoj6iSR9GWkcELWiasPVOveU?=
 =?us-ascii?Q?aNVV0QXfz6HnlNspyTKlNB8cSW5u5Sm6Xv4ugvA32JaI5PNKl0a+XsNc9TmT?=
 =?us-ascii?Q?6ltNe6rBLJQqkEYHAbpPn3oMf4Ei9kXqPJHmZ4uyaRi6+r7pA5dXbgfi5pCU?=
 =?us-ascii?Q?vfzrh4gqD0r8a3FatkFZrTrqxaTqj2JwJyI9va/+Bvt0VXkBskA3Ibk6cmX4?=
 =?us-ascii?Q?jgjO4rRzXLzUK6HyLmvHqG7/MXAYO7EmDCdgajBuW0DdJ/HGvc92tp3G+9/N?=
 =?us-ascii?Q?uF8d0nFEPHJv/7Bw+5/yrekaYHVTxIg1zrVFdRws5Qby3J0CM/k9KL0yRcT1?=
 =?us-ascii?Q?fNl5XSycIXlDV+PD3orFcc4ZCpePHBoV40iw1Mi0oc+B00jBBnlXgPc4LGBQ?=
 =?us-ascii?Q?vlcgfHAA6CPlHHkRSImJ5w2YF2RRu/sM69nbzCtbPiai/YiLOY7GRTOatrjO?=
 =?us-ascii?Q?99htz0hDXqeBFORYIqob+UzGcsgh5oYgIH/Hbk6NgerUblNbdTB5plmfXb8R?=
 =?us-ascii?Q?hln6L1mSdL0ShE9/Sj1dMoLW0/x9/wnJEmdoro8a4pB0PuJterlxG3qDAS3k?=
 =?us-ascii?Q?4WorA9ep5qE0NsrHyoEragbwHpWjPWC5RJ6Bk6CnXzB/UZqO+JvetGXPXfFb?=
 =?us-ascii?Q?kZlp1/zfG7sfuD4NbbXIjrdqWW3bwesKxoCsI/0Flj/YLmajo2o780JU1ZuU?=
 =?us-ascii?Q?4ZFfG+NPJ8y+5+2OpaBJ7iu1JUs47FXfC7zUqu4MGgXRidxA0Tsz3KRiuNYw?=
 =?us-ascii?Q?U/2UcwbfccDLrPiUmFhTOIXJD/6M0uNgq6bum05xo25WIZgDupvn8NvAEgJX?=
 =?us-ascii?Q?xMp1KIWgOD0eYK6JLUnDguhxRVmjUwEE2vKDiELQ/da8Bh5tEnplORj+lSfP?=
 =?us-ascii?Q?JuQl2W5oNHA7N4LG0TQ9bqncog0M1l1+OPlByR4PgqMQkrnZScZiEwwyLoHv?=
 =?us-ascii?Q?JQpjRbxa0RBilDe2YmAH8N+4+YfY5zCwVazd1hwYDoIWmVzY/aCrmw4RruSK?=
 =?us-ascii?Q?I91cO2D3rOZPZdink31QQmFhr0hagiRrZVBi5a/ncdDMQHzLJCpm1i+2uwgC?=
 =?us-ascii?Q?GXCsvoSCrRUUh7/U7o+ekg+JMXiilYKzT3Bb5Qp/AbqhEbSsoULgPulG3by6?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 143e56a0-d6d7-44d9-52c5-08dd617d9437
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:50:14.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNL0J4TNBKryU2kpissZ4BeVJiPSe4XNhwsEkzgOmsPvOS/hxTCjNwVSKRncxoVq9ur/rkSy/PNTbA2KiA/Hhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com

On Wed, Mar 12, 2025 at 03:54:21PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Mar 12, 2025 at 12:31:46PM +0100, Lorenzo Bianconi wrote:
> > > The system occasionally crashes dereferencing a NULL pointer when it is
> > > forwarding constant, high load bidirectional traffic.
> > > 
> > > [ 2149.913414] Unable to handle kernel read from unreadable memory at virtual address 0000000000000000
> > > [ 2149.925812] Mem abort info:
> > > [ 2149.928713]   ESR = 0x0000000096000005
> > > [ 2149.932762]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [ 2149.938429]   SET = 0, FnV = 0
> > > [ 2149.941814]   EA = 0, S1PTW = 0
> > > [ 2149.945187]   FSC = 0x05: level 1 translation fault
> > > [ 2149.950348] Data abort info:
> > > [ 2149.953472]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > > [ 2149.959243]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > [ 2149.964593]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > [ 2149.970243] user pgtable: 4k pages, 39-bit VAs, pgdp=000000008b507000
> > > [ 2149.977068] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> > > [ 2149.986062] Internal error: Oops: 0000000096000005 [#1] SMP
> > > [ 2150.082282]  arht_wrapper(O) i2c_core arht_hook(O) crc32_generic
> > > [ 2150.177623] CPU: 0 PID: 38 Comm: kworker/u9:1 Tainted: G           O       6.6.73 #0
> > > [ 2150.185362] Hardware name: Airoha AN7581 Evaluation Board (DT)
> > > [ 2150.191189] Workqueue: nf_ft_offload_add nf_flow_rule_route_ipv6 [nf_flow_table]
> > > [ 2150.198653] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [ 2150.205615] pc : airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
> > > [ 2150.211882] lr : airoha_ppe_flow_offload_replace.isra.0+0x6cc/0xc54
> > > [ 2150.218149] sp : ffffffc080e8ba10
> > > [ 2150.221456] x29: ffffffc080e8bae0 x28: ffffff80080b0000 x27: 0000000000000000
> > > [ 2150.228591] x26: ffffff8001c70020 x25: 0000000000000002 x24: 0000000000000000
> > > [ 2150.235727] x23: 0000000061000000 x22: 00000000ffffffed x21: ffffffc080e8bbb0
> > > [ 2150.242862] x20: ffffff8001c70000 x19: 0000000000000008 x18: 0000000000000000
> > > [ 2150.249998] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > [ 2150.257133] x14: 0000000000000001 x13: 0000000000000008 x12: 0101010101010101
> > > [ 2150.264268] x11: 7f7f7f7f7f7f7f7f x10: 0000000000000041 x9 : 0000000000000000
> > > [ 2150.271404] x8 : ffffffc080e8bad8 x7 : 0000000000000000 x6 : 0000000000000015
> > > [ 2150.278540] x5 : ffffffc080e8ba4e x4 : 0000000000000004 x3 : 0000000000000000
> > > [ 2150.285675] x2 : 0000000000000008 x1 : 00000000080b0000 x0 : 0000000000000000
> > > [ 2150.292811] Call trace:
> > > [ 2150.295250]  airoha_ppe_flow_offload_replace.isra.0+0x6dc/0xc54
> > > [ 2150.301171]  airoha_ppe_setup_tc_block_cb+0x7c/0x8b4
> > > [ 2150.306135]  nf_flow_offload_ip_hook+0x710/0x874 [nf_flow_table]
> > > [ 2150.312168]  nf_flow_rule_route_ipv6+0x53c/0x580 [nf_flow_table]
> > > [ 2150.318200]  process_one_work+0x178/0x2f0
> > > [ 2150.322211]  worker_thread+0x2e4/0x4cc
> > > [ 2150.325953]  kthread+0xd8/0xdc
> > > [ 2150.329008]  ret_from_fork+0x10/0x20
> > > [ 2150.332589] Code: b9007bf7 b4001e9c f9448380 b9491381 (f9400000)
> > > [ 2150.338681] ---[ end trace 0000000000000000 ]---
> > > [ 2150.343298] Kernel panic - not syncing: Oops: Fatal exception
> > > [ 2150.349035] SMP: stopping secondary CPUs
> > > [ 2150.352954] Kernel Offset: disabled
> > > [ 2150.356438] CPU features: 0x0,00000000,00000000,1000400b
> > > [ 2150.361743] Memory Limit: none
> > > 
> > > Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> > > routine.
> > > 
> > > Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> > 
> > The patch has "Fixes" tag, but it is sent to "net-next" tree.
> > I think it's rather a candidate for "net".
> 
> The offending commit is just in net-next at the moment. Do you prefer to drop
> the Fixes tag?

Oh, I didn't realize this is a new driver in net-next. So, I'm OK with
the "Fixes" tag then.

> 
> > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/ethernet/airoha/airoha_eth.c | 16 ++++++++++++++++
> > >  drivers/net/ethernet/airoha/airoha_eth.h |  3 +++
> > >  drivers/net/ethernet/airoha/airoha_ppe.c | 10 ++++++++--
> > >  3 files changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > > index c0a642568ac115ea9df6fbaf7133627a4405a36c..776222595b84e4fba6ae5943420e0edf0d0ecf8f 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > > @@ -2454,6 +2454,22 @@ static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
> > >  	}
> > >  }
> > >  
> > > +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> > > +			     struct airoha_gdm_port *port)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> > 
> > You could reduce the number of lines by moving the declaration inside the
> > loop:
> > 	for (int i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> 
> to be consistent with the driver I prefer to keep the current approach.

OK. That was my suggestion only. Let's keep the code consistent then.

> 
> > 
> > > +		if (!eth->ports[i])
> > > +			continue;
> > 
> > Isn't this NULL check redundant?
> > In the second check you compare the table element to a real pointer.
> 
> Can netdev_priv() be NULL? If not, I guess we can remove this check.

I guess it shouldn't be NULL since "devm_alloc_etherdev_mqs()" was
called, but I'm not 100% sure if there are any special cases for the "airoha"
driver. Maybe in such cases it would be better to check for the netdev_priv?
Anyway, such checks seem a bit too defensive to me.

Thanks,
Michal

> 
> Regards,
> Lorenzo
> 
> > 
> > > +
> > > +		if (eth->ports[i] == port)
> > > +			return 0;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > >  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
> > >  				 struct device_node *np, int index)
> > >  {
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> > > index f66b9b736b9447b31afc036eb906d0a1c617e132..c7d4f124d11481cd31c1566936cd47e3446877c0 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > > @@ -532,6 +532,9 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
> > >  #define airoha_qdma_clear(qdma, offset, val)			\
> > >  	airoha_rmw((qdma)->regs, (offset), (val), 0)
> > >  
> > > +int airoha_is_valid_gdm_port(struct airoha_eth *eth,
> > > +			     struct airoha_gdm_port *port);
> > > +
> > >  void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
> > >  int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
> > >  				 void *cb_priv);
> > > diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > index 8b55e871352d359fa692c253d3f3315c619472b3..65833e2058194a64569eafec08b80df8190bba6c 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > @@ -197,7 +197,8 @@ static int airoha_get_dsa_port(struct net_device **dev)
> > >  #endif
> > >  }
> > >  
> > > -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
> > > +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
> > > +					struct airoha_foe_entry *hwe,
> > >  					struct net_device *dev, int type,
> > >  					struct airoha_flow_data *data,
> > >  					int l4proto)
> > > @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
> > >  	if (dev) {
> > >  		struct airoha_gdm_port *port = netdev_priv(dev);
> > >  		u8 pse_port;
> > > +		int err;
> > > +
> > > +		err = airoha_is_valid_gdm_port(eth, port);
> > > +		if (err)
> > > +			return err;
> > >  
> > >  		if (dsa_port >= 0)
> > >  			pse_port = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
> > > @@ -633,7 +639,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
> > >  	    !is_valid_ether_addr(data.eth.h_dest))
> > >  		return -EINVAL;
> > >  
> > > -	err = airoha_ppe_foe_entry_prepare(&hwe, odev, offload_type,
> > > +	err = airoha_ppe_foe_entry_prepare(eth, &hwe, odev, offload_type,
> > >  					   &data, l4proto);
> > >  	if (err)
> > >  		return err;
> > > 
> > > ---
> > > base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
> > > change-id: 20250312-airoha-flowtable-null-ptr-fix-a4656d12546a
> > > 
> > > Best regards,
> > > -- 
> > > Lorenzo Bianconi <lorenzo@kernel.org>
> > > 
> > > 



