Return-Path: <netdev+bounces-298358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0IclKSsmK2oO3QMAu9opvQ
	(envelope-from <netdev+bounces-298358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:18:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2E675662
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:18:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mI4HmENN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298358-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1836C30590A6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA432ABC0;
	Thu, 11 Jun 2026 21:18:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370C31326A;
	Thu, 11 Jun 2026 21:18:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212712; cv=fail; b=lY3scGUApRwIC9g7r4XPjNtbdysdhIjijtWG4dYGYAP+gTcsiNqQwwgTZCY3N/hprE94+zH3zMj8y1NtBS1FMzinxLwniszOVmB7cPTlR1ol4Nik5J8S1i+ReZhbSpnjodiBF0fv8+2WdLJQND32s/cI3th8vxzLs4Zg+lAQThE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212712; c=relaxed/simple;
	bh=85FLD2wDruEYYXLKEpWbwqedJPq8BLpZJ6yjNrazvjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSOvfEAylq85h44TlVUzFL1dUbaKFm36vXoPJk+RGHrV3ucppxIgjY/5QP1xnGp3k7jJt4HvhwSydxc0pP7VVufyS+nNxoEuUUxyZX4ZiaWPN197lGaojDe33I6XIi6P5fvQqrynpSMG80Zy2LhkiXq0T5RRgYHeIjSXgicvJG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mI4HmENN; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVnv77KhMMkUqOuPXa/xZvdI87GO9KgJtU93PnQtnYctacJWYAClQuiUbkkEssp3iV3efoubZ3Q7uBH1VNcaaHCa4degwTvPtP5wvx+uhb12qs8gq5TKV4VeITgLhqueUUmprYmtdcjAhQAWavpOSd4G55c2xLWfu5LsZS0aQwR9h//2piT83ldL+rfkWyU0c/v0JESFmMsF1TAZWApnnxLsIbRowhH/iErwIG91tVPgAuNXmYTYzM1U68AowKoQwh9HTK0ylDLJT5cOMF//i39+7rxMvWAwdhlkdyczgtMlcdls1VYj6MXKiqfDz5RZNUM4/5Ok1BSS9Vq8Kev6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snqWhlNJUOj4kuLFQ671NKdpah5HDdwrhM+lio8sHAs=;
 b=eAJa/75NJKBPPsRzl+H5xvPVxHoVV4MpcrbYW29QwJrZzbYC3nnB32gByN1xpYTDoXpmpqC1qr/HgL63l8IIDIe7vnvAKkIQP7Iqrc9Sum3HcMuV9LIAhLlUMSAEnofv5JKspoxdFmYW90NSyPwSxses1EVFpgjEabv9D/BFIifKy0ZmJpiKOsA7geTvfxW2up9tegOITAP2dDlkb/q8l7BCU1TPo/xiB3ToLAUvZKz3ugjEyui6OBJEFNaWJToZqFmwyaJaVQlN6h4mIyEARMvBc3X32omCA4jHab/vgKKIphUMmfGToVZrt7Q+Juz38Il8ByuhVkZqpK8iEKVghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snqWhlNJUOj4kuLFQ671NKdpah5HDdwrhM+lio8sHAs=;
 b=mI4HmENN4zNAwForE6/me2HCBEifutmC2HfBNreSXvCgu+jLcu4NEuJc6eGduHMoY1ck82A3XAumboKD24AQkB+Zh/uW0+35vtxaE4VqlEtzaAdqi9HgfTs6oJbPSDNkDTM9O/vf4A2K2qrV3HcmWAWh+UmyHFwoIxmYgBVoVGMYkgQh0N24Jbpye+LtkTRLRbIU6AW2XEYnWcv1PYj3+zpJv0AI0XawyC+fxTNacwrLWZvpK2CuagHxil4jMyytPQzDZLhVY1wFMjkb+8IEMh+N8nw9AooWs+qTSZziIB+fxQ0CIvPc1iCBTwtZ73bhTvgL9gVFDofEw0mn3TZ88g==
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 21:18:22 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 21:18:22 +0000
Message-ID: <a3d9459d-b8a5-4892-a087-8cce3862b8de@nvidia.com>
Date: Thu, 11 Jun 2026 23:18:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netdev: expose page pool order via netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Yael Chemla <ychemla@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611161235.3807332-1-dtatulea@nvidia.com>
 <20260611131849.43870ac5@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260611131849.43870ac5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: a965e32b-5ad6-4af6-f806-08dec7fef783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|56012099006|18002099003|4143699003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gFqWO6X4MF01LJ6Lqm/2wVifoM9leIMmnkSzQNcWr9/Y8ifVb4wVbAkYsweUkv3Uuek4k3t6qQdw80OGi680qct9z2NJ3nXH558QG1WJxtbZsjZy2GftWqIN+U9p3TcRt2ISH1UXXCRszsCXF4mMcfKXRN/tUnBv0zdfB8H4jrQlsgGN/K/qpz2vgwejhQVxqjBgHdkPDF0jxpbwgBVWXCO6NSa+JN5S8F31y6CA9bFhthZy2Z0g2xdFHALomAdVkqMOAhQfczdaICHPTIzb2Mq+4trndO/poHEsN55YqQmdcDD/dU5bid/9/+KPaha0cODgoUk4MIPpqy2aXh1BAtUxVfbuVlDblGNKGgjHEF48TJN5+SCkvUQ/2ELQXKCnhPcUtIcWoYuy09fGeatOH3dWiXmBpYgJkPLV3DEGggZFX3aBf+5nxhGiTHZSfvO5H64bTfySAIfWBXkZxPpTl1xdXJoI5V4SdeAG0IsVkmbaXpL+jrto/XUPSTrpj4kOgM2QU26pmNhYL3yTQ2+ODZMHIzaGxmsBoC/iOQ9YD9glRLamtn9zQ8wPnQ0BHSM6qYcAFQKHcemv8g6Mmep568QaFrdFSVtBW3MLvZAEpCh8SEWsua+C2bTPND8wDouaaH6LRns1xkxMxT7X6kkysESqJY4CTCHY5vBO8eV07ay8E3ADETdHpdMdCM0XzZB5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(18002099003)(4143699003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlkzNUZuRzR1Rkh3YXRGZHppYkw4cXBWUVM4emRENFhaN2VkMlBFdzFjWFV1?=
 =?utf-8?B?cy9VNDJLTy9PR1N4aWQzalp2RFFDTklNeGtqTmFJdGRkRTRDZ3hsdWM2V0Mr?=
 =?utf-8?B?MEtJZE9ia0lGa0RxaHpHeThLUHI1VXBaaFhyNHlCMHBTbmRQOUZGMnBnZnQ3?=
 =?utf-8?B?WkE1RFhBMzhZWGlXUXlhek9tRmdYYW1HZzVYOFVsR0tMcnN6NTlTbmFaWHEz?=
 =?utf-8?B?TXpkeWdVRVdvN3dsTjM5U3A2TTVMb1ZScDNkamE5a3hXUTZoK05iNnduWEtB?=
 =?utf-8?B?M29PTDUwQmxWMWxRNGFDVll6ZUhNbDRCb0dmbmxWWmdLWkg5U1F1VjRFV0ln?=
 =?utf-8?B?REh1YWhrUWVYYTRDdVdyMGZvMk9qYkV5bThQMDg2Qm9zVEx4TTUrekZzcXNy?=
 =?utf-8?B?R0VjOVJRRmlDczZpN0h1alVod1ErVkwwdUZXZElaSUI4YkZscDdNSFJCOTY3?=
 =?utf-8?B?SXFWM2JrSTNMbDNpODlJRUs0OGgwTmNwWGM0M1RBeXJxdUY2YTF2Qmw2cGQ4?=
 =?utf-8?B?MVlPWmRnazhrZVlrTWFuVUJsRk1OemVVMndBUUJwTTJERG5ubnQrMWYrcjZS?=
 =?utf-8?B?UHlZTU9RWmZNQVhWNmdXUlhtK0tXVGkxb2lsMzdhUndDSm94NjlERFprSzhJ?=
 =?utf-8?B?aGRMNnliR1laRFgvRXE2cUkxdTFIeVpmeEUyYTVtdllYbXFtank0VGswL0hK?=
 =?utf-8?B?ZmNCaHpwUm1RTERRZXF4NjY2cFdVT3NOSGNEUWdRV010RG5nZStEbm5nZkNL?=
 =?utf-8?B?eFQ0cTBwa0ZremdUNFhxZEZvQmpRV3dxUGpuV1RGQXlhUTVUdTQ0OW1YRnVB?=
 =?utf-8?B?SXMyUHg1RGJtbmN4YklyYjUvcDFGU3d5dmhkbEN1alZvdDdDQnpRNzVoYkww?=
 =?utf-8?B?VTV1Z3c3aS9DUHMreWVDaGZFWHVSVlR1dGxlQUYwZFc5cGRDRXNEdnJnNlgy?=
 =?utf-8?B?VmxacWJSbDduTlRXRzFQaGRtZVFGdGpFSFc0QmQxRGVEM3QrVFlDbE1zVzVh?=
 =?utf-8?B?OWVaMFU5NWdNd28zM3pHU01jVWE3WkRZWi9xMU5JMVE1NjhNSFJjQUdvZmRV?=
 =?utf-8?B?NjB5bUNWRW5SL2k0anp4TkMzL0NGckRibzRDUWZYK1ZIR2YveWJCanVBMlZU?=
 =?utf-8?B?YjhGUXB6cjNQMlNMYzd0WlBVWTVZL1pGdkNWUUpCbjJ4ZmxMYTFuNlVaZWhr?=
 =?utf-8?B?SHZQTzFtRGpsc0ExQmwyTkEvS3JoVzFMRHJUd3RKNnovWEVydXJQL1NkZ1M3?=
 =?utf-8?B?ZUlybHM2NlQveHVOWCtDNFJTL0NvYnZEM2g3Z3VFSE9hOWNrVHd6aU5kalpt?=
 =?utf-8?B?MGJVdVNSU2NZcnZLODNsZU9qV2JDWjhMY3RhaFBvM0xwL3NUbExVenY1SFpv?=
 =?utf-8?B?TTZqalh1T3ZXQ1NmUjFLN0FJanhVQ0p3Uzl2WTV4NE9oVk10YlNOS0J3N3My?=
 =?utf-8?B?U0tHeStVWXV1VVhoaDNIS1BOcHFXbXpwY2FnQ012Qk0xNkI5Sk1SUjRZNFF2?=
 =?utf-8?B?OFNDSGxoMS95SDA5S0YxV2JxQjZBb0dCWks2S1hxTURqYkhlMml6NFRmQ09J?=
 =?utf-8?B?R2svbDBXRm15TXlXait5MjM2d1A2RzBzck1SejZBb2hoSTBWUXh6STRpK0t1?=
 =?utf-8?B?QVpLK25IbzdUYjZ2ZXhmK1JVbVhCa1lvR2lWUDZyWUNUWTNuUURDZFkvMzgw?=
 =?utf-8?B?Z1VTY2l4Ukpoa0lPa1FtbnRDNGlrMzhmb1N1NUsxQXdRVHg0WE9kVDEzc2VV?=
 =?utf-8?B?YWEvRmtvUks0MzhvOUZ1RUlHdDdOdG9kSDRrUFVjMjNkTkVUT1drUVl4ajVw?=
 =?utf-8?B?STBicGtrSWpzZy9xNWI3SFBrQWhodVZvbmd3bDQwaVYrN3RjZExaUW56U3F3?=
 =?utf-8?B?TlErL21VM0gzUmptU3VXNjl5N1JSMlBMYkowaEpnMXN3ZUpkdkxOWnJNUENQ?=
 =?utf-8?B?U1V2TVZ2UzlybnBPODZuUG44T3JEck0rdDZXRFJDbzFqaU5FVkZtTFkyRm45?=
 =?utf-8?B?RjhZcVZ0SGJDcDNzQzZuM2tDRjVZNzRJNm5YQ2RzM1VabktVa3Bpak9nR09m?=
 =?utf-8?B?emxVNEZCRE1uUWhhSFAwZ29zaGdsWUhJRUUzV3c0aUpoREc1Rnd2N041SEVV?=
 =?utf-8?B?WS8ycTVIa2RRNlRwUHYzekNWVml6Y0R6Q2gvL2NDRk80RGlDNzBQUHFZNkRw?=
 =?utf-8?B?b3AySVNBcnhTY1BFaTg1OElmMjVTTWpaZlR5SW5wUWdrRGhEbjRjUU1NRDZs?=
 =?utf-8?B?VVJEbjJDeW80QXJuWm5UZ3EwR2hOL1FwVW4weVhvUCtkVndwMGd4blc0VlVk?=
 =?utf-8?B?S3Jwa3p4aDFNUjBrSFZINVFZOU1zOS9JekZQWVFFbGpScmpzbE9BQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a965e32b-5ad6-4af6-f806-08dec7fef783
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:18:22.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpbleGbowN1xXzYJqaNZ8ljQA1htKe+ObMYmYeoW1ook5IHkwd0WfBVpYwjlAm9Nh5CMDVBqxYGX5BQxsL5M6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew+netdev@lunn.ch,m:ychemla@nvidia.com,m:tariqt@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298358-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lunn.ch,nvidia.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAD2E675662



On 11.06.26 22:18, Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 19:12:32 +0300 Dragos Tatulea wrote:
>> Add a new 'order' attribute to the page-pool netlink interface to expose
>> the page pool's allocation order (power of 2 page count).
>>
>> This adds observability for the latest io_uring rx-buf-len configuration
>> for high order pages for zerocopy rx.
>>
>> The order is added to the queue attribute instead of the nested io_uring
>> attribute as it can be useful to see high order page_pools for other
>> cases as well.
> 
> Memory providers have a callback to populate their own attributes
> (nl_fill). Sounds like we should expose rx_buf_len over that thing
> instead of exposing the order which is more of a kernel internal?
> 
Sounds good. Will add it in v2.

> Also please add checking the new attr to some selftest.
Right. I added code in test_zcrx_large_chunks to check this.
I lost it on the way a couple of weeks ago and forgot about it.
Will add it back.

Thanks,
Dragos


