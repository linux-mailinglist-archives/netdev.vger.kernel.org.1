Return-Path: <netdev+bounces-153630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB19F8E2F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBA6188644D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E5319D88B;
	Fri, 20 Dec 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVeN8TOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519D19ADA2
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684524; cv=fail; b=VEs4B/a+RiRmbb/q/kVuMEbG1q6YpNaXeOfEDuVKdq28M9BTKptIB7hOfUQU1h+aLQRzImocFqJanQX21uSyaLgeEUTEaVHwIeXbh8FzfwQDQQfqzCV5lwrHeJhl2My0QgzwKxGQiDlOjPbBs3AsfrS6AB0NNynbWN3az7XFOCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684524; c=relaxed/simple;
	bh=z1GHb5SQh8EqlHDdtlCNaLwyy4xmRgn8ehL4xMHbBrw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s+8xb8qyU1pyJVSZ9ZAm4v+ZPg1pfPKOMmuUpCLzK3Fh95jaU3L8d6+G4/VXKe82WxBfovcPkCdyqyzefrkBFBfyjGj+WhqHTEjvfayOJpg++meQBMZQ4eVnEgRTwhs87MMz7+N7EQfYx8EGr8e8DY9guL/cA8yX1WTj4IYPncs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVeN8TOZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734684522; x=1766220522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z1GHb5SQh8EqlHDdtlCNaLwyy4xmRgn8ehL4xMHbBrw=;
  b=eVeN8TOZCjfhcSgg1H8FOGbogad3tnL77i/29MyQi/TYL5VXdiIyobBv
   fHJxa0ZeY139GkhqfgS7/lUHX0aFiB7PsFSZshe2tPOyoc65r5C9a5ui8
   gHVI4IQFmljr01xgJh4GPz1JyWHmPbRqC2e48iQJiyT4aWVpFwDHn4F5+
   KmNWso6R2Tcuo8ydAOkgyJjCQngVH3y5xQzLLJEW53UxVNPbLsk0tWKSX
   zVrXu/Wdw30HvKwPITQQV8+UlAGcIX3aB+K0ED9I/YVFTn1l6hKlJvtkv
   FKKUM+BlxdyNc/3omoRatMByWGwORHUlo+XrAExoEJJFIEDgf6nDfikG5
   A==;
X-CSE-ConnectionGUID: 0b/KZ7oITnSOAlihVeXOCg==
X-CSE-MsgGUID: Ih1iJeBbTsqek06RcuUENA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35258604"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35258604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 00:48:21 -0800
X-CSE-ConnectionGUID: si77pzjnTNWQVbpEc5Xbsg==
X-CSE-MsgGUID: hjwXIlUiTZ+ZyjbgoM0pSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103533193"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 00:48:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 00:48:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 00:48:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 00:48:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4+XtLpmoUQ7PJpFIKE+kNPfm63RYepokb2nQqS3H2GHtI+aF6n7yAW1U6pI7f9qyjv6zaAEwfGIz32fSLDVb9IzlRTIDTX5vI3ChaVIfT6EhC8tLZwyZH1CxuKuk11nb97RnyJfBlWomomrfyKD5nuuLIrXP6zVGFL20LO8TTb6F20g4y3QynYcUBVI+YOQmV+l4MQvUdLh485iIni5M2lPeysvsDMQMABOztn7tZTLVp8MiHUkMjdJEjqs/M2WEAR7xTYj55BSraaNIjFYJ5fvC/W2/nRiifPRI/WfGF1xwTNTLIxvS0jqpFy1ReXkNaayN6zqvbOFh7pDwzH2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd6p2MJz3Nt3bgTGkyBxaHKp6wdkMAA4gqyS4sVgUn0=;
 b=hpePCYN48SY6tauN2wF9RLBlkpfED12NPMU7wkOoItJIAZTi23+C4l8WwNgIN7Vzy4slOIDf5whDVZhYTr32HYgpKem1KgP+vIAbJfL/x6COvuN5dKgEb9rgM1DQzRMd6C1ebOPbce1PTDUxZt5An9A1rha62eHBLRF/GBgWjpLYlsBMi1ELD/kIHpi1zAbYwvWtfaYqoYNsd40x03qDA1SZy/4g0Vaj/kkyFEUK00Hn825ZzA8pkkXSmtToCGhOa9KwJmqNDbK3Um7W8X6amiB1n2tCfKRwcp6wtxngsTTlWGX1AjT4adksJyrx99V6EC7KQYptPqaFlDgHCpG/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 08:48:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 08:48:17 +0000
Message-ID: <ec95c546-114d-402f-b7b9-b3e54b33dbf0@intel.com>
Date: Fri, 20 Dec 2024 09:48:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net/mlx5e: Keep netdev when leave switchdev for
 devlink set legacy only
To: Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
 <20241220081505.1286093-5-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220081505.1286093-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 56024ad6-bf6c-4610-6985-08dd20d30c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDhhY3dqM21KaldSZHBzeU1kMmFKYmNaMnlFcjRGQXZPcW52c2NwSGpHS2pP?=
 =?utf-8?B?V1RVc2ZZTzNYM016bFZmSUxYaDIyZlkxdHltN1A3aU9LTlRkZ3Ivd0FZdEJV?=
 =?utf-8?B?bnBrd3Y1OUozNCt2TGNCRFdTMXF2ZFk4SE5OWXJ4VityL2o1QXlRb25SRlY1?=
 =?utf-8?B?bUV4ajdMTE1vbXgxY3dPYlhmOGpEcnBzcVFQTXRUbTlXV09YcmhsTktDTG4w?=
 =?utf-8?B?cmZQSWM1b0JyWGxNdWFmZ2w3NDMyNnEweTczbHMzRWhkeGJtWU1seldPNHNR?=
 =?utf-8?B?NHZHYUY5WSswN1VxM3ZrM3VOYllVaDJBTHhTVFZHSXJlbnQweUg5aTRmY2ZT?=
 =?utf-8?B?bW1LcXVUWmRKcWExckNRRmNWS1UzYjRCaUZzRWFjTXRtUk00cjdnbzkwR0h4?=
 =?utf-8?B?QWg0bXJYMzRpN01LaUQ3VXhFMnRhR1VSMklHTVB1K1FUVzR1WnArRElXWFhr?=
 =?utf-8?B?UDBiVGtIdUZ5aDh3R1lVbXc0VEJ6VVk2TDU4dkhCWERrdWlFL1JDdkE2N0VV?=
 =?utf-8?B?L3VhaEcyR2xMNlJRN1pmQ0l3bnNvbE1ub2ovTkhlaStOWERuejlYS0dsQ0lX?=
 =?utf-8?B?VDRHYitPdk45S2JIRDVrR056cyt1SkovTFJlU2N0ZXhseWRJY0d6T0Z3Z0ov?=
 =?utf-8?B?amc3WTBubHBiaWllU2x4dzkyWkxqNVNLQXEwQ2QvWmVENWE4SXFzVzBlakND?=
 =?utf-8?B?NWVaMHM2UkJ6TGdUUnIySndJZVNLVitzWStwV0RIMFVQSVkxYllUbTdnbUJn?=
 =?utf-8?B?QnBLMEo0SjRYc2xkMVdPWmZlQ3N4TStNRENGeXgwRUZBSEY4TUZBdFJ5WGll?=
 =?utf-8?B?NDVDcWdlSC9KcFFFdkpYclZQdnJwV3FxNjBycTh5bUNxdFY2SGg2MUJPUTd5?=
 =?utf-8?B?Q0JxVkM3MUFybjUxMllPR041NU9lT0lkQnVYZDM2WTNzTjR0ZzRIcG5hakxu?=
 =?utf-8?B?K1AvcGpXQWFLK0FTSHo2cXZJRUdMVlNhaVgyL09Oc3Nqb3Q2a3NvRGNXOVE1?=
 =?utf-8?B?bkVKL29GTXVaWXlLaGFVOWQ4aTBESHozY0dZYUZCNTlNRlZqUlFaSy91NlBu?=
 =?utf-8?B?RTlBMTQyTjQ1M05RcFh0RnFvMW0zYzVzeDZPdmhodFhHVlE5T3czR1ZSNEtS?=
 =?utf-8?B?SnpiWExZT2dDczdKdFphVWRDUi9SY290dU14dXZVRjA3QkFTa09PZFlaek4z?=
 =?utf-8?B?VHlVYTU3MkNpSTltRVc0NENmOERtZXRadzViVlM0akNrQ2NOQ2MvSlNkMGhC?=
 =?utf-8?B?ZCt0RVBNMHlBY3pta01BaHRzdGgrWC9HUUVqR3JlTUMxanVDRHVMOG1Ocjhr?=
 =?utf-8?B?R1NXeVdXV2ppS1hFbWJVT2pZc25CTDBJSnFHNHFkYWlqdDBFems5eDl0cmx6?=
 =?utf-8?B?L0pDNXdDaWFXY0xHSTl4TXdROFZLVjJlY29jZFJYV0svQzBLK0huUng2Um03?=
 =?utf-8?B?UU1XRWVNd1YyUG5tdlBHbXowZm5vUjZ0YUJmcG43RHNwOXpCMmRtVmh1NmFj?=
 =?utf-8?B?V2IzWEM5Z2NBUnVXT1BqMzFrMUhDQ1pTNm9WWlErcUE2WXJhcUpsOHBYVm9K?=
 =?utf-8?B?ZE8rQlFhNG5tRE9YeVZhZ2UxTDU4M3V3ZUFjSFdxVHBBOGZ5eVNrYnVQMDlV?=
 =?utf-8?B?eXltaGNCZGFOQk5DMW5UM2hhQjAzR1laMSszUVdaYW5SelUxa0N2Njh1bndT?=
 =?utf-8?B?TmRxS1FER01FMC9zcXJjamZXR0F6dUJ5THlyR3FqUU9ZN2VIQ0JOUDFJWi9Y?=
 =?utf-8?B?Q3NVZGowZjJvSFByQU91VTJSRXRjT0tjTGVwVm1uRGM2UVRuNDgzRHFpQUc1?=
 =?utf-8?B?TW0rWHVaUUo1ektPUWNPc3lQbnY2Q2ZGOVM1b0hpZ2V6T0RKS1B0Yk9uclRY?=
 =?utf-8?Q?3fixiwfSEX/gJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVWUDk3NUZEeEFrK2pQVW95cTBadDFDWGFRb20zM01CNHJLaVh2M3Vxck5N?=
 =?utf-8?B?cWxTNmVVeWFCMmhsSFZPKzg2ellMZDlvS0NoMHpZMS8zaGFqSTV3TnpRcmtM?=
 =?utf-8?B?WU9Mbm1zakFZNENqZFM4bjhSRlRVYU9mN0JXNlRhVklCUXA5aTh6d3cvNml4?=
 =?utf-8?B?RmlUSWZKVWpSRVQ3ZkZoSUJMQjNqZzBmUHFucnpoYUdPc2diMmZFNFZiK2ZW?=
 =?utf-8?B?ZVNuN2ROVGpkV2dsOGo5QXhRSGg5RWtoM2RyT2lsQTBRQXVzQzJoV1BZdjcw?=
 =?utf-8?B?MDl4aXBkSWtpcC9ic21JS2RnRVJCMldEL1JJU3BQZWJJbVQvalI5TG5lUnFX?=
 =?utf-8?B?U0JPekRmZktIK0xiUTNlN2tSK0JsNGZUZEpIcm4wZHA0bGlYVmRkSm5HT1Jt?=
 =?utf-8?B?ZTA2RFhHcXRtTHNnUDBxNHJ1UDQ1QlZIU3o0dzJFbW9CaHMwbXU1QUx0QW9M?=
 =?utf-8?B?MWlBNytnUTIrOWE1aGNLTDF5ZHhoZHc3MTl0V3F6MXhZWHJiVFo5Uk1XdTE4?=
 =?utf-8?B?d05CNXdTVDNvTlBKc3R1L0Zha045YmZudENxTzh6U1paSzJDeWllUm8wY1Zn?=
 =?utf-8?B?MGRrckVpNEhJV1A3a1paL3Q2cXRNcjIwSGpUVDNIQU05RGg2N09qZ0hxTnM2?=
 =?utf-8?B?akFFMERTdjdjdG1sQy82aWs0Z1crOEJ6SVp6LzV1RHFQR1piV1RXRVFCUXVC?=
 =?utf-8?B?UUlka29rWU9pUzFiOWRBK0xyS0h0Q21JbmU4YTlidFhLM1NIVmEzOGgwM0Q5?=
 =?utf-8?B?VTJqRm9Ea3NxNmlWck5oWXRIRFhRQUh6dlBHYTRlZDR0TFZ3SGRmM0lFVWZ5?=
 =?utf-8?B?N05sT2NNSjNvVG5vNmpObmhGSlRrV1A4NVhVRGYzZVM2MGdFSDlsYkZDWVhn?=
 =?utf-8?B?VjZtcW9sRytXMkJaMEpFeG5XZXBkMzhhZkpSZ3pFdGxwTWpxS0tLcmx3UEJZ?=
 =?utf-8?B?T1BFYmhwTG5hYVNEY3lqTWVKc01xZUptVzZHMWRRSnF5eFk2b2hkYjkzUG1u?=
 =?utf-8?B?Y2NlRmtQSE1wSHFod1RYVWlqK29ObFZweDhYL0JueWNOSWtMYUZ3amYvaUVT?=
 =?utf-8?B?L045YzFFSHFjY2pHT1RyaEpGN0gvOURpZWlhMVU1NzlTNHkwbzVKMXZ3YmJk?=
 =?utf-8?B?MU9TelJMWmZIZHZtNlE1UGluck5UQkpIbFhhTkJpR3NWekd3VDJVZS9CaVZy?=
 =?utf-8?B?a05iVktJTWZ6M1JUTlhydVlDSjFyK1NqLzZsMWUrZEo1dXdoczd0QmFESEtt?=
 =?utf-8?B?R04xVmhBNnhNYlYzc0prRXNIYW9lRjVockI2SzlVMldnUXo2c2Z1STQ5cmI1?=
 =?utf-8?B?NDRvVGplcFo1YkZ2N3Bza0QwYUFyQ0RuN1BDYU9BTE50cEloV05QcHVTZEov?=
 =?utf-8?B?N1k0Y0ZwOUlBYWw5cENZSnNQZWVRT2pHcFdjY3pxR05uU2FaaldyVlMrc01t?=
 =?utf-8?B?OE55dFhEMk9kL3ZuTnNVaVFOWXRoRmZSQnloa1RDaitWOTZKdDFlWDhrOStr?=
 =?utf-8?B?VWtRbGlqbmpNcVZFd2kzZmJtNGNGSmR1UWlwcDZoUThkRlZyTUFjdm9GYUha?=
 =?utf-8?B?NGZ1cWlldkZ1cnpjYU5wbWROQ3JXd2JOYmoyYUR2QzdSWW5iSllneU9rMFgz?=
 =?utf-8?B?M1NTS2VxNEN5cEh5ZGNHRXd1Y2JCRFlTZkpuZkVZaHBjRWlHd2p5M1NCZmdq?=
 =?utf-8?B?RWh0eXhCczU3dXlxWHU3RDRZdWxPTWtWMkxVNHVnS3VyaG9oblpMbG1scTU1?=
 =?utf-8?B?NGh1NlRtWkRSdXpKMmtHMVpuSHhUWUIrUUNYV2RLS0J3eFJxa2lGL2QvNUNE?=
 =?utf-8?B?by9QMURVOERLWW0rT3FJSU5RSTdxMDE5QlVKbElhb2ExbmlNMHg0QnpNWGl5?=
 =?utf-8?B?dWdGRzM3b0FWU052bHpORS9Uc0RHTVM3Zk9JOHFta2QrTFBoWFBZZGIvVTR3?=
 =?utf-8?B?MVg0bHpDazUwcUd6dE0vWFpIaCtXTWJhYVVNQzJjV0hjQjQ1MGhadEd6bjRJ?=
 =?utf-8?B?MVZaRVhSRk1pZ095WXNKS1N0VUhTbWhrN21NYkRJWnlPYkF5Z2hNcjNhRWpl?=
 =?utf-8?B?djFjRVZtSDlmNDBrUFByOGVOS0IvTkxCNWo3NVJMTjJTTVg4R2tWdGpDOC9I?=
 =?utf-8?B?NGlDbFFxVnc1SFp2NjRoaFl2Vk0xV1N2OXY2NjVCekxaS1VBYWJ1cUZnc3lo?=
 =?utf-8?Q?ah2Ke3Qse87iuurEgb45SSo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56024ad6-bf6c-4610-6985-08dd20d30c0f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:48:17.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQhOGcKki8IXqDc/Iol8Dba0wVIGEWALTtR1yxgcQmKS224owTsE7qYAIMPQ8C+XzyWgerd596nLHj6yJ5amyFVWeZdM24whEyjpdPl88oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com

On 12/20/24 09:15, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> In the cited commit, when changing from switchdev to legacy mode,
> uplink representor's netdev is kept, and its profile is replaced with
> nic profile, so netdev is detached from old profile, then attach to
> new profile.
> 
> During profile change, the hardware resources allocated by the old
> profile will be cleaned up. However, the cleanup is relying on the
> related kernel modules. And they may need to flush themselves first,
> which is triggered by netdev events, for example, NETDEV_UNREGISTER.
> However, netdev is kept, or netdev_register is called after the
> cleanup, which may cause troubles because the resources are still
> referred by kernel modules.
> 
> The same process applies to all the caes when uplink is leaving

case

> switchdev mode, including devlink eswitch mode set legacy, driver
> unload and devlink reload. For the first one, it can be blocked and
> returns failure to users, whenever possible. But it's hard for the
> others. Besides, the attachment to nic profile is unnecessary as the
> netdev will be unregistered anyway for such cases.
> 
> So in this patch, the original behavior is kept only for devlink
> eswitch set mode legacy. For the others, moves netdev unregistration
> before the profile change.
> 
> Fixes: 7a9fb35e8c3a ("net/mlx5e: Do not reload ethernet ports when changing eswitch mode")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +++++++++++++++++--
>   .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++++++++
>   .../mellanox/mlx5/core/eswitch_offloads.c     |  2 ++
>   include/linux/mlx5/driver.h                   |  1 +
>   4 files changed, 35 insertions(+), 2 deletions(-)
> 

sorry for nitpick-only review
I didn't spotted anything bad in the logic through the series OTOH

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index dd16d73000c3..0ec17c276bdd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6542,8 +6542,23 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
>   
>   	mlx5_core_uplink_netdev_set(mdev, NULL);
>   	mlx5e_dcbnl_delete_app(priv);
> -	unregister_netdev(priv->netdev);
> -	_mlx5e_suspend(adev, false);
> +	/* When unload driver, the netdev is in registered state

/*
  * Netdev dropped the special comment allowance rule,
  * now you have to put one line almost blank at the front.
  */

> +	 * if it's from legacy mode. If from switchdev mode, it
> +	 * is already unregistered before changing to NIC profile.
> +	 */
> +	if (priv->netdev->reg_state == NETREG_REGISTERED) {
> +		unregister_netdev(priv->netdev);
> +		_mlx5e_suspend(adev, false);
> +	} else {
> +		struct mlx5_core_dev *pos;
> +		int i;
> +
> +		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))

you have more than one statement/expression inside the if,
so you must wrap with braces

> +			mlx5_sd_for_each_dev(i, mdev, pos)
> +				mlx5e_destroy_mdev_resources(pos);
> +		else
> +			_mlx5e_suspend(adev, true);
> +	}
>   	/* Avoid cleanup if profile rollback failed. */
>   	if (priv->profile)
>   		priv->profile->cleanup(priv);

