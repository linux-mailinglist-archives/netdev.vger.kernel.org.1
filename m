Return-Path: <netdev+bounces-293051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGfpLahVGWqYvAgAu9opvQ
	(envelope-from <netdev+bounces-293051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B02F5FFA70
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE369301E57E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A91F3B7765;
	Fri, 29 May 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="HBlb4Eb/"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023086.outbound.protection.outlook.com [40.107.159.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99E3ACA54;
	Fri, 29 May 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045194; cv=fail; b=e8iHpKHBsuInOJYb4bz8p+kGMA43PsdqiLpf4CD5uI8R0yW59VNFPlJL8R9pP5nAaGhC1MskCbgYdMVoJ0CXxLxo4+VUTHWUdfsO3yFdByPeNmtNEBRzLjYrF7yD3E4HKqrWhtJ9Rp0zi9bOUrLGk/cksKSTqZrO/R581lX9FJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045194; c=relaxed/simple;
	bh=VAkHpnVd7hl1IG7enjFur2ehX6kS8Ug0CWdlKjDp6K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0ye0aUf9UnoNX7I6Zp/wuftDBQOKRktVFR0H3uTw+s6dZQcMIjxySHNHGq5wXuM8qEjEJVwu2evcQZdA5qbIdXZ8RVBOdfaPWC7PAZmuqCrinjgaa5BXxJfC91ZO5LVkP7ob10rbqYE4MxnZmFGVaRqR/mU5fJmUJlRoSs5dLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=HBlb4Eb/; arc=fail smtp.client-ip=40.107.159.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFHeoYu7f34gLULjuqm5GwJQ5blWzeQOC3/i/6XQKyEMNsZ4Qdwac8MjT7JjYkqtyklsNOZHXxSxgQHbbv7LC2CIXbR6UpDZi3BMZdx7kwywaniewUXMA4mvSLOJ2RK1YY6lu1W86/QAw+RG9ML44wEB0tnmtDhsYVmy28Qbiy6Y8A6Dl632j4M9r5RnOGjTycg6lWiTv5RgW906jtTZmTY25jFNRlsN3nw9zyVTtdtSOy78lW4gH3tngM5vzB7nq8yteh9uyoJDM9jVZVmecfLQ3bpnXwuiji8Y9jHlXRH1w3NH+skrRwjuvszAANcXrYDQ17edE3/ViZBDDG/JUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpH9arenzIdR/TeApQnRgoBovYQTgz24BNA/v2H7p+I=;
 b=ihMg0MJowpodyZntySf+NUaEuJs/u8LHPvzPpc+HG8sG7kGbVfJR0slH1WhhiB8SNW1QxSlfW2T3ywvmmMwPR56ly+Ix+yxNvBy8tKlOBIJhviAfoKf5TThUqFNcVKcoUGaBVvurtw6ob8IpdWltGp5aDJs1YK2skOl15jA1o6HDmr57jOV/laEyG9yzyKDZkVrhqTBMgQQlIiYUGiGUARUE6gcxY8AufEpgQZu0EryFElK0WgS9fVOEeX2Cpw9Vf1axk4tP8R1xFtCDOMFxHFTtrGjo6kHmxcNDfZIOx//62mRYsDxKurMHop8vMa8dPatdhEK0aKSQSwy94PO0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpH9arenzIdR/TeApQnRgoBovYQTgz24BNA/v2H7p+I=;
 b=HBlb4Eb/3fS29Tp6D6uA4NaoKm2yCPMA9mUEnk72T/GHAYbX7fes0vZbO+xn6Zxl90pWcGEz/qXT7C7BUslAq6n7tdUVkwZ6uzxnO9dMKAp7M6dElqqB15UteoS181ztsRqBaFJHmVbwlllE1gAIy3pDG0gWivnD9w/egQM7BAr/llMxnhrXv6KmBFYc5eTa/HQvpTQ3eydJ8l9zOHaXbiusUPe+nv7y/YDiHv9Bu4siatFlda5K5xC92YdDaqzUEQL3PDYR+7d7Gxd3cZd7iR9yssP+Z7idYdxpVwzOUtuBy+SQN9ue+olFs3LvJjy05V+jw6jfGOZ0POhrvqnBSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DB9PR06MB7770.eurprd06.prod.outlook.com (2603:10a6:10:256::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 08:59:47 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 08:59:47 +0000
Message-ID: <c11e4e11-12c3-4297-b870-b734eb75a580@vaisala.com>
Date: Fri, 29 May 2026 11:59:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: fec: fix pinctrl default state restore order on
 resume
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nimrod Andy <B38611@freescale.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260529-b4-fec-resume-pinctrl-order-v3-1-6eda0f592fca@vaisala.com>
 <DBBPR04MB750094BCF64765DF8463587188162@DBBPR04MB7500.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <DBBPR04MB750094BCF64765DF8463587188162@DBBPR04MB7500.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF000239FD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2af) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DB9PR06MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9e19ee-556f-4665-d77d-08debd60a26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jn+s0lc6CiF2Mjk6BScZMNky79ZAj+criRg0rHrhPGgqKnggIqtcKWcG8GOihQZbWudGCpJ2OY5FnL8ujpnSoVTNX6QkCg/0J6PKFosO7nS04r04VcWgkParlxbabVXVxAqj70aqiqJ9jgO1L53y8rwyyRH8Vx6GkTT7d2+oePqY5ruksDVUtWlWi09qfCUqfrafcr872oBnLQvv7A3PxauuOnTdy5jAlgvMgNxvBF4wqWXn0DpLBDx8X8+ed3JdMUibjD9QAR1/pOp0iT/gfSgs4TFckAb9DryLFkWi3JKSrjEKSY9+QE1ZkwWncKSbGDQpeeuqMRcAiCU+hDdWUXGM94DXR58VxDzL0NPIJXDg7jIm8aQOw17B87dxDFTNdewQl1uHe96EB3epeQMNJHH0Tw6Elu2zFT2SOVrx6mgdwue/BMkvAJ6L6VnPb03l5qQ09MZIrwCUGA50WFCOolVKu4Xfl6pBe5egVVAWX+3rEACsyTIeMSL6eWgzLsKe18yBu9ukDPsinsnvidMrHZ3IEfR/33B5/verkYWjBtxEfJVWNWcl8cFpncc/P+zaklw9JDgPqXIOjXkGAWkaHDh5gFF0m1znxTeyQ9Fm9fRHiQGK48N7YPB5iCgcykDZpNHMk1xM2dcTsx+GOTS+5LePrS2OGvg0AiPG87T7w8vv04FxdHwjbipLZwDcSSu0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXcxblFsVG5pN3NkNmVrWmxSTGhYSGdJd2FDaFJjUUVES0xYZTBRU3NwUXpO?=
 =?utf-8?B?SVRGZDRyMEpEMkFHV1p3MG9HMDZWbkcrdzZ5ZGtRdnJXS3R1T29aeTJKK3lr?=
 =?utf-8?B?SzhQTGhnY1ZGWHJVdnZON1ZCcnNTVUlJV2w1ZzhWM1F5VTlxcWRjeFJGczBN?=
 =?utf-8?B?NUIydEppNmR3Y1lsaTNSNVRpczM0bjNOZ3U3SFNxRE5KbE1Ca0lRL3V6amRF?=
 =?utf-8?B?djFEVjN6bzFYeFNiWFFiS0hsUDFZbzdQbHBsQ3A5SWFENjZKYm5mbWE5UDVZ?=
 =?utf-8?B?eHppMWhYLzNLbkhaWndPN1RPOGtmSTB6NHR0anU0L3lNTWFpRHVjNGZZUTR1?=
 =?utf-8?B?MnhxTHBXL2xvT3U0bWNzRFJKcXNRZzNHb1RaVXNGbFpLSVI5dWVza3lWRCtJ?=
 =?utf-8?B?VForbDBHbUsveFYzQU5TYVZaYU9ZWkliQTN0djNRajVKYjJTWmlpZ2kyZkpM?=
 =?utf-8?B?UytMVEp5SVo2WU5nNXNPbWNtaWphbVNjTEVONHNQZFYxSGJEWjk2ZC91Z1dq?=
 =?utf-8?B?MnJ2dkd3NDA5RHo2NnJ2bGFBbzBJTXFhSDBSN3ovVjlXdm4yQUljb3B1Z2xU?=
 =?utf-8?B?elNVWlg3blA0UWJNT2xUMmNyYTZlOXJWWi8zQ2JYNzljWEp2M0V2UWhiL0RC?=
 =?utf-8?B?SUlvYnJxaDBBU0I3T1ZraElKZk9mdlhXNGdyYU1qV2RZTHNyNkhiOEZaUUhh?=
 =?utf-8?B?K3VOdG0wYlF5SXZoOE5oMWE2NytvRWR3d1JPS0F3MFpIUXhNdzQrZlRPc1Vx?=
 =?utf-8?B?ODdYenlwcW9rZG1TMGZBcTNpY2tuMitPd1dSRjM4V0tvSnpXZEVlbExrRjBD?=
 =?utf-8?B?VGpFd3BvNnYzUXZiY28yNGtlekRpSWw1WkpXZ25CbS8xMTQ4ZmJTTmFRY1Na?=
 =?utf-8?B?eCtQV1pZVzh3enIzTEZpeXZ3VGUrdmxUQzRNK0tKUVZRVHFEdUhMNXRxbUlC?=
 =?utf-8?B?VmpKb2RMaHgwRWFsaGdiNHU4bUhXdUVtZDFVb3BRQjY3ai92eWQ0V1RMVDln?=
 =?utf-8?B?ak9aK0lLY3d2S1FBYmFESHBTMDErMGg0M2lSSURWNEtPZ1pyQ3NFMHlFRHFU?=
 =?utf-8?B?dUd6Sm5VZ0lQdHhxazVDb3dsaXN6R1lLK2c2WUtqSlBmY2svOVI1eUg1Skp0?=
 =?utf-8?B?NVhIWnBOMzBscFM1RjI3MnViNW5QRzQxcUNNMHh6akJESitRSytVcTBOMmhR?=
 =?utf-8?B?a3M0S3daNGJaa3NGaVZPQ21tNHlnaE9DekJIOVlVWFVCd2Z6S25Kc0IrdEh1?=
 =?utf-8?B?UUVINllRVzc2TGFTNUdkbFdhbk9RbDF0RlBaby9GNG10eDF5cjFjaEZ0U2ZV?=
 =?utf-8?B?ckgzZzBrbFZrQWJ4SjFGcjU0eUY3cnZwSXVCL0ZvUTNKWGNQeEJJOTEvbHJ1?=
 =?utf-8?B?WjRsdDducWQ2dW5BWmZuVDVhcGdBUmNQSUhJeUJJVUdLVUZyN0NHb0hLMDQv?=
 =?utf-8?B?czJ3S0dtRnNsdW9uejdhL1hBWTBtdkVtTDE2MEttZ0M4SUtISFdPNVFCbVRJ?=
 =?utf-8?B?UWJqbjRyendCdEpmUXRTYkR1NG5RMXRGT1lDazJwTEw3eklNYTdGOWw0eGRy?=
 =?utf-8?B?ck42YzViTGZlM0pYeXJBVmhnNENIZUNsRHozSWFnak1ma2JtUWdJKzhKY1M0?=
 =?utf-8?B?bHpXaTNqdUszNmw0KzdneDgrdUJWVGtqZE9jRUtLSTkrUUZmR1VMMmhUUkxL?=
 =?utf-8?B?Wm5POHdRaTYwNkhjeEZnaG9McTYycUJzK3FKd0tKSExXZEkxV3BQOWN1TlRD?=
 =?utf-8?B?Rjc2Qlg3eWNjVlZSZ2IxSjhnanZUclFONTBVSzRJeXZQUUU4eG9DVTZvOVVr?=
 =?utf-8?B?ZDlldXFheEs4dmk0M1BJK1Nzamk3T1VtYTd1ZCtidDVvbHRQcDVlZnpMOGQy?=
 =?utf-8?B?NEc4Y096c3ZrUkZoY2xjNU5TUk43QnhjaDdaQ2RLZkljTFdrdis5RXVJR3hF?=
 =?utf-8?B?MjdHNzZDdTdJUE5pMDY2RFpZem1tVFVQL0QxcXpINmhFam5CUGhQVUJ4QlNU?=
 =?utf-8?B?bWtmNWNkTTI4aTIxWU1XNjFCeDdTSzhPcFB3dVphV3dUZmpJYmdrQURHZk1C?=
 =?utf-8?B?QVZTNFFkb0tWS25ZcU9pWjBMbzltYjNpRUNEVDBNUXFINi9vRys4eG1rSUJj?=
 =?utf-8?B?ZUJ3UlZXZk5jcjVzdk1ZR3RTVmphVnZ3Z3p5eUIwWGRsQ2xpM0p0Mmw4V1Ev?=
 =?utf-8?B?SllWbnBiSks5bmFPSVl6UEZyUGJKUXBLSElDZTNUcDF1L2NvcjFQZXNjNHBv?=
 =?utf-8?B?c2VyUEMxUGRQdm5YSU5rWXhpWVI2ckp6L2NRZ3lZWUp3dkFQWVN4M014S3ZD?=
 =?utf-8?B?UUhZdFlaS3V1M1pjeE01am5aaXc1eFRNbUM3MmhMTGd5Mis2NzZ2R0R3aERy?=
 =?utf-8?Q?8nFB+yiGLxmEv0y0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9e19ee-556f-4665-d77d-08debd60a26f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:59:47.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjH9XzpI80elLY7rIxQhN5zISH5DCVaXADzVMOBKoeNEYI9smjnPhES9IMdwNHocY3SlmR6zmpYmU/QuDnQl2IjGx3ek3A32bBradBL16MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7770
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293051-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[vaisala.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vaisala.com:mid,vaisala.com:dkim]
X-Rspamd-Queue-Id: 5B02F5FFA70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Wei,

On 5/29/26 11:37, Wei Fang wrote:
>>   drivers/net/ethernet/freescale/fec_main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index
>> f89aa94ce0202d5f28f37362ce70e0943aa14025..6ebde65d7f1b8728a6c5d28f7
>> 5cc0b0c4d983969 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -5594,6 +5594,7 @@ static int fec_resume(struct device *dev)
>>   		if (fep->rpm_active)
>>   			pm_runtime_force_resume(dev);
>>
>> +		pinctrl_pm_select_default_state(&fep->pdev->dev);
>>   		ret = fec_enet_clk_enable(ndev, true);
>>   		if (ret) {
>>   			rtnl_unlock();
>> @@ -5610,8 +5611,6 @@ static int fec_resume(struct device *dev)
>>   			val &= ~(FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
>>   			writel(val, fep->hwp + FEC_ECNTRL);
>>   			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
>> -		} else {
>> -			pinctrl_pm_select_default_state(&fep->pdev->dev);
>>   		}
>>   		fec_restart(ndev);
>>   		netif_tx_lock_bh(ndev);
>>
> 
> It looks good to me, thanks for fixing this issue.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> 
> By the way, it seems you posted two identical patches, which might
> cause confusion.
> 
Yes, that was my mistake -- sorry for the noise.
I aborted the first 'b4 sned' with Ctrl-C, but it looks like the message 
had already been handed off to the SMTP server by that point, so it went 
out anyway.
I'll be more careful next time.

Thanks for the review!

Best regards,
Tapio Reijonen

