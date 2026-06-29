Return-Path: <netdev+bounces-302859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hKreA9oCQ2oBMgoAu9opvQ
	(envelope-from <netdev+bounces-302859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE76DF437
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Y50HioQc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302859-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302859-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2771D300A760
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735883CF1FB;
	Mon, 29 Jun 2026 23:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF253CF200
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:42:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776535; cv=fail; b=YobcvFkS3XW8TIjhRrV2WkGKRsnjC/m2AyGu6x7k1f/98G2iU8OIEAKg8naPlmQzbjIvbJjKp9KCadWezMXStAUa7Lpb/H/f0h4eheJZZ8tuVy9Xq0W5wyKArj57Z8HhWsUZSQ68x5BtnItFnsbrpaJsW3f71cvloqK/nRHqGrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776535; c=relaxed/simple;
	bh=He5B4d1OwPnRR6etzlN5EVKwFNNSPv/4oB/UayUHe7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrOq+ROMP2F+K6wHNfmSneMMolGC4BP1oWSf8XciQkLz75OD41P8yV41ZcgKtJNgJjd7Zg3tkgjINKDdRtiB5tVAqCHKjyUXCaWl/mabu7xbqqTbAcRDUZUV8X+bzUHHh+ATPcJK7ks/ZaKdq8rRyxwOCHQObWWKC1veAtDc3X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y50HioQc; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5Wfky96XYTesIqeJClCI77pO68ASajFw8aXQyoXcI2H8tTE4X1XEHoUAKCf0ZRmQfP4F/rsHEmRR93CwE5fX5mzVL7OFtYrN9q8E0BIo/aEeMo06PidoUKjTBQtkoSITWTzUIitGQ03NGV10i5V+RmbmHvqGhO5pnCvduBBf7mHFzqsCw1+wNLIAv1KUDogDpVChi3eJ0RATgp7VKlDITsx8PbrKMY3LteyPZPyalv9MdXD1tliheWMop85guU5XpUyCp9D5Y24MNADHioKW6FXZUSW5yaiGbb0oqfmxuSfnj2q2PXiTK0JjwsTypl7uW0TDdRkzLzjrPxjQobYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl2+Ie4bmLMfx2eehi+t2Y0cZYqZv+36Z2Z0yklFLJk=;
 b=PaV4/qoY4GbcIVupBpH7H7MWsSii53ExLFUayQkcDjiDxSB83qnN2wxolTSBZ39JbOF8slHGtQeg7GgEN+q2wi5SI6pesNe9KaYTWG3UBx4QJlCrGSe2M0caAFogbWzfXW8Z8sa9Vujm2yj0Hm0sl78BudTwdpngJoJOGsAD9EZROJp3lwdzhjeqk+mt+tGA9XFzt1U69WIBEvDcAQjhQzxM+Iz4Nliiw1Azo5CSe0kZ6hEWByeGlfFlUtjckoYACSkSt+dp8KbYorAI7pTXu9LwZbKeCJmXP6AnqnKeA0l6cmovKAEs39Q9WPFv3W1vMO1jOZvDXDi69GGuF6y4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl2+Ie4bmLMfx2eehi+t2Y0cZYqZv+36Z2Z0yklFLJk=;
 b=Y50HioQc5oHGKvjCxPChiSizlNItBR9GZJ7695oOlHjkuXf54XK345Q24EwwaKlmbaZM63vje6+Fsci7UAOe0te+mT/J9zA50CBfFV6Ni3Hz+uMaEcugYPQ4t89YxZekoU3qWkusLCBmOCZJTHr2JNN20n20XUP6KyPFaqAxORY=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:42:11 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 23:42:11 +0000
Message-ID: <0a91e9a4-fc99-4253-a98c-99b1f97a2f8e@amd.com>
Date: Mon, 29 Jun 2026 16:42:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] pds_core: fix use-after-free on workqueue
 during remove
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260629200358.2626129-1-nikhil.rao@amd.com>
 <20260629200358.2626129-3-nikhil.rao@amd.com>
 <CAEAWyHcS7bi-wPEMQ38U+BLrnSJevHm6eDYQBp4n7omvHRPgeA@mail.gmail.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <CAEAWyHcS7bi-wPEMQ38U+BLrnSJevHm6eDYQBp4n7omvHRPgeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: e92a65d8-34fe-45f8-9da8-08ded6380a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|4143699003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	if67SYjR6P9hisNf9d6ZQeVRnGbrXxywq/LU6JfqhJfQZDgqc3Goo0270ggxoP9Q1C6TFeV0D1lFn6csZ01m6ya3Ma4D6rC37BdYoShQepCV5ItOsUK592Cj7OnQydfRWqhicLTjZMRkwu1Obw3chLhGrZCIeniVJBXLuqyrbly3gtNSH1YZn90wStvviaOpLIUMLXze7lNR5thX38OWgEFuBvL4h1MkxbV5i78CBoVQ3cBEDzmbni3F+mKKTba+sfZABIIwEg9emUS4bm5MORulnJNl9AweWCqIRDr+MuhYu5WXKOjfJHxyBvMljOhwACh8duCY6fWhjhgE6kymi15mzfS9xY1zj7qeOybrX2T0CaDLnAA+kO2rZy/yE+oXHNCq5GjsMGk4JcGOLhkzIrEj0sv+OHoAWrl9vVQ04Z3JrccpvuzW3CnJBTg/iOwH6Hu8wV0zuUdSG/boVihDafzCYXURTJoblJSg21sWlHcrZLmKXliN6HiFOf+xmVKLv6HK2WLZ7WD+XmYBQ/b0HfMuk/lQDTCUO1ssa68EBzRvzolkk7WS6my5bl1eu8j53he34T4QbSiWBVyEyw9qkhKtGxNzls//KsWZV4Rm+M9TV4BGdX4zwz/zF8/f14xcf1tH50xoeqA+IwS5cLUWKTrlk8iQ8Y3da+BFTaLugBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(4143699003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFdRemR5eEhobFJDMXlqTDJlay9BK09WSWdEMFQwMEZTS2RlQ3luR1dMbTZO?=
 =?utf-8?B?N0N5Mm5EK2o1SGNIbUhDclYwcXp2c1M4NFdFWUpsdzlNdXM5Ky9vaWFmNzJW?=
 =?utf-8?B?WklHYlpqakNoVjdYeVM4UWJDa3RRUDFPb0VaQ1hIaUhYVGM2MG1lajlyZE1X?=
 =?utf-8?B?WnJYbUNhcnZCbHFzUzNuMGhoOGoyK3FVQktKdTN2RmRDT2puY1RrYTgrbVRN?=
 =?utf-8?B?NFVHMHFWb1ZvM2EwRzgzMkp6NmV3NEQyeXFjSXpjcVpLYWczRHR4NTdrdEdQ?=
 =?utf-8?B?OWtmT1hXY3IwL2lNMlljSFptWWo5NzVmUnIxNGVVcmJ1TDc0THp6ZHZLQ0ZP?=
 =?utf-8?B?Z1NaaThqcXJUZmo2OWFXSFlFeHFXbDJyWTdSdTQ4dDAvSnJxcWd2ZUYrNGR5?=
 =?utf-8?B?KzlyMFhKWElDVnNBdloyeEoxOGJHREpWQWZOcXZmTzVseHhEMyttSWs5QzJ4?=
 =?utf-8?B?VjRub29YaS9oM2tPTEJOVTY4UW9UMXdYZWdGSExuNHVIcURpZGZ1T09pcVFV?=
 =?utf-8?B?N3N2YnpFUG1SODRuOEhQUE1QemozdVhBRTVabnphNVZpdndKaTkycDRnL1pP?=
 =?utf-8?B?aU9LSHcwTW5kanNlRm5tZU9zZEdRdjVpVmFsRFlwVWJYdXlwelhvYkJia3RW?=
 =?utf-8?B?MTNEYXVxc1ZuVis2VisxZEIwaG1RQmJPOVBUcVJoMk5KUWkzaTY5ZWsvWlJB?=
 =?utf-8?B?ZUtmYTBjZGlick9aSzBLOUJQOHBKZ2syMWxaWnFuSkZoYU8yTVViY1hGYXhk?=
 =?utf-8?B?QkxKa1hpNE9NZFJlajJ4NHBZa3E0eXhLUXhYNXFlejdCTFpRaUpjYkhlYklt?=
 =?utf-8?B?NXdnWklHMHJMd2tTMFBFa3ZJOWNIUGVwQjU5a0h3ZVdjRFdKUE43Y3pQUlU3?=
 =?utf-8?B?Y3F4N1FLUThYMUM5RUpSSU5wYm1YeGF0bjlBVG0rVnd5V1AwTE13MGk2QW1x?=
 =?utf-8?B?Z3dnTGJYVmJqQzVzNFFQVlBGcEFtd2NyaGxUcjh6ZzFUV3ZnQjZQQlY0ellL?=
 =?utf-8?B?UDZva05ZdW9wbHNyWkIwakZEbUJ3aXp3ZFR6VER4b1IvY1hrU25VdjNiUE1K?=
 =?utf-8?B?OUFxdVFjbFJZZDdpMmtJeThZYkgxd21YSFBKN3FKbWxHTGVSNG9OU3NtaWNh?=
 =?utf-8?B?SzRDUkpKNytMbUc0cWhYamtVN3IyVkdVazY4bmRQditxZXNXU0x4VTY0VGhG?=
 =?utf-8?B?Mk4vTUo3bWJCdk9RWVlxYjZSakNudkxyR3h1SlBPYUp3MkZVdzZDTGRpQy9I?=
 =?utf-8?B?Z1ZDTzhCd2dXc05OcGxDaDd4L1lpU24xZ1JBSThXMTZHQVhhRS94MFJQY3Vh?=
 =?utf-8?B?NVBmVWxaa1NUVW4zTUEvdGxKbzZnREo5cVpVQzFTWTg4OEgrYm5hdFM0OGxn?=
 =?utf-8?B?U0s1TVNDSW9aekd5SGZQcHhzYldaTGZLWEhGYmhaa0lJelV0V3NobU1FakRP?=
 =?utf-8?B?cVorSm9acytTbERGNGQ0eGRLb1V0MXY4MlZBbEprbnB6cXZvZE9RNG52ZnRo?=
 =?utf-8?B?ZCs1a3YrUW1hSVEzUVdiSG1PUHRoRVNkbE5RLytnb0N0UnZETElYTncxcDlV?=
 =?utf-8?B?eG5JdEZBYjJQSDI0VlA4Z0MzR3hab2xpUWUzQnhmS1cxdzhQR1l6b0J6SDJB?=
 =?utf-8?B?b09rMFROVWdGSlBDRTI3ekVKUTNOT1JhTnFiOGdsdlpDVFhHNVJXbWhlVG5J?=
 =?utf-8?B?Mk5qMEFiUmtnOVFVbjNXZGMxNklxc3FyT1pHZE1OOVhGRklsL2dBNW5Rcmo4?=
 =?utf-8?B?V1pvLzRkdXAzL1lmdzRPbEhMeE1ncS83dVJVa0x1SU1vYXNCMWRLSkN5Wldm?=
 =?utf-8?B?VUVobzVUVmVHSFVsN0xqWGYzTlhycm1nSFp0NEdVVHprQjBKS1FydWpYSlFL?=
 =?utf-8?B?QlZLdGJFbzU5aEd0U2lodnlHaXZVWUxYNEJnT3AwVnNSa25FMGpyMVdIVzhv?=
 =?utf-8?B?bnVoYjdnVDdXQktEM2hLN1B2UU1uWWp2blQxMHBFY2ZpdktDbkIyZU16V1Fh?=
 =?utf-8?B?em1UNHVFRFFBa3F1N0IzTU50dDBLQTJUR0xBbmVpZ0w0Zm1FRGZJa3BJZ28w?=
 =?utf-8?B?L3FkVkdsT1JQT0U4VlBsUU4xSTJqc2VneGoxYkJpNTFrYjhFVkF4SGtwUlRJ?=
 =?utf-8?B?cFhQY01XT0NYZE9WRzZ2Yk1IR0VnQmZSYjc2L1VEVTFYczJ0WW5FYmFhakVk?=
 =?utf-8?B?T2J5U0dTRE9UUWlpaTRyOUUwakVacTR3ZE9OaU1rSG9QZ2lvR3pUMkpHbGFC?=
 =?utf-8?B?SUx0RnB3YUxKRExrUEg1WlZYYmF1dDBRd29UZXZ0U2EvOUswZ0RhQkdqTUJK?=
 =?utf-8?B?ZWhSOEIySVYvMUIyZ1ZpbEtZbmpZYTh6OGZablkxRzVSdWxNWEV3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92a65d8-34fe-45f8-9da8-08ded6380a08
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:42:10.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmzB5KfnCB9UU/BblgWM5g3KOrFmiWZRM1D7Na0WD/YvBMtYFoBkaj5TCStvLT+7sDOqWGrmUeBG15NCmoDUcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302859-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hramamurthy@google.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59FE76DF437

Hi,

On 6/29/2026 2:32 PM, Harshitha Ramamurthy wrote:
>
> On Mon, Jun 29, 2026 at 1:04 PM Nikhil P. Rao <nikhil.rao@amd.com> wrote:
>>
[..]
>> Also change pdsc_core_uninit() to free adminqcq before notifyqcq,
>> since adminqcq's work accesses notifyqcq via pdsc_process_notifyq().
>> This ensures notifyqcq remains valid while adminqcq's work drains.
> 
> Code LGTM but wonder if this change could be split into a separate patch.

Thanks for the review.

The previous code had the bug this patch fixes: destroy_workqueue() was 
called before pdsc_teardown(), so work could be queued to a destroyed 
workqueue.

This patch fixes it by moving destroy_workqueue() after pdsc_teardown(), 
now adminqcq's work accesses notifyqcq, hence the change in order of 
freeing is tied to the fix.

Nikhil

