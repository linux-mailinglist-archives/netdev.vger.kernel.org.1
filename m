Return-Path: <netdev+bounces-255526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHDMMoiCfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:30:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AFBC439F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD88B308B84E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1438B7B9;
	Sat, 31 Jan 2026 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="a7XLZ3nv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E638A9C0;
	Sat, 31 Jan 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898362; cv=fail; b=GMP5gVCdCHSkEqEyN9X2BQbvJjFQataFbKTYNZ7hmp0l0E4WZzxXYsl+A9ac0EovP0JghdnaQHS6tvwgmqbB65eKcVpMkxvL9IjwP79JBe9D1/Wj9UMsJ5zQoyhc+tUUbfsGzfnmeuIR2Kq/XjkEz44DEx+WGGjbHhvij9qk4WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898362; c=relaxed/simple;
	bh=R6Jwm6rEe0uIHAbjG2An3IcxodMf6ZIHOKHK/eaZqPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnGabYTUNF53ahIk8XFp9JN4GozY1JUsj28FBBcUtF2dxC2IQJIdzndsEyK4VCGHZdDJfntAJ+aJNA9JSf9qHl3Z4vQfNvjvRz/qQB5pVfSymfRf5ORpS1UtKu8KrsNX5fUYaIrKJh5rZsEqKwwDOIszR7kWlHbZHxy0kW8Qm2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=a7XLZ3nv; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4c99fEM+56MBcbZ2qH0fuwzzVJh6GLHCTp44Ez8v30IL+2Blw7mUQlMxcyjEvqtrLGBFvtJ2AWZzJSd1GGwia2gRd1D16cD9atkztEExzcpkZEfQPVrVFxbPTJj/TSdVKzi0X+gVtfn9lS5XFFJ1r/zsHcEI3+DZ6wf3K86coROLLKPSBXo/xRidMoD4jWMksYA6ZIu9pJWugcoZUZ+xJH9g64slBQJvN7LbTuoWWrtIrrWxuJyfJ7d8XM4306eadBpKatlnXvG0XWto19iQcUSW7J2877Owkuji+SPhOFAe9gczGmlfaINYdt12rNI5lQgMO5uTtrhITaaSflHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlK3Bxn0IeFnWtFyT2iAJ7XYdpxqcUgoM0zT6soEW38=;
 b=hM4JNedn5bnh4DnhqVQiEaVRQKy1lKFS4S7a/mtT0kKh1/6L1akT6Lts4WLesfr0kD/Fbv57xYfWrxqrAoGnnmLnztJpUExGqEcYckZRdh9k8WTcwLBZDP6k1p0aG2z7+LuYw+dab9lesA8hx3jDYxsoVqs7BP2USu8XcTDeLCdP9pdF/VNVekVNla1lUoxaFUwdIAJlDHZmfDzT9x0/t0cDOoQb6P5JcFHus75ayrFHzxPJB1IDVh4HlpPDg2OCCf/3igJQrV/Ap6hiCLGWnzyYMZDjqbsRUdptPIfkvLI95TYuQ8+9KhXs+3CgOUvMHdsl2gt4D7Jxq1LvPR04kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlK3Bxn0IeFnWtFyT2iAJ7XYdpxqcUgoM0zT6soEW38=;
 b=a7XLZ3nvvWxjqnWCoJZAqOGzQhilLpveAcjLdVe/0E17S0COYrkY/Ce3otCbgAqiCcMCI8DSds2caGAEASmTUW8r4Gb2bKU3A3XzL7FKL0nA9dSYyxxDp8wMbHHzuVpgC9N1Sctkf7HRI0X0p85FOpF5J45j5gk68uJJNP2wf0IlhSRnrtBrpl/uy5Xb5vDIvaPbzlH/84DnJmFIhPnznZp8Dj0SKk7Rpom6yyXaopVtBqlaJ/q+zKMxJzE14S6SroA3mZNx5ooy+lJUp918EXKlMmljAoLBZfv7E0N4Hu8LWQsneLDfxR3dyL5MYcVBn77kEGjbehllrAhclJzMIA==
Received: from AM6PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:20b:2e::15)
 by VI0PR07MB10892.eurprd07.prod.outlook.com (2603:10a6:800:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:51 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:2e:cafe::d5) by AM6PR05CA0002.outlook.office365.com
 (2603:10a6:20b:2e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Sat,
 31 Jan 2026 22:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2AF772397E;
	Sun,  1 Feb 2026 00:25:49 +0200 (EET)
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
Subject: [PATCH v13 net-next 10/15] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Sat, 31 Jan 2026 23:25:10 +0100
Message-Id: <20260131222515.8485-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|VI0PR07MB10892:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44ca557a-c50c-49f4-77ee-08de6117b09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1lKvYz4QQ7ZuiJ/0Ek/ua6DsWYI6vasur8ducsJJSsffc+JR1DkK7c1EWJK?=
 =?us-ascii?Q?WldpwvPX6Ds49HPnl6N3Ow2FwqfwgcwkE/lnLL9j4SOBh+Hw0D5TScf+B2+7?=
 =?us-ascii?Q?SaibnUGzYPKxzIJw6ZHWhdrRas7jkj27t9TxNBkT4Sk+ggcbuj5r59kbJ0QW?=
 =?us-ascii?Q?DHAaIXcHtOYnR/FwafmRDRsjpdoO1X7s0mzNauPiNdt4v2EX+B5ySL99Yc81?=
 =?us-ascii?Q?LjhiIJzONPYtebngigBv7CJ6nwRTh8RsU8iPXyob0wFklRrKaoHwHz/Fra26?=
 =?us-ascii?Q?lReAgaSaXSNx1s2R2glZLqgaF3ObA+AttFw9Sti8AWIZs7yE3Bcc0cqQ5VcP?=
 =?us-ascii?Q?ExxZfoaMd0EpEDpzwKFqav+5wmrTVHLBQyGCXcB376mRfYUnEB7ulXgRHSZ5?=
 =?us-ascii?Q?4kBpObObPqPrOYsqhRii1fvpcSWSfgRzdf25xddI6czmT67t6pgsN4PBOO0f?=
 =?us-ascii?Q?nqenDIpmNGbM2Yd3Oz+ncBJ8hPlmQFHmrNxom4lDOoutdM4TQabynXdTCc+x?=
 =?us-ascii?Q?aN/Bn3CthioWWWqoMypciSHpr6LmcI2EFgl9X6YI+YJ3SoBF0s9L8mWbCKXh?=
 =?us-ascii?Q?hwuL/cyE/e4j6UpB+6lxKDqkTBqF8gD00Ord0e+8PobVzWP8VF3/fHHRQ20Y?=
 =?us-ascii?Q?pHeQf9ehBPiWAvOAAzDeGYbu1cStsSijVoJkrwkF3t81TAonqaHNHVq0PyOx?=
 =?us-ascii?Q?h253KruKXFm2yG9Y5lgg15UbVmZSH+2lEhwYwh6aGqOXDGgrkOfhwxM4m16c?=
 =?us-ascii?Q?fQ461KXkg1w+rKWUWi9sKmR3C5G9SlwRE4JXliuLGF4L+4gqPeJ7sw4AqOVD?=
 =?us-ascii?Q?ab473dYUFk9eurcjTKCr30NJPMFiqJ9qm4TCR+lQYQknRm/nEqdRA/I/MI4j?=
 =?us-ascii?Q?fbFCHB4G7lbVAHLSmgRxDWEt2M+nyHVZzZ300LqfWJgoi8ZuHBooUX9U9JtD?=
 =?us-ascii?Q?99mt6gW3cfDZw68FdwNr3tmEW+r8ud2UuMEYqPKoCd+kDEJGh1hNZq5mJsxy?=
 =?us-ascii?Q?Fruf1nql9n+5rzE+i3iZXvb+sfaYF0eLuDBPwU/hZPRHuZkKNLNC/Bo2vl8R?=
 =?us-ascii?Q?LqrWwfSz1wStV+ZQjFi6K++z5cNrQA9rnRGODiIatMkvUm5sxyyJc79aRBRK?=
 =?us-ascii?Q?vemlz49JvnC5zTZ4RzIj83lhyxoTzbeD0qbaAeAm73bdIne3x8weL4w+B/tV?=
 =?us-ascii?Q?mogwjZfod76XPNwG1BFmUeIpdiKL3hP0+2oBid+zgnzTDeyHl37epmxW5jV3?=
 =?us-ascii?Q?L2zPl3tSLSD9+WLj8lMcMErf4H4WYPOx3HG77hhuH+Hx3g4hsEkHQ2ML9ZxN?=
 =?us-ascii?Q?qQhrSR3eLk/uyHRX62phsoTHfdkfzV7ljM3nFcF6Md20gg8tL7Np3iyj/aed?=
 =?us-ascii?Q?yvgLaqKcLxdZ/S4BJc9Hc1nB7bIq5ncXMgPQH9B8F+/ZSS6BAOA+4nCUtnAV?=
 =?us-ascii?Q?Exy/aMOeNWIzCSwqT8xSBlS64HmpdM8v1PKERurQ8lX1INov1/V3eb6dxdzA?=
 =?us-ascii?Q?aN5ejMcSx7YrGBY+EuJdmJp/EExnIK+CKczBHzzYB6aJjoa6X883vNYX9piu?=
 =?us-ascii?Q?RIR8z0ZPMThqzR2qVV8YC6XrzyItC2SHV+Ketzr0rN+vu9eP6HRohE385FE7?=
 =?us-ascii?Q?D/Q+CGOo/sGL8bdDPXmmUSrjfnwRzkpQBaNW1ZOCWVxfFEJYU+zMT8ca6t9e?=
 =?us-ascii?Q?OEQL3OvpNM9nwVxYTZ/SGMfSciY=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xOQplVYphvAd+Nu3DcVaF2lZo+G/IMLeS+Njdqdc0bzv+w5kJo992mWQZKBT6BWtjU53Blk+1fHYX641Ersf8Ini4UvivdGHs73qIPSESXIqThcqX3S51Wi/3y/wTIf8B8lxNnSug8lbUrdGwlnEECK2QST4FwWL16Gp1PcoIcnONu23vabRLBoI57cju+BZR0JkBJ2ckhqbqms0/qTvpsZq4uS1hhdkEgF0GZXpk9Lest9anO7Jy5Gt9hRgognD+Mo1jqQaMv0Q6j8aVkdr55qdez8++KtCetcbnK9R7LkvmE3L2BHoeczvBKzV0YtM5ZCyDoSaZN0pYkhFS2MTkGfAOUirWI3Jrr0hLKMVjIka2wxGi45UkEIPRRSNgetFj+jQveuz2dZkbWtyMTA0sHlmlTId9LYMalnHII3O/nSUDCFNzHDMWGL9JYz7lR+E
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:50.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ca557a-c50c-49f4-77ee-08de6117b09d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10892
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255526-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77AFBC439F
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
v13:
- Add INET_ECN_dontxmit() to clear any previosly set ECT bits

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
 net/ipv4/tcp_output.c           |  5 ++++-
 net/ipv4/tcp_timer.c            |  3 +++
 5 files changed, 38 insertions(+), 11 deletions(-)

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
index 59dafcb45c16..988d161e9918 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6469,6 +6469,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index 22728daed436..2b356fdbf2ca 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,8 +334,11 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
+		else
+			INET_ECN_dontxmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 	} else {
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


