Return-Path: <netdev+bounces-188847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD34AAF0F0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34B64E58D8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88A137923;
	Thu,  8 May 2025 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lhwq/XLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A95CB8;
	Thu,  8 May 2025 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746669689; cv=fail; b=rZrF8BqerQVJPR4U0ezQwiEMGgWellXty4ZhXi5sjqXw6Jes/+qQGMF5HHKHfb8dvwFTmZiWYQaNBaiOFb3Lqj3l6HK6Lbk2QPUmNzkKzgTYj+QONDIfAiY03nEXz1ja+zysr7yVJNfTMhOQL6gzgl+/dBiQn52iphNm+L+YJeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746669689; c=relaxed/simple;
	bh=x4EeCfzqZERICwQ1DbrEVr7L99qV4xtNimZJXEV5YHg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryP7zTaXAhXvLCg6njFdFriocuhkPCwCyLwhiPe8bK79CXd/9AHtmEylMRL+qDuKHwFT7OoGlmOss5HhETXDcJzmKgDKbm/leNqeNm0VMMRg9ZqoFSVfWejSKCgf/RkFvRgJDWhDs7K5N4DOM53qUXI9dgKuuTkjXw/neGXADRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lhwq/XLQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746669688; x=1778205688;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x4EeCfzqZERICwQ1DbrEVr7L99qV4xtNimZJXEV5YHg=;
  b=Lhwq/XLQl5gBea1VJFrMTJmCgezk3bie85JDegJCoQkU3qvOyzks+JI7
   n5jAHT9USTvqAZcJto+zsw4LEPgkTsiBSz7dIpeYaCmilhBFfpl05EP/o
   ktJSCleNZ7s+TEVSP5BLe3nnrsvu0MuNHHjFhMZqFixqq38QdP3QE8wKO
   eV3W+7KC0PYZl2ult/CE6oR/R1svOA4lcxGlDe6/ydazAyZ0rfypmrxPh
   fekzOLfEi/pBQXA2uNnVxgSQLLe6DthMUUGp18poDla2rlQn6d2KPIkiM
   lsY1k3e69oYk3SNGgjyeyrpL/Ane/Yu2OvFFMVdk4hWPD++PHxtgHfXCY
   w==;
X-CSE-ConnectionGUID: cZOhizrARxi1pxrjX44m5A==
X-CSE-MsgGUID: W//A3776TJm/WKWDo0/I6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59091853"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59091853"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:01:27 -0700
X-CSE-ConnectionGUID: VvrbDFfOSbqHyq8F+2x+pg==
X-CSE-MsgGUID: WV0ZDZE2SBqMl52qVOcwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="140181558"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:00:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 19:00:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 19:00:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 19:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE6g3j+0jw8dfGI35d3VqdRDpOjb1X9AUbrXy9I9nSvQ4HNz/dgzrV0HxvB4ZRjd46CZ9bjdXvRfkeEpWvmi/tIDyJ2B/M9YqIsUbj+NjQXFvtPXTD1//xrNU6X267I8F/Ffp9UslzEs28I/jpusXuuBfv/ensFPeBO+WiFs6Yyow7uJkqTvmI7+lPXNBYE96WjpBzk3kpmoFEBF3PM3G1HziRKSZssDzBUeRwUGUqIojt13sCMy9LG6vlNM/NZaw4fnA3SSa4pAbXkxvwz1Hm38REPkLrWAovLnvGwtLTiQHvX5qBFOdzAErepKEADTSfoUFngP52AvuPk4atzlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ6oIl5+33gqhoOFeR8cp+Y820Q9txjLQFVbycNG12M=;
 b=nGsfZtykP9Rdr+hzlj8G/lBB7xOX+gpu89srv5UG7KWrYfbNTEnAmLlzqcMhgzOxKng4VKSOFn1om5Rg+PN4NZn76eRwpEuvcpDUhRuNP4vnH/qphnMqwJegmRh84txnMHCeJ6um4+YqWihNfePQLXIw8pDzzvffScDcNETfjY9FlKX6xaTXzgjEgaRTW9kKbIhMmt9LOLVaPsrAwxwGnPYBUd9U6/V5feEVwFSHm5ATRT7rhivhgua5UtBCZldmJz54UmgxRMSiuUcKe/wK0lWe1fyx5elyPSUBLRKg0q6X2MlvE4C1TlWYslbIu0H1xWeJRZrZm5WcVHY92oMCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 8 May
 2025 02:00:02 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 02:00:02 +0000
Date: Wed, 7 May 2025 18:59:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v14 00/22] Type2 device basic support
Message-ID: <aBwQGNx4uK0f9aCS@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0288.namprd04.prod.outlook.com
 (2603:10b6:303:89::23) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 5782943b-8010-4c31-2678-08dd8dd40b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?f0j6Mel/Z4NYYrDGGgpI5qG7dZCeOluFzpdJS/OxYvI20OOQzxfvDz/bkP?=
 =?iso-8859-1?Q?ZvmynGe6jR2HxrB06CGN6fFiZ5S19wrqbPXxL4nVIK4dZ3JHjy4Nnoxoby?=
 =?iso-8859-1?Q?BDmP3WNK08xf8lOtvchmOkYZMnvoXo25ri4r2OqEZV42sDmZUHOucMC0Ur?=
 =?iso-8859-1?Q?PpdQBGF9xZlNRV0d2BJtywwbNyTkwWGUlC330nrq3wvQ6/o5M8pZNOBduE?=
 =?iso-8859-1?Q?us5KxSR7mLpuEb00YuQcGDajmYucXaEcHrDlvYUNSZjJEaaWwo7A1dCBX0?=
 =?iso-8859-1?Q?PomjqQai8aZ+0UA4zZSFAgZk0TmO8nOomAyTDjWUQAxMsrnW6ewBVFkWfE?=
 =?iso-8859-1?Q?Mve3lO/OJvzOmZEdiyArDWse0vYxTIhOxSuHx7do8pkoE0vF7YZfxEmPee?=
 =?iso-8859-1?Q?URXfZoGmvsHkh3c+OZiUMdX9MHnm0/tn7OgfMMMzHUMgPQK9umOxKloYfu?=
 =?iso-8859-1?Q?TDkjUqAfXkTR8bq8InzYvkhxWYHH1+MFnJfYU9+zX9aeWIAEbJvQSv+UZD?=
 =?iso-8859-1?Q?Pp/6A0r0FhtVZcKorWIn6ncwZ61MGr+z75DwNIxWvnGXzBh90Rc+eyzbqO?=
 =?iso-8859-1?Q?z2SvW5Sp+wd4ru5Bqd8GinZ49WDzFHhAYpM0auDlGM8L/B0qvzEqjExh6s?=
 =?iso-8859-1?Q?gfzYXOAvgdYpJt+kjR7xLwYG1q91KXLez0LpdirY6Nyn7naRJb8p1ksTv+?=
 =?iso-8859-1?Q?jEVB2VOeZe7ae8XHiC41YjJ0EY7CiJKqImv9jSLH1LuK3FS5Vhbgb6HO4T?=
 =?iso-8859-1?Q?wbPXuQcdPHaySFHqZHAxrkRk7qWxfBTAPbvcOGbUXjoSSM22MCcA7waZxz?=
 =?iso-8859-1?Q?G2PiMRyi2MlwHAkxwGNzOFIOt+VPJUvLmKNrVscMo3dfwDrl91RgnafnLH?=
 =?iso-8859-1?Q?Fxs2uJqx3sd2AZIR3XKcBuZPerGwvL80PcxgmpcxwRJ+Tk9lt8ynbkTWP1?=
 =?iso-8859-1?Q?kSizEHTaZK6QQX6xV9tlemCaDZI0SIsrekbGCBKpuysLs2EHUFN5Glufz5?=
 =?iso-8859-1?Q?DwB/k+AUYbHsqalTJuiu5s74WlKdZ5VpCCIRG6iCrd+LrR+pNDIBsIfIdZ?=
 =?iso-8859-1?Q?gIXWM2PKeCjag9GDHGsSX48HIxQ1VO+OC1KQ+LK+6HTYJ3Hn1698DDOLmj?=
 =?iso-8859-1?Q?G2pgYRTAzJpWU5yjYkcQSq8CyIA5ATqqyhGKk7aYQM86xxtfbrkD0r7O0S?=
 =?iso-8859-1?Q?qScRaL+/l/VpgPhRrRS24fskFW1PjQ6yrEWb+/VQFSrmxsHBOvkqGEkXIs?=
 =?iso-8859-1?Q?xstB97Z/XBuuHIwt30OAzEu2J9TxuMLU4qQdNg3uCZnNYe4Y8VAmmVkySP?=
 =?iso-8859-1?Q?+HlC0mJxbL9DHtb+Ah7hJHrgsTHWeT4UMgwlgxKj8nYmv3SiZHXPY5T0HN?=
 =?iso-8859-1?Q?HULgFtoMe8mkdskAwJaZbdEkcEaTug7QgjAAdkAOfXvmhwHReRjBcxBEMb?=
 =?iso-8859-1?Q?AWTg7SgobQ2IKDrQ9HP4qIfYlrqHRL2k9sw6XiPOKPpDx/dsolM+flczC0?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WYbeBwxLAqZZTsC443zCvBZoItOpHF7n7gDD1kRB8XoqqZh0hB82I7BIYs?=
 =?iso-8859-1?Q?UNjVyyAVPQkQ/RSTtxTR+ADAQiJPOrfKSeCRSC2Sp9u7fAC87e/1bMbLTk?=
 =?iso-8859-1?Q?ICmW6NX9HaTzFi2lhGnTVdONfBSYBcdrgMS4bC3hgiNCchxMLdj6ElNCPr?=
 =?iso-8859-1?Q?Uv3OSJap9YjKWYXYS6isqHV/qBm4upHhdmhXFkkwgv0p3qow30Il/OXHdd?=
 =?iso-8859-1?Q?DAzxijzdCwF5E/DAtQKWZo8zsbDQ0CUYbEj5Ez6FTmgXrp6LCIxgDWRLtk?=
 =?iso-8859-1?Q?LsKmmcpeTRNSetx7nDEr0H1qS4sP58RmoezeMuYz+enQTIRXWThOYBZVIj?=
 =?iso-8859-1?Q?lWkRv5GHZ20wcTOJ5Msf56623xP8RxWDQUgyJ58Uv6GBSTulizDBCoNMz8?=
 =?iso-8859-1?Q?zz/MFO/TKAEr6Y5IHq61zgaWKy4SeHmRdIklc2hcuPnL2O0JT46CYe8NkX?=
 =?iso-8859-1?Q?eZ9aYSCObl/+slosfhb0MKhEbzA9+4Z0BrKYSrlYPHuGKnFLJFeJ6wC9qQ?=
 =?iso-8859-1?Q?E9WJKIUVNCoyGrec8GS69xah03b0/15UhJ6WrJH2Mx9vT7phloiGT3Y8mO?=
 =?iso-8859-1?Q?01j14cN3T36QKq7+w37O8qDqjWspmn5dU2krUV0CGmCeQLr5W/OetE+5EH?=
 =?iso-8859-1?Q?5jAp3G357m/VA+wdZi1n1dpJBb8Uw1ZkqlTNzS2SAoAd2pA5ECb4efXmsk?=
 =?iso-8859-1?Q?bI1yyuHCwTsGFrQIce/Rc+aIlMpI9J/DaYdAGdCX04OrsPOnyVtREeBUD7?=
 =?iso-8859-1?Q?KGsXnp1FQqKS55Wrlpk425YIuhpHnjZJcl2eZudO07818+ikFmUpQVjtA5?=
 =?iso-8859-1?Q?zyDA5i+X5Vm0/1JrdhV5DbyuQT27iDqjbZcJYX+xgLfZfGDXPq/RO97lfc?=
 =?iso-8859-1?Q?LmfOJ2A+QuTGUoriAXgFgUygpi8GshQR3w6qsZAFdU0f1jjFQRLeQw7Bn0?=
 =?iso-8859-1?Q?RiEMlGJikvu+5bI+fQqetxXPParF9XB9Y4MX/bS8rpbU4N1v1phXpSULbH?=
 =?iso-8859-1?Q?xlqE8NndjDj6Lctk6NN820Aqk7ykT+PU3Mvk3NMAARABgJeDWO84lqK/b+?=
 =?iso-8859-1?Q?ZUSeMlVenl7zr1iI/h3JMCa/PtXOWNlptKYwzJKTb8OvlxCJaRyTAKbDJ9?=
 =?iso-8859-1?Q?Si3Zci7460UYQBf1DcJVby6BpMd1JM9LY2thz9cPoegyJKOs1AqwFyJcyD?=
 =?iso-8859-1?Q?mmWNqZy058iXR62R+2RfFbOoqXwf36uMdRAJ0+XAC1MKf2+4tpQJaAJyUp?=
 =?iso-8859-1?Q?mqVGGtEILDooMOELEWfBGvA8XID7fWJHFfQaL2r1MU6wN/LyeBsGQjhWeb?=
 =?iso-8859-1?Q?ylt/l0LCY9Iw4Cpq5pRia11NYg1mHPc8FSrXtWfxVfyFMXtmPNR5fI8tDL?=
 =?iso-8859-1?Q?j1JJiCPcsHQ9YMPRZC7DXJXGblBIgTEh23HxzazznFKPD27BmI0TghIaN7?=
 =?iso-8859-1?Q?Tip7U1XWmhCZc8exW8ErkUOZDQ2u5Z+feyuyRHnIQIphwrj1NdxWs5FTrC?=
 =?iso-8859-1?Q?INKqj7kD3IHGfuwmX93HrVT83r7RS+TAAr1xVJycZI7A4Nv5uZH548YCcB?=
 =?iso-8859-1?Q?VB13lPm9c50d/lCGKkXxeoHjUiG/ST59qzpdnZYMuidX2CMB1h/267f0v2?=
 =?iso-8859-1?Q?/rtxS9r1vMuFLb7RY7SyeusBro0R7GGSw7ddFkY3z9ulxs/PULkHkYHw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5782943b-8010-4c31-2678-08dd8dd40b2f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 02:00:01.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgoTaYDethEE1UZxf8hrl9a310C+2PTq7835CRQkFeFLzCRGarHF88cwvRi4lLb0K8g0k7nct6IZOzK6ZwA6rtnkKsEeFsyGC17zIc3yrC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:03PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> v14 changes:
>  - static null initialization of bitmaps (Jonathan Cameron)
>  - Fixing cxl tests (Alison Schofield)
>  - Fixing robot compilation problems
> 
>   Patches changed (minor): 1, 4, 6, 13
> 
> v13 changes:
>  - using names for headers checking more consistent (Jonathan Cameron)
>  - using helper for caps bit setting (Jonathan Cameron)
>  - provide generic function for reporting missing capabilities (Jonathan Cameron)
>  - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
>  - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
>  - avoiding rc variable when possible (Jonathan Cameron)
>  - fix spelling (Simon Horman)
>  - use scoped_guard (Dave Jiang)
>  - use enum instead of bool (Dave Jiang)
>  - dropping patch with hardware symbols
>  
> v12 changes:
>  - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
>  - add public/private sections in now exported cxl_dev_state struct (Ben
>    Cheatham)
>  - fix cxl/pci.h regarding file name for checking if defined
>  - Clarify capabilities found vs expected in error message. (Ben
>    Cheatham)
>  - Clarify new CXL_DECODER_F flag (Ben Cheatham)
>  - Fix changes about cxl memdev creation support moving code to the
>    proper patch. (Ben Cheatham)
>  - Avoid debug and function duplications (Ben Cheatham)
>  - Fix robot compilation error reported by Simon Horman as well.
>  - Add doc about new param in clx_create_region (Simon Horman).
> 
> v11 changes:
>  - Dropping the use of cxl_memdev_state and going back to using
>    cxl_dev_state.
>  - Using a helper for an accel driver to allocate its own cxl-related
>    struct embedding cxl_dev_state.
>  - Exporting the required structs in include/cxl/cxl.h for an accel
>    driver being able to know the cxl_dev_state size required in the
>    previously mentioned helper for allocation.
>  - Avoid using any struct for dpa initialization by the accel driver
>    adding a specific function for creating dpa partitions by accel
>    drivers without a mailbox.
> 
> v10 changes:
>  - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
>    memory after all and facilitates the setup.
>  - Adapt core for using cxl_memdev_state allowing accel drivers to work
>    with them without further awareness of internal cxl structs.
>  - Using last DPA changes for creating DPA partitions with accel driver
>    hardcoding mds values when no mailbox.
>  - capabilities not a new field but built up when current register maps
>    is performed and returned to the caller for checking.
>  - HPA free space supporting interleaving.
>  - DPA free space droping max-min for a simple alloc size.
> 
> v9 changes:
>  - adding forward definitions (Jonathan Cameron)
>  - using set_bit instead of bitmap_set (Jonathan Cameron)
>  - fix rebase problem (Jonathan Cameron)
>  - Improve error path (Jonathan Cameron)
>  - fix build problems with cxl region dependency (robot)
>  - fix error path (Simon Horman)
> 
> v8 changes:
>  - Change error path labeling inside sfc cxl code (Edward Cree)
>  - Properly handling checks and error in sfc cxl code (Simon Horman)
>  - Fix bug when checking resource_size (Simon Horman)
>  - Avoid bisect problems reordering patches (Edward Cree)
>  - Fix buffer allocation size in sfc (Simon Horman)
> 
> v7 changes:
> 
>  - fixing kernel test robot complains
>  - fix type with Type3 mandatory capabilities (Zhi Wang)
>  - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
>  - add sanity check when dealing with resources arithmetics (Fan Ni)
>  - fix typos and blank lines (Fan Ni)
>  - keep previous log errors/warnings in sfc driver (Martin Habets)
>  - add WARN_ON_ONCE if region given is NULL
> 
> v6 changes:
> 
>  - update sfc mcdi_pcol.h with full hardware changes most not related to 
>    this patchset. This is an automatic file created from hardware design
>    changes and not touched by software. It is updated from time to time
>    and it required update for the sfc driver CXL support.
>  - remove CXL capabilities definitions not used by the patchset or
>    previous kernel code. (Dave Jiang, Jonathan Cameron)
>  - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
>  - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
>  - Fix construct_region use of rwsem (Zhi Wang)
>  - Obtain region range instead of region params (Allison Schofield, Dave
>    Jiang)
> 
> v5 changes:
> 
>  - Fix SFC configuration based on kernel CXL configuration
>  - Add subset check for capabilities.
>  - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
>    Cheatham)
>  - Add option for creating dax region based on driver decission (Ben
>    Cheatham)
>  - Using sfc probe_data struct for keeping sfc cxl data
> 
> v4 changes:
>   
>  - Use bitmap for capabilities new field (Jonathan Cameron)
> 
>  - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
> 
>  - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)
> 
>  - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)
> 
>  - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
>    MODULE_SOFTDEP instead.
> 
> v3 changes:
> 
>  - cxl_dev_state not defined as opaque but only manipulated by accel drivers
>    through accessors.
> 
>  - accessors names not identified as only for accel drivers.
> 
>  - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
>    (drivers/cxl/core/pci.c).
> 
>  - capabilities field from u8 to u32 and initialised by CXL regs discovering
>    code.
> 
>  - add capabilities check and removing current check by CXL regs discovering
>    code.
> 
>  - Not fail if CXL Device Registers not found. Not mandatory for Type2.
> 
>  - add timeout in acquire_endpoint for solving a race with the endpoint port
>    creation.
> 
>  - handle EPROBE_DEFER by sfc driver.
> 
>  - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
> 
>  - factoring out interleave ways and granularity helpers from type2 region
>    creation patch.
> 
>  - restricting region_creation for type2 to one endpoint decoder.
> 
>  - add accessor for release_resource.
> 
>  - handle errors and errors messages properly.
> 
> 
> v2 changes:
> 
> I have removed the introduction about the concerns with BIOS/UEFI after the
> discussion leading to confirm the need of the functionality implemented, at
> least is some scenarios.
> 
> There are two main changes from the RFC:
> 
> 1) Following concerns about drivers using CXL core without restrictions, the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
> 
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.
> 
> 
> 
> RFC:
> 
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
> expanders. Type2 CXL devices, aka device accelerators, share some functionalities
> but require some special handling.
> 
> First of all, Type2 are by definition specific to drivers doing something and not just
> a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI driver
> as for memory expanders. Most of such setup needs to use current CXL core code
> and therefore needs to be accessible to those vendor drivers. This is accomplished
> exporting opaque CXL structs and adding and exporting functions for working with
> those structs indirectly.
> 
> Some of the patches are based on a patchset sent by Dan Williams [1] which was just
> partially integrated, most related to making things ready for Type2 but none
> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
> signing as co-developer, and a link to the original patch.
> 
> A final note about CXL.cache is needed. This patchset does not cover it at all,
> although the emulated Type2 device advertises it. From the kernel point of view
> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
> device needs. A device accelerator will likely be connected to a Root Switch,
> but other configurations can not be discarded. Therefore the kernel will need to
> check not just HPA, DPA, interleave and granularity, but also the available
> CXL.cache support and resources in each switch in the CXL path to the Type2
> device. I expect to contribute to this support in the following months, and
> it would be good to discuss about it when possible.
> 
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/


Hi Alejandro,

I commented on a few things in the individual patches and had a couple
of series wide comments that I'll share here.

I came into this set with the expectation that it was a model for Type 2
device support and I expect it is, but without the summary I was hoping
for. As I review the patches I can pick this stuff out, but would have
appreciated each patch commit message stating its purpose more clearly.
We get so use to reading this as a patchset, ie a short story, but once
this set merges, the patches all must stand on their own, so including as
much story in each commit message is needed. At the minimum, every patch to
drivers/cxl/ in this set should explicitly state that this is being done in
support of, or in preparation for, Type 2.

I sorted the set into 3 buckets as I read.

1)These are the changes made to existing paths in the CXL driver to enable
  Type 2. These change the existing driver behavior.

2)These are the patches that add new functionality to the CXL driver,
  that is only exported for use by the Type 2 driver. These new
  functions are not used in drivers/cxl/.

3)The sfx driver code. (which I glanced at)

I'm wondering if bucket #2 is something to be documented in the
Documentation/driver-api/cxl/. 

Other general comments:

- Consider each drivers/cxl/ function exported for use in sfc for a kernel
  doc comment if not already present.

- Some of the added Kernel-doc headers are missing  a Return: field

- "Printing numbers in parentheses (%d) adds no value and should be avoided."
   See: Documentation/process/coding-style.rst.

- Follow cxl conventions. Commit messages in drivers/cxl begine w uppercase


-- Alison

> 

