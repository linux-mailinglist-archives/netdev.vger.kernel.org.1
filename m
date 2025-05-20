Return-Path: <netdev+bounces-191703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF55ABCD48
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9401D18947AB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9F19EEBF;
	Tue, 20 May 2025 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fw5W+9FI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945520B1FC;
	Tue, 20 May 2025 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708644; cv=fail; b=TDFnFJSplNPYRl0iLdX4AIwXsaPoIF06+yrXK8EQxFmCXTeCXgk45iiOo1gt7VwJQYM6eHrlDlNQi4D9Zm3FaQRM3gf2vgAYRJLRTif9jes5ZWGv/eG+wKnWAaMkLQSnNu4VfAc+Fk6CKHA8Ar6zcOFGiRPueHyAuOXwkx+JdN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708644; c=relaxed/simple;
	bh=CaJfXU+pcnAvP3U9Z436GW+egZbRX7dA1cms3y9F0mg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qFjyZ6WzCGifNwg26OJnHMsdDHOIiUM76mSzvb5I0wSI25qvJs6xmrZvLbRvmw27Imf80lKIqPUdCdmUssFXhNDP6tlgmBp991RFlt++QgODp6M/25uQTa0yf6hZhl6iKdk8I0smtO3VWEXIN9lkPQLL7VKN81AiXwtUarFd45Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fw5W+9FI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708643; x=1779244643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CaJfXU+pcnAvP3U9Z436GW+egZbRX7dA1cms3y9F0mg=;
  b=Fw5W+9FIKwhqzREHJXnE4RQ3k7iAevaLEEU221pB+3qZwc9HJulxquCK
   PkMAWwT5aAw6p50pVGtqrLKPepBIFoBfzPdCSCma3ILiCyxOvqGvWqAu7
   i7AiIxhZxo2UWBfwD5mWojeTCe2Qdt5LdWRjn3BebGu3dlg8TQnoB1uFs
   zDZus+tSVAIMoLpjuJJPRA9MIayrdmyD88HQ/Kolsyft+vqXsKtAui0Jq
   9AkGR3B5B7KzfgGAwav7vpKiAUrUOP+XbZd9DFc8ykPOFZ/AZoEpz6Urw
   QAUdPPZk6SlgC9kzjkQnNg6yPrZQ3lRyaj6QaA/AkWGrTB3efVLLa7/Db
   g==;
X-CSE-ConnectionGUID: 1QCJl5F2R5CZCNSlODTgEA==
X-CSE-MsgGUID: gyVu/ACBQHGUSZg8SAT5kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49608877"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49608877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:37:22 -0700
X-CSE-ConnectionGUID: irErniW2Tc22/8cX7EkISw==
X-CSE-MsgGUID: ISWvYM/RR+SGvbPwL6Vl0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144668545"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:37:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:37:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:37:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U12PI3UEaun7mLYJN4QdWvrzeCq6sh9fUsD/fFOeHGBaR1PNaXFEqPHQp7Se09nzSQ9RTptoCYSJlB8oUiyK0Cv47nwiSZ0ZOsLOqIuxmBq1F2Hx6zhIe0WT14tMN0US9qXjJHHyXb5kKUh+XmsRA9U1IDT9VRAT4TBv0x7CMM072PMYR2cYNWSLVd3wRcqz2pIAYR1c/dpAHwtYR6jjXWvlxXjcCj61FitzKXR0tp6Rf0sTh13/xCvPzmuFKc6etsHefGQl2VcrAS7FTxFVKFFykjes1aLXgeQFW644UhCxHVEmtMEqVI19Po6qEARKQToCWE5r/OcF5S5VReG7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ25ZwXPKUFuBOtJPHLdS+U4inqYCHqGO1ifs48V5ag=;
 b=NBYj/rOShMmtwKcQjqBENZ2Dh5kDHU4tKgQpjSZZ0DZVAvj5PlHtMg5I55JrFO1KRJiBdlDSs0IgmCkZHMUZPxtbjcl1e/Z5I1N8R1bTdR5eD899OAdm6OV0f8kAMwVpkgkzrM/mwZPGpuo11LCnYm1OShv965rfDE3JHRQTszYMQ5cOcC4fXZJD9HTm7qtEJPtuQ+iRoDbKkwPFQ3U7TmvBGnYfdTWwCG76OjqVBWFPv/CFqISrRh+IZ1cniUbj5hYGN1/NRXOkftYwWFkTol2vZScCE6FvJDIu2akNtCEX12D1y1J2pTkSWIcXVn23nE/rIaleheryXMwlqddGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:37:13 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:37:13 +0000
Date: Mon, 19 May 2025 19:37:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 18/22] cxl: Allow region creation by type2 drivers
Message-ID: <aCvq1Bob6Uz-vZqk@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-19-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf5ab5c-5af6-486d-fdf7-08dd974739cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VdzlgBgscB+w/+vY4fjR0HpTf+/X2Z760WWPdcVKDo1WHRDxIk3kGGz/QFmr?=
 =?us-ascii?Q?L9POvSs0iGxuKW3YwbuY5bkcsk61V1obehn0wQAO+vTVk7gGfDg/aaYLszQ+?=
 =?us-ascii?Q?FWrdyNqtzmaOvLHzLgkfIVbLbVKT32M9RHtDrp64fxFYlMKOBT8W7O51r7pN?=
 =?us-ascii?Q?Wjq+nY4oWkPBzniwqbIjZ5H3BBRkfk9XRrMzpmCChe1bbVCvK62kiLufmXZ/?=
 =?us-ascii?Q?CCLl6zKKZGE4JWN0+NFn97ToRx5Ekn6A3B7volm7iq2UNrtJcTPe/SQAzuhq?=
 =?us-ascii?Q?EgjHXTVrHBKTBlu06TPEdW16vf5LzR3WmDLiR++B+ddE6Aem2g+Q0BJgO3gD?=
 =?us-ascii?Q?uGf5V1xRshvmmCT+Tw/Rvc/onG2iIAC7UTLNzR9Qisbk4Ph7Q0OOs31SzlJe?=
 =?us-ascii?Q?ZRb8cppSFJXg0ttKufWwyiW5QMhY05DXJVmPtyfTGn7Ne0hOllNR0/EBNAtx?=
 =?us-ascii?Q?mV7oufXxawswPMbJdM4ae3zHM4t/TUSJwEgpzKzzu96PXO5bU++QRR1T+6kz?=
 =?us-ascii?Q?x2cQKTR+Pen00tW6mQ6K/fm/eDrNgpBuesad4/L4SJFaaGULR2yco7TpA6lz?=
 =?us-ascii?Q?Q9HYUwClbdO4JDqUXNo91wGKMx43AEOudrQK3vJSaQWEYEgXMavgnabQeCzv?=
 =?us-ascii?Q?Uu8eSEX7fmXAgck2fP2ol2R2eYDCqUN86fOaxayvDjTdWTEpQIHdP0E6huyu?=
 =?us-ascii?Q?zCQVfi0EZW01e4N52s4Vmyv4FJqZOCpzUMqQzT1HrVhxb/9o2A3rJ6pwbXvg?=
 =?us-ascii?Q?QVk4QaBGQUH68W0zad+ZJ4hRlBf1ZRS3y+sxD/R1ijFCY+ibBlOHEh4KMipm?=
 =?us-ascii?Q?7mTFlCGtGBaQeCBP3E5y1jTG8CyU5KLp9lvJNQTgxJsR1XFpI+5w3fnjIhcL?=
 =?us-ascii?Q?xTnbMUpbOlK4HMCcf4lPiBv8q2AfYQd60AyLU5PfTPziP/4/PCEyzOW5AAce?=
 =?us-ascii?Q?IqxOd5UVpHNjkrxemtCnbiidhJ02bu/PpTKS7oYjrNfC5Shiuw61AhcMufGG?=
 =?us-ascii?Q?QupFoot94ZrxhjArJp6bSaabQtC34Ac9wNFCeOfmWJgwUHWzOVY0lKBwxrQJ?=
 =?us-ascii?Q?L/7uu7Kw2QuUnTT4u3bkzjKJuG08aiiDKCDoGkuOuhwO+jSlPYSnHQ5QC6aK?=
 =?us-ascii?Q?q7IqOUhPh0rXo4m9fKJQgIWT/Bk8SKpC1CZaGwrZ6joAzje0m0FNYe722NBV?=
 =?us-ascii?Q?1cxFJUaJIyP0wSgTHoXLtFTUJwXtKcGOmTcX/dho5sRwWU2G/4UANUhRlYW4?=
 =?us-ascii?Q?DYVNO1Z/3esKyDgYVCAO4r0Iu6ILLZdGJZNSfyDRjO2w82SBtMVSISFSIV1s?=
 =?us-ascii?Q?vmIZ17LYDWZKkoDxqpRlmnMZ3xVSukzbPj3yE+xyGzi9ftFI5h7zr1kIppn1?=
 =?us-ascii?Q?vb9E6ac=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/8LwagwFgRB0Q1kefBcgmwwdtfrGzVDbG8z3yDEP1xa6AgOc+NfRFKQBGOm?=
 =?us-ascii?Q?jlqFZ0x22AC5ohtsYHUX/43aWVHcumnwRTDgANXNyDr2ynKEotRsDQXr8qWz?=
 =?us-ascii?Q?xMy6AdoPEelm3cYi/q0qH+dr71RDg4A3j+FUqVUfJiaRhfeIsC2hoySs24mQ?=
 =?us-ascii?Q?lWvF0ah7zfFnyQ9XnuURkqFZdQlGUuPzAfLsrXkl7lYnk2GybcBudv4/Kz9B?=
 =?us-ascii?Q?0PKQvVKtmlg/npXNZQdU9oYfeYDQoQke2v0cK4pwIDHq36zfzmiNXbhJZbSx?=
 =?us-ascii?Q?gBQnxR3yMjcP3dMMvV/pB4N+E7kPYtrHpxsEZuUpGitTNeLIBmmv4tLQyy7a?=
 =?us-ascii?Q?26P3JdOLnf+m6DpCwItaH3VOudU4lA1pexEvN72L5VVK27g2cwAMh2GFcPIB?=
 =?us-ascii?Q?S4pSUllmHdYGjDZ5IbzEnwVZAfHa1DcXpyOX/51q0+KaCsDM114QXM2lduOX?=
 =?us-ascii?Q?ChDWY96dsDB86AYyWXSRniQlsnTDHziO3UMBSz6oE6AvME1n8s0zZvOVyc07?=
 =?us-ascii?Q?+6MmJbDIYtDedlB04xupfUOzptfauw/BNGHj+WejzUsuT7096BqI2TmUnMUV?=
 =?us-ascii?Q?eFMOdOmBC+rWx4hGZIH9LAyVuKDA0v5ViXMhCBpUnXwr1YZTBCoVUZayeiD2?=
 =?us-ascii?Q?orIbAq9fkSQwdyVHZy8dwcZyXf1RzyrQObRt8r/susWbElPaBeW0duMASeuD?=
 =?us-ascii?Q?lyTFol3WZ2QsSdU0PV3RYXS6XBjOQ2AIPwh58X53wWWtu8u1elI/6lS499Qb?=
 =?us-ascii?Q?sJbwXCvzAGIiyAtXpTAm2y0nYnmkjjD2HFMVgQRqC+hUmjVxSIEV7jj6mGL+?=
 =?us-ascii?Q?Pa5qIX/ahaWsK3ZCTgUZScTct6AllC91pk+INfa+p45/RVh8YOnYnWQedDRI?=
 =?us-ascii?Q?coC6jdpywolCRs88a2SehaYTsHVtzKxC8vXUhXibJQOUYUZDGXZ8RpnxxA/Z?=
 =?us-ascii?Q?aZsvwB4Ry0TJJCWiYghMFwGWRVzyQjkngyoIEVde30aEvNdN82cI6ircLDkh?=
 =?us-ascii?Q?jYYoPViqMLrlSEj2OsQGVXFodyDkNvf6uz/PCpPlIYRZ4WyCYKwll8U+8Wui?=
 =?us-ascii?Q?hMWSOx/3qJtYiJMW72PS6XWIgawcAHr5+MnIpCzUKOQCwS66YEL7+RnEKFxL?=
 =?us-ascii?Q?vOHSvcb1EkA3b9ni8d7ekUcgIL78IHOs8tw0DD4BZBYnPONUVeuWH1MNnmQ7?=
 =?us-ascii?Q?rQLMO5jy1TRU7GptbNfQ6mqZu1Rv4MlcJ+J12yd54mTLk9Gg1gbbf6o8hBd+?=
 =?us-ascii?Q?YUh5gKP1DHqR7QZMe1HEl0GrWDiOI4OSZLuQvTz6k2zWa/tZ/6hbu1qnMLZI?=
 =?us-ascii?Q?ANKgwsyBOGWJIYP7/GdBdJ+Ih+0tCkUROzFJnVHP3uAH83PyLyxuAeBmNISR?=
 =?us-ascii?Q?GV3Nk5E/uxC5+Oeza28LVdWBTwtmzMIZuavYkVW46oFoFNOreNo8ckUG2GfE?=
 =?us-ascii?Q?kzxPdgNPSUZVKE+73NBa2E9jHCEeEimgpVMLT3nj32ALokZSwMe13RDxwIAT?=
 =?us-ascii?Q?+9MVuNfEneekO6Yhb7aAa4+5l+q/ZQkIwwVeukKtwNWtDWeH1o87ZTP4JMh2?=
 =?us-ascii?Q?yHr5L7obmJV7H8hxpnRgZsRIuZQKImczfKZ5ZZPK2/mMXCyc5HZN2rrt2+Hk?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5ab5c-5af6-486d-fdf7-08dd974739cf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:37:13.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c/J6XC5IPshlW+m45jG0thhX3q6BSfDAxQvTaWBTNICM2UFFWZTldKIDNyuoZ0qkV9mjalfq174wh01npAevQvDH4TV+ouH9yQhTQ+doDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:39PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

