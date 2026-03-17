Return-Path: <netdev+bounces-268716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOBHLMimuWkhLwIAu9opvQ
	(envelope-from <netdev+bounces-268716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:08:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1432B15D7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8C133051CBE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DA3F7AA2;
	Tue, 17 Mar 2026 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="qFrbO2il"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021085.outbound.protection.outlook.com [52.101.52.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339637FF5F;
	Tue, 17 Mar 2026 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774521; cv=fail; b=Wyr+bsftmqZqdOuId4lvcojfP/Fdo8kOpj2dO3WhX753QpriSkMXblKvJOeAwY4LGQOnjKqpGDZ0NLMjN26uy43omgNwBCpkHTJ4hy/404gm5ixZQndMvrG93sSIYO6gJRoe5ih70wvxa/OpBKpybPv3DVXE5QRpJvCS1GiXsic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774521; c=relaxed/simple;
	bh=y2bI4us75ajyty3ADhL9dYSoXmU+VwlTbWRPQIUQDzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fv+8HLNRlrrGfrGfMz/gH2LGM6U69ZWcKQByYkYOjKwjUYO5LXDHBZvQdehNZooDYx3UL4SeERaoYU//1de+2F1lPFfC938JEZu3nJRPgQm9tstWTefJcTi0oeRvaDsmDYiJ0ojnSHKu/9d6ufEhDkBNCpPAFqZj4aH+6o6JQTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=qFrbO2il reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.52.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Okguc+N8qyX/DX+T2wB7QA0QFDC0v3acKq3aMoe/yKBwIVlsD4O19Y1a0elQQfQ6nnn5H6GC4U/3gicQb1UuW9RsNXuHii83E7Rt72KIgk9MDfc49KT4as30T8S8gGBYpzqU18L2p0FNOdijhFbprk3ZxU/FCDtmyLqhJzbzIfivuH8C6ZalxwK8BG1UYeLG/8U2DsCKy9na5vrOj0Qgwg2X4yUjZVVV7Wkz7Ni/ihQDuY3XMlbK6n1hxjbpUdJSY7uS7syvMelCK6CJG0zNXnerqCim19DTwRQT1vJFMqAs5lfCuuh3MxhGeQ+n9Do1mGpEZOI4pjzqw/WDdZdNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC3KsgVLubMNKu820n2WFfzE9E5lPqlvWbScn4Xvf1w=;
 b=rqIlru5W28JQzTRaZmHVgPPUHvlSww6QXjATBaTu68kOV42jUOlu36iqibHXZUS7f3KmbMs8dDZbab75lvqaZApYeclasyY+qSj2ZpoOZ+AyJDEW8gCy+Ns2WQExwzjOktw6G2gUddcgOA4NBOvBRiK/BMNKSqEWwKMzJHw4LzEERbkuMmumceP5I0Rbbk1Lk8k3h+w0rzmmcCXFctSNn5ASufGlsuDaKKsSmtrulQiFg6NHNZhxb6uXTFNzoQ1nPCHi9e9gbIzRoYNYENcewHF1NKqMpt+oZMKFYgL5Le3FDsuCFGS6BBnX8NSIOfOzKKb9c2IFZjuYLSaUO7ob/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC3KsgVLubMNKu820n2WFfzE9E5lPqlvWbScn4Xvf1w=;
 b=qFrbO2ilN+sItiyBwjQD5yubOWP7uUCxAR2r7JVe8EYjXMK1tP0oe3y+e/TrlY21uDCtu+rIndjo2bR/UbL6AFX2hmEJGNxlsYQH2seqFB2r1pkmYsm8AK/8nHmDwvmxHuhhzlVzg/kqXsTNKezy5CtqO5IsQitSsMlVlADEdqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB7264.prod.exchangelabs.com (2603:10b6:806:1f3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 19:08:31 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:08:29 +0000
Message-ID: <d71ef30e-e382-40e9-8592-3ef749bb05f3@amperemail.onmicrosoft.com>
Date: Tue, 17 Mar 2026 15:08:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v33 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260316035626.363698-1-admiyo@os.amperecomputing.com>
 <20260316035626.363698-2-admiyo@os.amperecomputing.com>
 <73277cce3afbc784f3aeed69da3c39a0659d562f.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <73277cce3afbc784f3aeed69da3c39a0659d562f.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:40::18) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d24909-7510-4508-984b-08de845892d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CFupJOkW2Hy7HBjOq55Q6BwBz8pgcxQNVpejquByQswBOiFBrc0g5Edsg2l3OMco5MJHemJ57luLlWwCnybqOKJMND1cOSH+NZLXY3dwZsa/cLa/jo9epNgp1zGLBj/pkmzSVnIGJsdLeanEy1uDH2VOQ2ryw8pEhlaxNtzHnu9ZDJwtiA1BFmWWjR1Kiw1fW2La3qxv1r55X49LKNqy4dYtqekEvYESQ7B29qe8UrVLs0ZGuNdD6THW/k03sHU4bVhZp/q4XvZxgNXI9IseC9siySTkdRDIf6cPut0mn2vCbKH5u4fAE9Y5rinByvebBgVGWF+GRKlCFISdkd9qf/p7zc9XzoQO+58G3SQ77NSvoecYJvFMD8THRsnlt3qmSaK/cM8bRdvgQCD/HpNDvyrtpQk9ZO7zPDGjQpSOy/cFf74DC07+yJ0BV7KcPQLfMYbCosJyNA/7tQ7h3o7UupAJnDCKR9e7K+O2sHdqUAjHvkED8F7Kjuyif0RAf/MU4QnJMhZHQyUgjyGt3XlWmlsjpnqR/m6e98RQv7mykf2pYzDIfDLkVk3EYK7pqA3LFZGZGbKIi31WU2J+2e3FK3qyiymkMlf54mEN+d3VmexQRq2loT10maYSWCgtj/ElNpdOuopbkU6985Y78mFguy7ds5nm3I+dZQyL692wGrZWmGMjNG9xmXLQw/Tuo0xcTd+DMDQIbBoj6ZHQdmC+S0XltnuK2UnSdDZGmZAftjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJHNUh5aU5SOUJNTHFjRXNuVVVQdTV2K00wK0pkVDhqNytWWUlrY3VXNDJs?=
 =?utf-8?B?QjdMbFlZUnVvd09zUlIvb0t3NXFUYXhmbU9uTmdVbENWZ1ZPM0VrWDVDSlRs?=
 =?utf-8?B?anZvN1lVbzk0bUx0dlJkd3Q1T0FpN2NWUEI4M0ZDbTN1cDRwRFNBV2pzbFFS?=
 =?utf-8?B?bjRDUWgzc09IMlFCTWJrTllNQ2VwUFd2eS9nOHRia1FCSTlpcGw4a0xKVis3?=
 =?utf-8?B?Qk5UbVFYQUpObFMwSlZhVHMyM0IyS3dqTnNOTnk2Nzd1akNrbG9FbGw4T25D?=
 =?utf-8?B?UFhvKzZTT1F2NlJWaFRjT3g0bTRSSmJFMGxUU3hXMzRYSGNYcTVPUVZ3YzZK?=
 =?utf-8?B?VGIxMXQvVUQxdE5nRExLL2FuODNGVkJQaHJ6OVU1NWRPeDFJa3V2WVpmSlk3?=
 =?utf-8?B?S3RyV2JqVFAvcFpDVzhjWC8vYUxkajVVcTZtRjRoSDZaZGVJZzVvelNlb1Ir?=
 =?utf-8?B?NVMzcm93SEI2Y29CZWVtVGl4YXp4UEtDbmNFTlc3dGN4cmc4L1BpaGNXa1pW?=
 =?utf-8?B?TWNvSkZGdXl6L3BSRDZEMWZjUUhoL2tGVEJ1ZlFUUEhNYlZVcjdzNHBMYXJV?=
 =?utf-8?B?UDIyclhxOWh0ZThJZEUybkcwV2xEOUhRRVhGNVEvQVJlNVhWbCtZSUVtNW9E?=
 =?utf-8?B?eVJvOWpkT3NDQVZSL3ljNFcxTlNZWm1ERnI0VWpmNmxGejA5d1MrdzZ1SW1s?=
 =?utf-8?B?QnRzejIyUGx4MUdXOWlvSFVHUUw5WUU3eTFBRnhYN0VuN2tqSGsyQW1RVTRy?=
 =?utf-8?B?Tko5R1VZOTRZdUlObGE4QmNab3dvWXFHNUNJVWhWalh0RWhJN1p2c1V0N09G?=
 =?utf-8?B?SDRIcHdnRSt5c0lGeXZ3anFnYUZsRVNqaWdCV1dqK01peUxrakwwczRnYUtl?=
 =?utf-8?B?NlZBMk9idkdIQW40VXhhV3hDaVhXb0lSazZEUnduS1c3Z05abXduRG9SUTlO?=
 =?utf-8?B?OWIxU2Q5NG1zVWxmbWRsWWRQT3BaSnBvQ21RWm9CK0hBL3pTclYzVElpbis2?=
 =?utf-8?B?SS9KVExPRVcvM1g4RjJ4cC9WRWpMUXBRbFd3NHJneW4yMkpLMmg4SVBORVUz?=
 =?utf-8?B?eWpKSjZ0SVJDRmRpMzFkQWlFZHhScm9jcnRpRWpZQUg5NzRCTk5qMWQ4Y0Vq?=
 =?utf-8?B?TDA1S2JYUDkyVXVXS2l3VHd6S3lPOE5CQWF4Rmg3ZUhudFpBWStBcnZ0dnhK?=
 =?utf-8?B?Y1M4ZjZiRldka0k4c3VuU0FCVTUwL0xYSDFCZzRXaFo2WnhlWCtKYkpRdTM3?=
 =?utf-8?B?WE15Z3ZZdHJOQUZDdWNlQmFTa3RBektWV2xjZVpVSzErYzVnbVNiQ3FDL0Ir?=
 =?utf-8?B?N216Y1hnRDZiQzBXUXZBRy9wUFB1dGozV2hxaG5KdlVJYUJ5UTZTZExDaGdy?=
 =?utf-8?B?QmFMUGdRcS9jZFJoaHFNY0ZPcW1SenltMlNtYjlab3RtbEF5WEU1MGI5cndo?=
 =?utf-8?B?MXB6RWFhalpDOU9BUGtNaHNSMUhURVVLcEJHUFdxYklhVmRWRWZVSU04ZkRX?=
 =?utf-8?B?QWo4ekJEQUo2dmxOSnMxa1N1VGZxbHZEc1NUUHZmSk82QnU5M3RYS1U1NHRa?=
 =?utf-8?B?UHp5RiszbXIyQUhRTTBHOTZ4SVRGSVNWRUR4Y29wcy95Q2tvaU1rcUJVSEIx?=
 =?utf-8?B?elAzY1RObzBwaHQ2U0lQNmVqQlNXMUlpb1llM292dER0aHRvR29LMndHdThW?=
 =?utf-8?B?ZXBpcWVVZlo5MktBMlNYNk5RbG1MaUx4d3VFak91RWZsOW9mK2dPUVR6eGFi?=
 =?utf-8?B?Mk43RGFTK3ZBL3ZOeERDQXFhaG5KTFFZS0pXeUFxYU1CNzB5cmJsaXB3b0lE?=
 =?utf-8?B?TFpGS0ZwaDZ5NllNdXZ1d0R6TUJmVHlJYUN3YUVTdm5mYUd1MkJLWTF6M2xF?=
 =?utf-8?B?Z05yMmpORW1vZXhDMXlFcFF3ZFRBMlE0bVdIUUhWSE9WZ2c4d0JVbjRGWERz?=
 =?utf-8?B?WUlrRHBodG43bTkwTjlRcWd0RFM1NjQxZG4vTG1mMVZkVWFJbnp2WEd4VnBm?=
 =?utf-8?B?WVZXRVZ1em1lcHgyV0k2TVBHRlk4OXpqb1hsdlE0VVJLZ1EyRkwwd3EvYUZC?=
 =?utf-8?B?UTgrbkFza3pmajdNTFlKVWRPSHMzOEdaNXBMS0lWUGN2emRhbE9jN1k4L1lC?=
 =?utf-8?B?Zm9INnNwS3d2R2lxeXZIbG96QUpxR0JpQXpqaDZrM2x6L09FZUNaRGxKK09I?=
 =?utf-8?B?emdFdzA3UnNQUGw5MCtmcDlveWdqM3ltbTVSaThmV0l4TGNMeXl4YW1vS0Nl?=
 =?utf-8?B?L2JZc1hiZ0NoaVVXS2RNM2k1NDFvMkxndDlTeHFEMk9hQkljM3l2WjdUS0xQ?=
 =?utf-8?B?QUNOcUU5QWhSaVpRc3FGb1pSaVJ4cDdzLy9iODFBVzY4dDFXOWFWK1lGT1VD?=
 =?utf-8?Q?+1XqOwOhTqdMpxrfL9zifdNLbzcrEFg4VJ4Vfvk+ylqT0?=
X-MS-Exchange-AntiSpam-MessageData-1:
	nFpy3skPm5LsDm7qB4cwH7c9FrkVVxV3mlkKvO683byaamwgovDs64cE
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d24909-7510-4508-984b-08de845892d5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:08:29.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBio3bEL3gQ1jemVfc0FTH5Y1JMkgXH47sLhJIhKk1eCHB5yP9RcLnFfsXdbM7MIoGSJWcY0CAKY9ivakWyeVrpAb8Eo7n+vOeHjRe+Q+Fgofta2HOZ2gGAPnx3G0TbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7264
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268716-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.811];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: 1D1432B15D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/17/26 00:51, Jeremy Kerr wrote:
> Hi Adam,
>
> Some comments inline.
>
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *inbox;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       int size;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +       memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>> +       size = pcc_header.length - sizeof(u32);
> Since size is signed, this may be negative...

Which would be a sign that something is wrong, and thus that should be 
handled as well.  OK. Will do.


>
> (also, why sizeof(u32) here? from the spec, it seems like you're
> trimming the signature here, so MCTP_SIGNATURE_LENGTH would be more
> appropriate? or sizeof(pcc_header.command)?)

command is the right option.  I think I have just copied this around so 
many places where it is renamed that I mentally have just gone with the 
underlying size, but explicitly it is the command size.



>
>> +
>> +       if (size == 0)
>> +               return;
> ... which won't get picked up here
>
>> +
>> +       if (strncmp((unsigned char *)&pcc_header.command, MCTP_SIGNATURE, 4) != 0) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
> We shouldn't really be treating the signature as a string, just memcmp()
> instead of strncmp(). You could also consider using a u32 (appropriately
> commented) instead of the string for MCTP_SIGNATURE, and doing a direct
> comparison with pcc_header.command.
>
> 4 -> MCTP_SIGNATURE_LENGTH, or whatever you chose for the above.

I think I like the memcmp option, as it is defined by the ASCII string.



>
>> +
>> +       if (size > mctp_pcc_ndev->ndev->mtu)
>> +               dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
> (I assume we're fine to receive larger-than-MTU packets, in which
> case probably don't need the dev_dbg?)
They get dropped by the MCTP layer in the Kernel, apparently, so the 
dev-dbg is to help someone debug why.
PCC currently lacks a negotiation mechanism for setting a larger MTU, so 
we are setting it manually, as our backend uses a non-standard size.

>
>> +
>> +       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> ... with the negative size, this will end up as a huge attempted
> allocation here.
>
> Maybe change the above check for pcc_header.length > sizeof(whatever),
> instead of subtracting the sizeof() first, so you cannot underflow.
> Then, use an unsigned type for size.

Yeah, there is certainly some better logic for this.


>
>> +       if (!skb) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
>> +       skb_put(skb, size);
>> +       skb->protocol = htons(ETH_P_MCTP);
>> +       memcpy_fromio(skb->data, inbox->chan->shmem + sizeof(pcc_header),
>> +                     size);
> Minor: This seems oddly-wrapped, as you have longer lines above.
I was trying to get everything down to under 80.  Looks like I missed 
some above, but this section had my attention.
>
>> +       dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
> Your RX stats do not include the PCC header, but your TX stats do.
>
> I would suggest making the SKB layout consistent (ie., presence of the
> transport header) across TX and RX. Include the pcc header in
> the RX skb data (which you do in the TX path), and use skb->len for both
> TX and RX accounting.

Again, a vestige of debugging the disappearing packets which was due to 
exceeding the MTU, but since stats don't effect that, I can add it back in.

I'll get this....Thanks so much for your patience and diligence.


>
> Cheers,
>
>
> Jeremy

