Return-Path: <netdev+bounces-251918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KVjHqbncGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:50:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9B58BF8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E09CA64D7D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CF4963AC;
	Wed, 21 Jan 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="N6ZUh5Ry"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F9495526;
	Wed, 21 Jan 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005953; cv=fail; b=isQwRsD28jzvreo/VRdF7a7HfoVUxrd9LUTy7uKiGmD2FTIDQT/Xb7BjOKIflRRIRz9fB78hGlwJfTyE8DytJnlxgEAQsvF+kdjtSoOAZht/NZLEKvpouAAv3QkaMMo375MtFFrQp2jwN7eyp/vVD4IDxAUQfVqiu+Lu1IcCVjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005953; c=relaxed/simple;
	bh=G3XlyymA6YlGBTnuaxgJ/wBf8pPoh2XMNrL3HrgSqrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F2G4DPRi6qB/OD3Vnp7yuzemPu6il4Jv3YKHlpl6DMCeMkM5AAU6mHn9ZeHnDAMwGmvceafPQVNUKiQTMr1CGEhhgpmluEYuennwcuTw/OfnB0h5oq9nUgUlpkhwjjTH9Z5PEvJ72PXnhRIfLV33E1REuI95cg/ZPLOnp6ggm6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=N6ZUh5Ry; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihR6xaMdHL5cuW98QC5DyKRWbWAYkpxD0F013ZpS9bjPgHAnIY2SLUwwRrs6oOWTlPAlYhVvkjqUAf51SvVNy5WJG419HtVdI8JGsc3nnrkAa2dbflMobDE+5pA6YHNqe/TEOp8RlzJlwVRAa+quRwtJYGLDxOPhEHpDrxoxU8/TCTyb/xIzpQQemFxas6wyB9YnvkRFZ9EjsvwHONS5EjLgm4j5hjNt2tVNNCh3kqdiY1/NpV5k+O6QgNTRiBfn0YW9GQ8WCu1pQNDommaWb2p+tNa1GsoJ6VBCqe4HYxXNngTg8sZQhR8kD00Y92uVbhGPreugC8/Q8Nqn4isKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DBz3WupAwt/67RfLO0B4NTY/CH6SU3dGDx91bz8BLU=;
 b=JeOCbIl6XP82bc7Y5I1Fl8zQAt1VeUEZadRY+NOWtQZLUXEYz54em6gxilkb7CNF7YTcmbXAHWFy/4uKILy2/rmwj/EmJNBSdVnnrJt5U0TNVrBuaOSLWOhkYQKcjeTOSGMK73q84t+FoaERSOwx/hbHjNOyMIIZ8Gy/cReN+vJjNcFb+sgBkZTsuKFmOWQvNkNfgAEfHXUbj/2fICtMEpEqZs/VClc2oMOg0CbjhkDLp3ul3ZkecsnnbPWyc/yvkYOmN2NOy/eLnqwbv7tv4oThbm45AR0gFfm2U87gLMZG0Pz6vrwNfDNw9FyeEyZAIX+jzVNNVJkF4tvqjKgneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DBz3WupAwt/67RfLO0B4NTY/CH6SU3dGDx91bz8BLU=;
 b=N6ZUh5RyUdpf6VL/tG6bR+xUwH+9yfq9Mq8ydOqjSD2Yggbj/YcgQ9S/PLFSRZnHdbmrFJR6koN+IirFcd05LW+ZnT22rHle0qCjPSy4jt8Y9yac02Vd7VQAdg7TRy52XXz9nYw28vofpJiNHUqeVhPWw3MtYkS08/yzDNo/aGZQSh+6YIQ3rScO+d+WHai0RuDrlhYbX6VH/R2BRtPx3waewFXiMChz64vuzQlDh3zfeJj8KEKaXI4kni61VCLdBLSAw92GK/VqFwEKSRS/R2Q5ZL48v3OMsTXhIF9IvxwRuavhEwHowS85C7xcqToiHdbLM3oEB9re2JyWuz2hvA==
Received: from DU2PR04CA0290.eurprd04.prod.outlook.com (2603:10a6:10:28c::25)
 by DB9PR07MB9174.eurprd07.prod.outlook.com (2603:10a6:10:3d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:18 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::58) by DU2PR04CA0290.outlook.office365.com
 (2603:10a6:10:28c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Wed,
 21 Jan 2026 14:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Wed, 21 Jan 2026 14:32:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 61DD62034A;
	Wed, 21 Jan 2026 16:32:16 +0200 (EET)
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
Subject: [PATCH v10 net-next 00/15] AccECN protocol case handling series
Date: Wed, 21 Jan 2026 15:32:00 +0100
Message-Id: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|DB9PR07MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 6300dd14-674a-4ca1-4b58-08de58f9e130
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020|18082099003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?akhHYW4vV216bzVGdFdJVlR4ckR2RXVGd1dVWm5QdXFSMXd1NzRQdU11TFFp?=
 =?utf-8?B?V3B3ZEE0c1NyUllQMHNFWGFySldDeW92NDBpaEY3ckFMcHk5bnQvTjY2M0RB?=
 =?utf-8?B?TndQeEdlQXoxZlp4YWZ4YklweEZ6b1JKQVlURDhCbnhDQ1RwYVBuZk5nWFVP?=
 =?utf-8?B?dG94Tno1Z2NLelJJcVo4SUh6ZDg1amovYllwRElXUzB6L1B3RDYvendLWWRN?=
 =?utf-8?B?VWkzaFFtdjNFNTFTNEhDeDhQdDZQMUs5NHJQQ1Y0a0dPUmtEQ1BmMm1oamJj?=
 =?utf-8?B?THY5Y3lvQ0M2WjFGTURsdVJSdVFkK05EaDhGWjdHT1FDeE1NOFlRSHZVbDZ1?=
 =?utf-8?B?UTRsVnRGSmErb3NpdlI4L3QvR2FReE9OaVJBUDU4bEZSdStSOVhRcXg3a1pV?=
 =?utf-8?B?NEo2YWdodTJyOUY2L0xoRlpROWd0ZnJLbC9BL3RBZkVKVmpJQ24xQmFLcEhp?=
 =?utf-8?B?OVd3eG9PNkh3UUxRRm9GV2NVek1oQVo3dkpJRGtnVXEySjdLeEZTeHJ4L25S?=
 =?utf-8?B?VkJWVnMxS01kTWpsNUx2ZUdmejRkdExRcUNCYmJIL0hBWUVTTDgzZ0dkK0Fu?=
 =?utf-8?B?S3hSUWxwMUVWMW5jcUZvUldjYU1nVURTbHVWdUY5bE81U0syamZobDdkUksy?=
 =?utf-8?B?RlBPOUkrZS9WajFYbEplbkRIYmRHQTJReG5LQzJya1M0cVdmdCtlZ2NXODYr?=
 =?utf-8?B?NWlmODVwcEt0aEZ2Y0Q3dk8zK3BlSGI4SzVwTk5vdXM2L2xiakx1Q21RT1g0?=
 =?utf-8?B?dVJFZkxzOS82S2grT0Fuam9UeGtuWDVzcCtLM2JxYkoxcVl3YU9nZ1VSbEVl?=
 =?utf-8?B?ZWo5bUxsMzh2Vi8vcEV6YlA1VTMwdy9FSGxrbnE4T0RmdFdhenZ6dDZyNWxG?=
 =?utf-8?B?NTFEV1krZ0xzLzVhVWpvS094bXZIVUtmM1RJeWEwOWl3WmIzdWtuOUV3Z1Mx?=
 =?utf-8?B?dkRuRWJXTlZuRVp3dXk0ZklUeHZJUGZ5b2UwOGdnMGFCMDdBdmErTUVpN3I3?=
 =?utf-8?B?eDlNZ0d1eFdqaDNDenBWbzdiWHgreVdMazRvaW83K0RzZzlGK2ZkSmFRMUxG?=
 =?utf-8?B?YThPTDJqL210cWpRdDhsOFd4Y1BBNStzUVI1WXNBODJTNDJkeW9udmQxOE1y?=
 =?utf-8?B?Umt1T014TnU1dHhVdll5cmdhS3lhTzVrTzMvOFZmWGVKQUJ3blhHTU5uQjhs?=
 =?utf-8?B?VTIvQ1BWRUVZSXB0c2dSZ2RYZzYrSTlLMEVvUFpOQk5zNUpuZjJTazBwdENl?=
 =?utf-8?B?ZmZPQ0IwS0s2aU1VQ3BEY3VHamZNaHBlT3FKRzZ3UU1TR0REeWo2Zit1Q3NF?=
 =?utf-8?B?L25IZTBPeWM5T2RqdUdJclpiaVlNeUk2VDVvQ3JhWjJodzdqckVzQktpMVVS?=
 =?utf-8?B?VlFGYnBYcXN2OW5VRmxxQTRIVy9XYTgvOXZ4L1haZHJDRWNkd0E5aGVXQWJx?=
 =?utf-8?B?TVpXcFQ3TU1UT1h6aVlzYlArcE5uQXRxK1JjYlZNZm5zMUNITHNhTG1wQ3Qz?=
 =?utf-8?B?aVFZVDYwR3d2Y2FEUkxXUXJ5bU1FbzJtbHFXVE9CWExIZHNCaVgwcTMzNkRK?=
 =?utf-8?B?Y3ErZmZlM21qRjNKNkRMTmlFbE8xUTRBOFBQUjVhY0FGSUlpRTJNV2ZNRzFE?=
 =?utf-8?B?UFR4d0hDZ1kveDRkdldUR2lqYm84QVFGRE1VQWdiVVEzWVJsRWI1RmRncDN4?=
 =?utf-8?B?M3F6YUh0bXo2VUJ6YllzblFVOUxSL2RHdUJHZVlITXFDQ0daOXdqcG1QT042?=
 =?utf-8?B?RmIyaWhwVXBBSUxXd3hqT0tTaVhBTUJyRHhETWJjTFRDYmRMRHRORlA3Vncv?=
 =?utf-8?B?RkZjNXhSNFJqZ2ZQNDF4anNKMWZtOFdpUGVWRXhzVWdKWXFXSDh6cGhpWHdQ?=
 =?utf-8?B?aDducjNOa1BPK1VSS1NqS0V1TnJGdzhjYUtCclRndENFQ2ltY3VqSTBaSkw1?=
 =?utf-8?B?dXFPSDljcVRSUG5ISmMvb05meEFrYUU0ZWJCcGRjbjdwNHNsVHAyQ1lod2RD?=
 =?utf-8?B?a3FQVlpaNTE4b2xvY0xjd3c5Skp6QVd6Z2NIaHdsNU93T3JGdUNxQzJFRExy?=
 =?utf-8?B?SjhRZitrdTViYVBVeEIxQmw2RG54SnAzZ2JCSFRZN0JTcWQwMytkQmlXNnFk?=
 =?utf-8?B?QkZXRHpMOUxHRExJbU1QMDkwb1NmakxLc0NGREl0dG85emtuQkpLcDdhTlRB?=
 =?utf-8?B?di8xRjh2c3VSRGZ4NldqZGR4S29kaEJIOVlpaUNVc0l1RE9aTXdibklyWnAz?=
 =?utf-8?Q?KtOf6FOm0+UThiYFx1tqo2NkWCuMZtz7rdPRFpVWkg=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020)(18082099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:18.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6300dd14-674a-4ca1-4b58-08de58f9e130
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9174
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EAB9B58BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v10 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v10:
- Update commit message in #4, #6, #7 (Eric Dumazet <edumazet@google.com>)
- Set AccECN error flag on request itself via tcp_rsk() to avoid directly chaning on listener (Eric Dumazet <edumazet@google.com>)
- Mover new tcp_info fields at the end of struct (Eric Dumazet <edumazet@google.com>)
- Update timing in tcp_accecn_client_accecn_options_lost.pkt (Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>)

v9:
- Add 1 patch for 2-bit tcpi_ecn_mode and 24-bit tcpi_options by reducing bits used by tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info (Neal Cardwell <ncardwell@google.com>)
- Add missing comma in patch #3 (Jakub Kicinski <kuba@kernel.org>)
- Update patch message of patch #15

v8:
- Add apcketdrill patch #14 into this series (Paolo Abeni <pabeni@redhat.com> & Jakub Kicinski <kuba@kernel.org>)
- Add helper function in patch #10 (Paolo Abeni <pabeni@redhat.com>)

v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

v6:
- Update comment in #3 to highlight RX path is only used for virtio-net (Paolo Abeni <pabeni@redhat.com>)
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distiguish from TCP_CONG_ECT_1_ESTABLISH (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_CONG_ECT_1_ESTABLISH in #6 to latter patch series (Paolo Abeni <pabeni@redhat.com>)
- Add new synack_type instead of moving the increment of num_retran in #9 (Paolo Abeni <pabeni@redhat.com>)
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans for SYN/ACK retx fallbackk for AccECN in #10 (Paolo Abeni <pabeni@redhat.com>)
- Do not cast const struct into non-const in #11, and set AccECN fail mode after tcp_rtx_synack() (Paolo Abeni <pabeni@redhat.com>)

v5:
- Move previous #11 in v4 in latter patch after discussion with RFC author.
- Add #3 to update the comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN. (Parav Pandit <parav@nvidia.com>)
- Add gro self-test for TCP CWR flag in #4. (Eric Dumazet <edumazet@google.com>)
- Add fixes: tag into #7 (Paolo Abeni <pabeni@redhat.com>)
- Update commit message of #8 and if condition check (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #13 (Paolo Abeni <pabeni@redhat.com>)

v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1. (Paolo Abeni <pabeni@redhat.com>)
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3. (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #4. (Paolo Abeni <pabeni@redhat.com>)
- Update commit message to fix old AccECN commits in #5. (Paolo Abeni <pabeni@redhat.com>)
- Remove unnecessary brackets in #10. (Paolo Abeni <pabeni@redhat.com>)
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2. (Paolo Abeni <pabeni@redhat.com>)

---
Chia-Yu Chang (13):
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: add TCP_SYNACK_RETRANS synack_type
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
  tcp: accecn: enable AccECN
  selftests/net: packetdrill: add TCP Accurate ECN cases

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |   4 +-
 .../networking/net_cachelines/tcp_sock.rst    |   1 +
 include/linux/tcp.h                           |   4 +-
 include/net/inet_ecn.h                        |  20 +++-
 include/net/tcp.h                             |  32 +++++-
 include/net/tcp_ecn.h                         | 108 ++++++++++++------
 include/uapi/linux/tcp.h                      |  26 ++++-
 net/ipv4/inet_connection_sock.c               |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |   4 +-
 net/ipv4/tcp.c                                |  10 ++
 net/ipv4/tcp_cong.c                           |   5 +-
 net/ipv4/tcp_input.c                          |  37 +++++-
 net/ipv4/tcp_minisocks.c                      |  45 +++++---
 net/ipv4/tcp_offload.c                        |   3 +-
 net/ipv4/tcp_output.c                         |  32 ++++--
 net/ipv4/tcp_timer.c                          |   2 +
 tools/testing/selftests/drivers/net/gro.c     |  81 +++++++++----
 tools/testing/selftests/drivers/net/gro.py    |   3 +-
 .../tcp_accecn_2nd_data_as_first.pkt          |  24 ++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  |  30 +++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  |  19 +++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt |  18 +++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       |  22 ++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   |  26 +++++
 .../tcp_accecn_acc_ecn_disabled.pkt           |  14 +++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     |  28 +++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          |  18 +++
 .../tcp_accecn_client_accecn_options_drop.pkt |  34 ++++++
 .../tcp_accecn_client_accecn_options_lost.pkt |  38 ++++++
 .../tcp_accecn_clientside_disabled.pkt        |  12 ++
 ...cecn_close_local_close_then_remote_fin.pkt |  25 ++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      |  25 ++++
 ..._accecn_delivered_falseoverflow_detect.pkt |  31 +++++
 .../tcp_accecn_delivered_largeack.pkt         |  24 ++++
 .../tcp_accecn_delivered_largeack2.pkt        |  25 ++++
 .../tcp_accecn_delivered_maxack.pkt           |  25 ++++
 .../tcp_accecn_delivered_updates.pkt          |  70 ++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       |  12 ++
 .../tcp_accecn_ecn_field_updates_opt.pkt      |  35 ++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   |  14 +++
 .../tcp_accecn_listen_opt_drop.pkt            |  16 +++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      |  28 +++++
 .../tcp_accecn_multiple_syn_drop.pkt          |  18 +++
 .../tcp_accecn_negotiation_bleach.pkt         |  23 ++++
 .../tcp_accecn_negotiation_connect.pkt        |  23 ++++
 .../tcp_accecn_negotiation_listen.pkt         |  26 +++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  |  23 ++++
 .../tcp_accecn_negotiation_optenable.pkt      |  23 ++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        |  20 ++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      |  27 +++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt |  27 +++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     |  28 +++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        |  18 +++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         |  18 +++
 .../tcp_accecn_sack_space_grab.pkt            |  28 +++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    |  39 +++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt |  20 ++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt |  20 ++++
 .../tcp_accecn_serverside_broken.pkt          |  19 +++
 .../tcp_accecn_serverside_ecn_disabled.pkt    |  19 +++
 .../tcp_accecn_serverside_only.pkt            |  18 +++
 ...n_syn_ace_flags_acked_after_retransmit.pkt |  18 +++
 .../tcp_accecn_syn_ace_flags_drop.pkt         |  16 +++
 ...n_ack_ace_flags_acked_after_retransmit.pkt |  27 +++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     |  27 +++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  |  28 +++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt |  22 ++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  |  15 +++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    |  25 ++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   |  26 +++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt |  25 ++++
 76 files changed, 1686 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

-- 
2.34.1


