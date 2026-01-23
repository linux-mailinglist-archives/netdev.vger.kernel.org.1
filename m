Return-Path: <netdev+bounces-252757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAihLHlIc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:07:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8105173EE4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02B123007B17
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71206350A21;
	Fri, 23 Jan 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h8+4eOGr"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184B3502B5;
	Fri, 23 Jan 2026 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162859; cv=fail; b=CPvhKX8hEG5ifRxlXHxmEXJ7cdDsh7h7MnmDdPqyIaEUJHHi4bCrfCD7uE/SOKL8AS2VfFy98q/Uw572zU4yMkcECpE9wQgMkVxXaqaKOp7qLpxzaYymKP5kwWtd26UaFkPKkKe+lj1XGNbbPjP9RhFxaRoOqG42kbUQEcrNkHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162859; c=relaxed/simple;
	bh=KBsAtiSyWtbWKmnVwyLzj6GYX7Z5vb5cbpSaEm9xyKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsHZBs/y6kx6K7QqE4XuY0wNundGaNoYjUgWO3NNjFK32DnoXgpCkxTFH5N0tA/wBAV7W3Abr0ewqv4qQ0B4S5v1kNzIN3eWsExIRo8iajBkuflm7JopVrNbutz8xxelbR3yZETcVlyf+tHUxdeOr1DE4OHwYl3cFpmmh872ej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h8+4eOGr; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq6mjKptP1PDN/qW4o4jkmdzjSnW+Ql52Spf+6CMT9UB8VAthSiIIYky0weufvnJ1X9qPNsl2Acf6CYgBOLslNiwzH+t4Rvum4XVR+uOvSHVAiHTdnnOI4QZB2/uxbjzGokxiZB5oIRtRMUqCoPIpbHFMsvo7KBushwNEWxCTvVRGDHMNiH6L5Hu6aQ2XFSKcazSi1J2NCJhrqy8hGDONi67f5lVAYPtoIRtxQrLhP0eaJNpFhYqdwlxfqLJQmwzjeimWbkJWHKa/OhWiVJEuycoJg1dQ446vIPBmocn87qW+N4lA7jYxlqictwF8u9UlJVCHZDWPBoXNTF+K2wdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyHmwPzq8227sF97H3CMdTN3iDW5Ttjgfp20x+abPow=;
 b=ZUDIfc/jp2YYzSMM64gsjhBpmXSfxJdTl38VWDre3QfPzwF/JaWWbn/mA3PiaLgZ2/4mZksX6C8rzziXmC6zKoY7Ev0C3IsFcvh/R7i4pGsPt257uy/MyhOW9yspJ/UwEDwJzLmwvjagxQvAO9KCIjW27OSP6WsDDSlSi/jelhPFz5SkZpI9nBe4F+cu4Q19tMDh05TXrtf0KLt4+ICnEgSXnPR7LYPRKpJHfJlPLm6af81LZNHrxLMucGZXcKF9cCBhpbSQ+NR7IADzqlCB+6dqdJotCTdblH07AQU8yhtTukQbssCuA2uZPJT/QHtBvpWMCWellpOVMMNiWVCuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyHmwPzq8227sF97H3CMdTN3iDW5Ttjgfp20x+abPow=;
 b=h8+4eOGrXe30/OIlx+zrL9RP4R9XojoxrhD3XjznjVTm7C6IPz/FVWGDRwxqdVJ0DFgVuook0qMqMBJtQVv9u44uZ6+F6EIJN3XkbnUOzPy+7EHfIdZRHV+YtAIPpfgY5ydP+iSfIEyWPfgta/kQdUpOcTLkSz7ybh0RnIWCMMQZPS5yhs+BL/0KcUXxU5Hc1uVKpCc/EBJqCskyHszQ8k6vkb19W8yy5RYm8b5THpZdXQ/ZqwKbJBEQFbKtGoaNV15oEZ3pMuVnUC2f8cnNARqOPdyJkM8KvJsqQQqqfY7HrVCi9uxcobTi/VBve4JEMluyrvI/odQetIpoMB06gQ==
Received: from PA7P264CA0023.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::14)
 by MRWPR07MB11680.eurprd07.prod.outlook.com (2603:10a6:501:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 10:07:27 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:2df:cafe::4f) by PA7P264CA0023.outlook.office365.com
 (2603:10a6:102:2df::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0 via
 Frontend Transport; Fri, 23 Jan 2026 10:07:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B70361C0031;
	Fri, 23 Jan 2026 12:07:25 +0200 (EET)
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
Subject: [PATCH v11 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
Date: Fri, 23 Jan 2026 11:07:07 +0100
Message-Id: <20260123100721.42451-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|MRWPR07MB11680:EE_
X-MS-Office365-Filtering-Correlation-Id: e84c631a-f0be-40d1-3464-08de5a673660
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b0xvWW9XaWlNMmhzM2s4UzI3bW1vZmVpUkJnQVo4K0NicnVyWVlTSWdPNG5k?=
 =?utf-8?B?eDFSdmNBdmVEajNBMVNyNWVTOXRlVSs0Yk1ieTY5bzFzQzFjcnZaQ2tvY2ZI?=
 =?utf-8?B?SDZyZTVFY1BNaEY0c3BnbFZKNUV5QXJpenVjSHhzNmVmTlI3VlV0bG1TQnBt?=
 =?utf-8?B?M1RFYUNPcEpDa3UxRjM1LzRxY05lTHFtdmdIaklCYVVaNXIwakJEWW9NZEs3?=
 =?utf-8?B?dndjTWlpR2IxR0FWWG5TdzZSbUV4djltalE3V294RStmbmI3SFhESkRKWWJq?=
 =?utf-8?B?Njl5N1Y2NDU1WTc2dm9pcjVnRUk4dy9RTGtQMUpSYm92TU1wREZzZFdrYUdQ?=
 =?utf-8?B?UlFXK2JTckczRkcxcUhpTVN2YmR2NTMvYXY2bW1LdFNkWFR0dU5GWU5GWGhB?=
 =?utf-8?B?YWp2MkRZZVkyS0pDMktmQXhNNFp0d21MNHA4Ym5MQlRqRmVLalRaOHV6KzJo?=
 =?utf-8?B?T1ZuZmlYbDFqaG9vTXdmWFpyTkRuSVpUUkl2QUh3U0JSMnYvM2w4d2V0QzAy?=
 =?utf-8?B?RHl5SE4vWlFzb0tCS1JBZkN5bU9KVkt5N3gwUGQ0ZXpjY3ArQU9zQUJzYVA1?=
 =?utf-8?B?TlNUQ3hFMU5YcVgyNHpEV1dXV3ZDN2FYcTg4ZlhJSUdUcG9BZDVXdkw3SFc2?=
 =?utf-8?B?NWZzakxWdjBHdVdOMHV1U0c3dHd3UEcrSDR3cGkveTZhTnVtOFlmNW5XK2t4?=
 =?utf-8?B?b3FCOTRaaGlERDBEcm8yNEpDVmJNZjdldDkyeGVtdnl4Z0h2T1IzbkFPUzY0?=
 =?utf-8?B?d1lYTmpQWTc2TExRd2tPTE9uWHBjR3JyZ29Wc0N0S2JlaHR0anM1QmJQaE5t?=
 =?utf-8?B?Y0d0M2hzaFRLaGl3OThkQ2ZOanpBcytSaTJzMnBDZU9Pa1BveWFaR2hoWHFq?=
 =?utf-8?B?YTFRU0tEVDdQMk5xeVJOUjFIRDU4bmIzLzRRSHBkZHloYWp1b2JrTmhmL29M?=
 =?utf-8?B?RTExWGRhWGFxWDQrallrSGNrRUwvOTZmM1V6aU8wbS8rTkFRY0xBYnhaM0RR?=
 =?utf-8?B?RnZPeUlRNnZJK1NBT2pOclBoR0U5VVJXRVpKU0pMZEdEWis0d1BwWHBpbmd0?=
 =?utf-8?B?eC9QamFxdnFnQ1o1bW5KR0JnNjRDYndkTm1YY1lTRkdmakFZejA2RDJwR3RH?=
 =?utf-8?B?U2tITWZOOEJRa2hTY1JYT0xQd3EzSjBmUVlHYnE3Vm81MThyRS81TDZOZFFk?=
 =?utf-8?B?NWxJbmkvZUZ4aU5WM1Z6QXhKRDVLS2I2YThKelBFZk9Gd3N3dElOYzVYeTk2?=
 =?utf-8?B?b3g4dzVPS3pteGlrSDRMYWVSRS90ajdpWjBWOERFanFBb0JJR1d4UmRDZzJV?=
 =?utf-8?B?dWI2cEt0UzlRVzBrdVM5WElWUXlCenhpNGlwM2pPWk9XNm9lVmUxWjIzQjNL?=
 =?utf-8?B?d2trWG5DUXF4ZllpUkZQSXZHL3hseG40VndxQ2VOcWRhWnZkLzg2SEdZeUw1?=
 =?utf-8?B?ZTE5M3k0ZkZ0TlRYWHo4YUg5YjVwUmRyR0IxdVpGekZhU2FDVDllNGJYcnQz?=
 =?utf-8?B?ak02SDdXMklQc3cvUlNMbUI2d2srZU9WcnNOTnBVTldGRUFPZEI3cDlla0lF?=
 =?utf-8?B?eXBRSFpIaDZFaSt1V2ludGpVVVZnRXRWT1d6QnROeDNXL1RKaDhFS2F3N01M?=
 =?utf-8?B?WlYxTzNRVHJOcTBrVFkwLzRkT21UcjhHN2ltZC9UR203alloUnFoZTB4Z1Nr?=
 =?utf-8?B?WnBEbE9lMHFxeWtYTzRiK1I4SmhEb3RXenJaWTZEajErcVhjRGlaT2tHTyt5?=
 =?utf-8?B?U1pCdGdFQ0NCdXdaTDFaV3A5L2pCTmg0SzlTQjFCZ2FhWFdHVnl3aVhvR2Rt?=
 =?utf-8?B?di9HWmgzc3Mrdjl4Tlp1TlBPVCt6UlgrTUJ1UDNUR09rZzc5ZHN0QnNVV05y?=
 =?utf-8?B?c2VadjZ1WllNWFppWm9VL1Z6S0w2eWNaYjhVRWFJQlFjYjRSQThyN1ZCSVVG?=
 =?utf-8?B?a1pEblB6Szd2QmUvMUt4S3ZIdEpLK0tjUERmUFpnQitZRjArbzZqZXpIU2pk?=
 =?utf-8?B?NDlhQWVrWnJ6bXFWN0pPb2Z5L2x1N0ZTMlF6MjVnK3hqSFBsUjg4d09YV1Uz?=
 =?utf-8?B?MnIxTHUvYjhMalBWUHpUNW1tYmZkQ1BWSTdxd2xYUWsrQUY1UWpPZU0vNy9o?=
 =?utf-8?B?Q2laa2VLUHhoYTcwQ2dpZ2N1V2FCODJidi80UldCYTB5SXZRc2w1SFpxYXpF?=
 =?utf-8?B?M0lNcDIyT1BYekk3STNGZVozb0I5M2RqY0M1SE9kSVd6OE0rdXpxNEk0bFhF?=
 =?utf-8?Q?9Jwkn5Yz6b35REUhGG/9c6pM8/y6/ybD4gE+puE42Y=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:27.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84c631a-f0be-40d1-3464-08de5a673660
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB11680
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8105173EE4
X-Rspamd-Action: no action

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 367b491ddf97..fbc514d582e7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -342,6 +342,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 148cdf3cd623..a00464cdd53d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3436,6 +3436,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5209,6 +5210,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9e91ddbc6253..5fe0e1d2c076 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


