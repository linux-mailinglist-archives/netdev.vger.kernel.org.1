Return-Path: <netdev+bounces-299117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C2+PNCkFLmovogQAu9opvQ
	(envelope-from <netdev+bounces-299117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:34:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1B6802E3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:34:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Q8E2cNSf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299117-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299117-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5705D3011584
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAC1CAA78;
	Sun, 14 Jun 2026 01:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42D2C187
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 01:34:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781400870; cv=fail; b=SL0LOLTtIgFy9MTril3bsxkqyR6AFZMiqPLVJYABHhQ2QGQZ+sE/sbAjahK3mJIFAST6TS/i0z3Q343Z2hX0pF82fiISUNxDV9zcPkNnb2G1Z/ZgFxkAF0LxgWl6+wdJyOsm32qvgiWMLUtTw9TLFim7MDQiMePojJYR797jmyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781400870; c=relaxed/simple;
	bh=XJDE9H1zb3ncjaTpBBW/YYcd0WWJ/Ioawsig7YbpqpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mH3dCi1M2xFUIEwEHrlTYTVCPgb6lzsOkCYZ15FaYT1k7t2w/BmWnYbXIXTO+ijZs5Q2BiIZgKGiY8dMBjq5r5AZWk7H9LDVcn56zhgxo33OEnwffi4cUwzXellRNniOn2KFJbNkv4hFiY8H+B44+efCXrFGniRb5DeEHdTvso8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8E2cNSf; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKZ2Rr1A7zfaXOBhQn0+hoJnpAQLyfqhRo4U2wZ+dPFeUSXwN9BGRIN1mGaehqJUuGCa097FM1Gs4LwvlwCgtJ0FgeWPANwyQyGzDR2EYGqYurbmcFRBsobKqeI6vhqE1XHzxJxSllaFnD9dcWtajLiQUe3dBKE35YUfG/Jw/RtsnOsSAfm2cQG1E54glDiRieyaeiNcR8H7THp1HxMh6YVbNPYmvUFWdyIRx7P8OEpaAdRcPR4Yw1vugY3TWgVJQFvxDqKRj7ytmgWG2DVBuLCRwasuoGVgsndUGQVDkFVeNd3eGcZLVvrRGQxeLBNCFB60ZYWnrsEzKHfM+q9Phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDiQyHEveBym3FiIt/ZgDT8cjLo5WLmulj+buCb9/GE=;
 b=bF9HtJs+wbjOKUEj7hvPm1ykEbnc7V0pCYeKHqG1RKZQv4/f40somjuGKcQ8rmByTdBpGCxAvF6F5ZjnGtoz9HQWyhYMDyY1kVpj84I07NjohPIOKGiZWE9LV0GagvDR9ULLjYc4XL/JgNc0cvQR9XvzSNgJRLKuoAeOKdL+npSU2occRIA3lax/CM0O2DKjgIAjHG07QZZHOwfi0l2lhiwdMw/YRguKr1el0O+/Vk0UosG0EJMUHRZWFvha+SdNFlOGodXnsZ6VWiSKpdqQL6DuwkyGhAWuJpGojXRD4y6gFERXWf13r9blXNmUG7swB3xtXFQljlYKo95cTPRMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDiQyHEveBym3FiIt/ZgDT8cjLo5WLmulj+buCb9/GE=;
 b=Q8E2cNSf5Z6/Iq7MgBzoU2F+CDF39WsB7rE43jFPglWDTQ8dPAYZt8NXcO5DpLJW/2YbyQBdGB75mg+B3O4oFx/jmlcYzKRwcKnblvu3IOzw7qo7xYG0tgnjVCtmOG7fQCY28ZrnBfB33I6qCIdeenRcDrjtY7rPAcxs2xoDP3o=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.16; Sun, 14 Jun 2026 01:34:26 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 01:34:25 +0000
Message-ID: <4f6de4ed-c687-4d1b-86fd-1c8e63e08fb3@amd.com>
Date: Sat, 13 Jun 2026 18:34:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/5] ionic: Expose more port stats to ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
 <20260613165323.4df246d9@kernel.org>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <20260613165323.4df246d9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:a03:338::13) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: fb19ffc2-df83-4e92-7933-08dec9b511b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CvYmUDLlJtQm3ddJIqtdlTDyz7yzKKM+64r36P0WgCu4uVrW04Wd7dMRbNPwkvLLI30G/Aat/ojfUcHmWKSSI4Ie6FtqiICDZ1wGEsY+QdpVO7gcEVS6hLq9ZnuHtdSUQJZCcAj/naVhxKousk3KYAdko8zr30frNrp7b80zWETJpJiYaZ2P0u6yeMWNbXNDNYt8IcZQHPJqkKen8H51Eo7XLexF5Mrm+hGvLCHxnLiZytTuy12AjziJePapVIZ68tpBkXunNaHObnJQbPaOYcaCn6IdqSPoKBIl32CpiyATAbqrBEK8vGqyWqmIFR5p/1/ZA+CxHcf5CHz/3hA2Y/D/vTOwlFEu0pKDWVzu4jb1kE6mMG2SZAzetjHpiT/Lwu6uWhMP/ptP/P4bJIAIwInb1ye+XLYy8t6InPg/xA8CNZt6nO6jkxO1mZIuXx2RHndcPb4rKJk398TlotNixxGyl0bHLOt1duhiEAAu/WrI49QnQP8kxIgbZb5zwNxHyFjtrj5D7dwhHWrqn5Msg/kBqyIXfLdmqWfvwT0zP64Rr7dBxKShZJS9Xy9rAIFbBpO2cLbLe018mW9tqLE6WOIMMMyKPvzxcoregHvmfdJxaXbNvfFE8/F37Nk1K3QnvFnMQdkPkbCy0eCyXWj3LJSDjj+EdQ9LjijH6YZZg9dsDO+N15VXywdytTbRFzdb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(3023799007)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3gwYWVic2xtNWpCZ2psb3NHNm5YbitSVWpSUlVIU3lVeFFkY25QK0Z2NzA4?=
 =?utf-8?B?VjZJQ0syQWwxc1lSOTVTK3BLdm5iQjVpaXJFNlBmNytNWTAxQ3hOUW5jU0R4?=
 =?utf-8?B?T1NaNDVBbjlaaGVvNlFXemNoRjZPNWY4VEU0ajNJcEZ3cUdYRTd2ZWVMTmFL?=
 =?utf-8?B?R2MrY0ZieTNMaWxoQ0RZdDBsT0tjMHZJb2lGbnFzRmdhWHB2ZUpzdnVVbC9w?=
 =?utf-8?B?cEo3R1NjZC8vTlJFcXd2cU4yU2JnNEVkNjcvZVFpQXpFL1pwVkcxMXl4VU9N?=
 =?utf-8?B?cTNPdnE0WGJOZkF3N0gxWHZqSFpxUFY0Rm9XZXl0NDRLY0MxdlNibHpKYjYw?=
 =?utf-8?B?MXlQOGZCOVdYZm1JaWZid2dDazd6YlBPV2tLNXJnWlpjRE9OemV1eXJxK3po?=
 =?utf-8?B?a0hLNkxnUzVPRTBUdVo3VmpZVkJuV0swVkJQdmsrelhPWEUrTHdDRDhpbk41?=
 =?utf-8?B?bjN2V1pNa1FraHdUU3BnRGlVOGtSa1FkMHhoUFI5VFdyMFZUNDh5dVhrRDFI?=
 =?utf-8?B?ZXRkeEloQVkwTndjSEFVWEk0S01JVXdOT3JCV1Z1QlNEY2JoQUU3aE1kZUJ6?=
 =?utf-8?B?UkZTL2NQUzc4U3Noc0prK0dCYWtRS3dPOGdnWkVUdmp5eis1M3RQRHhBSGNG?=
 =?utf-8?B?MFVTSkFKSnpmanhHTWhjRlhUZXFCUE9QTG5jS0YyU0FiYUNtNEJwamQ0MVo0?=
 =?utf-8?B?T0pQOFE0aXl4N2kwckpyL0dWcFBFcjA5eVgvR0lVUExQazNlZkhXV0V1T3Vt?=
 =?utf-8?B?YUF3LzM4eEVjVWlLL1c5SnFUOHlWTXBGQTJKblp1YXVqM09TZ2tDcFowdUpI?=
 =?utf-8?B?OVhYN3VVWVFmM1JwWERmRUdheElieEJFKzdZTzY5MzRHZFNtNm5HelNQY3I3?=
 =?utf-8?B?U0pxNFc2Qkg1WG9ZTDk5WE80OXZMZ0UyaGFwNWNVbHV4VERodTBCNll1WlI4?=
 =?utf-8?B?L1dHbUF6SHl2WEQ2S2VnN25YdkorZ0pQMHRZeWxxRTRWZzN0dTRhblpZM3JP?=
 =?utf-8?B?ZktpSjJwNE1JVWtuZlBVNDkyM0k0azRqclRmNWVWR25EaGRpUXpSeUhhWWwz?=
 =?utf-8?B?VTdMcFgxaTNxN0xSbWp3aGROVytBTDBjcXBhRnZLOEVId05xbjlDMEwwY0ln?=
 =?utf-8?B?QkUxbTNnaS9NTDRpZnoxaG9KdmpObU9zTUdyemhpYndtWGFBakhlTkR0U1lN?=
 =?utf-8?B?M1pPZnpsZGY0T1dUbWhyMms2NEZkbkoyWmlmOEZNMUVwRGtmbWdpbVpMWDBs?=
 =?utf-8?B?M1BlUE5HT3hEK3pxRmJYTTVuOThOcEdhdFV4dE9sc0NuNE9vMmVpSVA4Tlpq?=
 =?utf-8?B?bk5VYm5uQjZjQ2VlV05yNE5uNGxOS0VheHZSNnpEakxwY2RrRmZYMlVhdkJJ?=
 =?utf-8?B?S29rNVZUR0JMdW9Xa0ZtVWtUNVljdnBlS0RwSTVKRlBjVnJPYXJmbjJ4MjRR?=
 =?utf-8?B?ajBRNmEwbkp3eXdXc1hmUlc1VGlUV0E0ZlVjQVMwZXhkVlBPSEViNVgySFdh?=
 =?utf-8?B?akZhcW9DeVd2amU2ZUVsS2ZuczlDRVIrY3E3NHpnZVJnK0xKRG5nZVZZbERm?=
 =?utf-8?B?QUF4VmI1WlcraWkyTDNYVE9TYjUyNTZDTmtWNVRnSmJQcG9USGRiL0FXZ3ll?=
 =?utf-8?B?RUg5NnNzU25GOEp6NVE5V3BMSGpJUFFTb05HMVAvRDBXME03aEh3bzR6OUtp?=
 =?utf-8?B?Z3pPYWJtOVBIK2xhb0I4Zkw2M3RlSTBFaFVHSFZRUmhPUCsvU2dyZGFvSThz?=
 =?utf-8?B?d2ZlOHdkdTYwK3RoVFhuL0gxVGxOU0ZPTkxFeEU2ODAxZkFibGJNN3pqT1JG?=
 =?utf-8?B?MFkwZ09ReWhPcTIyTVdqU0FqZGFSRnRJNUxyOU8xUFd6eHYyVkNCcm5GVVo5?=
 =?utf-8?B?SGsvNWEwUUFzK3MxaWlVY2lhczBOamFsVktobXFFWUgwRXJKUDZPOVJyOEkr?=
 =?utf-8?B?QWZUTG9YWU9keXZKdDNuTWxOb0JGbVFCN3owY3NMaEliUzdTS2RreHR6V2VG?=
 =?utf-8?B?YlJvbENrUFRVL09XNGxhcCtyem85VlgzbGNjU0R6RlM5azhDUlQxdm9kbXV4?=
 =?utf-8?B?dEExalluSWZONFdpL2NnbmUvNjNqbEExOXliTDBmU3ZGdDhUYmZEZVhtYktu?=
 =?utf-8?B?TGt5dUl6ZlQxVXpSWE1OZmlEVFFKaFNhWWJkaXRiZktOOUd2ZlVJZEFPN2du?=
 =?utf-8?B?Wm1UQllPY3F2YzhLaVh1TVA0eXdaM1drKzFaRHBNU2FFSDJRbkxjQzU3L2hT?=
 =?utf-8?B?RWgweHpHMC9yTlRDS1NyVlNNN29BcTVHc1dydG81b1JwaUJEUzRZTjZnQnc0?=
 =?utf-8?B?bUJ6UlhPQWp1RGppQXlrTXBTUXlRMUNzTE9ZS0JSR0ZOM3VWcWJpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb19ffc2-df83-4e92-7933-08dec9b511b1
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 01:34:25.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OA6tAI8M1aLtVyYRrpVMrqXchHh+nCQ+YXu4cq46Dh4MeKtZmAkOt52fp1bvKsa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299117-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DC1B6802E3

On 6/13/2026 4:53 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, 9 Jun 2026 23:18:25 -0700 Eric Joyner wrote:
>> - The link_down_count from firmware mentioned in v2 was moved back to an
>>   entry in the general ethtool statistics; the existing driver-calculated
>>   value for the ethtool ext link is more appropriate due to the firmware
>>   value being a small size and not resetting between driver loads.
> 
> There's a uAPI stat defined for something but you don't use it because
> you can't be bothered to handle overflow and reset? What am I missing :/

I could add the overflow and reset handling (I was working on it for a v5), but
to me, it didn't seem like it was worth the effort to modify the stat from
firmware instead of continuing to use the existing driver-calculated stat. It
wasn't really a "can I do this" question but more "is it worth doing this?"

To start, it didn't seem like there was a specific standard that the API
expected; it looked like "copy straight from the adapter if you can, or just
calculate something if you can't". It's hard to tell what the actual
expectations for the interface outside of the struct comment since there aren't
many drivers using it. The Mellanox and Broadcom driver stat handlers just read
the link down count straight from hardware (though I don't know if those stats
get reset on driver load or reboot and we're the outlier in the way our firmware
behaves). The Intel drivers are similar to what we do now in the ionic driver,
and they just count the link down events that the driver detects, but I know
that they don't expose a link down count from the hardware.  What we do now
seems good enough for that purpose? It's bigger than 16 bits and gets reset on
driver load, so why add more code to handle something that this seems to do well
enough?

But, I also still want the raw firmware stat because the firmware has a
different lifetime than the driver, and so it will count link down events while
the driver isn't loaded or in a state to receive link events. But since maybe
that's only useful for debugging, it belongs in debugfs instead? I just thought
drivers could more or less put what they want in `ethtool -S` output, so that
seemed like an okay place to put it.

- Eric

