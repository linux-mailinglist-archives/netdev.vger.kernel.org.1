Return-Path: <netdev+bounces-93182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B468BA6EF
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBD11F21BD1
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 06:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CFB139CF8;
	Fri,  3 May 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AV1RPeTh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AE848D
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717227; cv=fail; b=kZFGxwfXnQ2n3SJZ7ZQ7j2M/R/6rL6WWabt4FjhvSCwv7O2wvN3WWVWubTYYwTYvMqbgdSLCefqJTJuXliKUh5Y3xlc7n2n3oQlciRYnL3dUdrDfsI//G0AY+IaIEfYN45kN+3G/U1+NlLZGTOqvOhpBFsTgUOw1WuhvmqFCqno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717227; c=relaxed/simple;
	bh=VKuQAnKMeQlfQezBKM3St+n3l0j8cZOCDgCKE9waWhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XlOcebfLVyAbgFgg7uM+qqkaIT7UqDamg7Xo2uhbeDowEx/OpftNlikGhiD5dSQEon22lm5TJ+QdiXG2p8mMmv7mwFCpzm/262Kz0yv9WTWtA9F718Higf2c10rcWmfZcX4UcZuji/5dDQLZrKVCZWX55gyhtRylKBrMTsnJdH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AV1RPeTh; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4432aQHi011127;
	Thu, 2 May 2024 23:20:05 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xvem02qj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 23:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoBxOZec3w8qE86Bqq/F4Ds3o8YjYds6tD/o8JpvRnGfdH3c58R4BOXJKWILsRbNttagtrq3h/roN/DCSo1+E0uADRr9nDQYGtEUykVaRBXCJYbFsGcy9Ho9azpGKbwkERjPgA3O5rinnVL8kJLVzOU9FXU/v2Nf1593rnXDndj8PmFcLZIILjDv0TTn+k9Vc2CbrIaXx9F37XeZweXLdFnBj3ZXpsHwduf4xa+qwAl7f4D6paMERsCj+tiBsVBJN3SBVfK8w0tuIec5YjTuNL/XkgvdjOkEugF9N4CLYEMvBzvow96Wy+2g91edmVXOOeJgNFucKUkuyqyDg95Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKuQAnKMeQlfQezBKM3St+n3l0j8cZOCDgCKE9waWhE=;
 b=ThcRmL92XlAsamWu326v2D/AXDs36Un11DSrlDNm94ZOQq0pQpgqLbLiC0oubIIC4VK1zgs7PUcDGvEIgoH4UjVApq/t8TmOZxnFbavh/OcD8b3nSvOFfiHCbCJiWlEwDtUb1RYeb+6F2NWi4o3cJxN2pFRPuvtgTk0GooiwXhwhDb0eX7o5lYptH2Ye2S4jGEh7pWm58VSUmR8799rXKc/1A6sX+SY/rp7jq2omMyouRVkckJvk/mHWmlardxy2XhTH5O4Z4yjxyD+ieu5bopYTmghpKrLLTYjuNcoevfg2L4bdwexnDx2fgSexRkBenA+4t5oPKC1FyApEaLMdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKuQAnKMeQlfQezBKM3St+n3l0j8cZOCDgCKE9waWhE=;
 b=AV1RPeTh+MYhueYBdpcO/F6DZtLmcnF3MZxLCX/BgSlkqmUl6WB2nzvEdoOkf69HbqzWBn05j+QXP2p/SFwRer0o7Sz9EXr1gIV+wwJ9FOXPPzJ7K1fHjaG4i16I3VC2kst7QswpQSiYwOJ+qmGBtZZmM6DZ+XAkqNUauzpC3UI=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM4PR18MB5025.namprd18.prod.outlook.com (2603:10b6:8:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.40; Fri, 3 May
 2024 06:20:02 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 06:20:02 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next] octeontx2-pf: Treat truncation of IRQ
 name as an error
Thread-Topic: [EXTERNAL] [PATCH net-next] octeontx2-pf: Treat truncation of
 IRQ name as an error
Thread-Index: AQHam/U0kEIVmmRrj0OoHDHHlx06GrGFCuCQ
Date: Fri, 3 May 2024 06:20:02 +0000
Message-ID: 
 <CH0PR18MB433904A22EE2C4F2E408B6F6CD1F2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: 
 <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
In-Reply-To: 
 <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM4PR18MB5025:EE_
x-ms-office365-filtering-correlation-id: 0e883230-ccac-404b-1782-08dc6b3910f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cjhYbWthTWwwMUFoZzc1dlhxY0NJY0h0Nlo1Mnk1U0hGMlFCWHZhcnhkNXBB?=
 =?utf-8?B?bERnY3Q3NThEZjBxRU12TnpoQ3dHby9aclh0MVEwajJvMS9Ka25CRmxFaWN3?=
 =?utf-8?B?Snd5YWErMHVFQnFZYXNMeWJadVEyYXlJWGpiV3NxRzdneEdTcjZiSXY0WnpY?=
 =?utf-8?B?K0VTWmtFSkthMEhqTVIzMTlSZ3FyMisxcE9jSkE4SkJkWDFyS1ZvUmJUQW0y?=
 =?utf-8?B?VkExS2JQWjlKaTdGSUI3ZVdwOWhtMG9JUmhPcUZDcnRYcUREWUdEcVIwYjFP?=
 =?utf-8?B?Njc1ZXJ6UzdvbVJQUmNLRHFmR3k1bURCcGZLdFM1KzI3bmptd3Mva1ZjQkhH?=
 =?utf-8?B?NzhEZllEVmZrc2lXZW9VVHMwSW40NHNrT2MyaFRXTmtMSVovU0t3bDc3b2ZJ?=
 =?utf-8?B?MWhiZkQxQk94TkMrTEZKem1KVTdhNDdXeWxrWkw5YThIdVpZdzJYbWpNcWpU?=
 =?utf-8?B?emtCZGxPWCs4Z3J5cHBOMTF6NWF5aE5JM0NmVWlqRml1anAyT2YzS3U1ZnRO?=
 =?utf-8?B?TlpUOEVNWS9IWXM0aysrZkRYYmpjTFZIM013elFHcytvM3B1QmhEbHlQLyta?=
 =?utf-8?B?THoyQklKK0pWRy9kMXNwSlFVejR5ZUdzNlNzZGR4NHJCUDRhUTgwNXNocWdV?=
 =?utf-8?B?RjhDWVJ5TjdOV245N3JhVVpPMEdseHBzbHBIRWZuZjgrRURobno3ZkpmMjd2?=
 =?utf-8?B?aWczL055YW1pSWkrWk5OSlhKbm9wUkhZYlNKYzEwMW43dVRVWkhORzlLbTdi?=
 =?utf-8?B?d3M1RXZCcnQxYXBUeXM1RUoyclk1S2xHSk1NVHUxVmZ5NVF1bEVpM3JYcG1G?=
 =?utf-8?B?cUJxRUt0SS8xZm5hK0plTkFRT3AyYmRZUkEwZEZGSmhEUDZqS1VRMlpVY21Y?=
 =?utf-8?B?ZzJZa1RYTVRoZ1pJa1dIWVJuN3BHQnRlVWp2OEJyRG82a2JXOFdjeUFCM3Mx?=
 =?utf-8?B?S3dPREpQTXp2bGZnQ1NxSnpqSDltY3NsNFNsTGZyUHRPUW9sVXJCN29VNEhv?=
 =?utf-8?B?ejJmZWE5Tm12UVFVdXpabTJITkU2NFptekNsR0ZsRWF2LzgwUU9vc0RVTHRh?=
 =?utf-8?B?WHl5UW92dDhxMmpkMzZjUEs5Q2NJbEowS2ozVDlRZktDUmtXOUpHeVFEdkF4?=
 =?utf-8?B?c1R4UXE3Y1A2b1BXdURHNFRmUkltOEhQNVJhdG4ra3JDa281SWlXeXFMYlVo?=
 =?utf-8?B?RjFLZG1PRGtlUzZvb21UbFc4R0NLZmlJVXpTTEwxNmorY1pkUm9jYjVGeXkx?=
 =?utf-8?B?Wnh0OWg0YXlucG1DZmovTWlYZWZ1QmVjQTgzaC9WTzdkU3l4RENuYTZvamNk?=
 =?utf-8?B?RjA2SGt4bUlFL0R0cnQwQXByVGVmS1RHWURrUW41S2I3Y0pIT3prYXR0MmlW?=
 =?utf-8?B?ZG5wM1AvOWZVaUM3QzZDQlBhMlRoaUJ6TVZicjdIckhUdHZSbWt0djhTMWQw?=
 =?utf-8?B?QWRlSkk1bFB2MEdBbXpwUklYRXlrRW5leDNiVXM1dFdGQ3IxMVdHR0MyVzIy?=
 =?utf-8?B?NjN6ODlBQ3VnMzkvYVRTQzVUdm1wNy9DTVloZEJUNUxheno1TThGTnRqc01K?=
 =?utf-8?B?Y1l2SnNTUnRYNFY3TGxoNk4xT2FEc1NWeGduZDNzMG43M2xFczQ2NUlqVGFq?=
 =?utf-8?B?cnRObmQvOHAzN3I2U2NZaHBEWUJoUC9MWmdTU1VhUWd6YVdUVkhMYlJnUWhV?=
 =?utf-8?B?L2xFU0xveXV6c0ZJTXg3UkZlT1NjblBlam14aVhITnp1SWdjRWZEek5GTi94?=
 =?utf-8?B?dEY4L29Hb1N2ZFNyRkx0bkRpY3o3bmd3WGJzeWtiNE1GOEs2eGl1cVhDb3pn?=
 =?utf-8?B?Y3p4QkNqZFpmUnJnRVVmZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZnplN1dMWXdWTzEvS1VNMUtwdXVjWXlWYWNWMSs2TDRNT3grTUg0OUZSL3NH?=
 =?utf-8?B?eVpaZUVsU3RIRDR1VzBJSWpDTnFYcmhmK1czMXdsek94TmtDa1RhN1NmQjl1?=
 =?utf-8?B?UER5bW4xUUFHYnMwNG83QmRRWHZHckgxdVNiME9wRHNXSXF6YTNlazNLb3Vt?=
 =?utf-8?B?cC9xZXhTTm1pS0hvemRRNlVBbnkzRWJmUlhDV2RQaW5jYkVpaTNHNTdwVEE4?=
 =?utf-8?B?bWQ4VWxlYy9aNVRTK2FINDJZa2YvWDMwank4K3IwTXIxYkQ4a1h3QVE0c2dP?=
 =?utf-8?B?Vy9zNTRPT2VXd1ZwL0FoeVMzZjNaMzFxRE8yem9WdWM1aVo4MVpEV0IwQ1ZP?=
 =?utf-8?B?WVlGRmVuNWFVV0FUU2gwclA4SUxLREMrRzV1aWlRbVFFTkd2elpoelZWWlgy?=
 =?utf-8?B?ZDNGdHlYcVFFWm10ZGtSUHlla1djSUYwUEJ3TUNGWGFmZE9YV1MyVGJuRjNV?=
 =?utf-8?B?eW9wUDhCVFFEa2x1bDNvajVTVDVlcWVNTFRQZXRDT3NQc0FFRDR5dGMxRHJ0?=
 =?utf-8?B?OGx6ejJYUURpaVY3VDBXRHZ5RFpmM3FqZFdYejVtS1NzcWo3aXloWXE0TlBO?=
 =?utf-8?B?WGx3OTR3SlFaMjZaMER0MU16OGF6Y3lJaEtHK1V3TDRFaUJIbzdSQWpJZlMv?=
 =?utf-8?B?TEtFbEpJd1dHUi9Idkc5V3JWSUk5UG0zNmZMY0VkZnJ1WWh1YjM5SDVkN3pN?=
 =?utf-8?B?V0FVY2o2Qkd6M1pQdytRWHJBWnJ0L3YwRTJ4eUU1TFJIZ1E5eEtUa1JTTmhS?=
 =?utf-8?B?aDlxYW5XazZ1SUFqeXhhc29kRjZ5enlDemhNQ1p3OVdsQ0JvSWlvaXcza0lv?=
 =?utf-8?B?ZXhvUEFlZkJiUnkzOFFYT0pFdTVldG9MU1F5S0VaNW1xaXNzWXhjWTVtSmdV?=
 =?utf-8?B?VkcvQzV5Sm1FWFBtSWRqTjlRcERUYklPaVE1dGJBb2txWlYzdEZvRGdueTdR?=
 =?utf-8?B?STdwWm9jVWpYV295aVQ3U0JQbHJkRWtBN0dRclhCeWpieFRHVHprWmNJZ1hH?=
 =?utf-8?B?RFVwY2F2V3ZsWXF4R2Foa050dUplQ1JsR2VtVm5UYVFRK21KWktKNUlIblA5?=
 =?utf-8?B?R2xmcER2N2h0Rm1MUGlrWFRLdEhPcnJKMUlxTlBVMmZjVWRLYWJ6VVNUZG40?=
 =?utf-8?B?ZFRHa1Z2cHBpd283R3dPZTJGMlo0OGVFZkRvTVRJNjM5SzhQUXR2UVdRRExB?=
 =?utf-8?B?KzB5eUNFTHBmS0lhZVJWT1Fvbm5DbkdwbDFqMmRFL2RCVmo2VmQ3M2V3aFZr?=
 =?utf-8?B?QmZ0YXA4RUZvZlErVUVoVFBZSHFvUExzbWxpRUFubXFmV241WTQ1RjZuNGxw?=
 =?utf-8?B?WldNV3o1UzVKeWxHczZQdFUzbGpMRGlkdEk4QnQ3VFRaM3NBZzVLRHZJaFUz?=
 =?utf-8?B?T1ZaYmlMMmtBbEt3Z0c1d1hxc09PU1BwMXU1a3d2Nkw2SDVhUWtUV21KbENQ?=
 =?utf-8?B?LzFPdzlHVHBIWG9wVUdVcFZyZUN1a1p5TVdnZ3BLN1cvUEpzNXVUR0llL2hE?=
 =?utf-8?B?dGx4WHY0YTdnYTNjaW55TEsveXlCbzZTRkdzUTQ3WjJXQlhyK3llTEN5cTds?=
 =?utf-8?B?azMvOVVoWENBaUJobGlidWI3cnRsT1dkdUFxNXdQVEkvUE5WTUowVzdjVURX?=
 =?utf-8?B?bHpWcVF5U2ZZSzRwT2xHcU9lbHM5V0JldEtQa2w2WW9uWW5CQmZ4STZtcFNM?=
 =?utf-8?B?SVRDWm00RXI2WFY1ZjRxaUZWb0F3djFOT2hzTnlsRVJDQ05UTjNKVW1idmdz?=
 =?utf-8?B?NXZmOHl1VmpYVkVQYTcxUklvbUMyakFnaEJCcW9GTk5ndEp3dXFCcjVGSXdV?=
 =?utf-8?B?Vk5HU0VaRVV3UUswdGRBRlI0eUdNTmM0UkxCNW1RM1B6aW13Um5VNnpEOW41?=
 =?utf-8?B?T05GSVJnTHdPclJhWGovQ3VvTWZSQWhISnZnQjkrd2ZNT09yWnd6UEJBN1V6?=
 =?utf-8?B?dGZWWVlvZm1EY2JybXZOTkJQTVVpZkVnREpMZHdXd0FVWWY3VUZkaE9WMkR5?=
 =?utf-8?B?NW9QTS9QR0xrbS8wZG5QNDVhTVRYNWNsdnIzTmgvZlpuZ1hqajhsb1ZNelY1?=
 =?utf-8?B?YmNSUDZBK1FBcjNKak1vdUI5SlZ3em8yTTJ2dlZUcCtENWliUk8xM0Z1RDUw?=
 =?utf-8?Q?WHPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e883230-ccac-404b-1782-08dc6b3910f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 06:20:02.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9pj71RHq1HTbFmCqOeVUK1xOjQwvymgYmUT07olaSWWVbonsQf2i29OwdTFQS+SYZjG/G773LrXLT/K1mTkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5025
X-Proofpoint-GUID: 2KqCpVCkIHEk6F8LjRZF5zlREeZaNjTH
X-Proofpoint-ORIG-GUID: 2KqCpVCkIHEk6F8LjRZF5zlREeZaNjTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-03_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAxLCAyMDI0IDExOjU3IFBN
DQo+IFRvOiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6
ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPg0KPiBDYzogU3VuaWwgS292
dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2phbnlhDQo+IEFr
dWxhIDxnYWt1bGFAbWFydmVsbC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGENCj4gPHNi
aGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+
OyBEYW4NCj4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+OyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIG5ldC1uZXh0XSBvY3Rl
b250eDItcGY6IFRyZWF0IHRydW5jYXRpb24gb2YgSVJRDQo+IG5hbWUgYXMgYW4gZXJyb3INCg0K
PiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBBY2NvcmRpbmcgdG8gR0NDLCB0aGUgY29uc3RyaWN0aW9u
IG9mIGlycV9uYW1lIGluIG90eDJfb3BlbigpIG1heSwNCj4gdGhlb3JldGljYWxseSwgYmUgdHJ1
bmNhdGVkLg0KPiANCj4gVGhpcyBwYXRjaCB0YWtlcyB0aGUgYXBwcm9hY2ggb2YgdHJlYXRpbmcg
c3VjaCBhIHNpdHVhdGlvbiBhcyBhbiBlcnJvciB3aGljaCBpdA0KPiBkZXRlY3RzIGJ5IG1ha2lu
ZyB1c2Ugb2YgdGhlIHJldHVybiB2YWx1ZSBvZiBzbnByaW50Ziwgd2hpY2ggaXMgdGhlIHRvdGFs
DQo+IG51bWJlciBvZiBieXRlcywgaW5jbHVkaW5nIHRoZSB0cmFpbGluZyAnXDAnLCB0aGF0IHdv
dWxkIGhhdmUgYmVlbiB3cml0dGVuLg0KPiANCj4gQmFzZWQgb24gdGhlIGFwcHJvYWNoIHRha2Vu
IHRvIGEgc2ltaWxhciBwcm9ibGVtIGluIGNvbW1pdCA1NGI5MDk0MzZlZGUNCj4gKCJydGM6IGZp
eCBzbnByaW50ZigpIGNoZWNraW5nIGluIGlzX3J0Y19oY3Rvc3lzKCkiKQ0KPiANCj4gRmxhZ2dl
ZCBieSBnY2MtMTMgVz0xIGJ1aWxkcyBhczoNCj4gDQo+IC4uLi9vdHgyX3BmLmM6MTkzMzo1ODog
d2FybmluZzogJ3NucHJpbnRmJyBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCBiZWZvcmUgdGhlDQo+
IGxhc3QgZm9ybWF0IGNoYXJhY3RlciBbLVdmb3JtYXQtdHJ1bmNhdGlvbj1dDQo+ICAxOTMzIHwg
ICAgICAgICAgICAgICAgIHNucHJpbnRmKGlycV9uYW1lLCBOQU1FX1NJWkUsICIlcy1yeHR4LSVk
IiwgcGYtPm5ldGRldi0NCj4gPm5hbWUsDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAuLi4vb3R4Ml9wZi5jOjE5
MzM6MTc6IG5vdGU6ICdzbnByaW50Zicgb3V0cHV0IGJldHdlZW4gOCBhbmQgMzMgYnl0ZXMgaW50
byBhDQo+IGRlc3RpbmF0aW9uIG9mIHNpemUgMzINCj4gIDE5MzMgfCAgICAgICAgICAgICAgICAg
c25wcmludGYoaXJxX25hbWUsIE5BTUVfU0laRSwgIiVzLXJ4dHgtJWQiLCBwZi0+bmV0ZGV2LQ0K
PiA+bmFtZSwNCj4gICAgICAgfA0KPiBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAxOTM0IHwgICAgICAgICAgICAgICAgICAg
ICAgICAgIHFpZHgpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fg0K
PiANCj4gQ29tcGlsZSB0ZXN0ZWQgb25seS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEhv
cm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9t
YXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jIHwgMTIgKysrKysrKysrKy0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9w
Zi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJf
cGYuYw0KPiBpbmRleCA2YTQ0ZGFjZmY1MDguLjE0YmNjZmYwZWU1YyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5j
DQo+IEBAIC0xODg2LDkgKzE4ODYsMTcgQEAgaW50IG90eDJfb3BlbihzdHJ1Y3QgbmV0X2Rldmlj
ZSAqbmV0ZGV2KQ0KPiAgCXZlYyA9IHBmLT5ody5uaXhfbXNpeG9mZiArIE5JWF9MRl9DSU5UX1ZF
Q19TVEFSVDsNCj4gIAlmb3IgKHFpZHggPSAwOyBxaWR4IDwgcGYtPmh3LmNpbnRfY250OyBxaWR4
KyspIHsNCj4gIAkJaXJxX25hbWUgPSAmcGYtPmh3LmlycV9uYW1lW3ZlYyAqIE5BTUVfU0laRV07
DQo+ICsJCWludCBuYW1lX2xlbjsNCj4gDQo+IC0JCXNucHJpbnRmKGlycV9uYW1lLCBOQU1FX1NJ
WkUsICIlcy1yeHR4LSVkIiwgcGYtPm5ldGRldi0NCj4gPm5hbWUsDQo+IC0JCQkgcWlkeCk7DQo+
ICsJCW5hbWVfbGVuID0gc25wcmludGYoaXJxX25hbWUsIE5BTUVfU0laRSwgIiVzLXJ4dHgtJWQi
LA0KPiArCQkJCSAgICBwZi0+bmV0ZGV2LT5uYW1lLCBxaWR4KTsNCj4gKwkJaWYgKG5hbWVfbGVu
ID49IE5BTUVfU0laRSkgew0KPiArCQkJZGV2X2VycihwZi0+ZGV2LA0KPiArCQkJCSJSVlVQRiVk
OiBJUlEgcmVnaXN0cmF0aW9uIGZhaWxlZCBmb3IgQ1ElZCwNCj4gaXJxIG5hbWUgaXMgdG9vIGxv
bmdcbiIsDQo+ICsJCQkJcnZ1X2dldF9wZihwZi0+cGNpZnVuYyksIHFpZHgpOw0KPiArCQkJZXJy
ID0gLUVJTlZBTDsNCj4gKwkJCWdvdG8gZXJyX2ZyZWVfY2ludHM7DQo+ICsJCX0NCj4gDQo+ICAJ
CWVyciA9IHJlcXVlc3RfaXJxKHBjaV9pcnFfdmVjdG9yKHBmLT5wZGV2LCB2ZWMpLA0KPiAgCQkJ
CSAgb3R4Ml9jcV9pbnRyX2hhbmRsZXIsIDAsIGlycV9uYW1lLA0KDQpUZXN0ZWQtYnk6IEdlZXRo
YSBzb3dqYW55YSAgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCg0K

