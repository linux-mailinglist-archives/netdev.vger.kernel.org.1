Return-Path: <netdev+bounces-301912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRZEG4X1PGoPvAgAu9opvQ
	(envelope-from <netdev+bounces-301912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:31:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E086C43E5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:31:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=d3HC5grS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301912-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301912-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C14D5302C4BE
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899D38B146;
	Thu, 25 Jun 2026 09:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8E176238;
	Thu, 25 Jun 2026 09:31:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379899; cv=fail; b=kkztZe8BUTBzOpWJ8IMflEpMOLxdT0ympbW0p8d9Et/yW1ZwsPfCqhc2ePUwPeNvzhyGJLr5GY+jmjRab9Usq5ClKocVvAxed3uz/bH5IY8i51T8aPmQTC6hTXw6jMsd3j9T245L1n5ialIDNoq9ivJ5DewRLKZle/FaDMBHfU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379899; c=relaxed/simple;
	bh=MGZMNaqNn3jaQSq2RRyPS68p8GBfvP2gD0PK0P733Po=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DAOvdSBgFQBT+d9HQRZEE2iCA4OuKD/nUDgLU77eFvQc4Be8ONG31YmqMeox+ZpYgNKCCEojKCV4qla2LSfbOrIig5MW70XyNxo0QB+wjwx3LbByGnZrzvyZaKa4UaadkHjyL15WjDbHaNnGMjmzjKZecRmF6sZUZBfsFmXaJTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3HC5grS; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot5e6FDW9TRFwexirs1BZO+4504V3Sm0xssKeQbhzsHhldBJiHii+pg2I1BgCjcW/j66OYIArq84E7BNp/4soGhqRFreRWUQGvzkMiADZ0LdEafPGlRh0KYV8A8FTGQpIevE7Wnw2zcAD77fldF5YZNzJhRuM+b1/PCI6bfxcnxnSYqwb5zxt5skQSp6xTXEI9lAEtyDQ+yTJDg96yDBFg1oSNJmDyamCDMNAhVDbLvdQDy+WzAT6DrJA9JMAAATzBeG0TUJMBGXXAJW6nJDNLKAKxl0vSGbX8kEJUusPCeU50JT1GdFsj/YYWtDR3TH2QRMx04aG2XVx79Efeq9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcRgDZQAquKeLgdmCMoW+sq97y+gPhQ9MpaSCbawRtE=;
 b=CHHauxvSZybqU4zTM0RM4w8YwQ1zp7Dfgn1zz+N7evG0oRCjoFUMt2d1mZM1VIfrxZ46RWgodC2UNYvj/G9awtm6iisotYwPxXQpvI2j8VfKwHt1mDXaHKI0/5uH5vDhIc/LBbyCwjgdHjOrq56o2VF3zbv6wwk8d6cO6cPU3K3O7pwLuBCptYprGfiGPH1DdvvEBfJPwuZzvXyw+uDoc2W3t8dQjhcd8xIM9WhetZmcCK0KPXS/EyqGYJNQZ0RgC4y/AKWYtUZbz1yrZJDmLO+rq92hNEkWtnSlbzcVVEtWXAmEDacBUYM8h7klOl/QgyQCe448k0ZyGnHwGngRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcRgDZQAquKeLgdmCMoW+sq97y+gPhQ9MpaSCbawRtE=;
 b=d3HC5grSLaGwLlSCdIYXa+SYoPqQo3XSPobgGKVRGmOvxTchv0Gae0iq54r12dA6pYONgp27JSNiPbqcNT2bXqOTvvxLkbneAM7CYG9xPHH6DoMnjhHp8UzQgixxgLArU0W1UwirZTkBcLLdrMAN6Ok55r9gJcnjSRd3q9WM8Wg=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Thu, 25 Jun 2026 09:31:35 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 09:31:34 +0000
Message-ID: <b0a45e85-f42c-4a52-8223-f8318da10649@amd.com>
Date: Thu, 25 Jun 2026 10:31:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Content-Language: en-US
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Edward Cree <ecree.xilinx@gmail.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
 <6a3c55eea91d0_f12301008f@djbw-dev.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6a3c55eea91d0_f12301008f@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::11) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed20dd8-67db-42df-1281-08ded29c8c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|5023799004|921020|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	VOw682us4oQ7L9OANtk6qx2nxBg3BjVQU+wLH0wt5aVKt7acQK/1c4OnwkF1jffsesuvS826OK6al7lZbZpemalSTQ5Oo7V6p5/BR8snbs3bW4noua2l27QlyjGYN1K6RkqWaGF/08fFnp/KsCs1wmLqBzgK7j70mffyDwTWydlk6YVJcvvd2FbFeRsGf27CBBWdurHUmnuQKdMtjaBntEopeJy/1uYMz6CEFgfPduEM97QZw4ZEXKhcewpgy2HoKuVOoz6CQn51ZHnTCp+sGW50ozkcrMcngdM4MbR9j4/8orVm6NMCTPhqA1GWmiFLcEBYPKkJeMrO+K9Fn3XyrlBL/2dkNLpfPk5hj4Diyz5TkpflCj4DMDjsejQT1sG2V89iFmmcOF2SymtOurdZRBFGbQ2JtQhRTHg8RCAKGdvviOQ43cJ0t2I5hFDH6sUUc889atimTTH2HHgLMwxkd8XeVW9BK9eS8E0KfCxToCTtEnhR9Ja9vHXU1QKejAC3RBE5PMDxgyJImKPUtVwK2z/+3ejQetB8U/GNH+Dgfs5XxNBI7kp+hKZOqTmrAHFGZeWiv0WgXj+hycjLCr42dQ8ISl+LxCkv19E3/87P3L/IIvT+dpB+H9N3wScINkv2nY19fMlGBtuzbabEqiHZTQGnbWtGAwLiQlO6mRHsaetyFdZZYLqsJ97iKTtkGOkpjiFZK7pQ/Ydf3q4feRUe0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(921020)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K290T1huZE9TYkFFMDArYk05dWQ3aGJYUnU3OTZaWFE1clBuMnhtYnBZeng4?=
 =?utf-8?B?QjJoWk93ak1zaDh1eVByaUN4NjVaZjR0cnEveDV2ZXlSSk9TRTE2SW1mRDY4?=
 =?utf-8?B?bFVOMVR0UGkxZk9Qb3duQ25HVGk4SDd6cmxZNzJET2RUTlFLQ1dKZkVacVNY?=
 =?utf-8?B?a3V0WE1JeFRxZWdNbUFNOVFXaTVlcjlmdHNmVUNEWUFnR2UvQUNZUnlyZ3do?=
 =?utf-8?B?Q3E4dlVZWm5NU3dZelZVV3o2YzNWc00zdk5rWjhBSmFFUEtBUWZRd09PWGhG?=
 =?utf-8?B?YUd5dUpHTHpneVNieldjc29PMFF4bVU0Z3ZOWWs2MzVzaDVOT1ErWFJMSW1n?=
 =?utf-8?B?Vkg1K0NkUlZHVnJ4VDFLSk1Ham5xdTdOZmx3blF6SXNsOXRra2VsVFZKMlpL?=
 =?utf-8?B?U2dPc1pVTFlGaE1xUGlSSS9TaDJROXd3dVlVQ2RFK081REQzL1NMSnFjNFlP?=
 =?utf-8?B?aXNnZ0VXaEVGUk5QN0wySlcwekU0OTNiT25JdlFIZzg4Rm44b2ErNUFqeC81?=
 =?utf-8?B?OXlmWDVSKzMvekJMV3B1dkNHN1o3bWt3bGdDbStvaFVYOTFzWFVSaUFwUDk3?=
 =?utf-8?B?RVk0Z0tZK3RjclZ3YmIzUkhqZE1YNWlWdkliblBkL09ySFJFVXdzTk5UZjcy?=
 =?utf-8?B?VzE5N05GMENxM2lNUE9Qc1d3RElnMG5zZGJaVStNU0FybDZEMVNIUGZZZGZa?=
 =?utf-8?B?ckJ4UGFqVUppMkpQN3pqR1BsNC9KVENxSlhjWlNPOFVGRVpHZ0J5Z01uUnl2?=
 =?utf-8?B?M1VkcGZJL0tLNzRTcERaUE5JNDVLTTUwSjkyTW9qaFBwWVpZVEZyUTNYM2Zm?=
 =?utf-8?B?S0lFc1hsNERwcXljV1d0cnllN29yaktaWmp4Q01pNGxJcFY3cXJ2b3l3SzVh?=
 =?utf-8?B?K0xId25Yb1B0Z3dXZ2h5dlo2T1RITW1pZWlXdWZ2dlRraFR1d1RJckRaNzFa?=
 =?utf-8?B?cUxqT2V6MHVlL1lRQ1YwRWVBVkR4WTV3dGorVlNnVEFhd1FpYTJFWUJKRzYv?=
 =?utf-8?B?eE9XZWtSbndtQlNTUFNWM3c4QUwxakZPVk8zUStUdGM1TTIyeDE5ZnBBS29p?=
 =?utf-8?B?bVFyNFVrYjRpNUhIUlVGaW1VaGhGeWNJSEdIZlFDSmtha3dpa1JINzlLcEpM?=
 =?utf-8?B?Y3FwcllWNHU1MStXNldCSVg1UnliMEw0UEpmZ1Z1bmV0SU8ralc4a2trME9S?=
 =?utf-8?B?ajFRV1lwU1cyalhWZWV5MU4rNW55dDM4UGZ6cmxyNXh5TGsyWGk3TTFBTDh4?=
 =?utf-8?B?NWNvdjhuUXBIc2lScFVQSGxzUmxpQjNCcHdJa2FCTE4wZEJ2UHdzSWx2bFFD?=
 =?utf-8?B?RFpjYkdtaVJRS0VxZkhoUWxZc0VHYnVwbmJqOW56YUs0SUNqekNtTElnMVk5?=
 =?utf-8?B?V3gyNTdWSzNXWjdybG5KSU9VbVhoTEpob2NhNWY1YXJleWNvaFRocEJKRnY3?=
 =?utf-8?B?Vy9HaXFrSDlPay80K0tFWFdVbEg2NzRKbUdXcEwwbU9QZFBsUk1aMUdyZENN?=
 =?utf-8?B?Njk2UmVlelZENndlNy84Uk44OXhJalUxYmI0OENQZ3pWSkJsMjNiam15Qmgy?=
 =?utf-8?B?Y3RTdk5oTXhFTWtiNC9STjR6NTF1VVdRRkJuTUdmNFRaa2FlQ3UvNVdxYTFW?=
 =?utf-8?B?TUdRcURNakduUGtKUG1URGtEWjdSRzZQdWI2SkVHcmRlc3ZnalhubVkvYjBw?=
 =?utf-8?B?VTBYNk54c2gvWEV3N0JONVJqWTQvY2h3cGFMRzJlMUF6S21lTGx2bFcvODVi?=
 =?utf-8?B?aXVqbW54d2tiQVhjV0ErYzFEa3hmVDRJZnp4VFhaZkdzRk94NnN3VVJjaWt3?=
 =?utf-8?B?VUx3eWhrQlEzaE83Rk5oNDZqblRFQ25LUG94aGwvRDVsVkF5RnpJelNjY0h3?=
 =?utf-8?B?UWVFR29WOG9FTnJkRyswQU85YmMxdE03cWhXd05NV0lmSnZQSG85OWdTLzFK?=
 =?utf-8?B?RjhLNzhzVmpDeTFWM2dpL08zWGhqTzJ2Yi8rK2ZxZmozNys1SkdhZk8reGpu?=
 =?utf-8?B?eG1ORTJLamk5NE1sQk1Pc2lQc2F2d2VIbTducTgwS3plck9zOXZwNG5wT0xY?=
 =?utf-8?B?SFBPRDFmVXZRN1lTdHhhdlVJa3lRM3R6Qm9jVGxOTVhNczJhbmRidmxBeUVv?=
 =?utf-8?B?NEZTOEJWVlFJZmFCOU4vTnNEN1V5ZWFDRndKSSswNXllSTNWSXFNTVh3QTZl?=
 =?utf-8?B?TWZuQUoyZXEwREJndzdQcWZUVGZmL0tBS2lsckdKRjhpZTdiVmd4UXYvbnla?=
 =?utf-8?B?dWNpZFR5dmM1bUlBOE9lRHVTaWdSZWZ6S09uQXFVNG9ud1JYa2NpNmg2VGNR?=
 =?utf-8?B?QnJ2UDF6QVNLb0tQSUZvK2hSTjluMjVoRk81MUNSVlRESTFMZWxrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed20dd8-67db-42df-1281-08ded29c8c87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:31:34.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKc8OnOnwT2drffVKC6fr+V3yBLlJ76iBCa8tgH6vAbSHAe/4im3r6tKxhaHzPA9VbA40o7fUteNFhbsMrcRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:djbw@kernel.org,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05E086C43E5


On 6/24/26 23:10, Dan Williams (nvidia) wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use core API for safely obtain the CXL range linked to an HDM committed
>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>
>> A potential user space action through sysfs unbinding or core cxl
>> modules remove will trigger sfc driver device detachment, with that case
>> not racing with this mapping as this is done during driver probe and
>> therefore protected with device lock against those user space actions.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx.c     |  2 ++
>>   drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 61cbb6cfc360..3806cd3dd7f4 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_fini_io(efx);
>>   
>>   	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	efx_cxl_exit(probe_data);
>>   
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>> @@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	return 0;
>>   
>>    fail3:
>> +	efx_cxl_exit(probe_data);
>>   	efx_fini_io(efx);
>>    fail2:
>>   	efx_fini_struct(efx);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 18b535b3ea40..3e7c950f83e9 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct range cxl_pio_range;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return -ENODEV;
>>   	}
>>   
>> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
>> +		return PTR_ERR(cxl->cxlmd);
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>> +				    range_len(&cxl_pio_range));
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +			&cxl_pio_range);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   }
>>   
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
> If you are going to have an explicit efx_cxl_exit() then I would also
> add an explicit unregistration of the memdev.


This is necessary for undoing the mmap. Nothing else happens there 
because it is all relying on devm ...


I could change the ioremap_wc call to devm_ioremap_wc, but


> This would also fix the
> Sashiko report about pci_disable_device() running while the cxl_memdev
> is still registered. Unfortunately, mixing devm and explicit unwind is
> always fraught.


I do not think there is a problem here. The cxl core does not need what 
a type2 driver can do regarding PCI BAR mappings, or at least it is not 
the case for sfc.

Any action through sysfs cxl will go through cxl core and the only thing 
linked to the type device is the CXL registers which are mapped inside 
cxl_map_component_regs() and those are managed resources.


So, I can not see why this change is needed. If it is really necessary, 
please describe the problem with more detail.


It looks like you need reasons for delaying this further ...


>
> Let me know if this passes your testing, and I can send it out as a
> standalone patch. You could also use it to unwind if the ioremap()
> fails.


You did not read my comments on v28 ...


I changed efx_cxl_init to make the driver probe to fail if cxl is 
supported and enabled but the cxl initialization fails, including 
ioremap_wc(). What you proposed to do, explicitly undo cxl 
initialization bits, has the same outcome: device detached from the driver.



