Return-Path: <netdev+bounces-294320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySN/Jo8YH2pgfgAAu9opvQ
	(envelope-from <netdev+bounces-294320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32C630E03
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=amperemail.onmicrosoft.com header.s=selector1-amperemail-onmicrosoft-com header.b=uWRCLriy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294320-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B6AB309B0BD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878A3FDC16;
	Tue,  2 Jun 2026 17:50:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021139.outbound.protection.outlook.com [52.101.52.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBF3FD12A;
	Tue,  2 Jun 2026 17:50:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422604; cv=fail; b=KrYUg9S79uJf0RAqqitxhR7sMswzMwtIUlmLpc0HCXqwlMubobxvh90vcXeH4oz5c+kcsFpFe7mzEVccKC4MNE/NCAg2sIo5rPGIWNnBrOUj29kobjTa5ugzkgJvoSR+pwu4PSHgoVMym3yDPNlSjAe00Q3l7Iqqt+LQSKcJK0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422604; c=relaxed/simple;
	bh=1YPByECFRvLB4wdEdr1lMMeh/s9KY0s0tWKWHDNTlr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2tYp8Mq5q01D4m0HTEc1rSly3P1+EP+ylz7JIfAYDxpXDtpu3ctrH9Gky4UjE8vPG6zYxknH44fEaxMOl7ubdoL0aQ52FGFM3mZBsC1/4QiT4Q4WpCnnq2eJ2Ic8K7kWIfTAZ548tWmlC3Zob8yf/fmuuKOy1+bJn0p6DkiWLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=uWRCLriy reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.52.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J92aQdIp3YKRSeeBrhvcAUywsGqteutpwniuIpKMUkjrguRxSgTPHOBROvwZP2pEdeUDbNj5kLLDYiCxKAend0b5Du9+F0Enp2Hf9jur+QsxlBjFH+TRE2aP+rNGRBhantyMbJG1AG71o9JK50AkZYTF+Swj46X4ZkeNrWbMVSDn8cBYEehezSrpIyuipvUAKSIrGUyh8ZLlpL/TwMEcSNI42KMydD1DegW+N7S5WzHGfCduYJsdwOyTA+ahUtHprFIm5sMr04L2J2v+jRNED1Cxp0Ce0FuB01ZywnwSG0hMhHes8naOhKCGy7lqLCcUTg2LHQj/CDCGE/MlKUyXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugJ8V2nmER9Nc5HQjpxuyeBnPf9fq/l4TaBFEorLiK8=;
 b=F31KuaCYB5LdvWcSyLx6TdsLJQChvHuRUr37nlPo43JA50dmLDu3ClLDsVOLsOlU6W3CLL8965F/WfUxOpBpGDSyMVLtJZm5Ku6BdmQzZ3uaUFXjBtPjX8auEM4MlWUh5Rt0mv6I2hbLRH8mcStiFUPcnPUUDnA4SXsDa1In8+Csv9uc++e8zAIcSd/ynfpfLsuesilBE+66yenjYxcx0GN8lORRtykUnGoFr9EpYDXeSdsCCjhkEiUByPYjlMvqktsNo6IwKhAyy70DXsEblRq9oRUQ1zxfaFjhl8yjCFwbE4U9W2VeLIcvd6Tz3qcf2dhXuORtn4uiLAVLA4g1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugJ8V2nmER9Nc5HQjpxuyeBnPf9fq/l4TaBFEorLiK8=;
 b=uWRCLriy6s46c4IQGm2IFO0vsC3Jr3i767MeOi0NwRMUjr1nidZWixKz0IHGso6oElYS35xRuUQ/lKqZfPPntMDqYjUbJFclq3rpKe65fNyxGsJpECu/CZ50f/EDsLObaeb8HFiFV7AhsWWbJJkUKWSrPtTdYqEQ80BUtZTu1ws=
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 MW6PR01MB8381.prod.exchangelabs.com (2603:10b6:303:23a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Tue, 2 Jun 2026 17:49:49 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 17:49:48 +0000
Message-ID: <edacdad5-7936-4fbf-ba66-973768ebdf73@amperemail.onmicrosoft.com>
Date: Tue, 2 Jun 2026 13:49:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>,
 admiyo@os.amperecomputing.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 Jonathan.Cameron@huawei.com, lihuisong@huawei.com
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
 <20260528084611.133703-1-pabeni@redhat.com>
 <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
 <8c2a9e591ba22a95962c2c5f7dff5971fc5123df.camel@codeconstruct.com.au>
 <4fabc99f-52c1-422e-9513-69e2190bc91a@amperemail.onmicrosoft.com>
 <068cd5ffb49aac3bfd2184df7289093cbcd524ee.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <068cd5ffb49aac3bfd2184df7289093cbcd524ee.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::13) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|MW6PR01MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ab1e16-8a45-4c50-45f8-08dec0cf5713
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|22082099003|18002099003|55112099003|5023799004|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	LMNr91uLMwjJiEvrBfuQHyp1fUfMtKRmGtDzZ5rdm14J7Hb4YhWX1d5uYrsqkLpk5vHaeumpupEPCzm+p9vh9XpXwqmUyzcD7pLMe+6Y2ZTnSougyKVWucod+kWeKv+RexbxgVFLleS1m163GeCH6co7h/BuVBwcP9UhSPEO8trZBlr1eM5gnPXW1VHO6bmakyfldltI4FeoAD80GwCAYv4ZnLkIfybuZSGJfejXZt5qorhnTQIY8+fwJNWwHpKklyZNaC4OH6vn2+tDI4gIHwaM2SU7YfSxsGUvy8sFioJuNX0Q7cNiFV7UbIwoksVVFBoLoxzPT8FWpA9CizYOXtA8fE2hnZhZ7nr5ItO/ImnHwILR1aFnR2wrqPHtszCQyk2A8AxpIZOZ5E1xBUpusN7cRZ4LpqXW29tTjwf4JlQ3+Kv5YZ4zjkQQJAPUqh2pBePev/ND90dTbQIYvRtL+4JV1a22Qd/xMKHuwplBUL8YNtQDegfvUqaHn8uIu3/0Y581riRF4DkWSjMwPidlR0m17Tj+OHPpTtnDVdQvDEkLkvYvhDdoSaNfs1iwQiPkzfXjV9Xfl/qcHnHKbvBmAQ0cW3/oHfXslZ+muRuH3KDTF3hQ+qxycqOGLH9mkd3e6TJS4zU29hqZndkAslBxAwIqBIT/zwdyJ16KLoa02vskv2tooVLXOAjWzua8IE8jcyq3Fj3LROgXnxV1r56Tdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(55112099003)(5023799004)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWlLV1hIUVhrN09tdHpaU0xxZUxtck1XSmVYRVZLcmtWd1JrY00zdEdXdkYz?=
 =?utf-8?B?RmVOdFJOOHZiRFpKc0ExWUVzOXlQbGFqYXQ3Q1VHcU9YMElUR3Q5MkY0SDcx?=
 =?utf-8?B?NlNFWHNHYXFJVG8yd3NmTW54cEtUYzdJTlFUNjAxS09PMmp5UExCVHdNcnFT?=
 =?utf-8?B?T0I1ZXhQZTFUeS9YRzEzT2RyS3lYK2E0VGZSaXN5akdORFZvOHM0MmZyZENz?=
 =?utf-8?B?aWNwM09YUE1kN0VlTElQSHVnQlhoTHdWMGM4ODdsU2l6ZGZIQTMvblNZSnhB?=
 =?utf-8?B?S3dkTFdyVVJKV0s4K012OVpkSFI5YStBblp0OVFEcEpXWm1aNldYYkhTdFRT?=
 =?utf-8?B?RHpRQ0lpWDVXcytzM2hqdis1ZFBPZjVOOUQ1dFRaTDlYMWQxNzZTRGUwOXh1?=
 =?utf-8?B?bkhhenZWNnhTZzl6VTBHRzZvU3A4VEt6YTFtUXFyV3lYZFFJays5SVpKYXlH?=
 =?utf-8?B?OVdvZ29NeW5zeUk3NXNBV3NSclZGcm42RDlwZFdaT1dPeXJ3YnBoWG5zNENP?=
 =?utf-8?B?cWNESENCejRIQ2lCZTVuQTJoNElxc2ZpT3dqS0YrQzVpRFA1K3NnaExMaEND?=
 =?utf-8?B?L3FQTkZhOXRYWHB0NXBldC9HN1BYaVMraUk1bVZmSHFGNmkyZnBSQUdRNjh1?=
 =?utf-8?B?N055dUY1NEJIYkZ5SjNuekdKZTVZYmx2UGJvb1VRNnVZY2w3a3lxWSs5bS93?=
 =?utf-8?B?Ulh3SWgycCtUV0hmaHhyT3NTR21SV3NmTmtQdEhZRUcxZ05TdUFKRVNaelYx?=
 =?utf-8?B?bXFFdUsxTzhIWWt5dEN2TGhHcElHYVc2RUxsOFdGc1k0K01wNWJKQW16YWJN?=
 =?utf-8?B?Lzl4aFpXYkxYRmdVaFBkR3REdjRZRHdhSTg3Sm9XQVpVYWpPWnVMNFZHU25K?=
 =?utf-8?B?RFcwVisyQjVNQk05UnVYYXU1OWVsY3JvUFZjYURNckRYY2tubm1LZDBldjNX?=
 =?utf-8?B?SGNFL2JlVkkzNkUzNjJ1MUlIMjdHdjRIczJsc25FaFY3L2xqZWZwUGt0cVlH?=
 =?utf-8?B?Ris5OU1zUDRYR3JlSFUwdS9maHIrWE84cXpkbmI0MldwcHRPK3AzdHZrQ1Vh?=
 =?utf-8?B?djd4a2dPSTB6bTV6UzNtdXljbzh0WkFTYnp0ZGxFOFJna0JoclJxWjRRM1VK?=
 =?utf-8?B?OUxOZDJlOUc2WUt1c0hsUWNzUTBpTXNESzg0RGtHdExuMUl4VDllWThpSXFX?=
 =?utf-8?B?RVRzaDJPT0dSUUVrOEdicE5YTWx5c2NaeGxKYXN2S2hGQkViVnZjY1QxcTE3?=
 =?utf-8?B?TUZ6RStLd0xTejc0bjNtK1haZCswd1cvemhjVXNOZ1pKTms0ZDJjY3NFZjZz?=
 =?utf-8?B?ZWwrN3l4NW8wRnRUck1OLzEzS1FRR0VRWFQ4UU9vYXdZVTY1TXh0NXp0VFJB?=
 =?utf-8?B?ZXlDd3BUOEdVTXFZL0xDRlRCNHZlRDRZb2ZtbnZ6ejZHRVFvdzJWNnE0ZzdN?=
 =?utf-8?B?UkFEWTBNMWd4cHVqcG1XbDVMLzA3SkorWU1JL210VzgzUExYVFZpdDAvYkJS?=
 =?utf-8?B?Z0NrUVBwY3JPWGpvbWtBaGo0UkVqTURQeHo1bmxGckdmY0JPaGhPVXh1NUc5?=
 =?utf-8?B?RUp5QnRBQUtwZlNYUGZqSi9LcVZrb3o2QUVFT2E4QXArbTdLdE1SaGZRYmlF?=
 =?utf-8?B?d1dTTTUyaFo2UHhQUVErNGRmQXJ1WkkzNHRxREdDV2ZybFN2Skw4eGp3aDd0?=
 =?utf-8?B?c2JtNUh5UjZ6VDFObWYwYmhxemJGYXdKZFBvb3lUZFJLejBiQy9YV0N3VnJV?=
 =?utf-8?B?aWlhOVVFOTRsVUhyK1JtTXBzM3Y4UkpyMSs0SmptQVlTSm4yQTYrNU4zcFFx?=
 =?utf-8?B?bm0wYkV5MWprbzdtUGFLaHpaY0lQNmxnQVJpV3U0Rm12SEgwUmQ5V3ZMR1RC?=
 =?utf-8?B?NXVsU1ljN3p6YjliN1ZDOXM4elFnTHNkL2xteUErSjZISXF0SkxXaVhaYWQx?=
 =?utf-8?B?WnlqYWI5WCtUWjcxRGdIVnFJUUZVeVUreWpOK3YvcnNITWpqY1lpMVkyRTZ0?=
 =?utf-8?B?VDFnSnJHTG5uOWxadzc3ajRqT3ZMUDNWUkRrZWVxOHp5elVjSDhjOTJ3dGxH?=
 =?utf-8?B?MjlRcWMxQzBjVjdZdkxRYXNPL2VUakF4WVVLSzdjWTQ1dWhxazhUWXRCeVVC?=
 =?utf-8?B?YnVIblRGWkpEVjVSTkw4V1Z3L3Z4aDJqbXdZSjM0WGpaYW5WdEpkTVN6Y1ZQ?=
 =?utf-8?B?M0FpMkVYSVc4L0ovMGF6S2JKVkFLWC9jWHZFV1UzaUMxKytweVNsS25aOGFI?=
 =?utf-8?B?amxYL1ZCTFBmTlk4QkFxNjlTcmdnV2orSFlDemplT1Y3cHptUCtpaTYzM0Fn?=
 =?utf-8?B?bmR0VEkxNzlOQ0ZwVVZUY0ZQNEF0NVZrTzAxcGxuZ0NLZ1VaMGozRU9TYXk4?=
 =?utf-8?Q?6GYVGjZUv0vXK7nFthsgj3zuCVcs3TPJ8xnKacIdQpUxp?=
X-MS-Exchange-AntiSpam-MessageData-1:
	yjw1gfEy5aqWOiP1aBQIbMTXRvazTT0n6bAu3i/X0DI1BAVt70AW2Yn4
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ab1e16-8a45-4c50-45f8-08dec0cf5713
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 17:49:48.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoQ5QCrAUMqvdQZO9Fu+LsGtfxriPJanoQyUfl3HBhiNVV7xWZvU/YJwA89l7W49KgWKlAUNBY+aUTaCyxlQRpj2hM6rJZeZeMAPLRu20vXrIqwsSYAjCxAPCSCWhCOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294320-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:pabeni@redhat.com,m:admiyo@os.amperecomputing.com,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sudeep.holla@arm.com,m:Jonathan.Cameron@huawei.com,m:lihuisong@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amperemail.onmicrosoft.com:from_mime,amperemail.onmicrosoft.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A32C630E03


On 6/2/26 00:42, Jeremy Kerr wrote:
> Hi Adam,
>
>>> The LE condition makes sense, as the driver does not support BE. But
>>> what is requiring 64-bit?
>> The code itself will not, as written, work on a 32 Bit system, as there
>> are 64 bit specific code.
> Yeah, that was more my question - what is 64-bit specific about the
> code?

I'd really have to dig, as this decision was mixed in with the earlier 
endinaness conversions.  I suspect, that it was origianally triggered by 
the ACPICA insisting on Machine architecture for these values, where 
they are supposed to be explicitly 32, 64 bit etc.

I can dig a bit more if your feel it really important to support, but I 
think the intersection of ARM32 and MCTP over PCC will remain an empty set.

It might be perfectly safe, but I have no way to test. Treat it as a 
general trend toward not supporting newer technology on older architectures.




>
>>> The comment is:
>>>
>>>     Implementation of MCTP over PCC DMTF Specification DSP0256
>>>
>>> But DSP0256 is not the "MCTP over PCC" transport binding spec. Either
>>> mention the host interface specifically, or use the correct number for
>>> the PCC spec. I think the latter would be best, as the host interface
>>> spec seems less relevant here.
>> Yeah, just going to drop that line as it is redundant with other info in
>> the header.
> OK.
>
>>>>>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>>>>>> +{
>>>>>> +       struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>>>>>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>>>>>> +       struct mctp_pcc_mailbox *inbox;
>>>>>> +       struct mctp_skb_cb *cb;
>>>>>> +       struct sk_buff *skb;
>>>>>> +       int size;
>>>>>> +
>>>>>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>>>>>> +       inbox = &mctp_pcc_ndev->inbox;
>>>>>> +       memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>>>>> [High]
>>>>> Can this dereference a NULL shmem during teardown?
>>>>>
>>>>> Looking at pcc_mbox_free_channel() in drivers/mailbox/pcc.c, the
>>>>> channel's shmem is iounmapped (and the pointer cleared) before the
>>>>> shutdown path runs free_irq(). Until free_irq() returns, an inbound
>>>>> doorbell on another CPU can still fire pcc_mbox_irq, which calls
>>>>> mbox_chan_received_data(), which calls chan->cl->rx_callback (cl is
>>>>> still set at that moment) — landing here.
>>>>>
>>>>> Existing PCC clients such as drivers/acpi/acpi_pcc.c::pcc_rx_callback
>>>>> do not touch shmem from their callback, so this driver appears to be
>>>>> the first one to expose this ordering.
>>>>>
>>>>> Should the rx_callback bail out when inbox->chan->shmem is NULL, or
>>>>> should the ordering in pcc_mbox_free_channel() (free_irq before
>>>>> iounmap) be addressed in the mailbox layer first?
>>>> That needs to be fixed in the PCC layer, and is submitted in a different
>>>> patch.  When that patch is accepted, this issue will be fixed.  I do not
>>>> want to hold up this driver for that issue.
>>> Understood that there's a fix in development for this, but we can't
>>> introduce a potential null pointer dereference in the interim.
>>>
>>> If you want this merged before the fix, how about a guard for a valid
>>> shmem pointer?
>> The mutux used to control access to the create-teardown path is static
>> to drivers/mailbox/mailbox.c
> You can't acquire that mutex here anyway, you're in atomic context.
Right.  And this would also prevent me from implementing any other mutex.
>
>> I could run mincore
> No, that wouldn't work (and would be moderately horrific)
I am glad we agree on that point.
>
> Since you did not answer the guard question,

Sorry, I thought I had.  I have to admit that I misunderstood what you 
meant by "a guard for a valid shmem pointer?"

> are you implying that the
> shmem pointer may be unstable *during* the rx_complete call? (ie.,
> rather than being invalidated before the call, and so a simple `if
> (chan->shmem)` guard would not suffice?)
>
> The Sashiko review seems to be incorrect in that you are not the first
> user of the shmem data; there are other uses of chan->shmem that do not
> seem to have any intrinsic exclusion between the rx callback and the
> free_channel() paths, nor check the validity of shmem in their rx
> callback.
>
> However, the closest existing use - the xgene i2c driver - seems like it
> can not free the pcc mailbox while a rx irq might occur, with the i2c
> locking in place. You could do something similar here, possibly via a
> spinlock acquired in both the ndo_stop handler, and the rx callback.
Could I safely acquire a spinlock in the rx_ callback during interupt 
context? I thought that had a significant impact on the system.
>
> But if your proposed change to the iounmap() ordering works, that would
> be a neater solution here.

I think it is the right solution.


>
>> The patch that this gates on is:
>>
>> https://lore.kernel.org/lkml/20260522205220.237355-1-admiyo@os.amperecomputing.com/
>>
>> Please comment on that one to move it along.
> As you can probably tell, the pcc mailbox interface is definitely not my
> area of expertise.

It really is the area of expertise of  very few people.  That is one of 
the reason that this patch has taken so long: I have had to learn by 
trial and error.    After the initial work to get the shmem managment 
into the PCC layer, I have tried to avoid changing it, since there are a 
lot of erlier, type 2 drivers that don't seem to get a lot of attention, 
and yet we don't want to risk breaking them.

I thought we were done with PCC  until the Codex based code reviews 
exposed a few issues in the PCC layer. the biggest is the one we discuss 
here, but there is another that I think I need to address as well:  
setting up the interface (specifically calculateing MTU) requires 
opening the channel.  While I know this is safe oin my system (the 
remote side never initiates conversations) it might not be true of all 
senders.  But opening a channel is an indicator to the remote side that 
you are ready to receive.

Thus I have another PCC level patch that I will send on my next 
resubmission that creats a query-only interface.  That, too will require 
an additional change to the MCTP-PCC driver, but one that makes it more  
futureproof.

Looks like this is turning back into a patch series.


>
> Cheers,
>
>
> Jeremy

