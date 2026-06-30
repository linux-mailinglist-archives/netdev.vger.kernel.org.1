Return-Path: <netdev+bounces-303299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWzOKevvQ2pKlwoAu9opvQ
	(envelope-from <netdev+bounces-303299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C56E67CC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=ThLbdQqG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303299-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303299-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5D030E449E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1347AF42;
	Tue, 30 Jun 2026 16:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6247AF6C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:27:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836878; cv=fail; b=UUBzejt7pgDUSatYXCAehTB2O+Ucmmt6yXOEukkwYjqtPo8kTUSWeSUE3B7VeLr9d1MypeAQg+RaQl1GeM8umCqhjJDuFqZdIaNRgcXIPmDMknuQvPb822yqIk0EGk/MUpfir9DLWKu106SP8gP6SRhU64uBaUd98PWdIEC6+t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836878; c=relaxed/simple;
	bh=yP7ZDPdxCWxKSxLEBUyWJH1JyTzGdjtPu6gdmNYRTrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcwV+j6qgZu2RiBskmsDr4Bi/j5zXO1v7VcKZvgB9IQZUo/5n84DUswKM8P3V5Y8riArBkzfeqAM+OAmyyVceyldR/73Tu6lWl84r/N8l+uRPEfz4dOOkz80aVCYuPJL+8Ibf8ESgp6+lVf3ynfjK9WVrykId+srYj+mnIcld9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ThLbdQqG; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9GytEMQuqCMyZ2EXhW058N3xz76ytgg9XEQL4J9E6ffGqS33SBnK2jFTdWCGuMyEVCT9h8ihS26l5loCiNUh8rQedl1oZiKCcOJ29oh7F59ZNA9OOjnqqB6jq+BVhN9/q5JKDKaR/g6OfAvFDdBoAnzaaK4ulpTqXDATdLfrrafVJwTQSpcoSm3qCp1WDPqRrvgJKrnFAaKTYYnmgO1Wh4GZoeIvDhdII4ydkOynbsdYD4DqFxxX5V1+4SjB+NKjccJWMbKQ6elhshaQins0zH1StbF0wUZpBM3DqwfWw4EJynAtVWu5/IVul+S/+6bJvXdbNXf5qMihrr5me4jEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSGe+s64L9ofDvCtiBa9upQ3c9QHnO/3h8sUm8rOuNo=;
 b=aPyzEIZdps69aQc3JgW0ItgtAd2pZleqSTqksVRGrD7VNsyAeoG3I5sMO88seJv4c3W9ZMgMmC5mnVfO57iBQosyCwilc/tcu2kObdsFbp0+0vGVn7y/LFZ9DSgXDDGxCfOfZN4du+n7XG527D8PFOe8a93we0XaireBRNzAtk4WO/B3mgb08yVbbyTRskoW7IfhT6wLUOtKa81zNQUn2s5adk/xtaczHdhqe58dXMnGiBj9KZ3421arnwE+HzTFX/HO/rTi8ZzEhwgESjNBNEbYEzAlSE32TqHNn1aF25/dbhqLqrrznEvoVUmAoP+5NgB1uYOEPkkKKkqTv0h7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSGe+s64L9ofDvCtiBa9upQ3c9QHnO/3h8sUm8rOuNo=;
 b=ThLbdQqGJZgSoQRfoyAuXUQdDpZbMEGAT+Kgl6+7jDocoHHQBQ93Fiyyd+4exXsgLxsbyVABN9hTj2GCtxnmLfg2swY8lCh+fj+xuhO21ot1sfs64+pNZQVYd/M7VRew//Ty0jsvt3Q38q5va5UDBjhMpr2x2VP3VuL5SkMjlSc=
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 16:26:38 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 16:26:38 +0000
Message-ID: <bc26cd1a-ea70-4219-8ef2-a4a46d9669d5@amd.com>
Date: Tue, 30 Jun 2026 09:26:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ionic: Change list definition method
To: Lei Zhu <zhulei_szu@163.com>, brett.creeley@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20260630065457.160081-1-zhulei_szu@163.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260630065457.160081-1-zhulei_szu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:610:10e::23) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: f9904ce9-8d7d-4527-1148-08ded6c45c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/M83IIa57PvvTAbvLCoO4GRtlM8KUN52XNs9inNj3fDi+KuDhqkH3aPyZU+IajM1PBgzSL5fxRM4k2J2M2NhaeoDT1MdMeB0ZkQaKHYoX+AYZJHtdCYzw0yUJ6XNN4SqeswQroPWzUIBgV5uTow2Fba24y7Pz9AqnRi0hRWAuVNwkX6ILwFclUr3PfT+1emBP+UgSUhYWzmCkaA/RBw7/551VcfMumyeK0r3keR7eg6Uw/XNATU7WADLwCSWBaDKg3DRX6JguGCEOdTCPDYZs7yqMVLbyW+xQ8M/GZjrqzxksCe52620DmR4Jc8EBnN66AyqqhsEigbrWgo7XwV76qfeMteePjXbfnffby8RC7lpuiefw+xlSupoJrwyrL968G3IAPBJJahyut3tW0hVlCTOyj3ab+e4LMDmBrSk05cirTKg0RQZO8pC2l5WwG5wBDdjdgxWWpZ7brUWm/JlpzQZ3W82hmmtUMCYXMWzr766PmdecYsW50IInxNZImGLopf4q7mjA+HBk5deO7c8A+2LQFU1uPEex6i3X8ltiAcea0+nwXvullNevXC6ugFytSEveC/qCQ9EEoqj9Q1Gd2gi2L79yNlbOcz3/KPRFiMsYXMhLBHDPAABSO1yCvwFqQBhMi9BTE89TcWQiUSJcO3KFlqcZtNluxDKnGPM9WY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG5NclhmUnNzbFVuZGlSK3U3aUdaNWM1MHlaRm1obGJvZHNja1l3U2tob3hJ?=
 =?utf-8?B?bWV2V0NxR2FuaTVTMVJRVWtXd3JkL3ViSkhkdzFqRkFQQXk5Wk1FOXVRU2du?=
 =?utf-8?B?QzZER2YxUEhzUnA1TnZWMDdmTGVLeGFsWG02SjZFTjgxZU45MDU0V0dyK3ZR?=
 =?utf-8?B?OHltWkl0SGY0MllUTjA1bVF4ZjZIUFUxTWlqM05vb2JmbDR6dVpSK2hsRzNn?=
 =?utf-8?B?SUVselhmY29SdW41VWJTTXZYTFltWmU2aURwQ2VlTWNraDBCZG5VY3VpWmJ3?=
 =?utf-8?B?RktNSDQ5dHpIL09qaS9iaDBOVHY5QTEzbzQ0ZEVlMGE0SlYyNzR5dm1ndlY0?=
 =?utf-8?B?M2J0MDBsWGQvQW02a0ZJWEZQcU1yRWtsOGFQQktrVVRoQzdBY2NuK1FQVXRS?=
 =?utf-8?B?Vzg3MThSZkZwWjN3RllyRzdKTjE3cC81aGNKREhNZGQwQmdGNnJjenRvREp0?=
 =?utf-8?B?N0RYTWhFYk5KVGVFYjlYRllvZTZ1OUxRd21UK0h0ajF5TlpIczMyRkRtS3Fn?=
 =?utf-8?B?SEJSTVJtUVZqcEdxVysrUC9xK2NzWDFRNHlSdzhEV2NSTkJZa3NmUHY3d3dT?=
 =?utf-8?B?bUI5WFZqTG9MZk9GSjl3c1dRZnFZWmo2OUFDaVE0ZTRJSVZ5R3JocGhJVlVQ?=
 =?utf-8?B?aWRMbUNLMUZFSkcvdXFpZm13R0ViRklVRFZVd3htcEl1S3FSa3J1d2EzRWJZ?=
 =?utf-8?B?c3RKNDN6eGVTSzV4Z3JWK1hET2VNQ3ZBYlRLR3NlL29DUFQ1S3hTWFVTekhw?=
 =?utf-8?B?RUZBSFc0Y1Jsbk4zK3NlR3VXZmZ6Z1hVNHpuM21LcGMyb3F4dlpIdWRtUzR2?=
 =?utf-8?B?OWdCWW9SNHhXeDBEbVNLZDJkNkQ4MVBWVVlETk5pazU4Vm1xbXI3Y0t1Qllr?=
 =?utf-8?B?bStlVVJFb3ZOVEVWNjlxVjBDSzJEZFJucmQrNG01bzM3Z1hDZ3Z1WHMycmp6?=
 =?utf-8?B?NHdlOUZTMmg2R0pXaFpXVnNXRmJTYjRFVjZ1SkxqbHZQZC8zOStWSEhqSDdy?=
 =?utf-8?B?UG1valhQMmVacVBPSkhocVRaSE1jY3VCajg4ZTlhaHVjajE2MkcyNUhoTFQy?=
 =?utf-8?B?YUphamhXT3kyWUVZYVNTVGJEbmh0eGttQjNYVVNWTXNnSWd5d2pkV0xweHFI?=
 =?utf-8?B?R2liKy95VXVrdkxwWXBGRGkyaE11aEpiNTZ2YzRMS3FrZTYwa3FJZWhPUGZj?=
 =?utf-8?B?VFBlTUNUbURBL1BVVTBtQmRVem54cVhMVkhzZzFDSy9IUXFMamlKVEVOaFd4?=
 =?utf-8?B?OVNQcVp6bExWQTFHVWtkd2FBZlROaUVHMVdmZ1E4SVN1cnYwRHFuemgvUU1y?=
 =?utf-8?B?WExlQUNHcGNOV2JNWFVMWEFjWDdoNXNsRjRoWTdkem5Ca2dIZ05xRUxyOGMr?=
 =?utf-8?B?TjBRZjVoa0lTY3N4TUdVNlRUWTNTMnJyejFBYys5ckhlc1F3OWhXMkkzL1B4?=
 =?utf-8?B?SmUvbXl4cWdlS3lDVU1SMDdVS3BzVkRpTGtONXFTNXcra2NpZ2JHNVQxVUw5?=
 =?utf-8?B?bUJxUkN5djhzNi9COVpnc0YwZXd5VTg2ekZlY0ZYQis3cWJ0MFBJU2hRZXNR?=
 =?utf-8?B?b2JZWHhEYzhNL0dtZllrMVVFWWhCQkxaWmxQV3JsMHFKem1aeVJFZDM1T3JD?=
 =?utf-8?B?TENuelF4VHBOeE0rMkd3bzQ5ZFV5TXM0VGcyVTJLT1NkRDRQeW5Mc0pUMlBp?=
 =?utf-8?B?d0JDUW4yNFRramFxT3E3Tnh3YkRZYnBRQVVsb3JHM2Q4dEZ2Y3o1VkozQjZl?=
 =?utf-8?B?QVZFd2ZLZFZuOTdYdTh0U0hvT1F5SVdweUkwQXhiWXFveTAwMW5TeHJzQnNW?=
 =?utf-8?B?OHNTUFRwZno1UW1tQktoUE9CTXBEN0tKTFpSTzV6a05vZ2puZUhoUmNPWWVk?=
 =?utf-8?B?ZUg5bkJuK2x0SkVpMXBwTnhLWEVGUzhsZE8wdkhWcUk3TWhMSDlqSm9QaE1w?=
 =?utf-8?B?VW4rc3NLUmNoTjBiTXVxYmoyWERQZWdwOWxOWTR5U25qUm5neHBHTFlkOWp4?=
 =?utf-8?B?ZklLRXd1a1JJSU40WS91c0x1MERuNVZDa0F6V2pOa0pLd0JxRzRFOFY0M2Jh?=
 =?utf-8?B?c01DT2JZWEUxMkNtekljTHMzU0FyQnZYT3VEK3FZN1ROTjJnTHA1ZWdtMW5s?=
 =?utf-8?B?bzF6Nk43dGhTZmlnQVp1NEU4ZnpIZ1NMWjNuZUFjLzc3VTBjWjFaWkwwZG9q?=
 =?utf-8?B?WExVSGppNmhxWGlXMS9RVkl2dTY2dFl2Qkt2TDVSMWlIS24zWXVGUEVFUmRw?=
 =?utf-8?B?QU54dDFLM2FleVdEMERsYUQzZU9VZnhyUmZqYnNraDZxMklKTmhTRUhSQWtH?=
 =?utf-8?B?R3F0Mnk1MVJHQ0d2a0pYMnZHdm1HUElVa2lpY21hRmdhaVZ4NUtyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9904ce9-8d7d-4527-1148-08ded6c45c51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:26:38.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFOPBok3vrOVJgaz7+8ufvn+OJYdaMsBPOw9F3rTCd3qT4mzU51kfBjk+mcknOtQUiKQEWqnbWpclyq4r3UE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
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
	TAGGED_FROM(0.00)[bounces-303299-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,amd.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhulei_szu@163.com,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bcreeley@amd.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aka.ms:url,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 019C56E67CC



On 6/29/2026 11:54 PM, Lei Zhu wrote:
> [You don't often get email from zhulei_szu@163.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> From: Lei Zhu <zhulei@kylinos.cn>
>
> The LIST_HEAD macro can both define a linked list and initialize
> it in one step. To simplify code, we replace the separate operations
> of linked list definition and manual initialization with the LIST_HEAD
> macro.
>
> Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
> ---
> Changes in v2:
>    - Order the variable declaration lines longest to shortest
>
>   drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
> index 528114877677..c999754afb5f 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
> @@ -558,18 +558,15 @@ struct sync_item {
>   void ionic_rx_filter_sync(struct ionic_lif *lif)
>   {
>          struct device *dev = lif->ionic->dev;
> -       struct list_head sync_add_list;
> -       struct list_head sync_del_list;
>          struct sync_item *sync_item;
>          struct ionic_rx_filter *f;
> +       LIST_HEAD(sync_add_list);
> +       LIST_HEAD(sync_del_list);
>          struct hlist_head *head;
>          struct hlist_node *tmp;
>          struct sync_item *spos;
>          unsigned int i;
>
> -       INIT_LIST_HEAD(&sync_add_list);
> -       INIT_LIST_HEAD(&sync_del_list);
> -
LGTM. Thanks for the patch.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>          clear_bit(IONIC_LIF_F_FILTER_SYNC_NEEDED, lif->state);
>
>          /* Copy the filters to be added and deleted
> --
> 2.25.1
>


