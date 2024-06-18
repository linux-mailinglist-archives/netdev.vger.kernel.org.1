Return-Path: <netdev+bounces-104311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD990C1DD
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 04:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AF11C20F67
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9986B17565;
	Tue, 18 Jun 2024 02:31:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD6DDA6;
	Tue, 18 Jun 2024 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677917; cv=fail; b=EMyi+bAHwf0iWBJLfBb7AxoTT/PcpRP5wOU6lc9FIRKhYSQ8Oi7UQUQUyyqn7lOun4wpcokgcI3SUHf+sRbYOukBbp5FL6BHblN3x1bBcJYjEFiAdD4XffUxvmigfRHoqT0GMJk3ADCuue2yU7YwfQjL1Z13Rl0QFpVA4IrwuOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677917; c=relaxed/simple;
	bh=YYMyRi3N0PaXj1DPox2w0QdTwRRlxJTT6vH+VBGu7Ic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eL+VnporJvQKIW8xoHMzSAwgSNYK1wxq64dnRzer7N9yO+JWaH/SZHUGMXRf5ChhcrCaepHxBtLRQOdAMptJ7pwfJV06K1GiNZH9bigcOfSR736Wx0bjXS08aZdc4WaTbsE433XUWijfUSKDf5tsFHllBdo8KPaMYyIrEseX7EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HMxlVv019509;
	Tue, 18 Jun 2024 02:31:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ys05w2eny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 02:31:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiRmcPsrtAmUNePCHbwBW/znQVYzUjCNWE97YYc0nn70M3JgJZGgRJiUoZ2eCsoQ4zZWUraDrgOey9XnGy0vsCzBIoPnJvj5C4OOe/9Oh4Ubd3JeeNpuAUESQ3wKt6Mn/vuboqVSxboiBXs2S/jBjoPUL0PRFRd2zXrb6faNSDrpgU1j9QPTr8picAbFGzkq2VtqTJGRTk2yFXEHtCdpXUlIw3WUp2BlgOOursjgLZdgTRhE2mJWfejd2r/v5V32IoGEcLtepuHUhxLgqojatiTw6ueblAAPS1VPvCM/5PQaNPp7iOQt66RGo+qyXbBhQ+DYYMKT+6BVKf+iZMmOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOVBA50eRHgx89yvOKTIhLHlFU417m36Wr2rMKSBmfM=;
 b=PkYQ9YZRVObBUY54PjasNA78eRNhuvqXKbgzNx6+YWHe+HQrRMseR/VyD86j2Q82h3tMuYlVbPNpGxlcXBywB9fSddusmW/PI0CERZnrEesN59Mr0AkMfBJ/+gzsOOLUumFCNFbIkXSexmLYvTP5tFg9E98ZQVGlyIMJPn5YKeWagOXOgZk+IVXaW5Cmayz9aIn8ZlYTmio+7y7OJzAdxYD/wb4VxWZSocwhH4DeSPwY5F0X+7Zv5+VbI5BbD6uA6lH9UQxKjwvhoRgueKtZKdrW/coe5CSYJ7iN6y6dZrC4yFi5LkQrJQEldwvEljP/PlPVWRXjlroN/vgi+9VFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:31:18 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:31:18 +0000
Message-ID: <ed2dcd7f-0ded-4735-9533-2324600c3c82@windriver.com>
Date: Tue, 18 Jun 2024 10:31:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: stmmac: No need to calculate speed divider when
 offload is disabled
To: Simon Horman <horms@kernel.org>
Cc: olteanv@gmail.com, linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
        andrew@lunn.ch, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20240614081916.764761-1-xiaolei.wang@windriver.com>
 <20240615144747.GE8447@kernel.org>
 <ec41f61f-d500-4dda-8a79-37a68ddafced@windriver.com>
 <20240617102901.GO8447@kernel.org>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <20240617102901.GO8447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SN7PR11MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a16f9a8-cbb7-47a1-f2ff-08dc8f3ebbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cTJaWGk1aEp0NWxYQWZ5RFVFVFRJVUNjR0tzcDhJU0FNd29HWEdGTVRibkNt?=
 =?utf-8?B?c2ozNjdYUzhzRUpvS1JwZmh1aXc3UzQ3VXcvM3hEL284NzVkZjFMdExRVGIz?=
 =?utf-8?B?dmd0VHdxVXF0aGJGY0hGWU1lMVBpZSt3YnVzZWF0eCtRL0JYNHRoNDBFSUQ3?=
 =?utf-8?B?b0lyU2hmZXZveUIwMXAyL0N4cEVYRVhaZXFRYjNJdFVXVzkzV0R5c0RxYSt1?=
 =?utf-8?B?SVI5cGZsZGdsa3lPdXhlOGI3cnYwSkdhcjNReExwNkl2anFWaWNVcHVNNTAx?=
 =?utf-8?B?NmUrZS9tTmhQMGZPbmpZSU5XREZXc2FrTmVBQ3pEOTdsZDJZTjgzajlCOThw?=
 =?utf-8?B?SGJVRHMvYUs2c1dUd3pacEFRVjBOSHdBaDhUU2JZcjN4bEFkbS9rWjRRNTlW?=
 =?utf-8?B?Tzl3L2R3a255ZHpBM00yZHZXT0pOcnJJbXovQUcvNzlidllKQmIzNDFvUWU2?=
 =?utf-8?B?V2xsZFZxNUhTL0ZNWTY3bERUd3ZlZkdFT292U0srcnpSZXdrNXQ4MHdsclVQ?=
 =?utf-8?B?UTN4dUg1SjdvWXBCY3E2ckZIZnBJK0hxTkgzQWEzaGU5SUk2MU9IL2ZEUWtT?=
 =?utf-8?B?TFZzNWNaMEdsc1R0WWFEalRVR1k0elBXQSt5N2J4T1RxQU9xdkltbEZ3c1E0?=
 =?utf-8?B?eUJudCtYT1FVbHJQakJqRTd0RnJ1QWlPSGsrNTAyZm1nSVpKcXJxc0NjVHlC?=
 =?utf-8?B?dkZBS1pPaXI1bGtSV2JsTHJ2cUZvRGNKK0duWFRsV0k5dHQxOWNSekNVOU03?=
 =?utf-8?B?MkhyY3J5NkRQcUpDSGxsa2lLem9pdVlGUkdhbEpaOVRwVzRuK2hQN0RUekVF?=
 =?utf-8?B?UU1oY3pMMHhWYzZGdWVvYnVPQ1E3cXBlc0V5a2d1QTFxeVB6N2ZCcXFYdzlx?=
 =?utf-8?B?Qmk0NjNORFhFMC9ZRU1pQk1sUk80TEpWcWY4Q01jNWc3VStqWmdPSVNYSzNa?=
 =?utf-8?B?MkZJTzJKS0ZkQmdjWi9lV0NvMUk0QlcwWkIvQitPZWxVVHpscGZRc2IveVVO?=
 =?utf-8?B?UHcxZWdKNkQyY2pEekVYbTBFOFRadWhrc0F1U0Fvd0UyRU8wam1zT1lGdE5n?=
 =?utf-8?B?SE51QnNKOWtaMkFGRldqRVcwUXo3WEdLakdDK2pmenBYb2x2NTZLd0xjTUxm?=
 =?utf-8?B?alFmWjNKSzRZTFRVQlJoZVRvNytUdGMyakk0SDZZR0JjbTVjWXNvQ2tPQ0VI?=
 =?utf-8?B?VGZRN01uOStuQ0FhRG5MVjhBVnE4WDNMT1dYcFJXK2wvRGNnSVQ0QXZxY2Zr?=
 =?utf-8?B?Y3AyR3B4dFNLbHlzK0owRWZJbmVjdnpidDg3bmJ2ZVA5VlUwT09SRHRMamF6?=
 =?utf-8?B?TVNQaVVOUkRmZGtJendSTGNGUEhLNVNRNmp4SVdhVDAxZWVqY3hkTndvNjlW?=
 =?utf-8?B?YTJzM0t0UVdPc3pRWTFiNUNaR0lMSE4yeElEZldtUVZJdXVjMkhTT212RW5l?=
 =?utf-8?B?RGFFeHZjUTlHZ3FSZkYySjlBdWRjWFkyRlkxT1FDbnNNVHlLb1EybHg0MGYy?=
 =?utf-8?B?OFpkSnJDUno4QnpJWGJOYXFXaEpYRWt5T3p3M0VFU3dvd0J4cXREazk3YTdt?=
 =?utf-8?B?RU9GaHJKZ01POU1BSFhnTC9pei83Z050RzFLdGt2d2MrbXQ2OEVHbHpaeUgv?=
 =?utf-8?B?SGR6aEtpcXhlclkxb1JqWG50Yzg1cVgxWXE3UzNpMTdiSVRCcjlvTEEwM2xB?=
 =?utf-8?Q?h+QFw12gJXbJojyDV5YR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmViM1UrOXZ4alhUQXJvR0NYS2xVejFXeWJENU9JaS9scCtvbXBLSStrQk42?=
 =?utf-8?B?N0V4RGk5b1V6N2laS2dLNUlVakF2UWxLQnRmUjladGZ0ZWltdDFYdXRZQ0JJ?=
 =?utf-8?B?RWdYSktiNEc0YnZTOTVaTjhoREtPVC82S3pvODE2cFF5NjBsZE1YQVRLbWtS?=
 =?utf-8?B?MXRobnlMbW5JdnZ1VDNJcnIwNkRUWG8vNmdaT3VLc296TWJBY3dxL3JTZWV3?=
 =?utf-8?B?Yk9nTlJUVGJpbDUxTzIwZ2JrQXFLekVvMEV3cUI1MEd4UmtjaTNuc1k2d0k1?=
 =?utf-8?B?OHRSditQVnVtWW02TFcva3ZiRGtnU2xjcklpeHVQSWRzQm9YVERTWEpsOXJG?=
 =?utf-8?B?VlV4dEpWL2szK29zU0NiWXZ6ZWUyOUdqN2xuT1lPaXlXRlFsUVpLQStOaDJn?=
 =?utf-8?B?clUwN2JrNjh2aDJsUGprSWRzMFYzWVhpSm9mVkNiODlhZ2lvbXdmVVJoUWV4?=
 =?utf-8?B?WkhlQkllb1VDNkdUeFVIMlJRZDREUGtCSklaOFNwREQrTmRkZzVxRHRlbHdP?=
 =?utf-8?B?V1dKSmw1c3NvaytjUElkaFhVSURpUDk0S3h1SVRUdFhlUVcwV0ppcUVKZkU3?=
 =?utf-8?B?MjczR1hxYS9aRFVrRjBTUGJxZDl4NW1hamJxWGdVUExxWCtGelV6OUxPbks2?=
 =?utf-8?B?bk5JR09TTHVDMXM3VTlaTWRvQmUxaVFUMi8vT2tyWW1uak5LZERZNzBPSTlN?=
 =?utf-8?B?aEZwTWVZRXQ1VmthUXJiUW92OUs3bTQ0bklQZ21ZeXNDdjRyU1NQbllGbVVP?=
 =?utf-8?B?UE50Vmg5S0dUdFJOZFVONHlHeURKNHJoVmYyTjJkdXlUanh1TFI4dUd1Nktj?=
 =?utf-8?B?eE03VDlFTkRyeWlYM1d3TTZ3OGZqOWJlZDQyVFU3SS9KNWJnTUgwOWVrT0pN?=
 =?utf-8?B?enRSVmV3K1FSQnc4QWdSWW9UT2taZDljSC9HZ0xIWWNkUklQa2t0YlBOQkox?=
 =?utf-8?B?MEczTVRINkgyOW5jM2l6ZlNOMThTK2lEQ0k5bVpLeGhTSnF0Mkl0cHlhRjFV?=
 =?utf-8?B?aENrYXQvZ0lyVFZmUUpVbzUrcGszK3JsdTBjMzJLTjY5cEdVZ1hHMTlXbDBW?=
 =?utf-8?B?TFRYMTRkQ1o0TFd4aVB0WDBEWWhrc3ZKMCs5NmsxT211Y1FqVkFKa0hIS0xq?=
 =?utf-8?B?cHhIUXdDc2hWaWxXYXk0VHdOQXFWRFI4a1ozNVEwWnVJaDlsdWswR2J4YnRR?=
 =?utf-8?B?Sm5ZMXJ3d01idnROWlNPT1pKM3VTaEVqNXpNVDFYMDFTbmdQR09kWUlIMXc2?=
 =?utf-8?B?YmxNVFZTQ21WK0gwT1Jyb3luY2VxMFVhQ2IvT1UxMEo4bVhzbHZKQ2Y4YTNz?=
 =?utf-8?B?TFhZT2hud04zWlZTci9TS2JFZEZ5SHZhVE1aQkUrSXd2R2N6dVpxQjR3eTMy?=
 =?utf-8?B?UUJKY3N6SHkyc0FpY1pGWHE5c1FtSmZoSlNjTFRHeWFuYUY2V3BDVlE4ajZZ?=
 =?utf-8?B?Z1BjVWcya29najJ6L0JnSnEyclZMek4yc3pIZXdxcDd6WE5vK1VNcmhzWXJa?=
 =?utf-8?B?eXZKY2xUOFFibldkOGdnM0VncVNHek9KL2ZwbTFvaXUraTI1WFcyQUJrL290?=
 =?utf-8?B?TEdiOXhTd25zak91bW8vZExIWGhSL01Vb1BkUWlJdUFwY05TQ1ExMWU1a3kz?=
 =?utf-8?B?bml0cVB4V0FYcW1yVjdOL0ZDekVOaE94ZlB2dy95c0V1WXdQa1dRYldJeEVk?=
 =?utf-8?B?dlZzWUkralQwRm5McWk1VFk3WGxNZVQxaGZFbHpubXYzRm9wWUZBUUJlVDlz?=
 =?utf-8?B?cndPN2MxTFpDTEhDaTFKdkc5akJ6THZOTnd5Z3FKRmRsamVjb1VUdWcxS2k5?=
 =?utf-8?B?aDU4RStpRkxrUitWdVhTWC9QRXhmU3ZEbzJkSjdhUjhLZHFRUHFzaFc5NXFa?=
 =?utf-8?B?WERFRS9jdGMwMzdGUG0zd2kyV1VxV2NzK21OM1c4SjBRZ3pLR1ArYUpJVlFK?=
 =?utf-8?B?SE5SRVAvVityL05hMTIzb1JtVElib1JHdjUrRHhiajFzVEptSHk2b2MyRmE3?=
 =?utf-8?B?OUFicXNwOFlSemFwMHdheWNZOWFqWjlNekJieVJsSDgvbDc3UHBIaTJNbFpi?=
 =?utf-8?B?UUhrUDVESUhVemN5MWhkQ1k2eVFreGp4OHBiY09FTGpDTmZLaytNWmdWWjI4?=
 =?utf-8?B?V1JYbTNoRytYSElOdnFiTDdYQ2NzMHUxZVV2U3ZVV3RKQWV5MUxvcGhQSVNu?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a16f9a8-cbb7-47a1-f2ff-08dc8f3ebbac
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:31:18.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/hZZjyhsRqia2HsAatCB84BGRPyO/+q79Qeouw6dMkoyfIcRtI8xaOoMUCF7h+UmkqNuUODbeEhUTc5i/Vwf3jfHuBKkyVX/MFccbZaYWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-Proofpoint-ORIG-GUID: kmSWEd5sS6cOqAw_wa6Bint56eps0S5U
X-Proofpoint-GUID: kmSWEd5sS6cOqAw_wa6Bint56eps0S5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406180018


On 6/17/24 18:29, Simon Horman wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Sun, Jun 16, 2024 at 09:15:05AM +0800, xiaolei wang wrote:
>> On 6/15/24 22:47, Simon Horman wrote:
>>> On Fri, Jun 14, 2024 at 04:19:16PM +0800, Xiaolei Wang wrote:
> ...
>
>>>           /* Final adjustments for HW */
>>>           value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
>>>           priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
>>>
>>>           value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
>>>           priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
>>>
>>> And the div_s64() lines above appear to use
>>> ptr uninitialised in the !qopt->enable case.
>> Oh, when deleting the configuration, idleslope and sendslope are both 0, do
>> you mean we also need to set ptr to 0?
> Understood, if idleslope and sendslope are 0, then ptr could be set to any
> value and the result would be the same.  And, based on my limited
> understanding, 0 does not seem to be a bad choice.
>
> My point is that ptr shouldn't be uninitialised at this point.

OK, I have sent the v2 version

https://patchwork.kernel.org/project/netdevbpf/patch/20240617013922.1035854-1-xiaolei.wang@windriver.com/

thanks

xiaolei

>
> ...

