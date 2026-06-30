Return-Path: <netdev+bounces-303329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id buKZG9cJRGpSngoAu9opvQ
	(envelope-from <netdev+bounces-303329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:24:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFB6E72D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:24:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=HXiGs7Q5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303329-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303329-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA8E30398A0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FA3DE422;
	Tue, 30 Jun 2026 18:24:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718621CC51
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:24:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843860; cv=fail; b=d2732fTKSFC40Q4cjpoWrFmne27ayUYuVzLu7j0a1eqlMP9gXXPNAaERZjdXsYXJ6ZeiQuJJraq1zw+ky8r2KqR63BlFQ61LnFQ7EnBMANColTtGRPsbRdZqnl5SrIjkb5l/kvY18c1DZhk2ZTu7ZIQ0Op4ux/i0yZWZ4mLtoo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843860; c=relaxed/simple;
	bh=4GIZB9SpOFcPHi+NXFVW2xoGSRl03svtSFLdIQTyHFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VIjVGWzadUVFggoBGp2by1vZJ7EDxAHOGFN44cXYmtaPv1Y6JohpV0ts4TxIZU5eTszH5ZSNrDmATAqmI8cbfRBi7J6mzsAif0fJgJVBxRqVgeigXj5T+PQCQgVUgrBuDwncRb+sSovZba35vvcXI/498PIuklEMw4oW4qOV5IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXiGs7Q5; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmQkoqTmKyenMxmA6haZyeT5AeGiKXf8YKjozPBFV0DQeUTqkNoMumcuMhvB9X+eUDoUIJUA+SaVKq/OZsmf51yPdx4xjtRuiQC1GhqRMaCuIXrTI8dXjztNSlD1vT5tuVHvP+dApm4ph/YM25+lXdweMhbhmcnMcQMYD6Azr11h78dJfN6nQ6R6cBqONMSuR+bJY2nmBwCsmrXHPYT57cxosxH/uXmC/mOTEYgm67DgizMNfQ556QdRt08pDFI9Qrx8PPQQ7KpqQZYkNEBJAkoHLMcKLdCDIKkxxrCOkG8zV0MlEL1NVe20sDWOfD0je/4t/tmyTLXS78N0p50K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LuGlbtas+0mgY9KIT2I8ZtiJ7laxwERtkk5ilG3Z9U=;
 b=OCHc4rG9UkrYmYI3k30ZEfclRqA4UQVcrV2ikHbQ6yi9eATkaDKiVR1EMqfAINi8zo05JD+enssu9opnmhhXNGTH+yfVIkILE6ILor2c6X8Z/IVou+8RNzJzcGqXTpALl5PddZAJxVAbbzz7dyME7/t13AXb1wquLNDrRbeR4T4oDQkdaWw257kpWQxrrNLMUg1q6nRgGTvBLeaxE8YYSmsqRbCh1mgEWceX6EAR1fUfT2wbPhQsZ9OUMKDjmG+opQmusmuHGdpetbxEcHGfql2I3ZtZrx//aa0yelZe/HpLHetYSmA7M1FyJNMuUlaauLj4q9vzhcmi/vPQTKYnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LuGlbtas+0mgY9KIT2I8ZtiJ7laxwERtkk5ilG3Z9U=;
 b=HXiGs7Q55lTjy84RvrRH3dNfIXj9qlDDI2bsh+crZVNpJi0Jrclm4YuBZqMhkeaXOXlLlzM6ZHcqgfVLJxWnKQiPom4SApouLYNyHj4VvKOZloKyBaiOZbDlyAObYm5x8Y45x5Z6a/Bd2spYO4FRZbDSnbW4Fv9fLjIrxPVKzP0=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 18:24:15 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 18:24:14 +0000
Message-ID: <a71c52a9-44c2-4dc3-b9fd-c9a95267a086@amd.com>
Date: Tue, 30 Jun 2026 11:24:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] ionic: Add .get_fec_stats ethtool handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>,
 Simon Horman <horms@kernel.org>
References: <20260614205303.48088-1-eric.joyner@amd.com>
 <20260614205303.48088-6-eric.joyner@amd.com>
 <20260615182732.7d28e31a@kernel.org>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <20260615182732.7d28e31a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::16) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc7f841-1753-4a52-274d-08ded6d4c9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	43UYerhfGX3uh/9D3cmYfEvCys/RldpEvuX8UihITBIQnFOcjDP13oiSP1cGuECIYmb9nFkHBFpMQ2PC9w8iTq7RIh0n3m497BBCETWawbf7gHUcUmBCjw7eKH5xt+5wKz/LkqavaUerXoXz2Bv28ScDezQ0JyB0hXp1Obj+8oWCSr5sOOfjk/5TU4KoWf+o0ykFmbJ63Y900NsiOIkCOkx/iq4AFpGXB5I0rzIupUIhxVE4GtEuJcdlpzUHfDbu20JHTFDn40/0vxhM4FYkqXHjriCYVEo3AKhuOuKWC4w+8vdt7vUtHsCooOhshHqklSsTp9O/JuNAMcBRyD354lxd1NMFOMfsyoWm/K7p91tu2rCljBQBFOVZwnTcz6R9jCdqW4qn9VsJ/JPD+LDf54fP++dM/tNQQJEr1cq7RL+zZh4/q1bRgNeiJ12MXIeyUKRizkR1DxD+VU1bNr2WhZ4ooL6n/+JJ5xUpPCeAOvDJ3hBiq6Zea559P3LP7JgblbiBgeDTgvPN6TU+iBun9iiFVO0svN1N6wjh8MqkAnymLkHPx/VzvX7DDcv+OXpexsffJ3UnI3H2FD3kwwrFRGUL6Syf3rQal8ni51qnL4csSSgdY6g40vfpNCOJAyV2rof3yGwblZZTM7JqOznwGIDhRaefcBfgSKX8atBcULY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNFdmVNUmN5ZjhiMG9sd3JMaDVLSUo3UDg3TkVEV25kR3VON2F3aXozR0ty?=
 =?utf-8?B?UlQvSjFSWUFPYUVwWmxuRE1veXoyMUZQZnRWQWRiZzZocVBtMnZVaUtCNnB2?=
 =?utf-8?B?anMyN0pZMlUvcHc3akd2eEZ6RVM5QmUvc08xeHo2Vkp6RTZ6cmZjT2ZEVW50?=
 =?utf-8?B?bmJTckxSNlpxSDlydFZQK1A5M0l5UmpIYUlMTTMvMzVJWkhNZjR3MGNYSWZ0?=
 =?utf-8?B?eU5SUDRkOExmVXBPcW4wR2hGTnNoVG1jc2xpbWVJVDVnZlovNEg1VW4rQld6?=
 =?utf-8?B?TitkM2xSUWdNc3V6ZXFvc21YekIxU3lWVXVXQWo5R0FPOVhvTTRIcG5ONW5R?=
 =?utf-8?B?RjRXaDdPNHlodDhSbXBoUC9ZUzRvL3UzcUpDQWlzVllSNU5jc1IwSklIaVdL?=
 =?utf-8?B?VUtyOFc4cWR1a3BDc0tQS3Z4OHNNRGRHbVo2VFVFdWNlNExmMndZYzVWUVFp?=
 =?utf-8?B?M2g5dG9DQldGM0dIemVibXlWMng2cHJXZWpGOG1ETEtKd090aGRaaHJmUjdo?=
 =?utf-8?B?Zmt2QWdQU1FyL3BpK0RnelhvWUljSEFIWk1UMzM5QVl0dy9yL29vaXhKMGdn?=
 =?utf-8?B?Vm1wNzVJVFhlYkRYeUdCcEt5V2JYMWZGWkMydzVScWV3RzBOOUM2cUxLQ08x?=
 =?utf-8?B?RG9CYUNaZUNkbTM2cmR6Tys0Q3dUc3M3N2pzZUQvd09pZlRSWmFuQ3MzUW9V?=
 =?utf-8?B?eDBrSEZDeGw2T1NyaW1OazZVQ1VoQlVtK240NnBlQm1INDRpaHpMbk4zbTgz?=
 =?utf-8?B?Mkgwdm9uWHZHejc2NzVrVzZWNUJNNmJaNFZIcWZ3OUJ4WG96NDA1cjhFdFI0?=
 =?utf-8?B?T3ZQWExRTU12cjNsNlp2NktlcVA2MzhVdzcwWkdueHJDLzBZb3RZNkIxT2M2?=
 =?utf-8?B?VUhtMld3eU5lc2RJVjI2d0JmejdwZ2hMQzlUemhCamJIQlRZRi9sVkdIVGZL?=
 =?utf-8?B?SENzYVdaRkN3c09PZHlQVFNpNFROMVpvaysrL0ZMcUVBTC81YmxKY2Y4WEdv?=
 =?utf-8?B?QlcvWVNPQ2NUaVNTY21UZTUvZWsyRXVRS3RiY1ZabXVTRlhIUndKa2xHeGRR?=
 =?utf-8?B?b2szVCtiSkZqV2hkTFk2Snl6c0hvTG9rY29Dbjc0OFMvVEhmRmMydjhoOWZy?=
 =?utf-8?B?Q3l4aE56VXhZNDdUdVlieUhlWUtHejRRajlMN0dzM0txN2ttNEM1L2N2VnUz?=
 =?utf-8?B?MzRpdGpHT2NieUkyU1AwbEVmc1BRVkF3WTZzdkdvMjZKajJBMXFka0ZiVlpO?=
 =?utf-8?B?cGQ2Um1vUnhnTG5hb3ROVFJreG80dUl0aVJJNmZhR05sQzVMNVRiVzQ3QS82?=
 =?utf-8?B?RXUybUhNNW1CNmUvSUhPK1pyUFdMeHExY3cvU3ozeUpURGRNalowa00wa0JY?=
 =?utf-8?B?MEJyS24yQXZIaEsybFI5bXF6UEdtcUNsM0JkVHRnY0xWY2RhNlh2dTljekJT?=
 =?utf-8?B?K2lFZWtPZEhsRDFEU2hteE9MME00eEFWdnc5dEdaRUw2c3dVNnAralFaLzlZ?=
 =?utf-8?B?cUpIeXdTRjVtYVVKM3ZJK2JuNFpQeE0rZFZRQkY5QXpzQklxMzZ3WGlueFNl?=
 =?utf-8?B?SVZ6Ri9lWlB5dzl3VGI1STJ1TDJodVR0SG94NThwRHdyaTM0TnpobXR2NkZK?=
 =?utf-8?B?YXhEdE5xS21SNEwyV0hscGF2YnBQRlY0NDAxUllNTEp3UDBuZ3FwdDJSckpa?=
 =?utf-8?B?NFA3T1hxVjNCS1dHa3NOSXdsc0tUc0VzODVTV0FoYzVKTk02UGdtalhSVTNX?=
 =?utf-8?B?NFNwbkY1UmMyMlhROHBZQkZQWmhHeG5LbE9XdCtpR3l3dC9jaXNPQ0lEZTlZ?=
 =?utf-8?B?aC96V2tnTVdzYlg4SklYb2dLcWpLTXYvSWVxK29QZXM3QVZ3aW5WSXFFWXVq?=
 =?utf-8?B?b3BSaG1JRko5c3ZBODl1UWxnVXFzRXJjL2hvcWlFLy9TRW1QdWdaKytrTGd1?=
 =?utf-8?B?cHA3RFVHbjJBZEgxRCt3MUdOdVBUZmlCUWpWcy95c0Vjbjl5b0hpL0tKZWFU?=
 =?utf-8?B?RHcvRzJDL0JaZ2hWamVDSVhPY3B5eFBBMDBKRUNxRzJBUFIyMW9zSnR6SVIv?=
 =?utf-8?B?NEFyUGpIWCtoV3ZTT0FPTERiaWNKcGdEaXRQLzd5R0F0dEptYmthK2xVUkkv?=
 =?utf-8?B?MjlpL1g3V0tvUnhhRmtvU053VC9LR29PMk85OUt3V0lyQURVSHJ2WEpKRnps?=
 =?utf-8?B?b2R3Z2tBOVpIT0MyUUc2OTFlTFpjVDM2V2g1SXU5OXE3RlFPdE9hb1RVZ1RZ?=
 =?utf-8?B?TXJuWVJEQXhCTTArdHZKV0xXajNGOUhWV2g0clFGQWV4eUVUTktMMU1VWEVN?=
 =?utf-8?Q?5uNceSudiG3YbAe+da?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc7f841-1753-4a52-274d-08ded6d4c9d7
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:24:14.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxDsrKntgvr5avl47GUuW6x3K/bWdbiG0++QkCaiQgKEvSik0sJvSrddiqbchVED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303329-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6EFB6E72D4

On 6/15/2026 6:27 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sun, 14 Jun 2026 13:53:03 -0700 Eric Joyner wrote:
>> +             if (fec_cw_err_bin != IONIC_STAT_INVALID)
>> +                     hist->values[i].sum = le64_to_cpu(fec_cw_err_bin);
>> +             else
>> +                     hist->values[i].sum = 0;
> 
> Setting the sum to zero is very much against the API contract with
> ethtool, no? Since we are just digging ourselves out of a whole with
> the link down events maybe let's be more strict going forward. :S
> 
> I think mlx5 had a similar problem of not knowing bucket count.
> You can put the bucket table in some driver struct and populate it
> at runtime.
> 
> Looking at this scheme, tho, I think the ethtool core is buggy for
> mlx5 :/ We should make a copy of the hist table, because we write
> the Netlink attrs after releasing the locks. Another call may start
> already and make the driver write its table in parallel.
> 
> Please send a fix for that if you can, or LMK if not, I'll chase
> one of the people involved in adding the fec stats.
> 
> I'll apply the first 4 patches here in the meantime.

Yeah, I'll work on a fix.

(Just to say that I didn't forget about this!)

- Eric



