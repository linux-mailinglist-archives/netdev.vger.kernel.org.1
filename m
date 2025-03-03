Return-Path: <netdev+bounces-171289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA122A4C5E6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D861885517
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58196214A81;
	Mon,  3 Mar 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAJWPLQA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C0214A71;
	Mon,  3 Mar 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017536; cv=fail; b=ia0OYGajWPk/P+xgy4MjFON7q+Vtap4bzxEnNCF5GvvrBLq52txcF7H1U6pCFwqbthoAtjZ6qxFX7JUqdv0evoBRsEFylmmmzJT785pUgy+mIKlRbQ8ib/cNwbzkLbD1GAG/TccukR63ZBBYjK7cr0k7/LO+vTZMGFCHo/fStn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017536; c=relaxed/simple;
	bh=xYUyOXGagPf9377SY5MNwAr3egY8XhMHLuBKqy779uw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCIKCXF6aRHefd0QXd3xqYwWwk0dz1YPnH6mr6H+iZDZZEr+eVQIpbBe15JeAxkPgDFWWMqy9sZjtQHRqNvXqZeqBA+37UTdyQfRVigFpvPkr6j/9H4WmpOdYsKrCnGmwM+ejNBV99i37jutLVJjrdgT5LbcrzRQzBCnnSaj9sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAJWPLQA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741017535; x=1772553535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYUyOXGagPf9377SY5MNwAr3egY8XhMHLuBKqy779uw=;
  b=EAJWPLQACYXiLj5p/3GhQTWQPpvvQrO3CUOOxcFHHLzeTHa1/2y9LOzp
   2jm72UZ2qz92T7EeIfeEoi2ruQ4QH3zLUabB71YplQaOg7fmBlaIvwEMR
   II7H4+bRzKFPs0wSo0hPz8MYqTRlJqCVABXqPhddK/oMWI5gjABmBDNb0
   COYxzrzoMbts42oWXHBbY608YN47AECmGlUx9RI8sSYJBRNd0DVKhL/S4
   cE7XogoKwtoqIjaHTNzvJHOpRNCaRsZbLTOy3kxq1hIv9D7sLs1FLhNUr
   5DWd+oJibG3sjb6ONmhucXQ/nL2KfiwJeGakZnbvmVDl1f0CoHeen6cUL
   g==;
X-CSE-ConnectionGUID: xYyvHBLjTsaFqRnolDR39Q==
X-CSE-MsgGUID: +Q/R2El3T9++cgtPU96M0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="64344280"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="64344280"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:58:54 -0800
X-CSE-ConnectionGUID: 0UAMHAhRT/6fCAGyAyNV0Q==
X-CSE-MsgGUID: vOq5Bqr5Q261Nm28tk7+8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117910752"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:58:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Mar 2025 07:58:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Mar 2025 07:58:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 07:58:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx7EVTrZ1VdJy7gWkEdZ7pNipH69ehbOE2SpUoEMs8guChNoBUV1rqlDLt8qhFK85Rwk7qQLi4ZAQeOAKTZqqufe+g+NCBFv2nuP8mwcgwADULivVVRKsynt/c4Q6Np/kfZQENrZDTNwpcJY2dFJE+NY8dOhW56BPAFOrxJBlkj5cx4sw7jLgEh8sTcGD3Iwksv5sDmh4ola0/me8m0EXMwZ3aX5t/ZDez4/gvieEF6omw4+kWWqbAYoy6EbfIWldGt4nQ/6xLgl+qqHiHzci2ggqBhb2Y/T29LfL2QuFCf3MKL5oYdJy2V9EdNE2UaYKlIHfdamzPQOJuTkujMOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0exio2aL0Omo9+b9ca5r16RaDX3QCU5j0TAHjU75WZ8=;
 b=aAAXzyjOqalSqLF/3rn46Nsz9gPTo4gIzCrXN2m+5Ddkk2xvgD8duPAuYJcozuEsMMNz0aure6hs9VbAOwur7mgI1/ozODxzAWJu0G9+VumJ8j+uBVXUdQ+C+VmdlTUPSRdtZ7yWmzCEQoQ0WHTPshSYlS37Y9Gm9o7Rl5u2QOolel7QppngLnmbmPJCC39t6Tbw81YW8svUmvOC5SF7tr7WakOW4bT/dO+qjOFCd/n419ATRjeBwlsTVyGId9+vEQRwlZWgEY09175NXHLB437lbZ3srzondWuAyss2LK7CSmR+bIxCWd6wuWMSzJgmMBH6zfKaW+KhnZrDNxnfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 15:58:49 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 15:58:49 +0000
Message-ID: <89a97249-ca35-4cb8-a037-27dd7d8c0102@intel.com>
Date: Mon, 3 Mar 2025 08:58:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Prevent use after free in
 netif_napi_set_irq_locked()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <5a9c53a4-5487-4b8c-9ffa-d8e5343aaaaf@stanley.mountain>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <5a9c53a4-5487-4b8c-9ffa-d8e5343aaaaf@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|MW3PR11MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: d49b735b-e3d4-40d4-8f83-08dd5a6c49b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejYxbThtbFhmYWZ0RjJkbE9BVExUbEd5RUE3ZTBCeVA4QjFad0l2Q0hEc0dQ?=
 =?utf-8?B?K0IvbVhMM1l4dXhkY2dlWXNzWXJURnVCNSsxNDZMMllLUUwybllmdStxWWM1?=
 =?utf-8?B?YWpyS2xtalk1cFpoTHpjUGRHdDlpQ2dscjdlVGtIcUZ2R3hSMHQ4dDgyYUFk?=
 =?utf-8?B?blBBTVFBNVUwdXBhbCtKd2lsQStmb1pURk5JTHNJa2drcnlWbXkwMlAyc1Bz?=
 =?utf-8?B?T0hhZi9oTUdFU1R4eWs3d3R6ZGNvVWt3ODNUcFRZUUNNcm1mejJFLzN5S0FD?=
 =?utf-8?B?VWRWdlJONTI0UWlDNHU3R2g5ZG44dWgvVFB3QTB3bHpKT045bVNvVXVuc0Iz?=
 =?utf-8?B?dmdGRmZoSnVZNHRrdUtkZktRNXJNV0lqWG45Qmtycm5GNUcvOE9raDlBZkkx?=
 =?utf-8?B?eVltelB4dWhUdzFkWnJLREQ4aHcwWFpWb0lvRFFKWmpESXlhcjB0enArVitZ?=
 =?utf-8?B?S0tubFVTY2xpYk5iWlpKUWZlR1VUMDRjRFh1aTY3cUVSSkYxN0JoZUpKSlBm?=
 =?utf-8?B?WXlacDlyTGdTM3lkWjVlUm5JNG0xZXFFNGVFVmVwVklsSEJNTno4bjRuSGVw?=
 =?utf-8?B?OXc5b1AwZ3IrSTRBOVVyeW1IcEFMZGNLMkNiVmxxcEFjOUVyRVdhUWR2cmlh?=
 =?utf-8?B?L3VQSldaN3Y4UzdpU3pnanpmRy9WVE1McFhWZ1I4a0o3dFZGMjlLeW5CMmdm?=
 =?utf-8?B?TmxnYVJBMzBHYmRuR3J4TFErTVIyNDlmTGFoSUJvSkYzZXVsL3BlU2lUNU8r?=
 =?utf-8?B?RFJWb0U5K3JOUE5ITC9mc0p2NWVMZW1MT251S2lUQXQ5UVBTbGVLL1hrL0Vp?=
 =?utf-8?B?MFZpOGtkenB5WGpZYkNoSGoyVUJSWEJlUTZvckErckZETkxucW5CSVJLMGho?=
 =?utf-8?B?V01XZFcveGJEbG5QeFE5Z2tiYkNMSVNicmtaVmpUR2c4UklrZjVDN2dOaURu?=
 =?utf-8?B?eUZ6MG82ZDBYclo1aGR6dThraUpPY2hPUWkzb1JQeGRyYUxnaFdNT2NvTGZm?=
 =?utf-8?B?Wk42RTdxV3FyNnJSMUx1d3RIcnpBSlZDT2lUU0VDaVMzRGovOXI3TE5vODlU?=
 =?utf-8?B?RmJoQjBQZGV3VHpRQnhVRkRuajB2b0lyN21Ra0JpZVBmSXpxQkRKbytDLzJW?=
 =?utf-8?B?V1hEU210OTMwdkxmMVJaenBlMXA5K2ZQaU5lZU8zR1hTejhrUkJrcUs0NGJW?=
 =?utf-8?B?aTNLTFpvVy9HVmlBVERTZWJVZHRHdm1nT3hIZEk5OVl4TTZiOU1jZGpwZWpy?=
 =?utf-8?B?Qm8vRGU2SEh5MFJsOTdCMEhJTHRVVFFVWmxhcU01WFNuK1oxc0ZXdVJIekhx?=
 =?utf-8?B?MDdWeFdNamF3dTBUamFuVmNXZ0RWM0FMMDlpL1d0NzN1U0wrSnozT0VlQVNp?=
 =?utf-8?B?NTd6TXNiYzVMM0NiRFh0cmdiUmZhTDFCdmxXVjI4M3RlckZHWHNXZXV1L3Bh?=
 =?utf-8?B?YVVwZlRmYkFwTVZIOTZqK1FHL0xPMWcvV1VJL25lTFo2QlVTMGVYV0hUTUNz?=
 =?utf-8?B?cHh4SjVaYUM3TXl3c1RncGpTTDEyNXU3Mlc5L09xOEQ1S3lwa3R6NTdyTTlK?=
 =?utf-8?B?ZG1tRk94MTRvWExiV0pxem45MjdING44YUcvWnZNSk55KzV4cGVrQ2lUMW45?=
 =?utf-8?B?WlNJMnovcm1ONmxxNDQ3MnN3TmFvaHhVdXdoWXZzSDlEVDljaE1UdjFER0ZW?=
 =?utf-8?B?ZUpFeEpnMzdlNlZJS0k2N3BmdHRnb0lTK3UrSzJTNU9aczVrU2RrQUdLb2Rk?=
 =?utf-8?B?WU1yZGRwK252a25IY09NZk9nbmpkVmpzakVuUUdkc2NTN2IvMitYQ3M5MmV5?=
 =?utf-8?B?RiszSmF3cFNQYmk1RzVvbDFCVU55dXoxYjB3REU2djd2SVFlNkMxZWpZZSs2?=
 =?utf-8?Q?TESeJhTHQMnaP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktFSmppek8rcks5RDNYM2JZQ29mTDV5K1owa25zWm10RnNOQ2R5QnlFZEl3?=
 =?utf-8?B?TnozSDMvWnFZSW9OK28yWkpHN3pURFdHQ3QxVU1JWlI0aTVFVXFsRlFTYXFS?=
 =?utf-8?B?ZXV2TVkzQXBnWU53N20rSGxzdk8vQlBldU9PVEhrUUZyMm94cU1oY3ZncERZ?=
 =?utf-8?B?dmhjYWErSkREYXNSKzhDNjYvbFBDNDZQS1EvalgxRi9QSzFsRWxHTzVHS1Zv?=
 =?utf-8?B?c205cVBXQnlMVE1iZHJMQ281MzgzaXZwemtnOGFEREtQdXV1N1lOcnhXNjgw?=
 =?utf-8?B?UHRTVlZLUDY2azJ4NXY1ajJYYy9yL3dpWDdTMmlHdjBhQXFEMVVJeTZUaVNW?=
 =?utf-8?B?YzU1YUpKRllEM1JIUlNyYW9MYUFqYUh2MTdrNmw3VTFnT29TNGkwZUE4bjNC?=
 =?utf-8?B?WkdCUkFmUkxIelpxTWFUeS9NSWNwczBoQjNEMHMzaldYNzdDR2U3MkNBZHpy?=
 =?utf-8?B?dTQrVDRmLzJWZHU4S2RTS0ZJc2w1WVJYL04rdUU4MTJJRWhQZnlRZ0QyV2pI?=
 =?utf-8?B?M2ZtREpPbUlON1lBY05UNzBPNzNlY3A5MzgvRXN2ejg1WXVIOGhSMzBmSVdG?=
 =?utf-8?B?QlE5aDltZ0FNM251L2M0dTlIN2prMU1BZlVnUUNKSHFmTWVsV0NHaXBmVWll?=
 =?utf-8?B?RnlkQW1QU3hEczJ3dmFjbStMRFdDYy9YSUIwRUpFa2o4SHdIWHFndnNsUGF2?=
 =?utf-8?B?cVVXZllSWDFLOWhxTVRCM0lGQStqemZIZXFUeWpoZGs0SXJ6SzhOMWF2czQx?=
 =?utf-8?B?VTlvMm9HUHE2cHhnR3dITUhtVW5KL0gzdlJZWnJqc2h1VHF2aXdZVjl2QUpm?=
 =?utf-8?B?dWt2VGxkSzIrT05VS1N2RGxGV3ZQOWJCTWFtOGpsbnk0TS9wVmx3dTNRandZ?=
 =?utf-8?B?K2VGVXBVL0J3eVI3cERORTNHMWxBb3ZId0JPNGtmdFJqMEVKbGdUTHVCM0Nh?=
 =?utf-8?B?dExrb3BFV1doQ2FZSDF1WGdveEQ1Z1dWTXlua1k2cVJIQjB2Tk9qSlRNT2hS?=
 =?utf-8?B?bDZZdWNDZElMaER6RWxCNGhjdVRFRG83aEZzZHJFVG9ZbFdoYWFHVUk0RWl2?=
 =?utf-8?B?Z2N3ejlJRXNkeERXMTFVMVl2aHZsM3NZbnloNGNwcjRITjAzc3FuYlR0SW82?=
 =?utf-8?B?YlphUExHYmZJdWkzajZEd0I1OW1lZWJwNTNiSEV1cUxkbTZLalFlQ1RpTU8y?=
 =?utf-8?B?RXdrcERGejlPWUN6ZEY4djJwNmJsSm9lbEJyazVDR2FRNUQ1NEp1OEFVZlNi?=
 =?utf-8?B?cVJVVDBlNTFOMlE0R3lGNUJtZW5wTlR4TXV4cERya2RZWjdlVk9xRlM5eDJV?=
 =?utf-8?B?RUt1K0VBNzdhbEE0N0hDcXJGRkRVRmlWZ3YvYVlkMzZYUVlOcm80Q1JJeWxD?=
 =?utf-8?B?OFpVVDlhRXUxc3F1ZDZMMW9mMTRGL25NTkpqTTVuTUdFWloxZHJTZStyTWtZ?=
 =?utf-8?B?L3pYcmpLR1lncm5mWnhOTEhHZjUwN1oyVFJoS0dBK29Kbm1sVUdjZStKMStv?=
 =?utf-8?B?YVl6SWEwMU9NZGNNU0lHQTl3ZWNkWlpuSmhBOWE1dE5FVit1dHpraFRFZndj?=
 =?utf-8?B?dk93YUhaZE1VZU55U09sNGVTZENXWUVRNlVUS0Y4ZkE1dW1Rb3dhT1FVb01V?=
 =?utf-8?B?bGdMOXVTa1Vmc3FGa1p6WU5hR3dyVWc4TmtVN2xNZW9GVENodlhUVGVMMlR5?=
 =?utf-8?B?RjlRd2U0K01sRTUxMlJ2bTRSVlkvcVhTc2VlbmFEbUFGS2FQMi9rY0FNMjVL?=
 =?utf-8?B?ZzZnKzVLejFqRGp2ci91THdSaDFyTGFCM2J0aUIxblRPRlpUYzNGUmFyUUpM?=
 =?utf-8?B?TzlYdG1BbzFIeEZCbC9nNTluSXQwcTFqZ2F2VkR4OUhuWWhGTHMyWFMzYWpW?=
 =?utf-8?B?UGlvbkpmNlJzUTRDZzlTMEZ3S2lrQmpiSHd1THJ1ZEFaaFFXMHJVV2FyMFNp?=
 =?utf-8?B?SCtPaEJja0NJSmhvaThrc01MbUp2NWU0cDVNeG9QaXJhR011YTFKYVB5MnFs?=
 =?utf-8?B?L1NvZ1NoWmJkZE5iMEs2RlpzMkVBQVNnSEdISFJ2TnJwQ3RtRVB2L212SUsv?=
 =?utf-8?B?RUdTM3JteVh4S3hxdzl5Q3pvV3ZyQmVIUWhyR08wZlNiZnRyV3ZEWktTRzdk?=
 =?utf-8?Q?SXMqroZM+tWfHH0Nhor7AkpFb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d49b735b-e3d4-40d4-8f83-08dd5a6c49b3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:58:49.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFSYoxzMZRcZmedRN6PerR4wF64RJClP4X0jRRYjIFk7zAwHMAI2LDnxzGKQSTSX4HIj6YlGdxlERg9VzrA+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com



On 2025-03-03 5:02 a.m., Dan Carpenter wrote:
> The cpu_rmap_put() will call kfree() when the last reference is dropped
> so it could result in a use after free when we dereference the same
> pointer the next line.  Move the cpu_rmap_put() after the dereference.

The last call to cpu_rmap_put() that frees the rmap will always be in 
netif_del_cpu_rmap(). This matches the ref counter  initially set in 
netif_enable_cpu_rmap().



> 
> Fixes: bd7c00605ee0 ("net: move aRFS rmap management and CPU affinity to core")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   net/core/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9189c4a048d7..c102349e04ee 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7072,8 +7072,8 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
>   put_rmap:
>   #ifdef CONFIG_RFS_ACCEL
>   	if (napi->dev->rx_cpu_rmap_auto) {
> -		cpu_rmap_put(napi->dev->rx_cpu_rmap);
>   		napi->dev->rx_cpu_rmap->obj[napi->napi_rmap_idx] = NULL;
> +		cpu_rmap_put(napi->dev->rx_cpu_rmap);
>   		napi->napi_rmap_idx = -1;
>   	}
>   #endif


