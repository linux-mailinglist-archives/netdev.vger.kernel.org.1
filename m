Return-Path: <netdev+bounces-252769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C/hCqJJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F4740EE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B907302D8E4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590713803CC;
	Fri, 23 Jan 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IbNT3swh"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BD2BD035;
	Fri, 23 Jan 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162886; cv=fail; b=euOCDCBHb4iDSm7Vi3/pIaJjFOdiMSb10NYRZLrrdV71OH3QDDG2DWTobjgsw0uvg2yhhY/Ni7DLfnF/1br4+F1WLE94vKDbKyzjz94tBWPzqqcxvFoNK5yPI5vC4bNV7zOQj9sGQkf+V6IoTQ4jhyEg1JvLIETpC+ThZYtQ174=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162886; c=relaxed/simple;
	bh=sxwxOU4j5x2hAd1/t8fbXcuZnREOhX7bl8Oj4QapLY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVPVvSs7xMZ5leSziYOsWr/YmG6K2IY3bSDXUynEnrLnbO6cmbzXm6XAxNtMLJLu2tzuxgCB6FgrY9wuzInsbAMeCO3jAQxiXRgOEK7NJ/sMHLUn4fjOmqNrlt7OW3AAgP2lZ4PQSMtfaOeEzvF1AMhY8Y4z8wtTOblfJ7uJDR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IbNT3swh; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSBIxUSdOteRRcDDfeX9SA+ZDihKfF9k4y6kEQllwkKjx+hWQ+Y1K+NiJT3nlTk0xstfBTuN7ciiiL8zjoWGmq93mtXgngpRndTcfykkFNZ0/F2v+VmWgT6H9NqgT2HlTfs4Tlfa6x/O+lcIYlZkia4+KxTwEgRo1eBL6UaGzl9QTjEQOAC+dqdo5Tc21HC6Zj5Vdd3tJzoV9J4eUrxFJ2tiNVUYS2PbqOLCJ08IZGItHLA/obz6VfgMPJ8kFSXgD2iu2cJBDyAuSFMSlpW9TBLreqIaqhgCg5FyAPMZ5T4BOtpPagCUCFe56GoaY3imKRPUiVHFDT+1jvqgBVV/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQXzErHvUWjCghuZBpjEynDwWuOtdJYBz7Hj3ML/x1Q=;
 b=WK1PKvISJSubxb0hB5WzHzIKgcXHmUS7cUtJVLYlm5XGZdHRet6beE+bI5MJklPY99VVM9dbXD7h0KH74Jt3HwELRIwopowJgczHPbH0IFlXwpfYw5sVwnNJpM/1bShCxpKNEadCuCijiZtgDDUd5Q1ARdEQ4XZ22KrM90PbJG0PPGMvx9NM1Zisk3iVUePh2svZDuP8vKumxvzg8BPYsWK9sghnzHQZuWe+5G/SvS2rMBGH/5Znaoi1DwSGvqDmZIYOT6Sai8cWsA2B0SCUM/+o3py2JILVJaGvW3HGXNl7JQiN9uqCLLQ+ZVk4owxRPBS2J7amCDIgAb7G7ro+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQXzErHvUWjCghuZBpjEynDwWuOtdJYBz7Hj3ML/x1Q=;
 b=IbNT3swhZ5gBHoSFTfOomGMb/4FDJWjMRxBm5QxIObfkUAlFKmqHptzcY1AdDwbmaqudYEqOUh6BcPb7t8LRuQGhB+oIT1fTo8Ft+ov+tqMO3ONnVNlevu0L43qscomknybnog76B/h44BVnRIs5mfaswqCXJ1+d5dpr4xoEJxw9JqAsvkrSZaQLBx9eAAmXrBSr+pd2oZG002+bxKPbIdi9NuRffDcqAD/EJkpXSmc6FJJSKBLom2CLiJ3ud+9t2f+Lz3ZhQXjRir28MuGIYvzAfWDFma+WSAuiNYIdguewL1k5M8Gmn22drxVo7CPgPPLi8EQWK6mMxKq7z6loCQ==
Received: from DUZPR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::28) by PA4PR07MB8597.eurprd07.prod.outlook.com
 (2603:10a6:102:26e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:47 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::55) by DUZPR01CA0109.outlook.office365.com
 (2603:10a6:10:4bb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Fri, 23 Jan 2026 10:07:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 974E21C003A;
	Fri, 23 Jan 2026 12:07:45 +0200 (EET)
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
Subject: [PATCH v11 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Fri, 23 Jan 2026 11:07:18 +0100
Message-Id: <20260123100721.42451-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|PA4PR07MB8597:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0100790a-f398-433e-83cb-08de5a674246
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?LAlV0UElm7Z2m2ytSLlI4jf23B8p0kPPUYpxgpZJwh5uwhIibNlDWtoDhHsw?=
 =?us-ascii?Q?6K+fW2xfP5V3zv/ssdg0ZDL++iksoMvjWmsFzciE80/N3zA/fGPARuY6a/cM?=
 =?us-ascii?Q?uKu9KX2DsGhv4wqQ3yiNBiLatb9EeVLpim4gq0hGlKqzZ3HlqUwCZ5xQnITF?=
 =?us-ascii?Q?UtjY4Avi8gA0yxu9oPLz7HvWFVxhrrwCGvuTI4xzfjGWkyQlCNBcxj4VX+Yr?=
 =?us-ascii?Q?AFlRHNeWRzTrV4N/xqzGKpenY/tAZ4SChpzJDZYAl3vEbkUdB85vqy83v9K/?=
 =?us-ascii?Q?MyZzvLFBnFJqZow3T+EwqFf54CKOGb0uWOGg+GDLE07OYcTDDentalf9bfdF?=
 =?us-ascii?Q?xViHlLSDEgyqsuXLpnwq0rBxN0qr+Be7iFghW4PI7vOgprx18RIWsFnZuqqF?=
 =?us-ascii?Q?t4wYkmCo4vLtlyhcwOV3MZBsV/T2vQVybhtxmtDaTbOmQS/fIZv9DntWaFk6?=
 =?us-ascii?Q?+Q3/ZoEokyOKhxbORtStJHywmGCfWsM0aBELljy0WsHOx4jMyrUBNVveXQNK?=
 =?us-ascii?Q?/UsO42mz3wTeclADEsmmZxYQqAV261/z3U3XHqd4rAhyUPEhay5NSpYuxxW0?=
 =?us-ascii?Q?waIOhdhH86eUknpEGiiyZYF8Kl8iEdKBUkaXQdn3i2kCdLE/PM9SotNcgIQl?=
 =?us-ascii?Q?AyjjwkdrxxjJu16iObcaYIQH6soLjP0jrHurgRECgTIAjEoaqu9MCkuMjCBp?=
 =?us-ascii?Q?yLJTNiBSiAumP3kGw8NfWER/6cKGb1TXxZh9jsL8Q031B/ciewJazjXZkMkP?=
 =?us-ascii?Q?GFpymm1WCF+FeuDuTqz27y7aqqcwCfqj+Orn8n22wjYBjgbHsRK45Tix2Z2+?=
 =?us-ascii?Q?Uvwg2bSAkqb6rDw7yEMOeFZWSDDk4xa45yuP2T7QNmb4pS5NwYSA28ykJvum?=
 =?us-ascii?Q?sHM72o8+7VH6jltQAksz1P02YTXGpGZBrcy8Y1bs50QjBfmntV/RJrvqarXF?=
 =?us-ascii?Q?l5nfXoyTi4frL5yzTG2atRppn+lJrqkRzK/MH130xuR2WGADtuq9D6LnJKS2?=
 =?us-ascii?Q?IieMRiVZMiqGfndYyqPc1z3rtzJXTb1IPDmZs5lqdV/n7QnmeHBnbEQIggaB?=
 =?us-ascii?Q?HkOVaba0gxr9ge1dXlw5kOv8joOzhNrv2CVPNn5eVCd6/sclr9p8IWmGPvec?=
 =?us-ascii?Q?q06KDinzrUh21dlLJJr7LJpUtsQHV/AtttEhuO5lsGi7vIWEChty81Iq7A/b?=
 =?us-ascii?Q?u+1Yyha0ogLplfpFxLKmIQ+fpmYcTF5iQ0a/vSx3jg+UpwBIbfr+cMLcFSsm?=
 =?us-ascii?Q?mri53xOFRw553QWQP5M5Eo1dbrPOIqOF4htMFWuDRqaEYNhB3qGbPIxp5rRO?=
 =?us-ascii?Q?q3P26MlCz7N4SR9MRm0FuWysQxlnBQ0UU4lDSaCnHUw6YLj9KZR/XEGN2Uop?=
 =?us-ascii?Q?4YNmF7oK42QZzcK09pZK5P4oCEuRfN7bDvF53MKxLaSa967ZEBRO7P8z0R0/?=
 =?us-ascii?Q?e0Qhv26q6w8x27hLGxbHNHPKSJN03dev/48gCRnhKjHxXlPYDpAYiXRofk6E?=
 =?us-ascii?Q?iuAE+Bj1QZZF9USI+U11NY3zZdw8A6FA9C4dyMzXuDD9Vl80BxHmYxehI9jz?=
 =?us-ascii?Q?FDwyRUkqrshJIXdcYlU53nLmWpGu87commMIg7rfPm7TGRe3y+SaoDAbUJvv?=
 =?us-ascii?Q?MpBcu54TUj5FebDRv+fa5LerVJPP8Pnhs+2RzJHVwCdwocXjGNSPIDzqgWYQ?=
 =?us-ascii?Q?UjG1XxO3BVeHHAE7+4t+Xbe3Zjw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:47.2189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0100790a-f398-433e-83cb-08de5a674246
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252769-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 063F4740EE
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768), and a new field
(accecn_opt_sent_w_dsack) is added to indicate that an AccECN option was
sent with duplicate SACK info.

Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
(TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
persistently sends AccECN option once it fits into TCP option space.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v11:
- Modify accecn_opt_sent_w_dsack to indicate valid prior D-SACK info

v5:
- Add empty line between variable declarations and code
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/linux/tcp.h                    |  3 ++-
 include/net/tcp_ecn.h                  |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  2 +-
 net/ipv4/tcp_input.c                   | 13 ++++++++++++-
 net/ipv4/tcp_output.c                  |  7 ++++++-
 6 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..28c7e4f5ecf9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
 	1 Send AccECN option sparingly according to the minimum option
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
-	  option space.
+	  option space except when AccECN fallback is triggered.
+	3 Send AccECN option on every packet whenever it fits into TCP
+	  option space even when AccECN fallback is triggered.
 	= ============================================================
 
 	Default: 2
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index fbc514d582e7..f72eef31fa23 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -291,7 +291,8 @@ struct tcp_sock {
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent_w_dsack:1,/* Sent ACCECN opt in previous ACK w/ D-SACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index bf7d3f9f22c7..f4558d6ca394 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
@@ -413,6 +414,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent_w_dsack = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..385b5b986d23 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a4d086ccb18a..9dda1497c149 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4971,8 +4971,11 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 		tcp_sack_extend(tp->duplicate_sack, seq, end_seq);
 }
 
-static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
+static void tcp_rcv_spurious_retrans(struct sock *sk,
+				     const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4992,6 +4995,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    tp->accecn_opt_sent_w_dsack &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 042e7e9b13cc..ccba73ad61c6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -713,9 +713,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent_w_dsack = tp->rx_opt.dsack;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent_w_dsack = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1187,7 +1190,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
+		if (ecn_opt && tp->saw_accecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
+		     !tcp_accecn_opt_fail_send(tp)) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


