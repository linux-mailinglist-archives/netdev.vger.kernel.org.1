Return-Path: <netdev+bounces-270082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH6JJiLGvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:11:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07882E19DE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6F2302A6A7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5F315D33;
	Fri, 20 Mar 2026 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuthURFB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547E2ED846
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044331; cv=fail; b=q3qqzRxpDwv28Gfm4FnvnZDK29u0UjtYkVEtZ1qxtJ70fR0FPjP9WrzB0j6ezmGqYuGy6nL8rgB7y1kI+QltUy6oJ71KAvQUWD0GKL+bmk4VALcYvbBbenlPTuRXroYSt8wcwoxse6v0nEVMnDbsrU7ZnIpa3nUHpn+yIBVYBhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044331; c=relaxed/simple;
	bh=4d5vzEM6R7Hctj7YLe8YwuFxsiIPURqpE8ePz3jF2pI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=esevtHWkYCiQvbwvh+hrKixLJkITZeU78evSWX47rO7/B3UcfYZmeuKcI0nQFSju+UoNBIZEWGAzescmImSDRP7ZrhWnXQmlHFUZK2OYROSc0GjQYv6l6U6+GNhRO68s8tmMADgJ0mSTh8HmjZRktideuv7vEI2IIAbxVBUxpj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuthURFB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774044330; x=1805580330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4d5vzEM6R7Hctj7YLe8YwuFxsiIPURqpE8ePz3jF2pI=;
  b=OuthURFBtjva37cgn4uQXSJeoMYz2WFMX5jliEW6dF9hhPxB77vp5orZ
   DUK8qPZyI+jumyiXZLIekiFOYMLraZcO6WkVRmq6MXt5WmtBna99laDs7
   toVCi6evLaRWAB2Bg0PBGcPmHeuQqSbPKbJVGwTggV5cqYCxPptWRNcl3
   VpQT2ssXPnBovVGYjEp2AyVw6+5GRODZ9FOO8s8k+4otNT917NGktmcjw
   XTTF4OiNaVOsBxtUyHtTj9X2sXfPGI1fPh4gzjQbXPNynkS9zzp9aw4Zq
   WNXQuOqI1JXVRacnPa4NVCloytKO4IaiUKZVRspAIOvH08/yl3yrNJ0M1
   A==;
X-CSE-ConnectionGUID: +GVwNsmWQdKx0oNS64SUJQ==
X-CSE-MsgGUID: JgcHJk5RQc2VBAwmxIrZmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="97758631"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="97758631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:05:30 -0700
X-CSE-ConnectionGUID: UtmQF9cBQsOIlTUsOKqxdA==
X-CSE-MsgGUID: HqW94raQRlC/0XPCMN7mig==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:05:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 15:05:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 15:05:29 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 15:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3vUSj67+wzPw+/aLO82OI5Pg1C5tFm9a30OrU58IjBBgu4sjG8UX9flq8HBbnHLxhwaIofmYEGaSolBGflkhcxvYBLM7cy4JjbBvf+2UDrYnDD21zXuQeGPg7PUdYbADXLyj4bAXfKp8lU52AUZqI70nHfgk651tIwRXBT3wPHK0aM+SSUvGiO0Z/crNFmFSJXHZcuvVPo9IJxih1Jh1+pfzFwrbiqpdg1+tn8jCqCVqdkIt74wznBZzn736Pls6PZr73M8qjqqKcYzAeTjVcXqqhfMCs1lp7wdHOYBR4jLz6N/37uw+3ALRJLMqbp5RwJrNmrSW/S2mPwzrSfFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBfB5WIwwGxZ0FdqbOgmla95WCQQK75+d29CClm9SUc=;
 b=UbGLufwe2k7Pukp5pJlh6bB3tGp2ZPtC3UO5x+LSIj8FiEiMd78qZcHP+bNxkMUYaPEbD/9IVWhjYG02zuV1u8D6Pn2dAHMF2RBiYeqN8TJtxUHnhNCIPfxR52HL9CxPB0A4eLjjJomIwlHlIg+6eRQ7Fx01v6sbULAc2rpveMG2StFNYQnKWDwP6TCCpydFAUwsUAsh85EezORY3I73IyKqoSyeAbbWlkEwxeHgL5ptriDjwuD8+w9IKDYWsk46PUt0uZZZ8i+FUWBt9WLqjWDTXaK9P1c+y6hujpmjrAJX/rUybM0BT5yjou4GIj7Pft/sWL03sqC11uzsq3UoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 22:05:26 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 22:05:26 +0000
Message-ID: <c1731a39-bcb1-408a-9630-f8878c270d05@intel.com>
Date: Fri, 20 Mar 2026 15:05:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ice: do not carry link status over to link event
 data
To: Simon Horman <horms@kernel.org>, <aleksandr.loktionov@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
References: <20260320050525.422403-1-aleksandr.loktionov@intel.com>
 <20260320193314.171338-1-horms@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260320193314.171338-1-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CYYPR11MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: f7219ee9-0f32-41e2-2c37-08de86cccaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Du5CvduPDmf7zD8OAF1H0IVHa48Uxziy5yS1NWwFyJs/4zs+8n65wFVMaXrzy+kTKYI5e6Q4i02yas1314WiIn/gT0gT7VeJlcUtGStrSwic5QSw/RuyAifrbLC9yGbvAKk5lX6I/kWs5/c60DfO0NbO8Ox629EXrT1i65YtPnHI4XAq69sYx6LXN9scrC+nroLZmNpIEYqbJsMBbD6K0pxMLMScLn4OflOgSXQ8bjntS+TLUlokgABy77nS5+XUjKoCl/kpaTcZmoRvRsQJERdBkNuomLOBsC9ubZspGZtFSCd0blh1dlSKH2kxBCbfFuhbJ2MBhqTjAWuywrOMFVLZR3+trNcbN/oJi6OdMrC+Bornj0fdfmXMytpmzP+2WnvRFMgCobPUZqzUNWipU8Q9Dr4CusKY61AkCmqDOjr7Q/08gn/SHmtjNV4ZwkM8UAUIsYOa6zE9LUJjLNnhQfTV4JalYvJA1z5vC266NDxizRqmn1PU65Ak8V/w0+404j3a+OAaAsLR+JmK/xFVAkdtFyL/TkouBLXtwu6UZ1CbYwGticV1IeIJqJUx7PA7cn/YsutBj2rGYXUCw6+FRyxCsgKklf03dSB4N1vkWvvhZfHYFy/68vdH/zrh4d349mkusxBTz8RYVh/kC0R6eDmGU/q+Vl3k2BLGhpLm6JcpKQQLYXYVG+9bkejwVMNI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWR5VW9lV3FlNkgrclYzRVQ4cVdaQU5pQThBSDJvL2JHdzlITmdCQ0ptYkVV?=
 =?utf-8?B?Q3hBaUtzSHBLa2JRVEdXa09nK0JLd1MvekRsTTUvZWphRXZPVkhEWXhNK25F?=
 =?utf-8?B?V2gxQlVRVzRpdXRNNUdqUVVIcjJZUzF1Q3lTWlVqUFZRWllGTURQSFI1QlFF?=
 =?utf-8?B?QmRqYTRNNnpSQWZMbjc0enQrTnlpeUJpdm53SVNrS29NeStaSHJ4dXVWY3BZ?=
 =?utf-8?B?NXlJRWRXMEpCQjd5NjZGM3hicmNQTUwwSE9wbDQ1bkhSK2thUkxkeXIySWdN?=
 =?utf-8?B?My8wcHY2bXMvMVM2emFXYU5mZUs0SXFLR29xN1MxYTN3OHZGODNkR05CZjQy?=
 =?utf-8?B?bS8rU0kvV0lwYUNZeE05VDdVd1E2azNBZFBqVUFSN3gwWkYxS1Uva09xbkdX?=
 =?utf-8?B?TTRKaUZSaU4xTlFtNkFDdlFhcnRvL2pxYmlUZ213a1UvOWF3aE5FVnluWEdB?=
 =?utf-8?B?TjhUYThvWUxvZlh5KzZ0Z1pVT0xHNTJQai95bjBNVlJpcFU3cnVVTm5xNnk4?=
 =?utf-8?B?ZHJXL1Z2TkJjUE9aVUJzMFhnNTlBWGhlNnJaVFFjNGQyMnlleWVZMm5QS0g4?=
 =?utf-8?B?SE1XTUZTMXJIRkNCVmozQ2ZBbXhjb0FIeW1CZWdhTU1lc0lMRzluTGdKd2Z6?=
 =?utf-8?B?eE1OQ092QVdNck9vRTFPaEE2SFozbFhBM3pTQSsyWUxTL0wrQ2paYTd3dU1E?=
 =?utf-8?B?ZjZray9KbFNRd3N0ZG5KQnVPKzVjSzlnUXVIVUJuM20yNll3WXJWRWIrMVhF?=
 =?utf-8?B?ayt1SFBndUtLNVQ1TDBjK1gwYzVOZllsU0VHd0t2bzNtcUtaUmFKRWNrQVNR?=
 =?utf-8?B?dUxLL0JJTU5kbkZmVm42TDRyYW9FYTJOMk5HS1hMMVhpMUdETHlyMVdPZjRI?=
 =?utf-8?B?bEVONFVtQyswRCtyY2J4dkRrL0lSRUE5MjV0N2xrcFdDUytPNWgyYkhEc0d2?=
 =?utf-8?B?TFpjWnEyNHoxZDVmREV4WVVBR1lHTzZxUDdPdGs1ay9JODBuMFVIS2ducnlo?=
 =?utf-8?B?SlBpUzZUK2F0ZEE5RWlkdlFEOHh6dDVlU1pSOFBUZTNEVkhoZTlwY1FvQmJX?=
 =?utf-8?B?Q1ptQlRORENPMy85ZkQ1NTNrQ3RvVWRuY1FBNGtMcnBSL2FuRkhxRjQzd3RW?=
 =?utf-8?B?b2h2b2txbXA2NGJXMkxoRURGWjlaSHI0bHFucjVtemlnVUR4cWpGK1ZObkJt?=
 =?utf-8?B?WDRUblVOaHJ1a3pNRUZjZFN6TUhOQVJ3VnpvRytVcUp3anFrRFJlTFRrYkdP?=
 =?utf-8?B?dUhXVW44WUhId3VNc0d6azlzMmIwWEVOdWNFZFBCd0krTjNKNEVHZHJvS2Qw?=
 =?utf-8?B?eGFGQXNLb2ZYNWQ2TlF3WS82OXUwQWhLL0lld0d6K2dDRWN5WEZ3bGVmOHBX?=
 =?utf-8?B?S0lRQ2pjYmZHTnZ6RldBSVJVaFpuQ0RPenkwb2hCRDhNaTdUODgzYTFMTi9V?=
 =?utf-8?B?R3ZJWTRvNWQxUjhQR3JCbDhyaE1QbG80OVIzSEpKZU9SWjF2cFovbzlHWkt3?=
 =?utf-8?B?NTJGQzJhRmY4akRXeXFBeGVIa3l2YXNnZDE1cWxMbFhESzhUY2NMQjgzQndJ?=
 =?utf-8?B?QXhxUmJqcGRTVkFhSWNpMjBxN1NzWUlJYWNSVUtKdEplam9FNVE1Wm9KQk5H?=
 =?utf-8?B?VmhXTytKcjgvS01TclE3a2Vkc2VZLzF0emI4ZUlvbEtyTmpOWUFyQnZNdExP?=
 =?utf-8?B?WnZmdWNwdmhVM05WNmF4KzFsZmUyZEVwdXluUktSV01JcU9GaDdOZURITnRM?=
 =?utf-8?B?SmJ3c1NxRW01RTNrK0F5SGNFNzFXZ1Rsc2xJckVsYXAvSUJoK3dUUWtHU1ly?=
 =?utf-8?B?NzVWakc5QkFMaGd1WUo4cHdRWDVVd0NzYVJSbG9CM1B2UlRjbklwUThONEF4?=
 =?utf-8?B?N2tFbXF6SFlxMHAyQ0FtZzdRcmhCaU55MHJGOGNONWQrd25PTytHd2pMK3N5?=
 =?utf-8?B?SlVPcjhCN1dJbjlKaEk5eG1iajBJNmVVamtPd3V4SGFSem1IK2pzS2tUQ1Ix?=
 =?utf-8?B?czZxcHRCYzBvU1pIRmVDaGxOOVlxemtwMFY3RTFlaVJVRGNMeVBQK3RtbUZa?=
 =?utf-8?B?SkpWTXZ6dlVBTHhBRTNBWEpTZHZNTDZ5OUJaSENyY1Z2cUJXbC9NeTcrTFRn?=
 =?utf-8?B?bkhWaDN4d2FLdzVvVCtzN2lqZWcwZWc5YjF4S0htdkpaSDdYTEg0TVJlRE5j?=
 =?utf-8?B?dGhHUTlxdFpOSlE5U2V5SGx4ZFZGcU5Xc1E3djRUemY3V1VVb1FPdXd2R3FW?=
 =?utf-8?B?OFVIck42ODBMbWxRTWtTdC9uVExUY3RRV3V1TWJ5RVM2QlN6ckpOYnd3MUZm?=
 =?utf-8?B?SWw3SEpJT3J0TEZBR1JKdW9ady9PeDZpcWZWckliaXhvaHp4Q08vazlRdmEz?=
 =?utf-8?Q?0UTBRfdUYFfIwdSQ=3D?=
X-Exchange-RoutingPolicyChecked: seW02PaWP+XOXcokRTpGDziNNamThG0dFSZiIHViqnLZLm/wEwiLELdMggihJ4je63N53mnuKrRjOce6dTfrN7Hp6ZuF+JEc7yZH0ShRrquEBleGGf5Ncap8fzNT+cKfzQtUFvKTRP24Pw8SVvkanZ2vriP01rcq6NMw8p15Ug750XZCVMgQTZFizFVCILuSDQqi9FIIHpnEATOw08MXOWMy7JjjXiWuvJFDVcAt5EQtFSEsPeIb6O8NUsypox+BIzYsPjA3n8x5lUGTgObfsUkPO//5ftCPzi0hNpd5TxfKxVH97NZZoY2v0CyZ4GKn1r5DCwVRyJiCJ9iAMtxW/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7219ee9-0f32-41e2-2c37-08de86cccaa0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 22:05:26.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khHnGOHS0ZazINgNTbs8J8cuuOCsWJBcERQTkOsD1MKix4+ULhUnAVTTCt1ecGN36wMdXJZ18TMNzgG9Ns5yqCvwpVAbCau1x5q3Q0X1gNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270082-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F07882E19DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/2026 12:33 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ice: do not carry link status over to link event data
> 
> This patch removes code that updated the link_up parameter with the
> current firmware state after calling ice_update_link_info().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index e7308e381e2f..348c86b7328d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -1127,12 +1127,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>>
>>   	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
>>
>> -	/* Check if the link state is up after updating link info, and treat
>> -	 * this event as an UP event since the link is actually UP now.
>> -	 */
>> -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
>> -		link_up = true;
>> -
> 
> Could removing this check create a race condition with stale link events?

This was a part of other changes that allows this to happen. By itself, 
as evidenced here, it does not.

Thanks,
Tony

> Consider this scenario: firmware generates a link DOWN event, but before
> the driver processes it, the link comes back UP. When the driver later
> processes the event and calls ice_update_link_info(), the firmware query
> returns the current state (UP).
> 
> Previously, the removed code would check phy_info->link_info.link_info &
> ICE_AQ_LINK_UP and override link_up to true, reflecting the current
> reality. Now link_up stays false (the stale event data).
> 
> Later in ice_link_event(), the comparison checks:
> 
>      if (link_up == old_link && link_speed == old_link_speed)
> 
> If the link was previously UP (old_link=true), the comparison fails
> (false != true), and the driver proceeds to process a link DOWN event
> even though the firmware reports the link is UP. This leads to
> ice_vsi_link_event() calling netif_carrier_off() and
> netif_tx_stop_all_queues() inappropriately, marking the network interface
> DOWN and causing packet loss until the next link event.
> 
> The removed comment explicitly documented this protection: "Check if the
> link state is up after updating link info, and treat this event as an UP
> event since the link is actually UP now."
> 
> The commit message states "changes that occurred from update link
> info...will be handled appropriately by itself" but doesn't explain what
> mechanism handles this. The ice_update_link_info() function only queries
> firmware state; it doesn't generate events or trigger link state change
> handling.
> 
> How does the new code prevent stale link DOWN events from incorrectly
> bringing down an interface when the link is actually UP?
> 
>>   	vsi = ice_get_main_vsi(pf);
>>   	if (!vsi || !vsi->port_info)
>>   		return -EINVAL;




