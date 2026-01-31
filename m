Return-Path: <netdev+bounces-255517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP2pGqSBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127FEC427F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2398C304DE8C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329638A9D3;
	Sat, 31 Jan 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ShvghnBF"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06F38A73C;
	Sat, 31 Jan 2026 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898341; cv=fail; b=jJ2bgueunWmQ+j5U4/gUfn/B0hsOopnNxSDP3/dhRH4Vz9YCzrMut84yK2aejFUgkfFRn/Ari+FMos+Lv1e1RXUmYCLjGbXNIOiCX6QpevsSce/KVUJ/yNAU5c5ZnaduB/Ys9Hvm6Emc6ipxvlBX4YXYmODIc1maqZe3giN6YIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898341; c=relaxed/simple;
	bh=hzDg/IcjKa8J3+EDjAyd1fOqyDA+mi6uE46KFp2YWd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYtVeQor2sJScH/0WLc+pP8cF+ZMebyXqeKKnxd6VUjxLomv0RtWEBg/VnOOazCtrl6j/mOYNeuqQH1L8Qk11l8/NiMDd73xHEeruR4+UWJRhSRYGNhyMkSQOCwjPG162gPkbtIbkoXEF+e+yfkn4WhtDZy/X5n4IlV3cdVe+7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ShvghnBF; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG62UfKzTPPFixghlMAQDBhCgvj+C0b+aPrgQ5pd1ZbuWcm4aDdy9+839/8vQAP/htXB8b6ms7yBKl2pVxQUq2fi0TAx74DxOMsNDtAR+DlBCXyhc4k3HUQZYnNcWt3LzpGKaIwxqW5WsCdy3eAnjekK//C6/CmO/QSS7m696si0RZRDZg6mAby/8Pf+C9sZKJaAn4sYKvRksnUlTX79MWut5hKb0zsIVfg01dfFIBOYWGJPeA/EVdeK/xAeTIQPVLM/lPacU3BPgDlvrATHu6ULS+B5T9uy3PeFPY9zwKwfTZYUSdT1yhvcC/amxi9DMHevSLPEJRd/kbjE5WhIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMWEZkYRrsj59SSk4PpMJ5N3Kt132lj1PcTEVbwhB2w=;
 b=NH0Y+mDdf5kzzM6JSzez0o8katkBGBCz7VQKWhvY6CKSOJFvIgNbOClThtZWJEx9jQdMILiHYyFh2GPzLhRSlkk4eH9ZrfGuqudd6BfmZMxU/GXg4MQjNQUUUevuf9L0PBao5GJfJslgiz8m1tknZCr4T2ijjgCS8SO6Ygg1w9xANraP1guzezgAbog2MhYNfsz6FXA5gq8pBeA3l7cjPsSVafPK/IXzZb6eNwDl4qYSiN9dkmrBlJIlzGQHbucdrJgtu3dlEg7new0h8cj77AYdOrQPhqVmkhd42n2BvtsoK6f+bAPm84AovudXOI67Q+BxOOWEk5ZBCiIkuLyCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMWEZkYRrsj59SSk4PpMJ5N3Kt132lj1PcTEVbwhB2w=;
 b=ShvghnBFiPBC2D72vWkoCFTMkjRPerDMTjuVwS+H25S509Y1U/P867hfTtOUR94xb3BwRvoQ/ecju3whSGkrMi+bR+byo2moYcqms6VCeloDLR7RiyUNmIeUWf69Ul4vgI/RQKI2riJ1TA1QjUkGLzQvIsYm4EyGB8f0m0ZujIA4aefBnVmCOX3fGNuD2peqTWZvf2xTteh2jrmz/+RDFbam0F6+3oUJ0dpl4d1726XU8Wc0cxR8O0vmPXe/oeIDOB8Vw4dIS7a052T/RYsXJBND61dMx5eNoe9C2LKbnW84ubU/ktuzG61hiynbec/ul12phzRS7jNQ2736Wybj5Q==
Received: from CWLP265CA0284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::32)
 by DB9PR07MB7913.eurprd07.prod.outlook.com (2603:10a6:10:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Sat, 31 Jan
 2026 22:25:35 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:401:5c:cafe::e3) by CWLP265CA0284.outlook.office365.com
 (2603:10a6:401:5c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 917402397F;
	Sun,  1 Feb 2026 00:25:33 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v13 net-next 02/15] gro: flushing when CWR is set negatively affects AccECN
Date: Sat, 31 Jan 2026 23:25:02 +0100
Message-Id: <20260131222515.8485-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B4:EE_|DB9PR07MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: ada23f1e-5c60-47c4-3413-08de6117a74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEJTWDVobVV3UWhYZmVFWUROa0N4VmJ0dEpPK0w0NWd4VXd6S2RvNE84M0kr?=
 =?utf-8?B?Ti9maWoxTTFwOTJtOHNGWmJITUZab05KeHR1Qk5vWU1UTEUydDRwenBJMHFO?=
 =?utf-8?B?MmQ1YzIyWkNrUnlKRjJoRXpoUUlvWnA0ZFg1dmtycXRrUWpuZkJuVlZsTmpk?=
 =?utf-8?B?K3NlR3F6RGpMZ2pwbnliaWUvZlVNcC9hQUVkajdtQjRGUGMxMGdyK2R0R2dD?=
 =?utf-8?B?bzZMeEFJcG5lY0ZZTFVpV3pBa1VuaWwxcDRZZWt1WUV5djdSVDhEaXhleVNo?=
 =?utf-8?B?UUdqKzVjQnRUZ0hxOVZLTHJXYmtsZEQ0dTVYV0ZPZk1OYnphcmpQSEk0dk03?=
 =?utf-8?B?TWRWTzNUQnpLODlselNzdktQUWRhMWFWNW9reEJPS3Q1MWpDK2ZJR2RIQWxD?=
 =?utf-8?B?a2RKNUpKZEVZR0V0MlExNDV0U09BQnRiTGxsby9BMkFuWFhTRFQrd3pZVExL?=
 =?utf-8?B?K0NpZ2d4M3lZcyszUlZVT3c1aWMxZFRBaGtjU1ZTYzM1M0EzWDV6Y1p6NEFE?=
 =?utf-8?B?citYcDc1TENwbDZYWkhJSEtVMk8xMmpCbHEyRWVRWjJOZzdhcEg5UlMrNXRR?=
 =?utf-8?B?R3RpQ3l2WDVITFlNbnpSS2pmWDladjczRFh5bkFUOGhTR1lwd1lWcWhIUHBn?=
 =?utf-8?B?d281YlFrYVZHNUU2T05GWW81RFdpSVdJa2pJeW1qb1JjRmdJOWxKRHpEdHk3?=
 =?utf-8?B?T3lML1FPcUJjUFFLOWpmMXpYVC9odm9telFTTlkzVEE0aS9nNlhGbXBJOU1D?=
 =?utf-8?B?OHlGTVpNOU45Mm1mcmkvSkJYV2liZWN6UCtJQmZienVtWHFWUGJ4dndIdG45?=
 =?utf-8?B?VGlrWEpRSE9JbGxzK1I3bnJaK01ZMlIrams1dmZXSW1qTjhIUGZIMjlUWFpz?=
 =?utf-8?B?eENtbExEZUh2TzVCUVluYzQxbml2UXBQRXRBMkVnZ2JNaW9VMGpNWjZZRGFD?=
 =?utf-8?B?ZksrUVc4bzc3WWxFUnJJRzlCUFZZcHpTSXRMMW9xMVpZVUZxTEtZNEo3YU1H?=
 =?utf-8?B?QzNrNFRnSkthVEJvb3ZRQTNXYXJMNDJZOWE4R1JEUlVlMUhKeVpONnVsTGFF?=
 =?utf-8?B?Q24vbmFwaGZFbVQwYlZvcnlUMDU0TXhnbVN6R2I2WStzTWRlQUoxWmM4bTN0?=
 =?utf-8?B?Y3c3V0xyUEdPakdkeU1DR044eVJXd0lwbkgwWXZLZTh5c2crN0RqL25sL2JB?=
 =?utf-8?B?Sm9WMDYyNFUxRDYwTDJycWNTeFVTclJhaDhFYmxYUi9kbmtiVkN0cjNtYjdp?=
 =?utf-8?B?WGk1RURCM0IxWDMyN2FlZHBQMEhLNGNXbkJBMi9acThrRUhiN2FPY0J0aDgw?=
 =?utf-8?B?czREQjZDVUorR3hUcWpqNEc3M3B0VE4zdVdndkVZM1hGVnJ1L0d0aUl0dDBt?=
 =?utf-8?B?ZW0xVEx3d0grYlJkcUszNkdYNi9qUzZpSDNZZFlUUmpwbEF0VUI1MWxybG94?=
 =?utf-8?B?aTJpMElzZytYc0pTcEpqR0daZTdlU2dNYXlrRmx4ZDdLVGRVbGFUZnh6UGtJ?=
 =?utf-8?B?ZURMTVNQblNjalRySW1rZ3RIWEFZWEZ4ZVkyN2pjdkUrNXc4TUVyL3N5R1ZF?=
 =?utf-8?B?VDd4QTNVWVZUWi9OYVJLeEJES2VFZEcydEFFWlhPWE93dzlFRWx0S3NGL01z?=
 =?utf-8?B?UGJ6YkJxWk9DTUdOMVJNU0RlbnJhaHNESE9CRkx5VlFzeVJiQnBFL25lbUM4?=
 =?utf-8?B?VXFFbGw3aFdlSDU4U2hSaU5wTDdxWm9FckFmZkZmUzdBWUd0eVV1OU9wZysy?=
 =?utf-8?B?T2pDVmk1WTd2MldTS0dUc3VTSFYvY00yMGpueUtwUytnbVVkTml4dXUvYzR6?=
 =?utf-8?B?L1ZDRkFobkd2VjBqMFVxaElzTElSVU1WUDVrL3Q2SmtTRmdXVWR0L1MvRDNI?=
 =?utf-8?B?NTZkOFhwVmZxNzRPdi96VVZBSlQrZU5HM093ZTB2ZGFzelNRZjhzUUlRcW40?=
 =?utf-8?B?VnRkTklRQ0FrUWFjZ0JCaW9ZalRNdElDK2hsV3A1M2lpYkhHUlpvcC9aS3px?=
 =?utf-8?B?SWo5WVh6ZXJ5WUl0Ly9qYm5vMFRRSithR25xdWg3UnZKYjd5R1JsNldGWEc2?=
 =?utf-8?B?SW5MSnpuMklxb3lrUVlPcXM1bElRNnQ2b0wwR3BKektyeWlZZ1cweXd5TXBK?=
 =?utf-8?B?ZTR4SVJXT2dRTTBQQ0pvZXE0K0hzVXVvUG5TbkdSNTNhSXYwWFU0OEhzWEhF?=
 =?utf-8?B?cUp3alNHWUQzMUNuYnpUNU5QZXhiKzU5RGFqcVY3Vmg3UzdQSnp4NmdCQWF3?=
 =?utf-8?Q?jRC6qIrLcMgurBtUg37DRYZ5+uDkO+UAnK3SnRW3RU=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OJfQyzMbKbbcLEhUuEOHVvMGVgS3rsJqj9mbJIjB4J5OnmewMnclQ1e/RftTAQ7Kj33cDxNJZ5DSe50ZiuY+zHkHEgkdiip+KJ8BSeljeVekVv85LY/wtDQwL7eVae5V83OZc8AxIBq9wuSyDQg6XVbIDAogY/tNrFYk6Lbne4usCl4iLnggP+zfCxjARtZz25SguQ2+V543teAWbvA4ec4RZ/12o1LXzR67/tO8qjgOTdpJA7qMSw8WFiDEwvLyfhUrHa/G6U390rVDsjZFp2hneis8oZm6a+QKTuoB+b2GvI1x7yrOe/yY36kyNL2XGw07EnqkKr34wc86VUgzv8qkxEIrhAJSBI73V90aWDozO9tXV4iD8CXKFBOB6mqPsPczQDK5vKkYQ5RZ/90h0tc3IWoOx5YclFOHP8MbQbMpSFcpXNVe2uGmYmsYL8xB
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:35.1361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada23f1e-5c60-47c4-3413-08de6117a74d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255517-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 127FEC427F
X-Rspamd-Action: no action

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 942a948f1a31..3b1fdcd3cb29 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -304,8 +304,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


