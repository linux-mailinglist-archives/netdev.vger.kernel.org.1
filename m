Return-Path: <netdev+bounces-189881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00531AB44BA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E480A861168
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F698298CC4;
	Mon, 12 May 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCTV/JrX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD6296FDF;
	Mon, 12 May 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077253; cv=fail; b=HYPRwbADc9/hO6woa+UpKt5QgQZp4mV4CMxr2qAVJ5uGxemVFOCqIFtirY4EuPDOiaLPx1qiP42KZIo31aXyLfEmgN5d1GR0ShNL0zNICHJ9/sc3OOUDb3gr0Fi3Sr1wICkTOeECaukUjpA7MPkEAisW4T8TxmRp4X1+jGRyQFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077253; c=relaxed/simple;
	bh=sSVYb45x7FaifdhTT3+8iKwj1A4WTfyYCO75FCGhwP8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6BXp5F/kHP0fSiDjSNWRObrf1VAfxPkgij8CXsNePfQkq2Q5+Birpldu6Ou/eSAtxjfOiDsJoUyDgBgCnyP0Xd9OGSDOuVOZAiL7W2YxpVAJzgcBh7oZigRbvk5g5zyNFrDm15DyN3Je/0MSg9toI4Q30fnJuKpj9cofVK63T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCTV/JrX; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747077251; x=1778613251;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSVYb45x7FaifdhTT3+8iKwj1A4WTfyYCO75FCGhwP8=;
  b=nCTV/JrXLEVaCw6HRzmqF2LhYkKqMFcDAK4ir2X0t7QUpIThoyMH9TWp
   4cuXdZKWKVr8bTbxgnKScPfW9vNpQDUd2DfTGtA6vu0GPOitbnxlwTHAS
   OC7gdWvGLeTJUCRQxmo9TauxKmRhO+iwzJNgVCAoY6L7INxAne8G9EHde
   wC5xQ+Dba3jsCJLG1JExRHzFJoe2zLUxm4UU/Ww6fZg1WrU0OmW46iSio
   G78pqCdy2RzfG7TAbnbgEeo0rYLyJ7PfHLgndcCeHDwNa2vMOu97h5wXb
   JtvzRxlLB8FMKE9S6VfmFYocSkYSTsk8RoDoaD9kH3vOuL9O/9hTl/+2G
   A==;
X-CSE-ConnectionGUID: gFHCYdnbTH+keOgctVB22w==
X-CSE-MsgGUID: sri2tWrdQI2dW73wLNEh2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74288246"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="74288246"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:14:10 -0700
X-CSE-ConnectionGUID: ihHO8O6ATkqlD6D/k1al5g==
X-CSE-MsgGUID: EzDY3PlqR5CWJJKQ1iPEVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="138401467"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:14:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 12:14:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 12:14:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 12:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpoL4yZVFSyo8PDo1kwx27RcsADOcuCjWKbIe+NlBr44LRu7/spUqyA87d+/j0qZomYNcOsh65U56NVmgWpKk+xgatjq/GNwU/RCVuP92rOm1CofMorDEdIYqsUEX5nFaqXb6seUpE/c03Oe6sPR9kFg1FMoWdWohT/7Vu7ja2X8CsRYSQNiwmNsMuTjsqEAiJo/KRIPxTssjFcYEuiW7zZON+Xr2ang28ZcN3zlQdVjxuYCNk6AOfwbkRkB1nz2OAg1Z9ACdAeusoxSra3FHMokjqrjEUH/WDhShtuV/cBMxUc/vNHg8Htk8grJqZ77YB8vn9Vps2El2Ypf9UTMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1M1h94mBu0inlYs+58007RyNFRU2uI7JX1WF6sUyqM=;
 b=wcgfRCNFQE82lun6l0uVNSaqRAtsddmY31j2Iuh08d45NaQQClBSVtsC3oGGuvV0Yc0Ll7Xz9IlKkQapLEa5zpEWRWrg4P6R0BAkBk/XG4yew0z8tsIzzFJI7NqA/ER7IDiNssxEzqXf6efgBvyH8CF46AtJOmNaUw84kmDWsur+6qWGlvxOxM8Kryhtq9vkmJ5VeUEoIj0XtikqY5X0lIIl4xcBeTrfp/mHSZMNh7c7d0nKnWoC4g1OpdgV8scRr9MHd3aRVzVMt/5dzC40ASjkXR0q5BmhTRhSYHMWJiWCcEyoFB3sXR55Ez7yNWIZUzHq7jz/3tWC2xBx5Vipfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 19:13:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 19:13:26 +0000
Message-ID: <fbc8c469-7a6a-4b3d-a161-f2407b70a791@intel.com>
Date: Mon, 12 May 2025 12:13:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] eth: fbnic: Add devlink dev flash support
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui
	<suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250512190109.2475614-1-lee@trager.us>
 <20250512190109.2475614-6-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250512190109.2475614-6-lee@trager.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0312.namprd04.prod.outlook.com
 (2603:10b6:303:82::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: daa58f71-02ed-4bd8-8217-08dd918912bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWlYbi9maDF0MWVSREZ5VnZNaEwyMlV2dEVmRmlmckRrdUJUbDErMTFiOXNI?=
 =?utf-8?B?Tmc4RG5Ed0l1WnN0akYzT3ZaOFdCQmIrVUxQd290WEVBWEE0a29pSEZ5UDh0?=
 =?utf-8?B?d3RHMUZmWFE5WGJ1WTJJdzAvbVVNdFpUMEFlbSsrL0J2Nm1UcHU0WjlUVkxy?=
 =?utf-8?B?VVY2MjY3WElXc0tsalltVUNkQjhpRkZuNnllV3hud09rbUpoRVJlN2c2KzNh?=
 =?utf-8?B?Y3kwUGRNVnJuclBMbGMxSlVTL21SY0d2ekVQMXVPd3UybkFqRkg4TWVxc2dQ?=
 =?utf-8?B?TmFVeTRFZ0lwV0sxQWxSUWM2dlNWVkl0c3RNNko3bXlKcDdQQlhnZ2c3WnRY?=
 =?utf-8?B?WE5NR05XTmgydURHYUc2bTJWUFdFdm8wajhUNzhCeUhhTjJyckY4aVlVRHl4?=
 =?utf-8?B?YmVGZkhQWWp2Z3dOUUxpcW9RdUVLZWpmSEVsalVheDlrckRJQjFXV0NLZ1hC?=
 =?utf-8?B?S1AvUW1zOGVqT1RIRUlSbnJMM0xydnpOemkyZ25yT1JnYy9IcklRMThDbW9y?=
 =?utf-8?B?amJneWgyeEF5L3NXRlpkQjFpeENVSlYyWENYRkRiSnUvSjN0U0lmTHlySXVG?=
 =?utf-8?B?amRPU3NISkFiakxoaWRjTDFqd09vS2R0K2Rhd1RZWDZaZUEzUEZySkVZUnZO?=
 =?utf-8?B?TFp4bzl2elV3aEVNQnhYRkZvc3VTTnZKeitPTEtEL25EL2hpdUFqK2FkMTF1?=
 =?utf-8?B?YlJvWDE1d1g5WG15ZkxvRDJteTF1OHRGSWVEOXowUUQ3L2ZIL29yZkVGRUhm?=
 =?utf-8?B?MTczSTh2cXJwUE1IZ3VESzlYZGs0c0JhdEJUT3ZKbjhCWDN0clFyS1prU2ZZ?=
 =?utf-8?B?S1RaNmNuTjNPMDBPVUlRUHFTRU8zRGVzSTVIVHNsV3pvQlJ5cVhBUVRGWmVP?=
 =?utf-8?B?YytZSWZYRVJleTJTaTdyZUsrM1M5Z21WTDhZaHJWb0tWRTlXeGQ0OVJ5eXJp?=
 =?utf-8?B?UVIvUG9DTmF4T0UzYkF0Y2RnTTkvVDZQdVBaZHB5MytwaGp3OWptSUQ0SStH?=
 =?utf-8?B?ZkMyejRodUdQQlVLbzRwQ0RGRzMwVm95OGNKazRJYWx3aXMwNGFJcUVUQ2Fa?=
 =?utf-8?B?aUpiUmJTNmlFMnoxV0JKSk1MazBrZkxUc29rc1NHQmtEaGZJTEplSElkemRj?=
 =?utf-8?B?dy93SisrT2d6eEgrZ0kwRjE4dXVyRmYwVDlPL3d2SzI4Y0pwRFk5NDRnaDJN?=
 =?utf-8?B?TUVMMFpUMGhaeTZUUkxLRXBHMVB1ajlUd2swUzB1UUxFSzJibUdRUTFLZkVy?=
 =?utf-8?B?VUMwN3ZKU0pXdGhsd1V2eWZDUzh6VHdpNllhWCtTRytJVHEvOFc1TFczRjZl?=
 =?utf-8?B?bjJEaHlDak9qYWRJYjlMUy9rdk1UM0lBOTRBenlza2NtS3RzclN6MW5QWkUw?=
 =?utf-8?B?MzhCeTd3QThXZ3FWcHYrNkoxYktKdEovMzBzeWRicldXa2d1WFpoZUp0UGdZ?=
 =?utf-8?B?YnQ2SWY1UEZRbG50ZFp2QkhYbGdObXNRS3BsTmRaZFlNeitvbjdDbWg1Z3dO?=
 =?utf-8?B?NURhcnhtL1ZVZE9QL1IyZjBMelNYdVRaNmswZ2JGS2Uwa1BadnNxUEIvbnFN?=
 =?utf-8?B?N1VjeWpnRmp3NEFORkxsTTFqWDZ0eDB4MWJCYTdWazAvWmNPOGtuRlUxUE8x?=
 =?utf-8?B?SWVRMGJiN2o0STdtc0diN2hDb01sZVRmYVMrdU92NGkvVVRoYUdFVjRYdTg0?=
 =?utf-8?B?aXpEK2VjZERncklJOTVKK2htY1MxZ0pvaTlWclR3bWN1dE1kdTkxOU5XZHor?=
 =?utf-8?B?V3V4Ym1jT2czUWttZWpnT2k4TDkySnFjdmNHOUR0dlAvakd3RG40TWdCRXI3?=
 =?utf-8?B?MEdoVjhVNzNLL0laY20rWjhWRUlJb1hQOCtGYlp0eHAxNWhtV1p2M3JZaWtm?=
 =?utf-8?B?MVpwVmhQQzJ5NVh6S2MzSTc1bzVlNjE1VXh1NmtBYnZIaHRubkRWcy90T2FE?=
 =?utf-8?B?dk11cFV6NUQ5S2g0V09kRFR4NnlVbkdhVTJkbDJLVTRCbndOWFhpdUlrVDRU?=
 =?utf-8?B?NXhrK2xjeStRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2c1NW85LzJ3dndYZFNiY2dXQmRDWGNXZ0VsS0FXOWErVXExYUFnOWlHa3Iz?=
 =?utf-8?B?MTluQW9DTkpGOTRlMGVLb3Y0Z3BHM3dHSTNXR2JNbVZaeUQyTWNoUGNCd2pj?=
 =?utf-8?B?M1o3M0FOZkVocmR4d2o3amo1TVJjRnFMbnRIWTNUc3M2Q2h1RDA4WGdUS05h?=
 =?utf-8?B?dGNCV3hMbGsxSThTVlpJalhxSjF4UXJmSEp1cFJwWDNyN3hvdUs5S1ArZVl0?=
 =?utf-8?B?Nno4dlJwYnFiUWRRQUFsMUNRcklEY09RRWFwR1pXL0ptNitBdDhxOUtRdnl4?=
 =?utf-8?B?Q01LYWlNak80aUZXQ3lvTXhCSTM5RzlobzZQenJKZ3BQaVhIOGVTTFM4TGZj?=
 =?utf-8?B?aTg5eDhycVVRMW5UZ2UxZmorZ1NZMmNnRlA4T2NNVCtFNVFHTHl0TWxSbEUx?=
 =?utf-8?B?UUdTSWlaZUN2M2FTZDEwcGdkWTNxTi9TdTJ6d0pCb0RMdng5KzFDQ2dUVTJh?=
 =?utf-8?B?VER6WjZIL3N3WlNVYUc0MXU4UkI3eUdDTTErdmpNL2pqUDk4M1hHQktPQlhh?=
 =?utf-8?B?QWRnaWVBRUJad0tNVm5PbUk3MEFIQ1RVRENkR2x1cjlNU1FjUXMvSEI4Ylg2?=
 =?utf-8?B?RUFSR04zUWo2RXltM1BlU3VvSWw1RlYydkxuWXVCZEZvcThqaDJNR0pQNU93?=
 =?utf-8?B?VlFKSHlaQzhIL2dtNmd0TTFjNUQ3VVhaUm5nWWJ6ZFFQUlB4a2hINkVNZ2Fy?=
 =?utf-8?B?YXptRnI5LzVWMlU0UEJiaTBaa01CQXphdHU0SGJBbDN3TlpWeVlBRXF2b25U?=
 =?utf-8?B?T2wzRk5KSHp5K2wvK0JsZC8zRjZCa29hdk1BK0VoM3YxdXF0Y3lSMzlrcFNn?=
 =?utf-8?B?U0UyMXZHL3R6aWJtL1FzWXBEYkdLSVVRVVFDQXBpa0N6QlZwYW02QXdXb2F2?=
 =?utf-8?B?UjlxRThoOEFWRHpzMFFac2t1ZUFvd2tBcFRpNlp3Ri8zUkVUd3hyWDQ1NXF6?=
 =?utf-8?B?cW9sc0VrMXlKUFBiSFpiVG1TUHUxaERrMWcrYjVPeVdIcjRJbkNtWE54Vi9S?=
 =?utf-8?B?M3lkd2VXc0M1L0QzT2o0SjFLMmxzdFY5UjBaV2E2MllLQzRJOHJwN25DL243?=
 =?utf-8?B?VEs2OGVYQUVXQ2p3eWNRbnhvZEVBTkdnZEVPekhCODJ1ZW9TZktzeTB3bkRE?=
 =?utf-8?B?cGJwcEMwRTJSeHQ1d1g2QkkzbzV1V1ZBaUI0VURDMHZrck1LWDl4dmF2S0ZH?=
 =?utf-8?B?MDJFK0c2QStocjZsOGZnM3hBT2RCa1NLYnR2Y2pxN09vam1VM1I5YmNxaFBL?=
 =?utf-8?B?Z3Q3TnFqRTJCUk04Z0FleVZEVVB3QWpodytteW5XQklycnF0THJZdDJqblFK?=
 =?utf-8?B?VVdLYXlhSUlCNzl6RTFJeFppcURFRWJZMDFkWHdhUzVDTjYva3JUNENZVklp?=
 =?utf-8?B?dEd4UzUyaUpvR0Y5bURFWk1OTHhJU1JJaHgxL0tiZjc2RFVpbG1BUkVIRVVY?=
 =?utf-8?B?VmdvQjk3NUZRK1lER05vUUNLeWd5K2dnU0NoQys4MVhoaE9LQ0preU5KeXZq?=
 =?utf-8?B?dncwanIvMkVXM2VKSjVNMks2N08zZDlVTXg4RUt6WGVWaUd3Q0V5MTFrTGtm?=
 =?utf-8?B?UUlVUjVQOTBCRDY1Y1lkL01UMWJlY3FPS2ZpVE91R3gwaW15dDJmeGhUc0Yy?=
 =?utf-8?B?cWhLK0FlNUVJMmNRL3lkOElDdEJwM2tPMktBNEt2UDlhaVhzT3lJTXQydkk0?=
 =?utf-8?B?eVNybU1HVlNhcmNIaHVuRjFWZks5RmZPb095L3Z0MHNxbTd5UlNDVWY4NVNV?=
 =?utf-8?B?czhrR0F6SE0yUkw2bGZocVZmT0xQR1RuT1BaRndsbzZkY21EYXNXYjl4OGlm?=
 =?utf-8?B?c3RTR0o0RUxPNEZFTHRkZVVtekdpWjMwa205SmhjODdqQnAwa01IQUFEcXd2?=
 =?utf-8?B?TE55QW9va3VWMEN3cUlRMWErcmpadTFBSGFWRkZyR2d4d2R4RkYyUVlPNHhT?=
 =?utf-8?B?SCtYOUEzcHhCOXlYbGhVNEVwNUZ6aUduakNaODNxRzBHVEpUTFN1WVFQaGNK?=
 =?utf-8?B?NXNPMWpNalEwd2VLSVY2RkZLL282MU9JaTRRQ3BOS2pHQ2wzK2Z2dHZMZ1JC?=
 =?utf-8?B?Z1JwUlhUbnI1ZURKWEtZYXJrMVlzczNsakp4ak9NQ0ZSaERXV1lMN2dKMWp6?=
 =?utf-8?B?YjNQeXRlYmlJVTZ4T2g2aUdSR2phNGRVZnZDcWhMU3FjSVlHWnJEOE5hcjJi?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: daa58f71-02ed-4bd8-8217-08dd918912bc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 19:13:26.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUqT+mZsYpTqU17k+9xjxGq4TxD9g7Bgbhq/reIzhdv+U29zEOmZLGPzWhgZUIY6LEqxFTvDHFCBAWkFfJ8vMrMCCEq3hfZkKgnXyTwqOso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com



On 5/12/2025 11:54 AM, Lee Trager wrote:
> Add support to update the CMRT and control firmware as well as the UEFI
> driver on fbnic using devlink dev flash.
> 
> Make sure the shutdown / quiescence paths like suspend take the devlink
> lock to prevent them from interrupting the FW flashing process.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

