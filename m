Return-Path: <netdev+bounces-254941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFIgGx3ne2laJQIAu9opvQ
	(envelope-from <netdev+bounces-254941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:02:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762CB592B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6741D30054EB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14636CE0C;
	Thu, 29 Jan 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtycZg14"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871F361662;
	Thu, 29 Jan 2026 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727771; cv=fail; b=aH6ldq2Z25QYatWBLZl6Nfleec2ZxbfFSQFwbWXf+d4IDs76SEQiJWizEX/NOZi7JhWH8/uaiMycVvYbgpyHW/3l1cgHuYg7ZuM7wSSLgcYvduwVO8MJssj0nzWaqtT7sW1QCzt9LbjPjdFGvEELZohurfn1aRHUT5yqpvvbXCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727771; c=relaxed/simple;
	bh=UkYEBJBHkFDcRxaeMa0lv2vGI+/DWQOrHnj0w4v0rN8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIFsH8vDqaHzYg6TvAxqV9edWAu2ANsVU1hksXoyRZ4d6L1YyoGiKjItByVCyH+F8EfNNFGnQmq2AeMCbFDMMpPN+2j83p3GfTkI0rRjkccbQzBNyInMZRAqpNTxFJzttVgISBqcplSC86nuWGSOqz89KdwJ2kICtYppSYrbqOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtycZg14; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769727769; x=1801263769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UkYEBJBHkFDcRxaeMa0lv2vGI+/DWQOrHnj0w4v0rN8=;
  b=AtycZg14PwGaPLzbzOlqPOTKfiPYYZt2wgMWimNxZ6hS4vJvZbur2nH6
   C3ATmGA8HPn5jglzceTedlkXeCB6hMz72yK1ptQu3aD2LZiqSIw0J4FUg
   NbAcLrCecv/UiFNHOeGo0P7STv5Z9uIKIudpzKcO5CWzHhV6k2sqPjKL3
   q4Lb1bhwON9blQBwZTZO8eu2wvllHPLEN5zw0kkGg1YNV14SkeRqOF+Km
   +vllrDTebPffrdvH9ulUrSrtGN/epP93NlIkrKPGqIQfU8c1eUXudqgEJ
   Oe/PcrsTdiUH1un/SLTMmNACtZew9HntLXSEOYyGt3+Uq7jAc9k5Pymwh
   w==;
X-CSE-ConnectionGUID: dEooOLLyTMqtgVIIboEpRg==
X-CSE-MsgGUID: V2kDc1nRRb6nTcnLUN79hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70956460"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70956460"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 15:02:49 -0800
X-CSE-ConnectionGUID: Xv8bEC8wQnmybP0sdEgoow==
X-CSE-MsgGUID: XqXKu+iyRPKdDfAyvze0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208305097"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 15:02:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 15:02:47 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 15:02:47 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 15:02:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAJrh1deCkm80QYk/V8s2VDAf08PLzRg4tsLIl9kxfNT7HTVlnYhVyk5dLvA356qgZbw5fCmBR5jn3714xKrJEMSqZDrradeqzjMD1wq1xexdv0Ruo2sWYYU172KXrBVn+2V5EsAj6yw4jSgtb11RXL95zEQcW5cD1GYI1h/PlDDPQndzuWCe34x2mA3/6RtXmaqInhfd29lLyBCXu+JG8RxrGP7GXhP73qYZC6PQ0dI6XFJ15+0fj+/TqjGcYnbRpzb4L3IlC51SbVawDiJnJsR2L62mPniWCnN1lMU4bZfbKBxndmI8uuLFdfaAtUbV0PUtOLvkORiqcFKwlSWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGYRAjVKCMLm9L4UAXdAgICZpSpwq+3n0jj9fdQUsgc=;
 b=ogoDWSewPrLCEQD4gs6tP3Ms6r9q2njtAM500Ej3X5utaqUCYMQ/cYRF699vkaGk1Fs2Oj+GREa9hSqj2zlKVrq520wR0SQCMWX1y3rqmWS3S9SvsFjnZpRkogIM/QXTV1VTAESSanepRmLZ3ZSYbmm/NGciLW+N876mvjTM0tKSQFx8b44plzfVQ2ryRFxn3rcz7cEERIcfXgmODO/m6u7/e0K/JdnPh4qONskVWwe0TSbhXwzvo8PBVisOupSrowp6ZAzO1mQLlqd3FxnjBthOuS58HIBzOxgekCiD43Rjpb1+Yzf+GzhSY1KXW/mi0JcKBzl/IWAkF54iJ+xTbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 23:02:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 23:02:44 +0000
Message-ID: <c9439528-7185-4383-be62-e9d1cea87811@intel.com>
Date: Thu, 29 Jan 2026 15:02:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] octeontx2-af: Fix PF driver crash with kexec kernel
 booting
To: Anshumali Gaur <agaur@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <20260129091925.2465681-1-agaur@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260129091925.2465681-1-agaur@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3cb238-9a2e-493d-8393-08de5f8a8328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkpvQkViNFdPVGFGWmpHNk5zM3hQTkFGMFNBNTJIM01pNnZvdzMzNW1Rempi?=
 =?utf-8?B?NWF4V2FQaUJNdDFiMEtTSGRPRGdUR3RJYzhiRW4welJkZERhck9hd2pyNzhR?=
 =?utf-8?B?cUZ2Rk5wb1BWc1RoQ1dLazRCQUFwYnNlQW5YTG0xTGZ1OWhqYjNIcUFwUE5n?=
 =?utf-8?B?Um9EV1lhMk9wWkl2S0QwNTIrME5xeC9hMHROMUdscTNOb0c4T1A2eFV1elJU?=
 =?utf-8?B?dG5CbkhxelJRa2YyeWNKbG54VWMrYVcrNG1CRlpvM3FNcTRTMjhFL0Y3R3Fk?=
 =?utf-8?B?VDM4d2IycnlEVlVqUzF3cnd2QmpyRS9vOWZrQ2VRTXZPbndNNEZoYkZQYlc5?=
 =?utf-8?B?SDJBWXpLRktESCtLWlhJbkJqbEo2K3I5SEtlNmFEc0J6dnBLUmlZUFdhalJv?=
 =?utf-8?B?b3p0YXpNbEdDY1Bna0xwRjMxWFBWcnNLMlRvTVRKa21iL29FLzRxVTQwRStV?=
 =?utf-8?B?aEdwUmRZZ1JFMEx3N0Y0bWUrV3RaSmlEU1pVZGRNeFRSc0pSNHdYNm0zUlUr?=
 =?utf-8?B?ZElWbStxakhtSSt3V0cxQU9NYXRuR0ROYTRYbktiaFFlTTdudFJIc21QeXBK?=
 =?utf-8?B?S0JLV2hpb1pNeGxwaDhXcVFuUFg1b21kU1lpL1ExWmFpNm93Tk9wNXVtcGMr?=
 =?utf-8?B?V1loZEhJaWtkSytlZnFTeXNSMDlYV2w3bzRJRE9KbkZuMXd1S3JxMWcrcUdJ?=
 =?utf-8?B?YnNoTlc3RXMyWnpXSXMyNzQ5b3FSOU5sT1pnQStZTnphMVdSVlpCWkFFdG9B?=
 =?utf-8?B?eWU2WU0wUXNVZHo2VVBtVWVxQjFZYk1SRVRhMURoTERUaXdOWWNLKy9jU1BV?=
 =?utf-8?B?MHp0VUxEdkFOQW1QT2xoaEtoMWRUQzZhdHpHRlhQQzFqRG1sRjA4a0pKUnVG?=
 =?utf-8?B?RU1mbSs5UHdKWkhLaUV1eEs0UlBtbGUyV3NYYTBPRjJqRU0wSVJacEgxOVIy?=
 =?utf-8?B?RWJKNjdleTFxdzliU3N0MWdCQXZhYUJpSGg1ZFFPYk9uSVZSUThFWEszWUYz?=
 =?utf-8?B?ZExZVmo5bDJZb2xwMi9zZlhzdVhVWHRONzM1bzRvL01XWmQ5MVpBVHNWYngx?=
 =?utf-8?B?RUI1NkJOdmttUEdHN1BuK2JWcU5kRXdPS043cjdJYWNiaDVMUjJ3Z3JhNHFD?=
 =?utf-8?B?dWZKZytWQkpaM2VvNGY4NGdEZjVHV09jWlpERGpFRm4yZDBSQVJCOHBPL3lx?=
 =?utf-8?B?T29pNkQzZ21lSU9ONElSd2ZHOFdzQktPdUNVTThPbWkxMmhmQ05mNVR6cUEv?=
 =?utf-8?B?RHZIaEN5M1BteWROQWtXUzlCSS8xUXFyYkw3bXVTbUkxRjZVb1RydEFtNnRh?=
 =?utf-8?B?bXcyZnRJM3BFTENIMWM4TXoxNUhueG5zNXRWbWdNbWxlVG5aSGpEQXRoRWYv?=
 =?utf-8?B?OFZOUWxsNFF5V0M3VkR6bjh0bWtodFJqWmVwSGdDbCtMck4yZ2k3ZkxhYUNl?=
 =?utf-8?B?RWo0eWZTOERNK2wrRVFRVDVhb05Xak1tZWJaM3ZJNXNndEU4NnZHeEhPZTRo?=
 =?utf-8?B?ZlBkTUZLTnY1VjlDM2tNRnNqQ2h5V3N1VTRPaytFQlFtK2Jrd001LzFoZ3hN?=
 =?utf-8?B?MkdLam85Vmt6MDRKTFN3UDJjVzMxRDltUFZXMTh3SWR2aTBaSFhhS0RZa3Za?=
 =?utf-8?B?UGNiclJPdnVCQWNSTVlQZnNNUzh6dWIxeUxuQWorMXowZzcrMElTSUJyVXl0?=
 =?utf-8?B?SU5ZNjV3aTVydThDK2Y0eWNnVVU2aWtndmNwelZmV3hKNnpSbmxmR1U3UTlp?=
 =?utf-8?B?U3NVZXJtV2ZsY1VVcXBWQWFpZCtMWWxUSnlRa1gvREM0U1BWUWJMRk5ZN05u?=
 =?utf-8?B?VEVJM1FyYklRUDl3aDNWZzhNRjJCUUJIZENhVTl3M0VIanA0TGR2aVZ2bkJl?=
 =?utf-8?B?T3ZpR0NJNkxyQXNKWTN5RytocWNZdnhVZW5PNGlKOCtNTC95ZlJ1V2ZCUUcv?=
 =?utf-8?B?eHNTRk8xRDhmQzlYbkNWK0d3eHNPcW1uR0VPUWJPNkhnK2RBbVFvOHREeVBz?=
 =?utf-8?B?L0l3bWlRT01zaUtndjFmM1FIbk10Z0QwTm00aHpaVEdXbXRITGVhVlpucmFV?=
 =?utf-8?B?c0xZbFVPMlRab2VlTW1UV0E2YklVS2NBN2VsYUZ0b1hpcklsT1VkejhSTCtr?=
 =?utf-8?Q?8zKk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0YyLzJrZjd0bWlvN0QxdmQ2cm1tSzVOdldqWTg3T3lyd1Jqek1LT2NUQm84?=
 =?utf-8?B?Ukd4TndSYkxIVmpTUnhYRmsxSFJiNEt2Y3VoUkVQMWlNQkJJOEY5N1EzNG9v?=
 =?utf-8?B?Zytaa2orQW9jYWRPSWgyY1JSZ2JrNWJGQ013MFRuZEJPa1prT0hhd0VkSUYv?=
 =?utf-8?B?Qk9ybGNFaDZBN01USVIvTFo3UDdVVUVTSkpoSld4aHZDQi96RVU2bXJseElv?=
 =?utf-8?B?bEZPZlVjTHhhQ01MUGlYVGNmL3FqTU5uZk5FaGFFaDFpM2lzUXBWdjZuOUhi?=
 =?utf-8?B?cDd3akNkMDlod3Q0MlhqZ3ZzWnZ2Rm14bEswYXFyK2FUNjhveDdVNEZLZFJL?=
 =?utf-8?B?dk1MUTVOazhUVVd5L3kybTlBWXFRRGZnWkkvYTl4cDVjSldENkJaUnQxYVhy?=
 =?utf-8?B?QUx5cHdPZ0lXa3F6MytudGNtZnM5Zmx5L2d5SFlXa2hQSmY1R0lPdXRORlJ2?=
 =?utf-8?B?bVl3NVZoWjJ4S3FVQkVmRzRROG52ZmhUV1RRbk1QSWNsdENHL1Bvc29SOVc4?=
 =?utf-8?B?b0lWRWFRTWpjYkkvMFNoaXlZZ1dPU2MweUg3OXo0Y0JscTZNNWp4VVFsSXRa?=
 =?utf-8?B?aWgyMEdoOVp6OTkvQUVhdW1Ma2xaWWxnSFZJdG5BazF6RmdoQTNKbUl6TE1V?=
 =?utf-8?B?ZHUzSVFDeVB0TVdhY2dDemxyMkxsRm9PK3hzK04wUTQvM1UvZXNCN2xwRzJ6?=
 =?utf-8?B?czZ2UnpRZ3JocEFKbk0vTzVDei9MZDkwdDBOdlJkVzAwd3BJcUFaMHpUekRC?=
 =?utf-8?B?N2hZMHpGejZwV0ozUlF4cFJpVkRQU3Bhc2t0WVNDL0JGZDQ4ak9KNzRrL1BW?=
 =?utf-8?B?d253TW8rTXdHaktvWXgzU09wbmJzVU5vWCtmY2FVdkUxMDFic3FlN2dZR0V6?=
 =?utf-8?B?QkdURWpGREdMcTZVVVE3WFgwQkt4eEtadlJxRlBOV0hXQkMxQWZGV3lma1VZ?=
 =?utf-8?B?dlhUSUh4OVVvR0kwSFpacHA5REk3Vmd2T0llRi9xWjRDS2F1ejVDZGx4bWVK?=
 =?utf-8?B?UjIxZWRaWTlKZ3lTV244ZGVqQWt4MzlpZTVWQjI2aytuVWtHbGZDWFY3Y0FC?=
 =?utf-8?B?TXcwVFNvYVg2Yk1lQy8vWmJEU3ZTbjc0b0xPZUxvKzFneDhxVjl6djUvVkUy?=
 =?utf-8?B?d1hWZzYycit5VVZvZCszLzYvem1PSkVwRDVTY0g5MTlTR0F0YVFORGtHSVB0?=
 =?utf-8?B?TWx4T1V4ckFON1FLRE93ODdOOFJVS0pSN2ZWZkQ5cGk5Risxb1k1c2k1clk5?=
 =?utf-8?B?bWF0ZkRvQi8rWmIwVDc5Zm85ejJIamRLNm1Gbm1YeTlwRjIrR0VKay9paG9o?=
 =?utf-8?B?MzEwb2ZsQW5DQ0RHdFpyVmxuTmMyZFhoajVzOFQ0VkhndlFkd1lKUHM5WHVa?=
 =?utf-8?B?NVU1d25QNTNFUXQrbFZKdk1hQVFLQk54eDNUQzRpUU5jV2hPT1UvTTZ6QmQ5?=
 =?utf-8?B?YmVMc3RZSUROTEJiS2JJTHBVbE9kVkNyR3F3bmN3VjFUMWhRZVRsallmQ3hI?=
 =?utf-8?B?TnU2ZHl2MFRYL09MVmF1Sm92K3pkMkV1bWE2RkF6K0ZSazkxN3p0bjl3QjZn?=
 =?utf-8?B?TkMzYnVaTGE3WVdCdS9veTZmVzZqeVhSRkNwSXE3bEt6bUNPYTJMbmlhRm5B?=
 =?utf-8?B?Y0MvWGlVa3pBNTNGamVRbzM5UDUwV0V6M0ZBbG16ekk3R3AvL0VNYkN5d0ZZ?=
 =?utf-8?B?L3g1K3RQN1FjU1RCaGpOU0NQM1MwVVZ0dDNkRmdjSmNHUUZycEpwMVdYK0ZG?=
 =?utf-8?B?Kzg1SmRIYUhueWwwL0JPSXJIUVp1eWZFbk13b0NYM1ZBWUFTRlJzbjFjWUpQ?=
 =?utf-8?B?WkcxQTFaaVJ3WTYzS2xxWkV1R0dFK09idE1RZXhqdlV1TERrL2xrdWNzdk5t?=
 =?utf-8?B?Y3EzVTQ2NEpHYVpONWcrNHhYMWZtUC9KQmVPUUFEUzdjMTZIOEtscDZOQXpa?=
 =?utf-8?B?NzFzbFdHN0k1ZWpEOWJYdjgwNlpiS3NhdzI3K3pIS1cwRFpLamR1TzVIbERm?=
 =?utf-8?B?ZGxkOStiVUp3Mm1oU3dKTDdzU3NQSGpWUlI2b29janpWbmQ2a1U1YWlTRitJ?=
 =?utf-8?B?cG83TFJBSDlUbldBRWhsVjUyNURYd05oaE5Yd01wUXVoTzMzVTc4NG9XRGoy?=
 =?utf-8?B?SUhuUnlwU1Iza2pZYXRYWE85YXM5eGMrTkVVQ2w0MXdLSmxvdU12cE1EZ0M5?=
 =?utf-8?B?QzRMZzdQQzdQSnkxRjg3bXNOOU96eWxITllzd2s4Z09JRjhGMnBJY2pRTlV4?=
 =?utf-8?B?ckx2QWhCZ1Y4MzVsZ2UxVFBPcmYrYmswR3NDWWhtRDVwS0JyVmZROHN3SWpv?=
 =?utf-8?B?MmJIa1IzcEZtYXdhNlVRemJVOTErTU5wQ1l5VzlPZVI0VFZncU5ucDJoZk1i?=
 =?utf-8?Q?vWgiGjl6yW6kguyI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3cb238-9a2e-493d-8393-08de5f8a8328
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 23:02:44.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6vQf81Eo3OmNlY+yn7sA79OMpMRg9IFHYbHXjSYbnylgGGYyHhvUVb7jiClzTeUmBAR7Fw4UP1tyOPMLmfnqM/M11OBY0qaFNAiVjgZbFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-254941-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0762CB592B
X-Rspamd-Action: no action



On 1/29/2026 1:19 AM, Anshumali Gaur wrote:
> When both AF and PF drivers are built as modules, the PF driver in the
> kexec kernel may probe before the AF driver is ready. This leads to
> a crash due to uninitialized hardware state.
> 
> This patch ensures the PF driver properly detects and waits for AF
> driver readiness before proceeding with initialization.
> 

To me, the patch description is not sufficient to describe the what and 
why of this change.

Could you please provide a better explanation of how the addition of the 
provided shutdown handler fixes initialization?

> Fixes: 54494aa5d1e6 ("octeontx2-af: Add Marvell OcteonTX2 RVU AF driver")
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 747fbdf2a908..8530df8b3fda 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3632,11 +3632,22 @@ static void rvu_remove(struct pci_dev *pdev)
>   	devm_kfree(&pdev->dev, rvu);
>   }
>   
> +static void rvu_shutdown(struct pci_dev *pdev)
> +{
> +	struct rvu *rvu = pci_get_drvdata(pdev);
> +
> +	if (!rvu)
> +		return;
> +
> +	rvu_clear_rvum_blk_revid(rvu);

Here, I guess you are clearing some data about the device status. Does 
that mean that when you initialize later you will wait for the AF driver 
to finish probing and configure this? It would be nice to explain how 
this change fixes initialization.

> +}
> +
>   static struct pci_driver rvu_driver = {
>   	.name = DRV_NAME,
>   	.id_table = rvu_id_table,
>   	.probe = rvu_probe,
>   	.remove = rvu_remove,
> +	.shutdown = rvu_shutdown,

This is the shutdown handler:
> 
>  * @shutdown:   Hook into reboot_notifier_list (kernel/sys.c).
>  *              Intended to stop any idling DMA operations.
>  *              Useful for enabling wake-on-lan (NIC) or changing
>  *              the power state of a device before reboot.
>  *              e.g. drivers/net/e100.c.

How does this have anything to do with initialization?

>   };
>   
>   static int __init rvu_init_module(void)


