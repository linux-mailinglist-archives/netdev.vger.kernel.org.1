Return-Path: <netdev+bounces-254296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAoAD+wfemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:40:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6EA2F9F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D4AA303A92D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599F361644;
	Wed, 28 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="B2H2/Ejo"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A3359FAA;
	Wed, 28 Jan 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610911; cv=fail; b=UYGgjMREKhRJH6YlSsx3Mnpx43pAHscOqFgXtHyczbNPzapwi/EmYZCx2t+OOWgBJ8BcijrpslwU290A27du2B72EUAC/sTCR/tKbeTtaWgDBoEj/L+rOMZnz5hMuJKsgabruenFQ8kAdbd47kTNg6uN3AWQ/BPUCufsm+uLEg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610911; c=relaxed/simple;
	bh=KTf8Q9CQcPUMQQLmoQ5u81rk3noWRcWUTroiJqZNLF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCUU5mKre7sYPOm57XDvvdiD5l7fbxbLa+Fppe4WBLGDcHjHkVWkhWXKfJ7YKxPjWKwyDi5PAd+A4/rA99kE/qP93Ofk5NQAIQZ7R+31Bogk0iSPlCDk825v5Z5jX5bdkqoxBd9JSmKnkGmqCB7d6H8zxIhfHZOmy1/x5vA7N88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=B2H2/Ejo; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QARrRbT2Xw/MoD1zHD3D8dt3Pr2OvlxjINxHCjNHc1x0HuRxqlNnFcfvfFjDUkPInQXRzyv44HLDalW3feW+debpc4FiWr4IZ6qpBaj7+sjacIMTOmiBogBzp9ocGt4Tvdy1RQp47y5rbhD45M6twwxeaKTY01pvjBSfc0/Nrwo/IjNMeb8p1SLas15Qn/Tha5OrYpXxg/V6IoMMtXGyE0o9N0YyfLgGxWaFiHlspSsB2wh9IrAK4SuFdU3RQvpomYUJRg7pNO7uSbjA5RO0v1KzqB0ly5GHmDfw/OOKAC39P0d5y1cJ0HZTqXsW3OqPcweXySBU6nEdQ+AQBk5YFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1jIO5JCbz6bw+e9destp2P300pOskm9/vZvAWNarMY=;
 b=i/jYxJPin9+M2egicLNlP2MHDzegxukUpkgUCsCjsJGcxKB7ct40dBiB4/WNP8ExU4ASFI9bekWwhWWZSvcFxB18oa/aQmv5l/73AB8wVZe8TdkhOSHb46Btw0xK5jelb67cn+cHNwOzgKs2C1Elk/YE5A/mq//tp3yNL7mn57MHw1tsHWOr/DWipytaUl/zGrFFD5i/Bqvu1VmX8qwXh/gsIezxXEJAzdz2wlxmee9ICIRdAxhQ9rGQbL59I0saRCs7rbNKtGoyDUVsqzFw2NnVt18zH4zGXRSmMZ4P/qiCiqMdKR66QW/rYp0Cpvpeh8Zgq+XQkELNYCso37lWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1jIO5JCbz6bw+e9destp2P300pOskm9/vZvAWNarMY=;
 b=B2H2/Ejo1cIzZlmuclVtejVsuG7mrIL8FBUpwE/yfoySgfd+VPbPKlbyz4Ow37i7nhaNw1FzhONUh15iF6WCSL0SdVF3UfvWBPAUrTKqQh0879LxxL8mFcyAp4lnuNWTkw4WN4C+hxeERrkS/B7LBfuiou+rF83T9NAQwjyjREjhN1xLHUuTZNUgBTftH917IVTltT//kFw+2tSzNbSObwxyinscrxDvAbktRj7KslKAwPEtWLj6aBeRn8x2jZ4bRAYMoHqaD4FyGZ445sUW16BSSkCZsyHYi4c8SMZy9lhzKodebAfcDToIDy1dIDpCnBs25qDJeeEFpcgU3xAa5w==
Received: from AS4P195CA0033.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::20)
 by AS5PR07MB10108.eurprd07.prod.outlook.com (2603:10a6:20b:676::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Wed, 28 Jan
 2026 14:34:48 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::67) by AS4P195CA0033.outlook.office365.com
 (2603:10a6:20b:65a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2C8EE23649;
	Wed, 28 Jan 2026 16:34:46 +0200 (EET)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v12 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Wed, 28 Jan 2026 15:34:24 +0100
Message-Id: <20260128143435.15708-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|AS5PR07MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c821f3-e79b-431d-9f1a-08de5e7a6349
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aWk1UHRNSTFSRHlScTFWdzdYWDEwdlQzcjh6WUE4VUFkS2NIdTlnSE9hRGdX?=
 =?utf-8?B?RFJVWEExakhnUy84NEpQb3ZJdkRpVHhHZ1ZmenBqMDFxRGpOakRpVWdDM1F3?=
 =?utf-8?B?NW1hSFBsNGllbjBMRGwyRG9KSncxMmhSL1Vmck9hdGFBOXI4Mk5jeU1tR3E0?=
 =?utf-8?B?MVhlbnd0eGdwRkYrR1M5WCthbmxiQ3B1SFhxSGVQWWhVYzlEeUFKeVl3eWha?=
 =?utf-8?B?VldrUVBwc0NLdVRKN1Evenp4Y3JWSUJkUU5FWjN5Nk9nV0FRczg5cEtSc0xl?=
 =?utf-8?B?eVNyR0hWbThiN0hyOXgvRVNSb3g3UG1RbjRrL3ZJOEVPQ0pVT2J0TkdvZzFo?=
 =?utf-8?B?V0gwSHRjcnBVRlU4cWgzSldtVVRtaElqcEZhSFdSbkJ0Z0twd01VL2syN1VQ?=
 =?utf-8?B?cGtjM0Z6d3BDUFFla0NDTFdGWE4ydHRVUVBXeThsQnBpNUNNV3BHRVA4OGEw?=
 =?utf-8?B?NXl4bEtFZ1ZFVklkOWZacHhRd2JJZDRIb0JlSmsvMkRXZkxBcDZLSmZ1WWt5?=
 =?utf-8?B?cnNuVEVTQm05YzhsdnBrRmRNTnpPODZWZ3VhbldJaEJwN01sRStCclFER1I2?=
 =?utf-8?B?YXAxeDVzUTkxYnN1c2VWMHd2VkFLajgxbDh4WUpadWlFUFRsWWI1Z2VuSm5C?=
 =?utf-8?B?K01UdEVUb3hLMzVNRGZYMGh3cEtDTnA3SDR6QVlFcGtxZkhRR2NCT0w3YU5a?=
 =?utf-8?B?QjlObnd6TmE3bk92a0swYkVRa3ZNZWYrYUZLNnhzcWxYM1YyMzNiQnlFWGRU?=
 =?utf-8?B?aXZhcStObWZGa0V4cnlibk0wcFMxT2drRUxjMzRvOFM1dFVna3lHMjYrZ1po?=
 =?utf-8?B?NTBPeW5nUUJrRkFhdkdzd3ZXNkxQWlhaaUlzNU9kbDlwTWc4aUdLRjlpWklW?=
 =?utf-8?B?dGFOTFVIdStDNnNlRFRmVHV1NUhkUytiSko3cURJeC9sMUJVaU1CcDRVaGM3?=
 =?utf-8?B?eWVlUmhYMGJsaUt1MUtTckFoeXpQOWl0TTJ6TmwwSTNzYUlTc1Y3L0o2Rk8x?=
 =?utf-8?B?ODdybnNpWUFLbkZ6NkJ4aGFXdFFvTUNXNWNwNWIrWklRb0lDK3dHWWtOZnBQ?=
 =?utf-8?B?eGJFbTQ0enVyVTU2MzdHRWREcjNrZUVjMlc2bzlUOTJHczR4Z1o4cVdhTlly?=
 =?utf-8?B?V2Q5SHpqalJ4WDl6bzRDczBWdkNlZDJzcE9QM3ROQ1Jva3ZlNWFTd1BwMVRv?=
 =?utf-8?B?MmM4d3Y2cGgwSVlUUGViRkVXSHlqMThvRU5jT2lFN3IwWVpRNzlReWRkalJw?=
 =?utf-8?B?ZTBISG1EZXFFYS9KV3JVZkcvd0FDTjlJUUJUZzltSlBYU2JSeWtvVys1M0dC?=
 =?utf-8?B?MUtHYjVqM1oxRHFvcEcreFo0QTVNVWFJbmZsNmtyWVM5NFYwN0ZUYW4rSkc1?=
 =?utf-8?B?MHk4YjdpNm9QRTBIdHM5dUtMSXFya2kyRW81dUR6cmQ0anlSVGViVG45cXFG?=
 =?utf-8?B?VEVVYVpaYzE5cWJPTndSNkF3Zm83YzRkK0E0UjdGeXkzdGl4dElyaHVrRTJE?=
 =?utf-8?B?aExVWUJYdEgxeEJMQk0rUWYwZlZ6VjRvaG1pWVg0VEdQSlVCVjBKQXNpcTB4?=
 =?utf-8?B?bXVFdmdCcmNrQ0dXMU1wazdpMEZpWU5EUFBCcjRQWTRPajA5dTN6M3p0bVIz?=
 =?utf-8?B?RXNhYk4yT1Z1S2VlNTREbERRKzh2WTd3TC8zY0VZc01Mc2VOQ3BCYmpyaTRM?=
 =?utf-8?B?aXVINXRaQkdkWDBKUnpiZ2xZQkVjWEFZSkl1ODBOQ2Q0R0JhRHNwM08vb0Ey?=
 =?utf-8?B?alloL0s5YlBHUTNXWjNNQkErdmtnSEZybGJFa25URG5zQXlHamxZY3FYSndP?=
 =?utf-8?B?OGNNWnVrNm1YMWNWSDhEUWZDbE1SalJ6SUsrRUU3K3FXeGhyeG55c3IybEJn?=
 =?utf-8?B?Y1N5OTJ5WUdxUCtvc1FDYzVId0ZFbXNhbk9SSzA1cm9FdWpIMlFURzZIUVd6?=
 =?utf-8?B?YkFsNEhzUDIxOUwzVVpyMGkyaHBNcTlQajJCY1pidHJjaG9UYVlBVXhTT3Y3?=
 =?utf-8?B?VVh3Zk10UTFRMERWa1ZOY3o4bytyQzJLNmRnMnUvbWhXNDJURlJEZDZvSlFZ?=
 =?utf-8?B?aElZS1IzOEJ0OTc0R0pFN3dzSC9zc2tuQmJKVUZUVUowRlpJbDd1ZlJCNDJU?=
 =?utf-8?B?WTY1RktUMVovMXdjOSs0alZtR0J2TlVSUUlvTGd2cDJtRDNmNEtIL3NCdTQr?=
 =?utf-8?B?Qzh4ZGpHNHMzK0tHSGFJRkVoaWlYY3VKME5lWWxISG96c2hhN1F5bjB3Ull1?=
 =?utf-8?Q?IRnBnNyjZqjY0SWeTvxGLHc5igEiPd7ro7SCgt9MRs=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 5D4MVerpPec4IH0AArsrxCb2o8TodNiBfHBZBTJrOqPtOM33oZ9mNTtfMVHrD4/lDBNCtl9iYIGiyabjhn+tR+m3RBPi5CxtFPaT7FspjV3AhKOc/Ck8L7AZiA7vsKnmYeGlTl5FmXm4R0DI2pRjl2ZuTQ/bWHfTIPJObe/2DqghbevPSDs9l0ZbV/mAXfLdyj2yGqX4QtbCYckUCasMO0K3Df3o/lm5e4aC31eaST1dnycHSQcBlRZSgKbFaVFxegQxgwRIPSKgypxpsu3IBVUyIHVIn1Q7pmxRXlMyLk1UhK36oHiO8xkTkyoC7y8w0mGjtqI46ubJp8STMYDakSeje5cWWI+n2X5NEt5tZ8WH9scDT03D6dwW6/A27K8e8P1UdtTFXkexfb20Gd3yKrupSbIZJRwM8Q0StmmeV2g6fnP89jp/cNULBxhNZ68Q
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:47.7263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c821f3-e79b-431d-9f1a-08de5e7a6349
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254296-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,nokia.com:email];
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
X-Rspamd-Queue-Id: 91F6EA2F9F
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two flags for congestion control (CC) module are added in this patch
related to AccECN negotiation. First, a new flag (TCP_CONG_NEEDS_ACCECN)
defines that the CC expects to negotiate AccECN functionality using the
ECE, CWR and AE flags in the TCP header.

Second, during ECN negotiation, ECT(0) in the IP header is used. This
patch enables CC to control whether ECT(0) or ECT(1) should be used on
a per-segment basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the
expected ECT value in the IP header by the CA when not-yet initialized
for the connection.

The detailed AccECN negotiaotn can be found in IETF RFC9768.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commit message

v6:
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distinguish
  it from TCP_CONG_ECT_1_ESTABLISH.
- Move TCP_CONG_ECT_1_ESTABLISH to latter TCP Prague patch series.

v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 21 ++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    |  5 +++--
 net/ipv4/tcp_input.c   |  3 ++-
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index efff433de9a4..ba347b87a63c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1204,7 +1204,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
 
 union tcp_cc_info;
 
@@ -1345,6 +1350,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..fdde1c342b35 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
+static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_ect_1_negotiation(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..e9f6c77e0631 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -257,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5fe0e1d2c076..cbc8e28fe492 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7420,7 +7420,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
-- 
2.34.1


