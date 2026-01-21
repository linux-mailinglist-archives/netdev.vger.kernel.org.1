Return-Path: <netdev+bounces-251930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJcmElnocGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:53:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD5B58C8C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64B706AC1A7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD74A5AEA;
	Wed, 21 Jan 2026 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JcAbOVGE"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84984A3415;
	Wed, 21 Jan 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005974; cv=fail; b=EmMofYhF5pm+PR4DSyganff8VVuuuIRmdamjlmxfghHYXgO+mE8WH5o7aKge3KAXTVLGiPJLZSSc4h8zDJ2ens+i423ou2OxRCjcvEsc83zUoTq4umBlfiFa51fzEdrGtZB58Os24/pdlv60OK6BBjy42bp/dSc0vwBuXMifPD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005974; c=relaxed/simple;
	bh=K9sp/cKFhO2N1xPzkjJWGMSrD6M/VgnZ8iPjal4WcLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SipMyQjSePR6ZTmz1d8VKzHLrm2OSMN80Q1GBCXmpGMu1WbyXKfPl4KkoCvGO3kl5s9VDaCgBUhDTwvc5CX4lQ0wLBoa+9LHEZQNMkKeW0jFnZTzIPLOv0Y7wj2nf3yY12jxrT7sZt71ULFa/I5Z9XKSxh8B2Ax9sIo/m2INN44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JcAbOVGE; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT5+LlVVnv2uoZjtNr/yFQ0HiJFtRmhofaxI2Z8O5QDv9tCsYjInrTo35qwcPa2784KFexbtfF3PoB21DPigyfvHl0XOPhM5ugY7+yrKbX2UGv2JoShz/9ByYuyI4xHfdvLAHXe9fIZGs3AnPBNgzxJpQclmitsRsA4bY8L+tXijoAkhCUhOq55oTMAX8q4K1iK9Nc/wcADwhrmJ/NVrRKt612nU5V5av7zPcKuB9Y9ztkYoa8akIvSwSOkVrHVlfek68Q0yvEkhs7umI1d0hbAK3141060KCL5bMteKBCZnhkP7B/6+o6hD8VuF1HXcc36gRWvdeGY0Cu+VotCCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=W7C/c5fGrbTrBUWH0M8JQE0BJDt8M4PEMHO5kR8OwJpQjSyd0eFotGzBX8/61H25iqTRqfcPqmKYbB7yM+jnBNESpztxAuJy5XrM/FtLClYCiYwQccClJ3eBfpOnwEMKxF+gvbe/HgsKcLEFr3BZoExP/Swpq2z9zh1QITMFawbcvXakIXCfrNIvOORSLY0q4k+rbxayCxUp/x5ug5YAuEhgTdtMUypDesMx3TV02BWPLEwoZSutUnVwwcR7+kW0TYVxmLTOajZH446GrkiSoSD+tLXWRYjfZig6VAdVqx6062kZ4LwDue70fBPicbslTlR+Ks8SuG0j2cEL8OyEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=JcAbOVGE3LBuuDO+ChQmBB3xWQ0klVlhAZG4Gfg8FrjDD23zEhkUohuXHaAkXIP8KdD35xY373Kp6dkvgyfavK9iuC1irYj46uJUb5MIT6maSEMDfFrqTGuY66WBadDDgGhBfEDipMy8gxfegbD6AEiLATNpkQ1vU2KrIN08QwTHixwhjFj9tWrprx8TEOywDDVEy1BD4FuSByU+Hop7lU/aIP3VLPNbcSXaTTtSAB+IdmT6q4WZEJ05ojLQEbTr3HWX73CvzyeoxdAgFId5+6QVfMmwRxXa3D8EdEkSxgXZ+cynTdanurTcqCYf0QqGT/0/T5z6GNUxstRHzt7WTQ==
Received: from AS4P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::8)
 by AM7PR07MB7012.eurprd07.prod.outlook.com (2603:10a6:20b:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:47 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::88) by AS4P190CA0020.outlook.office365.com
 (2603:10a6:20b:5d0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3CDCC2051C;
	Wed, 21 Jan 2026 16:32:45 +0200 (EET)
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
Subject: [PATCH v10 net-next 14/15] tcp: accecn: enable AccECN
Date: Wed, 21 Jan 2026 15:32:14 +0100
Message-Id: <20260121143215.14717-15-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AM7PR07MB7012:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c3d20011-b7f3-4f94-63fe-08de58f9f248
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?55IT1cDzTa3noH6lA2d+qRuovLd+b/Rdjj0X0MZ1y01v9bewDAnQi/esMpAu?=
 =?us-ascii?Q?stN21iNe/5RxObNq850m6DqyaaJ7uf5o9EG1S070jZItVCZMc6KfQ/MBqzeN?=
 =?us-ascii?Q?msDlbrcA7EH5jGWes+r6eyE7Q7gyVLmMwfyUCq5LD+ZUooCEIOqWWLDAm5i6?=
 =?us-ascii?Q?HQz/cDRlLTVTKFN67QC8S6qg4Dn/wTu8Q/oIUAuZF4tf8xeQFRM3ZpKp4oKo?=
 =?us-ascii?Q?utnXiJZKIujQOnEoPT2hS7Tz+rQn4Vcuhk7c08mDWnUQqkzRcAmeeo/lRTa1?=
 =?us-ascii?Q?YIeE1LZ8jGkfFHzY8v+jc1W7oO9iJCuYFqxrDN5Fpj9bTomxmIlCvuVI2EOM?=
 =?us-ascii?Q?J8nj3jI528/hL5iDbMQY2tVlTqrqMOsprFm8uivSrreCz8eTfFczn6Fiimn/?=
 =?us-ascii?Q?DgUqNk/34DfR2iQQrCM8RpWaD9AlfdORNYJtM1MQVjpDFoI6l65ShgiIosEZ?=
 =?us-ascii?Q?QGBM2AXKxYL7NbCla9o4sbZq73V6hfntmgPG+yA6wGDh1XHDeLXGAUacvr6j?=
 =?us-ascii?Q?mIfy9L9xXeGcEmH2fjbd3AzecertdsAtrg8mRBUyETTdh4kcto2fp28ATMK1?=
 =?us-ascii?Q?k8zeER/6NkKY8SqLgvmP60x3GuxauVnyu2XNFIyI3SgbZJXoTwmhaR6u0DyN?=
 =?us-ascii?Q?KhHOK3HxsPVEDpEWQsEfGKPwLETlMQa8eiaOvMC0MBArecAEtzfgdSE7MqiY?=
 =?us-ascii?Q?ehqc1lD5jv0RvEtaWySOOP6/B3jPLn2HiyYWjJ9PJx0ZXVoF4hurFJqep2f3?=
 =?us-ascii?Q?6M/Q/eLgDNviH3d0bENpruSDkbYTBZ7ods0UXd43aER/XzdluBzBnZXUj2/9?=
 =?us-ascii?Q?mbgz0KDgFCf61uBjehuEklwzewlvlQukaKpOX6sjpQFCeUnpVMqNP+CAcQTK?=
 =?us-ascii?Q?worzKJGSUnqoDaeSUE4Iro/s+8tPCopm0ie7iOnLG1vAB3AHpPd6PZngABcs?=
 =?us-ascii?Q?F8Ede1cbI3/Qn01eAnpe1oNQhS+Oy8qxY8p/ZZGp21KUtK0BQO4nJ+LaYWaA?=
 =?us-ascii?Q?Z6h7KGUOIA9P+inZBKbxlR9MU9Ryt7EJlsZqzcRZKuK6Et1CJM0POD4ZNWeA?=
 =?us-ascii?Q?PRfZNPkIprcgv7esJVyu49Co9qKl8Kn5JtCJGqn9zVTP4wvlh9VY8E9EdLlB?=
 =?us-ascii?Q?Xkc8Nz8WPy4ms6DK+HJ185K0k9GGCg+X5C0LP+f8ffetGAy78ABcW0JAfjfo?=
 =?us-ascii?Q?tKTcINDj6xnwuyjP6YdP+xCjLREdGYFvgLPViTVbjGeDGGAnXSoxhCobkLHX?=
 =?us-ascii?Q?GXTLgMzHeZUAY+JZPmmYhc86kri9RFyWm89Iji4TMzbwzNc9zkOiQw+gLlaf?=
 =?us-ascii?Q?Rd6TEmmNXQ6mYWMzalIT7EZemZvHjMgcJeasZmXssi10DuvMTLBPRHBaIHZM?=
 =?us-ascii?Q?On+sYuunDMUVvryLgVwMav0+YJIF+pf+JjTy0VONZXC9WsAnN4aQiSo7EaR+?=
 =?us-ascii?Q?YVwhudzUnKEhQHzsHXtBXtD3z17KBFogfPQgGbVfc7v2/8jKzucG6miw3M7U?=
 =?us-ascii?Q?nvb+sFS/KyWoWfxX9AkhDbhV9Vgp2oTyg1pk1XckvID42BwATrNE0weboDQa?=
 =?us-ascii?Q?PWqQ8ncJ7Q9g06BKLAxfxZJfqFZwfTxY2M8Vy71eOlgbmaCo517QNPgl1OKT?=
 =?us-ascii?Q?MMDUSuJtuhGpkbB1HnMIta9Bn+FdnrzxEWHZYg46F8xOAwxcjnWn06WT4fQp?=
 =?us-ascii?Q?xghCZlw7avkiQ77xolymBD/Qwjw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:46.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d20011-b7f3-4f94-63fe-08de58f9f248
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB7012
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
	TAGGED_FROM(0.00)[bounces-251930-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2AD5B58C8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 385b5b986d23..643763bc2142 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-- 
2.34.1


