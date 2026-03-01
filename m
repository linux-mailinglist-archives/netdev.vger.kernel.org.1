Return-Path: <netdev+bounces-262375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHUrIC7go2lPQwUAu9opvQ
	(envelope-from <netdev+bounces-262375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 07:43:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC01CEAAC
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 07:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 530FA3007B02
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6F31714F;
	Sun,  1 Mar 2026 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DNhH2Ag2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDA3148B4;
	Sun,  1 Mar 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347433; cv=fail; b=M7P6zmrfUuPBBPThpHF1hSapQ4mtVDJNxFLkL/+Eqh71qwrpsKAUtFo5e08koR/2NzQXJcLuLbVAx71+yZcbgA2B7VK0A8RUmXzTbmZK8g5Huc12zjbAZODcZ4KrJZ8XxSP2skemmNmAgvWRO+1O0n+5FRb7aw7ti+PosJck2jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347433; c=relaxed/simple;
	bh=ObOh/B7zyetICib2trK2R5xDtTQgbot6DeckTumkvE0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcDglXK2D0AhPFJMdEYWYzJvPPWZhrpOsiG6Er84HjDSbGwlmWfA9CEKYhiOh7nVVYrtQducjPDzjhFW48V0yX8sm6yRRyGOJXcBaDgaHLkwSAuYSni5mwWm721q8oNojgHMVUyoPvqfQ0fhvGQAWqiNavzH+sbf434gLqwM4gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DNhH2Ag2; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SB1MwW2152321;
	Sat, 28 Feb 2026 22:43:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=1yKZSsGu6UgQkUI6Mf2vAKE6eo9h+wE/9xXoJ71y70Y=; b=DNhH2Ag2fb2R
	2kfnOG5+WOaxJdeScsi2K8lItiZ7K2n0PC67tQRgFF3r5vUOFEtfRaRrkvVqMHp3
	z/ahPh8jDxw8tkYFCScm5oEhs6Z1sJCyMcyRt7/FdY/2xje7EbJdm7eLreHY4OUv
	d0QV5belh+k5utLt9KSo7aXSoZJv5kKyICooqLv4DDCAsdghfDbnZQ4Z1TaNyHDW
	Ht6V7lKvmL6he39cEYGztJqc0TAohNm0iVl8xcQnKUaYVWXjrFQt9JF6Zw8fj+kX
	TyShLBubZCdhPuvv2bubG5irMubTsIMZXPXFAYkDLUNrvwHqkMHDj9mchWmvjdHk
	q+kmJljdJQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ckw8xw31w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 22:43:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1ZTNyDd9CmdE2HyVq9kROi828ypVWwO1Y7p8c8lEpuJZiOx5OI+RRP82aktWfPxABgxOc2Knd6oAMngYpUGg8WrESPUeNXC0voUgXnjV/VdZJP/m2Hb8yHa8Trzqmod4M2Qa8iNGFEJHZLmInyL4ofyTGg2Z95FlLFrnLC8GdWMP82ZuR8aNp1NLhUsAQjeAqLSP3J+H9FlX55U/wwzzh9GUBvNxQiwM3kCKGDEJ/nftWgUX9e0sSbStFws17LjIInmg5oU2ZSuCayFeJFf0O9FGeLmjwxK97SzqnSEKunWHWkam1GBzTCtbNYH8nUUYfZucMp4ECGX6hjyoeg4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yKZSsGu6UgQkUI6Mf2vAKE6eo9h+wE/9xXoJ71y70Y=;
 b=R/BplCX7Ax3b+QZz3mI3lbNVMqxQaLP5CDlit0UKQdhr4MkCBuoHC914fjh8Eb2bvorCiw6a/c3cplWAQqS2THJ3kcmaDzs2UGsy9UVbmZl0+R2Pn+KpMsmB6sUgW10VcqAGQ3GyyQybFcQ4yQMyvWlhuLWO0J2q93btSDmXBDcroM+W/W7YYIFaYrzBS3YsP1x5oBQgGryQhpNx8GCGbgo0QzrRtvS0NJl3MQEdpzzVHknvYuMejTzyV7veRL8uVACZ69kgCP2qXMUhddnl/rZZEufnPlPWwfYxsPXVVgG2uv6nuDU8BIOhmiCF6Ee197QYj/hdd2ZxwUkqJVdJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB3893.namprd15.prod.outlook.com (2603:10b6:5:2b6::17)
 by SA1PR15MB5095.namprd15.prod.outlook.com (2603:10b6:806:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Sun, 1 Mar
 2026 06:43:32 +0000
Received: from DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667]) by DM6PR15MB3893.namprd15.prod.outlook.com
 ([fe80::12c7:cfea:e8a3:9667%4]) with mapi id 15.20.9632.017; Sun, 1 Mar 2026
 06:43:32 +0000
Message-ID: <e824c5a3-cfe0-4d11-958f-c3ec82d11d37@meta.com>
Date: Sun, 1 Mar 2026 12:13:19 +0530
User-Agent: Mozilla Thunderbird
From: Vishwanath Seshagiri <vishs@meta.com>
Subject: Re: [PATCH net-next v8] virtio_net: add page_pool support for buffer
 allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20260228134122.631580-1-vishs@meta.com>
 <20260228135423-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20260228135423-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0149.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::19) To DM6PR15MB3893.namprd15.prod.outlook.com
 (2603:10b6:5:2b6::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB3893:EE_|SA1PR15MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ada1b4-cc3c-444a-2a8f-08de775ddafa
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
 tJ6ZZX4vtOGVgSM+yM/e+b4ojWq9eF68fBNJSREbAugVGZ8wqm3ofJeayGl1BPYjCSlzhhrj1NqUqko8O0NcLMq6u0oorMSBBH9ElizFz2/bNjvoKN8Nw7rhvlfMG1Pha+ZjCT4vW/tcibhs9UFWyGB4Va2Idjxo2PlCHOYgwoM1+6yEV/9MJXh7cwHqLAq/HjeXcAv/P2K6Nv/l/ckFb4YpGFfPr7//+D/4u6WtJkGMFOQ02YnYSuWE3CWVkic9MQ6V5PNWep0jUareBgBI1kBu0r1KCsjDlR+/goPYgseURtHZuVGT1Gh3396dbRSRfSxboXa+MF82Wfa2cYo+5/NGVj9gkgj+yZaBuvxAKxL7kcZkQxDDIunuqjZZLayU9n+ibewru7BkuvaZJB9NqduO776p6zIuKotGL01DNt0Hhl5wh2U+08iag87BnePI2IxQX/bj4ALjAnd/NqPskkIVt0EmNaovGDr00XncGhKJDVzJ4jOQxddD6uyjE9dTkzsGdFbj5eKLxc2vaTGiclWJhEz36j3+b6BXc1yrFNSA44Uf9y1iFO6XhzqCfryIyJ5/28mFV0savsq/CY8F82j/E+gFe49Icqwiy4qKxC3w8RqJQC4i8NPd3ehMT+Jamq+DTmFZD08/0krp2aK9A23N0nQP5UQlHaeGBrAXDUVlR6SxKyD15Gsz5R4wnIJC6gHHyaSnWAcqxbB5Le2PSuIFJoRZ7Dvp6Ze7XiT2zXA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3893.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VGVvcjFxRHlUY0JMWnhVckRHRGQxbno0ZFdDQ05FcGd6MFM1M2xyRklVdlJX?=
 =?utf-8?B?YlFvSzBUVlN4MFFVSStXL2taME1VMWt5UGkyNC85TWx2YW1YTldBOGhCY0F0?=
 =?utf-8?B?SHJETU5NNXcvVFg2Z2doeGVTdDBwT3BjQUJLQ2xHS0xEMzJHUkhWV3FrRGlI?=
 =?utf-8?B?QllLbjJNcHd1VGRFc09PTDh6RCs2aG5aYlU2c3VtUXJJcGh1L0FuQTJWOXBh?=
 =?utf-8?B?eVZ5WFlWTnBMeWNxblYwNjJ5dzVzTlc1akl2anl6VnlNcmY1MG5WK0JyMUVE?=
 =?utf-8?B?bS9Md3RWZFRKSWs4dnNKRFhJOFFBS2VET3hGcG5FbEJtWDIwRitNb3lzLzlP?=
 =?utf-8?B?Tkc5Zm95aGc2cFk3dlcxS0ZlVFVVaE5GSkVyU1pGU3JEMDJ1NzdWazh6QTlh?=
 =?utf-8?B?MHQ3bkFnK1VKeEZKUithNGtFNjVVNy9aQlV2eDZjVFlNenhYVXNSMzVyRXBK?=
 =?utf-8?B?b0dEY3hibTN0OUM3VkxUK000SUdPVkxSZ0hlN2ZraE41c1NJNm1wSXVuU2U1?=
 =?utf-8?B?c0F6SUFOejdMbUVOeUFZZnlBUVhNWVRnZmc2RU5RV1lDUmlEVTNRZW94d0sz?=
 =?utf-8?B?aWwrWEhjR1grSW5Qblh3WXJiMDQxK1F6eHlIaHh6TDlPRDA1NXB4SFdZcmZQ?=
 =?utf-8?B?YlFIaDIyRG1lNXQ3VnNzamNyZTM1c0dHdDdBUVIyWGxmNGJjc0lNUUt4blFL?=
 =?utf-8?B?K3J1NkZuM0kvUy9NVHM0ajhvNjRKOWRBQ2FnSzJ0a3RIdEpIaG9JRjRNNnlh?=
 =?utf-8?B?VHcyR0ovd2Q0Mmw3dnA5WDVhQzFDOUZpWERBeDE2bFI0amxkbzREajUzeEti?=
 =?utf-8?B?UHYyZnA5UHBTU214UjRDNWtQNTFiZ2VNbDFLQUViUGVvVWpmQzBqK28vL1p3?=
 =?utf-8?B?ZlpUQlFQb0QxTENmczdUY0JvbUhhTlpteXJLS1ZVVEJock9YR2hzZEFYNjNs?=
 =?utf-8?B?RlRxalN6VlU2cVJaWkxmNEJOTm1OVzZmamhvVXJuRlpJT3E1V2c2MGVPRk10?=
 =?utf-8?B?a09Bd0tmOEZNMnRWSEZsTXlMOWFwSlVCWVF1bjFGUUhLcGRzTGhTMGRmMjNL?=
 =?utf-8?B?MEh5aU0rN1FJMUplY2d4THQySnpncnpmVzFRTDdzelJSVW1YWHo5dm1HMG1O?=
 =?utf-8?B?RlJQbWJaRlpETWR6TFFRTEltSW5BSVlnVHNDei9HcEc1SE9NZ2I1cDh3cHhP?=
 =?utf-8?B?My9EUEJDaVk0KzRZNzUyWXJaT1FCbzdVZVZGaEhFVTkzeDV1eEtVcVlKeW5l?=
 =?utf-8?B?NmMvVjFyY1l3Q1RNNWQ0b2IvdUlMSmNNaVUyQ2E3dENGOHhhSXU5a3IvUlNH?=
 =?utf-8?B?THhpaGN4QmNmaWVvUjQzbjNsQmJhRTJQM0hxenZmOVR4MzIrNUVvREw1cm8w?=
 =?utf-8?B?eGxVWENTK1VncCtqaXBFY0JVaGE1S3pEc0thUVpJYWdhR21NN1RDR0lia1pr?=
 =?utf-8?B?bEZPcjNXcjBGUWlDRjk0U21sMFhkZFRMSWdzYi9tK1JPZlE2Z0FtQkRtOWtn?=
 =?utf-8?B?Z2hFUnZFNXdIeVc0TzJ4NmZVdXVGdU9lTW40Smc0TzA0V2xzdHRnclFLOEQ1?=
 =?utf-8?B?dzVGb3JScE1xcm03NWJBV0dDbjV3bFhmM2daakFYYU84MTdmamVsZ2tmYkg5?=
 =?utf-8?B?bVRPS3RTcDBlR0lzRGNiMlhncHljRVBOaENNcUV2ckdnTzBNNldVOFEzREdx?=
 =?utf-8?B?S1RpdXpPK2EvdVh0SjBGdmNXU2lFbG1YWElyOENTTDg0aHVKOGg3K0N1WjM0?=
 =?utf-8?B?dXprdVJ1eG5xOHdSRWpKcENRRkJCNEIyUjVYdFBuZ1BOV29qZjR2VU1UQjdD?=
 =?utf-8?B?a3ZTV25mUVRvNjdkdjg0Z3lKczFZMkFnQmpOWGgxNEZ3OUsvd0lhbXBJRVhI?=
 =?utf-8?B?aXA0ckpaZkR1dUJXSFY5Y084Rkw5RzRUaTNoNDdEZVNTdVNhVmthcGxydTZa?=
 =?utf-8?B?OFl0NVp4bTE1bHBGb1FDczBKMkNUL3E2ZDFETTU2WnE3SGxLbkQ5SGZaT1p2?=
 =?utf-8?B?MEVDYjBzU2xkTkpBUmIxUVpsK2EzaG9zUjVKaHYxd2JWV3R1WWEvUGl5aFVW?=
 =?utf-8?B?VlhCWXl2UnNDdnhjY3FsRnNCZUgzZkJUYTlJUkR5dXZJMThDZnI2Ykd0U3R0?=
 =?utf-8?B?SjhIL1FNOGJHUWNGRUg0bGxDbkRkMEw3T3FCTDR0UXZwcXBCMzI0NVZ3eU5w?=
 =?utf-8?B?dk5LWXlFdHppSlZhM3daZUpWenpHUnoxcjFoMm1rM25LUURzS2M3S2NUVVhx?=
 =?utf-8?B?V3g0SXF1TDVRS1NESlloWXZtR2laQVpXVTJ2VkNNajBydjZlcUR4c3BCZVg1?=
 =?utf-8?Q?K6s2XMfSAzLtk49u4m?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ada1b4-cc3c-444a-2a8f-08de775ddafa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3893.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 06:43:32.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5ercHV31Lkrxn1CHYHJpVQ8NHluMzDlExKrEpQRzQK05Pe1jfvqq9NjjBb29Gtu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5095
X-Proofpoint-ORIG-GUID: pV_b3cfkCMBTkaab3Bav9IWBbWBOGBFM
X-Proofpoint-GUID: pV_b3cfkCMBTkaab3Bav9IWBbWBOGBFM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA1NyBTYWx0ZWRfX7eb5aYPjp3T9
 ppVBUVe9M8UaWVdsF66bl/HOzL4avYhNU5Y1AIiNHwrFrks6wWBNldf3TjN7S0Y3PtxsOEKQ9s7
 69/x82XT3Id1Q70O04mC483SoiZNp4OeFAydSTgqOIaAgCvzTJUxLuVEGz+Kxr5wiRl94/UNftz
 ARqlAS04fQTUnNm80VnVKzvpXUBeYDRROw1jFa2etDQa+qBXjkx8ssFfNxIUDmOIn0jG0aSt7u/
 zUQaL2reYdodukEATsLpyQ22N/AvNqIlRZ6+e5cDCIepPqODyOlz7LXh6k+6Qd21biUTfRnKgLl
 3aMYfj8Ejm9+TL1pm7PrT7wA26uKv59sGY/Cdk0jvoONorHAq1c/aSuW1OQG6ow26P+FzedV8wr
 y+NKasLAfpeZBPIr0eWFXuerq8qA68CVC9uz/DpyQPPUAZVabpprZ8zhetyBNvnpoM6liMGf90X
 sKV39RJMDNYE1VEBhnQ==
X-Authority-Analysis: v=2.4 cv=FPEWBuos c=1 sm=1 tr=0 ts=69a3e017 cx=c_pps
 a=H8U4Gh8omvmqDI9iB/RWMg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=FUluw0iEB13zHwshHtwA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262375-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74DC01CEAAC
X-Rspamd-Action: no action

On 3/1/26 12:39 AM, Michael S. Tsirkin wrote:
> On Sat, Feb 28, 2026 at 05:41:22AM -0800, Vishwanath Seshagiri wrote:
>> @@ -2446,7 +2349,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>   
>>   	offset = buf - page_address(page);
>>   	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>> -		put_page(page);
>> +		page_pool_put_page(rq->page_pool, page, -1, true);
>>   		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>   				     len, truesize);
>>   	} else {
> 
> This part seems wrong to me: can this not be called from
> xsk_append_merge_buffer?  Because that one seems to still allocate with
> napi_alloc_frag.
> 

Ack. will fix this in v9.

> 
> 
> 


