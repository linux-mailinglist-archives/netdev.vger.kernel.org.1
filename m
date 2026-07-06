Return-Path: <netdev+bounces-305062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +S8RHMOyS2rhYgEAu9opvQ
	(envelope-from <netdev+bounces-305062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0843C711803
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:50:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=caM4cf91;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305062-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305062-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6940630739B8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB241A785;
	Mon,  6 Jul 2026 13:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020108.outbound.protection.outlook.com [52.101.195.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6F3FC5B5;
	Mon,  6 Jul 2026 13:40:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345251; cv=fail; b=qvKy4tvhCBlRMj5KmsneGQA66N2/pyCvRyphgtUSUf4uIYPe4qBwa+ILJ3FmcSC0dxqVVyU1vpHSxjCQizEA0nwk5ZFcdNRWkneSwuYl1ahfeZA1cTjfck1JWNL59SEIuPx1ch+/yxZuEQinQNZPpSCa5duBFBcvCROMb/y3wss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345251; c=relaxed/simple;
	bh=9TdsMc/PGlZWldJp9jtgbiz0F6Kd7oNkHeQxy8Gm5mE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YWu38s5vgCjOaj1o5fSiTNoVJq3EjtUS9nuOZVqnZlRgLJrcDQ1PjHs7NmpCorYKAtecP1c1k90bim3GNrjQihtzVVeeeopWCzpigvZgPso3lZeYPFN/Wcvcpw7RZ+dIz0EnHgbZzb7Ygcom7bZH123zMVr8Hkps3EPmu4NWpro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=caM4cf91; arc=fail smtp.client-ip=52.101.195.108
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwemvyILRMRgdROR16ZHOYUz+/OBR2YZk/3iN3FanHjDbXThmuANdoz3rYJqiOR/LFrriseNx5DdTVZh2zNs8z54pP8QQCeaUTpONvyDccRy01M4oJy9AVuk0uVA48oMWzJ3clJrPaLVtsTtGAdIIrV0pPOqpa6byr1Ba9ui7bAY8F1ozkNY7bxidmrBojMzIlgBR7nxij9bqP66A6k1paAlCRmAbKCYdofcw05FEYkzKp2YhHQH2ZuEzbCNTRHEGsnLcRIxeF/Q1zU55iR+L495Yt+piwoQ9LXwuEmV//kLQ2ptGG6bmW8+F/19Xa+Uxc5KS0Mx/ouonPQ8a6wZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS1nrMkQ+n+ifHk9bsVXL+95RAP2c4oUGjTve5ol22o=;
 b=OWRQcnU7NCPUzp0yEysvApGfHRNRK1dPAcpTtf02regDTjnNfBa2uuZYaj/ZwPEAYlozdna9Z4BnSsbANho5g599Pp69w+4zX/oyrVc3nQnZWWlpNCa77TODmnQfPcnpG46daG7Bu4lXm9Mg9w083+TfFGWYO6JQeJ26lxCMdUh/+nSMotf621WpVF0zETDQ+E3Yg1jlmS4GVaOCQ8UcTVSqs9qVDf9Z1mxPQzHIuLK2YiFRwTI4DXejk++knp3TuvqanFC2K2Qhk2suh3FQ2F4gyRHa6mfP0tX9pliAxUOOXdBWUg0AvkKpGx8skEf9AJEYO+KgfQisiJ/RJlld7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS1nrMkQ+n+ifHk9bsVXL+95RAP2c4oUGjTve5ol22o=;
 b=caM4cf913k915+JM/9zgY1sWcY4FNcdZJ+80FFBEOZr31RainAdDLtvsoG5HpW7Dd9Cys6oY1bPiCdawG0bIK7bRRfTg/WcInst2dIsVlO9VvhEvxylhczIdyT9qDIQrFlfTENEcd7xpPXbYxTrca4/ZXUpXOJVtGKawRN2UdGQ=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2886.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 13:40:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 13:40:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 14:40:44 +0100
Message-Id: <DJRJ4N9UQUR8.1GSF8WWG5WO2Q@garyguo.net>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import
 style
From: "Gary Guo" <gary@garyguo.net>
To: "Andrew Lunn" <andrew@lunn.ch>, "Guru Das Srinagesh" <linux@gurudas.dev>
X-Mailer: aerc 0.21.0
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>
 <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
In-Reply-To: <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
X-ClientProxiedBy: LO3P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1874fb46-0e59-4ca4-ed7c-08dedb642df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|366016|1800799024|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XtyDwG9qlfHUrxgrXzpu4i6BRU+kOkiUxmiBb6Y15jCyFuhSPtTPS887nPgqf4fIGY4RP191MNmNLdba33yOU+5SaiBKHUdXpAlnDFo/Dlsh93icXZ7fmuZhLfbppRo62EYPHYmjoECJcnB9UYe30WmYjgsuhKuESNczOkKMtCqwNy/v55mAgazd+nPcJrMuaUHHzAuUgqeqTfU56vrjj823JLGd+xZ3kYRXXpyfabYV5ALRlLQbm4Z7TFd536m/61tAK1qBr3VQ/2hcsJBS1b3ygO79h/XIUPtcwu0G4EB50nt3RvRtgJ/yvuBOGA6e5ec7uXGYyvidCNBZGU8tKNCWFd91PbttUvCUkQYzjcxlW25K5AS7R7rSa/LuO73RJkmDZSaSuVzLScfTLrvXV3wb0h5nnH1jDK4Bwo25oPbDb1EAYqQxqU4AyBJNnMGIiWU518wHJ4Fx4xpaSThYqTMhyuglIzwrHYkBKdNJQKAzEqvCwUAxCKOqqvBB38Ls84GO+4HYQIVQ+B22ao9/00jAgoFcSwPq9LbcNEIOcyDqPPVAuUqKnd6GcTpJXxoDktP/YI7Hr6X33dmAgIE3Q9W5E9wSFHbIpjXY8FYKDHVJkWZ6yBExBW8wVNPGaBaubvo1RGXJVoKlY8kG5au2Lz8zliJn7YkPh0dzWEzelN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBlSVpmaEQyYytmcUlqVEtkK2NGRGF6WndOaUV1QThrT1VOMlZwR25mdVlO?=
 =?utf-8?B?UCtxNEFqdmVBVjRxS3NMYkhQYkVZeXpHNEx0RHV6K0tuZEkxdTA0VGQrRXRo?=
 =?utf-8?B?bnhTOUhiNGh6RWRWbVp1cUZXUVhaY0hOYXRlcHd0ZmFkNXBGejF1SlhDd1ZE?=
 =?utf-8?B?KzR2am4weEFvM2ZiYVhjRjdjQkFMbkhNcFhzc2NhUThEOTRDUk5sWjRqMksx?=
 =?utf-8?B?UDhuYVlnM2VsdWt6WnJ1Q2RKRUhXRVIyM1BralZybDJwcFRDTW9vcUNpZGJ5?=
 =?utf-8?B?SjVJeVJac3UyZ0dtZjhPTld0bk40ellRSmVlRWNTalkvUDJtOXhOdFhvaHlJ?=
 =?utf-8?B?QUc1QTFNMUVmL010WWxnQmliUktwZk1jQUFZcldLaExrdWxmdDd2YTYxVjMv?=
 =?utf-8?B?NmQ0RERXVXU3YVZHRTZpekp5UnJ6TERlZnlHTlVDWmozYituUlpMaGk3MHcw?=
 =?utf-8?B?MERmQjZuUE9uTTFVRUp1SlBiK2JKU2hvSTVWdmlFblJKaEt2bmpIMnVwUGc2?=
 =?utf-8?B?d0h3ejNFTjA0bFFBQkJLdkM1L1FtcnZ3NE5RSjc5VW15MkpEZ2JiVGVOTzQv?=
 =?utf-8?B?UnRLTTltaTN5a1pMVXpXQXI1U3lOQ082dm5nT2o1c1Q0c0xWTmZONHBLcmNV?=
 =?utf-8?B?NzBTSm1wTXZPY3pIMUUwOUh5blpySjlTdkkvcjdUSkxwWEpNM0hLSzFCTHRD?=
 =?utf-8?B?d3AyUzhZZWNrVm4zZkNQa1BEcWJ0MUdxL1poenJwRWZNZ214RGFvU0RzZlNu?=
 =?utf-8?B?dktDM1BqdEVCdk96L3RjeE42T2grVUpoektaVHZCRVFQRzNKa1RURzd2Um5R?=
 =?utf-8?B?cDNwbmVoam81RHFhVWo5STFhRnFJUTZPWUlGZ2UvNkMxQjRYYXVuMTRuVGJZ?=
 =?utf-8?B?cWpNWmpuVVJHa2plYUtPanF4MjQ0TUNPdTd5REY2N3o2UGVtZW9pYkphalF4?=
 =?utf-8?B?Wm9uYW8rWWQ2d05kdG5OZG9lZGY4NlhhRTVBaXBlNmptL3VQWnUzOHBsSlpT?=
 =?utf-8?B?WHZDRmQ4bzA3WGQybWxMaWx6VG1obDZLWUE3UnFBZ09mZ2ZlMnRiNHcyNzdv?=
 =?utf-8?B?L2wrOXkwQ3VtSFJiUGpKMWx4VHhQa1dXOU1wY3NjOTNxME40UnVTZWtPR2N2?=
 =?utf-8?B?UzZ4NHFxY3dBS2Z4dDZ5bVRlMktxL2syT1JsL3I1OFNMV1VHVmQwc2ZGdUpn?=
 =?utf-8?B?QjhaU3lwT3ZGbm5neCtqM21QdnVwaXd5USs0Ukl5ZzV6QlFkM0RIR2ViSFBy?=
 =?utf-8?B?MDVPeG5rdnJwNktwc2MwUC9NL0M5UXFyeUx4U3N0eVNXSWFwakk1T2lmMDUz?=
 =?utf-8?B?Q0lobDdQNDh0cDRmQW9SbkpMZUJ0NG9JbFczVHl1ajRjU0NDemo5NTRVcTFv?=
 =?utf-8?B?UDB2QlpBdUdDK1hwa0pPY0p0TmRzQ0phck9paC94VG1jUTAvVFF0ZUcvckpl?=
 =?utf-8?B?YWsvLzFTaThxNEFCWW5sVGI5MlR4OHcyUXE3ck5OTDhCWGV2K2YxSHI1RG1W?=
 =?utf-8?B?VW9uT2VFOGFHY1ZjbEpvTEFidkpURUp1OGVxRm5LMEZRd1NnYVhISCsyNzZ5?=
 =?utf-8?B?b3M0QVVIT1JkNitudktpQmNRSWxGd1BlenlvNDNhdGZIeUxrYWpiakRsRHNa?=
 =?utf-8?B?MGJ5NWlEVi8vcXMzbVkwT01lQkxhNVJlZU5NUHNwOHVxOEFwenBXQUhkcmlr?=
 =?utf-8?B?STc3amdVeDdQOEMrVlh2SnorSWFwY2ZpK3NCUVlac1VYRStWYzY4YjdXQlVF?=
 =?utf-8?B?eU9Nakl2K2JMdGlhVElBL2pLQkh5ZDR3SFMvM2o4NDhxand4VDZiVnhZRGJD?=
 =?utf-8?B?Lzl0eVFOYWdrc2x0QXRLZHQ3RG9UUHpJeCtZVHJJTmh5U3VRV0pjMCt5cTJR?=
 =?utf-8?B?dnE2MWFubGJWUXladGdqczZBNEhrOXBzMVhXOGl1TkN4UGx5QlU2bDIrQWFK?=
 =?utf-8?B?SE94NFBsbXVlVTFHNDAyMXhUTWlXVm1pS2NHN1UrMUlvYVJhZFROeVVlQUJi?=
 =?utf-8?B?QTd4b3dzdVB0SklOZ21VUTRQYU1HZU1ZNWZLMXhaVDdwVHo2NDE4aGdtN1Zp?=
 =?utf-8?B?K0RzbFJPTTRibmsvZlBuZzZRdGFPUy9ZOGVOMk9SNWdTL1pJWjV2aERVazFJ?=
 =?utf-8?B?Yk9SZ3Zrc2ptNVhZTnUyVEhWSGp5N0ZSVGJMQ3V3eFUrMVF6d0NraFRPczJo?=
 =?utf-8?B?eTg2b1h3am5EY2wzM3BGWXpzVFVpOGpsTXR2aFhFZVRFSk8rYUZpaFdXbGNI?=
 =?utf-8?B?SER3YzVtc2M2RVZjQU5nN1liMDBKQURRNmZQaTVHNG5qbXpacTRaRkRHeTFo?=
 =?utf-8?B?Z25GQnlBSVZ2YmtVNnBEeTZibkY3L3REa296R3A4eXRXZi9CMnFXUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1874fb46-0e59-4ca4-ed7c-08dedb642df0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:40:44.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF/9vs+JX/eDMdLGNMH+331VRe5HlpOQgkcnDfEgWQew3xhFd4A5cUKI5+oYIv7LOQbiOlD7Pis5+8JN5OKT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2886
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:linux@gurudas.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0843C711803

On Mon Jul 6, 2026 at 2:05 PM BST, Andrew Lunn wrote:
> On Sun, Jul 05, 2026 at 10:38:40PM -0700, Guru Das Srinagesh wrote:
>> Convert `use` imports to vertical layout for better readability and
>> maintainability.
>>=20
>> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
>> ---
>>  drivers/net/phy/ax88796b_rust.rs | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b=
_rust.rs
>> index 2d24628a4e58..5a21fe09bd62 100644
>> --- a/drivers/net/phy/ax88796b_rust.rs
>> +++ b/drivers/net/phy/ax88796b_rust.rs
>> @@ -5,7 +5,12 @@
>>  //!
>>  //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b=
.c)
>>  use kernel::{
>> -    net::phy::{self, reg::C22, DeviceId, Driver},
>> +    net::phy::{
>> +        self,
>> +        reg::C22,
>> +        DeviceId,
>> +        Driver, //
>> +    },
>
> A question from somebody who does not know rust. Does the order of the
> elements in the list matter?
>
> Linux has a pattern of sorting multi line lists, because it reduces
> merge conflicts. Can this list be sorted?
>
>       Andrew

This is sorted list, albeit in ASCIIbetical order instead of alphabetical. =
The
order is enforced by rustfmt. This is not optimal so in Rust style edition =
2024
it is actually recommended to use alphabetical instead, however we haven't =
opted
into that style edition yet.

Best,
Gary

