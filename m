Return-Path: <netdev+bounces-100923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EADE8FC896
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E6A1F23273
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F318FC6F;
	Wed,  5 Jun 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ms8R2RRq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860B6CDAB;
	Wed,  5 Jun 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581797; cv=fail; b=MsUDwjfWMrLfJo00QPOcYWDx9x/hGcfskLy62VORLcS8FyDZr/Ii/h3utgizZ/wbzkGysf/NGUFc6cKNNB8d7oYoNf9aPI8S631KL83LK654EiF8tmIO+StIb7Wlt3iSd6b8hVBQz4p3BGIpsTmhUBnE5oDQkoGwxdWBtJcU8C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581797; c=relaxed/simple;
	bh=NWbB9/+lDcb/2WlRRbxeUiwOH3iNFhxBvPcq5ZHnqfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnHgjnbmgHeleyeyNkO5JQ/Ea9HRwT5Q/jYEKmVCVHLQ8R/DtgYxarrjv8VXvFecq0uD3v9LzqBV2Uqvuq6d0HWATCVeLCVfssndFyV/akh8hx2eVw4c+mYa+sgHi6Xh+MtIM7C8b9MMkxXLa137gMy84rIivE5Fxan8aK6ndQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ms8R2RRq; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717581793; x=1749117793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NWbB9/+lDcb/2WlRRbxeUiwOH3iNFhxBvPcq5ZHnqfE=;
  b=Ms8R2RRqBW9CfHk8KnynpJVreTNsSUQtXf5dMlDm122QDux8YWXuXzsT
   w3Tsz+ipcb3vQs1T9y2aoObQnJ/XrP4cJNd+0aP0g2weGMcjmKDgE6YQG
   RnyAgWrN+BY0f0BbJ3kEu/raT3otm/Rd/m2UteCdkdJFTHer2KCrS1gur
   g+igY7akbSb8lK0Mf6xO4OOl0NQk6zbqK684VPF1LDvS0YBplkU6u2QKp
   uTxLh5WcUJTeOrv5FrhTE5idZbyDIpVcuVMpFckyJZzjT45xLH/bBik3R
   eOauwTKy3La5Qn9uvHPu44zGoz5D1Vgsob+kdXjOmrYVgZr+GFjIyMz0D
   w==;
X-CSE-ConnectionGUID: d0fPleXdQ7Czz0U8UuyfMA==
X-CSE-MsgGUID: NmIgwpU7R7qaa+1n+Cguaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17967383"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="17967383"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:03:13 -0700
X-CSE-ConnectionGUID: BxKp0eGyQySMMLIpHJw0Lw==
X-CSE-MsgGUID: ey7SPrm/QxukCqYQHt48IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37478830"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 03:03:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 03:03:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 03:03:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 03:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBS76yBxYYVsjc/FOZyF/HAjX7t8QZ/npqnknpDSKcHN06Re6vChRmeqrKBQoMKwx/uiZ57mYx/fuYZ1HBfsGaRCx+1Oz2xz+EkYuLmK3EcoJUAEs5M9/H1NG3rp1YR/tzjdzs9/aPoqZHZVAOJEurOnb2et0EX21XzJyEYLAEi5I5uMlZGekxcSXO4CgqwGgDbB7Js2WwnZQQVSjwSdD89PZ1/3B0lKO6q8SUA8WL5DHAcSrka9NAA0W9D+jOjMPnIW1QMEnT8q3Z6PVNBZ7eN92YbdGD9Sg8/GU+xHHEY88AbC6EaAMuAkPmMbPqpp5VxPGCzxFA8OhJOcqKzvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNM6yd76IVL+CI7A+G5f7/ymh93PzZcf9XfTn9hlw+s=;
 b=a87JS7afwerQT3RZTALpOPO4o10U/QEzRMohPTsapinpyhCd/ooDjmSPNjgngCkrUbNPEUMNmpIj5aALybwY02bQnR9QSVSoqY7VWVyT1FX1UoFGW2eQQoG0n3kFIZ2Hkgq2IlbKfUJ9olyVFMpeflzMpX3lgTKT8qJ04gfwAZzyRDQn7eOXo35RmqJkk6+66apADXtvmrLu3pmZM60L22tIJ8Jlz6n0MK2ymq4gzvg31p3NFPOckP09fGgvfXROiAVaEa1JqsSp6oro8wHYtTJluU5494pU6eqt66kev1h+5rE4qm0+CdgvYANdEYV84Yq3MCtG7Ayco35qL4tByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 10:03:07 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 10:03:07 +0000
Message-ID: <b52758c4-a0f4-4cda-9bd0-5ff022a9c9d0@intel.com>
Date: Wed, 5 Jun 2024 12:02:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: ti: icssg-prueth: Add multicast
 filtering support
To: MD Danish Anwar <danishanwar@ti.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Diogo Ivo
	<diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240605095223.2556963-1-danishanwar@ti.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240605095223.2556963-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:10:52::25) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d0fc37-8a37-4d1d-90bf-08dc8546b2d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnloNS9uRmVPb09HQW0zVDQ3ZldON2d1akpVemxjdUJSSUljbU5wQjVaZmxz?=
 =?utf-8?B?Umt2TXN6MzhtaDZjNEV1R2RiOGNxWjdpajdmVnVnbzEzemNkbWpjaGNTb21H?=
 =?utf-8?B?SnN4My9GU2VFYWJHMiszcjc4ZDFzdVNTVi9tVXNzWTFOZTFZcElCWG9QMDM5?=
 =?utf-8?B?ajFMYUFsdDk1ZUQ3dlBHRUk3M2hoeDFXQTduQU9aNzZIVjlXYkVBQWhSZkhE?=
 =?utf-8?B?UlFVN2VhRXh6M0s2azdyVzhiOUptU25DVDdGemZraC8yc3VmZDZza2RiMlRE?=
 =?utf-8?B?T2tYcXZXQ25UdkdKeVZXS2JZUlJhNExnRTNybnd5V3BsdVU5aDRLL3JJaVNS?=
 =?utf-8?B?N09TTkh5UVZUZmVpd2NEUmpaZE1Oc1hJeHZHbWVXOTBSQ3NRdHpGTW9tdlIx?=
 =?utf-8?B?aktpc3A3Q2RUMGxVRGtGT003QlYzZlFCK2xvWmZ5cFdzdWd5M0IrQnVhQ1RN?=
 =?utf-8?B?NUJKcDdzaEQzcVY5UzdHbC9UTnB0bDQ0L3RhODJKcUtMODMzakZKRzYzQ0hD?=
 =?utf-8?B?OTl5U3NmTWxyTktzNkFVN2R0NEFXT1JrQkN2aUhpczZrbUxIYXZzV0lHUElU?=
 =?utf-8?B?Ym8ya2xJOWUwVU5GckNGcW1DSnJqaWtlb0lhVmVKTm96ZGkrNk5UWWwwQ0tP?=
 =?utf-8?B?T0R4TEVIa25qZ3JyZUlRNmgwZjEycHFacTVTQzBiYnAxdmdaWFg5cW44T0ky?=
 =?utf-8?B?SlgrTVB6SEdycmM0M2U4S2hkNkMwV2d5L1oySTVkRmdRMEJGU29iOTBRU2cr?=
 =?utf-8?B?WEJjRWdHeFIvTjR3a2l6MVlIZE10MjNPTTlWanBlRUtMaTdIUlBLMkhMWVA0?=
 =?utf-8?B?V3lqTDZJcDVLNVorL2dLWkE0eG1BNWhRUnNBczN2S1pBN0FROTJ4cmVlZ3VQ?=
 =?utf-8?B?ZWxiQVBhdGhoWnVwTHB3K3FvUlpJSi9GYXVTUVFPSXJrbldYcTN0THlRTnFj?=
 =?utf-8?B?ZCtJRnJQdk5RSWFCSXY5dnYxek55VlFhWmZleW1HSHV5QmZrY0l4WTZWaXg3?=
 =?utf-8?B?K2hZY1VrdmRCUGc4aXJ1aW5kUVh4ODIxV09OWE1POVUyUWdiaEhKczhTSUZN?=
 =?utf-8?B?VlFQQUNPQlZwazRqNndhWTM1b1FwbXJOamQ5MzU0cmI2ZVZiQmdONlQ0TDV4?=
 =?utf-8?B?bmlkdks5QXQ4OGtYVFNCcmtPMHd6SEdUYmRDQ2JmSkxiN3N1SzFjYlVHOW14?=
 =?utf-8?B?QnpOdGdwTVNQTFNKT2dJUVUzUE53RTNZQ2RQbGpLeGRBaFdQUjRqWkR0TWcx?=
 =?utf-8?B?amNDVUtvY0xyKzBlOGUyRG1Fa3d2eFNSNWhuZkc4aU15WjhrVE9tMzVlU1FU?=
 =?utf-8?B?cW5kTFRPcGZoa1lwb2xidlFYcWs5WXlvWlFXNFUyaTdHQWxPdkUzS3FrRUVw?=
 =?utf-8?B?RFdyM3BGVzRsT1lESExxbDBENVJFTDJSTnpXZFRnbGZKd2pyVFE4aHZDMlJt?=
 =?utf-8?B?ZU9CajlVTithZnphU1cvZEJMMkFjM2YrWjlEb3Z1MXpENUMxOVpQTDNDSnE2?=
 =?utf-8?B?YTlDWUNad0V6a0ZWSTY4TlFsSnk1NUZqd0owNGh1SENDZ3Jrd05UQU9IUHdm?=
 =?utf-8?B?MTd5Zml6dzFZYUxURTZIM2pBbWFXSFhVWlVqQ0Jkd3drUG5JWlFsWjd3U3Br?=
 =?utf-8?B?eHZ1dmpBV0E2eVV6Y0tJRDl4U0hucmxLMzZqbzR5VjFKbW1xcXBDVm4wdWJq?=
 =?utf-8?B?VENkWXF2MkZCTnoraUZza2FJdFFrRjg2dGJFdXo1dlhScFRIaDZTVnVLZjAw?=
 =?utf-8?Q?kWOkFgZn5qy4dcBjG3lbN7PT9Y5+yQdBPYCOyDR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTd3dElHSEVHTCsxUytJeTZDM3M2U1VUTFoxQVM3ajF4L0ZVK203Zzl3WWtk?=
 =?utf-8?B?SHlnZFZtd2RFOXhLRWtQbzFhc2xVU0N0ZHhPUHBzU0FKWHVjWkJPaFIrTkdy?=
 =?utf-8?B?ZWZBWHFWN0didGxBaTg2WDlhcUxsaEdndUlNZzZKSUgzUmZNdWR4ZzRid1VK?=
 =?utf-8?B?VEtHbnArL0FmVWhDaTRZL2lqeTZsTXdyZkhMV0NBelFIWU1pTHM3QkVqMENz?=
 =?utf-8?B?R0RDSUJVNDkvcjhMSlJOWHRNTGZvWFRpREt1V3Qwc1Q2Qk91YmJ6SDMvVjVH?=
 =?utf-8?B?eWlTcVFuUXFuMGcxRlpRVFpnWXBaWkF6aTVOSUlOQXFDSy9xRkJndHJzZnJX?=
 =?utf-8?B?bnpRZEQ2aGdXOGF6WU5FVnNqeVhMNjV1OTgwRVpJdDI3bHIvSnN2ZG1Xa2Rj?=
 =?utf-8?B?L0t6N1plb2dvckxrMFVKZDU2TkhDNGVSUXRxM0ZOL2VZcVhGM01sSjZ6MGZU?=
 =?utf-8?B?R3A5R2xvTlVBeS9MNUZ1dllMdXlIRExxWlpzL3Y4a1FYUzRkMG9IUmpGM201?=
 =?utf-8?B?cDN4TUJiTHoyZDdwdGF4eDRvbW9HMTl3VDRyOGJPOGRzNmE4OXdDWHRod3NH?=
 =?utf-8?B?TCsxTGNVKzRlelVsalpmaVdsdmdJMEZUbFhYVVlCOHlyUGNySm9HeUV2NVly?=
 =?utf-8?B?UW9YWS8xYnVLd3NQRE1laENGZGEwT3ArNytDbG9Ibkc2cjZEMytEVmxCS1ZB?=
 =?utf-8?B?cjc3emw5YmZlWHBQTkwyNnNLZjA0blh5S0U0czIvRHZzazNqZGh5WUNHRlJy?=
 =?utf-8?B?OUhsUjV3aVI5Z2sraGhvNWxiMzAxUlJzVUxYZ2p6cy8zakFFNGJVaFFWSWxu?=
 =?utf-8?B?TEpNVUNVTlcwVjhLRmo2Ukl3VmU5M0YySnUyVG5UYzlHbmhSbktOb25MUnlK?=
 =?utf-8?B?SHY0cFRQQlBFc09NR3EwNnFscHluQm1OUDk2dnU2RnI1K0NhTlNUdkwrNi9J?=
 =?utf-8?B?dDJOc3gzNXo1NCtPa3FhQkJxaW1VU2JrUzBUOUJWYnpid3d1aEhyemdKb095?=
 =?utf-8?B?K2FPVGI4ZitRVVBvcW9jT2k4MjVlb1QvWFZ1SzVQdUhOVWYxYXp5cnZuK1FP?=
 =?utf-8?B?OUFhRnl5bDFpZndpVDh6VStYY1UzeTBCdFhJTGpYcnN3RC9oV3dZclNpSjg5?=
 =?utf-8?B?VjN2SUxvSEViL25CS3hJM2FqMWhUTWdlK2Z6c0YxQk5vNWJocDhubDhqQys2?=
 =?utf-8?B?V1cydjNBMnpRLzBKSmFNRW9zT3JUTmZDT1FqejBHcUZxM2tUK01PVklBcnVX?=
 =?utf-8?B?ZUphd09Sank0eUlLTkZZN0tSVWovNjlJUEtzVWE5MEZOREl4cVRGMmtpSFJj?=
 =?utf-8?B?eWp0TDRVVUtHNkoxNVRTc09JbURhVXRkYTExQlVBU0pZWGNkeDZmMjFDSUVV?=
 =?utf-8?B?TTVBdVlrSzZhUWVkVWhYYXc5UTkza040cGxzY2FJRjBoUHkyUE01UHF2WHJO?=
 =?utf-8?B?anlLR2hKV1hYam9ZaW1tNERFZEdIRERYMTVzNWxEa3h1dXRQbjZyc2VmUVh4?=
 =?utf-8?B?WjNSSXJySC9lL3lZWVcyTHpjakllY1VoMWoyY2hXcDl0VGtDZ21BS3lnRmNq?=
 =?utf-8?B?OEZmRE9yaHBiVmlvdXUxd0p2SmdkZkRIR2RWSHVBQ3ovWE5uN0xZU0JsS0Zy?=
 =?utf-8?B?MnpRa0J2YWZtOGZ5RCsrQU5YTndJVTF6WE4xNUlrdFo4Zmo3NTRzQ2tRUmZv?=
 =?utf-8?B?RWtQOHlONkFXMTE4ZjJuSXVuSFh2ZURXRnNKUUk4VysyVld6bkJrS1JPekc3?=
 =?utf-8?B?TzVDRFdvekJ5NjZveFBaZ044NytPQ0pMQnB6WFJVcWxhUVRTM2hNWEdVS201?=
 =?utf-8?B?UW0zWGFsYUZVelMrT1ptRjZwdHgvYlZ6eGVsMmxOVXJUOEdYa00zWDFUdE9M?=
 =?utf-8?B?ZlRCaXQwSnZvdzBkUlp4SS8zUEpUME9SMlpxRUVnUTFrSjhCNEtKMTl6QjYv?=
 =?utf-8?B?TTFJYVZmWHlvdTZuZDZoR1VSc3VuTDZvSmVYN0hteTdKM1Y2SUg3aWdEMUZN?=
 =?utf-8?B?bUlvSGVrSHNLUG9mWDF6WDFHRGhIdTV4U2xsZFFrL2JMNzBtbmNHaXJETzNS?=
 =?utf-8?B?OTE1VlNrU3NPWXVrTDVTZUNjZkw2Y3VuNVlqMVhIc2t3MnhKTndheWV1Rlg0?=
 =?utf-8?Q?N9jijDOAh+fx+BI2p9ef4v+GJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d0fc37-8a37-4d1d-90bf-08dc8546b2d4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:03:07.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQkbJ4+XREhMBcmPZ9ZX41Gqhg5qoTZ+Rx6g7tL8QP5FSJ22GdnvcQIrcmwNNskblLB/hMkVKJ+QJcaXRuJfOtsuDn/8GXHZJrmKcIPDSBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com



On 05.06.2024 11:52, MD Danish Anwar wrote:
> Add multicast filtering support for ICSSG Driver. Multicast addresses will
> be updated by __dev_mc_sync() API. icssg_prueth_add_macst () and
> icssg_prueth_del_mcast() will be sync and unsync APIs for the driver
> respectively.
> 
> To add a mac_address for a port, driver needs to call icssg_fdb_add_del()
> and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
> will then configure the rules and allow filtering.
> 
> If a mac_address is added to port0 and the same mac_address needs to be
> added for port1, driver needs to pass BIT(port0) | BIT(port1) to the
> icssg_fdb_add_del() API. If driver just pass BIT(port1) then the entry for
> port0 will be overwritten / lost. This is a design constraint on the
> firmware side.
> 
> To overcome this in the driver, to add any mac_address for let's say portX
> driver first checks if the same mac_address is already added for any other
> port. If yes driver calls icssg_fdb_add_del() with BIT(portX) |
> BIT(other_existing_port). If not, driver calls icssg_fdb_add_del() with
> BIT(portX).
> 
> The same thing is applicable for deleting mac_addresses as well. This
> logic is in icssg_prueth_add_mcast / icssg_prueth_del_mcast APIs.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> v2 -> v3:
> *) Using __dev_mc_sync() instead of __hw_addr_sync_dev().
> *) Stopped keeping local copy of multicast list as pointed out by
>    Wojciech Drewek <wojciech.drewek@intel.com>

Thank you!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> v1 -> v2:
> *) Rebased on latest net-next/main.
> 
> NOTE: This series can be applied cleanly on the tip of net-next/main. This
> series doesn't depend on any other ICSSG driver related series that is
> floating around in netdev.
> 
> v1 https://lore.kernel.org/all/20240516091752.2969092-1-danishanwar@ti.com/
> v2 https://lore.kernel.org/all/20240604114402.1835973-1-danishanwar@ti.com/
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 38 +++++++++++++++++---
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 

<...>


