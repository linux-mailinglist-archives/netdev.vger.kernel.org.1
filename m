Return-Path: <netdev+bounces-254289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHsMMzUfemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:37:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25BA2E68
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C56C3073DDD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F93635971A;
	Wed, 28 Jan 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lieWawNN"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2F23AB81;
	Wed, 28 Jan 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610898; cv=fail; b=n/CJeajGcY1LC5lUgj0QjJpFXIbHyI3Ql3Nh3gzgJS6RT3OTDOa2hP4yoFx1VaICuGhNhoCyQ91Bj7pCdC5bYximYGQkta49bJTJnwCVUBTeg2pShgabKe3+SRgsGvKOH+rQZleDzZTlizYFyANbC7jPGDnIVSZfGUY6wUaNEok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610898; c=relaxed/simple;
	bh=QnHh/fJ2T5iQaKg34Ot+lLxWo2DBXfgBeqqAD1tMjOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGE013nCWGGAR/jLQGhqFs/hPchtoHJdJOZrV6wG2vdXi1UBKo4SmPB6xMvDJur3y7LZgL8xm7FpaV1klEaTHwHiA+E5H7Cqn9VlnX/W1dl9s1Bi3kqZ/LVKZgxEzTw5mnxZaIgfNveAJ8trSLPnxMvSRVUIPKzX8KBWx3k0ujU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lieWawNN; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4YYrxP1ktLscMEN5sRo5Fc44XEhs6mUhJ8Bi6Z5dtYEDwuUGrfcMx00xKeyhROL81IW2P2f3HXdFuLGyi/nYiE+rS1TzKwAmklWuFd14LK3LgdS2Y/dRrYoJvJiFB6ScOG91VsMQgxmlzZZOixnB48C0AiWqbla7ihABgYFvHMohnQIv8W9HRuX5zg4T8442oWKsykHotDkpNxW5ytlhxMC7zTs8+YAZi4cDPsoNRec1+O4kaxU/MaI5tu9nxB45/y7sw8Zh8nQMT3wX36afgeorSdmdBRIdn6xI0dJqngqOh5ycmPyZ9tsluw/98zTV/dluBWKyrT2yGLrVnKsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eltGCKg1pWq4cGc5yivHhhE58zndSpbeTPjlnTQwfVM=;
 b=SKs32qse/qvz0MS2s3uXeyjHtrv/01uA4971Y24/FNkQxIo7LWX/01+XEXPsBhOIWx6n8oAWd4qINtKlnf+1iJUgzR0PaauPEUT3xj4Rgbej3gcMbAikUxoiGRt4Z/+b7JnesqfJwNRz5UBjVbJyPndKDpJ41MCAgVChgQp1CWqeM2apQg1WT0RW+mTRHVhtgQjKTN5rqrWcY7bnqidwE1h0GmE5Ch7HZlm/LIrdDUf0FC4uC9sf5EwDzSn3MeGRTjY1y05iOVaudD9rfY/dGZDhBIMR0CF95R8ug//KuXdfy8fozL7f6ROw/HGmHXF6tPNedANNG0BCPt6qqnuuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eltGCKg1pWq4cGc5yivHhhE58zndSpbeTPjlnTQwfVM=;
 b=lieWawNN+VyiWXwXkkXPkEqXv3QxECPgAxq5y3MR7qbidnMymcClBXf2wmSB3Nvsc6nB2ES5agezHE4+vHBMAjTBXhx+dz/DEgSgEw1sF5pF9/WNpcJq8i20iU0bWC2xGgkbT5FaRm7zBTUeEmXdDlN6Y1U+dh4zZeBwbYqbpF22tP9R0OUR2K118+EIWE5rJ07DzuNsMwV37+pAnk5Dy2MtDoe1cKoKITr3FTkGjVDyw+SbPjU6d+6dpZ5OWqvFBCcUVU4LP7d2fFQ1hwRC7JCLeQLFk3AVrgDsmRd+W59nU2w1IlwmURIVhAsmhuz9/RQJahGNr8uwrHayaSSAZg==
Received: from AS4P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::14)
 by PA6PR07MB11612.eurprd07.prod.outlook.com (2603:10a6:102:51a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:34:50 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::b6) by AS4P191CA0001.outlook.office365.com
 (2603:10a6:20b:5d5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 02E9923656;
	Wed, 28 Jan 2026 16:34:47 +0200 (EET)
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
Subject: [PATCH v12 net-next 05/15] tcp: disable RFC3168 fallback identifier for CC modules
Date: Wed, 28 Jan 2026 15:34:25 +0100
Message-Id: <20260128143435.15708-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PA6PR07MB11612:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89155f39-4fe6-4166-e50f-08de5e7a645e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?slpur11wX5/staAZtK8gPF+A7+WQAmY0KYN8QLTcUVUlNFi6ygoy3ohB9LFg?=
 =?us-ascii?Q?dzvzAvzSrUkUw+WhViBfTPAES0jNdBn6IQ+uY4mvYyF4T6SAuthzVG/p+eF9?=
 =?us-ascii?Q?9YHELL4VVlsYojGc6U7A2jhw88WgQfLog/nbyuiQC6QPSXONhhRQ69XHgZjp?=
 =?us-ascii?Q?XkTcvem+Vn0lhQ//viE9ijMz7NwG3bv0NTtVJyAs8k7OMVnDcW5uUq64TBxN?=
 =?us-ascii?Q?rKTJxQyuu4mHVOQpiacgK0cRXagDs6IHVvjsuq/jr4tp9N493tKco+ykFzgZ?=
 =?us-ascii?Q?DjxHuOO1WmHi0VSXyZmF30zDXJAZ+Sz/zoc8CIHroHkaUPUh9a15Zf1Y94Ez?=
 =?us-ascii?Q?StjnZA465S2q8c7Sf/2fjniBjSWqBFnxWPHd2noMFTS7EgYUBkBshfxNMSHY?=
 =?us-ascii?Q?7W66nrUnJnotWRlQdP1nNvtjwPH+8fg00s72Nlhtr6ySvO2IIJY1qwE2j0z/?=
 =?us-ascii?Q?tOyxpvuLngAqOnvkj5w62Z7zOgm+bzAu5ZffPURf6N+k80rMJKRoBqdod27/?=
 =?us-ascii?Q?Ee7mQvvI009vwfhzuAKBaacQEXz4GoGUtK0f4EXmP0hlhoatj6gpDleDAbHx?=
 =?us-ascii?Q?nZazUKvuYzkPC5NL/DnjTydDJp8uMN0tm9I83uJ+Xxox50GlsMxA7BSMTp9H?=
 =?us-ascii?Q?KaD47HRN2scinfV0R1WAeRQL42VqRer3c9GiWBuXVYelyaaRV8OBWQU/N7FY?=
 =?us-ascii?Q?uBNyYmMCumVj3gKsSiTg/1DVHjzrZlm7ItUiNLSAGrbFKYThpBuckVILmOWZ?=
 =?us-ascii?Q?MroJ7ihV9NI5jsG8MfayilJsZJGmC+oRlf/dnsFSHRI8vuFohzZGP9YMaylw?=
 =?us-ascii?Q?LdIbeYXrsRyPlV+2kR2jY3BdCeGCnEbOCDc9uwLwZEEafRFpqmrtPiC6Ks4M?=
 =?us-ascii?Q?DLOx9dGHBrS4lbzYP8sGIFnra79Rvtyrwksx8PyYUwrPm8jhZW998HAfo4qH?=
 =?us-ascii?Q?ccA0bPrzhF3geW6KY+qh9xcYtFu9y2NPkbpG8sICXyF2y2im9mjntfo7XOfJ?=
 =?us-ascii?Q?rwf5nktLJmDwd8HsfyTQSu/cMVeha1y+FpsoGoD25RuBux4XdS86Q/lC2K+w?=
 =?us-ascii?Q?laxxLp40Y7VjldKkZepc88s5BoaQhmjDbttoNIeQNHqao+uKY5psdcZw7WcB?=
 =?us-ascii?Q?2E0Xf1iX9yOo/iwD0XwVH2VXsmkTbYXbAI4jbNVRgJbKF97eD5RKPZtvlaso?=
 =?us-ascii?Q?wAChYYTUcJKZ98vRuqUduVHC4dk9/amIT/uj6SozcdX2Hqd90OESJ7A/IeXF?=
 =?us-ascii?Q?HvdiTJUnVmYGkHkQ/PTpKphxNMxX42pM5ANWIrFohwfVsx8rtwlxgd55uwez?=
 =?us-ascii?Q?sCyJBRje5DIVNsDS+fLBli3iYWcFoRIfyW6Fud3QWSgjgCDoxw9Tg/mUymQD?=
 =?us-ascii?Q?YQYYQQiNCyqMF1QuM7/TsrmUPbf+Zk0MHSm6f0LEWNfl2dVou8qSr/oeE8xB?=
 =?us-ascii?Q?1w0tw3lEuwq11F6j4TKOVVYBK+zVI/t5qTTvOBDBktywiGZ2h5H8ICC1sOnL?=
 =?us-ascii?Q?phe6Ymz/970LPdPnRIfRA4N0Vomf8XWvsqSa+YWgwz6hwot/uZ/KdX65T3vk?=
 =?us-ascii?Q?yLgNPhUDxyMLfabRM8/jQZVq6CNgxqB+X9LFQZMq16sg0utan+feLcJ6zFGf?=
 =?us-ascii?Q?mFzp27e2Y7nO9L+hRMESuDcQxs5CAAHuSn0uoJ20Gjg0n+/liB4JB6hoPdZE?=
 =?us-ascii?Q?ToDVQA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 6idOBZiMM+u1ZxfHxSUk3DUGg4/dN6tcn7cB9g9cEGqcuic7EyUpwumcKU5p7TDQh3qh+ICIEu6qC0sDQ6VyhK8lABCheJ/qt96OSYIU9IOdl3PgD1SGhqDQA6oYU73hx/Mss0TcvJaTA5Tfcsup1+XLe6vQvbt+X6DrU45bZ1KfMQMXzYUIokkCv8MiSo22/TfFwFYJSfxLctPZmpdkghOdRz2ZW/WnzQhy+HGiVKicHrLQ8SfYOZ6VTLKGegom61BqVvhB52o4WDvTue/MYbBZKLyKCo+Y1oCYkqdsZpV5o13FE726VM/CPTmzSGo7+r9HXUTeCQVFql9VEr9tU1H2p1ZXDkmilHeuSxJDHQmb7gridzrgi4psccIIIXFb+aAMJvWI1IS95HjJ+RnLS08KbAk73Wcs9j1lUKL7CRqELhRUPrrtxVqP2eUf+zBz
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:49.5225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89155f39-4fe6-4166-e50f-08de5e7a645e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11612
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
	TAGGED_FROM(0.00)[bounces-254289-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6B25BA2E68
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ba347b87a63c..7965d4bfb4d7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1208,8 +1208,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1364,6 +1367,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fdde1c342b35..2e1637edf1d3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cbc8e28fe492..aef6f2bbcd0c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7015,7 +7015,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..9776c921d1bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -485,9 +485,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


