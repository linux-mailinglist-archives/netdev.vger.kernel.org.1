Return-Path: <netdev+bounces-251925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCfOJ4/wcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:28:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E8592CD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1636A89F92
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B724A2E16;
	Wed, 21 Jan 2026 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tRAoWJ1i"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD24A2E0E;
	Wed, 21 Jan 2026 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005964; cv=fail; b=nrbiwbPBUvJQMlzKh7FNL89Y/Q2HXGCG1JyVmj4CFjSvWsopwb3v944b4mFnhOVwABMA6d7MiXDaUaHL37RuAlZ+IihQbLWz+npZYRXiMLY9JS2mivC+ADNODDeQnjjNFurMy/mPgHftUkcaEGwgOaUy9NU8o9uEjUBdQkSQ4R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005964; c=relaxed/simple;
	bh=lISi7AT9P0+MjuHe06m9kprjbGvZC2k4XO7oKJiOnpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxfdEgoj5gAAArTv9cdyR8rksO+LvCOK8tyBr7dxrMFLx2Uj2bP3e9kC6+9s4JARkHhvi6Zigp3LbH52AszJdH0O6h53DnXGXd58B2ZaeHcu6R061lTnVY6r5RqMKEK2D03EenEaqgzCqF0LhiXcA+k6f+rPR7/gff/QmrhLr0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tRAoWJ1i; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feGN0EiQBAUluAfu74YvKr41j2fO6oFW2d/No13tcEHolcHS4TpVglkM1ZJl3uiBAh1DklKJgqV0Rul+4SHDELrY962C6JMCFMsbpdrHg/uZmTynI5UfffojA10XTLO+eFjBxdFmJOiZBkx/RqjYYLxRKViavy3NYCDkcriGTE5icVjrNB++8XVz8medlTxuEOl3gMFSL4/qISajhTxDaXGVbEwl7LOyY+mom5yscSGtRNm7ZsBogBblBtocn8s5Ou5n44a5LPTkZBnNHX2Hfg01/5QoaRlQGZ4Ef+KBvi/oJbF3VyCha0qG8bF5+MYedkf+jwxRgeVN7/V9l5deJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DfcORmyTBE8rcwkEjhhJCGQVol7xT6Wh5l9CKSWn9Y=;
 b=kCG11W4th9sGXnTFItg59GkZzTutfc+tDs7RTzYyEI1GtkDk/Kh8Me+v9ffQr/BzBzNCMSO4unjv2dKnHBMw6xPRVGMIJ5JsmDTmu55OstxkX11V+ZdGzu5+coLrv5aiNcdR3TH2Y2EES2dcEmh0KXDEYyG0XVUmRxQ78gLc/s63hsGuDO1+fgZs74Mhqn5HA3KTBfDpyNrgFHjizWDz8EWBEBzToDjrh4XVtrWlb598YTr2FJBOU1sJk4X9KuuS253wjECN/2RpKSy8qv/pjP24Ww3mPZHeoCbVuRDSoArd4YOFCJgRbcoIJcxGTZLcl+J5exXR2K2vZB+q0gk0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DfcORmyTBE8rcwkEjhhJCGQVol7xT6Wh5l9CKSWn9Y=;
 b=tRAoWJ1imZqei7qfrbo1yP0YQSoSXjMdDIq9EMDiDXKl+GVLRgwCQdtv+e4SzvRW2/NTuT7UTP8Kn/DF1StDXyTo1mt49nh6GnYtcDzMGpW9QrBDsEC8OC16PjWtGXw8Wkle77YVDuEVWef7YvC14CxsvNhmymhAzGDbGHhVZWwsy1tFuNKhS9o51/ns2vXr0IwlIVj4PxcttFjjbJUuXHmO431bZQnlz2BjHbJiSwfgKzL8+lTVHA7fiJi6A6XwdEZil8sK6RhS+gIMpo62FyghbjnKrRs452YycVHt3U2AP+N8Z1RWwx8vT4LwZD/hRMcqG8aJ5Txt1QiIzkz4EQ==
Received: from CWLP265CA0539.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::16)
 by AM7PR07MB6850.eurprd07.prod.outlook.com (2603:10a6:20b:1b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:38 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:400:18d:cafe::87) by CWLP265CA0539.outlook.office365.com
 (2603:10a6:400:18d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id DA96D2029A;
	Wed, 21 Jan 2026 16:32:35 +0200 (EET)
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
Subject: [PATCH v10 net-next 09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Wed, 21 Jan 2026 15:32:09 +0100
Message-Id: <20260121143215.14717-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|AM7PR07MB6850:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf9f22de-1b56-46f0-5873-08de58f9ecc3
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4gmNuhTS2eJBt4fh9siAGAJRbKVVHoO+yPItx8Zlz43jzOVc0bi2cLWcJLus?=
 =?us-ascii?Q?Sa0ljlTABxrA22s7c8lMCvneT0Bsz9RjQTdXlhcmM+CwFAd+D8yVUOWGXhzl?=
 =?us-ascii?Q?Nh5Yb3bRerAZkuVTxfx0hildrHpFSVCq0kUQfO2gqDG2m9Y9H/joc/AVnKad?=
 =?us-ascii?Q?U5AVX9FppVynOVhYP15OiaYrps0PB+CNFH3c1FFePSQdt2Eq8qdXrFUgqzLD?=
 =?us-ascii?Q?iQHoiZvts0+vvfix7A6+gmxLuX2W9vLdmKAoksisTXTSZk8J+5CFkaOaGdj3?=
 =?us-ascii?Q?loEvZmVsiVHuDnFM5w1CuXdO2TypqhjzbjmLXBb/aP4hSlbiurtrVZ4d7jSr?=
 =?us-ascii?Q?fcy2GzeMpGWjcTNNmRL07n7NlQj4pphbcdoGl2f1AWPkwjeTbAf8xMIJBcD3?=
 =?us-ascii?Q?eFdwRHN7vpKCVlIrSyb7eOLNeRCNZjgqNlXqAm0qDJoZjUFud9hH/RQh12jd?=
 =?us-ascii?Q?Nj/ncZ9fNNagufzDbtf8NJSLecw6BIADL45oKvr12vt2j8emqP6JQd1D4M5y?=
 =?us-ascii?Q?Uhr9VEGvL/SkIr9fYf9KlWLWoGAxKZd0tojnvRSA9O4BOZxGc5OrQIHOC9mp?=
 =?us-ascii?Q?FI+wCYCI0kBQr14VT46OHJa8QpRSSxE/eo40c+qmYCLpo6BC4Yj2HW9hYA5q?=
 =?us-ascii?Q?R/kfKdDgyiKhH3F9UnKP5fty0qtyRExJajtle81badwT1GYILkSK5wETUJ6b?=
 =?us-ascii?Q?bndKHnMCEwefRLcqDTIOQTnllfqxHP6wSgDJNI6qnFg8joqKzMHXPhXXcwiS?=
 =?us-ascii?Q?HrXfQn5/0T08O1SGGyOKAw90GIR59r1PJ3fSlX0ZcxfX6BQrJmPsDI+6nj/b?=
 =?us-ascii?Q?kPVjShbHaqjhhlnhWQ0xdOGj+wc0y/JYFpcc+mIthlCQl/+Jrd7Ql8dQuBQ0?=
 =?us-ascii?Q?/XtklwandMtS7NDo+4UHfmHEAf5bylCppZoRVBuiibTkmza12zqH0ICGLj7f?=
 =?us-ascii?Q?g9KlNqhjOCzJAWgea9egL4opHqv5o8ptCPj/sDAAlvl0+hvNJBSpacyW1jEc?=
 =?us-ascii?Q?UNG37zmEcRBMr9Pem7FdQm9JFKyhfMe1aJOft5AKEBHYqLbjsuYy15Mt95vc?=
 =?us-ascii?Q?kXR0bhz54PKr57/emcWouf4ELAEazpZCbmQYyDoCyU5NEW6oxRT2Nm3mdxaO?=
 =?us-ascii?Q?3QGSCof/FHSwTR/cnQChfEL8/lvQA263ZucrRcmEox9xAA0Q2FLDGfjsvlN8?=
 =?us-ascii?Q?Chuy6SU+0yO63fBM+BCnKLUAEoue4SKMH5ct1h1jEeEN/uy0vdTNC8bysL0y?=
 =?us-ascii?Q?5+7e1TrwAAS3bkyyBADp9MGf/wPZZhSBGF6dybtRzL3paWbtFgGMNMjrkG7t?=
 =?us-ascii?Q?3KD1MUUspqNiXH7UXlanr8oKt7madBlwOWhwGu8YIDea7uCIH6Kv2ylFGMIU?=
 =?us-ascii?Q?a5voYqxWyLw5/FQGvYM0wjRFKJ9MNb6beyVwgAQGfkq/YSUSOTMrUnfDLX2f?=
 =?us-ascii?Q?eyL7DRE4MmYTezvLI3O5G+Tai+1CWOPyIvzXhx5grLrJY0G7FxnSBvQXa8RG?=
 =?us-ascii?Q?VtjKzkcg/k9564R2W+o2/wHYJvyFviLG0Zbp+iKzbWWQBApKwRayKnbmks6f?=
 =?us-ascii?Q?MWHva9rY2er2g1lCdLi3ilwgoNm/B0aQ/POkwCnjC6Nz7Rzk1PFl39uhBQHQ?=
 =?us-ascii?Q?deyFxk4GGj3c59hTXvlMcD1VTFgUZjZ/DW5njBs9H6OfEvkhhJSb/Fw9Vxhf?=
 =?us-ascii?Q?HjoBmssCzA0/R6ZFFWSqmsucfkA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:37.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9f22de-1b56-46f0-5873-08de58f9ecc3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6850
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
	TAGGED_FROM(0.00)[bounces-251925-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3A5E8592CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set
the ACE flag (Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit
such a SYN/ACK (for example, because it did not receive an ACK
acknowledging its SYN/ACK, or received a second SYN requesting AccECN
support), the TCP server retransmits the SYN/ACK without the AccECN
option. This is because the SYN/ACK may be lost due to congestion, or a
middlebox may block the AccECN option. Furthermore, if this retransmission
also times out, to expedite connection establishment, the TCP server
should retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0) and without the
AccECN option, while maintaining AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN spec RFC9768.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 329e7e461c52..8536ad08a668 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4039,7 +4039,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


