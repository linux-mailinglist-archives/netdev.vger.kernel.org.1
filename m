Return-Path: <netdev+bounces-305137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XPp9DUbbS2oPbgEAu9opvQ
	(envelope-from <netdev+bounces-305137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB19713708
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=nseFC01E;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305137-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305137-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2505315C7A8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B476422524;
	Mon,  6 Jul 2026 16:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60E3F8231;
	Mon,  6 Jul 2026 16:15:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354531; cv=fail; b=laNxoCj03c8mNDXASiDQyAU4C/WinIVPjcL8FYsUWKvl5QpomWiEnM0phzZR5kYYDPmjVPpmiPFpXpl9EYmfBjouvX3CiKEU28/8cJ22kSAZUcyOMInisz1f8N9lHTBO/h18PfzxbJSGAs+qXq9E8MM849g1rEnsyLEx0r7/jeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354531; c=relaxed/simple;
	bh=UP5QP7BNwvUJ7os6lIAAFxZ9ZZCcEfPxRy+ibtt6WZc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=L8wb2lgYYmbaymmXKcBKEfq55i+pzKjg26uOIbe0KtPi1jslGR10Vz7uuIhFg5v5VKtUyinPoMbOmPMHAbztfzHLrtkp+d8kxSar2V6S3kfgBVVKIA0UVH+MrrOp5Lv9ZFK6W2vHvdOTg8i1eaf53xOuDHz5HhhYiL3xQDf6RuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nseFC01E; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei7Sm3meHbuYacbPQHvXJwhwEO/9cC/mYOm8/bxolghy2EOm5sIC/OTCCO04FeQ2kaa0DNDYsfV4+rMlRN4Jw2aX2g2wNKUD5pYKE6PFLeTQuBtN9eaZj6iOsnbdh5HNklzPbImGdHorpLkBixZNcyl2HTZLeuiUmzumFyaALOPoi8GiDa0CdSPiyT665xJSiXoxijN++v4Hh98TEbBrgjkzpE9r9SmDBCjGEhu3VHfB5QKPvt66hiTdFbzOeJXVYDHdKopjUNmKgV7Toypk+ZW7bfVZvF8HQ+3GqA0yAsqUx73RDPlRG0NSKkhphZxgKubhVmpLT7I7QverowypcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP5QP7BNwvUJ7os6lIAAFxZ9ZZCcEfPxRy+ibtt6WZc=;
 b=xLvfOuAMXz3F9G55Is4dtDotC5TQ8Bj2nnRyFRngZ7PKh8dAMT9T57CL3d+YMBb5nlpb3uCfTQ5qfDAyq1zjeRp1slzvpaLBtWCatrZsaM/0KcIDIvKLJRy3OvD4OrUoj4pDr/yXKIv/W+9w0yTJcY5gurEKt/rko/4+GkcLmvZnIG2r3mTLswjz1AK0mErxUaQQxS6LXPAWyLIe9G2u+WyooqqrZ62PbH6vcjTn56pOTQUQykv6qB2j+cNPJx0BqgNwzqHDOANwljtZVpD3tpZKMe/8e9TTyaeADWW+PSi31+dwQH3giphgEuF3V8FXwcOGRIGtm0Yc6Wr5BnfrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP5QP7BNwvUJ7os6lIAAFxZ9ZZCcEfPxRy+ibtt6WZc=;
 b=nseFC01ExlxpBPaW7SH8n8XGS0+ZoDzDEwjd3nJGRQhEq58OVcWOGdt80s+VkziuqaoXNOLT0MsBVGSqy9rFMrMYliaqBlZziY6ALQFRinOUuiEno04S+/d3LC7j7bG0RDvOE9O5gg7U+ZBph05QGg7TJwPR0xW4thFTmwVgz3g=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5304.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 16:15:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 16:15:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 17:15:25 +0100
Message-Id: <DJRMF2RTW8QD.1NAXB4C3AX9EU@garyguo.net>
Subject: Re: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import
 style
From: "Gary Guo" <gary@garyguo.net>
To: "Andrew Lunn" <andrew@lunn.ch>, "Gary Guo" <gary@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Guru Das Srinagesh"
 <linux@gurudas.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev>
 <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
 <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net>
 <c1d24c8b-1c1d-4784-88a6-3cbb519d0406@lunn.ch>
In-Reply-To: <c1d24c8b-1c1d-4784-88a6-3cbb519d0406@lunn.ch>
X-ClientProxiedBy: LO3P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3fe636-ac28-45d7-c00a-08dedb79c9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	YmDTSB+dOU0ENWjIj0NSLCFVKzd06m7lnJjtC2TvJ5u5hucLpmqn38JkiI2ETmL9fWSg8WDGq/eJyeLW948Kb876JwyQHE68pqpar1xkHUpcLE986oP38azsgxr3ULd8s5CKNHzC5qiSArfgHlus3iaTWPDNpzsp1PTel6cgTCY8uN53bfiTSMmAukAQ/FIIHMJqoeHyOkpP8N5ncAkpACo8EEkpR2qHNdYv+MPYVLIYdA3n+qzsaLCENfma74xq8ELmMEpJxgFWQkN5sDBk3l97qwMgSSGV22GVBnZt15eiac58S6rmR1wzjxG0Gz256R35BJ/ehUvgsbwmssxwrL19ki1ZQczlvFmLQGo2D6OwNdphfEDABMInHfH+ozYZmKn2+FGzC/SXulrrfxu5tKWf5jQgq9f8dxBKT/AjtfQSMBS8w65umWbsIGv2MWbyG8r3Lj50Lk+5PdsqKSZE6lciy09rLfU7o/vvi5Cx5fh4O1O1PfAli/mDcMcUx+BQnKGSZgOqzqkGWE4vzCyl+lhC2ZqpBt4OpfwXUVj26/KejLTOvTxAWlPLZETJdcVOfz05gZHRy1IjuiurBt3olA9EgiuwSasIPkfAeqR0jxRktpFolrjqJOMrJpXzADbFX5Xuh1hT48nyll4yemENpJTcbghlYMH4N27u0bPOmUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkYyYW5YV1hoR0QyUTk5dmtoWWJMOGVQWnljY3l4WE5HdGhqSktwUDAyamdz?=
 =?utf-8?B?YU95bDZFa1JFYWk2SitJZDJvWE5IRFVNUGQ4U2JQQ2RkTmh3UFRrOFJIZFBn?=
 =?utf-8?B?NDZ0dTh0VGptWi8xU3BvZE1DME14QzVyZ1hmSll2TXJvRmdWekpuanNrejQy?=
 =?utf-8?B?eHhMWTlYSnkyaDQ2Z2FQc1lvS1dxTmtWc0ZwYUthTERHc1dvNjFKUnBCM2wy?=
 =?utf-8?B?b0dzbExhWjIrQ1BWOHViVGE0SDNKY2hBQStmbEdJcU5NNVpiVkNURjNnZW9x?=
 =?utf-8?B?RGVBREVzNUZjZkwyS0doNFRaRkJiNVVMdUZDT0Z3Z1FYVkVjR004OXgxVkdq?=
 =?utf-8?B?b1pHRXlRb3J5azlOVGEwMThhSllCcnBHK21XRTN4ZEg1b0g4amdQUFB3L2N3?=
 =?utf-8?B?ektLV1g2WHJFUUFPRHJiQlIyOVVjQ2NmVTBucHVhOWRORjV3WkR2Z0cwS1VR?=
 =?utf-8?B?b0Q3RCtodHFHaGdUaHBFL0ZpOVJLck9sUGVCVGpQbnJqU0pOL3dVVFVxcGww?=
 =?utf-8?B?Ulp4UFFyKzliV0t0c1ZjcVdnNThKZWlRTTBtc2lvZC9WUXVldFBGMUI0SEF2?=
 =?utf-8?B?U25mNkZUMkdQK0ZkZWhQeWU5TU9JY2Vid3JnbWhOWXVEU0pMSXR1K0hMNHdz?=
 =?utf-8?B?ZVFhejU1aCt6UU5FMFNQZW9SUXVsL3BNZ2VhbU5SSXBWcGlHT0xmTFNSd3o3?=
 =?utf-8?B?aHlISVJGeDFzRXZlOEZZdm04SkExNXFwMDVBQWVHMWJYdDJ6bjV4YzFOc1oy?=
 =?utf-8?B?OThoUHY5TDdtZmFUdFBLK200VmJvT0RVYkpLdmxTSlhwbk5IbTJJR2pBQUgz?=
 =?utf-8?B?MFFXR0VsVytrS1lacE9WU1pHWDRJOEk1TytKM29DcDYzRVRCNjIvUC92dkVH?=
 =?utf-8?B?UlpUdzU4Z2grYkdIR21PV0x0VVhvNTNjYVpmMytEaHhyM1RhdUhzUnJaMXVa?=
 =?utf-8?B?VXAwMEpmRUJYd0NaMzErWnN5OWo4QktoeEVRMWNjem4xWitISHZvSnBXMVJF?=
 =?utf-8?B?UHBhLzNad0NaUDF6T1puamo3L1BHQ0x5MDM3WngwRVM4ZGVIMWVmMmNPLzds?=
 =?utf-8?B?Sm5wOElrYXZsWTlXR1JWREhvamdSS3RPb0lPb2pYbDl2WFlKSFQ2L2ZzanNV?=
 =?utf-8?B?eVRsYm1BM2hpZmxkbVJ4aWsrN0JaZXUxWkhuZytpZC9MNnVMN2llYXBqR0RK?=
 =?utf-8?B?SW9QZWFsRDJSbVdYNVZ2eXM1eUhyZmNxUUhaeWtpbllUUUtIMHhBM2srdHhH?=
 =?utf-8?B?djI4R1dGUll3cjduaHQwcjd5OVBGTWgxVlY4NFJRTlBUWlVrYksrN1JmTk03?=
 =?utf-8?B?Zml2RTc1eXYvdmkycU9sYWljK0F2UXYzQ1Jhc0c2MXgxcmxSYmloT2ZPdEZT?=
 =?utf-8?B?c3FnYnF4czh4SVNsVklhcHRpUVpKWjZOaUE3VzBBNFNKYy9ZZXVMUDRwRjh1?=
 =?utf-8?B?akZCUm9kVDlmWmxjQUE0NERIM2RtT1hEb1NsaWQ2bXlYN2l2MTZlS1libktN?=
 =?utf-8?B?aXZGTHg0V3crZUdRV3hSUE12bmVZSEp0WDN0bmlnaWpMWFhnTncrMlhqTURQ?=
 =?utf-8?B?ckd3RHBTNnpCbWdZVVovdHQ3eE1QbEEzN1gvWUt4QnhCZnZWeWJzSThpclBw?=
 =?utf-8?B?QTl5MFhBcVJnbExkRzR3bDVCMmZUS0g3Y2dRWlplcFVITTdpTnlJZTlhaTJV?=
 =?utf-8?B?Rk1IeEtCWFBoV2tDSUtUamZOaVh0YVNZcHluV3E4bDNuSkF4NkplUlRoVGI4?=
 =?utf-8?B?Qit1akdSV1M2S1psak5UazJ0NEIyVi90aWorT1VHYkFWTGx6MWppYkVqUjR5?=
 =?utf-8?B?b3M4WmtCZUgrK2ROeVQvTjFIM3hWTjVEMjdHNkJEeU9JWVZaZnB4NmJ3aTgv?=
 =?utf-8?B?MXBXVWlwVHN6dE9IbXFMNndoZHM5VkZTMXJyQS94a3U4d2xIczJ2d25BNUdG?=
 =?utf-8?B?cW5HVmhvRVo0QWNVd2xDdVYvWC9hcmZpSFE0UEExV2ZhaldjY1BHYmRRNXZG?=
 =?utf-8?B?OHdmZGpTV3FyZlFZL3RaSmRCRVlhUmptbTUzWVg5eklzMGVraVNObjVNOTR2?=
 =?utf-8?B?VU9mSHczK0JqYnIrcmxyREY1UGdyZGcxWjJ2NUF2Q0Exd2ZZdW1TeWV5Z0th?=
 =?utf-8?B?M1RQR1dWcGN2d0lZaVQ2Qy92QUhJUmhLZ1RQMHU3UkRaZVBQRHMrYXZRYjZz?=
 =?utf-8?B?RTRxS2ZFWCthbkNSaXN4WEE3bFhuZHZ2TXdCcThZWVpNMnJYSEVjcjg5SnpJ?=
 =?utf-8?B?Yk90elYxUm5vL0dOT3gyTFljK0ZpNEZMb292Sm8zZHdEYTJOeWN3K05WeS9Z?=
 =?utf-8?B?Nmc0RURKbG5aWlBHVGlMcUZOTmpSM0ZycDNSdUVIZlBBVzJZZzBmZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3fe636-ac28-45d7-c00a-08dedb79c9af
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:15:25.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThjNpF9iKbuhnHwtPqec4H5NMKkcKIuJzLoS4yjvrwZOCI1eGBfvzw41M9iWPjuXhW/VtiTMWxIiTOEC48no/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5304
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:gary@garyguo.net,m:ojeda@kernel.org,m:linux@gurudas.dev,m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gurudas.dev,gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AB19713708

On Mon Jul 6, 2026 at 4:51 PM BST, Andrew Lunn wrote:
>> This is one of the quirks of rustfmt. Before style edition 2024, if an
>> identifier is all caps, it sorts it after non-all-caps identifiers. The
>> motivation was to ensure constants are ordered after types, however for =
things
>> like C45 it is actually a type, causing this weirdness.
>
> How often does the style edition change? Is there a 2026? How much
> changes in each one?

So far it has only changed once, with the only major change being the ident=
ifier
sorting that we discussed.

Rustfmt has quite strict backward compatibility, so misformatted code stays
misformatted. They use editions as boundaries to do bugfixes/improvements t=
hat
can re-format previously badly formatted code. There'll be new editions com=
ing
but I don't expect it to be as major as 2026.

> At least in netdev, we tend to reject checkpatch.pl patches, which are
> mostly about style, unless they are part of a patchset adding new
> features. Style patches are mostly a waste of reviewer/maintainer
> time, because some actually break stuff, so need to be reviewed just
> as much as code adding new features. But style changes have a low ROI.
>
> So while there is currently not much rust code in the kernel, making
> style changes is not wasting too much reviewer/maintainer time, but as
> the amount of rust code goes up, you might see some subsystems
> rejecting such changes, or wanting to pin to a specific style edition,
> to reduce churn.

We can control what edition of rustfmt we use (even per subsystem level). S=
o
there's no obligation to bump edition unless we want to do it (e.g. it form=
ats
certain code better).

That said, like Miguel said, this can be pretty trivially reformatted treew=
ide.

Best,
Gary

