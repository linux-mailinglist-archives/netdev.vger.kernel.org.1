Return-Path: <netdev+bounces-97662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4818CC98C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 01:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78101F2202C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE366149C71;
	Wed, 22 May 2024 23:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF75146A8F;
	Wed, 22 May 2024 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420267; cv=fail; b=AmGGNuvCBkuvtZ7lrmLU/Jcoq0GdZfbSQzmFLtsEXIDmXMw0ct2cTS+EthHN4Mwx20MdGBTfqHp8mMyVEQ6g2m5eMmBFAyyY23KIMJHCTnU7aMcnhp4DP+vOrjKP6f8rm2z0ZJC9jI5sXaC55525ZuIqstueVyHsZguWhkdccoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420267; c=relaxed/simple;
	bh=vMsGYAJ8+mILdaXnWyrTax/zlZ73gdFFFcQBDUg5NYU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YlzKqs7xG2sJ7bjkg5nl8Al0GkLs+6PRRwlY8VyIz+h1+ME0vphIJ/X77yLPQ2Q0dcJ5pqcueYRWpNpz0Iw4ckSKToL32slWMo62oV2JuVQ/QK24ZP/lYYfXhMYCYTg7EZe0cWSGNRMgOxj5xJnoj99pl4AlADvfnFnod3NxocE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MGeUOk028786;
	Wed, 22 May 2024 16:24:08 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y96mnh2e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 16:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/sRFnjj/ak9jAaw4EZ0TjV9BWXkG2vUKUf2Zh+l81vrUmUAd+8ypHH6oRTuGe5YyD1kl3/H9O2hZXByVaRpxUP0+V9AfXm6m8Pv3kMX89ZGwxW3onsjO6EcU3wM+EBy0tYZvD3Kc09MRlE4C/0WD5Wv/XYoJbVF2u3Gq2gCmrRW21PXxuCuWQhjs75Kuh42FpFe05eVnM8ZeNqsqtBQ+J7UoA3oWvcbdbYHYR0qSBbL3JfDo3fcqUTaSqaqbhjco2l1UmlImOgWyhuDqjkITShk3ZP17O3gfZqVlHUtiSUCND/mYhNDlFKQHgj6YoRzgmtb2xTjxwVBa0jWvxni/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMsGYAJ8+mILdaXnWyrTax/zlZ73gdFFFcQBDUg5NYU=;
 b=odIqN+uSxMbTMROwE7JNmqy+TD0Q+XPq3JzVN3MXmXSYGhqGWZulncUOSBhjuvbC5VaQJG8PuZutUuO5EGzlG/q7uICAgnGwHeKF/AvAEj2ZUxzDHfqT5PV/e68ptLIxugbgx5iqolQXlAKw9NvHojkB2ICTvl8jKraYUbhm7AixaPmz9TeulDEBo1/zVG8WJZOG3WgZd7LbsX14bPySvvHNvO33M4vVWjOZCjV6VAftKZQgdD9nkYAkfAX9z0c8GNxewkE6el0bdRymdrRdtKzCGuA70TwPgfqLzVdbJM2VdcSvH5FGEPAhGpKdAyHVwp1kAKq8jWpS5X00ocFe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Wed, 22 May
 2024 23:24:04 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 23:24:03 +0000
Message-ID: <843c073e-1082-4732-bf2f-15960d12d992@windriver.com>
Date: Thu, 23 May 2024 10:23:53 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: fec: free fec queue when fec_enet_mii_init()
 fails
To: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240522021317.1113689-1-xiaolei.wang@windriver.com>
 <PAXPR04MB8510B1D6C8B77D7E154CC6CF88EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <8bbf2c1d-5083-4321-bded-f83aba5428fa@lunn.ch>
 <PAXPR04MB85100FA1D553CE1E8523269088EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-US
From: wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <PAXPR04MB85100FA1D553CE1E8523269088EB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CY8PR11MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: cee54a62-a08a-49fd-2852-08dc7ab6448e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?czM1Q00veTRlOVo2NXJBZU0wY1dtOGlIRUY5OVVYODNIY2dneFBpazIwUGFr?=
 =?utf-8?B?OWgrWjk2K2dLaVZPQ2ZsellaUUdYemFBMFdySVRVK2t4UlNYdnduU0dzUVVU?=
 =?utf-8?B?NGwvZE5ISkN0aUx4NDdzeE9QRk54Q2FjVVNCbFFDN0diVzVveFJ5SXl6TlI0?=
 =?utf-8?B?anBaSGZDLyszUDJkRlphd1lDRVd1TWRtMVE4K0ozY0xLQ1RzS2xGd05sRWlq?=
 =?utf-8?B?eUtkamNUbG1GV1hnSHEwUjUyN25hYlRLbk1PQTN4bzdFUG5JUGZrcGVxNGJa?=
 =?utf-8?B?TFR5VXp3ZGFVNEozNFFHNkprVmFmVVB5cXRSTmhxaURYMVRCY1B0V1htSzk0?=
 =?utf-8?B?V3FHdUdJZDBZRzhaM1B4Qk5IVUllVUo0REVhT05OUS9TM3Q5d1F4N1V0bVpJ?=
 =?utf-8?B?VWtjNTVRL0dSWDBUbVJ1UXNKalFVanhVMVJzVnY2dzROVDR0aUc1OGJaeTdt?=
 =?utf-8?B?ZlQ2UnphTnFueVdObVhmUWF6UVRFdjFrRnFmbG91d2x4bTFJSXpSNllaYzRp?=
 =?utf-8?B?S3FRamsxc0pCSVo2R2RhL0tPSW9VSFpRWHpKVlAwajVVNVh4ai9tK2tRdzhx?=
 =?utf-8?B?ajRobk8xV2hZNjdhTExCcUVMWFN2dWZvS2l2NEJLK2NSQ2JUUFJQMXdRZXdk?=
 =?utf-8?B?RXNCQ0xoby8ra2lzMThSZnNPUEZFT0hXZDc0ajI4aFJDR2hOSGFTZ2lrbEd6?=
 =?utf-8?B?ZDNJVkRmTGFzdHV3ejlYWUx1UnFENVpEa3ZjTFBiSEk5elU3UEpaeDUxdzl3?=
 =?utf-8?B?NVUwZnpaQ3A2SFdlb3FXcWFxVytFeUpRNWNLeEx0T2FxZmV6MHdpYldSZVhX?=
 =?utf-8?B?NFhTMDdqanJoVUxoVmluTi9yMFJ4MWlKcEJQODhtMGdkYTFuZlRVRTJlckhq?=
 =?utf-8?B?RFR6TjFCYTBqTERBZjUyZ0xqaXUzQ0YwajZqQmpBMFNtZmZzeHRvYjRJWWJt?=
 =?utf-8?B?bENXcU1uQS9jYWZFWDROOGlBMUNJZFhzZTl4Nll1eXByRjlHWGF4ZW9OZkRQ?=
 =?utf-8?B?a0p1a1NWa0ZkdC9JMElxYUUvd1dkZnZqanZPYTNSdmh3ZDF2MDErbXdqRFQ2?=
 =?utf-8?B?eHZXME1LTEV5T0lhL01QVDBxdHZvVVpwYktpbGo2Ump0QXhXOGlSRDliOVBL?=
 =?utf-8?B?SWovNEE0ZWpGRXJhMjBNaWh3WENtVzRPbnRGaUg3VFg4ZzVmYnozaGhvRGVs?=
 =?utf-8?B?WTJKWWxHbmk4OFRsT0JXbUJobk5xUzF5UENTaU9NWVhYcmZFSE9RdFdrcE9U?=
 =?utf-8?B?K2NEV2dLKytzNVdyZ0FRbU1pNGxteFl1cml4UURTT3BFTHcwOThUeFVmTDh2?=
 =?utf-8?B?UGZ1Z29UNE5zZnd3SEdKQmZ4S3U4aVBEZFNuQU94R2RiNkZaTEg4TDNMN05V?=
 =?utf-8?B?Vmg2K1B4NFIxUTZTelZnYjZyUldzL1NSVnVGTDhVYlpBbllLR2xWZExTUS9q?=
 =?utf-8?B?U0dWNDREVldjbkpjaHl0UGpCQ3d1MllTL1B0N3ZPUE51andpdkRZaDJFQ25p?=
 =?utf-8?B?cVpLUXZHYW9zc1FJWlNKblF2clF0S0NYb3F2cFcrZG50NWlidjZxS1laemxl?=
 =?utf-8?B?c3M0RVRUM1Z3Qnp1QmsvZGhhZGFINEpPSnpRWlk4L0gvZEtSVldHKzI3VGts?=
 =?utf-8?B?RG5UMitXYVNncmIrSytPZUlGQzBsRXBvTXlWNkF1dFdWQ3hwb0t6allObTFm?=
 =?utf-8?B?WFdMaVBkTlM3cmV6b2JyL2E5U3liQ0dReXc2S3I0ak0zYUxUVzBKaWt3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjYyK0h6eTlKTXJvYjg2UEU2OTlYdldpQ1I0L3NYUFY0Wm1zRXFBaTFKTEpo?=
 =?utf-8?B?UFAzNlNibGl3WHdTSXU3ei9mYlFxUzlVWG9oUUJyNXF3N2FsRDVOR1UxdlNo?=
 =?utf-8?B?dENMYjkzK2I3UWZWQnhZbVA5QUUvRUxDZ3pEblR5WXVWbnNLNmhYV0ZXdkwy?=
 =?utf-8?B?QW0zZ3M4b2JyQnRaNk14R25xR1RkWC9IbTdqR0NLc0RuTXJBeDExY0Y3dmsx?=
 =?utf-8?B?L2FYK3Bhdlc0aExLTTQ1N0NzSG12eVVLVm5MeEJYbnRyYTN1UjhSblloR3pu?=
 =?utf-8?B?TW5sMUszbTZpYUxtM1dwRXFYN1djUXYwUTZ3dytabzdKY0IxRHk3OXE0WURS?=
 =?utf-8?B?dTlRNmdBbjZvOEVLU2xCR2dGQWhNVTVVdlB6V0ZodzJXc1Nxa2w3ZDR6ZDFE?=
 =?utf-8?B?RDJDRVJlUEZ2ZjM5VkQ4SFhtdXhsSGlKTXRianhsNVlMODlvTHpYNjJYbFpo?=
 =?utf-8?B?cmdUT2VmK1czbzlhQWpOa1BndVdmM0hjaU04aUo3bGNiTjRLVWZ4b0grTENK?=
 =?utf-8?B?NGxJcUdOV05EVnA5WXl2bHZkS2w5YzJ0RzhCYzR0RUdHdjNuN0NQUFhtNVlz?=
 =?utf-8?B?NDJTNW1zTzBFUjBtbDRZWDdyVXJ2b3VrMitBeFcxc3RMYmw4dVVNZkJHcHBi?=
 =?utf-8?B?V2ltaTJsd01idExaamNlRjNGOWJGaFJxY2Q0T3doMHZYSkMyOWY3WVF1dmsr?=
 =?utf-8?B?SDBUSm4vck4wbVJlUHFMZzhCeWEzejlqMHEyWW5CUGxBeTNrcGlVamc4dlBa?=
 =?utf-8?B?dzhBdGt0cVZQR1UxbVBQNGpRRzY1Ny9sRUFkaFFPQjdoSENtQmUrdFVCbS9a?=
 =?utf-8?B?bXRKRTRvNU85VytiZ0ZrdE5vSU8zQ3hGTnM5WDlVc0lOSzNHd1VqZ3NNak5i?=
 =?utf-8?B?QWQwYXJ6ZkZLcDFLeENRbS9DTTRKK3V5SXF1Qk1oQmxGVkVnUlowWVd1SC9J?=
 =?utf-8?B?NFZSaXpWQXRpV3kxdk96VHNBRVBhaWV0dzNGeVBzT1lXaTlDenFHekJuY1hr?=
 =?utf-8?B?OTd4bUFWOExRWVF3enlZeTZ4VXE5ditmVVBlVDMrVENjaHE3b1ZjUHE0TnYz?=
 =?utf-8?B?QnBxc3ZYVzBrSGZPYjdrRnJvdnBGV0VNMnIwUWZJb0hIc2IrdGp4YzlXVFJ2?=
 =?utf-8?B?cnNqbUlvcHZPSkJ6Uk0zVk1DNUpqcUJkUHpPQzBxTzB1L2tpZjRDTmZMUDRW?=
 =?utf-8?B?UzRPQzF0WHRYV0JoYW00Wi9LbE1ZV0Z3MHhjNXl2WTFCRjd4UGpSRmorWkU3?=
 =?utf-8?B?eUNFNGNBcWpQZmNTM1B6cmwzS0wvNFN2ajU1T2ZxQ3ZzRDdTQk9tME90Y1Ni?=
 =?utf-8?B?ZUJqY3FDa3pyWnloWjlpWDEyR0p1U1FVamRMbzFrOEt1MXg0S3NJZk9SUWp5?=
 =?utf-8?B?blltcjZxSVJaRkROOC94YUJpcmhRUmExOUI0dTNMSkIvKys5N1hFdFlob3pr?=
 =?utf-8?B?ZkVpVlN6V0ErVDRTc3kyRmVTS21QVVV6dTYwVHQvZ0NKMGpua1djYUc1NTJo?=
 =?utf-8?B?M25vdTFycVVBc1E0Zk9Pa0ZwSWhHclAvQjNuQkNKeXBiSUlFaFM1NzAxdkE3?=
 =?utf-8?B?VFpoOUNoWG11elZpemFmTVdvbXdHaUV6NG5UNlk3M1g5S2xyRC90MFVQczVZ?=
 =?utf-8?B?NGxWMFBURWh2M01iMXpSTlhncUlZK1FCdnNIazl4NFBFSnprQk5CaTgrWWtw?=
 =?utf-8?B?MzQ2c2FwaHpsTmUwOGpqY2VvNTI2WXZKSHcyMlpNYUJWTjB6NTJwTXJEcTJ0?=
 =?utf-8?B?clhpT3NIZldvaVprSWdRektreXlqUUFvNUl2OHUvandDcTVVNmtkODVTTEFF?=
 =?utf-8?B?ZFpmNGVpRHBJNVFOM0V3dk1PYUk3TVRtYWV6c3dzUHhVdXdNSHNKWHlrZUhE?=
 =?utf-8?B?ampUWmxic1V2OW8rUittWjBicTAyeWt1Q1NSTmxaajBFQ3Y4QmRZRkh4c3B6?=
 =?utf-8?B?Z3FtWmQrdTg2YjVSY0pDcTNuajhtQ1RiL2hwakFKMEY3WnliSGZmUnIxQkZY?=
 =?utf-8?B?MktDM1JRTzZOT3FiVUlMTkd4aHhxQUVvY0dMK3FORXhWV3Y1b2p6cmxYMUFp?=
 =?utf-8?B?SU9FQXNIbTJVNlY5a1JhUFcvMmlJWXg2RENhK1NzaDhHZTFtekQ5dGZzaDZB?=
 =?utf-8?B?N0lCQy9EQWd5UnJ3ZzRGRGtiTnBLSmJ6WUREQ0xFS09DSUFOTStvekxlM2Yy?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee54a62-a08a-49fd-2852-08dc7ab6448e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 23:24:03.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbmnK5Go3QtAchN5y4ipJ32IiBcxkXZ5UnmWMAhKpHaTHXBcZz6M/6fmYbR0r25oUmLleFexqDKPVGSNAAVt/Y0YV517TNAdOwN5NNAkWgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-Proofpoint-GUID: KcElsVWt2oQaeda8JJHVIw59E99Q1Hy3
X-Proofpoint-ORIG-GUID: KcElsVWt2oQaeda8JJHVIw59E99Q1Hy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_12,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220163


On 5/22/24 6:28 PM, Wei Fang wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>> -----Original Message-----
>> From: Andrew Lunn <andrew@lunn.ch>
>> Sent: 2024年5月22日 11:15
>> To: Wei Fang <wei.fang@nxp.com>
>> Cc: Xiaolei Wang <xiaolei.wang@windriver.com>; Shenwei Wang
>> <shenwei.wang@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; imx@lists.linux.dev; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [net PATCH] net: fec: free fec queue when fec_enet_mii_init() fails
>>
>>> The commit 59d0f7465644 ("net: fec: init multi queue date structure")
>>> was the first to introduce this issue, commit 619fee9eb13b
>>> ("net: fec: fix the potential memory leak in fec_enet_init() ") fixed
>>> this, but it does not seem to be completely fixed.
>> This fix is also not great, and i would say the initial design is really the problem.
>> There needs to be a function which is the opposite of fec_enet_init(). It can
>> then be called in the probe cleanup code, and in fec_drv_remove() which also
>> appears to leak the queues.
>>
> Yes, this issue also exists when the fec driver is unbound, maybe Xiaolei can
> help improve it in his patch.

I will add fec_enet_free_queue() to fec_drv_remove in v2 version

thanks

xiaolei


