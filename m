Return-Path: <netdev+bounces-307558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KsHbGx5+Vmpr7QAAu9opvQ
	(envelope-from <netdev+bounces-307558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:21:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F46757CC0
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:21:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=M017rqye;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307558-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1C23303A71A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9831ED8B;
	Tue, 14 Jul 2026 18:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5577328B7F
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:20:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053213; cv=fail; b=KHlG4aePstUc56smvEQl5cUUhprSeIJyNjSRDxyY6i6CGCqGkMWrZbYR2XcGB8f+uNXezWzO41nQ7vuhBYzo7fdJhYr7qGBUZtulhYtzLGpcQm1Tu0Mil6LwbxW7ShjFYExVQ9UVX15PtADrAU8ElUaE3+Ay8RaYfPNWVv0Oqnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053213; c=relaxed/simple;
	bh=3Jxm7/l1m/p1BX9Ces6VYQUiRX3tUW2AcOVnZ3+jgKc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mR5ucEx3rTScN69UWb1oGGdsQt0xO9zxnciYr/HKaofaVaJHcMa1eeCKEKSNNtwXG5yotVNXifP2icJCJbmCvlup/wlsVxXaZT65BGkBBpNi/+lImaP2KXsRPMxOFrZQXJjmImikYIIr4mlR3NvRmYN2lCbpQlxLocht5wAd/kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M017rqye; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo3nxgofeuHBIcNvILPMJGK5REZbXyEOUerL/ZXO9B4C4Wp24fDr9dsJRXp5ii/XrVHGV6BGiNYiu5YZ0bihYGLD+usDuttm+DIiA/y4zqMgPNaLVNtJp6qNgu6s4/iejY6kAD1/bxA/VzdRorsD+r+YxcgHWFquSDHArEZlUqGHKMcEl9/mOq1LDBuF4mgy7kmZpNiGDXlXmA52jYSwbgblD/7khN2xNimLUcP+BbvIE1DC7wctmK++1ewUPS7HWSg4EPwWbJTAi9aVu+GtC+d1QRp/43YJnXNCM9bl0jYKY5WhdwpLcx47y7Rd0/fdtv9b3HsOCROou/rsaG6Yig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUN1jFpaxdnHBf17oqsG69asdcNKka4iL78oDRsunOM=;
 b=y5DY0/XxOAutoJhTpiRBlgsKiHjiLtynUqCPEWwdu1itR9zqDN17fU/5XhoW6DGBcM6TyXl2yyfn0hx+6RzzI4pkVahVNW5TV0YM3EvMBty1IUdd1VRHbqDZz7v2uUH/e38fonxdhwx46f29dUL2Hq8MwvFece2W11o2jMMvj647FkwQOALyvmsmG52WdWGp2bkZNCNg9iSN+h2lj7XSabfhXDyDwCyI5L8O5QJfZerV9/38X1gAxrt+S0SGigMpdXbkVLjg6a3qDgP24GdTFAzkR2w/RFLXS3z8a/szzT6w+XEbILk8VpWnuxF/pAYfcD+86LVOkxRfeOJpjZmwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUN1jFpaxdnHBf17oqsG69asdcNKka4iL78oDRsunOM=;
 b=M017rqyetaMrqEQvW3DjV5HoDpLkbx/j3PR01LzEIRNEx6gftH6P5EqJcIebG+FoUUb/qdPMGxAnX/8O42wTA1z8Q+cbHhL2f7ry81H4vXNo/qK2lcMdsNmjHHe3AxMeKhYKZGzIPM1P8G+NyqcP+CM3JO8hq+6v4FMmECU3bY4=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Tue, 14 Jul
 2026 18:20:09 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 18:20:07 +0000
Message-ID: <0d5ce279-9491-4eeb-afd1-40cdb419a1a0@amd.com>
Date: Tue, 14 Jul 2026 11:20:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] pds_core: fix use-after-free on workqueue
 during remove
From: "Rao, Nikhil" <nikhirao@amd.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, brett.creeley@amd.com, eric.joyner@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260629200358.2626129-1-nikhil.rao@amd.com>
 <20260629200358.2626129-3-nikhil.rao@amd.com>
 <11c0ee2b-96ff-4e27-8688-485dc4605f58@redhat.com>
 <3fb21caf-c9f8-4218-8c14-8192a71f26f2@amd.com>
Content-Language: en-US
In-Reply-To: <3fb21caf-c9f8-4218-8c14-8192a71f26f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: bdef748b-14f5-473a-8b67-08dee1d48604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|4143699003|56012099006|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rSpY0W2I9h5dSsTLbHiyk/RcSBWbNExQfgBUPGk4jHe70tqRfjKURc1v+4dtMVBlI4Gn/ATS13OZ4dJ6CThAVx3K/50+dEep9dH/rcrrvFSjBDbaKSVoAHFfZGRX2IKuFXtklJuP6BFiGa2t3ue80CsBZBti7n/AYIohcN3RFWjPRM+HgwJkqHAxoRvdYJ2mE6JrHDJJVOTV06hrAmzLJbFsAz6yz7bkm0/EqrjX9VVG4sYskcauPKPmOJ6Trqlcg3/qqQirzX//E71uGEVKnJKOufQaCBV/JiRboNmUDWBd1nMjnY32vlEHW3zbAjLcdL1WbR2CzytHXvXCgjU6bZyWd1uEuPItoxEyP4QSlPd45cc+/splRa4jGbxm9OyTq37Ct64WtdAO3dZ2dU9sT0dVHo3U5xdz8bgqh34sbV6voyptl8XUaUwaJQ4Z8rL+WiQl+jI8vrWdeGtldXtn07O7ScxGcME2GRRlLf8lQkzRyCalB79N/UIEhEZ48468KBiggD/dmg99JDLm5EFwqyEhnmk9HSl/cSKVNpC73TP0bJiiitWu6N/2IAOOL7xssUcfTLMmcVajr1tJjAQaZSh/odZfoVO95ZlwfHA60Kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWVNeWhpVU82YXE3Q2Z1T3pJREdmamJhTG5aTDRQM3Z1bHlCbFFYc0M3WnI2?=
 =?utf-8?B?eTZwdlNrakJqVmYzZTZIeXhEbXYxZ09mSlR3akVGdDlGcndCQkZWdTE1STh5?=
 =?utf-8?B?R2hjUTFydGw3V285REgzWlFYSGppRnhFK3YzcTBFZVp4d0F2ZmlSc2RTbmUy?=
 =?utf-8?B?ejhxT1Z0cDFlYnB2TjM4Wmx3UWNFSTE4QUxvSVdHNkxZRWl2RS80NTI0ZWpl?=
 =?utf-8?B?OUpramNEQ25UaXFwWUtkcHlVa29jdTBNWWlaakxTVFVPZ0lEWjE1RjdReERt?=
 =?utf-8?B?dDZTSC9Dekd6Uk5KdXFDSGpleHdvZlJXaXNxN0s2dVZmYkFjRUpiU1RzR2ln?=
 =?utf-8?B?K1RjUUtQb3hUa3dKbjQ3eHR1dTBMSTJZTFA1MGQwREkvYXlFNFN1SDdzU1Ni?=
 =?utf-8?B?VWZpamMxOWFWcTMwSlIrZlVFSS9JazVpVXpYcitSNzN6azhvYVprcDc4VlVG?=
 =?utf-8?B?dVVBSXpOalYrQThNNy9hUkV2MjljUTY2aDcvWUhXTXpmVmRZMncrbThTb3Nt?=
 =?utf-8?B?K0Q0OHViRTVsMGlKSWxiaEpyMlhmTnlsdTVDOFlXSVZ0ajhOUHBWL2V4dzI3?=
 =?utf-8?B?L0dSSzRrS1JvMDl2Z0xtMG43R2x1ZHp6RExNTUhxamhRV0UvRHB6L0RIbFl3?=
 =?utf-8?B?clpTL0NSa0w3bUtMcU9NbW5XZUFEWU5md3FHeEF1RnI2MkJvR2c4YlRlY1F1?=
 =?utf-8?B?aDhiS2xUU2wzdTFaaGRUZDlxcEYxYWhQWGMrZU56RTVQVzFndERqL1RwUGVa?=
 =?utf-8?B?OThXTGgzTCtXN1U0N3pjOFd3a29pRVA5ZUk1SER1UFBsVmlzdGc1d25Gdm5V?=
 =?utf-8?B?dVNGZE9sRkZQZ1NpU2cyWDRXaTE1N0JoRGRyRjdLS3B1MkUyN2xDTTNsdFUy?=
 =?utf-8?B?bExEZG9PSC9zT0Y5OFNHeHBmQU9DUXcycnMvRFkzMnVJdm5NZkhUbW9TYTdL?=
 =?utf-8?B?blZjdVpEb2x1a3M1bks2ci9mSXlkZ2VEVmtaM3FXWjNWenU4Z21ZQ3lUcHNC?=
 =?utf-8?B?OWVGeDhaVEdKQTdhSDg3bGxWNzRFaXhRWEoyaU9Ua3Jxb1JpcnovQ1NEVFMr?=
 =?utf-8?B?c2NUOEZjVU83cEhHaUhJd3ZOdncvdTZKbVcxVXdUMVh3QXNReWlFMkJmM0ow?=
 =?utf-8?B?MUw3QngxakJ4UzJKOHRsSXI1RWpocjV6NDJheHlDVm04ZmpsUmRTOTRONlRM?=
 =?utf-8?B?MURZNG1WbUp3NkhJbGdMY3FGNWNZRUUwTTZCcDdkNENMY25XaTFaUlN1WGp0?=
 =?utf-8?B?dHEwZHJIOUlGcTlXQU4ybEVwOTJwdUxUV0VIZmRzMXU4UXBudktPYVgxVHRU?=
 =?utf-8?B?MmRWbm1nWWhkK3hYY0NCRzljdHhyb3hFdk4rcGlNbXJaZ3BpUXlvUHJoRkNC?=
 =?utf-8?B?ZGVtQ0xBckE0aHdicjRDN1NvbXM1VGhlYStBSUl6NGNrRmxqeE00RDJqeE9j?=
 =?utf-8?B?WEZGSjMrMUEwWnF0NEhVS2s4U3Z2cGw1V1FTUGxaeGZxL2cxN2x2Z0MvaWs3?=
 =?utf-8?B?eHNKUWo0S1RvY3VueS9aTERLdjZyU08vb2V2MlVSZHhzREVhakcycStFR2xF?=
 =?utf-8?B?MWlKMmlIa2RvSDdVUVgvdm5CK1g5T2xYZUl3ZFNzcGVhK1JLbDRtcmZsWVJi?=
 =?utf-8?B?cHF0UTBWNWs4dGM1c1Q0blBlNnBOR2JkRm9iZ3JkZUY2aEZmYkVzbkJRQmFo?=
 =?utf-8?B?NFg1VXg3d25DQWx6S1RiWGVYaWorREJjWEJyNVB2d0M0c0lQWTRFdVJUOTVz?=
 =?utf-8?B?VzRUK3pSTFFMQ2ZFOGJSUGZ4dFJ2N1VUU2dWVEt2dnZSbU94cFBaeVVHQlBK?=
 =?utf-8?B?VTY1VmtYVER2amtPd2dRVHN5TE1Ic3g2K2lXay81amUvM0hNTU1uMEVkcTdm?=
 =?utf-8?B?NFM5bWZQbytnMTRCeVZ1U0hDd1Q4cUdaS2grTGNzeldMcDhFbFVPcUxpVi8z?=
 =?utf-8?B?aDFaWWw5eU9qK0kxUXJxbjFyejViamdqWDIvb3owOHVvY1NucVBqTVlLcGVj?=
 =?utf-8?B?SE1CaVQ5Q0pqUFkzYXNIN0tPbExLWG9DK1NiT0E5OGl0NnBpUHdjdU03RENC?=
 =?utf-8?B?cjV3M1Z1aDRNRHBlWnFsV3ZUcVhNRENPZVN3V3JOVTZ2K2dnUHJWbGhINm1k?=
 =?utf-8?B?M0FiOGY2R2R3WU1yT0puWllLbGkvNnpBc2JWa3ZzUmtWa0U2Rmdtb2xOaXpI?=
 =?utf-8?B?MkxMbVFDU1FrbUdXZkxSZW1iYWMwcGFWYzNmMVlzd3AvUnZFNUk0ejJPblg5?=
 =?utf-8?B?VEFvZkJ5SHFHM2FMM0Noa2lJTk8vUksrNlRLMjVhcXdRTnd0cjlSaElSdHc1?=
 =?utf-8?B?YlRBRVBPUjhTQmJIMFVEdUZMTGk1Z0Q1UGtiUVBpWWcrL0ZSdjFCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdef748b-14f5-473a-8b67-08dee1d48604
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:20:03.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiqmsaG5eeGRfXcKZUE+cF2HACQDqK2n/FkOjsdBpa4WmEQxWYFaOg0VnUja3l0YMU5mW0pJKGK/r1CQr5rveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1
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
	TAGGED_FROM(0.00)[bounces-307558-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2F46757CC0


On 7/6/2026 11:29 AM, Rao, Nikhil wrote:
> On 7/2/2026 1:13 AM, Paolo Abeni wrote:> On 6/29/26 10:03 PM, Nikhil P. 
> Rao wrote:
>  >> In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
>  >> is called. This ordering allows two paths to queue work on the
>  >> destroyed workqueue:
>  >>
>  >> 1. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the error
>  >>     path in pdsc_devcmd_locked() queues health_work.
>  >>
>  >> 2. A NotifyQ event can trigger the ISR and queue work before free_irq()
>  >>     is called in pdsc_teardown().
>  >
>  > I think this should be 2 separate patches.
> 
> Thanks for the review.
> 
> The original combined them because moving destroy_workqueue() after 
> teardown fixed both issues.
> 
> But they can be split:
> 
> - Patch 1: Set pdsc->wq = NULL before destroying it (fixes issue 1). The 
> devcmd error path checks pdsc->wq before queuing, so this prevents the 
> UAF. Also avoids needless health recovery during remove.
> 
> - Patch 2: Move destroy_workqueue() after teardown and add 
> cancel_work_sync() (fixes issue 2).
> 
> Combined, it looks like this:
> 
> struct workqueue_struct *wq = pdsc->wq;
> if (wq)
>     pdsc->wq = NULL;
> 
> /* teardown (free IRQ, cancel work, free memory) */
> 
> if (wq)
>      destroy_workqueue(wq);
> 
Setting pdsc->wq = NULL risks a NULL deref in pdsc_adminq_isr(), so the
split I suggested earlier doesn't hold.

>  >
>  >> @@ -121,10 +122,16 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
>  >>        qcq->accum_work += aq_work;
>  >>
>  >>   credits:
>  >> -     /* Return the interrupt credits, one for each completion */
>  >> -     pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
>  >> -                           nq_work + aq_work,
>  >> -                           PDS_CORE_INTR_CRED_REARM);
>  >> +     /* Return the interrupt credits, one for each completion.
>  >> +      * Use READ_ONCE to get a single consistent copy of intx since 
> it can
>  >> +      * be set to PDS_CORE_INTR_INDEX_NOT_ASSIGNED concurrently during
>  >> +      * teardown, and skip the credits if so.
>  >> +      */
>  >> +     intx = READ_ONCE(qcq->intx);
>  >> +     if (intx != PDS_CORE_INTR_INDEX_NOT_ASSIGNED)
>  >> +             pds_core_intr_credits(&pdsc->intr_ctrl[intx],
>  >> +                                   nq_work + aq_work,
>  >> +                                   PDS_CORE_INTR_CRED_REARM);
>  > AFAICS this does not look safe.
>  >
>  > A concurrent pdsc_qcq_free()/pdsc_qcq_intr_free() may free
>  > `pdsc->intr_ctrl` before setting PDS_CORE_INTR_INDEX_NOT_ASSIGNED.
>  >
>  > I think the teardown should:
>  >
>  > - disable the IRQ
>  > - cancel the work
>  > - free the structs
>  > in the above sequence.
> 
> pdsc_qcq_intr_free() doesn't free intr_ctrl - it only calls free_irq(). 
> intr_ctrl is BAR-mapped memory, freed later by pdsc_unmap_bars() after 
> teardown completes.
> 
> The sequence is already as suggested above:
> 
> pdsc_qcq_free()
> - pdsc_qcq_intr_free() /* calls pdsc_intr_free->free_irq() */
> - cancel_work_sync()
> - Frees DMA memory and structs
> 
> Note: the adminqcq ISR handles both adminq completions and notifyq 
> events, so notifyq struct is freed second.
> 
> In the current code, qcq->intx is set to NOT_ASSIGNED in 
> pdsc_qcq_intr_free(). Moving this to after cancel_work_sync() removes 
> the need for READ_ONCE/WRITE_ONCE.
>
There is no change in v3[1] beyond deleting READ_ONCE(qcq->intx) (and 
the corresponding WRITE_ONCE):
qcq->intx is now cleared after cancel_work_sync() in pdsc_qcq_free(), so 
pdsc_process_adminq() finishes before it changes.

On the Sashiko comment[2] asking whether the credit-return write could 
hit "the hardware register of a freed OS interrupt vector" and cause an
interrupt storm:

The credit write in pdsc_process_adminq() targets intr_ctrl[], device
MMIO in a PCI BAR, not the OS IRQ vector released by free_irq().
free_irq() shuts down and masks the MSI-X vector, so even if the device
is rearmed after free_irq(), the interrupt cannot be delivered - AFAIK,
is no unhandled interrupt storm.

I will send fixes for the rest of the Sashiko review comments.

Thanks,
Nikhil

[1] 
https://lore.kernel.org/netdev/20260714180223.1642792-1-nikhil.rao@amd.com/T/#t
[2] 
https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com

