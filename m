Return-Path: <netdev+bounces-150842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA129EBB76
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AD81881FC0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2822FAF6;
	Tue, 10 Dec 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnXXqjz7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0822FAE5
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864638; cv=fail; b=D2/qyAFfgJYaN1Q9EcVwr9oiYF6DyFxGs624+LyPJBcils0mr2LKue00SaM2v5OgUvUu7YbnuGo/tsN5ZtK2o+k6fiAFT/G/aeF4RQxccnB98CHXM2Nkml/9MdjlHFUbcyQzGT6kgm1vheEwBWZrlPujKUhzJe+zUSCTrSmEjIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864638; c=relaxed/simple;
	bh=1Ulb06uZi9K4DmpX1ZjIigW6t9TLeBg4GQ3WO3B8/8Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2Da53d2BwXDEs64wSL76RR9R9oFYQVB+J8xlTjOzAGB6Uym2wEUBCG2Fel5F8NtNX5Ng51kmEyowoB9YBjO+5ewq3u6vJzKtY9HYCpfLvzHEq2k0rc+uDI9oxSralauKXKPj8/9O2Y732yvER4Ic5mJEP+yil2UErx/4bT2dj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnXXqjz7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864637; x=1765400637;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Ulb06uZi9K4DmpX1ZjIigW6t9TLeBg4GQ3WO3B8/8Q=;
  b=jnXXqjz7G3WhxDnicYWwnqiTHWi7XO0+xuOS1ndTPmZ+OwiCv3EoTuKM
   6Bgu+A4ljaJ9RPluM/1Bba+piCcQjIUEJ3C7S8W2XiXUaNpFK4xCCdz8o
   vCg94R20pEKM4BakH1odoWG7WZkFOKYNiGA1Qb84HGUsHM42d5CklroaU
   DoxJg7yYZzCupVQXZE9yAi7Tox4sYt8NPBmslWV5Cnm9CkfXCBd+OZpFZ
   OfG7QNUNEN0xsw2qMgIwhUr1vdqDQ9UdzhcAtxGXRpnZQn4QVxTO01SwR
   GI6FxJbZITGT7asMYviTIxuKdkK/JWh/yIqP8U5wXs0jECbG2vSY+9yXn
   w==;
X-CSE-ConnectionGUID: UtgmfcBOQCGzy3CJ93vrbg==
X-CSE-MsgGUID: 3r1aOiMlR1qWwQgnVqkP3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34132613"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34132613"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:03:56 -0800
X-CSE-ConnectionGUID: UXM69/R1SoalQQbeae4Kcg==
X-CSE-MsgGUID: SUxXmfjlQSeYYtvOutBNpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95222146"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 13:03:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 13:03:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 13:03:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 13:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAkOl6xB/6NmYxcXux2tduXKeuznasMjEStOgH+rha+IiQ45in4I5VyH/tTw7Yp0ZHT9SpSXTRG2z6U2SWtKU9KbD+vUvfF9z+wOueO68IiPsAOVRO0XZ+StIauLFEXKvnqVVM0KN9t+7Z5uPsUiE2IPrZMeaZ/a+/HvHbbGC8yCN4o08DLzikrOLNZsoatH5fosL2fAQokvHCQX1Pos92YhDaeZu5+5l78yyQhzjcZU0NTjICpNWKzQJRr1LZfW5OpL/HIt2ft/aHJJYNx/n/j1UD03maUBx6z+FG1/Mz0Sw+D/oPxlzMfspVmZx6LPz71V4LJ0LCNxScPLbzsT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQlBZgfclXIbNedd/2y8CH9dB6SG1vEgynwdyS1RTJA=;
 b=jFp5A2YHJJKdBWVvpWyfSuTipudGFVADw0UmRtukBNhphZz+yO2fhtA5gt9hk81HI9BeKbzYwF4ZKfTpyOuzQEahVfXYYyl3Gb+oZ99eb2SSFyptaxKqfjn+JJWek2iNS/yJUYxVJ8SwvcipVe9jLTOxUvMyvfKSXu2PW+6odmPhAjfFo53v/P3qlhLUF72bPRdf8o1gQLmGqwutRzrsQsCU9SWrhCgDFQsjORaYbNCGdqJN8UF8cQHGQFX9mM3dafyvsotKCojK+5f9D+vmZqO6+LnJ+GfosY/ZWw5WSqnfasOwOyN/Y/T4UiOzWflF8qLcKJFe4IDCi9mruYsKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 21:03:37 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 21:03:37 +0000
Message-ID: <1887a497-e7da-461d-a0bc-b98bd654e595@intel.com>
Date: Tue, 10 Dec 2024 13:03:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ionic: use ee->offset when returning sprom data
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
 <20241210174828.69525-4-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210174828.69525-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 6103af5f-366a-4815-2f66-08dd195e1db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck0ybHlJK1R2Y1FTQllFOFpNWU50SEZJV0ZTYXlMUllSSnkwUU1VZ3oxN25v?=
 =?utf-8?B?bEtGdlk3ZGFvTWo1cWFxQzhXOUlwL3pGNjhOcW9XcFF0VEFEU2RBbktrczZI?=
 =?utf-8?B?THdMeVhYUVdqS2JyT2U1cjNWOHJVMnF0eC9HdUV4OVlpcjhTeVd3aTZmbTlT?=
 =?utf-8?B?L0IyRW4rSmlxSVVIVG5KNzZxaGkwZHJ0Q1BvSmQzSEJ6cWxnM0E4Vk5QUEFF?=
 =?utf-8?B?Q1MvbHRPNWZjRGV1Q0lRT0VLR0xEVkY1N1YyVjlUNTJIdms4cUlVcndXK0hr?=
 =?utf-8?B?OEJqdkx3TWVwZkZaSFZLeFlzYUs0NFNsRm9BVjN5ZXp3WjdoUDYzR2Z2ZWo1?=
 =?utf-8?B?RzV1bGhCYlJHeHNWWG1WYkRwUVFRL08vZUxkSml3SDhwc0lRcnRhZldTd3Qz?=
 =?utf-8?B?Z0U0eGJ2UEc2Z0xwY1ZwUS8vaFBHZFVHajVoYmp2NUVSdStUSngxcGRuN05n?=
 =?utf-8?B?ME1Qc2ZmanR1SVpEQXN3NTBsVE03R2RoQ2NFdGFzTHZSbzZJK0xMUStQeTIv?=
 =?utf-8?B?WlRQVnpPOWt1WEIvK1oyU0MydE11bXYzZlRadkIyVGFZckJVZWx5NDRZSzJG?=
 =?utf-8?B?NzVla0JITTFqVkcxMlJoWFdDOHdMWm1zOFhISVZhMkFLazA0TWkveTc4cHBs?=
 =?utf-8?B?bC9NUFZiTStic0FNYW1NQk5xdFBUZDMvUk5hL2MzajlmU1l4Vmk5YklWZXhP?=
 =?utf-8?B?MDd1UXZ5WGNvRTd5aERVWTA4a1lnN2k1V2tUcEY1U0I2Z1VQb0F0enkyL0k5?=
 =?utf-8?B?dWhmcWdPUERjOUpta1JqY0tvb3Nud2hOSjJuR2w3NkcrUS9iRGJzSDV2QStT?=
 =?utf-8?B?SEZqN0tENldlcFRVNFRYR1V4bEN2ZUJvTnZ2a2hVdDJOODhTb245bGN1UjZN?=
 =?utf-8?B?bERZSSt5L1Jla2Ryd3ZUL3ZXdDJQK0drQlVVdDFidHAyK1dKcG9DNUhMK3FV?=
 =?utf-8?B?VnVQUjlsSGRLTjNLUWtoc0hxWmV6alZZVHcwaVdzUXNqd3BwdUpnQ0ZmZnha?=
 =?utf-8?B?VWc3RElJVy91M3hGWldjcElOdWlQZ1gwelZsUkdyRTlRclU0ditoWm5OWDl4?=
 =?utf-8?B?bnJQSkk4aElaWmJtSVdGbmdPMC9qeW91TWRDMXpSQzZpVXZmdDZaVEU0S1FK?=
 =?utf-8?B?d0hTVmMwQlh3ZlhUN09GTmREQndacmZwdlVIQUZEaDJtbW93K01rMzZ6OFQ1?=
 =?utf-8?B?Q3FhWjFLK3gyY1g3YUpWYlhYNUlzeStQR3hPeC91RG5uU0hKUkV0UkJtN2N4?=
 =?utf-8?B?bkNBZTB2dmFWdWw4WHAwQUppUlBtSjkrYXhmRXNBYWkzWUt4Qlp5ZEpNclhZ?=
 =?utf-8?B?S3diT1VnVyswSGVKZS9pelp4cWU2UVAyWDVSTTBhSERqR21jUXpLa1JmM1h5?=
 =?utf-8?B?Mkp3dVVKV3FXTE03WXNMYUdDRC9SY2FFOXZXTWpoV25HQVlZcWhMeW5PYTZP?=
 =?utf-8?B?YTByN0x6azZpcEQvUVJZSmNITXRSMU1LMHYvT2tQekZXazlDbm5FaU1UUmZv?=
 =?utf-8?B?SHJzN1g4ak42Um9xUXFJNUpZMGRhT2N0Rmx5cEVJNTIrNDJxd1F5MTA1Skcx?=
 =?utf-8?B?SkpWT0RJNnRXZGdCLzgvYm81M3AvK09uU1l2Uzlhb1JxZnYrNURNZEU4MW52?=
 =?utf-8?B?Y1FtMlNBayt6MkYvaU9EeFJSUEVtaXZxRGRhcCtNUGNaMVFFbjAvbW5Ba01l?=
 =?utf-8?B?QWQyWGovejBBeDBGUVJZaXlsczQwaG9wNVdkZExVWWMwT3l5UEJRb2lER3Rw?=
 =?utf-8?B?cmN5YVpicUZkNFdGeFQ2MGtlRm5CeXBhSDA5c05USk00UVlob2NLbDk4cVNi?=
 =?utf-8?B?b0RnQ1VrcDlPMlNLRkVDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNoUmNtQjBjdC9vd0doNlIwc0dicnBONVQyNTlqemhRblV3MHpscE90dVBT?=
 =?utf-8?B?d2NIMm9EQUhKTkkxblQ3UzlYQ0ZMcmQ3c1RNZlUzS3hiRjlOQmsxZVVMMU05?=
 =?utf-8?B?aWJEUHFqZ0t1R2NOdTFpSGRzdGhSTVplby9SYmRRbmJBSmxiTXkvWi9aTHZo?=
 =?utf-8?B?K3orTkZ2QldnNTdFOXhlTkF4bUE4V2NZdmhkNDRxYXBjd1pCRHV0ckQ0cTdk?=
 =?utf-8?B?UU9VK0RZTG5iRFBxRkVPeS9EVXZnMi82OSs2eE9ETUJ1cHpvRXhHVDg5R1lx?=
 =?utf-8?B?TXJLVFdWOXR6RXl0dzJEdmZnZDIza3BQNWM4azlJckIraWRYUkk5RXVWUnpY?=
 =?utf-8?B?RXZiSkhnQVpYeE1WcE5KY0xPWndzazBxandqT0Y1NVR4ZGlOQ2tuS3p4TmhF?=
 =?utf-8?B?c05Ka0Q5SWtSZzl5UnFqSmU5bXB0b1pUb0twaUhLN0czVjhJeVY1TGxaZEx0?=
 =?utf-8?B?WnEyeWcwaTB2MlBTc3hJUTJoQmk3Mm94R0NzMU5JT0V5MjNnVlFQYlhnZHBl?=
 =?utf-8?B?R2ZXS3B0TW5yaW1QNmhLOXIyQUE5cCtZa0xab21xcjRUTi8vSWgrTGRPdm1W?=
 =?utf-8?B?U0dtdzJ1TzZkdUMwZVBEK2tIcGwxSVY3a2tUbnZkVFBpTm81ZXJnRkZibjk2?=
 =?utf-8?B?ODV6RHorL2lGT3Frcit2Y3dxa3hua1RkUC9yMmQxVThyZWtkME5KS3ByK2lz?=
 =?utf-8?B?V2RPNDRPWktMU3FITS9lT1hueUF5L2VJenlrazgxcGJsUm01MGlnME5KVEZr?=
 =?utf-8?B?TGYwcnhXUGdkSXZ4VjVEaDNrTjJWTnNzM3FFYVFYTjVRSDMzQkp0Ym5wazdp?=
 =?utf-8?B?TUdtd1MxMkpPTUIwc041TndTZllKWWozZzg5SlMwUVFyREpxVjVGNzRoS0Jl?=
 =?utf-8?B?aWFuNXFxUVVJNXppN3pBWkZzY1dvVTVURjJWV0k3N3oxNWd0MHhFZUNpVzIw?=
 =?utf-8?B?VEJBS3AyOTFKNFRDNjMrV1FwTmlqbXNwaUFWaVlsQm84M3VhK0IvMEJFWDIz?=
 =?utf-8?B?RkdmTndocFlmUGdYcHhCYmRBZWY2UkF6TGtWMEs4eG1HdjYzLzNDZElZa0ls?=
 =?utf-8?B?b2pBZjVlVTNjNHl3L09HN0w0enRHWkJ4K3A4REUyNWJqV1BRbHRGZGRwbnVS?=
 =?utf-8?B?bUtxMjFLMFNXVkJERTZIdlhCTm5RMGlLTi84RU1TVTRPUTZLOFphNTRZZjI0?=
 =?utf-8?B?K0t0MUNWQ01abklGNG5pbEVoRmwvMmw3c0F6TTMvT1NTODluWHZDWkc1K0xH?=
 =?utf-8?B?eUkxeGJYeUhiUzNoYlBhL01yUjJNWUlFc2lPTnpiR2tYbmdHVDdNOEN1NWho?=
 =?utf-8?B?NW5VekNYOTJMZlNtdVR5N2s3VTFKRlozUzBLcE5YdUROWWF6RnoxeUdsZVoy?=
 =?utf-8?B?V1V0TUlwK2k0YVJPN01HNml5WmticVZNM2RzeVpmdTdwTWQxZDlHMFZmSTJu?=
 =?utf-8?B?czlaVG12Z3dvVHJFWVFtQU9TZzcwTCt5VVdnMm9sYldhRU5CcEszN3FDOWpu?=
 =?utf-8?B?bTlZWkpvWGt3SUF2OXlub1l4dEl0amlYVTZycWJ6ZGlhaVBOMUtmNkhZSE42?=
 =?utf-8?B?NmV1T2lqbzN4QzFOWStVOWFReGVmdFFwYjczajU1SWltN1NQYmtPanp1aGtV?=
 =?utf-8?B?bmdCYnZuUWZjcUhDSVFINi9HeHM1MjAwTE1PUndlSXViTmhVZDZJeWxJdzZF?=
 =?utf-8?B?ckhlUTZJOC9sSlZ2eXZDRUFjNkNBb0Q3YjlaRi9WRmhQZE5oelpoOVk5TzRI?=
 =?utf-8?B?QjRTRzdXTXh0Mmdta1ROM0hQZHFNKzhsQVh4ZjRqMHJHMTh5dHIwaElTa0VM?=
 =?utf-8?B?bTNMRHFmNDlwUzYyVjNmYUwwT01FS0FSenhnOVgycEZ5RVhDL1VlQll6R0ZI?=
 =?utf-8?B?V1V0aGZVZU1vSVdmZFh4b0VleXU3aXI5anN3QWxoMXNYalE3c3VEV3ZRanJT?=
 =?utf-8?B?Q283d3BncExoMWdCaldtalNjWXUycENZdjVuM3VkZ0JYUVRqWDV4dGFSOFR0?=
 =?utf-8?B?NnVka1o0RTVTdUo3K1ZxOEtubnEwallWU3lidnI1a3hBSUJPTk1oWXhIUTZh?=
 =?utf-8?B?MHFCUHpMcjd4NnpGc0kzeFdadHRQU2dneVVEc2FwVmZmMFRUMXp6RDN4MDA4?=
 =?utf-8?B?RlRNZXFGbERNRVd1NHRGOUE5OVBtU3A5ZmZCV0NLZ0wwV1o4SnhMMEE1YTJW?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6103af5f-366a-4815-2f66-08dd195e1db1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:03:37.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT+zynrjWUzGiIFBsKB+h9vD6CxoOaUyD7IPpFijiaFJyYT+3egeWJXDih6kXfDj7ymDkYF5i/1zj0U45LdgnO4O55jZuW+1QOupCKhf/v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-OriginatorOrg: intel.com



On 12/10/2024 9:48 AM, Shannon Nelson wrote:
> Some calls into ionic_get_module_eeprom() don't use a single
> full buffer size, but instead multiple calls with an offset.
> Teach our driver to use the offset correctly so we can
> respond appropriately to the caller.
> 
> Fixes: 4d03e00a2140 ("ionic: Add initial ethtool support")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index dda22fa4448c..9b7f78b6cdb1 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -961,8 +961,8 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
>  	len = min_t(u32, sizeof(xcvr->sprom), ee->len);
>  
>  	do {
> -		memcpy(data, xcvr->sprom, len);
> -		memcpy(tbuf, xcvr->sprom, len);
> +		memcpy(data, &xcvr->sprom[ee->offset], len);
> +		memcpy(tbuf, &xcvr->sprom[ee->offset], len);
>  

Makes sense. The eeprom API doesn't require reading the entire EEPROM,
and can use offsets. Previously, you copied always from the beginning
which results in failure to copy the correct data out.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  		/* Let's make sure we got a consistent copy */
>  		if (!memcmp(data, tbuf, len))


