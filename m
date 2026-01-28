Return-Path: <netdev+bounces-254293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YESRJKofemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:39:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A0DA2F2C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4892D30B0ADA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423235FF67;
	Wed, 28 Jan 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RibUAMKr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EB3596E9;
	Wed, 28 Jan 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610907; cv=fail; b=q9/x62/KVX3FShvd4suOoLNAOu45C5iBmt4DCBV/2jRemCW+wPok8l2TmOT8Rbkh6/2o0ZpmlpiZDA+/poZZWJH3tHqwRB17eZ9y6M+lt8YgDBI3SwKSXKt0B4fjO+edgGl9JDNMVwBPPy0NS5Jnz3eWK8+Wdxx4GK01Jfz/y+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610907; c=relaxed/simple;
	bh=WQ1xrjNOZ30pkRS+1nMJWuAXV9LkTQFgkNkSoIGb0gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euvTYE7s8AR/sqo69W7EF8HxcEGrDbTs4KEZ+uK2jseyqFxL7/v7F2oFYHC2nZgNV0s2P8C9/am0n1lSltaXev6b1DMMq+8XkDMPkV+WEkzOle7Xqt72TGyFgCA4ZfNe6CDG5cK4OQT0ywMwqD4hp7KDgzHJ2y8GfQTEv3zH2R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RibUAMKr; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POaiwGY4QkH389TgBQRrcl1MsuHNEdz5p8EORazJd1EbUDsXxc2s57MEBSCkxWA280DUxrJpbcA9Z3mmklPK30XuEZ90WhjlKYZ46o/nsYqlxKFB2sqp5iruxTYu8+mCKf/CE3QiJrdwpZ9y6XDT6ve3Ck8bN4fMMZFyhy9kzHCgxx9JE9UOVoad9I+/Y9K/FARrX9mI+viOaGzwWkPaVpdfoSorSnkXnxp2DuRI3xFIM0/RdGw3GQTwZOrFFYmn//+XR3IQjqZpE2gYySZi8dnccNYEuDp8bpyi+O7zYmp+BxGZngSOc+ol/gfzJNpX0sf7A2V+gnLp/JtA9i964g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhlI3HMg37S+7MKV1X8WVT8Y+Y2cjSx079u5QQIGTW0=;
 b=ngNs9qvidGOTAxOhNzgNA6hWB6JS8409enwWepFAFqRXiepcGuG/AEgQrqmy8eRm8QxLlYBBKTTtmd/DlcVPvG/jF6asyHuTk8Cn5JtE+/GToWfjmwPCHrK4YePXsjWou2QNVvjMbmnRJOn32lTrkiyS8C1GCgreIzp9nvwFVyzjgIwx+RIc6u3+sCe2JG0GwWxtS6jvsoApQM4CqpY4unVse5dD9itMGM44s4JcexXHgWBwd9fgwLmXc8rAgsbonXWQ9LIlz0W0tw2IN/R+5UE8VhLGlS/Uz0fP9F0TUH+1aaKA9wBkvuVyfVy5z8OyMGrm5P0t4xVBtp9/o1vHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhlI3HMg37S+7MKV1X8WVT8Y+Y2cjSx079u5QQIGTW0=;
 b=RibUAMKreLzLmwwb9cDQP9C5dfhECvF2MMv1IklbGWidp7jSRLWUs/lRJivvAcdhxBwpAlblHYOOzY4VQRoiY/Xp1ljxuI02NIWnRnaSqbsR4uIKdtqBlZAdl3fs6gmJuQHAtDrLiHAaEt9lF8GLCAZeWTPdp1Eg1uHpapw0wW9t+V1N9pMoxNzG28+GSP+Aa61woj0RMwVM7Eu3cXxvqwO98A+MVyeqp2wPqo8C+Q46B6DtsPonZgmMfiEFLdZ/Ex/wMLH1dcTPJ+PqoxDmz4mlQlC83KU7/CKtdYahZ+kopiC7r69be9t8Y0w/u5824wM9fxLpmmTCkHWWL6mNyQ==
Received: from AS9PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:20b:498::19)
 by AS8PR07MB7654.eurprd07.prod.outlook.com (2603:10a6:20b:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:34:58 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:498:cafe::48) by AS9PR05CA0108.outlook.office365.com
 (2603:10a6:20b:498::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 14:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 1082723649;
	Wed, 28 Jan 2026 16:34:57 +0200 (EET)
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
Subject: [PATCH v12 net-next 10/15] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Wed, 28 Jan 2026 15:34:30 +0100
Message-Id: <20260128143435.15708-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AS8PR07MB7654:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae6787b7-99bf-4e63-34a4-08de5e7a69b8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?RsU6ls00ZynIEZq9dt2UgVt+znxJFGPOCE5HLYYn95rLj0++pMEMp21JPs8r?=
 =?us-ascii?Q?4JMKj83TllsKNa4ZrPDMrakh5Fx1bHY3WxWSvOlSzWqmrQ2WmwmzUSJVHGx2?=
 =?us-ascii?Q?x06msOpu9l/R93fJwvcF9ljvCUhqa7uS7FaQ7cStBAzEfk3/B3refIIRO+OW?=
 =?us-ascii?Q?Q9sC/NIqAJfJO/RN1uv3XnrZq4YWcnsHgylgBob6mQJwfdJXVhGE5q5+g13u?=
 =?us-ascii?Q?NSwkj/Z7dA0QM91YBM03N6X5W5oAk1clzc7R6/6sT24SaXW+xIdZfsugvcQX?=
 =?us-ascii?Q?OBulPqobZZGKFLdCau4eYa/9GBjjxs7wl7AT3MgQL/qmbpKkAP/fBqF4Hwag?=
 =?us-ascii?Q?CwoGDfc8/x+2GGOZ3YBjQHQRIBGet9hiwByeNn+JOQqJZIXoQkKYVVj6Cvna?=
 =?us-ascii?Q?I2RNHcA/L1yeSddFq3q5wGbZXiKH1J+/yNYGoksPyXey5e3yy4bGgDq3FBMs?=
 =?us-ascii?Q?U33yj8/VqHdA0hytXq2CzUCIn1V7sOjFMZw1o2qSQxP0YMbxfYmGXEHc2FwS?=
 =?us-ascii?Q?le8ZiEh0HgdwaU2zTD0vuAxOHEUpBS0xN9bzOtsmfA4NWu1UTVcfMIzE5tnl?=
 =?us-ascii?Q?IRcMu44bvknfy3JGDDpnli8/r2LomwUfjBKnT/35rVupr5b2l0aleVMsrqYo?=
 =?us-ascii?Q?Ndr4yoVwjNGuy7crFVAaFH+ouedRcmIsQUNejdcD5Ghwn8MLkDeQhDd/rkh5?=
 =?us-ascii?Q?SoS4olVZx5aTlJwU6In5lkzddPybAvJ6L0MW16hdlkRPMC24nFmwBIfmC9qW?=
 =?us-ascii?Q?kUCrpuYE17aH3M1QRuhxoTD4UgrTAuzjJEom/O6+R4ipk2L+Shurnc92m8Oc?=
 =?us-ascii?Q?oyL3JRv1SnDE2BuCfu7hYcNJl7pm/OlHg/uyKW5kBCU4idBvasCGtzPOLAX1?=
 =?us-ascii?Q?jL1MYWQLk6gUB6Lt2AuwGoeuovSV2Wwxu5XBQKEDSzlGpBoNTktnL8Pk8TmH?=
 =?us-ascii?Q?xqMYyZgCcEbQuVonDknzpDCrwxRcemnnnPq/UnKNtyquVhoqDL7WIplgvKCq?=
 =?us-ascii?Q?npQStbvEcljC2LszONhfmMbu9TnUDWtQngMfuBHwylDHLor2wNDpuj14XT7A?=
 =?us-ascii?Q?dvuqsnh0+/Hvs6pFqDelsSGOAfFdDmFSzcyCxPeiviY27nxUwOIgXkO+i769?=
 =?us-ascii?Q?vEoxqBmsgT1gREr2YDXxAWr8+lHJvIWi046tJU4DwEVXdCARXROFvj73/XnC?=
 =?us-ascii?Q?PayjtlkwwsoKF5k8lDcJlE/eXmknGxnwI81x5zDHBau0BT35plrMi3RXWPY8?=
 =?us-ascii?Q?YO/RuSkx90lFws+1QHHBS/BjwYZRTfboOhFCQyRZYWk7c/Lu85ddNM7NJKB4?=
 =?us-ascii?Q?KOf8gLOYzWO3lJxxm4sAB9DsEnUAr4PxcHpLh64bknYoN/DYfYL2gtlCB4js?=
 =?us-ascii?Q?o0IWegQU3FPjv7OVNNbj5U/ZEr2cnhFEcmAU/wS3DAPkcf5LQwKB1B198ye3?=
 =?us-ascii?Q?BY73TJytk9dii0sD7pCIlHFlYqHUKbWm1GCEMkuFqx1ZZtINZjHVbgRemm/o?=
 =?us-ascii?Q?uYzGrK5sdsja1ZQAAN21UIKPLZg+HGcU1MAZM93w4F01MgLu/uS6oxTXUtQA?=
 =?us-ascii?Q?3i2dCDHqW8IaUkZjLLegZ+yH6lHLX52Z13lbgin1QWcLEvCJ3WlF8hgp8hp2?=
 =?us-ascii?Q?J5tzRZIcESMreKlBxvrBlU9nCwHw+jFKeqqO8YW8PlQXouXQLjrV46pilsSE?=
 =?us-ascii?Q?Y2JwVZ5F4j9r8xVujy9BpSfeqxg=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 Bzq/dZnqi1Nk5y4Cj/nNRRO9JlLtfsTx8B+s4pRRB5U/rlgDe0xIqMES8lTxH1stqKVdP6V09vvzk0Par2KYDck5mPa7d7nBHuiowDO8+s8Dh71CpjWgbbfOiAvYYXLgLuTU+6uWpEaHQRHkxLKe2rfdrq6gEg5qz6omM/RUKm0vLG7RkhZ2NwpNRAMfJ/q4VB7bMjq4DDsG4Wt+kY7bqAb48FhCdpI2FxeHxK85uzThmihw36bAjXRQRoAlnsFavMG1ByfBWoAQN06zg8mU6cZrN0Dr8fjsnFRYefvxJsB3fjZtzPxjc7tmmQ2w00Ov4A0LFuPR9tbC04yR9EODWjSuSLazispz4nRqJTKANf8Pka5X7Md7+4EoHg73IbcewE8ud/tv4GvhIJii2cqelVthfYadfJprxUAAGjCz4fTHirrJJanYoRDBue/nXza4
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:58.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6787b7-99bf-4e63-34a4-08de5e7a69b8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7654
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254293-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,ietf.org:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 05A0DA2F2C
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
if it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

In addition, a host in AccECN mode that is feeding back the IP-ECN
field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
latest valid SYN or acceptable SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v12:
- Change AccECN fail flag setting to request socket

v10:
- Set AccECN error flag on request itself via tcp_rsk() to avoid
  changing directly on the listener

v8:
- Add new helper function tcp_accecn_ace_fail_send_set_retrans()

v6:
- Do not cast const struct request_sock into struct request_sock
- Set tcp_accecn_fail_mode after calling tcp_rtx_synack().
---
 net/ipv4/inet_connection_sock.c |  3 +++
 net/ipv4/tcp_input.c            |  2 ++
 net/ipv4/tcp_minisocks.c        | 36 ++++++++++++++++++++++++---------
 net/ipv4/tcp_output.c           |  3 ++-
 net/ipv4/tcp_timer.c            |  3 +++
 5 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 13372d2cbed5..018e8ffc0717 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -20,6 +20,7 @@
 #include <net/tcp_states.h>
 #include <net/xfrm.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -1103,6 +1104,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	    (!resend ||
 	     !tcp_rtx_synack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
+		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+			tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_SEND;
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
 		mod_timer(&req->rsk_timer, jiffies + tcp_reqsk_timeout(req));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index aef6f2bbcd0c..a4d086ccb18a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6394,6 +6394,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9776c921d1bb..ec128865f5c0 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -481,6 +481,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
 		tp->saw_accecn_opt = treq->saw_accecn_opt;
+		if (treq->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
+		if (treq->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_RECV)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -749,16 +753,28 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += tcp_reqsk_timeout(req);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					     INET_ECN_MASK;
+
+				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0)
+					tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_RECV;
+			}
+			if (!tcp_rtx_synack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+					tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_SEND;
+
+				expires += tcp_reqsk_timeout(req);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer,
+							  expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 22728daed436..ed545cb033b6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,7 +334,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 160080c9021d..5a14a53a3c9e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/rstreason.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
@@ -479,6 +480,8 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 * it's not good to give up too easily.
 	 */
 	tcp_rtx_synack(sk, req);
+	if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
+		tcp_rsk(req)->accecn_fail_mode |= TCP_ACCECN_ACE_FAIL_SEND;
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-- 
2.34.1


