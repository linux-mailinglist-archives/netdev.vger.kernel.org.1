Return-Path: <netdev+bounces-189057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C820EAB0292
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2D73AECA9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E22882AD;
	Thu,  8 May 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtjlwQgI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A026FD88;
	Thu,  8 May 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728452; cv=fail; b=CBNgFLusjzWaRTxBF+y5oUvoedyl+YGuC5tPiVmn6d4zAdSxrBq5y411rQrO3SboJAdN5aJB5DhMVXGe6OQMugUheFxE+nCeRKLP5NeVKGt0V4u8WKJTPV/fp7iE7y3KjEut9vWazCUieb79MVRTk37sJI48fHDfOpJlsezsiGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728452; c=relaxed/simple;
	bh=8p6CmRGbKRzWRmx39kPxNtIdyvcAvKo+eMmMdVYHBnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k0bITrykXDUTTKlbZLJRFJE5A48eVBk/xfeY46tvnLl5mgjrK2RTPkIvTAV5MGhNjkHgU2/SvZxaSohrscyT/fatnzfD9aWWwKBXUm8ZUA2wEFq7uJTMPaxqFd3o3ASONi7gbliNnnlRXEDgJEmkaSg6L1npMJu6HOKtrc/MdEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtjlwQgI; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746728451; x=1778264451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8p6CmRGbKRzWRmx39kPxNtIdyvcAvKo+eMmMdVYHBnc=;
  b=mtjlwQgIi4N5e/SS01hxLK7lqJRzJvE2dgW52ldrT9nkwf1WJGSqF79s
   s2qH7eiWtcPBvjl6CTZrWcpVhsLLxldA0gpFniD2oBDZZioc8il0rSf64
   YVlKkHUZBk++kgZfSeLu8niJOY52B7l7bnqQ78MK/UPMtd0/AmRJMUtRA
   4PAZ7WM6kNzGN7kNfAlU+oz0VqPEmmfoOUGLG6Soiaij1MifnB2UutZz0
   4jt92SMNrsnlzirScZaEeThp8E/e93JwmS4wQMVtlXxIJ2jR9+gS/FX/9
   5I3KlYE+A4jAHNj+ztJg9zglt/rSfaHM78aDsCXEbzt0rykt8o8dA5Qhh
   w==;
X-CSE-ConnectionGUID: cVyu7AG1TUevw2q7z2beHg==
X-CSE-MsgGUID: j5DRhDHLTzOkHeWa5w01aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59528233"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59528233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:20:50 -0700
X-CSE-ConnectionGUID: Lv/o/W5lSXiuM4fChxinQA==
X-CSE-MsgGUID: HqBY39usR0ivwNCLs6udiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136384807"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:20:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 11:20:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 11:20:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 11:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixCgqMAxrDDtcvn7VEaf3qrZsdZGKejoZJHy8kTL4AKOKnqacGnJuzlM1DgiPJNij0Bif6ZX0HBU3Q0EU1eeyaKZ4DLSXKt6825cycdwINGx3xNyPgYy7GsubHVLLbeGMCu5A4EvTFC3DIQ+ommgXzk1L2VXhcj1v+re87rHTLxLBpB8zAyV/onU1nmpOpZAqLCTHYH4zuzGnmWukEVrUy0cG3cIL6e5GFKJ/XTPf30mcCjTA14gWqsymoxDWuG9KMwQJAiIgKuSrBmdkKiCFKUSDUVWbqp6qnvX8Fu/SRF2AGVucYFiEZnbosjZMHZUy3C+LqsQeWt8q7T3fMm1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaPspH8Rb8uuuUJ/Vs14zXahfOICdYPhb52MFq4k0LE=;
 b=Gf1jCUjBITL1RcJpfmyKXm5QEe+zw9vunstYNo/s0COP0A9iK+zcXFJtJtSau2YmQprNvdQM6eQexkmu9uHZ7UH8AitnsDAAWFM3AHi27I+M1u4XdTEXmBYsml0OaFsS2NAGjjAZ0BOFaPr1sxx4+n4Rp36c+VYinJ3P4PBx1yDUqDbIqvIv1WBVTqjTn56M7o+t6fp4/tNZ6U2pZ4FEZCdn4YgNuFoQPgdRCM/R63wi1i1XKaez0Co2LRlZ+SW7l6So7WK2xoTlW+zS6S8bk06WAiO4gIIIrdGaV5pMsgooFG+fpHN5uNZ+iyG3KDhmWWh7Q1K1x74PFCXdKqlEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 18:20:46 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 18:20:46 +0000
Date: Thu, 8 May 2025 11:20:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v14 19/22] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <aBz19JAPxKm_XYRc@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-20-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e33ddbe-84b1-41b8-aa18-08dd8e5d0d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1EwBuuBdNm938k1tVh6jSt0mdVh5R8bharqt4W7EUO3cJzMy/rZVh3UAnMtW?=
 =?us-ascii?Q?RplQhJtgfSDa/xwdRLtHBCe5AiVSWPHortSl1KWq3p0HVZysJ34+NeT0HGKK?=
 =?us-ascii?Q?oRklpSenVwHQ4bM0XAtghMR1CcenKk9WEyuScJ5oVpZ8uTT2m235UMiiU38k?=
 =?us-ascii?Q?bpFsaCHeMA+yHHp/psAXMf/QdM47nH0pnPEZn88C2Ph2EdAwN/arKzc+DTSl?=
 =?us-ascii?Q?yjodVV+ju7yZEwjev+HaND1Nm6aPnCFJQU6QxgiBuI1GvkQ1RNZQC2myb4+Y?=
 =?us-ascii?Q?8tUoN0g/Gr5fD+ALSwJ9EVf3S2Xxyko5qpDqJMSbCZRm4cAOBxLlfUUH3ZYU?=
 =?us-ascii?Q?9hiShhZrc0spflKUSVeV1PQi+b148ODjgWF2XmH/9E2D0UIVsxCuj6a0OCmj?=
 =?us-ascii?Q?FrHXQl/6YQ2pOKI0ifn2ZkPpS1sWwWkvOv1CnXiSPTHo6H4ee2R5fivWVVPy?=
 =?us-ascii?Q?pYdQqbpFe5EZqF50Yv/3RhPxeLkHKd2oNnk5cmHo6xgRjxSNxEKXgNTKzAKv?=
 =?us-ascii?Q?qtDvnB+fVoOMQz7S8IG/sqbsHTp40lV26wZ8gM33uo3WJJY+sVy3HXmUDGC7?=
 =?us-ascii?Q?WAdC30I8Zf7V8KHBSRLmuSzCDIwzPkW0faWHFKkhUmoKq8yf2CPucF63zr7+?=
 =?us-ascii?Q?gu9tXT2f4vA5YTMWc7xPTIgSgJIOSc1/hwxUBauYyqh7TeNUbd1YtNHIriml?=
 =?us-ascii?Q?jpaQ+ObzqIMSm4S1rYZ4Kwp230P+33bt7z/LSm+FpwLAkZpXdcRjKmiQhE7Q?=
 =?us-ascii?Q?3rndmKm+7NMvSZeT8irwtcamLIUhKSFhmWSs44hyFTVnRThjtkEREl24kcGm?=
 =?us-ascii?Q?1R8rHafH1WDW9vFJWcEd9kwQDmEMtkNIwK49Ol3moM/UFLGvmmVcM2AHii9o?=
 =?us-ascii?Q?fASR2mX3LzWmMu9Afpg+P4/A2G9eontnzH39UxNcKjBBCQMwoJtKRgjI32Y8?=
 =?us-ascii?Q?A3fGT84gkJf6rE6J/bGDbEPnHkVmUm4zoa5yRxECip+HgtarLG5kZDaSBl9O?=
 =?us-ascii?Q?JyIsYasUFz3MxQ9TbFHs6OJXr2T12SV7xm9YeWT9+T33jHODUdpBRcI4jxiB?=
 =?us-ascii?Q?accHu5y5zIz6UJhCVYaYc1vumpJ+GE2bT3PHoq0yi0a+W+YbpIXNaIu1vLN0?=
 =?us-ascii?Q?uPzTjJEu/nijQPs48MEGklwQINxRRWzmY8n3IPCS+ny4c0yNO+DFbi0cJwm9?=
 =?us-ascii?Q?rXJS8Nz2GeRKeFILzkz5l06BW4Jch0ujbQ79DuzF/bRKTrBovTCAvp2yp5mS?=
 =?us-ascii?Q?+H0up4boTmC175ifBAuE6DfODYiYx6XEPUe0t5eiUPPy/8eoVpyec1MHwkOD?=
 =?us-ascii?Q?Q/FvPrm/Whx3oDhOQ+JRmKe0ruGAra0bj6h8wwD1gkmwghQPqGKkbu+Y5g+Z?=
 =?us-ascii?Q?CqQWc33Jw0iv6853Dwdl/+tWX/3yqgmGfm79kUCfGg8bXiot+TwXlwznlhIV?=
 =?us-ascii?Q?3PeSYwlrncQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0DRsl/BkHK2y6yHATI4YCN5UpjVcUpYkhEw6zK4jgz10/7e5NY0iIuTwliB?=
 =?us-ascii?Q?l1JGVXHrbAYVts0ETjWnibFa+2xyzaPoRqGm3kUI/HR6p68obCFLQ0c0GFsh?=
 =?us-ascii?Q?WQ/H4cY0lnLrRDaQFStTCOJGsZhRxfIvJ9BhGrjqR5ZGlFBLSnt1brkQFpoB?=
 =?us-ascii?Q?gCC497IxFUJG1K8fYPPSml+Sqdv8vmH2ICwdMmZpt+arso3TumUwm2pfufkT?=
 =?us-ascii?Q?ptL3CCeV6SGpTj79T9tMNQ+vNCoSa0sNXAUzpcA/FCBOu7TbP1Yn+VxUqZrU?=
 =?us-ascii?Q?x9CFotyr5g8uWtkQoYMRDf3jBj1szG4TTLqqkGAfl6QiARqh3BnkaV/ZqJNz?=
 =?us-ascii?Q?vRN+foLFmvIsBiU7eziZWGbiHm8g8MgTmxCG1lvU/oirowaWIC4sPbrbk68k?=
 =?us-ascii?Q?B9V13rgHV8gH/CkhEadAcSBdzYbCeEC5Obx0ijM7nkYsI2tuw7BCKPg+i7cd?=
 =?us-ascii?Q?FeKHX+89k/x3wQg4qBqftBOwZOF32J21EN0ifrQyL7V49RVLoEGp6OdeahKs?=
 =?us-ascii?Q?rtXKSjri/Mm0oZ7ENLpN4BCa8S5WRP5Vg/L67LwqoEInDfOH+mJe/Ez0I6RL?=
 =?us-ascii?Q?YjYnYShbLsqtpF2uE0XAk3CoVyZzBRt+SZgh2BNZqk/HKg+2jV9K8ip67GcJ?=
 =?us-ascii?Q?AeWcMQ2g3Lhz4oVr/bTaMAEGRBpVRgxof6Zt3AFD762es7y/WIrVIF+pTklJ?=
 =?us-ascii?Q?7vdr9PVZrZvfuwXBWBPrZ3piNe5MI0AkkIX2ICf/zTrMjeVtf/bG9Hotuko/?=
 =?us-ascii?Q?IUZGnl//8HY9KdnD7ffi9CSVdBnJ0k5Miot8PShZJFHDNaAvtAWTrPlivmQy?=
 =?us-ascii?Q?0rQvFAbAq9jI08grRkPFFQxJWdIHvKVTu/wZy8xxaq6SGdCnzu/SVlOEFdto?=
 =?us-ascii?Q?zWc6B8khps+9ZyiWgnvfqDzWzst4tr32EDRzu9asVtmPm1jC+6nHCcHd6lEn?=
 =?us-ascii?Q?LaEjsGICGg6bFYW7xl2r4LqfObhWK6IsPizcK95cUPj0ClOldxro35IkzOMz?=
 =?us-ascii?Q?kqiz3627Qnzt17aZgtmqUg+/6JMnJtLQM/f+iPtaIaURzM8a8ZiLFQ84UYYP?=
 =?us-ascii?Q?fwT/+FfBHbi4ahu+H8bmxZCwaK2Bprt/QS80Z/HCcaymL2/1teQ+b7zKid5w?=
 =?us-ascii?Q?Pdi+lHfCRfYEwIf5+Ex9cxakqa4mnrbE2j20dqqPj4Kh5ah3eAWDwS84G+DP?=
 =?us-ascii?Q?fmnrg9emhapDbcR0lqBW9ea2Ut1MSV3ceeUv2+umyvIgTJBJSbRhpzAlo8J+?=
 =?us-ascii?Q?iOTrkRDvK3juFaJQJynYq1dCPvwBXBQeIavYBUEM3bNZlCwXk6dE/qeO6KJ1?=
 =?us-ascii?Q?oqHjJ0XrzRTJCWRDqAbKEFvrqsYx3DolV1iEccVCpnnkcGrCvUzXpPEq7/bN?=
 =?us-ascii?Q?UfBX+b8Wd0vUeNAkHDypslkEs0VThGFqjYSHRDm7RL2F6HcfE18i1zeHooN/?=
 =?us-ascii?Q?KZbBXUDSb0SAAa908SvNjuIMagqOHQ5uUQYBrZIy5O3oe1bNcljWLS8FQSKd?=
 =?us-ascii?Q?LxpyNfl80A2ckTRhIvaBecxbPPVC924s6AcghbKgkisxn7pLlMd8Gz/tsj/5?=
 =?us-ascii?Q?ZN9xzRivMqg6eCvR+UlHrGQRzuiwkr1r/4pc/fN7WQXUH21nsAiDqcS8ZaHk?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e33ddbe-84b1-41b8-aa18-08dd8e5d0d17
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 18:20:46.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiQC/Vb1ErCVl6C8U+oHFyfxgSQl2QbyI+JPaUT/aoFq4TU5mjg2tT4zNbPM1RrlFp4Rt4k2Ly9aoFcPfxTohnnq39npWus9LA9THD9vfuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:22PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  include/cxl/cxl.h         |  3 ++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f55fb253ecde..cec168a26efb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3649,12 +3649,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * @cxlrd: root decoder to allocate HPA
>   * @cxled: endpoint decoder with reserved DPA capacity
>   * @ways: interleave ways required
> + * @no_dax: if true no DAX device should be created

I'll suggest avoiding the double negative on no_dax and name this
variable based on what can happen, not what must be prevented.

Something like: dax_allowed or allow_dax or dax_ok


snip


> 

