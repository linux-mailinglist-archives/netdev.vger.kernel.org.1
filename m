Return-Path: <netdev+bounces-297587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wmTiDYw3KWoSSgMAu9opvQ
	(envelope-from <netdev+bounces-297587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F300668211
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:08:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=prodrive-technologies.com header.s=selector1 header.b=n6XW2HyW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297587-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297587-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=prodrive-technologies.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3135C3223B58
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB23E5EE7;
	Wed, 10 Jun 2026 10:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023095.outbound.protection.outlook.com [52.101.72.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C813DF001;
	Wed, 10 Jun 2026 10:00:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085633; cv=fail; b=WBPMERpzaS83GqYo21zkszg3ffVAS0oPAwOHY7QD4d1a0FNxN2acihvNT7NVLgvH/FfY4An7q+ZP2fLgZx8tB8llcEoU7YPfmHQVxn9MapJ7m37I4O2H4K1f1sJDI8P8dPTLKY7TjFzOYSR0kh7QGtgLJocuvJctXYhcxiRZkSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085633; c=relaxed/simple;
	bh=9knk71CME3Ttq8GA4PhSbLqcnMWIi37Qmm+ZR7scN0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhHQU7bU16FYzbwem8Iw1zq6SwLccSqiK2MB0pkkhL1LofLV6BFMvmkVhvxD9ovVDqwCQ4wUO9KwvnWwZoBbeeo3BXvLa6Dy5umY6ag/U296A3Uosee0UNhtLpqpaNrWndiJkh9u3W+KaTaTbObli9cTNsXYqJV2+4rxyzm9HZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=n6XW2HyW; arc=fail smtp.client-ip=52.101.72.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPx4KnFndL2O0rWVI0jPqRXVn9qPzi4YFjH0wyJlkiDAogEoYX9aWV8Pq92sLwcq1ZgVDvlANHr/9+LhyKq8UNY+Au7SNk+fcsvJfP44HOeQYicD88JbqHJhbjDMhnqixM89CZOIpE8SJ0PclTaDAsoObr2WFeu63m2WeP7Jdd/iHLtXwDRcWuSSEbS5MUms/HFbzpGyzaJnY8eIJFgbSaHiV5Ja96Q481KpkKiTMWEzwelHMWAHg1WIfnEe3+grCb9mXAV5JFw2tdZeasq2Dy5rgl4HaEOsplRKPQCE1I+DD9lignQZUA73Wil2bj4bRz0jE8Iewy4+1M1MyrpOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jc0zAMG8iypEfEWAnohQYXtmHAXBEGZQfW9Gan2e7w=;
 b=Hr744Uqe/Z5EkHLWzDUWqufSZY5rkndZC2XmQH7aKzcv2BGaFV1dUUxLo4eBXRAWmA2xWWuvrqYphKILk1aHRAXcmuRkxiWWNPWUesn+OTBhHpdABdBtcvs+6ik3UZa6rpG1HI7Yi5nVOrEY6n5xZKgS6ystKqGpZXOfIM/2UeYcF/8KefYVou+gXUiVHlcso8AwfpEoDESeIn4N5MNjBgtgIyu+WcC2hukziRdMhjJqXZskb0NkuurMu8TUSNox6ECly1WoJaq3xRroUPm2M4Qd4Zgl3uwzdo+Z4YhRnp4wmm3CdUrUfIaM8dLNyZEPgv1Az4WWxDyIJMNwIncK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jc0zAMG8iypEfEWAnohQYXtmHAXBEGZQfW9Gan2e7w=;
 b=n6XW2HyWjcJU5FIHwoNlYd3PbDhUQjxDNq29ZktYg2woJNlbHi85QEj3hKKFrr4SU70K4rsBoPVJC5jZiBqkcLNdRqhRUsBceFD8cbTJvmoy2XHLmZdR25XofFXJSfnF4GZ0CPciZk5o4l/7gaBvApeP9D4X+xsUqhzxgPmIil4=
Received: from AS8PR02MB7803.eurprd02.prod.outlook.com (2603:10a6:20b:443::8)
 by PA4PR02MB6910.eurprd02.prod.outlook.com (2603:10a6:102:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:00:26 +0000
Received: from AS8PR02MB7803.eurprd02.prod.outlook.com
 ([fe80::1138:fa17:c571:8a4d]) by AS8PR02MB7803.eurprd02.prod.outlook.com
 ([fe80::1138:fa17:c571:8a4d%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 10:00:26 +0000
Message-ID: <58a4f1fb-3bae-4d47-9617-d22e3d7e0ef2@prodrive-technologies.com>
Date: Wed, 10 Jun 2026 12:00:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: sja1105: Add rev-rmii support sja1110 devices
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260608141654.2003932-1-martijn.de.gouw@prodrive-technologies.com>
 <20260609185915.7aa34d8e@kernel.org>
Content-Language: en-US
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
In-Reply-To: <20260609185915.7aa34d8e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0200.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::11) To AS8PR02MB7803.eurprd02.prod.outlook.com
 (2603:10a6:20b:443::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7803:EE_|PA4PR02MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 875792de-677d-4b48-3e0b-08dec6d71849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+ISrTyGTA2vGjEqFGc8uoBRIIYeY5PGffp94rrjHTF3f8+NStamagXBuNcv+xZnYE9AHDDV8puclJvHKSIv6kOOUu6+VfIsaQ+HMp2G57s7+IoGmOO3TWhsE++vQ/blNNZEdScrHbRL/ydssXZ25tTV4OScSn00ulTg4I747sVpq9xcKPldpXIzZBENdts/spMvJ0ZdagZ9IkzXYQdjEh+Yih4BQ0liyCCgLlmHZ/ZRm4sg7FR929mGbxdhr+i0CExk/YOCWD4FYheQ2LQxq5Omdlcc/Bp3pQUWrWLzfS7Sedf/jqN+9vThOwqdaLf4FC3xQKNVmlaUcFWjRW2c9WeGcf4BynGwQeRfBH/shuXtWeG+pzZvn5LlSda5UwWAS0xKxn5jI5OevzDIVAX/wpoP9iYMw3OgLCW/UCqz/yCAI+0b9OESdyk1bt6f0PK9CgSYtl/AmOry5UEDz6qZhjR20Cw3DNCkJn9Yo1lKSbCWTrNqyHZt+9ouRAiDhhIeBfxNeO2LncIFIpmO326/gqqEh5JRHHZM5Q65jssYWpjNtiWFtwt8jPx4/aJ5koC+oKE0uLAHovnAzIdh6SON3sPDLK/L/s5c/mdfaOSjtKsrlxsc5/qBoDtq2sxSyhwPHCDfj1BOLe85Jwv8PmcGAKSoX8h+68wISdWjFnKwjFKmTpqf/RGEv//Q1rg55Tl2K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7803.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1JKV2NkSGdjV1J1aTlTSlJlUkFrN3VBZ0FTVkpPblBCSGF3ZGdTMzErcFBK?=
 =?utf-8?B?VDdWTU9VN2J1dDZFdkV0Ry9Nb0ozSDBrdmhZRUttdFFLemdwQkppTEl0TmFl?=
 =?utf-8?B?QmdFcVF6a3pKOUw0c3AxT3RZTkpuNEVsMEdVYzNtUjdrTUVZVkZGbXVQbTI5?=
 =?utf-8?B?clRjbERDN1Q1YjVUUHlpUWtYeGRCZGlsU0M5anBoajBtdXFFVlNrNVY5U3dh?=
 =?utf-8?B?VUhhYTFlMzFGcEJOUk9FeDlMVU1DeVVPSUdjN2JUS3N6eW1LODJtQjYvS2xP?=
 =?utf-8?B?aThLRjZXRm1qY3A1dFhrdWFvRkxIUG00OGU4NmpiQ3BhSmZCVWxVM0l1WFd5?=
 =?utf-8?B?K09lUFBTdDYvTGtKODhhN2tLSXJuK01GaTNsY2I5b2VwVlJYMnA4RnZ5UEo0?=
 =?utf-8?B?NmsyWkxYMUZneXJrUU9kR1RVeVRhNjRVMFZuZkNVRHJHdjdwbkFrOTdnZkxp?=
 =?utf-8?B?a0ZwNzZxcEgwNjYrNm1hczhWVUp1eGpMOEE4QWNOVnNlVW1mMVVqR0lFUnNK?=
 =?utf-8?B?UnhqcUZUSTMvQnFGblpONmxnRnVySVlSMGJzbnJIZ0NXMklCdzZkcVJwLzdX?=
 =?utf-8?B?cHlGZkdFd1U0UE84WDZjSGc4R2JuMTMrVHp0VkxPUWU1OWJYSFdlNDhWYk5q?=
 =?utf-8?B?cXZ4bUtRTE9LM0cwVFpLbWVXRW5IZ21EVnNnZ29SNzBjWnh2V1F6QTNOWnBi?=
 =?utf-8?B?MkdLSmFkSGl0Z1BHUVpVcUtDOE1UN1AyQXMxQVN1VkkvSnYyRTcrdGNVTnJa?=
 =?utf-8?B?Ty9MQXNrdm9FcHNUczExV2t6MTJiZTd1MVl2VXFheGpjN2I3U0M4cEpsdFRw?=
 =?utf-8?B?YVpCT2NwYXFsS3JZUU5VSURhNXdxRkY3alR4d2VzdDBhUDFZcXUraVlvSkRi?=
 =?utf-8?B?U0U0RzA1aU9tcGk5U0pMVlJ2UGVGR3NSbW1KbmpDY3d5KzVrU1dYdDd2SWFj?=
 =?utf-8?B?UGF1Ulh3cFdYZG9EQWd1MU9YQVZ2QTg4d3VKOTlGK1hvaUlnUjB4QVIyMS9J?=
 =?utf-8?B?QzN4bFo4d0pVOVRjN0k0QTFUaXEwQksyR1lHdzdEcmkwTTBFaEt5b2xWSlBi?=
 =?utf-8?B?N1A1clJWK0RBWjZXQmZZOWhZVnpYTDZoSWl4T2luTzNPcnlkUUpZYVBqNGZv?=
 =?utf-8?B?a1lTS25PeGUyVCtjWFpMaSt0Q24rSk5HKzlRRjV4RjlYTmJSMVJJbkw4SEt1?=
 =?utf-8?B?Q3hjVk92YlIrb0laZjZJV0FVUDJrOS9FTFN4bnB0cmY0ZEtpRFI0K3hSUGh6?=
 =?utf-8?B?emRrc3o2amphS0VtUWJrem9pN0pnL0hxL1RaZWxnM3lKakNPY1l1bEdPWjBq?=
 =?utf-8?B?L3FhcjBlaVovNm1JWjJLTFVLaEFnN1lraHZOc0pGWmY0cVppT3FtcUNDbHR3?=
 =?utf-8?B?c1dDVEdmWHA4TzlrZjB6TTFGWTVNR25lMWsrRkJWR2sxdExKVHViTVdteG1k?=
 =?utf-8?B?VVo2eGp4WlZYWVBLdUZKaTZlUDRKcUd1Y2lNdDZGWVRxdS9MaVlVczcrU01t?=
 =?utf-8?B?d3FsQks4MWRraHlxaGJIekw5SXdYaVlvMHVRNW8zYkV4bTI0L21LVjVNNzR5?=
 =?utf-8?B?R3QrYmpWVThpRzNCVG5GZEtrZ0ZjbW1NcE9CL0lsSjEvUEMwTDRGNmxGQ1pv?=
 =?utf-8?B?Uk8yMjd6TjNUQU5ZWEUrUzhxSVRieGFIb0R6aGFOV2ovTmNLUkVYYm1JaGFT?=
 =?utf-8?B?ZTMxM3lEOVptNWIzYzBBSTkxWHlaUFVTM240ZDIyQmhFY0N2Z0h0MGsxK29E?=
 =?utf-8?B?cmtOaXFsRjU4VDlPbjVBdDJCT0I0Y0pxNWxpS0hsVU8xRkVlRjVwSG1nTGJD?=
 =?utf-8?B?QmFVK0oxY1Vyc1I5b25GZ1M3ek51Rnc5M0gyRG9Id2phUUhCV3lSSjUvaE1E?=
 =?utf-8?B?OXZQd0hlcy8wN0FkTytBaktxd1dhYnlERGlrRmJLWHBWeGhiYUo5WmtlY0VB?=
 =?utf-8?B?cEthbW9kRC9NZnZqY0VKVUNHdlF4VVpYTHNhSkd0aUNkcWVML1czcWdJemx2?=
 =?utf-8?B?anlYbVlBSTNHZ2pienl6SjE1dmU0R25JdDdNMjM5MnZWc2lHNkdNQThvemJk?=
 =?utf-8?B?YUxucmlFQThlbTJOSTBpVEZDemxSMkVudmxpcFdydWJjbTVXcXR6SDE0V09E?=
 =?utf-8?B?aHRhMFp0ZGxEaXpqNmZaQWV5MEtSMXRuY2JSR0hzLzhXdXZxWjNkSEdRK2lo?=
 =?utf-8?B?T096WStUdzhDb3V5aXpRaTd0NlBRMUQ3NXZjR1B4MzlzNEpXNXV1UWJpTGp0?=
 =?utf-8?B?cDU0MGo3K3VYZ1NWVkQ3MmhwZkJYcktoWTZIc09YQ1RacE5UMU5MYnJPWEc2?=
 =?utf-8?B?OFM0Uzl5RDdJQ1V1cFdQdnZTWkMxNUZKaWEzMXZINjRwQThVSnRxSVd0dzNU?=
 =?utf-8?Q?e/3eTN41hpNwZg5iUvBDDmzXCWcOnyr55EbhYCP0G0wAF?=
X-MS-Exchange-AntiSpam-MessageData-1: KT68uMSUKbj2sA==
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875792de-677d-4b48-3e0b-08dec6d71849
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7803.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:00:26.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkqFevqqDWB/6ZkLwdu1EGoLEhJMjqARshKdvWwJOi7dJwaN2aCP9PRq+InEqBsczWsdTo49ibC8GXijvAvtRvP2oHQUuNTCVtE4cvc0YSUlo3MzeC0bvQ8qWXgXOtlX9Jpy3d+eEHuGmktLzRXZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[prodrive-technologies.com,reject];
	R_DKIM_ALLOW(-0.20)[prodrive-technologies.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297587-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[martijn.de.gouw@prodrive-technologies.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[prodrive-technologies.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martijn.de.gouw@prodrive-technologies.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,prodrive-technologies.com:dkim,prodrive-technologies.com:mid,prodrive-technologies.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F300668211

Hi

On 10/06/2026 03:59, Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 16:16:51 +0200 Martijn de Gouw wrote:
>> When a rmii port is used in phy-mode (rev-rmii), the ref_clk is an input on
>> the rx clk pin. Configure both the rx and tx clock source to use the
>> rx_clk as external clock source input.
> 
> drivers/net/dsa/sja1105/sja1105_clocking.c:969:5: warning: no previous prototype for function 'sja1110_clocking_setup_port' [-Wmissing-prototypes]
>    969 | int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
>        |     ^
> drivers/net/dsa/sja1105/sja1105_clocking.c:969:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    969 | int sja1110_clocking_setup_port(struct sja1105_private *priv, int port)
>        | ^
>        | static

Looking into why sja1105_clocking_setup_port is not declared static as 
well reveals that sja1105_clocking_setup_port is called directly from 
sja1105_set_port_speed() in sja1105_main.c as well. I think this should 
also be handled via the struct sja1105_info. If this port specific 
function is available via the info struct, there is also no longer a 
need to have a sja1105/sja1110 specific clocking_setup() function.

Unless there are additional comments I'll try to form a patch-series 
that implements this.

Regards, Martijn

