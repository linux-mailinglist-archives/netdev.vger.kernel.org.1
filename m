Return-Path: <netdev+bounces-175216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA54BA6465D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB230188BE1C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC4220680;
	Mon, 17 Mar 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6jLnTeY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AF21ABD7
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201789; cv=fail; b=hxZbzunpZVWrhvRa7sehLbEyQbZ82jWeJu9tB69HdNUk4giSeDrdGgBjLTrpH9IbtVBpnqu5w6oVfblSgcFp612BI51WVFI9dYAYCesAPCwXcQVrStiscwW756fyLdArchgASot0cKo9R4a1VJ6bm3dtmxoo3fRRgIW70Z4NB6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201789; c=relaxed/simple;
	bh=6XzUUDR7DJBb0cAeZT6wZOineDeS9F8J33uL3TpSdAk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nz/kmqagP3UB5TTb3FVqBeCSeJm0XFhdtbflC0PwlGdIj/l6ElaU65N6v9mEvRLp+u9+uJrTUtmHrLm9Yh50EDzC/yHHNTPtRRuKilIFPQOCo8I/dcUUKhJvB2vxZ+VtIIfrKKic/hHjSP3TPoFPssqVDUh3ZmZsAy9Hep1J+rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6jLnTeY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742201787; x=1773737787;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6XzUUDR7DJBb0cAeZT6wZOineDeS9F8J33uL3TpSdAk=;
  b=J6jLnTeYGhd83FqMyWRrvkg6u/7QHY2xIN2rHPQQxdXiN5dypxObALch
   mADpk1pIa7ncZA4Qc5FHqcDPH4iiVAMaTq2EDYHm4FGezTnu7ufhJbeYT
   0eqkggFQZJ4A7QTQbk8NooSnotYIb9bxIGNCTdyH1DgrACtbbzz9Nik2i
   6eePa7jvXCIAED8qeZC8btt1qvjs/27DLtN7Vh0JvVsIVEM7sGBkz1Qv5
   BtuGn0FphJfW54ol78rrg7vGCpxbcyieFidnvcbw79fe7rYTGa8iMUl1P
   Kr7qw4xZJMXjef+st/usow9wtF1g1r0/9Kx0tan6wH4ILCRHXSW/5ML/a
   Q==;
X-CSE-ConnectionGUID: v2jLRLRsR4+B8bIuIW/5cA==
X-CSE-MsgGUID: 2a/r1jZsQEevmDWaEuGaEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43169094"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43169094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:56:26 -0700
X-CSE-ConnectionGUID: zI4rE0r8QU6f4IUMA1FNvw==
X-CSE-MsgGUID: TB74zzKUQaeKjxJlgURZlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="152748435"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 01:56:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 01:56:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 01:56:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 01:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+0FPe60o761GuW2uJREPTA8J23K7wLCEqpBplzAoHaQ/z3zQ7j0KFdHPHfcDZN2tx7VdETmK0I/w5vR5bkaqkiiP/rTohX6x50K2iuTDV/V7DeX4tKvAVjdAHO3CszVkffhAmHfmhK1Tpjdjzqq9Frr4I50i77NvqOfaB/AuZdIIw6GsY7lms/rQj+2EWdl3ZTGGYdenDQNq0jKB2/p0WG++XA4kXkkxuYxDVh0yzn8Q5DYMCiRyTf0K0IRq7htgH758nWcH7DZpat7j3ESJRKWH5uv/jEg0KnEvmIQtNwtEgSPwaMGTsvI9/Iz6SqYHLUcXsZ6wSxMXu93W2s9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKcIi0RisDtzTKPvvg0qixfjzE+Wx8ApmaAyWQ5jFx4=;
 b=SKYMifpN6sasjB+1Z0HGZrFb2Z7zJyZg1NW/sq9pUjwnEymKrRmHR+cd6xK0Jyik2rpX8Bo+TxADc4TBe9Nyb7n4Spo3EGgIWIfA14eGSyg5NNEj99Wpbsr1IzG2V93rOtOiodjQ9QSxPssW7IKXS1K6watkrij1rZ38J1dLZHssEx5Q2bRjLWuxglCGcq2pgwbVOP0t7y4uTAuFSuLSI6rk7h4XR2qy3jKiLJlb29ACBMFC1VdIqFFxdahjFx7xLARs9NgOLfcfRBYtUoaD3B+VoJJ4rmgam1hWKVoEi7pvUlazl0sZsGd7FoPKSX93RhjPp4qqHJoHzLfyAvJrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:55:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:55:51 +0000
Message-ID: <a901bf8d-d531-43b5-a621-b2e932f67861@intel.com>
Date: Mon, 17 Mar 2025 09:55:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
To: Matthew Wilcox <willy@infradead.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, <netdev@vger.kernel.org>,
	<jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<pierre@stackhpc.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <christophe.leroy@csgroup.eu>,
	<arkadiusz.kubalewski@intel.com>, <vadim.fedorenko@linux.dev>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
 <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>
 <Z9Q7_wVfk-UXRYGl@casper.infradead.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <Z9Q7_wVfk-UXRYGl@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3ac00c-8668-4752-21eb-08dd653184fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDVKVUNISWdYczRDTVh2Kzg0RHVlMDZtNUtSYUpBMXVsaDhvOXl4WFBTQXow?=
 =?utf-8?B?aXpYWUlBVkZiZHhxOFZxSlNtdzl5TlRuUnZuVmJGaVlZaW1aOFFCWC91cTUy?=
 =?utf-8?B?MUxiTTNXNFFzOUZDcEt5Mk1udmlQYmNRb3RyN2pQNGtWdGVSUFo1TjdoamlK?=
 =?utf-8?B?Z1ZmVG5tZzZuZzFUU3IwbmFkL1F0Rms0MEQzZ2hWaTlVVjZLaFNtQUVkSXBY?=
 =?utf-8?B?OG1VN3BSdFJiWlJCem1RMFJOV1J3L05BOUZuZ3BKVk9hZTVoRkRhNTYzbmpW?=
 =?utf-8?B?N1V6UW1tcUp0U1o5ZEZaZmZBMDJVMjlnVVE0c0JlY3JwM05wUzA2M1o1T1h2?=
 =?utf-8?B?WThKb1JVSXdmekhUZnFxT254NmZtVnlLcUIycExqTzBORERVc0MzdGNyWHBw?=
 =?utf-8?B?alEwdUFnYldZUHMwZGhQKzFiLzd1UEloZHNQcnEyNldpN2JjRVRBWlg2TTNo?=
 =?utf-8?B?ZVVKSzNmZmlOYXlKZjdHblF3RjVzc3Btbm0xeUl1L3luNDViOTVZVUJKU1Rx?=
 =?utf-8?B?R0ZXN0dBUGpxR3JPamVjaGRhRFdYMTRTS2krcUZxWm1rWnlCSDZpZkNJZzVG?=
 =?utf-8?B?cEtYRlNFa052Sk9YQUtRM1dHVEVpR2NKVGFFQ0l2bjczTmZFR21DVXRNRngr?=
 =?utf-8?B?VytUL2RiekhyNDhPd0tPUlIxcUVlMWFLL2xpQkpYajBUUS9aa296SWI2czZi?=
 =?utf-8?B?VVJaRHNGdVBxcHFGZzEyU0NiWjcyMmNHNHBpN1RXZXVzQ3RRT0lKZ3EzekZH?=
 =?utf-8?B?bjRoQ3kwZGRiM0FTVTBJajlKNWpqQktYNDBIa1loZ0J1ajR0UHlqcEY3RjB6?=
 =?utf-8?B?UTZZRFhsZHdRZlUxRmNFeEFpelFvL0VGUFJuMFJsdnFYSTFHT0xBMTNTS3RZ?=
 =?utf-8?B?T1h6QXF4cmJjdWdkUDM3dUl0VWpoOWRZSUEycUZ3cUpvdFF1SGdGODZvMDZi?=
 =?utf-8?B?V3RIdnQzeEttazZ1aWxJTnpVMDV6UWlCUnhZNUJkQ3ROcCtwVnlpRG1hTXYv?=
 =?utf-8?B?RWxZSE9YMFRUTEVWRmlJZU1CMFprSWZxZzNxQTdHYmNabDNKMVdjd1Y1ZEZY?=
 =?utf-8?B?ZE9sSXNjTEY5eWxkeFg1S0M4d3ROTS94TXhJQWdIdzdGY1JQOHdnbG9ocFF1?=
 =?utf-8?B?MTZFVFd4RXJMcHFyWUExdkZZc01aOENLMFJLdmRxVE9sTHRLeTltWVNhOWJH?=
 =?utf-8?B?Z1QxTlVoR2VmczdJaThIK2VDNzB5bVp2RVZhcFpyNWtjZFAxcXNXTml0RlhQ?=
 =?utf-8?B?cW1oRDE1TjZXd2lqb25IbXlDQ3liL29hczd0YnBORFVTV2lMZHlPZVFpWDVG?=
 =?utf-8?B?OVhBYS9rTk14STE2cXdDSDliTkk3ZTZjd2JEdVp6anByL2w0MlRjV1FyQXo5?=
 =?utf-8?B?TFdBSy9MZlJJNloyc1g2MFZDN0RaWG43ZWpwU3BRb053VkxPSS9IWWcraTFY?=
 =?utf-8?B?TlNmeEx3REtiWWhyWVpIZmFKTWp0R09CSlo0bE5KZ3VJUnZXUlgzc0V5NEdL?=
 =?utf-8?B?cmVpeXRrSW5TR3FBYW9qcWdEb2F6NVpBaVBDYnpFWDVIanJhZ1I0eEVaUDNN?=
 =?utf-8?B?cGtxNWJwdkJRT0NUY01JN3RZUWs2NytJMk9ETmZTUGJBN3FNWlB0Q3lDeGhT?=
 =?utf-8?B?Z1lTVW5uYWV4OXRnTEl5d3lTODY0cko1VVJ5Zm42Rk1GNGxrNllPc3g1NldY?=
 =?utf-8?B?M1NvL2I2TktDUUgyOVFDdDgzZlFXRHFzb1ZoU3NjYzhJMy9LSmY4UDF0RUNB?=
 =?utf-8?B?bjRBRjhZejJ3VmFoY3pkVzNNSjhObTVGdU9JbkFTemVOelNLVmFZSlRGanNB?=
 =?utf-8?B?OVdTVmdESVlrUDE0aWJIWjhsRHM1NGE0cVRydnUwM0hkSlZ4aFRjSGl6clM4?=
 =?utf-8?Q?KdBUXvcgB6FGN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3MwdWVBaEhVemR5dTRqbkdWL1hPeTVsTGZ6SWR4NnhSNitRdFd6L2F1aUE5?=
 =?utf-8?B?LzJIODhvTm5YQitZbUZYaVpiMStlMEZGNFZsOGsvZm81RFBqWFl4K3FGb3Zv?=
 =?utf-8?B?ZWd3ZU1sUzBuajdFMUlGOFp3Z3JEZXhIZXhZVThrSklrSVBmQUtHb1NnUlhy?=
 =?utf-8?B?SkVjc2ZUN3dLTy90Ykk1eE9rTTBGc2N2ajRaSmxYMXQxZUNJYXkrTGxkUm1B?=
 =?utf-8?B?eC8zbUlUcXEwSnhSMk9OZldBbkJ4ZmhaRlpxd1lCMWtiT2UzTFAwMitKTHYy?=
 =?utf-8?B?cklLRzhxeGRQbDdSbmlWT0tvV3ZxRi82cE5wUUc5L09Mc08yWUl0Vjg2K2dy?=
 =?utf-8?B?S0FKcHlaTC82TkFCbndXb29XT0tsVFV0UXJ2SmJHN3J6RmpuUnRwTU5CSFBp?=
 =?utf-8?B?bEd6TCtrSm1tZlNqT1Z4Tk9CQS9xL1pleUxFRzhMamRaQW9DQmZMVmFZbG5k?=
 =?utf-8?B?UUxoT0I3SGVieXhadmNGenoxZHBhUTQwMHFWMi8zYnk3ZVVXTGZZdWtmSVRr?=
 =?utf-8?B?Sm1uelNFeit6SG5KNkhyVXl3WGFVNWN5WkxEVS8rNnVqTC9vR1NheEFoRjJY?=
 =?utf-8?B?Q0dqK3NjSEFMWi9YbjV4R2M0ZVpLczNqMUUvS3l3YW45RTNyWHJkV0JNOUNS?=
 =?utf-8?B?OUZPcXlzN25RVHNrVkJhRGh3aER2dkxNQVUrMnViNE9MYndnQm9FR0FMWjRj?=
 =?utf-8?B?clVWOFl2U0lzdnFYa3Y1VHZtWk9KeW9ERXRSTEQ3WnF5cjk3UlBkWGF5VXQ4?=
 =?utf-8?B?QmdobVBrM2VScVRYUkJyT2lLQWZFZTVmU09lRnhQK0JkMnJ0Rk5DNTlxYVo2?=
 =?utf-8?B?STlwQ0xtYXVnU1lIeitwa1JFSlpwbDFHTjNQQ3BKbHQ2WXVEOXZadFY0SVF2?=
 =?utf-8?B?bmtpVEFVRHc4Wm1mWlIveDZNcHd3RG1UQnoxendVaWxRU0JpakV4WXBndnRu?=
 =?utf-8?B?eGxYRUdqcEo2clNBUy9TU0k4OWs0aUZrc0NzR29sTVJtUVljOU5ZQTRVcmVC?=
 =?utf-8?B?U3FRSXRjSjFZQmhRQ3ZvQzJ1ZnA4cEU2cndaUEFNUzZSd3YzNTZleG5EMlFJ?=
 =?utf-8?B?WjJWbnlEOU1ibTVKdDMvSVNKWmhTajU5cXdEY0NOMjRpcTlkWC91SnROdTlk?=
 =?utf-8?B?dWQzeUNiTDQ0TFQ3L2w1L3J1eStOZWVyVyt1MWMvbnRFOTQrakFnWE1udWJG?=
 =?utf-8?B?L0hPNms0ZUJyRElmUHI2Q2ZJMGI0Tmw0VUw0ZUdrbzlHRXNIeGEyVEQ0TjBk?=
 =?utf-8?B?cGxZR0YrNGYxaEJGNkt4blJyd3dpWU9JT0pBZE5jYjZjVmoxMGhHc21kR3E1?=
 =?utf-8?B?UGFiMW52Tnhqbk5RMC9UakRwL3c0a0FFYTViZ2ljWE9sRkYrK2F5N0d6TGNW?=
 =?utf-8?B?Uzk4azA5eWJGKzhYSm12ZG5EdFBvNy9QRHcyQkM3REt0cXdTT1N0TEloNE9V?=
 =?utf-8?B?VzIxS1ZKUFBraXFPd1QwZW9XVG5GYmpWbytZVTUrT3p2RmZRK2lKa1lMKzhD?=
 =?utf-8?B?MDAxWGJhUHZxQzhPSjI5Z0ppOE8waUJZN1psOVFrVkFhVlYyT24xSEVaQXQy?=
 =?utf-8?B?SE0zWm13MUhmQlpiWEpuc0NHeG00ZU9FSFpRUWpCUUZ0VEJocjZKWE5KU2lZ?=
 =?utf-8?B?Vmg1cktINlgzbUxkR0FDY2o2VUtjb0Y3ZU83WEhmK0hMcWFqenl6cGRpcC9E?=
 =?utf-8?B?M3NmRU9OMGN2WDFhemZaNVRGdklsalR2dlVSOGg2NGtydFY5dkczRENQYm1K?=
 =?utf-8?B?cnBmeDVGNTl0aU5SckxDSGNuQmdFMEpKMm9qTUM2SlRFK01XVGpQWVZDSEpU?=
 =?utf-8?B?U0lnSCtiNFUxVUpVcDUzVklLTmVzdEQzZTFpbkY2VG82N2JUMHRTK1RRMDVK?=
 =?utf-8?B?dXR1d1hxbzJFYXlGWTF6WlRhUmJXblp0M2N3cXZ4VjlrZUZoZmpCU3ZjQVhD?=
 =?utf-8?B?RU1FeUpkd0VDcXFCVG82NFFndFlrVk9DL2pLbDZSMmtFRTQxQU5HeGZhNWNr?=
 =?utf-8?B?S1VpOHNVUHlDbXUxWlMxMEpQVTd6dHd4bjFsY0piN2ZJMnhhZDgyZ2UvQVJp?=
 =?utf-8?B?Sjc4REU1b3VZUm1ONzdWNEh5eW1jeXVNekdIOGhPM3ZpS2h4REtaSHhYNUln?=
 =?utf-8?B?NFdBaHpTVmZQTkVXR0hWRzdqWjBiUkNqdzJEZ2JsUjlXYmZEczdQSk5tN2Nl?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3ac00c-8668-4752-21eb-08dd653184fd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:55:51.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYftSzEBujPE6ureT3AeR0N4WvSwA0jHd8K1jRsGmep22UDKi7x/a9KPDqaaeiLI0vW4rDCm/EAsv2X21D18DRp+JNbifK5dz00TZ2hcSXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
X-OriginatorOrg: intel.com

On 3/14/25 15:23, Matthew Wilcox wrote:
> On Fri, Mar 14, 2025 at 01:52:58PM +0100, Przemek Kitszel wrote:
>> What about changing init flags instead, and add a new one for this
>> purpose?, say:
>> XA_FLAGS_ALLOC_RET0
> 
> No.  Dan's suggestion is better.  Actually, I'd go further and
> make xa_alloc_cyclic() always do that.  People who want the wrapping
> information get to call __xa_alloc_cyclic themselves.

Even better, LGTM!

