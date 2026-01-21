Return-Path: <netdev+bounces-251919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFX4Id7ucGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:21:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 236925917E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8056AA88B77
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B1D4963B8;
	Wed, 21 Jan 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="hRZYy8db"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E736A01F;
	Wed, 21 Jan 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005953; cv=fail; b=NrL1sp2L7kj6LIsCXC1ir5VPw6n2eDcGmFLtnTjNvtEKKB4JUYo51eJ5uRqRscBsZ3qk5WPgABDX1b0JaqmABnEvutnQJTcikB9TNB2BMX31FboMLy5sk3I2IV7e2sJeHbfhFAiF+WQu5JIwvkXtIYWkwSW4f0LeNMVct+5LcrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005953; c=relaxed/simple;
	bh=s1XZncvgOh71GEK9Ajjd7vgKSOe7HtAgxYOsw3C+EyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSGHhP7eQAJkUSkZt6N4ErfoGZG3nTKz7hzXXrZJZ66Vqqvcb9CqlP1+WN2WB27q3AmT+lc0GzZp43lahO1948pAhzW8wKvjaiRNwnYXNJ0D6PX+jGlNPkrpwD1aOgCenLLS7aznw1EEw+XABB360FDrlzyok28xWSTOPNr86ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=hRZYy8db; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIDZAn6YCIYUPk065YbNDm39VZYIePbfhpP1bIC+tJCjjZyt/BodjXi9XuYmqiAAEr5YdY+vHaEbxFqFD1q89bhXjVKRBRq3CoHSEC1OGVvQVvvrSDYGX+OO+MFtCpEIDa5Ndcvk8rItsFx5kR601Oe9j/S8o6WnXBa09f10aYP/HLMub7eCgfEUlOFMTp2KcoYomqIIU8VrlVYqKjIbjJja7LH9jfzMktKqbbT8gXWB0pwycNMTWAlnHOmYT4LD5EWCNgI6n8KlpSdkDw7ZZRT8uw16Clev9p/OAXrcWAl8tIrWzguBykL9PWcMX0AJWsQCzRoe9AtKeWNortOKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=rUf9diP5qgFTYOdw4Cq0cNYbV86Coc+Fdqpd07gbRtaCjDl3sEXlwr9GFwi0hgginZJlYQCPxgtMTqUrAcuVGYle4EW4zCqn6thuPx3rmHVRmgZUYonGEqaq4I9/WDOUTvIILPNThaQt4CxRcUlwmxUieSWMEQCkTku6kMmSGXgKCz89cpG+Ky3zvbpytOJV8dq1zooKpUTal+Sbw3pkibfIb5sSw3yOkX934+J6JLwHvzwqaR/2g0dhArUuChUZyZps6ohqG9yhj1zAz7Vv048eJVoaM1fS7JcBGNiZKspfxrcwAIZgjWPQRhBp47RoTzwBUPuRknP0NEM/Q3c3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=hRZYy8dbzjzFuUUubzB4/ZvrZ+lrYTkEz0M3WFoGI/lT/OQUUb4ICUWvr0zUtqjbl8DS7nnLV4busOIJJ8SGy/nUkGTxGpElhAyOmXPfgV5hVO+MuOifcnehsgKmkBdD7vnYVdvhjS11illifg+/+NUg5B9ywiEfF4rWstUTEUG0igIgxOrkDaW+WR0zYsV7v2oINtGFFYCfsg689u2T1A9cWM0GoL8/9aZzrMZlEAJ4cIKfHm+dMVNYJhf8F3PEryasnrL7FbK7AUD2UA3+b7B09Ea5SMPQyQY3fHl6z5YySIpCPoHhPU8rdyjVFYDURM2M9bgU8VB2axiNEjL7Zg==
Received: from DB8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:10:110::16)
 by PA4PR07MB7085.eurprd07.prod.outlook.com (2603:10a6:102:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:26 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::7) by DB8PR04CA0006.outlook.office365.com
 (2603:10a6:10:110::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9F2EE2051A;
	Wed, 21 Jan 2026 16:32:24 +0200 (EET)
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
Subject: [PATCH v10 net-next 03/15] selftests/net: gro: add self-test for TCP CWR flag
Date: Wed, 21 Jan 2026 15:32:03 +0100
Message-Id: <20260121143215.14717-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|PA4PR07MB7085:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8424a9d2-1100-4fc8-225c-08de58f9e627
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ZRoRZ6Dw+w05vwNLwESLS9knGh33vF6M9Zt/lKmSOBhZO2Oi3i3PRrsXdmrl?=
 =?us-ascii?Q?KXcCQ90xB0mpFCg1/qRU15jqZXoMCIGtqWgr+S3Vkb9AbpfADFfXp5NbrcXz?=
 =?us-ascii?Q?MavDI6bgUGdoB0HZMiEt9VWZK2MKB2NmddCgigzRhcycSR6BiHrRm7wUXZgf?=
 =?us-ascii?Q?AsRjPjpXJ2mt6gMEb+EtAbBWky4ShI296EYayi/uR3zzK1dUDMiiKvaS9xpy?=
 =?us-ascii?Q?KkqqDsvFpCaKZPPu63TAPft0htJSZfGOVP1Ei1B0R/c6Efk1BgyGvlQ9zQxm?=
 =?us-ascii?Q?tIiYjLB13QTKWR0zYpBN2+66dtvYtcEpytNKU3v2phAhQtwKCJ1RYLt3HZQc?=
 =?us-ascii?Q?TNiN0zBuIkOHwnBqObKTGyL1cLYKvqdKKBjDT8rIyY8MAj1ejm1caQypMW3P?=
 =?us-ascii?Q?ugBc6LSggetgLU7T6kENT4L8CNAhoOOto18SyWHU1zD+Qafjp9DXsGwqXPp4?=
 =?us-ascii?Q?cBu6PWHAEzc6WLKMgzTimcxC+qPFpEDocwnw7Q1bqX5SDSPB1HRoOXc8TNoW?=
 =?us-ascii?Q?uu5jaVzzfK0W7h9DM1QBrLkyN/jRJIuKTJgjxF0tfb7Y6pVt8iUJPyLxIhUl?=
 =?us-ascii?Q?mjBXVkCYSDg6AR/pYXekqdOnC2/hSuHAnuhvLL5taaF0oeNlwWQEXI0ETSJQ?=
 =?us-ascii?Q?38QSG7cfmxeX4f1tUv6eOOVUcLULQnA5dsS15u40qWnGscoGwPLnZNG84AqS?=
 =?us-ascii?Q?6XkhZSNrer7sbmWBHL4M542LvmCVkwfnHpMXnnmgAG4SQiPb1lTA1GJTF6r9?=
 =?us-ascii?Q?01KneaMs85f48UoKyO4mKW0WBQdXCLINKFj5opimsouKVgh9gRMfABd43YtK?=
 =?us-ascii?Q?HKVSx2M4BE62VpCHgcA4d1xVG9GdngIeSFAXgdjAPUEo7BcO4zf3vfXlxRQM?=
 =?us-ascii?Q?PqGjR7CMiI9QdNEN2wZNWw/oflCqmIdZnWs4e5a7FBOG6RWY1vlB3EB/iSbZ?=
 =?us-ascii?Q?BTvLgSgr8ReGba1PXrOR+knD/25aIFkVCLc5tYzBVlBU2nII/1IA2cDaQ3Ia?=
 =?us-ascii?Q?Q0bJ/vt5yplNdXqZYJqQVjwPYlz3QEwib788BOknE4BI0qCO0nFgD8g0nd2U?=
 =?us-ascii?Q?LDGlzFkk7nTzFpao/bwy20fqF89gzvcaX/59c/OZ70zgNKAhOCBVPz9vil/r?=
 =?us-ascii?Q?ZO4Czbw7XS6aoOkrF28vuVJpGHN8v5bZBEatToHjl4EhnlAVeeAohCwtGIii?=
 =?us-ascii?Q?QBeaqO8mVweer7GLtIXAny7DtME3R0BgOFGua0n8iccE5aDF6l6lFfjYsQUr?=
 =?us-ascii?Q?8SSQ3xFVgvexHnDH0DhPJstEgfwnoFySSh8+IXPGT/c3oj0z992M9sus9IXq?=
 =?us-ascii?Q?by0Pqj3yhk7ybD+4mL2Jw+2B9/1u+189DvaRVfObMP0cbffbI5L2TC9gTZQM?=
 =?us-ascii?Q?mLYyKjeOLiVlBUPVfjFTdreGvVvJwOqaAdqFK0MDdNASnTMKpUBQgLLGynJK?=
 =?us-ascii?Q?FuS18DiZwqhveKfEjnh2Pxvn3CotSuwCLTUpt3q2ghqhgNYrJRhh94RJaV9V?=
 =?us-ascii?Q?lYVaaO4VAxwxGhSg+6xO83I3WG55H1kGD5/4bBmB4ypPlCAGKCc/Ffi7niBe?=
 =?us-ascii?Q?N6yLCRxViU/s/yOlm/TrpFgKyI1GowQXKcpMBcVvZb5A9k6z3MiZbkh9BD9w?=
 =?us-ascii?Q?Trs06QXFRBAQMG4HlB+qBbqfDcpFB3g2drLsDfpavcBVdkMeVcGIKzcSYlMC?=
 =?us-ascii?Q?3HN1zshfrMjaUkeZHd0gpfPJwz8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:26.3750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424a9d2-1100-4fc8-225c-08de58f9e627
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7085
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 236925917E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, GRO does not flush packets when the CWR bit is set.
A corresponding self-test is being added, in which the CWR flag
is set for two consecutive packets, but the first packet with the
CWR flag set will not be flushed immediately.

+===================+==========+===============+===========+
|     Packet id     | CWR flag |    Payload    | Flushing? |
+===================+==========+===============+===========+
|         0         |     0    |  PAYLOAD_LEN  |     0     |
|        ...        |     0    |  PAYLOAD_LEN  |     1     |
+-------------------+----------+---------------+-----------+
| NUM_PACKETS/2 - 1 |     1    |  payload_len  |     0     |
|   NUM_PACKETS/2   |     1    |  payload_len  |     1     |
+-------------------+----------+---------------+-----------+
|        ...        |     0    |  PAYLOAD_LEN  |     0     |
|   NUM_PACKETS     |     0    |  PAYLOAD_LEN  |     1     |
+===================+==========+===============+===========+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v9:
- Add missing comma

v8:
- Rebase to the latest tools/testing/selftests/drivers/net/gro.c

v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c  | 81 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  3 +-
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e76c618704cf..3c0745b68bfa 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -17,8 +17,8 @@
  *  Pure ACK does not coalesce.
  *
  * flags_*:
- *  No packets with PSH, SYN, URG, RST set will be coalesced.
- *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *  No packets with PSH, SYN, URG, RST, CWR set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg, flags_cwr
  *
  * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
@@ -360,32 +360,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
-/* send one extra flag, not first and not last pkt */
-static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
-		       int rst, int urg)
+#ifndef TH_CWR
+#define TH_CWR 0x80
+#endif
+static void set_flags(struct tcphdr *tcph, int payload_len, int psh, int syn,
+		      int rst, int urg, int cwr)
 {
-	static char flag_buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	int payload_len, pkt_size, flag, i;
-	struct tcphdr *tcph;
-
-	payload_len = PAYLOAD_LEN * psh;
-	pkt_size = total_hdr_len + payload_len;
-	flag = NUM_PACKETS / 2;
-
-	create_packet(flag_buf, flag * payload_len, 0, payload_len, 0);
-
-	tcph = (struct tcphdr *)(flag_buf + tcp_offset);
 	tcph->psh = psh;
 	tcph->syn = syn;
 	tcph->rst = rst;
 	tcph->urg = urg;
+	if (cwr)
+		tcph->th_flags |= TH_CWR;
+	else
+		tcph->th_flags &= ~TH_CWR;
 	tcph->check = 0;
 	tcph->check = tcp_checksum(tcph, payload_len);
+}
+
+/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
+ * pkts, not first and not last pkt
+ */
+static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
+		       int rst, int urg, int cwr)
+{
+	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	int payload_len, pkt_size, i;
+	struct tcphdr *tcph;
+	int flag[2];
+
+	payload_len = PAYLOAD_LEN * (psh || cwr);
+	pkt_size = total_hdr_len + payload_len;
+	flag[0] = NUM_PACKETS / 2;
+	flag[1] = NUM_PACKETS / 2 - 1;
+
+	/* Create and configure packets with flags
+	 */
+	for (i = 0; i < 2; i++) {
+		if (flag[i] > 0) {
+			create_packet(flag_buf[i], flag[i] * payload_len, 0,
+				      payload_len, 0);
+			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
+			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
+		}
+	}
 
 	for (i = 0; i < NUM_PACKETS + 1; i++) {
-		if (i == flag) {
-			write_packet(fd, flag_buf, pkt_size, daddr);
+		if (i == flag[0]) {
+			write_packet(fd, flag_buf[0], pkt_size, daddr);
+			continue;
+		} else if (i == flag[1] && cwr) {
+			write_packet(fd, flag_buf[1], pkt_size, daddr);
 			continue;
 		}
 		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
@@ -1068,16 +1094,19 @@ static void gro_sender(void)
 
 	/* flags sub-tests */
 	} else if (strcmp(testname, "flags_psh") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_syn") == 0) {
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_rst") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_urg") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* tcp sub-tests */
@@ -1239,6 +1268,12 @@ static void gro_receiver(void)
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 
 	/* tcp sub-tests */
 	} else if (strcmp(testname, "tcp_csum") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1bb8af571456..cbc1b19dbc91 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -17,6 +17,7 @@ Test cases:
   - flags_syn: Packets with SYN flag don't coalesce
   - flags_rst: Packets with RST flag don't coalesce
   - flags_urg: Packets with URG flag don't coalesce
+  - flags_cwr: Packets with CWR flag don't coalesce
   - tcp_csum: Packets with incorrect checksum don't coalesce
   - tcp_seq: Packets with non-consecutive seqno don't coalesce
   - tcp_ts: Packets with different timestamp options don't coalesce
@@ -191,7 +192,7 @@ def _gro_variants():
     common_tests = [
         "data_same", "data_lrg_sml", "data_sml_lrg",
         "ack",
-        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
         "ip_ecn", "ip_tos",
         "large_max", "large_rem",
-- 
2.34.1


