Return-Path: <netdev+bounces-291576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLfEFw1UFWqmUQcAu9opvQ
	(envelope-from <netdev+bounces-291576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD735D233F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E12CD304892A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2DF3CC7FB;
	Tue, 26 May 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="uzHuNwXB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023140.outbound.protection.outlook.com [52.101.72.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DF314B9A;
	Tue, 26 May 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782469; cv=fail; b=MjexUdjQ1SzjwuPNKYF9ZV+yxV8X+nIIwMmvxM6x7rvkcWlKylXwnPZjA5hGUX4ilWhLRzSWrXTrBZWnxYk0/gD9JOXXnoaBT+0c6qw5hoMf18QvbmMzVk76CkgbNWVdqfUMuN7FBa3EhZuWtYNhArvqIVFk414KYHOdQmNqPRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782469; c=relaxed/simple;
	bh=hux4eFykUNvSyz4OkfdF8zFSCrF8QnD2S2KotCLdXAM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=TzlLbwzwbWvP6JjZEjgfOd0+fwXuGG3/H9zkPT7pMmbKwaJOcP2C3b/oOQz/nw5bN1+MEd+MSi1vpeqMsz6Bi6Km7L7dt5UfzDkpRzJ3rTmDlFSTg6w+Hn2wyiil5qT3WW9pxjCDGklAGH72ucH6xrDbFibqEkRN5O+ScUDdvHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=uzHuNwXB; arc=fail smtp.client-ip=52.101.72.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8RYZRC+wQyDC9DPjWljcC3I8liJnO/QqWo/zmtPrYgMTSFfPpiNZ4mNaSuyw+z3NYqZM6m0g1iZcLCzSRsUtAIBQxr1MdWRxiYUyrX1SnfTehHRShP073tPl0ctU06GneK6fDcDmcUrtE53PG/SecdX4dR2BoZxHZTaYwCgYuLqikD0aWWzc4B1aDVxmEr6xYjkhw1wbRomJPiZlm3y+efcDH8UDLCsvwAjoeV3ZOaNRn5u1cCFIt3+/JGsGjHug1j4hZzoVMZX2al9LvM90VxsspEY4NpkGJULxpr/mMVxLEGxGELSq8BrkSNUFJgc2WzU3OPeZCxw/Nb7tDI2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+OTfXZsupcevtQM6a4TDNyenrvqf7vSSqBN6Va30CY=;
 b=gL+fnErpOZoiKqeWw7F48ZjAn/cvMYYnQF4bQvet9SeyyY5DMDG6a/dQ34zSKTUeYBj1RbFMub4fQxiZ5DfTCdRpXmaqHJJUcD954Gzd2zr5o62adLsMUNgISeaSeXo1JcgHKWNs1zvHSdvO5/VOYnxYxsARyFDt6n/Lb6m0X6qRKDrQhjj5UC/1NNizfk/2UAIYp4EW82iSa37J+jmqe92QQA49YZex7eAczYTs9Z3PQDRqaakrMn36KWrPJK5jasuhkA4UhEDI5pnI3cgqr1CRlXUwBykszAqzl+rJZXIRisjdbcVi2pS3HTZdoXXfQlvxwyFWcX+3IYMKlBACZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+OTfXZsupcevtQM6a4TDNyenrvqf7vSSqBN6Va30CY=;
 b=uzHuNwXBV/OqMjQ8IZWpUmxutBHidvPqqV+bkaoFCK5LM7JHSdhi8MhMcwdxBvDAKtcfIHMLTz56tD0UVkioleslNOi84lnJPaX55uV5r3S3XKuOXcqqbpXq+YS3agZfzUqkl3JuAPTSDGa40Ibpsqtwm4IwLkOerqt5oV7UPIUUJT/Sht/Ue0A8gPxxqCDFNcLUutoPAOpjiuTQI8tzGu+k8R/8l3Tgzu+fNhjY4KphiJN5B//uRSLxuuTqX84n8xH9tB6spFOyVztrMt7rj8O9F8kALtd5L1rbKHcDBv+j73wFILMNp9eyICLvZnH1WI01tjiXFjCHHnOLWNqDMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DBAPR06MB6934.eurprd06.prod.outlook.com (2603:10a6:10:1a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:00:59 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:00:59 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 26 May 2026 08:00:44 +0000
Subject: [PATCH] net: fec: fix pinctrl default state restore order on
 resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-fec-resume-pinctrl-order-v1-1-f2f926325424@vaisala.com>
X-B4-Tracking: v=1; b=H4sIACtTFWoC/x3MQQqDMBAF0KvIrB2IQV30KsWFSf60A22UiYog3
 r2hy7d5FxWYotCjuchwaNElV3RtQ/E95xdYUzV550c3+JFDz4LIhrJ/wavmuNmHF0swlgQXRXw
 IIlSH1SB6/vfndN8/s1LK8m0AAAA=
X-Change-ID: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nimrod Andy <B38611@freescale.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779782458; l=2348;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=hux4eFykUNvSyz4OkfdF8zFSCrF8QnD2S2KotCLdXAM=;
 b=XDFr09JsIFaXXb3+m/BWQHWhc4d8i08p1PorbdJphHVGkLVx+jBf1nozdfX+mbyoLmAUvlEZW
 /VK/QptpLRDB7B6+fpmP3xavUG54FMstFVL13iceGYzfGGhktgx1TkK
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F6E1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1e9) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DBAPR06MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dcb8fe-8013-45d8-b060-08debafcec6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|56012099003|18002099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+Zd4n9HJPoVG8xkGpmJrmtGwKjZSHJONqRXcirbUNAXN+ROKpVw8/60WRAM4/0Gl5T4peJxSGptGW4b6W9/7wcos4EREWtR++sS2JVdXZCcs28xqPIARWH/VrFXNmoNelwtDWFHKI0cUAT8ha6lwRk8Cg/+0k4LMU3c6Aydf7p9kcCOFgMTer6CKQxkNOMp6BNy1Fr5Tcw+NOmRdDNGg3WCVFCRaaSsZhmwSGSDZHCE6WvRB9Rj2jnQ7epgHJv+oUUsVUB7AEGAE+gsWD1ZiJIbAaYY4tF+p33RS54LsDnbH8t6wXjIQcWOdQHQyCKb1EhYm+EbFGW72C1xl1O1+d4vyMRMGpSr2hQz69Z/G9UgHQXAsLbIpRecEIdOMpFEKZKbFjEFWXHFrABZ2WRkvcBu4MNH/PkWtkf4oerQufR5mo2N5fK6fFX4uU/Px/6Ielhz1fuj6L54ssYCpQ9DEXVhm4ohycFXVPz5lUq7tvHJrKr4JOZ6MsjUAsouTvUK5br0Pf4n0TU+kLMZHbTbpjCE3ZkyhZDwYs8SqXGEUHUOVk+J+wCqY0p1IwbCH+jiFEvlVmSNZ9TMB/YK6n4AG5jEgEhHqxRvFfV6b1qIW3Xkk0ATCYjDkFpMmpH4FF6LDJAgs4IPw0SPrYVsHd8cJSbqIlMpJMdkfcLdIVY+HvLgnMxAYlvdBq7TjKOYZ3azqnoU75r40ODmKrNrstKO13JgOGCI3/bS5a2Vd2kQsIiO2oiNWTyemuCPCHF4I/UOD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(56012099003)(18002099003)(38350700014)(6133799003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amJRcHRzN3o5YkQ5VktGd09SYWR3ZXFlRlM1WEFORStLUmVGUlQwby84WU03?=
 =?utf-8?B?T3p1TjA1MnRXd2EwNGcwNjFqU0JNWmNEUGlOdi9LYnB1aGtXdVRGZkRBVFp3?=
 =?utf-8?B?VUV1eGM2N0VhYmhNd1BHMDlJMXgwVWlvTEU3NHIvZC9PT1haQmhFZ3VqRFQ5?=
 =?utf-8?B?V2FxcWJKck1KV2ZtdWdxTFhXbVhXNytBdktVQkNsMUFFQkRqdkgza0VFeUNM?=
 =?utf-8?B?MjNhbTY1ZzdDOFNtU3podW54TmFYZGdMOW1YVlZxUDNpNDRFcTJ2MVU5N3V6?=
 =?utf-8?B?TFlYVVR5TW9vL2JzNFUycm1tWFV3cDQzWGFmTkljb2pJak81b2ZESjk3eW5s?=
 =?utf-8?B?Zjc1cnZLd0NSZFBOcVRKdCtRMDVsL3o2ZnhBV25TOS9xTExaNGZaaWxJK20y?=
 =?utf-8?B?Mjk3S3VLYnN0aGx1TGRGbjNuankwYUlLRFlxc05mbG9Pa1VwN3prckZlYjd1?=
 =?utf-8?B?WnduWmNYbm5HUHRaL0JyQWd3VDBwbkx2VHBCOUMzaUEvdlppWVFMMlRudDR6?=
 =?utf-8?B?TlhrVDBmSHNqUHpIejlJUXYvSEZLdzJ6bHJqcTdwWGxmbU5ZU28rNXpHRXBJ?=
 =?utf-8?B?VkgxcjQvRTN1RFZHekpQOGlocnVvd2FHb2lLSmxVVGVVMlVuWkdMaTlnL0xR?=
 =?utf-8?B?eFRaS0FHZ1RzSU1KaU5PRHZKbGdSR3RLWG90cWd1MWViTWd6WERML1BPRitV?=
 =?utf-8?B?RFI4RFVVdmxsdFY2YjJQam5HZ1ArRWFFbDlHZ2hURHZzSDdjRUJDaUtSQnZO?=
 =?utf-8?B?aEU3WGwvN2pNc3lvODFHMFlCdVJidlZPKy8rYXYza3YzakxkRDltYm1XNFNs?=
 =?utf-8?B?a3hVMXB0N2l6K0Q0OU0xL3Vsc3pYNVc4NHNTcFlYcVlMMGR1d0VOVFpEOUFT?=
 =?utf-8?B?LzU5QzYzMm5RZGhuZ2Q4T3o1bkRyNklTa3ljbHBMZytuNU13WU5ubnAxdlpi?=
 =?utf-8?B?TVVKTytoREVpQXNKVHlvU1c4RjVHcmNabGJvblVUbzF1eXovb3FaQXJPM3RD?=
 =?utf-8?B?SEV6TFJGS29tMzNUU2JtRmN2ZnNIZlQwd1kvN2xnbE9ocEhWNUdFNlZOOGpR?=
 =?utf-8?B?ak9Xblg4UmpDVTQ4d0ZveGppamhib0k1d0gyWGh1d1J0Wlg2T3NIN1o2MHd5?=
 =?utf-8?B?a0trUThUcW9TZTJVcHNESXVtaVFnbDRKbHNDdThNSVZ5N1oxK2xlNDVXODRx?=
 =?utf-8?B?a21VNWZYSEpqak90Z2F3dDdNaWx3OFd1bG9NQlFKbER1VkZUOTV2TkJhQVZj?=
 =?utf-8?B?L1I1N0grU0ZFV1phQTJ6bDV6MDVtbWtudXIvdFJzWDd1eGRMbUV1elRYaHZk?=
 =?utf-8?B?dGdRdElFQ1pybHkySVl5NHc1ZWp3UCt2aUs5S3ptb1VaMEJWMjR4TjRXa0hz?=
 =?utf-8?B?enA0bVJ6eitxTW1ZTTQrT0xlYjJpTE02ODg0WitRdVZqL1dLRzVENWJoWlZX?=
 =?utf-8?B?ODdWSDlFOGM3b1ZqV2ErM3ZpYW03WXltV3dQNzczc1Iwby9jSjkycEprQ2hh?=
 =?utf-8?B?K0xsS3QrSDhzZWN6Z0dzakpVaEZleTd5bDFHcUtKSENTQjhGd0dhM3RhcDlI?=
 =?utf-8?B?REV6a3JWZ3MxVUkycXQ2a25rRSt0eHA4VEJuZ213djNYMlNwSjcxNzU3K1Ay?=
 =?utf-8?B?Z2tCRVVKK1pqUWZhOWdVQ05HQjdhUVIvWFNwYlM0aDlmTTk1bWViZWYzc0J4?=
 =?utf-8?B?Q2psR0c3dzBQclIzVWJOckdFV29ZVWZxaW05K2w3RTNOZE83eW53V0Vycm9X?=
 =?utf-8?B?K1pETEwzNmpHOXNkTG1EWE8ydDI2SWZhWGJWZzZQdlQrSVVhZkluVzJGUVpY?=
 =?utf-8?B?dUVvcEV1ZTlpampoSFh5TU1jZ0hWZTUwNkN1blEzbWRnTlJxTmIyYmpTN1k1?=
 =?utf-8?B?WFZ6NkVGUk1uQXM3ZDlLTXQ0RDdFd2VQWGpxRGMycDVVcWVDa0d3a2NmeHJ5?=
 =?utf-8?B?Y1NDSHJiSG83bVhkRmNkQ2RrY1RwNVNMTmhCQ2hNWXg3WS9KTzZOL29acWpR?=
 =?utf-8?B?SXZ4bWJlOUlXUDlGdytHZHVJZVJUYzFyTUw4ZHg0NVRUSURNeWNxaUlRZU5O?=
 =?utf-8?B?cWZJWEk2NEhHWVlDMDZyempoUk9iZHlnOFJnTUN1UGhtdXZZTkI1NWFuUkpN?=
 =?utf-8?B?d2JWb1N6QWFGS0NzTFluZ1p0WWxnOGlWdFg4Y0xKdSt3QnJzenFOUkhESnlv?=
 =?utf-8?B?VXF1RU5MWjNHb3pFUnBNVzdGd21GKzBLZUtjSnVtUDlSQ2NPRzhNajlSbUlP?=
 =?utf-8?B?MlR1bElxbWFnWlkwd00vRiswa0J5aStFbGpHa1hVdkVxbDdRUDVOY3kwMFow?=
 =?utf-8?B?VU5ScXk5bDFveVROdm1vRTFUWHh6RllRK2Z0TVZwRXZlbXRZbjFrNHZYUGlu?=
 =?utf-8?Q?WurIWswGgd0xOdN4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dcb8fe-8013-45d8-b060-08debafcec6d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:00:59.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI1aHvO8POWLZ7ghJdo3C1O+mkFTNz+/GeDyAUSRtV9iewq2zzHQpkpzzBmq6SCiZ52FAol4tz42JipdeiWDlMzBSUwArYsyKkwYoz2w+Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6934
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291576-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[vaisala.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vaisala.com:email,vaisala.com:mid,vaisala.com:dkim]
X-Rspamd-Queue-Id: AFD735D233F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In fec_resume(), fec_enet_clk_enable() is called before
pinctrl_pm_select_default_state() in the non-WoL path, inverting the
ordering used in fec_suspend() which correctly switches to the sleep
pinctrl state before disabling clocks.

For PHYs with the PHY_RST_AFTER_CLK_EN flag (e.g. TI DP83848 or
SMSC LAN87xx), fec_enet_clk_enable() triggers a hardware reset pulse
via the phy-reset GPIO. With the GPIO pin still in sleep pinctrl state
at that point, the GPIO write has no physical effect and the PHY never
receives the required reset after clock enable, leading to unreliable
link establishment after system resume.

Fix by restoring the default pinctrl state before enabling clocks in the
non-WoL resume path, making resume the proper mirror of suspend.

Fixes: de40ed31b3c5 ("net: fec: add Wake-on-LAN support")

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f89aa94ce0202d5f28f37362ce70e0943aa14025..723af4c057d7aeacb1e90301d95da52b79264400 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5594,12 +5594,12 @@ static int fec_resume(struct device *dev)
 		if (fep->rpm_active)
 			pm_runtime_force_resume(dev);
 
-		ret = fec_enet_clk_enable(ndev, true);
-		if (ret) {
-			rtnl_unlock();
-			goto failed_clk;
-		}
 		if (fep->wol_flag & FEC_WOL_FLAG_ENABLE) {
+			ret = fec_enet_clk_enable(ndev, true);
+			if (ret) {
+				rtnl_unlock();
+				goto failed_clk;
+			}
 			fec_enet_stop_mode(fep, false);
 			if (fep->wake_irq) {
 				disable_irq_wake(fep->wake_irq);
@@ -5612,6 +5612,11 @@ static int fec_resume(struct device *dev)
 			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
 		} else {
 			pinctrl_pm_select_default_state(&fep->pdev->dev);
+			ret = fec_enet_clk_enable(ndev, true);
+			if (ret) {
+				rtnl_unlock();
+				goto failed_clk;
+			}
 		}
 		fec_restart(ndev);
 		netif_tx_lock_bh(ndev);

---
base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
change-id: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>


