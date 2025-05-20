Return-Path: <netdev+bounces-191706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DBABCD4B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53723A3E67
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC919DFA2;
	Tue, 20 May 2025 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXztTvsM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631B1DA617;
	Tue, 20 May 2025 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708775; cv=fail; b=qc7Wwo22+h8/7/H7/IcbeCGPVpv+1kAMioJFRK+ZjQrgak5taWnygupMV2VhpDpWQDuVO/SYVjesO7UZQRgmgu6n79sY9J3fCd35P2gAXQLcq+1xT2x3I5KiLIavwVC7M7a/PfDf7Fb85FJtNPg8iTcqwjF3yyCCl4kTNOmQsGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708775; c=relaxed/simple;
	bh=RgLTA5dVUQYYm23H6xNHHs6Aqq0Y5JwgJYo14TML5ZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gGnDdKXfbwEq/qhxKlChPPzsLULBY+TMz9RRGMEpkv3ViPOdFGwgXvncFVF8ZognlToi0twPGoz8U0YoT6RbF+UU+pEh47fzXK/RAG7QmqLH+JvTXqxjaRn8Ot0qos56vBkNcbp2Rq3PiCp/hjEWAP8dSAfoJcfsNEPzgArfCww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXztTvsM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708771; x=1779244771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RgLTA5dVUQYYm23H6xNHHs6Aqq0Y5JwgJYo14TML5ZE=;
  b=bXztTvsMKtdmohOTEAkMQkgbpYjJ5E2PvTCkRWbWmLnbOIqZ1epe/aB8
   WcgXkUjEARMiD/Ori5H8osvvFrv9P45Bfw8DkMZfeebxo/DsZNY10GQ3n
   zfE4EUlxEJXgJST1zgGUVVYvAE2/yDF6Gw6kMNzOzMiZ4eDVSgdDF+uBj
   76jsAQICMZYd89yo6NNAO9S1ioEMIhnSl3GcmfsT9Q+FI6AcQL8gMXhec
   kq+Lxm03/3WdoG8h34t2D9gLR9feddCPZfNqCk1Wi/rPOYVnxZxgCJyt4
   5Xk1RJyaGlXXflm8ZEUNyevmKJM5k7+zW4UxJMrXnRGTvn1zaez8bjXHk
   Q==;
X-CSE-ConnectionGUID: whOqK3gqTNCkB2ugvKRyjg==
X-CSE-MsgGUID: wS+AGN6ZQyaMt+9dxrG+dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49690863"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49690863"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:39:30 -0700
X-CSE-ConnectionGUID: BM0pU+X3TEaXBv/bOS7UpQ==
X-CSE-MsgGUID: 2EC1jkHXSSiB6rxGAO9CBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139592406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:39:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:39:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:39:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:39:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V24tBJnCbf69MUdGHLTwUlFftQ9K3Ad55xrsBl1WDnM9ut1QKetMvEUSMN1wdQKqXLmTVSLw4yxMXfp0VifU+4Vd9MxAqmQcGXyAsYJ4275eMZTLorbwJjPXywQTnY0mTc6E8rV/1qk8kiHCmWk2qa/Uy5SaOOxXH0+/mD9nC8BNkW/RoLhpky9SonmjodO/oXzchcEW2jnzIlYEP/pvtzpqqE7hKq+0yC2dn8fAAYyegJyqr+DHGaFf5S9mypR+USvSvVp5O8IvSW7TrciuoGAV2V0dntskNRI+Ff/RD1F8JSVE2sCqWUAbTzwOYDGeWEA4LoKPny5cJbGnXHl6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOnbbBO1H2UhGL9bCVtskjxlYdh42xM8ojQFXXdzRVs=;
 b=u3AmKudVQgPW+OrB6Kef8hNDjrMzDyph/9TR5G5MiEu0Z86mvojBqR5i7LHhhcXXvISgo7CFtW/6xhFUaly4shTqbV3uy1RAIvCX4CkD2vxo0TMqWCXUmvc9+3UtDSW/JuEcpxz0QasP+Y6x8KD7CzAhaOIsiekiJATtPaz+0XiDRcP05tSB6SjHi6iCPfVytCpe3dXL5bYm+e3jZpjli9Mljyw/NbvdGuZnzaaiJiJd7sKKAdp9I85jFDcDuaZImtSgs7dt95AOlEBYXiTCJB99FpCU21xgcyqPlSiZw/nDZFEM0Wawlw3iJi2VdGG/Kg2NWmPcDyCCG3VRgWZUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:39:21 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:39:21 +0000
Date: Mon, 19 May 2025 19:39:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 15/22] cxl: Make region type based on endpoint type
Message-ID: <aCvrVCg8jz1bTkog@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-16-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-16-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaef177-c0b4-4fec-094d-08dd9747865a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n2jkOkSlRI308qVZ9JA5Pz3+sLIwNIOZIHJSAZmYH9t9jTaUBnmTpWtdln60?=
 =?us-ascii?Q?j7dhdom8lPEElDlqVj5F43IkKSCTS4H67aXsy7MpUcYnW8kDcDOqfpI6/jHu?=
 =?us-ascii?Q?sntLDw5HMnAyF2JNwClTjYKXhjRHEliquMJOp7mHaeH1pyjQncBFpTkrEqqb?=
 =?us-ascii?Q?npYGh579+dFPNaaMeh3EjFHc/BTzc5CHeC1L99VSW5f9mClygIRIW79+Vz2k?=
 =?us-ascii?Q?dq8ySy27s++hk5T753sklV+Pt3RmdbzvilbvT0kvq/QKiUqr4uUuSkuj+5RO?=
 =?us-ascii?Q?I3u2PVCjf/yCubkltPcBeCB7nfvbQNqb7upsk2aDIBm6qpd65Fy9SXeJPscj?=
 =?us-ascii?Q?GXnquOcjunH2cEe/BntbUjz1NCZRQMif0MfX6GqJfSvvZgcTGO2z5zOzIkd1?=
 =?us-ascii?Q?m4/K1BIej1Py69K+p3KXHUbyJsXQTdZ1dRO9jB8+xbI+0yUw9S7zqqxJ7kfS?=
 =?us-ascii?Q?DM9vCxPVwwFNgZ9Wc3SMcly2QXZIkQNlAenh+DjeQBi6qcKUgsvsIiAE98SG?=
 =?us-ascii?Q?Bble91QeKBxOTNPzeuXJnuIrO3/X5cgtBFbhKQ4AqHJG6mQdNDm3QRueosid?=
 =?us-ascii?Q?71j9Vs4MimhGTBC8TtyeuF29RL6Z5wrPcPe09/V0M9WdbZ3ly5AxrES8pvuH?=
 =?us-ascii?Q?AmoAqxJw2KRVnZZEZvAH7PGoFgPSLiZ16k1v8p3HHOQMtIq5Pxel0kCm5nwD?=
 =?us-ascii?Q?gNsdFg/0gT1NBxSu/AplKZ/76DzNDW4hGEzzOzCBPnjVxD9z/tClcPTjet5E?=
 =?us-ascii?Q?52CPWf6vbul8vEEKyeOnP0bhoebGEi2AXAd8/mnOMVYwzV2VauKiv2V4BAJB?=
 =?us-ascii?Q?ij/3XGrj5Yr0HZjVzYx0gmDdqyWyUjqBG2TJaHwRxw8OXev7rnMxMh1qAD6O?=
 =?us-ascii?Q?VvAVERYTBOWF02j6QU5Lrgco4qbgfQDP+WlrOqQaxVkZHgdTxplShEGCzJN1?=
 =?us-ascii?Q?+dvhlRs3V0qX9l6OVZ7JVYTY7KzwsUDsL+Ok4A5CJgmF3gAg/QARgyHvo9QJ?=
 =?us-ascii?Q?CSQ3gflqrMDh5v7jkzblT+oO1c2cMwoTduMD98vpXobvv9uo6RxJ9NtxkAH/?=
 =?us-ascii?Q?YN20t93/y+/PHLs/1OJMgUYaaNkxjzMfwQvtH3Czemy+pTp9ewWrEy9Lb7BI?=
 =?us-ascii?Q?PbI82Lyt8Ezuc0GvJWTuAAUqNerj0leEGBZVUcQvDPsEtYr1xsdl6lXQLbJe?=
 =?us-ascii?Q?fW1dqelctn9laQYuw0QDaT8Cp/RiAqpxIq8FjJWekClIhXy8/i0GGIK9al3q?=
 =?us-ascii?Q?C72NUsK/GSXk2VA5NkTmzb32WzmyUA+xZEMC3epLMoTghoPN/AP0O1xLPEnX?=
 =?us-ascii?Q?uokN7AQfrJIL5dyNrS7JPK9rk7gK0CXJvI1ieMEhhc7ZYphTMnkJ2nTeOwxq?=
 =?us-ascii?Q?6CfdC27eauZtrC0Lx1i2ru0lJYC+KF8OVBprsxeFep2xenQN47YmYGBoraDr?=
 =?us-ascii?Q?q57o9biqIS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fcZFplwE73rWO0BgulH8SWzsfkYTUrPlCSkNSYgOhTbSxNjaOcAzXHrrhwgu?=
 =?us-ascii?Q?5N1E2gsc4S7sPxiTBYmDbP3iFtF1eJK2V6XS7i4lS6gBj8cwof27HtJGxuXj?=
 =?us-ascii?Q?/ePA3WXvrz/ct8fulZCMQ5klhus66N8XjWRiMZjF7ZROTgV1R1eEqNEf3T8W?=
 =?us-ascii?Q?EgnlkD5nABR/+ZHWbxP1aEulg7OiMX6ftp8Qhb9J/Zg64g3DGfj+LL50I4pz?=
 =?us-ascii?Q?O7pAR30sczEtbVLNsOkJZNByai4PJHcqp3OkcIoiBRdb+FYxiznccrMgfN9O?=
 =?us-ascii?Q?6QxICWTN9s5dSeWGpbshf5TYgc5dkomH0MfUCluAbRRJc2aOZX4d6tdd08o6?=
 =?us-ascii?Q?FTmCgeAT4df73FFZLR82FWDGHAtVu2rLKIfTI7jV3GD1amabhpg1ngfkecTp?=
 =?us-ascii?Q?Z4/Y5z0nw3kIuN4df4vj2heeR8eDQCmfJvE9fHIFQrlXVJ9pk4UlmY9VKAyr?=
 =?us-ascii?Q?47/+P26anGxwoZM7RRdBUfzxgk1hE7LmFTReHvlPscd3q4CbpoqxkhdbDNqk?=
 =?us-ascii?Q?IFeQ+0ZQvVoBlROJum8+NxA6gvIlM84dZwKmWDFKHGGG72dclCAvoMKuIR3d?=
 =?us-ascii?Q?Qvkfp0SWKP7QrZz+CIiCCa01nVJ/iIY8AQYqZ75yo+dAhM99+0tt6N7F5OWu?=
 =?us-ascii?Q?EKiYijUnHolQkMR1ItqXLyoXwHjphVm/nDYTtjDO0okzA8E3lottwVdHTDRq?=
 =?us-ascii?Q?/hag8xUlTzuke2kWrgHHqiKAUfwML1kUU+qABm/OgR2gWNALqvvF1y4+uJZA?=
 =?us-ascii?Q?BYpwnn5h/qAXGLKNUfuXDjynEXyEsijsWpg927NtWpNVmLnfhGJQZFUUYS28?=
 =?us-ascii?Q?zCKHhV2qVRxyUTgraK1sxCquvIfa9khTxrON8g+FJOCxJ4719tuoJFhuOseh?=
 =?us-ascii?Q?LgmmIIe/PmPAUhuSB9I91PoMyANGPqzi1h5twdA+zMCShBvbG27pJ2UcaIL0?=
 =?us-ascii?Q?Bo4bteT0+7BlFvHTY4rqQWzp9hwsULbYo371Bj/wzeIkqVCjNoBg38/M5bFw?=
 =?us-ascii?Q?7kWuUSqgSnRrOQBRhZnWJVxQeDrVvNRuO1DMxlL6ZHbtQB4uwVTJ1RGYNxhb?=
 =?us-ascii?Q?FneGD3+D9SJ4Uj4muMpXjfI/g2kgdFzvxxhHV6/kSSn1LOh5tlQFrDIYgvdl?=
 =?us-ascii?Q?wjfvi2voFG7dGPi32RkfC/AaOqDo39Pb6ZINKOoqcUxNhPKRty5iobUYx+zi?=
 =?us-ascii?Q?luhcxu1pjlNDBkG3ZFY/1dIVSBdHOj6WmNmlNAw9EQGLjpggbsB1YziHNBvW?=
 =?us-ascii?Q?3F9TWByJQzXAZyvkC1BXsYx3XngthYDl45RXgEvPaSuidR+F6ddaXVF8IIFa?=
 =?us-ascii?Q?Sfc4LIxf7hnCRH15SFfiKts3A2NLXpMsY/5ABf8JuovpTxVz6kvmKDIZ5Tbz?=
 =?us-ascii?Q?uYyP8d+ymQUFV+3SayRBfzT5048PeG4ebXN/OOVfL3/r7/0IFVF/be10A1wZ?=
 =?us-ascii?Q?R7mxy8LOCTLuEpgUJq3O2Erg0p1frh8NYFFzy6TMdCJ3lOMIjYwUSFv3PG+q?=
 =?us-ascii?Q?NRNVFMvu4vpcIaV3qjbkw+knpfPlrHreOjWDr/1nhuizBD0BBKono2QF8WT3?=
 =?us-ascii?Q?EedHA6jNmaLunVEeYsn+rCL5dlt+3RbeUY3LBcGHm49g3QBCHRt95FSGfm00?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaef177-c0b4-4fec-094d-08dd9747865a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:39:21.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtfWijL8n/M00KUe/VXl0hF0QYnffCPbdaPojN9NLLlsNafLZi0BMCZKfRrciLUMVHb4NQoMJPOTQmIebpHOOlmc3prcmOVrst+v1ipQ0OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:36PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

