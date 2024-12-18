Return-Path: <netdev+bounces-152976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC99F67D0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B30A7A41DF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33631B4257;
	Wed, 18 Dec 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4CzWLpg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBB1B4235
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530363; cv=fail; b=aQXBuWEHnLkJtuBkIojbf/lT5VmewErRej0CLM0qTXr03QhwaNWHBX5nrStwYWCF72rCfbsX9lNXwvT1YF365S6m+Qv9VnGUiWOWpYylvZUhgUYczZG1gdnlS917d9zz58VAwTHPrCxq4nP226x5IPqTR9LKelX4CWTRPZaCAXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530363; c=relaxed/simple;
	bh=oZppF8eLutMcvTaCxgvmI0eMTGA9Fvhc30VGmqNYQEc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h011qk9TUT7rh9LmiBqLH+wmjyLKH15t4kdhapqlpmI/Ze++IZqHwGUajNm3BcDfjy6R9eqETMIokGInvlZ2JdQArzCfGyYgYoj8da7ljEAxhhcLQX6LzLUvDua+QHhNR6AlnjAVhQC8v2eKL47KW6Tm21JBcOQbhnt++/zhn8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4CzWLpg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734530361; x=1766066361;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oZppF8eLutMcvTaCxgvmI0eMTGA9Fvhc30VGmqNYQEc=;
  b=f4CzWLpgwnPTRTA0ClQ65+F6FL+h4QjisDbdxNeijAAAodRAJDa35yMk
   lFAMGzysmpqKIlqTHanr+sNrI1wj5r+43Av92bKiCH+LtSJ+KSK37+owt
   Srt6na/58RtLJghDOKpPv22L1Lz2eD1x8D88jhk2NNkrZ1ywanYjfcYT5
   oqguXgHgbxkIyi16OGChBOksVGGuJaM1/jFLffDQBZlqa6Z6dTr+tSEwv
   +lqOJ+p9z2QSB7ufnNfKqG58Nt/0G8zWPZ5Q4h//BOgEPQs7kxQMklatS
   IY2Z7YcIhyIfGRGidui/e3b4DtIterFQe56NkUqrBVHTV6YJybk8icQfY
   g==;
X-CSE-ConnectionGUID: OLcbGh2GSRWY1rRJpnYu2A==
X-CSE-MsgGUID: v7DiK0+QQuC7SQQN6WvtCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35038053"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35038053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 05:59:17 -0800
X-CSE-ConnectionGUID: 179VdclkQ32+A21Qi7EIuQ==
X-CSE-MsgGUID: tt7I9ZAuTya3CBBWTIWxlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128854263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 05:59:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 05:58:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 05:58:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 05:58:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTl/0XRMAR904jRc2kwMctZbwcG5zNjmIP+TY0fF8EIitMb/ZgOYYjIct5zvA+ZBbJXdPqoWFnbteCxB3krGAGOG56yTXBC7aGAcUzaXshpIz+wxohcpbtbKZox1xKVjPtk0wD91J1kccbioDX+1VLWPsiSIx9y95HWgwlCTQyPsWIP62sRAAbEQsBkllDybNJe8KGdBFNkaEhr45slb4W2ru2Tf2yMV0dLhYccDtfn9oV7bv8xN2Ls2SUoMG3ENjwZim6B7CUZbOwjpTs96PWvKLiUBkDq5O6PXMxgzvrJW2ZF1dnCZHEgeH3XoLO3wnRB/S4fHeycoGZR7d+FDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cecOXXSdjOeHEDcNlqXFxJr/6FZ8/rMxrS/oPcplqQg=;
 b=aK9Ku5OQa+QroPgyKIBy39jDiQOUHV5tHK0KJzjp7m198b1U2Y+z+2U18LWWkYs55l4cQ4pnEGw+8nEkJU4Y+3OOEEs7jNbwKkZuQVsGqbINaXZCQoSwNL8X3zWZMPBLzuLpJuswHAr9ji//tFGWjZFki2QzNDvk0pxsiU9CVIyFoM++ndWiqdCg/fcp952ifEJnASzUEheAKAA5bPhMU0m7rNRiqvRH3UE/x2Zq3NvL+fAl8uywEDB+zlDKN1KyqZ9QadJOlsONWVOKnYS3KdiPVHnPsTCRNqtsAVDQwzGwPEvUzVOGA3Qehs8PIkHHzlmzg5hxPGtyVyMWBHZYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7803.namprd11.prod.outlook.com (2603:10b6:8:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 13:58:30 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 13:58:30 +0000
Message-ID: <efa084c6-8a06-4345-8bbc-5e6741dc5d0b@intel.com>
Date: Wed, 18 Dec 2024 14:58:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/16] net-next/yunsilicon: Add xsc driver basic
 framework
To: Xin Tian <tianx@yunsilicon.com>
CC: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
	<jeff.johnson@oss.qualcomm.com>, <weihg@yunsilicon.com>,
	<wanry@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105023.2237645-2-tianx@yunsilicon.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218105023.2237645-2-tianx@yunsilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:50::30) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: f176ae1c-81fe-4f1c-3a4b-08dd1f6c0d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dStBcUtuK0d3dU0veGdYTktlWU5hOFNld2V2Mi9FU1g5Y3NlWmczOERSbG1m?=
 =?utf-8?B?b2JtTGY1aTZCVDUyOUJvNTRmMk1ad25LRnF1UERhZmFYYi9ldDQrdDZqL0da?=
 =?utf-8?B?Y2cwblJLKy9QSkl5RkFhM2pFOUJHL3M0alBGNnA4MGxBdXdXblhZVUd3cEhl?=
 =?utf-8?B?NHdvdkVJOGJBazlqa0hTN2lKNnZFaHN1QXNqSnFOZTMvcUZZZThlYzQyZTVR?=
 =?utf-8?B?dWRSdTNEVk5TWWNOeVBERzgwbTR1TFF5d3lTd0Jqa0NCc1NTb3pNNS85TXN3?=
 =?utf-8?B?S0hXamc5b0syNTJOdjlka3pkRUZWUWJNeGw3UTd5VzhOMUpkNUdubDErTVpa?=
 =?utf-8?B?RHdDblNrRHBxS1JzaWVKdDdNZFVYTFlKaVJ5WEkvelpKSzh6dzFiSkl3Y0d5?=
 =?utf-8?B?bHlKUXNBQ0hTUm9ZVEdSS2xkU2p3VUtBRnpxdTZhWE5mOGxJYlYwZEhvY05L?=
 =?utf-8?B?OGY4VG1IaGNCV1pUR2RSYXpaeUJsenJJekRWd0tPZzE0M3ZhaGdBTUFtTzZN?=
 =?utf-8?B?UEFXSHduWG9pRUQ2RTcxNG5Zakl2TnRteVhRNTU3ODFkaTZ4UGdITjhIQ1da?=
 =?utf-8?B?Rk1JMWh5NkNsWU1JcFdncjBxWkYxTW9zaVlsMVFZdUVFMU9ZMEswUklvdmNR?=
 =?utf-8?B?WTFPSnVZdUVqd3BmaElsOVJsUm9EdUlGeU5wZjFSUlk5YnhVRTkzelpLd2t5?=
 =?utf-8?B?NjZub0VxbHd3ekdQM1pYMG02UGgxaHpWWkpoS2x0a1gxdklIUm03RHVLMnBa?=
 =?utf-8?B?eU5yWXdqMS8zZzRtK3FHM0RKd2M5Qy9Ta3hkNTdWWHAvS01XM0lYZmlnVkhn?=
 =?utf-8?B?SHpKdzloQ0hzejkwK2oxWVdrUUg2R3FkM0ZvSG10S2FIb3h5ZmNQWFdPbmhE?=
 =?utf-8?B?bm93VjNTS2xxUjVrM21wS0Z4NjlPb3UwdnF3Q0NVRFVpY2xJa1BobXNMQnJZ?=
 =?utf-8?B?bXNaNUp0VmdVWElhS053WklXYXN1YTBwWWFjRVEvK0JhVGpvRkw0U3U1cVZs?=
 =?utf-8?B?bW9sa1pZMTRBVFZoWERaYm9zMTVUaEtHN1A0WTdPSVczMjBDWDMwV1J3NU9q?=
 =?utf-8?B?MnNXWUNFN1hWcEg1a0VWOEZ4SmNaRVpVclBRQU9oVUxIdFREcE5qZTBuU29o?=
 =?utf-8?B?bVZNSlVaMmRTcFY5S3NEN0ZJc2ZpSlFoNXFXYkEwMC9FRkJIbFJ6UUJlVTd5?=
 =?utf-8?B?MWhPb3UvUW4xa1g2d1ZnVnlWcjg5TzVJRitrMGdXaWZIaWhyTEQwZUhRUG9k?=
 =?utf-8?B?cnkxY25mM2t0Qk1RdHZUNmlMR2MwY1NvNjBabDNFaVJrdmowOTNWdzhobGZo?=
 =?utf-8?B?N043dEUxQi9WaUNHWm82eTRGMUF1ZGUyalBXanRvWFU5NUtNQksvKzdwWGM5?=
 =?utf-8?B?NXlYdzVVQXhsSE5LcCtFVmNjQXk0eVpNamZDS0RyT09DZnVYaXNENEtpQ2hJ?=
 =?utf-8?B?b2N1Y0NmYnJUc2tWMHU3eXNKekJJVEkzMmJaOFNlRGJuZk1FMzZkMGxrc1Vy?=
 =?utf-8?B?cnBFZjlxbmNOZ0t4WFhrY2I0TDFjL3p0NTV0WDJVaitqS3hLZmlIYlc0dTFJ?=
 =?utf-8?B?eU9USkVTSkVpTzlxcWxmMW1JcWtyc0ZVRTdUb1dUQVFBMjBjaEhWb0l6eHVU?=
 =?utf-8?B?dkJrS25oS0d2cGZ4V2tCMEhZVTZkdTV5TVEvbmRmalZyaCt1ZEV4NzUwcUg4?=
 =?utf-8?B?c0NPWFFKbm1JQ2ZHYVFXcEI5YnIwSllXcXhtc0svQ2JpNWZnZmJxS25BeVNk?=
 =?utf-8?B?VndGSVdjWDRWaDB6ZXl0WE01c1ZOWjdyMUp0T245Vm5KcTU3d29WWnRreXlp?=
 =?utf-8?B?Zmt6blJjT0Q3T0pwSkFRWnQ1MmNiaGtDay9wOUpNcXFFMU55ZzRrcFdVSytU?=
 =?utf-8?Q?/vlAlrmjHcm4w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUQ3V2VRVFpLTlV1Yll2SGN2Z2Q3RS9SbmNoNStCZ1E1LzZCcE56dDl3V2FN?=
 =?utf-8?B?QTJ6dVhWazI1M3NtS0k1aUFhL000SkVxOWFOaDdVdnBPRmVLakozRHBZTWI5?=
 =?utf-8?B?dmQ0aEhjd0c0bkx4SmFMc3NVUmpwbXNXZlRiejE5azNOL2ZhQ3Z3REh3eDFy?=
 =?utf-8?B?ZlBhbzNUbHh6U2cvcTZnVkVXb3dnR1pOdE85NnBwWFZmOTU3WisrdHNiWkF4?=
 =?utf-8?B?eEdGTmR0LzhUZ1E3YThXeG5JU29HT2VyQmc1emM5a3dtZCt6RHBBQURseCty?=
 =?utf-8?B?T3IzU2hMM3YxcWhPY3NkdTFvMWF1VUdMTm1GVjJ0cTZUZ3dtdmlDaE85SlpM?=
 =?utf-8?B?YVMyNDJVR2hhTVV0RXJ3RW1ub0hkSGlxNFJJVTkyUUI1MmVKTHNrRHJxSmg4?=
 =?utf-8?B?NmdZRUhtcFFjWHpmYnFGaG5hWVZ5a0pzQmxvTk9JdjJzMUNrOEdVMElGWVhy?=
 =?utf-8?B?WTRQOTM2UllrNDU1emszTlFvNkxRZzNKZkJjZHVwdE1zU0R0RjdhUUxmZlhX?=
 =?utf-8?B?dGVqUFNHUEptckxVYnN5bzN5V3paYXBwdytzTkluOVRDSE1XbzdTMzNDVVRH?=
 =?utf-8?B?aDdoSTJRa1RNZURPOGxWOEt1dGJnRG5sby9kOEI3YXltaDZ2VnJZNlZLMTh6?=
 =?utf-8?B?WmZwck5HbmdRcWllYjlXcVVYMVc3ei9IOXNHRjhicW5UKzNORHMrTFcrUmQv?=
 =?utf-8?B?T09oVHByR2R1bCttejJGTFNHVEd5MnFCYSt0SFdMOEJCK2g0RHAxWFpwRGNz?=
 =?utf-8?B?djR6VVBQeURKa2Rpd0hmbjJtYy9EaUIvSUdLc2N2bzdpT3ZBRFVmTUdDZWwz?=
 =?utf-8?B?ZGVuSVRXa3UvRzdyV1B5YzZrclFYaFNVMWtFMGkxYStBbVB0WEVIbXdkcEpv?=
 =?utf-8?B?b1F1WnBNSHZWM0NNRU5HUG5CQXNxVEsxNmdLSERPUmdzNDR4VTdRL1UwVENT?=
 =?utf-8?B?R252ZktvQkQxUWxtWFZtYkRBYnF1a2Erb29IR2VsOHlqcTBYejJKR1BaWm82?=
 =?utf-8?B?M1RrTXJmUEZOOHEyWU5Wclh2eHhQcE9TMFpXSVRKcmtnY1Z3ajlST1UrNHhx?=
 =?utf-8?B?MzFNUkxjMU1DTTVpcXVOTEUxUVV4RlJ5S1NGdk1PQlJmdnE1RjR0Zis5WmJs?=
 =?utf-8?B?Y1VrR1BQNEx5WjliNFZMQTRpQnYwUHpCQnBFM05TQjVIbi9CNGg3ams3cDhj?=
 =?utf-8?B?dndOOXczS1pMNkQ5QVYyaTVicnpUN09QK0x6RnJzZThvMTNZV2taUDAzYWxM?=
 =?utf-8?B?YXdhc3FZZmQ3NGMyRTNTMVZLTUlHOVdRc2NySWxvUmcrTW53by9jT3l4Q0dP?=
 =?utf-8?B?WTdRVmo4dHFYWFFGNEpaZVFSaFowaytrVW50Y0NHeFV5VWtOLzZMamJHQWI2?=
 =?utf-8?B?dHAzbzlkSXV2SDdsZjJBNXZ1Y0pXaS9hNHRaOTgvZVRLMWh4QTA2ekppUUNm?=
 =?utf-8?B?RzRQaFlWSm1naWZYZjJSNXUvQlZtZWxCUDVRc2dZL1lINFpnTGp2SGRZK05x?=
 =?utf-8?B?RmZHOENSWDJreEpKZUlPNCt2eUozZERvNWJITVl6UUh1Y21qdHN4TW1JOWFK?=
 =?utf-8?B?bVE5RkRTa3FFMkxhY2oxWTVocXFYQ2dLTFRQNVdYUEhzTk1iWkpCQ0RNSjcv?=
 =?utf-8?B?NFcvRGxPZ0ZuclRmeUlqZFpPN3h1NVhVNENrOW8yWWdhdEVHMER4MWREa0Rj?=
 =?utf-8?B?bHN1R0pMZThYM1FoWGFwUmFibnNMQVhpVmlPYmp6Z2x2eDR6Z1lGSlVqMGhq?=
 =?utf-8?B?YkxmaDZWejF3Wk5qTm1LOXd1eHJXVENVZ0dUR00wV2NLWUZoTmxjbDd0M2ps?=
 =?utf-8?B?d2daNmF0RWVRWDd0aWxZbHRWSWZQaEx4QWgvNVN6RVA2SWZUM3Q2WjV0bCth?=
 =?utf-8?B?QVlTVSt3eS9wbEtGZnU0S0hhV0kzVnJ0QjE4ejR4TWRqSTRXcURMQ3NoMFhT?=
 =?utf-8?B?bG41WDRuVVBFaU5ZVjQvN3hiNmVOdk5nQ0JOZEFiQXU1VHB5N1BtWjNYUXN1?=
 =?utf-8?B?Q0lJamFZcFpIbEw1TnkxUUdaemd2Z1VtNzB3SGVnbmNnUko3cGgxUFlnUElP?=
 =?utf-8?B?YzZ5djFxcXFpd3BsN3BvTmFuRG96OTNNdGdQSUo0Q3pPSCtRajdWd0c2WXl0?=
 =?utf-8?B?TEliZkdHQWdUaXN1aTR0WWY4RGxOT3Z3RExudlQwUnMraG1IVmg5M1pHbUFn?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f176ae1c-81fe-4f1c-3a4b-08dd1f6c0d84
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:58:30.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qO8kSssr3vDnYniqyyH7ba6r+vUXgEEjgcByFhK/HwdMvAeKr8N4Ak3I+MBgRPE8whgPXjzed2NRWc/EXpWTPMNt3FW1DJ8pz9eGHZsVaOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7803
X-OriginatorOrg: intel.com

On 12/18/24 11:50, Xin Tian wrote:
> Add yunsilicon xsc driver basic framework, including xsc_pci driver
> and xsc_eth driver
> 
>   
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <Jacky@yunsilicon.com>

Co-devs need to sign-off too, scripts/checkpatch.pl would catch that
(and more)

> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ---
>   drivers/net/ethernet/Kconfig                  |   1 +
>   drivers/net/ethernet/Makefile                 |   1 +
>   drivers/net/ethernet/yunsilicon/Kconfig       |  26 ++
>   drivers/net/ethernet/yunsilicon/Makefile      |   8 +
>   .../ethernet/yunsilicon/xsc/common/xsc_core.h | 132 +++++++++
>   .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  16 ++
>   .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
>   .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  16 ++
>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
>   .../net/ethernet/yunsilicon/xsc/pci/main.c    | 272 ++++++++++++++++++
>   10 files changed, 490 insertions(+)
>   create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> 
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 0baac25db..aa6016597 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
>   source "drivers/net/ethernet/ibm/Kconfig"
>   source "drivers/net/ethernet/intel/Kconfig"
>   source "drivers/net/ethernet/xscale/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/Kconfig"
>   
>   config JME
>   	tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index c03203439..c16c34d4b 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
>   obj-$(CONFIG_NET_VENDOR_I825XX) += i825xx/
>   obj-$(CONFIG_NET_VENDOR_MICROSOFT) += microsoft/
>   obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
> +obj-$(CONFIG_NET_VENDOR_YUNSILICON) += yunsilicon/
>   obj-$(CONFIG_JME) += jme.o
>   obj-$(CONFIG_KORINA) += korina.o
>   obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
> diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ethernet/yunsilicon/Kconfig
> new file mode 100644
> index 000000000..c766390b4
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config NET_VENDOR_YUNSILICON
> +	bool "Yunsilicon devices"
> +	default y
> +	depends on PCI || NET

Would it work for you to have only one of the above enabled?

I didn't noticed your response to the same question on your v0
(BTW, versioning starts at v0, remember to add also links to previous
versions (not needed for your v0, to don't bother you with 16 URLs :))

> +	depends on ARM64 || X86_64
> +	help
> +	  If you have a network (Ethernet) device belonging to this class,
> +	  say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Yunsilicon cards. If you say Y, you will be asked
> +	  for your specific card in the following questions.
> +
> +if NET_VENDOR_YUNSILICON
> +
> +source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
> +source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
> +
> +endif # NET_VENDOR_YUNSILICON
> diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
> new file mode 100644
> index 000000000..6fc8259a7
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Makefile for the Yunsilicon device drivers.
> +#
> +
> +# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> new file mode 100644
> index 000000000..5ed12760e
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#ifndef XSC_CORE_H
> +#define XSC_CORE_H

typically there are two underscores in the header names

> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +extern unsigned int xsc_log_level;
> +
> +#define XSC_PCI_VENDOR_ID		0x1f67
> +
> +#define XSC_MC_PF_DEV_ID		0x1011
> +#define XSC_MC_VF_DEV_ID		0x1012
> +#define XSC_MC_PF_DEV_ID_DIAMOND	0x1021
> +
> +#define XSC_MF_HOST_PF_DEV_ID		0x1051
> +#define XSC_MF_HOST_VF_DEV_ID		0x1052
> +#define XSC_MF_SOC_PF_DEV_ID		0x1053
> +
> +#define XSC_MS_PF_DEV_ID		0x1111
> +#define XSC_MS_VF_DEV_ID		0x1112
> +
> +#define XSC_MV_HOST_PF_DEV_ID		0x1151
> +#define XSC_MV_HOST_VF_DEV_ID		0x1152
> +#define XSC_MV_SOC_PF_DEV_ID		0x1153
> +
> +enum {
> +	XSC_LOG_LEVEL_DBG	= 0,
> +	XSC_LOG_LEVEL_INFO	= 1,
> +	XSC_LOG_LEVEL_WARN	= 2,
> +	XSC_LOG_LEVEL_ERR	= 3,
> +};
> +
> +#define xsc_dev_log(condition, level, dev, fmt, ...)			\
> +do {									\
> +	if (condition)							\
> +		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
> +} while (0)
> +
> +#define xsc_core_dbg(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_dbg_once(__dev, format, ...)				\
> +	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
> +		     __func__, __LINE__, current->pid,			\
> +		     ##__VA_ARGS__)
> +
> +#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
> +do {									\
> +	if ((mask) & xsc_debug_mask)					\
> +		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
> +} while (0)
> +
> +#define xsc_core_err(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_ERR, KERN_ERR,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_err_rl(__dev, format, ...)				\
> +	dev_err_ratelimited(&(__dev)->pdev->dev,			\
> +			   "%s:%d:(pid %d): " format,			\
> +			   __func__, __LINE__, current->pid,		\
> +			   ##__VA_ARGS__)
> +
> +#define xsc_core_warn(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_WARN, KERN_WARNING,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_info(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_INFO, KERN_INFO,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_pr_debug(format, ...)					\
> +do {									\
> +	if (xsc_log_level <= XSC_LOG_LEVEL_DBG)				\
> +		pr_debug(format, ##__VA_ARGS__);		\
> +} while (0)
> +
> +#define assert(__dev, expr)						\
> +do {									\
> +	if (!(expr)) {							\
> +		dev_err(&(__dev)->pdev->dev,				\
> +		"Assertion failed! %s, %s, %s, line %d\n",		\
> +		#expr, __FILE__, __func__, __LINE__);			\
> +	}								\
> +} while (0)

as a rule of thumb, don't add functions/macros that you don't use in
given patch

have you seen WARN_ON() family?

> +
> +enum {
> +	XSC_MAX_NAME_LEN = 32,
> +};
> +
> +struct xsc_dev_resource {
> +	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
> +};
> +
> +enum xsc_pci_state {
> +	XSC_PCI_STATE_DISABLED,
> +	XSC_PCI_STATE_ENABLED,
> +};
> +
> +struct xsc_priv {
> +	char			name[XSC_MAX_NAME_LEN];
> +	struct list_head	dev_list;
> +	struct list_head	ctx_list;
> +	spinlock_t		ctx_lock;	/* protect ctx_list */
> +	int			numa_node;
> +};
> +
> +struct xsc_core_device {
> +	struct pci_dev		*pdev;
> +	struct device		*device;
> +	struct xsc_priv		priv;
> +	struct xsc_dev_resource	*dev_res;
> +
> +	void __iomem		*bar;
> +	int			bar_num;
> +
> +	struct mutex		pci_state_mutex;	/* protect pci_state */
> +	enum xsc_pci_state	pci_state;
> +	struct mutex		intf_state_mutex;	/* protect intf_state */
> +	unsigned long		intf_state;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> new file mode 100644
> index 000000000..0d9a4ff8a
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon driver configuration
> +#
> +
> +config YUNSILICON_XSC_ETH
> +	tristate "Yunsilicon XSC ethernet driver"
> +	default n
> +	depends on YUNSILICON_XSC_PCI
> +	help
> +	  This driver provides ethernet support for
> +	  Yunsilicon XSC devices.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called xsc_eth.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> new file mode 100644
> index 000000000..2811433af
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
> +
> +xsc_eth-y := main.o
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> new file mode 100644
> index 000000000..2b6d79905
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +# Yunsilicon PCI configuration
> +#
> +
> +config YUNSILICON_XSC_PCI
> +	tristate "Yunsilicon XSC PCI driver"
> +	default n
> +	select PAGE_POOL
> +	help
> +	  This driver is common for Yunsilicon XSC
> +	  ethernet and RDMA drivers.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called xsc_pci.
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> new file mode 100644
> index 000000000..709270df8
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> +# All rights reserved.
> +
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
> +
> +obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
> +
> +xsc_pci-y := main.o
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> new file mode 100644
> index 000000000..cbe0bfbd1
> --- /dev/null
> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
> + * All rights reserved.
> + */
> +
> +#include "common/xsc_core.h"
> +
> +unsigned int xsc_log_level = XSC_LOG_LEVEL_WARN;
> +module_param_named(log_level, xsc_log_level, uint, 0644);
> +MODULE_PARM_DESC(log_level,
> +		 "lowest log level to print: 0=debug, 1=info, 2=warning, 3=error. Default=1");
> +EXPORT_SYMBOL(xsc_log_level);
> +
> +#define XSC_PCI_DRV_DESC	"Yunsilicon Xsc PCI driver"

remove the define and just use the string inplace as desription

> +
> +static const struct pci_device_id xsc_pci_id_table[] = {
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
> +	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
> +	{ 0 }
> +};
> +
> +static int set_dma_caps(struct pci_dev *pdev)
> +{
> +	int err;
> +
> +	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	else
> +		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +
> +	if (!err)
> +		dma_set_max_seg_size(&pdev->dev, SZ_2G);
> +
> +	return err;
> +}
> +
> +static int xsc_pci_enable_device(struct xsc_core_device *xdev)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +	int err = 0;
> +
> +	mutex_lock(&xdev->pci_state_mutex);
> +	if (xdev->pci_state == XSC_PCI_STATE_DISABLED) {
> +		err = pci_enable_device(pdev);
> +		if (!err)
> +			xdev->pci_state = XSC_PCI_STATE_ENABLED;
> +	}
> +	mutex_unlock(&xdev->pci_state_mutex);
> +
> +	return err;
> +}
> +
> +static void xsc_pci_disable_device(struct xsc_core_device *xdev)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +
> +	mutex_lock(&xdev->pci_state_mutex);
> +	if (xdev->pci_state == XSC_PCI_STATE_ENABLED) {
> +		pci_disable_device(pdev);
> +		xdev->pci_state = XSC_PCI_STATE_DISABLED;
> +	}
> +	mutex_unlock(&xdev->pci_state_mutex);
> +}
> +
> +static int xsc_pci_init(struct xsc_core_device *xdev, const struct pci_device_id *id)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +	void __iomem *bar_base;
> +	int bar_num = 0;
> +	int err;
> +
> +	mutex_init(&xdev->pci_state_mutex);
> +	xdev->priv.numa_node = dev_to_node(&pdev->dev);
> +
> +	err = xsc_pci_enable_device(xdev);
> +	if (err) {
> +		xsc_core_err(xdev, "failed to enable PCI device: err=%d\n", err);
> +		goto err_ret;
> +	}
> +
> +	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
> +	if (err) {
> +		xsc_core_err(xdev, "failed to request %s pci_region=%d: err=%d\n",
> +			     KBUILD_MODNAME, bar_num, err);
> +		goto err_disable;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	err = set_dma_caps(pdev);
> +	if (err) {
> +		xsc_core_err(xdev, "failed to set DMA capabilities mask: err=%d\n", err);
> +		goto err_clr_master;
> +	}
> +
> +	bar_base = pci_ioremap_bar(pdev, bar_num);
> +	if (!bar_base) {
> +		xsc_core_err(xdev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME, bar_num);
> +		goto err_clr_master;
> +	}
> +
> +	err = pci_save_state(pdev);
> +	if (err) {
> +		xsc_core_err(xdev, "pci_save_state failed: err=%d\n", err);
> +		goto err_io_unmap;
> +	}
> +
> +	xdev->bar_num = bar_num;
> +	xdev->bar = bar_base;
> +
> +	return 0;
> +
> +err_io_unmap:
> +	pci_iounmap(pdev, bar_base);
> +err_clr_master:
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, bar_num);
> +err_disable:
> +	xsc_pci_disable_device(xdev);
> +err_ret:
> +	return err;
> +}
> +
> +static void xsc_pci_fini(struct xsc_core_device *xdev)
> +{
> +	struct pci_dev *pdev = xdev->pdev;
> +
> +	if (xdev->bar)
> +		pci_iounmap(pdev, xdev->bar);
> +	pci_clear_master(pdev);
> +	pci_release_region(pdev, xdev->bar_num);
> +	xsc_pci_disable_device(xdev);
> +}
> +
> +static int xsc_priv_init(struct xsc_core_device *xdev)
> +{
> +	struct xsc_priv *priv = &xdev->priv;
> +
> +	strscpy(priv->name, dev_name(&xdev->pdev->dev), XSC_MAX_NAME_LEN);
> +
> +	INIT_LIST_HEAD(&priv->ctx_list);
> +	spin_lock_init(&priv->ctx_lock);
> +	mutex_init(&xdev->intf_state_mutex);
> +
> +	return 0;
> +}
> +
> +static int xsc_dev_res_init(struct xsc_core_device *xdev)
> +{
> +	struct xsc_dev_resource *dev_res;
> +
> +	dev_res = kvzalloc(sizeof(*dev_res), GFP_KERNEL);
> +	if (!dev_res)
> +		return -ENOMEM;
> +
> +	xdev->dev_res = dev_res;
> +	mutex_init(&dev_res->alloc_mutex);
> +
> +	return 0;
> +}
> +
> +static void xsc_dev_res_cleanup(struct xsc_core_device *xdev)
> +{
> +	kfree(xdev->dev_res);
> +}
> +
> +static int xsc_core_dev_init(struct xsc_core_device *xdev)
> +{
> +	int err;
> +
> +	xsc_priv_init(xdev);
> +
> +	err = xsc_dev_res_init(xdev);
> +	if (err) {
> +		xsc_core_err(xdev, "xsc dev res init failed %d\n", err);
> +		goto out;

return err...

> +	}
> +
> +	return 0;
> +out:
> +	return err;

...so you could remove last two lines

> +}
> +
> +static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
> +{
> +	xsc_dev_res_cleanup(xdev);
> +}
> +
> +static int xsc_pci_probe(struct pci_dev *pci_dev,
> +			 const struct pci_device_id *id)
> +{
> +	struct xsc_core_device *xdev;
> +	int err;
> +
> +	xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
> +	if (!xdev)
> +		return -ENOMEM;
> +
> +	xdev->pdev = pci_dev;
> +	xdev->device = &pci_dev->dev;
> +
> +	pci_set_drvdata(pci_dev, xdev);
> +	err = xsc_pci_init(xdev, id);
> +	if (err) {
> +		xsc_core_err(xdev, "xsc_pci_init failed %d\n", err);
> +		goto err_unset_pci_drvdata;
> +	}
> +
> +	err = xsc_core_dev_init(xdev);
> +	if (err) {
> +		xsc_core_err(xdev, "xsc_core_dev_init failed %d\n", err);
> +		goto err_pci_fini;
> +	}
> +
> +	return 0;
> +err_pci_fini:
> +	xsc_pci_fini(xdev);
> +err_unset_pci_drvdata:
> +	pci_set_drvdata(pci_dev, NULL);
> +	kfree(xdev);
> +
> +	return err;
> +}
> +
> +static void xsc_pci_remove(struct pci_dev *pci_dev)
> +{
> +	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
> +
> +	xsc_core_dev_cleanup(xdev);
> +	xsc_pci_fini(xdev);
> +	pci_set_drvdata(pci_dev, NULL);
> +	kfree(xdev);
> +}
> +
> +static struct pci_driver xsc_pci_driver = {
> +	.name		= "xsc-pci",
> +	.id_table	= xsc_pci_id_table,
> +	.probe		= xsc_pci_probe,
> +	.remove		= xsc_pci_remove,
> +};
> +
> +static int __init xsc_init(void)
> +{
> +	int err;
> +
> +	err = pci_register_driver(&xsc_pci_driver);
> +	if (err) {
> +		pr_err("failed to register pci driver\n");
> +		goto out;

ditto plain return

> +	}
> +	return 0;
> +
> +out:
> +	return err;
> +}
> +
> +static void __exit xsc_fini(void)
> +{
> +	pci_unregister_driver(&xsc_pci_driver);
> +}
> +
> +module_init(xsc_init);
> +module_exit(xsc_fini);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION(XSC_PCI_DRV_DESC);


