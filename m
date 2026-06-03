Return-Path: <netdev+bounces-294861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hLOqMWxnIGpj2wAAu9opvQ
	(envelope-from <netdev+bounces-294861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:42:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937463A3A6
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:42:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gf1Q+RRR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294861-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294861-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92CC2302F1AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743F9438FFE;
	Wed,  3 Jun 2026 17:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C93E9C26
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:41:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508478; cv=fail; b=eaKR/ZKftTUAXfcnNJ0FSqSaZgVEWyjw8DePyNFYbwdSjuUAlkFdyFsgcfA7P+2NV/E0aqgQLd14Y+n0XbEYnicCO4oZO+Nt6Bp4g798Tqg8HILbCtgT4Q6EJrGlbR/52ec8aL0NZllGBdw7ekFMj4Clnb9+aYHk/+6l+Uz7RUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508478; c=relaxed/simple;
	bh=tTB05Qfexcmw+USRrBTij/HaKFVKyYgX381cOpuYyUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iZF2KTJK5qG82Z3r49ps34JDhmXjetSJ832Ko1MljpuVf9mPVFnSHXDNxkG3TNDfh3BdHeWy4tYpwlnZBYeQKwY+GlHOGHM8LSMS2NcGnCegJBRYn5qspSv+/FF1xGJZiy7wAmP4Lhj3QEnktWjqSo24YrSL2ExMvLqn3K5IQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gf1Q+RRR; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSzWaEt0LhhyuaZSH5gb3xdJt/DS1G5Cq+aYlhf+ZZg1Gw1pGCJmHhfHpUBZwmYPHG9mCaDMXeXBVPddSZIeUzTBzBfNFcMfXk0ONq4m6RpNwBLnkZX2x3oGMCagevOQBuZrOMrIuFPYBT0VXMXHirdwnnf7I5tKWo67pS+Aez8xk9+h+c5BmuTBJ8RqJ4wMcyzI9kd5OJelkBJnfz2Op9oDAj1vhI56y5q+q1tFx9H3lkMbzMdjwE8DEXyNgztKEEBaORvNOuWVaFOq7QiFH819sU6CMbMIaS22xM4j53XC67bmcynMv9ZQmVFj+zlXgpJIBPkgeYRDQzCWxPQV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1/d3g+d9xzyu9Il0NWN4NEjElm9Jy6unTTlxwXZmu0=;
 b=KC9T4XMSaay3MAvRHIW3uHg35WyoB2zFl+dkz6o5kTk1ftCwDZX8dmEB9fXPdknGPihHUK92ZWzPGgbteqiXY5r8y83XJGvimuSNW4iEPq3H2xKctQvbTUTv3m9Kg4oL7bxG8+4KeK4S2hoVdJPOIqUxUEwCcmHIooZt7PD/I0mAo008qzdZLKYPAfy9zhqzdhP5vw4x9Lccbws4J2Kqu+DHlHnWVM4GxZgPnZZDKdhaUToKXZOOs+QXALN9JzSrR3S7awAjKQd7PY7ZHIYoAkmVZ6r70Tjklu7oLghuLNE+YZqqEi1F2DTHWWzemTR2wEUY9ICViRyH1RaRtG4crw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1/d3g+d9xzyu9Il0NWN4NEjElm9Jy6unTTlxwXZmu0=;
 b=gf1Q+RRRHwYD4bQRWLw42kXv5+2ow5sHqYpdYBIlkUEsok/Eo2qnUUqlrkJ9aZePnnIiMiikdoO1JRu5mC7Kumo//7WL/bEDhXnrTEwkHGK+FCCdWqmtPcYRM/mdjfEMgvlI3XD4aCOkMW3csGBzR+R39VnnGSoJLfUyyZoPC49Oj8/5xebJsETiQNtpWSzN4Jqh69nkTszA32beiSMqDx8/8193Bwlni2RA2B6WoLavWa4N3f3VLiJZSGscMy4m/nDsD8byFq/CekaQJjFYA1XdHhM7qeXAgujVo+HDCxp9lAaUwdipbou6j0GDJ65BQProbZOTFK4V7iP0DSPJSQ==
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 17:41:12 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 17:41:12 +0000
Message-ID: <ae5396bb-2305-441e-ac5a-d53a20e150aa@nvidia.com>
Date: Wed, 3 Jun 2026 20:41:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] iplink: bridge: add stp_mode support
Content-Language: en-US, bg
To: Andy Roulin <aroulin@nvidia.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, petrm@nvidia.com, danieller@nvidia.com, dsahern@kernel.org
References: <20260603173304.564055-1-aroulin@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20260603173304.564055-1-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f159be5-26d2-4337-0dc8-08dec1974d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PKBPTuhboIic7Dao9MAMflj+1LtNieV3zwxpM5Z0otVaPbbPFEFLRFVB4OTlTxv9UEdwF4me11wZ+hd+qKxkUHVR3+Fiji2i1CNOkf4QjWVuOw9AOQOgsKgf0xXe9MTt0JtNZw2YSS3+AQ/imQ8QNqJsSiZOMUQvG2Kv1/mJfAiHuHJTbWeS5+onO+txYjast7WZOm7q/qdd/YUzw4Ms15o0DQh3nhhBfyD8GWxbj5JyJ7jolVebnBdnjPfps8aBdLd5r+pGeGMziD2Wi5qeY6pzwZP72tQ+cE+7gzCAMt+M9wY45z0HADxjEj/R8Zc8yQw6s7sF0gmnJvKnzSP8bBsHo+7QRfv/bQm3cLjeLxPHtxyaanrNJ7cqtaP1JSl/GSkL85C5Q0YFZPuf402LodlDdA1wKH1rk6J9mrL6S7RPjkduVP0Z3OHi//4nYUgFncxnRWyC3NlT1pBiaKay6hG+aX3kvd+B4Fb14lhJgBmRto1ijbR02fQZSTofGZXVf7ZZQCrt5NqBBzZYMeQ5zap6O1C+4UUbewF8rYwkxa2ZXOCvATsmeXmycdQQMVNd9fVbeV0rgPK3XclR+0JOnagOoZPT8yMfMZ6b0Dkqxpwe4VNKDf5z311bUDJORo6w6JSzviL19OWWr8aY+7SSBqDbsaDknCNmnUHXZVUf5AWqJDgbBGGEL7sPbbSkLBZpxJ+VVNw+c6KpjitslQRY4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGQ2THFIT3crYmszcHVhS05QQTh6am9QMm9TQUdhN2ttbkhEbXRlMU5mR2NY?=
 =?utf-8?B?cDZ2SG5CVFRHWXEyKzk5eVd4UjZaTVhrQzRKS2daSGU1WHVYdFhYZWJ4WXJB?=
 =?utf-8?B?SElUVkpqNVNSZnVuLy90MmpJaGdvc0ZTV2hKb1hzMzgzTkFmakRLMVhLYUF3?=
 =?utf-8?B?YkVsekJVSUh6Ti9lTjF5QWlGWkZNbmF3ZXp5SklKbHBac3MvMGpvQ3lQeWpr?=
 =?utf-8?B?QXlFRFEvVFdPVm5tTWlhV3p3b0R3V3dqbDZFM0ZiNDlVUXoyUnVLS0RONzRk?=
 =?utf-8?B?U1RzQTNQQnRnME9mNDJUbWkwYjBrb2lPZU9QM0hPcXFCZzNYdWlFc1NPdnNr?=
 =?utf-8?B?TkE0TGlKdUUyMHh5MEluenRncWVpaXpJMU5QVG1sR3Qwb01MZ3U3MWViSmJV?=
 =?utf-8?B?Ym1LU09tNHdrMG5NQWx6Y3VzZnJJcDdJLzVxdXd4MkZxMzJaZU1JTTkvdXBL?=
 =?utf-8?B?MUpnYVdIbFJ5anlpdHpWcUxOSGk0aHQ5cE1iZGhhazBCNnJ4Y1pNeWZTdnUv?=
 =?utf-8?B?Rlc2Z2QwSWtKU3FmQy8ra0l4MnIwK3BuRGQ2TWNSSS9PS245R2NDK1R5bSt5?=
 =?utf-8?B?blYrRmxvdXhncHQrU3J4YWRCcUt4SkNUNVVlajRON0xoRCtYZWxLbEhYZ1ZC?=
 =?utf-8?B?NGljc3l2d0l5KzMzcTFBVXgxRUMxRFg4Qzdqd05DVjJyMTBYTHRUZ3hORWJY?=
 =?utf-8?B?bTBRQTBVS3I1dVFFaWhaWlJIaE41SmZvaDNOSEtpMVN1S01meExCRmtWRFkv?=
 =?utf-8?B?cHJLVjhMb3plQkhOQmEyVkZnbmE1UDJPVm8rMUNSOVBuTUlkaXBXaHgvZkxu?=
 =?utf-8?B?YU8wc2FzaUxzdk9Lem9mSFY5QlVMbzg5MDg5bk80SGNTc0Rwd2ZVazRxblVN?=
 =?utf-8?B?b3RFNkZXVTB5djFKRGtLb2FrNFFZWHdWL3VmQXpCR0dqQkNkMnRuZ0lUZU9G?=
 =?utf-8?B?WWQwQUs3NHJzSlJRVzlIR2lScTlxVk9WeW9yeDNoSjdJL3d5QmxvK0Y3RmM5?=
 =?utf-8?B?a2tORHZXeThzbW1iS2hCTjdnYkNhMzFHQkQybi9taE5yR0NqRUxTYjdnTFph?=
 =?utf-8?B?elhhS241eFdsNUk2MUJyMXlUVjZlUS8wdjYzbUpha1NwZ0F6WDBnZmxiektz?=
 =?utf-8?B?MTQ5QlBNRlJXbCtMM2Mydk5RMzZJSFVjZmhscVg3WnRaOHd0NDI5c3hUNmpF?=
 =?utf-8?B?ZFFPQ0tXOXZEVXpleHo2d21DcEczUHg4TmFhTk93bHpvK1I5WkNjK3ZTdnlV?=
 =?utf-8?B?TEREbWx6YnV2aFdrb0dJVm5MQ3hMMStVWEgwVDJiZ0FpNWFZdGt5VjF4V0ZE?=
 =?utf-8?B?OEU5Snlmdk5ZSG41STgvNFgzWG9HME1IRXZ5dHFJbzZ3M0gzd2l6R2R5K1Ji?=
 =?utf-8?B?czJBU0k2YzNZUmVYZmRiNmpUY0M4cGF4NnExejR3QUJUR0IxWUJFc1RVcU5R?=
 =?utf-8?B?QldmZ3hrTmZleVQzS01LWlVCT1ZVVHdxdDR1TVVWV1hYQUtSOWhod2I1R0JT?=
 =?utf-8?B?SGtBR1g1RmxleitPQjR4N255R0FVTzl0WEtmdy9HYSttQVVTWHRKTWJBSWRx?=
 =?utf-8?B?b0dNcUQzZ2pPa2pXdlR3UEZQL0pqRU4rRG8rV0hIZkFXSUVvV3FabUxrUk5H?=
 =?utf-8?B?WGFMWmRQaEpISmx5bzk3bWxDYUsza29pTGRYaThxS1FIejJRQzJGVzdqaVBr?=
 =?utf-8?B?TFczejhCZGh2Qjk5c0t3OVRIQ3RwWXQ1a1crMWtvNlY5US94eUdkOWFGZzRk?=
 =?utf-8?B?TE9yajN2NDkrdkhpYmpVbkdOR3JqVms1akdNM2RmWlV3ZWhvQi8vaXUxMXdM?=
 =?utf-8?B?NU9PUW4rS2RwVEREbmRVK25JZUxQNEx1OXowL3JLNzUyUkVVaHRzUGFCNUFw?=
 =?utf-8?B?MzJuUzVaOTZFU3I5NFlzN2lQaDAzT2NlblMwOTZjTnFac3lHQ0ltOHZockFn?=
 =?utf-8?B?RTg1WXlvdkdwckZXRUxPaEdYVEYwNWZhVmJ2WVRCemdUczFNQ2JQNmZqMEpC?=
 =?utf-8?B?cWt3QTVTSjBPZFg3OUlJNnl0aEJYZEh5UktMN3hsc2lWZVJaSGtEZWZvaGJF?=
 =?utf-8?B?eG1oRHdrZjFwdkFDZE1GbzAxRHNJd1hYbHgwVDVrTUo3SUJLNWVUSGVLaWZ0?=
 =?utf-8?B?MERzVENXU3BVaERqWlNrUng3UmVMUXlSQkxRb3Y3bzF1dHpmb2tOUThrNTB4?=
 =?utf-8?B?WkhXV3NQSU1nYUdURUhjS0gvWTdCUVlkMWk1QXVzOW5HQ0ljZVdhM1NJOHFZ?=
 =?utf-8?B?K3c1dXpvR2xoemNSUGpLQWdLWGk4ZW9PM1NTV3NyOFRtM0hkdVNMZDJwMjRX?=
 =?utf-8?B?V0RvWHVVVWdONHlFWEIySExtRXVKWjNlbzJrT3l2aTB0WlRGcWZZZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f159be5-26d2-4337-0dc8-08dec1974d97
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:41:12.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwDSJQ3rK/hkGe4t+76CG7BTQwPB1lhwG2ypp6868jdrGeQplJSoN04JtAdfjLEmbtRB/kHq39iIkT7pyj0Bxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294861-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aroulin@nvidia.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:idosch@nvidia.com,m:petrm@nvidia.com,m:danieller@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6937463A3A6

On 03/06/2026 20:33, Andy Roulin wrote:
> Add support for the IFLA_BR_STP_MODE bridge attribute that allows
> userspace to explicitly select the STP mode:
> 
>    - auto (0): default, try /sbin/bridge-stp helper in init_net
>    - user (1): directly enable userspace STP without the helper,
>      works in any network namespace
>    - kernel (2): directly enable kernel STP without the helper
> 
> A shared file-scope stp_modes[] table indexed by BR_STP_MODE_* drives
> both directions: parsing uses parse_one_of(), printing goes through a
> stp_mode_to_str() helper that returns "(unknown)" for modes not yet
> known to iproute2, keeping the JSON type of stp_mode consistently a
> string.
> 
> Example usage:
>    ip link set br0 type bridge stp_mode user
>    ip link set br0 type bridge stp_state 1
> 
> Link: https://lore.kernel.org/netdev/20260405205224.3163000-1-aroulin@nvidia.com/
> Assisted-by: Claude:claude-opus-4-7
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Andy Roulin <aroulin@nvidia.com>
> ---
> 
> Notes:
>      v2:
>              * Use a single file-scope stp_modes[] table indexed by
>                BR_STP_MODE_* for both parse and show, instead of an ad-hoc
>                strcmp ladder in parse and a separate local table in show
>                (David Ahern).
>              * Switch parsing to the shared parse_one_of() helper. Drop the
>                fallback that accepted numeric values on the parse side.
>              * Print path always returns a string: keep the JSON type of
>                stp_mode stable and fall back to "(unknown)" for unrecognized
>                values via a stp_mode_to_str() helper matching the style of
>                validate_to_str() in ip/ipmacsec.c (Ido Schimmel).
>      
>      v1: https://lore.kernel.org/netdev/20260518163647.1935156-1-aroulin@nvidia.com/
> 
>   ip/iplink_bridge.c    | 33 +++++++++++++++++++++++++++++++++
>   man/man8/ip-link.8.in | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>


