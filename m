Return-Path: <netdev+bounces-251928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGLzFbLtcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94459061
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A134A2EC87
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C8F4A33F3;
	Wed, 21 Jan 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MbDFvMf4"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7A4A2E1C;
	Wed, 21 Jan 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005971; cv=fail; b=moNBT0+fqKy4JiblBJ3/+ltXxH2CkNXGJeMgRDmptZA2gt0D26pB5bUUEDuqMQaoRi9pIzT4mrFeglXZwOyx/jcWjrXLr026eKLObGj4XtA8LK0fweQ+TEek5X+8FjziKDZBHR/EYUHcj1nZL+8vKcGH7RFo3KApc/xZVJdrGJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005971; c=relaxed/simple;
	bh=0h0Uj///Pc3ITts7Wt9L6qfs9EzLlA8x0SVBmOalMhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHJuXUQ9flgDMgiYgXhZh5T5NipEG3K5wYDI6REwmckZf2/75Z2SVtNKHczAoCg6dk7BcmkRlam9qvfqHmyoDg6a71G8tvIwAIIb+PfEzS3XHMio4K19Ho3rHsDqpZa3LOlK2+WzRvsO1z3IzMA8WO2ECLiCS6LhbZOyf2f135c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MbDFvMf4; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVlIHgSAFyjIACsQyAghHsjyMRanj1CFEw+a/669FM2hTjLZ+KE5hb+GABCjf15zgVxh1DJswlH3mc6MduK/OCSsCb8wATvgjJ/W7VesHlPZ6x+G33t+IS7ZVbvWVpYfOYhxEHRUxmhCk8zG5MtRgTK02h9I1PlKHWo2pK3VXda+og3NFsN+LiVqOI+fuVau0H/vhUe0/+8BMF6VNhjJkwZllZrb8i+UKupvy7P/kPzx4QtanzXCOiYY/jReRlRaKAyXfF23vr+fO1qQQqA9xq6mxRiXwjg81w5SdX//5WJQ+A1Uq7yf9t1IPOs9DkArIgtAlLM3iSVNBxHm+Shd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFdPjiuisN93qkh/KM4qkWIBhM5A3Dcu8r46rlzv088=;
 b=DJ9cSgvDffMCm8Bqu75KzBIovkH1hyoNQcR8btgDKtrbI+tOU+vzPeWOZ4VvPQjB8XXj+kPtSiY43qB0FljXYt/+B3ETSSl/oxAVkPiSdvHXAKeZrMGjA4D0awX4NxLmzP1JBNam55r95n6GEJCgzhHXri71FgIZayvJW9DMvlNH7YiZzjWS3TTVoC5tt1Gs3zq4iO4c2yJfWnlKWaD8ue4QhGyTxQ+OW8IqSaThy8KHLuu4RmO+xlc9iMulTwkM2RfN2yE0jYV3JMA4JAMHGi0nQlh/rbbMVLVlPawQQ0rp7AtV6lbii+RC/rAQrOYle9kGeJWLT/HdhOPrUO515Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFdPjiuisN93qkh/KM4qkWIBhM5A3Dcu8r46rlzv088=;
 b=MbDFvMf4E6kXZYdotsacTsjxmsSNgl4qxUBaUDMG3fsEPeRBzkbc/b6ORY/yKnKjose40BJriAbrMTKajFguHmTxxcHrFrADTz7QE/DF1UvzSs8UepH4XbNw6OW3cURFa29SMDdsUtwL4SkzCPFvwfDvsjAyPhVJh2Fcq3enkwuEfdpU3xTxMCvDHBpD+WA5I6E5YT3EDDv4tK0L4wIKjU5aTu4z4f9xd8THrDTNR/To1NG9NYa2c5uvk7r6vOQ0IdwIZgTFRGnnWa9l7GzfNZQ9LYdw+Y2lo7LpF80eoFQCPoJ/0J60IbWJ0PENiGRz2PaXKcC9VgcLLYc1ZCvyTA==
Received: from AS4P190CA0044.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::8)
 by AS8PR07MB7223.eurprd07.prod.outlook.com (2603:10a6:20b:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:45 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::e4) by AS4P190CA0044.outlook.office365.com
 (2603:10a6:20b:5d1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 468262051C;
	Wed, 21 Jan 2026 16:32:43 +0200 (EET)
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
Subject: [PATCH v10 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
Date: Wed, 21 Jan 2026 15:32:13 +0100
Message-Id: <20260121143215.14717-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9D:EE_|AS8PR07MB7223:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8ca672f-57ab-45da-4b83-08de58f9f120
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?r8TE2PHAuzH7IRsZd+fcyu3T9y2SZEvDCprI/bYkniyr+pVBERU5N8eo/2tw?=
 =?us-ascii?Q?Nnfx3aVhuifVHyrNmFF5ew2ndck/+GDuHrNE/ROtt24NrYYYA7rT97sa6HOE?=
 =?us-ascii?Q?tVUkonoDVzF4dejB0HgwQrxjJASxsXyNQRxu4sWr3Z9X7rNby0o1KlYbSVpO?=
 =?us-ascii?Q?7Ky5JX8yguzY6Bf+j+4bl8bkm5WXe59ahMAxhsS4cQ8loV/PmuowG5wPHm3h?=
 =?us-ascii?Q?2IyXVDBa9fk4qmlFPbJhtNO4pJXAo7Y7xWeqGoE0uyYJWPq0Db1ugpI7jMJL?=
 =?us-ascii?Q?XcMFC4XTldMlkSgwQsgrdeLxnPGkDgN6Uhl45pRg4/qVpHANXUMVUgPp/1Kk?=
 =?us-ascii?Q?fPdsSKt/B2fbIvs+QZRtN2v4VgdVE3nB+8Twk1z+U3/4TnllbWFk3n65ESCX?=
 =?us-ascii?Q?AoZsADkXz8eTrB7WYOQA/Z1OWefe5p7YEA7e9/EjloaY21eszqJZYHXQ2y6j?=
 =?us-ascii?Q?ksP61PbmTnBLlo9CXlDjUD/GwCWnXINRGY5FbZ4h5y/vKsCOMMxJ+E7SiysL?=
 =?us-ascii?Q?ytBblrdVH4weUIUdezA/uLtj+G7+snP7P1Coj0QRAFjBlTQJlYiHvEcC6Kf8?=
 =?us-ascii?Q?flUUoQexrI+6dPue7g1AUMLFh4YYacxZMy+NxZe1616SkLye2z50a5NVL8St?=
 =?us-ascii?Q?SKlziY4mFfVX5RARydvHTZudCm6OujpIx1k8ArO6d5npGJcP4ehjc2ndCPwa?=
 =?us-ascii?Q?gVLqTA2oKaU+go4NI0JLhQKHmX8yO60fs7UCUHNuESutPyMjnWl0CHfAxD+U?=
 =?us-ascii?Q?/mCrpLpkjzzFEpNi0A7V1pLE2t/b4Nc0MJD/QhHuo17azxk1ZMf3LLzWsVCx?=
 =?us-ascii?Q?AhcOAqQwfPCnPaFejAjzCq60T78fOYFyx1H+cxc5fQZ1X2ncBFcyrB60Fard?=
 =?us-ascii?Q?40SvQDIccnhBPGIKHKrn5IiXGPbY5OUgSlQHr4NOWDrX+0lrQhZCyGIpwYGO?=
 =?us-ascii?Q?sgEolJLEYDRQQlBhS2A5yJSkkt8wPFMG8eYbCN7wxL18iVSyMK4Ioqeq387K?=
 =?us-ascii?Q?DGhQU9Ib1YsbNTGw8LHWKvUXo5OzXZWbsCP84X1zYCHCDnvnIfdzW5ySfSeO?=
 =?us-ascii?Q?FuIPRrj/Bvwuaq7S10WdroFG3bzg3cApp77Io8EsKB+obV2y2pWAftFuEoAd?=
 =?us-ascii?Q?fpXaUY9TyTOYn/c39AlvZeYT6juZmdfD5qn1x9jBKXWLYSx83p9/AqSTISRT?=
 =?us-ascii?Q?eSLh1PliQKMoC142zYFwDjFkziPsqc7O/zoOJN9KrYxRMVP/GlbjL+r8g5xS?=
 =?us-ascii?Q?Vs/W1wNarMUkrdF3piLaNEFuBnOMMwYmxNOXO1A6+cdz0mrAv/cO8j9M2qKL?=
 =?us-ascii?Q?EoStjYmUDKUj8Kq2zBFLHys04tW9kk9VkU5h6V7BbRikZ/8mLErsM6Tmn8pD?=
 =?us-ascii?Q?0Qvz60csLXuF7idKZNUiQlvgKveZvdml6NjD6HvYdcpkHit9vE9dpUNKMkLL?=
 =?us-ascii?Q?tL5hdoR0Xy6GETJC06aw9iYbnmOgdYfGTrOsqphfUIvnlLvqgsWDdQOibfkM?=
 =?us-ascii?Q?LsMqjt4cLRteg8WPSQvXqqLojciEXH43DePED1YgotiZ+hTAuohTHAFohBfT?=
 =?us-ascii?Q?wohztZDfFWql9PlZ8vRJ7lEIJ0u+OVI3GO0E8vFGem2lJA9ID7C3RMhQqLsw?=
 =?us-ascii?Q?OKizVNEYsQsUaIeb3ROt55ivDx0UKZp6B1nIncDnsXw+k7jBXUEDGtCVNxxO?=
 =?us-ascii?Q?JBzvX5qATeFbQEu1j8fDjvh2Bcg=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:44.7760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ca672f-57ab-45da-4b83-08de58f9f120
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7223
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
	TAGGED_FROM(0.00)[bounces-251928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA94459061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
or ECN_MODE_PENDING. This is done by utilizing available bits from
tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).

Also, an extra 24-bit tcpi_options2 field is identified to represent
newer options and connection features, as all 8 bits of tcpi_options
field have been used.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
---
 include/net/tcp_ecn.h    | 11 -----------
 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 net/ipv4/tcp.c           |  8 ++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 41b593ece1dd..a31ba18b10d8 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -67,12 +67,6 @@ static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-/* tp->accecn_fail_mode */
-#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
-#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
-#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
-#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
-
 static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
 {
 	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
@@ -105,11 +99,6 @@ static inline void tcp_accecn_ace_fail_send_set_retrans(struct request_sock *req
 		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_SEND);
 }
 
-#define TCP_ACCECN_OPT_NOT_SEEN		0x0
-#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
-#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
-#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
-
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dce3113787a7..03772dd4d399 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -226,6 +226,24 @@ enum tcp_ca_state {
 #define TCPF_CA_Loss	(1<<TCP_CA_Loss)
 };
 
+/* Values for tcpi_ecn_mode after negotiation */
+#define TCPI_ECN_MODE_DISABLED		0x0
+#define TCPI_ECN_MODE_RFC3168		0x1
+#define TCPI_ECN_MODE_ACCECN		0x2
+#define TCPI_ECN_MODE_PENDING		0x3
+
+/* Values for accecn_opt_seen */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
+/* Values for accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
 struct tcp_info {
 	__u8	tcpi_state;
 	__u8	tcpi_ca_state;
@@ -316,15 +334,17 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
-	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_received_ce;    /* # of CE marked segments received */
 	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
 	__u32	tcpi_delivered_e0_bytes;
 	__u32	tcpi_delivered_ce_bytes;
 	__u32	tcpi_received_e1_bytes;
 	__u32	tcpi_received_e0_bytes;
 	__u32	tcpi_received_ce_bytes;
-	__u16	tcpi_accecn_fail_mode;
-	__u16	tcpi_accecn_opt_seen;
+	__u32	tcpi_ecn_mode:2,
+		tcpi_accecn_opt_seen:2,
+		tcpi_accecn_fail_mode:4,
+		tcpi_options2:24;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 37a6e0aa9176..f9e61e49f811 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4321,6 +4321,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	if (tcp_ecn_disabled(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_DISABLED;
+	else if (tcp_ecn_mode_rfc3168(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_RFC3168;
+	else if (tcp_ecn_mode_accecn(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_ACCECN;
+	else if (tcp_ecn_mode_pending(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_PENDING;
 	info->tcpi_accecn_fail_mode = tp->accecn_fail_mode;
 	info->tcpi_accecn_opt_seen = tp->saw_accecn_opt;
 	info->tcpi_received_ce = tp->received_ce;
-- 
2.34.1


