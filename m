Return-Path: <netdev+bounces-252770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KWfFAhJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B883E73FC4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55AC930143F0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7370F377548;
	Fri, 23 Jan 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ROjUVad2"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF93783BB;
	Fri, 23 Jan 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162886; cv=fail; b=k7O/EJnmRJ128D1LQDTew4VN7i1xlDKCGyoYGXyyenpYeSZcWhN4KTiUhpt8U7+JzyOybTdTs3bd8TBb7SaK1MPBgpMYBNnrM3vKIRCRbkCDizjK13ZXlEADy6tQXNwVNEqaLsN6h3aKFy3N+1I06sFKckOmtpIF1lf98yfCK1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162886; c=relaxed/simple;
	bh=NDjXBFP+J/0W/94u24p6e6fjleF/QRCcFNCuxuom/wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tA3cr95dZau5TlaWkt+i4hQZkJ4UUXNJHWiV57cx7T1Wf/7oqJITAEtsJgCKdB4pPhEs+bKV8sSx/Qok/Vr26uMiQw5Atg+I7YC02/IUFLFuhpAk+ed8oPliwtfsKPs8rJMrP1Drjk/2TYJA6U1xqfBC5eaIEvcujUNjiLKyo48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ROjUVad2; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZvXZytL2dRt0pfdQs0pAUTLsKTDOQHU/b/0OUHmFRpQcD6rGMqa5GS7RBzLcjBBOuikCHJteZJOrH+jKOIrYLopJnlxQTUry8FwrIHSpF9t2/jXKn67RRx69gN3jLF8z60ol5bOwX6FNKPS9xm9tVmNUxQt16AeQ8s/BQN2R9SWTQrY67NA6MdMyRXgSxHH0GesOiAz1BgvOPlncSPmaKP18sS7hufoGkfpqYCZgWXYUKLyfXDjCFZP5fr1BkbickZbY+XT5Z869MyzyG7PCkMjvuzW2phZrhy0hMt313qqdbTqIXy6b4PD3woL39cC3vwdbRoSJWO7M3IQ7icIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2tjgnXOCoxq83R2nfl4+tMSAIszTew6geH9ZnQGNFA=;
 b=yXArgWIL52vF1Q8R4ytKoUm6gkTUdsndAiSjaiK3o7FiCzgY/piZKOgeBmwCeN35QK9dLpmFtAXQk2y00q12xYST3ISP+i2tFnzdrr3eS9J/tZpIP7jv0zGEGfArnf8M+F6I0QvL8YfLwM+7/PbL0886Ge0lgqxTOH+wnPy8bFqG1ODCDfAtiXTKgHAGWHD+ljsEYAOogukG8saC9q9yxlwroIdXKLYBssEw9vg72+LdAxmcfLUEeTDljzOlXsTdjqkMIB6kBiRePU/AaH/k2Onec9ohoC8tSqPeIBTVIhTFdVuTrvLNDdz50vx+DR/G/qqSzRSeUeH59iVO5DIAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2tjgnXOCoxq83R2nfl4+tMSAIszTew6geH9ZnQGNFA=;
 b=ROjUVad2HaluxSxxqLBWOF4HoDxKJeaPcA5vbxybaVcRHuqBB2uxUY7VuucbLkO0DdZm0Jcx9eGjms9PVvBflUsBSi4HyVDpL6vMZvv3sM4psoBL9wpdUGvdTci6GVD+j2YsNORGo60xgSBtoazZd3CPm1PeQDwjxeqdyA33H5/0hFj+GSbEO+2el/shiqN32k5rtAZ77Vtfysu62uhHFhhNdLGdCFTJGkggqxA/wpYWQq9JjgwhYMUvVQjlDo+wrbL6zxBIqpYWInBic3+II6yYjpPxOmbl7wWIcADe990CKjeFTztfi5wXiwklGKo90J4JVejpNn+5FcBsm1DkYg==
Received: from DU2PR04CA0046.eurprd04.prod.outlook.com (2603:10a6:10:234::21)
 by GV2PR07MB12063.eurprd07.prod.outlook.com (2603:10a6:150:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:49 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::60) by DU2PR04CA0046.outlook.office365.com
 (2603:10a6:10:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5A4111C0031;
	Fri, 23 Jan 2026 12:07:47 +0200 (EET)
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
Subject: [PATCH v11 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
Date: Fri, 23 Jan 2026 11:07:19 +0100
Message-Id: <20260123100721.42451-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|GV2PR07MB12063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3584298a-a2c3-48f3-f51c-08de5a674356
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?sGP/MZK0JQHD+HsFccS4zYf6fPycxudZpm5k/mrwPNDvYyglJdFAKjvas3Ms?=
 =?us-ascii?Q?qYayKZ0t8O3GcupZU63an+tdjuU++/wcrXjSq2FiIcywkjohh6bjbh25NKQ8?=
 =?us-ascii?Q?57/Xm9wtn7IVFoKnODM1+9Has7IZ4Kji8qIaz5U1i94snxmPyYxrN9GYwInE?=
 =?us-ascii?Q?yAUAn4/QVmWZ3ubMgt9w/h7+KrBrdz1zYaYJ1yaCtSX/KiMaaGkktYxSC+3t?=
 =?us-ascii?Q?y8eueJJxGJQikr1JIMVhHmD+j04m73WlW6G40R8Lxbj2OQz8RUMDlZQOzF0k?=
 =?us-ascii?Q?6lFrtWDNpnjtwpcSyAmbl/CZ8X05Nn9Gy+GJb2Ffg5I5Ylr4zvvWZdJxKKVR?=
 =?us-ascii?Q?0uxpaEUL6pfRyRVt9TGePyDPLtBkCN9mNpW+OvtG6gU11ZucK4300m4FCZEH?=
 =?us-ascii?Q?PcKhB05X23fgCX1igKnhNLsQMGDL3HKrJklkQ21c+tC10tM2ePMmmpLGrKro?=
 =?us-ascii?Q?OyPfe5Fo0CkBNVo0mf81R6wVtMdELeGlxyYyZCdnSqTdUvRj018E+VtMB+gu?=
 =?us-ascii?Q?rnNyoLR1WbYZeuCY1IbOOyuInVrPu44rSzXsm/7xfB0z5S8k/scVksVyEZnH?=
 =?us-ascii?Q?paXfNpA/SQsuy1+JduRWnP9TqOhaBiQVJD7SW4oJI6z7T4bLqekjkjmpX/Ga?=
 =?us-ascii?Q?psS8ssDZxSxbRzZi3JZWmKXptfCOPXkMV1K30KAK+onhXAj+CFtuNIXcc95M?=
 =?us-ascii?Q?D0geBxqkFzwo5iW/vfjM8Ys39VYjIQxdey7ndKwVgfcQZvbbb52sYAv7I4XD?=
 =?us-ascii?Q?tT0ufe3vL/ZglRiX+TVzVbfCNqmaPeNkRpdOiwgwJT/+9sxaAAfKzA/59Xgg?=
 =?us-ascii?Q?9hs+H5iDrrPU60cV4QVHIpWctZJW1gwvlqMk4/SbO5ZQgVkUiAc8DUOD/kv2?=
 =?us-ascii?Q?LKOaHaGXtYjQlvmetR8I0e9WyHBX5omoV81uZ2b8PqW3/WveLoq7fmuY5pg5?=
 =?us-ascii?Q?YwbLSuHqtKqLvNpI9g/eMmf6w4zFToZPOajt/UXXiMPFXlzZCjwIL4rhIa0N?=
 =?us-ascii?Q?aTKzmWpLxDlIOtKO7+g5Cv5gupTu8/YyObQ2vAc+KP2BJvH22unT6oQXwrk/?=
 =?us-ascii?Q?RkYguZV6kAwcxYcSQsCE3UZsRLVIizlx7gGU0co3pGWNsmdF5Si8L3f6XGl2?=
 =?us-ascii?Q?ibwV2oATkuB5489G/1AAKY0c4ErXz3MpebYu75c292ENXNJSNhTSmaId07gO?=
 =?us-ascii?Q?ykIORZg9NSqrvw93DnCg8U/shvkRYOZ+hFSmbAZe1bq0KaIx8cnFHrNqklav?=
 =?us-ascii?Q?HPHo6s2jz0AEUEunsDAYmrxCkX4JNZe+DwLtJ1huwMfXbK74Ccdqdys/KvXT?=
 =?us-ascii?Q?55+s4NFO7FvBw1jF7VKTPGg0J/MIRHU0UwT1nnWRyXwgt0mzcniFZxkj+Wfl?=
 =?us-ascii?Q?jto+INnPoZsuwAbMQRlNa7oeRikp3y14sm5j5Hb3uvtbp6K4coqryI9KLASG?=
 =?us-ascii?Q?RdHe8EHyy8HWwmsKz7M0Df+gI0af59aenFaw3mo/Y6rHG1/Ul+xeo+xP89ce?=
 =?us-ascii?Q?v6qtfBdX4/s5MBvNNoj4QaBGoptru/i5bq8ZT2VqRAha2uu9NRFvw59OPn33?=
 =?us-ascii?Q?MGgx1Gty6zO7LyQINOlJVYOgU1dEon4gx3WDH+gEMHaK81mgeXRvqNrd+Ame?=
 =?us-ascii?Q?FSG4zIqfoXkrZne8ztCbvSnL/nrn3yzFTbniXFZb1gfAndjC5IpVdNrUhMOW?=
 =?us-ascii?Q?cUWWAWTrueJaXizNkGF057hiZEw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:48.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3584298a-a2c3-48f3-f51c-08de5a674356
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB12063
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252770-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B883E73FC4
X-Rspamd-Action: no action

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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp_ecn.h    | 11 -----------
 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 net/ipv4/tcp.c           |  8 ++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f4558d6ca394..c7bf681cd3ad 100644
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
index a00464cdd53d..6c9afa010fa8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4339,6 +4339,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
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


