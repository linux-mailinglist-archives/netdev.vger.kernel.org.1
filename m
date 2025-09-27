Return-Path: <netdev+bounces-226906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BDBBA60D3
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36FC380252
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF41A23A4;
	Sat, 27 Sep 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8sreHCD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fHHkyIRR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94F28695
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758985441; cv=fail; b=VLOYqNWcm8FhvLywC65/fkIDFU0IKb7Rs+96CS4tmPP+dJmlofjKVFo/XncmAlqX4XVOPPFvvT44nFEQsdOxuf1TSiDnc1KCofxYNv5hZZrba4Uc2EPl0iEXP99iB7X9LCrxqp3vMUL8ZKWRwkj3Txng2mLf/KO4iIS8zbXoqVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758985441; c=relaxed/simple;
	bh=Gf5+E67kJuiReVFnu0zgMVW+cOlo+ZFCHtGPr2xjmxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ra0r1FMT38fb34DJoGgyX2t7Bqx9QwrkdDyWc8CNcQ1cY+h00JxhOK4dSdNVkVQVZBqJtKACBScmyxplIQV5lcNiEATJ46Pq5gRpMA4NM2jraOo6i9Kk6PyZrqhadxDTkhgcOK71kKFYM118Lsyd9Zp9wP7lw9G9wufAghgwdsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8sreHCD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fHHkyIRR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58REYk43023976;
	Sat, 27 Sep 2025 15:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zU+ap9oSLqDDexRp0wSQ225Qn0VC3mMFIWU0tXAaIz8=; b=
	T8sreHCDFGMFnGA7NN0zp/HrvBO5mk7vSugjUaU8tqExCt9y/XpTgDpHFk3N0chK
	0+16jgqWspQrKFh+xRkHfgiTQzTAUAPJDPBCMcHAJFHrqz1NLxKBIPpFekhXVqVq
	+eRfON8YF7aQHyeseXeSmCfFSfNfXm7lfxfn474AdGoR/Bg31uCoosHvzUyslqzx
	H2P2Xb1/eDcveq7HJ89iNTUjxr/Z3Y24HqwxoWKPy7pnOzBfXyU/kziF7+xC0NVr
	giq4pp1epWsXNxbb5uC/ijjh+c8zni3+W51DclTWw9u6Q+UQ2m6vqOOrODqxG2Lt
	x+LzP4BqnnRqNRVitjvL5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49eht8r0bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Sep 2025 15:03:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58RAV6SP007188;
	Sat, 27 Sep 2025 15:03:23 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c5vqgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Sep 2025 15:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4nEFWR5M0f+itm7ZWAw3v0BGBKSxRqMxqdeySp+yxE0depJ3Bnv3/2K842rqIorqPRhrDSTl3nXbs6sdKSWLYVMcduLAdTo4YjFuvmQLEXFvLdiZfAnneRCYvHyvkEsBhvo0zpOQMov9gCrp4boHQKfrH6ihsCBT7T+VQB6U/LkA/mSEF9/M2HhKdxB1DH7r3DwlGO8TrxZtUvV1DqJ91PKDkziZQzlfWUf8PsMw+O8KzOae+dev7zB9gXCTtcT/rnpER8UPCwzmh2WKSIbmmuaTDkmo7UxyvdBOOiH+/7/47lmsnDt3JM29pg9zzLirlYDW7BEBQYlR7Un0kz2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU+ap9oSLqDDexRp0wSQ225Qn0VC3mMFIWU0tXAaIz8=;
 b=pg2WqL0HpNdLiK4gdDl+VOkcmZB8BF9HrXFRb9DF0TkJhzYaDUgZGMh8cmkwKehs2qV35Dgj9eMmloH7Fz8Q/yA+e1bjKkGDCWq2qtGvaelwM+nUhIY5zHKRztSOkZhQTlodImpyG2XTpq6dzFuDJvcl7QzzfzSjIHt4Y17zWFHpfxB3cw1dXG/qWCGoQnMyXAIjqor+GUCGxfJRAUZ30f1wHTwwnzc5pSl33eEcGMluc/lBd8uGdQ0igf3qhJCw8flVF/DFjz4FhwO2Z9hnuX5QEfOY/DAbJtF5Qx9CbQ87VF5p0gwFqOTFhxufP0S3smF56cSYbG77SpQ8lXzx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU+ap9oSLqDDexRp0wSQ225Qn0VC3mMFIWU0tXAaIz8=;
 b=fHHkyIRR7vUyZVmPFN1TcJYB9kodNP8QMwfm2bkC3/hrp3MKvsfZ9+ocBHfb3vtxcTfXnC0wFGw+uu1C8IOvF3YkNhvDPVfyaL+0ihE4fj3fEf/wpdiAknKSF3ONByRK1rszYWbvUvBgX2y01NxT30NX/cbUrdK32vU6G6b/fbQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB7523.namprd10.prod.outlook.com (2603:10b6:8:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.23; Sat, 27 Sep
 2025 15:03:20 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9160.008; Sat, 27 Sep 2025
 15:03:20 +0000
Message-ID: <16e05c84-f13f-456e-b462-5f273a8f29b1@oracle.com>
Date: Sat, 27 Sep 2025 20:33:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v4] eea: Add basic driver framework
 for Alibaba Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
        Philo Lu <lulie@linux.alibaba.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vivian Wang <wangruikang@iscas.ac.cn>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20250926070423.95540-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250926070423.95540-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: df2bff0b-58f9-4248-ed3e-08ddfdd6ff19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzIrbVlzbWRxMkhFZVRpNmhnOStiOWhrMnlUaytnKzBWQ1d4d1Z4NERDdmM4?=
 =?utf-8?B?aTJIazJEdWE4OFhwUjBCbU5XbzYxOU4zaGhmdVBLa3hmRkJidStkVmUzMTg1?=
 =?utf-8?B?QlZ1MUVRR2hHZlZ6SFpNL1o4QUJ6ZmV2SEFHTmhWZGVOLyt5UlloSFlic2RT?=
 =?utf-8?B?aDB4Y3dqcm54aVdPb0NvWU9IYTMzb2svQXF4THhKbyttUzN0Q0JkbnZVN0FH?=
 =?utf-8?B?SnJadXplU2JuTHZTNXV4TTNoSnR3ZjBCMks5d3hEMnhIUzdEZGJRdVVaTGl0?=
 =?utf-8?B?NDdqdXRzYnplUnV0amVGSFczcDlUZnllNzBHNngrZ203ZDZteWdGdGEzdjMz?=
 =?utf-8?B?SHRlbDlXK0xuTVQ5dHhmMWQrcjRmTk9pcDFXSHFMMUxPMC92N3oydlJRQmF6?=
 =?utf-8?B?WFFwZGdQU2J3enJqZUIzMVR2RUdDcXJnOTcza2gzZFo4SUJ0UmJXbmZNMm1h?=
 =?utf-8?B?L21HbnAwZzBjT3dFUHhmNkUvczlwcUFGeVZPS3gwVE5PU3R6Zm9MUjdGU1pH?=
 =?utf-8?B?bWJuVytZR1RmSTNIQllHbVk3NURlRnJMUjZIbVAzVWpsZTRITnhscVhTSkJ3?=
 =?utf-8?B?cnlXWnVlYndWbmhCL1hSUDdzRnErUUlPaWMvTThBdnZ1R3JPZDJqWmJjTU5h?=
 =?utf-8?B?UFkvYlBGdG1uR2U4MkNJR1JWb3BXbFNYNng4R0VHSGJ0Y09oakJjcFQrZVJk?=
 =?utf-8?B?bCs1Z0U1UTYrd1Y3MXF6ZC9NQmhLK3BYbkhEaXRIZFpuelhaRzB5RFh6L215?=
 =?utf-8?B?dHNpT0RyQndqSWxjdzlYUTZhYXpDNEZDbFRLeTl1QlIrTjNIOTRVeHBTVTlF?=
 =?utf-8?B?bmc3bENEaWdiWXRlRm4yZm8rcVQwdDU2NGJlVjA1T1Fha2d6ZlpMdmhEWXAx?=
 =?utf-8?B?dUF1VlVISGdIUnh3WUFhNzJVWGljdEQ5ZXU2VGZVNDVhN1BTa2t0STlhSEhj?=
 =?utf-8?B?SXVZYkdaOGxmQXdWelh5UmNiVFRGYmU2K0NjdWIvYnhWeENkU3AxTk1pNCta?=
 =?utf-8?B?VlBRZWoyelRoNXJJUGtvcjRVNHB5QmlLdGdzeGRoaHpLYWtrRHNwMVNvOTdG?=
 =?utf-8?B?ZWUwSUpEZXlEYmFyMHErUVdySmhVUk9zVVJydW13RjlVdG9ZSzlRcjducFBi?=
 =?utf-8?B?MFdMWUZ3SU53c2RGeWRObUQ5d0NBYlFQcndnalFCbzRmQmVhcUVacTdFS3JP?=
 =?utf-8?B?d1ovcVNPQm0ybnVLOE51QWM2MGl1dzEzWGdLenBMNUNBWDZ2c2xUOTFsanda?=
 =?utf-8?B?WlYxZm9hL2U5QzZ6ay83aUo5RUtBYmllRHhONU9LOG55YlBEbDFRNlpTUkh5?=
 =?utf-8?B?d09YeU5TQ200RmRMR3dKRWtObDg3YUhZbW1mS1hJdCtId1ZtSHcwYyt6QkFQ?=
 =?utf-8?B?bk5CZEEyaVIxUkFqR2JiVXdPajUwMXVMbFFycW01dHpBTlhXNHNuM3dOaVND?=
 =?utf-8?B?dHg5VUx5ZENVemYxd2c1ak5aMnFhbTVBNFpsS0JFWGQ5ajVQemxWcWJyZEJG?=
 =?utf-8?B?KzJpbnFPVVZqcTBlQ1hjQnljNk5JSGExNDZHUmpWVkYzTmQ5SHlBOS94eE1V?=
 =?utf-8?B?MjQvV29pTVEvYWE0MVgzdnRqWVg4SXp5b01IdFN1SVgrUEpuLytKbUxwTWVH?=
 =?utf-8?B?dnVrTFlCdnFNSmU1Q2IyR1ZNMzN1eWVQOStGcTR3M01tZzg5bk9Kb3YyaEQz?=
 =?utf-8?B?WkkvejI5TEdSa3JLRXJZejNXM0ZGOUh5TmhQRHQ0ZTJFVVZDRFRZYVdzcGpk?=
 =?utf-8?B?M0xraS9tR3pXQUtFdnMxZDRFcWExQUtBb1ptMm84MUxVaHJnRFo1VU9SZHg0?=
 =?utf-8?B?TnRBd1gwUUdwb1p5Z0NKUG9KMlNwZmFUb04zekZUeWdXT1lPb2luWk13a3I4?=
 =?utf-8?B?ZmVtZlowVXlhbjI3V0wxVkJ0cFp0VG84Um01YWVSKzk1VTJWTnlQSE12VUor?=
 =?utf-8?Q?j+rtQRrIaAa24yMODK88T0IvUs38IZv0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cno0KzJpT0VSb3B4blpDSDdhVkdFZEN5WlBuT0x4RTAyS2dOU2UwbGNxU25O?=
 =?utf-8?B?eXdmNkJnS0QxNk9QbXMvVGVIT3VORjhrSVZ2OXpwWmVGVTVvNHFNOFFiSVJQ?=
 =?utf-8?B?RkgzbXJsYVBxZkRDMWtzWnpnWGdLM1lLNkRVRUNaK1ZRdTJMaEVUUjRzNG10?=
 =?utf-8?B?RjlNRkVEbGdJdXJ6eTdHQmkwbktMS0ZiQlNGeStTVG43cks3YmUwWUZmc0li?=
 =?utf-8?B?LytRUmZYdlpEVlovYUFCUTNPbDFkcnY1cDNzWFM4VFJiN09HZU82dUhnS2Y1?=
 =?utf-8?B?em8xaVNveGN2clkxa0NvUFc5b00ydzBKUXRtUWNNZi85b3NJUTlXWXJuaHFS?=
 =?utf-8?B?Z1VQVkxMV21UdHdDQVFJTUhQYnpPZE1WcVc2TGVpZkNySzU1Q0Y4RVZ5elFv?=
 =?utf-8?B?dmY2ZHdTUHBjNlNHbVBKTFVYR1UxSUZhZkZiWEhrczM1SmYvWmVNRXhVb0dM?=
 =?utf-8?B?VUtQdVowSHN3dmhOd09aQlZybjFWYjhhTFNKamR1MnEyM3owWThyYWxtUGhS?=
 =?utf-8?B?Smt4K3BrSGJadElKdDRUV1dSYXpmWVZiTHBxcm81SSsyU1d0WTdrdkY0b0ZW?=
 =?utf-8?B?OGtxaWxkWlJKc2dPWXJST0IwK3RGQXhqTSs1NWhMZHJqSjdxalY5NTU1OTNn?=
 =?utf-8?B?eVJVMGdUUm5yL1dOc21GbGs2Y1BudDFXRmMraWRGTG5ycTNWQlhCZFk5TW5s?=
 =?utf-8?B?K21hbC9yZE9NajlRNzVUN1I0MGFsazZxdi9XVDhPbVhTcTlFZDlsWkRJYTBF?=
 =?utf-8?B?aCtVMmVUVW15NFJUUEMva2EvYXlZZkNYOEhubEhOaUhyLzVQUXVQaUlPT3c1?=
 =?utf-8?B?TE9aSUJkVG9JNzBsTFJJR2Z4aTZiM3MyaWRjREw0QnBUSTRvNThweWJNQksv?=
 =?utf-8?B?UjJKb2ZVaHh0cUlRNUhKWGVDckIrbngybGxjT0hDS2dlQ3MzSkI5QXQ5dFBJ?=
 =?utf-8?B?SkpFalRlTFUxbkhsb0VMMFR3ei9TN0V4b2FlbExyNkdYRTgxUENYQTZWVU5h?=
 =?utf-8?B?VGpjQUJDQklvUURGejhBc1B3NVBOTFRINkxSWnlXaG1XTnRjWHJQSnc4OXJN?=
 =?utf-8?B?ajIrQm9zK01zSnp3SXZnaVQ5NVpZMzRQK1MwMmtwTzlyc0pnNjRJNU43NDRR?=
 =?utf-8?B?a0NmVHdTbTdOby8ySlFXd29xV1lOc3VXc1hBU1RPdjEwV1doa3FTR3VkR203?=
 =?utf-8?B?TmZ2Z09ESjVEUDkwNXJzUnhSeTJjZjFPcmUwZEFBNjR6cVR4ZEZ4V1d0T3c5?=
 =?utf-8?B?L2dpOU5tdW44cGVQV0lnd3NJZW9TcXpEeEltYklROXhsWThadEF2anpLVksz?=
 =?utf-8?B?M3dKbTJxWkQrTElNcjNMNnF4ZzFjcm1WUVBwZGQ0bVM2L1pBdFk1K3ZmT0VD?=
 =?utf-8?B?VGN1enRwZHgwUitYQkxlZzhxdmt5dGZFTytaNTEzWjM0QmJtVTJJdG5EYzBV?=
 =?utf-8?B?dDBaZ1Rob3pQcG54cS9rc1BMYlJxV2dhRVYvT1MyS2pubGU2NjA2SGJQSEFM?=
 =?utf-8?B?RStZdkhLSWxGR2plSXNTcFg4TVZra20zZzhhelMrNVBKWWVTc3lJc0xnQ0RV?=
 =?utf-8?B?Uk8xdXlKREcxeTFWYlhUWEV0d1U3c1lqWHE2bDZpS3hCQmU0V1h1YzZ6WnlV?=
 =?utf-8?B?aEhtRXdZUkRzZzRtalo3NFZYOXI1Y0F4UlU0bWtvUVB3aVZac2dUeUZFbG5M?=
 =?utf-8?B?WDdLbW1VU0V1czBZUmNYRnJLVHRKeHNJLzB4Z21icUN3MkZzTzRGY0RheDNu?=
 =?utf-8?B?MytFRDFrQVd4eEVva0NCTjFNTE1EZXUwc3J3VXlYZFFvenZheS9KeFphNzJx?=
 =?utf-8?B?TmdJRFJrazhYQVczUS9JS1RIdjJ6ZmRtZ3FNUmVUSE1iNnpxNVUremVTTmNC?=
 =?utf-8?B?UmxFd1J3WU9jTnZYTk9odG84T2xCZjNPYmlMb0ZZcnprdERhczJQM3V5cHdB?=
 =?utf-8?B?ZFl6WW5FK3pNZEpkNGdoRWxiME1JMWwwTVVIQlVkNkhodGdKMSt4M3ZweGo3?=
 =?utf-8?B?MEM4RDEvYkJUNnpaSExVUldKK0haOHNjN0JOQWk5WnhNVHdaVmRONit5VDJL?=
 =?utf-8?B?eEREelNBK1BqN0VOaFVoY3VueUM3ZUFOTHJ6QkR6QS8zblNtL3B6eGdBWmVL?=
 =?utf-8?B?bHpuNnU5RWdHMHVtbUExN3RndzVzWFdQWk15QnpQV2FuS2NjK2JLNXc2bDdG?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PlRk/fuh4YZloiKUTUPHvpPf4+MSj6mfZwgpg5xfdTYskmQRjkwtbnKEbl5CuK4eQZHyNckuCdHNl4wTNDfbU9nw43yXPWORSjgqW7eSx5i/ylALJ4hdCVKakC28E9ScYmFhpiuu+N/EedcIfv/tUNbOkHH7eMqLa6tKjMTwWi4u49l5aPpb8QN2naXDzlzKiL74a5rn3ZwvyIuqRSdl8S8za7Fq351Qkq7zs0TL7B5ymZQXU2YsGEtmrGeyGi4FG3UvHVVtwmySQRNFHliSAlHdv59CUJBy+MNEVg5PReKygq9WDbJrLhgISkTIAeFNNl8UdJa5QD8Zl3Z7BX+Aq5tt89KdYn1HFybCBtaQzOS0YQ5juIM2MRK+Jvo/lbVryuS6FxdXiFtky3wJYU6qNQMdy2VE3u8nXyoM4eHjmNH8IDSLNN0KR9AoQPl9xXsn81Sz+SJkmYam8ZcKkEHVqfjFBA2SviabZVYpfehMAOjBrz6tXao0OCxdT19kWgKSU1Bk4HnMaUtZgB50r5EMOuH/2lPivHWsWOCCb9vgPY9Qz24h4XCr05AOBZlmNpqrmJqsoNkEep1P1FhObPyDfXe1wCtM0W0ty0E8bq8EufM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2bff0b-58f9-4248-ed3e-08ddfdd6ff19
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 15:03:20.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHc++f7bIkxH2ujICnr5uA17/iQYFfz1g4Rs/oJrlFdkUGvzUf1EuYXcpW7POp7oNSUXJUcgsMZekPX8p2xz6fTdcT6Da3jsP+avV8jT0mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509270144
X-Proofpoint-GUID: 1xQmh2Ut7svUQD0-5rIUSquSeKH60TSz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDE0MCBTYWx0ZWRfXyjeWtqlWtqJk
 dc766b5ErdVwdLNBpb1WFavE2FfgkU+o2ACmmEaJ3rATT5T/tBzKysUrjZewj1RiOrPJfSNGhPV
 btWw0G0L8pWwOqHAalIKpqRopInb9owjngsCjYAfmqPQt8r7J0+8k53DHDhaocIT4ul1GsrzuJS
 W6q4MZ0lrQhrPfccKQCWfvQF/Y2i+BNhYm1IBAZUfFa9fcZ8jp9/a0tsD38Nj6hh+Wth55ncu0I
 nXd4Nrr3/AWw7pPulMJKLF7q/EnM8kZDdQJELkwrPO1EzGN9Zd9dq9eCKKF70jQQos0dHY6s7nV
 7fYIXfVdbypaZKP69I4iRsMOTnIrsj0E9iSU7lbtYC+3tm1HpoAoFm4FClvFi03VlafM/aQnKRI
 BZXHnfHg7aQ+eLv/hxgi+JIBrm8Xpg==
X-Proofpoint-ORIG-GUID: 1xQmh2Ut7svUQD0-5rIUSquSeKH60TSz
X-Authority-Analysis: v=2.4 cv=F5pat6hN c=1 sm=1 tr=0 ts=68d7fcbb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=FgtghgyOZkeOqR8WI5MA:9
 a=QEXdDO2ut3YA:10


> +struct eea_aq_cdesc {
> +	__le16 flags;
> +	__le16 id;
> +#define EEA_OK     0
> +#define EEA_ERR    0xffffffff
> +	__le32 status;
> +	__le32 reply_len;
> +	__le32 reserved1;
> +
> +	__le64 reserved2;
> +	__le64 reserved3;
> +};
> +
> +struct eea_rx_desc {
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +	__le16 reserved1;
> +
> +	__le64 addr;
> +
> +	__le64 hdr_addr;
> +	__le32 reserved2;
> +	__le32 reserved3;
> +};
> +
> +#define EEA_RX_CDEC_HDR_LEN_MASK GENMASK(9, 0)

typo EEA_RX_CDEC_HDR_LEN_MASK -> EEA_RX_CDESC_HDR_LEN_MASK

> +
> +struct eea_rx_cdesc {
> +#define EEA_DESC_F_DATA_VALID	BIT(6)
> +#define EEA_DESC_F_SPLIT_HDR	BIT(5)
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +#define EEA_NET_PT_NONE      0
> +#define EEA_NET_PT_IPv4      1
> +#define EEA_NET_PT_TCPv4     2
> +#define EEA_NET_PT_UDPv4     3
> +#define EEA_NET_PT_IPv6      4
> +#define EEA_NET_PT_TCPv6     5
> +#define EEA_NET_PT_UDPv6     6
> +#define EEA_NET_PT_IPv6_EX   7
> +#define EEA_NET_PT_TCPv6_EX  8
> +#define EEA_NET_PT_UDPv6_EX  9
> +	/* [9:0] is packet type. */
> +	__le16 type;
> +
> +	/* hw timestamp [0:47]: ts */
> +	__le64 ts;
> +
> +	__le32 hash;
> +
> +	/* 0-9: hdr_len  split header
> +	 * 10-15: reserved1
> +	 */
> +	__le16 len_ex;
> +	__le16 reserved2;
> +
> +	__le32 reserved3;
> +	__le32 reserved4;
> +};
> +
> +#define EEA_TX_GSO_NONE   0
> +#define EEA_TX_GSO_TCPV4  1
> +#define EEA_TX_GSO_TCPV6  4
> +#define EEA_TX_GSO_UDP_L4 5
> +#define EEA_TX_GSO_ECN    0x80
> +
> +struct eea_tx_desc {
> +#define EEA_DESC_F_DO_CSUM	BIT(6)
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +	__le16 reserved1;
> +
> +	__le64 addr;
> +
> +	__le16 csum_start;
> +	__le16 csum_offset;
> +	u8 gso_type;
> +	u8 reserved2;
> +	__le16 gso_size;
> +	__le64 reserved3;
> +};
> +
> +struct eea_tx_cdesc {
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +	__le16 reserved1;
> +
> +	/* hw timestamp [0:47]: ts */
> +	__le64 ts;
> +	__le64 reserved2;
> +	__le64 reserved3;
> +};
> +
> +struct eea_db {
> +#define EEA_IDX_PRESENT   BIT(0)
> +#define EEA_IRQ_MASK      BIT(1)
> +#define EEA_IRQ_UNMASK    BIT(2)
> +#define EEA_DIRECT_INLINE BIT(3)
> +#define EEA_DIRECT_DESC   BIT(4)
> +	u8 kick_flags;
> +	u8 reserved;
> +	__le16 idx;
> +
> +	__le16 tx_cq_head;
> +	__le16 rx_cq_head;
> +};
> +
> +struct eea_db_direct {
> +	u8 kick_flags;
> +	u8 reserved;
> +	__le16 idx;
> +
> +	__le16 tx_cq_head;
> +	__le16 rx_cq_head;
> +
> +	u8 desc[24];
> +};
> +
> +static_assert(sizeof(struct eea_rx_desc) == 32, "rx desc size does not match");
> +static_assert(sizeof(struct eea_rx_cdesc) == 32,
> +	      "rx cdesc size does not match");
> +static_assert(sizeof(struct eea_tx_desc) == 32, "tx desc size does not match");
> +static_assert(sizeof(struct eea_tx_cdesc) == 32,
> +	      "tx cdesc size does not match");
> +static_assert(sizeof(struct eea_db_direct) == 32,
> +	      "db direct size does not match");
> +#endif
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> new file mode 100644
> index 000000000000..c1a273e3f0fd
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Alibaba Elastic Ethernet Adaptor.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#include <linux/ethtool.h>
> +#include <linux/ethtool_netlink.h>
> +
> +#include "eea_adminq.h"
> +
> +struct eea_stat_desc {
> +	char desc[ETH_GSTRING_LEN];
> +	size_t offset;
> +};
> +
> +#define EEA_TX_STAT(m)	{#m, offsetof(struct eea_tx_stats, m)}
> +#define EEA_RX_STAT(m)	{#m, offsetof(struct eea_rx_stats, m)}
> +
> +static const struct eea_stat_desc eea_rx_stats_desc[] = {
> +	EEA_RX_STAT(descs),
> +	EEA_RX_STAT(drops),
> +	EEA_RX_STAT(kicks),
> +	EEA_RX_STAT(split_hdr_bytes),
> +	EEA_RX_STAT(split_hdr_packets),
> +};
> +
> +static const struct eea_stat_desc eea_tx_stats_desc[] = {
> +	EEA_TX_STAT(descs),
> +	EEA_TX_STAT(drops),
> +	EEA_TX_STAT(kicks),
> +	EEA_TX_STAT(timeouts),
> +};
> +
> +#define EEA_TX_STATS_LEN	ARRAY_SIZE(eea_tx_stats_desc)
> +#define EEA_RX_STATS_LEN	ARRAY_SIZE(eea_rx_stats_desc)
> +
> +static void eea_get_drvinfo(struct net_device *netdev,
> +			    struct ethtool_drvinfo *info)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_device *edev = enet->edev;
> +
> +	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
> +	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info));
> +}
> +
> +static void eea_get_ringparam(struct net_device *netdev,
> +			      struct ethtool_ringparam *ring,
> +			      struct kernel_ethtool_ringparam *kernel_ring,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +
> +	ring->rx_max_pending = enet->cfg_hw.rx_ring_depth;
> +	ring->tx_max_pending = enet->cfg_hw.tx_ring_depth;
> +	ring->rx_pending = enet->cfg.rx_ring_depth;
> +	ring->tx_pending = enet->cfg.tx_ring_depth;
> +
> +	kernel_ring->tcp_data_split = enet->cfg.split_hdr ?
> +				      ETHTOOL_TCP_DATA_SPLIT_ENABLED :
> +				      ETHTOOL_TCP_DATA_SPLIT_DISABLED;
> +}
> +
> +static int eea_set_ringparam(struct net_device *netdev,
> +			     struct ethtool_ringparam *ring,
> +			     struct kernel_ethtool_ringparam *kernel_ring,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_tmp tmp = {};
> +	bool need_update = false;
> +	struct eea_net_cfg *cfg;
> +	bool sh;
> +
> +	enet_mk_tmp_cfg(enet, &tmp);
> +
> +	cfg = &tmp.cfg;
> +
> +	if (ring->rx_mini_pending || ring->rx_jumbo_pending) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "not support rx_mini_pending/rx_jumbo_pending");
> +		return -EINVAL;
> +	}
> +
> +	if (ring->rx_pending > enet->cfg_hw.rx_ring_depth) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "rx (%d) > max (%d)",
> +				       ring->rx_pending,
> +				       enet->cfg_hw.rx_ring_depth);
> +		return -EINVAL;
> +	}
> +
> +	if (ring->tx_pending > enet->cfg_hw.tx_ring_depth) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "tx (%d) > max (%d)",
> +				       ring->tx_pending,
> +				       enet->cfg_hw.tx_ring_depth);
> +		return -EINVAL;
> +	}
> +
> +	if (ring->rx_pending != cfg->rx_ring_depth)
> +		need_update = true;
> +
> +	if (ring->tx_pending != cfg->tx_ring_depth)
> +		need_update = true;
> +
> +	sh = kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
> +	if (sh != !!(cfg->split_hdr))
> +		need_update = true;
> +
> +	if (!need_update)
> +		return 0;
> +
> +	cfg->rx_ring_depth = ring->rx_pending;
> +	cfg->tx_ring_depth = ring->tx_pending;
> +
> +	cfg->split_hdr = sh ? enet->cfg_hw.split_hdr : 0;
> +
> +	return eea_reset_hw_resources(enet, &tmp);
> +}
> +
> +static int eea_set_channels(struct net_device *netdev,
> +			    struct ethtool_channels *channels)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u16 queue_pairs = channels->combined_count;
> +	struct eea_net_tmp tmp = {};
> +	struct eea_net_cfg *cfg;
> +
> +	enet_mk_tmp_cfg(enet, &tmp);
> +
> +	cfg = &tmp.cfg;
> +
> +	if (channels->rx_count || channels->tx_count || channels->other_count)
> +		return -EINVAL;
> +
> +	if (queue_pairs > enet->cfg_hw.rx_ring_num || queue_pairs == 0)
> +		return -EINVAL;
> +
> +	if (queue_pairs == enet->cfg.rx_ring_num &&
> +	    queue_pairs == enet->cfg.tx_ring_num)
> +		return 0;
> +
> +	cfg->rx_ring_num = queue_pairs;
> +	cfg->tx_ring_num = queue_pairs;
> +
> +	return eea_reset_hw_resources(enet, &tmp);
> +}
> +
> +static void eea_get_channels(struct net_device *netdev,
> +			     struct ethtool_channels *channels)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +
> +	channels->combined_count = enet->cfg.rx_ring_num;
> +	channels->max_combined   = enet->cfg_hw.rx_ring_num;
> +	channels->max_other      = 0;
> +	channels->rx_count       = 0;
> +	channels->tx_count       = 0;
> +	channels->other_count    = 0;
> +}
> +
> +static void eea_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u8 *p = data;
> +	u32 i, j;
> +
> +	if (stringset != ETH_SS_STATS)
> +		return;
> +
> +	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +		for (j = 0; j < EEA_RX_STATS_LEN; j++)
> +			ethtool_sprintf(&p, "rx%u_%s", i,
> +					eea_rx_stats_desc[j].desc);
> +	}
> +
> +	for (i = 0; i < enet->cfg.tx_ring_num; i++) {
> +		for (j = 0; j < EEA_TX_STATS_LEN; j++)
> +			ethtool_sprintf(&p, "tx%u_%s", i,
> +					eea_tx_stats_desc[j].desc);
> +	}
> +}
> +
> +static int eea_get_sset_count(struct net_device *netdev, int sset)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +
> +	if (sset != ETH_SS_STATS)
> +		return -EOPNOTSUPP;
> +
> +	return enet->cfg.rx_ring_num * (EEA_RX_STATS_LEN + EEA_TX_STATS_LEN);

what about return enet->cfg.rx_ring_num * EEA_RX_STATS_LEN +
        enet->cfg.tx_ring_num * EEA_TX_STATS_LEN; ?

> +}
> +
> +static void eea_stats_fill_for_q(struct u64_stats_sync *syncp, u32 num,
> +				 const struct eea_stat_desc *desc,
> +				 u64 *data, u32 idx)
> +{
> +	void *stats_base = syncp;
> +	u32 start, i;
> +
> +	do {
> +		start = u64_stats_fetch_begin(syncp);
> +		for (i = 0; i < num; i++)
> +			data[idx + i] =
> +				u64_stats_read(stats_base + desc[i].offset);
> +
> +	} while (u64_stats_fetch_retry(syncp, start));
> +}
> +
[clip]
> +/* sq api */
> +void *ering_sq_alloc_desc(struct eea_ring *ering, u16 id, bool is_last,
> +			  u16 flags)
> +{
> +	struct eea_ring_sq *sq = &ering->sq;
> +	struct eea_common_desc *desc;
> +
> +	if (!sq->shadow_num) {
> +		sq->shadow_idx = sq->head;
> +		sq->shadow_id = cpu_to_le16(id);
> +	}
> +
> +	if (!is_last)
> +		flags |= EEA_RING_DESC_F_MORE;
> +
> +	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
> +
> +	desc->flags = cpu_to_le16(flags);
> +	desc->id = sq->shadow_id;
> +
> +	if (unlikely(++sq->shadow_idx >= ering->num))
> +		sq->shadow_idx = 0;
> +
> +	++sq->shadow_num;
> +
> +	return desc;
> +}
> +
> +void *ering_aq_alloc_desc(struct eea_ring *ering)


typo ering_aq_alloc_desc -> ering_sq_alloc_desc

> +{
> +	struct eea_ring_sq *sq = &ering->sq;
> +	struct eea_common_desc *desc;
> +
> +	sq->shadow_idx = sq->head;
> +
> +	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
> +
> +	if (unlikely(++sq->shadow_idx >= ering->num))
> +		sq->shadow_idx = 0;
> +
> +	++sq->shadow_num;
> +
> +	return desc;
> +}
> +
[clip]
> +void *ering_cq_get_desc(const struct eea_ring *ering);
> +#endif
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> new file mode 100644
> index 000000000000..3b55d8f534ad
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> @@ -0,0 +1,787 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Alibaba Elastic Ethernet Adaptor.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#include <net/netdev_rx_queue.h>
> +#include <net/page_pool/helpers.h>
> +
> +#include "eea_adminq.h"
> +#include "eea_net.h"
> +#include "eea_ring.h"
> +
> +#define EEA_SETUP_F_NAPI         BIT(0)
> +#define EEA_SETUP_F_IRQ          BIT(1)
> +#define EEA_ENABLE_F_NAPI        BIT(2)
> +
> +#define EEA_PAGE_FRGAS_NUM 1024

typo EEA_PAGE_FRGAS_NUM -> EEA_PAGE_FRAGS_NUM

> +
> +struct eea_rx_ctx {
> +	void *buf;
> +
> +	u32 len;
> +	u32 hdr_len;
> +
> +	u16 flags;
> +	bool more;
> +
> +	u32 frame_sz;
> +
> +	struct eea_rx_meta *meta;
> +
> +	struct eea_rx_ctx_stats stats;
> +};
[clip]
> +
> +static void eea_tx_meta_put_and_unmap(struct eea_net_tx *tx,
> +				      struct eea_tx_meta *meta)
> +{
> +	struct eea_tx_meta *head;
> +
> +	head = meta;
> +
> +	while (true) {
> +		dma_unmap_single(tx->dma_dev, meta->dma_addr,
> +				 meta->dma_len, DMA_TO_DEVICE);
> +
> +		meta->data = NULL;
> +
> +		if (meta->next) {
> +			meta = meta->next;
> +			continue;
> +		}
> +
> +		break;
> +	}
> +
> +	meta->next = tx->free;
> +	tx->free = head;
> +}
> +
> +static void eea_meta_free_xmit(struct eea_net_tx *tx,
> +			       struct eea_tx_meta *meta,
> +			       bool in_napi,
> +			       struct eea_tx_cdesc *desc,
> +			       struct eea_sq_free_stats *stats)
> +{
> +	struct sk_buff *skb = meta->skb;
> +
> +	if (!skb) {
> +		netdev_err(tx->enet->netdev,
> +			   "tx meta.data is null. id %d num: %d\n",

tx meta.data is null -> tx meta->skb is null

> +			   meta->id, meta->num);
> +		return;
> +	}
> +
> +	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && desc)) {
> +		struct skb_shared_hwtstamps ts = {};
> +
> +		ts.hwtstamp = EEA_DESC_TS(desc) + tx->enet->hw_ts_offset;
> +		skb_tstamp_tx(skb, &ts);
> +	}
> +
> +	stats->bytes += meta->skb->len;
> +	napi_consume_skb(meta->skb, in_napi);
> +}

Thanks,
Alok

