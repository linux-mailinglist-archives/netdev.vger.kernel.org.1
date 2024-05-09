Return-Path: <netdev+bounces-94750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323CC8C08F4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61631F2123F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 01:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36113A3F5;
	Thu,  9 May 2024 01:11:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5913A3F3;
	Thu,  9 May 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217112; cv=fail; b=ru24gIquuoppk0xg89lJEcV6jp22ec7rJEinmC/wfKLv9fPHDH3u+q9Z2nIsEIuJCa4Mkxg98kE8WOHEQeeYczIshTO5VISCXbMGAOfK0mpl0j+hq5jXf09Mx4dPhWS//7feyv7XT1HG7Ut+WbwZFW8ghYbmGjAO6SVLSy6WcNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217112; c=relaxed/simple;
	bh=UXUjMMtm0X7HWoBYAHdHFaZnnLSmvD5xFwgcBn+KgdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1AT5OKcKB0FMSY7OfUW0e9+/I7j9TaHpR4q1QZ3fgmkyyFjxSLIcBAWd40jwSLxqHiZQiNkdfZDNU50Wl/uCAYsuydqE6Dl94nOxkRmHTNy6DRnmDtWQTQqUV8t/TdJxrk+yIVn37decyk7S2n8S5QZRhGpSrIiaWDfzfO6VVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449103BM014977;
	Wed, 8 May 2024 18:11:10 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xyse1hb0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 18:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X43ITG93V3DhU5qYhS3AoHEPH5jiGl2l6bWJlCKgmtJXlB7IC5cbRPfOR3zVxGPYhyqPNTAryhNcPseF7yBovbR3cZNEy3OEcFkS0cC2m5Owp+0X51zh768D08a2M3Imyd4L70T/h20Qz9iUuwpcO36dPB8s3f95hVqpsT3btc8hUzbI9vf3v9BI3qpi7IkVcUcSjfG5lVjb5cPKU6eKcG9AB0ZUdPflzt9zkYBI7QLOqJT+U5Er4eAHoH0xTvmBHo/u2KNOi9jNYLfW4ZSpm0Wmjt2lIXbfWeCXGYOjwJvuYDHSfLBM0qMpSFZxormWeLh3NrIhg1kAwR2xWzdskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZrMZgCpscq2mlXRzMRog26HCwnqKwx6gwisOvoDwYg=;
 b=aed1s0hz68c1c6WP9hfAV2532wEi7u59IWN8Etb4K/4OBsSue+rjVTcTgtBrn5688HVXnwZK3ZAbtrvGeaJT+Nucy3wXvCDEfSSDZrjUPbLApUkhoWj+IPx1lrwTrpnLNMazvPQ3UNAuLVLpkEc+qbxzKvW74/7Zia3jHFV9Exwh+pfPnmfN3cLkv+O6E671JTphxsIXZa3oqoxjeR6YNEVXgoaVYjE7Mio3JSAVGXqoMUQUzYANT2hD+axCOF3etxdpWX6ddJjOizGhiucab9+sOZuHlkuLGrefy0hMtoKf3gYyucG7wW+b9zChCLAdE5BTo7r4nwHL1YjODn0PEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 01:11:05 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 01:11:05 +0000
Message-ID: <96412118-87f5-4e9a-a870-952ae3725c23@windriver.com>
Date: Thu, 9 May 2024 12:10:56 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: stmmac: move the lock to struct
 plat_stmmacenet_data
To: Serge Semin <fancer.lancer@gmail.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org, ahalaney@redhat.com,
        rohan.g.thomas@intel.com, j.zink@pengutronix.de,
        rmk+kernel@armlinux.org.uk, leong.ching.swee@intel.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240508045257.2470698-1-xiaolei.wang@windriver.com>
 <dvtilkr2ho5yy56fii6voglgu3tnopmoy556vrdo4evlynet5g@lnrlv73a27hm>
Content-Language: en-US
From: wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <dvtilkr2ho5yy56fii6voglgu3tnopmoy556vrdo4evlynet5g@lnrlv73a27hm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb2d227-c4d8-4dfd-d7be-08dc6fc4e66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TndiU3B2RGw4VlRhaVJENWRuZlpJTUFVY010ZjE3ZVBWMTh3TGpKZzNJb1ZH?=
 =?utf-8?B?QXkzT1ZHMWRYT1FNcnJEWU55RXllYnhDZURHOHU4ZEc5YUJLVE41bkplS0Yv?=
 =?utf-8?B?amtOWWU3UUhCV3JDMkpralNrMnAwNG5OQlZWdlI1aUgyYzBtUmlOKzhpS28w?=
 =?utf-8?B?dXkya2czSnJ3QmROV0pXN29yWllqVERvVG1HYXMyayt6Z0g5bEN6c2hkVm52?=
 =?utf-8?B?dHErMktTUUo2WFNzOFEveExWTWM0L25hN3gvTzZneXFOM2pNV01DRDVFM1FX?=
 =?utf-8?B?UmRpaFNpL053MnpJRE5uQklSVkYrSHpReHhBN0tpRFIzN25IdTdhU2swQjRp?=
 =?utf-8?B?aFlZbWFjQlhpcnFUdTJvSU91Qy9TYzF0b3R1U1Q2TXgvbktsM2N3ZDl1V0RR?=
 =?utf-8?B?eU1FYWljS00rZnNQTy9XKzBhVUh6bE1teGpIRVJzVGsvRXY3K0swSkxIZ3o0?=
 =?utf-8?B?ak5oRFJhSXAyL3BPUENReVpiN0hidTJMLzVEamRIQ1JWQ0dWS1NncnYrUmg1?=
 =?utf-8?B?TDJXa0QwNS9McjN4KzAyaC94d2hZWmZrT3dUMWdzY1dLR1hoWVZtbzZQN0Vu?=
 =?utf-8?B?K0dlKy91M3loUU01RkJLcU1yT2o1d0t3MzE4QmJyYW9ObHZ3dFVrSGRDTjBR?=
 =?utf-8?B?Yk1oRDBNaE1pYjJvR3Rzc3NSOVl3d2YvWVBjSUZEanZHMWZ6ZnRxRmp1QVFG?=
 =?utf-8?B?MzY2YnhQWmZwWXRaOWNDMml0bUgwTGpmS09qNDJZN09zdEZnRmNMT3JoNTEw?=
 =?utf-8?B?ODB6VkJhVDh6MFp6UXhRQjJ5Sy9vd0hicDFQSThNYVJGNWw4T045a09OSjZF?=
 =?utf-8?B?TzErdXRBanJ1ZFhKNWxWOTlQZTlHNzB3UjBsREpJODRsc21EZHdPSjF6S3Zi?=
 =?utf-8?B?eENnYVdMV213MmJWNldVVGtGd0RWNVVRVGhWVHNJZmVtdS9URVc4dDM1Zm5N?=
 =?utf-8?B?aCtFWHJGZElhVGhJdDR5TjM1TjhzVWlBUFlsWisrYW1VSHZnUzhVcWRDSk1t?=
 =?utf-8?B?eTJTYXV6djhwTjhiM2ZiL3cyMjRXVUZhb0lXOHRhOGxyOXNWNUJtSHJ3RjJm?=
 =?utf-8?B?R2JOck5oM0JqSDFPOVVsUUN5ajNuWXpXMHVmSWJjZ3hZU0cvclpGWDRCc2ht?=
 =?utf-8?B?Y05heDNBN0pYWU43RCtVZ0RZRXpXRURmRDBSZndLVEJ6NmpzeDV1Ui9xdUhI?=
 =?utf-8?B?T3JabytYakNZQzJqNGtNa0FINkhmQ3pwY3E3VFZEZE1tZXFmWjFmWHR5R24v?=
 =?utf-8?B?VlhuOVRFVkF1cnpFdTNQeTdsL2V5alRrSHJhMlR4YzU1ZEtFa28zQlpXay91?=
 =?utf-8?B?TE9HTXh1WnJ3T3hwQkVOQk54cUZzR0hSN1pnM2lNOTk5VUJvZkNpd2JoMGV0?=
 =?utf-8?B?T1IrS1FVUzdwL2ZBaGx3b0Y3aFlFMzNDMVRrVmNvc3R0cnpES3hJc00yK21M?=
 =?utf-8?B?SDA2ZEo2ZUw3NVpSdGpOM1VnRkNOZDVRYmprMGlvb1lMY1lhNDQvZmpVZXBy?=
 =?utf-8?B?MUlXMkxJVzYyRHdESVpGWnVUTnZDc1FpZFVJWDBiTG91djdDTUhjU09KRFdo?=
 =?utf-8?B?OWx4WkRINUp6aEVWMERxVWUwZnF0NUJ2c3NMbzNaalAyWngrb0ZUWk1LeWh4?=
 =?utf-8?B?WWh2anFobFlJdjVmelZrb0RsRzhPWndkWm5OLzF6WlYrc0Zsc2RIUWhkbWxx?=
 =?utf-8?B?K2lHWi9sTkZZQ0x1U1dvbU8rcHBqR1JlOXNmbDViaE9tZkIxM1g5clVBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXI1cWpPWEh4aWpHWFAzYVhoUEd4Z09Od3dnUzFsd04xaEZBOGxxWWtwZDNP?=
 =?utf-8?B?MjlabDBFa05VaFE1VG8wUThmWjJxVDlUMlhtUGVxTkpUWkdkZGdGWWtCWU5o?=
 =?utf-8?B?c2VNQnlhVFk2d1JhUmZRYTRwc2NwVlUyazU5aVYyNmdsZHJVTndkRjhxY0pX?=
 =?utf-8?B?bGx6OEVsRmt1WU9oaFZ2dTZldXRYNzI3Zk9IYXJ3U1BPVkwxQ0JpWHlhaVNQ?=
 =?utf-8?B?YlFoUEVBMDRzcklPeVVBZzZpVmNQdlZ3bkE1djlJS1pEb2Nvd0hwckxKWWFp?=
 =?utf-8?B?ZUJURHZTZkdYeTdlTlN6RkoyRGJ5T01McVpEcjgwMHczQzYvczA3aFRxdnJL?=
 =?utf-8?B?TmVuVFdyZ2FoN1VXRzN0ekpUV3MwcUZOTmNIaUdndlR0M2RPWVNpeEx3bFBM?=
 =?utf-8?B?WVhGUUlqZ3l3d0w3all4c081QiswRzAzVWtQTkVUQ2t6eU14UWxEWWtPYkY2?=
 =?utf-8?B?SnVtNkNyYmkreGo4bVQyYVF1MjdKSVVpTUpTbnByNGN6RTZEc2ZIWFNYV3Zt?=
 =?utf-8?B?RUpEcVlrc09LME1hN0J5aWVtcklmODlsaEkxMURuNkZ3b2hYYXd1SXlkdWxn?=
 =?utf-8?B?c0dBdUZDWEZDQW1yQUZkV1RMd0JXSmU3OU0vS2NHaWk1T1QzYjVldGdBYWxY?=
 =?utf-8?B?cnFHcFpyZG9ETEg2YUkza1hVQ3hyVXpYN1JhalNaWnJnbDRVL1h3RTFtK29J?=
 =?utf-8?B?Sy9kTS9CUy9wRllpdEZYY2VhdGFsdmR5bk5uaktVcm1VUmZxVmNhU1huRUlt?=
 =?utf-8?B?Vks4NE1XeFAwT3FObmpjanhpTEpmUEJZaU9BNlUzYktNUi9ESVUyRU1QNlUr?=
 =?utf-8?B?TGRjM1ZrMmZzQ0NyQ09razJ3RE1RMklXdXNvbHFJaTlkUUtyRldBMkVmb0tU?=
 =?utf-8?B?b0xXeUdORTBSbzRweVdRV2oyWWIvTVFkNmkxSDZta1VGaDFhSzdaOUlQUS9n?=
 =?utf-8?B?OWlDVjRpaG1VTktCcUd6eUl0UEZKWUtCUDhEUFdyOGtnQlRYOG5DTkFqT0tH?=
 =?utf-8?B?cmdUbEY1THZ5NjNPaVlTZ0dmMklNNWJzUXBmaFhpZW1rOTc3VStPZUg3VzVa?=
 =?utf-8?B?dmM5UUVNNndhUUcxanNRSm9WbVc4bWgvQ01JUXUyeElMQkN0VEczS1oxUnpo?=
 =?utf-8?B?MmIrSWJlVEx3VFg4aEpZeWV6aFg1cTRPZ0R1K3dYODhUYTNIZDBxM0VwNHY5?=
 =?utf-8?B?VklPN1lkcGMvOGJyZTJyVU5PV0ZQS1hWMVVaQVFPU2hucXc1T2czRHY3Qmk4?=
 =?utf-8?B?K1phTmttYndmRFZ4TW40Y3Vpc1M2SUh2ZDlqaVBvOVFxRW56V2RCSkhCSkI3?=
 =?utf-8?B?OEYxd08zU3dRRkFVdi9sc2c1VXhKSWVqSTVXdURuTkFORWVaMEVOcy82M05n?=
 =?utf-8?B?R0hjTk5oNS9Mdmd5ZWcvSXlJS3FnWG9uTW9BUnRVWDg0UmlIMU52YXFQYUJF?=
 =?utf-8?B?cEEvNnpRK1hWZnlXcHhRcHFseHlZbGVkbW5lQUVIYzRvVmo3b21tUm9HbmFn?=
 =?utf-8?B?bk1OWHpydnkxU2FENU5xcTZRb2NNKzdrL00rajExMzI0S2JaaCtobXJJeXRC?=
 =?utf-8?B?WmdKdGUraDJwR3lyWWpRQnYrbEtzSjB3TjNlMGRSZmRZWE1MSFQzRlhEUmRt?=
 =?utf-8?B?RjhiN3VYcHJrZUtIWjE4WGV4KzZzbGQ2MVkwYS9uaEZKaWlVTmdpcUhMWXdK?=
 =?utf-8?B?TTVnSjhOVzFzRVBPUk56QnlINkJ5ZC90VlZrRVRhZnpLNXNxUHlBMHpZWU9U?=
 =?utf-8?B?YjhNMExIYlgyQzBINi9tYVFDWUFrVE9vQkJQS0VsZkNodHZESUVubjBvVDFa?=
 =?utf-8?B?QkFOZXNBNm12d0F6Q0lTNkhySUh6OWVkSGxvcVBjdEUwMG0zamlxNC9TUmpF?=
 =?utf-8?B?Z0xIMkFMeEM0OXg3b21Rb0pnNUZTeERjbzJxaEpTR2huWTNmM2ZEK3dhZ2Ni?=
 =?utf-8?B?UU5lcFhyVWZQZVVoLzNHaUR3dkZwWEpvTWpGYlpjN2RCR0NvWWFodElYNWQx?=
 =?utf-8?B?bGxzdUlmYmRENW9kRkJCZWRjQkk4YWtqcm91ZnlZTXhjR2FnRmVkZEhWRFpO?=
 =?utf-8?B?R29xT21XU2l6VjRCbzY5NXo4aFdoZU1xQXA0STZPamZKZlVZRmlBTGNhQThU?=
 =?utf-8?B?VGQvYU8rbUNXd0pySUpPekhoOTMwRkt3RG12OXk2cWVXa3ZZVjh6MlcwSjFB?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb2d227-c4d8-4dfd-d7be-08dc6fc4e66c
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 01:11:05.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFk29VhZJ3OWSY9lh8uUAnGo5vvEZIzKp+YOG1VVDJUsrEAaVoMKHeb6iRB1LMQ31cDkM7knnHnqprhTRd14MUNCjTasBGWMf/C2Cgib+UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-Proofpoint-GUID: k4ob9L0VxhzqgxpZxI_cbpgPArXkxAqH
X-Proofpoint-ORIG-GUID: k4ob9L0VxhzqgxpZxI_cbpgPArXkxAqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090007


On 5/8/24 8:56 PM, Serge Semin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, May 08, 2024 at 12:52:57PM +0800, Xiaolei Wang wrote:
>> Reinitialize the whole est structure would also reset the mutex lock
>> which is embedded in the est structure, and then trigger the following
>> warning. To address this, move the lock to struct plat_stmmacenet_data.
>> We also need to require the mutex lock when doing this initialization.
>>
>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
>>   Modules linked in:
>>   CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
>>   Hardware name: NXP i.MX8MPlus EVK board (DT)
>>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : __mutex_lock+0xd84/0x1068
>>   lr : __mutex_lock+0xd84/0x1068
>>   sp : ffffffc0864e3570
>>   x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
>>   x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
>>   x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
>>   x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
>>   x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
>>   x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
>>   x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
>>   x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
>>   x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
>>   x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
>>   Call trace:
>>    __mutex_lock+0xd84/0x1068
>>    mutex_lock_nested+0x28/0x34
>>    tc_setup_taprio+0x118/0x68c
>>    stmmac_setup_tc+0x50/0xf0
>>    taprio_change+0x868/0xc9c
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>> v1 -> v2:
>>   - move the lock to struct plat_stmmacenet_data
>> v2 -> v3:
>>   - Add require the mutex lock for reinitialization
>>
>>   .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
>>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
>>   include/linux/stmmac.h                         |  2 +-
>>   3 files changed, 15 insertions(+), 13 deletions(-)
>>
>> [...]
>>
>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>> index dfa1828cd756..316ff7eb8b33 100644
>> --- a/include/linux/stmmac.h
>> +++ b/include/linux/stmmac.h
>> @@ -117,7 +117,6 @@ struct stmmac_axi {
>>
>>   #define EST_GCL              1024
>>   struct stmmac_est {
>> -     struct mutex lock;
>>        int enable;
>>        u32 btr_reserve[2];
>>        u32 btr_offset[2];
>> @@ -246,6 +245,7 @@ struct plat_stmmacenet_data {
>>        struct fwnode_handle *port_node;
>>        struct device_node *mdio_node;
>>        struct stmmac_dma_cfg *dma_cfg;
>> +     struct mutex lock;
>>        struct stmmac_est *est;
>>        struct stmmac_fpe_cfg *fpe_cfg;
>>        struct stmmac_safety_feature_cfg *safety_feat_cfg;
> Seeing you are going to move things around I suggest to move the
> entire stmmac_est instance out of the plat_stmmacenet_data structure
> and place it in the stmmac_priv instead. Why? Because the EST configs
> don't look as the platform config, but EST is enabled in runtime with
> the settings retrieved for the TC TAPRIO feature also in runtime. So
> it's better to have the EST-data preserved in the driver private date
> instead of the platform data storage. You could move the structure
> there and place the lock aside of it. Field name like "est_lock" might
> be most suitable to be looking unified with the "ptp_lock" or
> "aux_ts_lock".
>
> * The same, but with no lock-related thing should be done for the
> * stmmac_safety_feature_cfg structure,
> but it's unrelated to the subject...

I think this is good and I will send a v4 version out later, does anyone 
else have any other opinions?

thanks

xiaolei

>
> -Serge(y)
>
>> --
>> 2.25.1
>>
>>

