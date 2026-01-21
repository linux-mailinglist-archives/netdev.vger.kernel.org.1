Return-Path: <netdev+bounces-251999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEUfDLQHcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:07:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA985A4CA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A71E7AC44FD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2883793C9;
	Wed, 21 Jan 2026 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKJi7OFH"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D030FC22
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013878; cv=fail; b=sHruZosWSHVNbLnZHzubd69DvdKqLFVF9+EENk5UmIpsrO4HGs5TyxrYPq3gxTBT78tyR7//QFE/0icd8hJY/c3zTc7vTgq6ZrDH/AabbFkJVLDkSTNUhxDS3H2l6j5s+3cqG2RYKZt3Q4cCP2gqLTLXP4i663NpEZV0UACP4hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013878; c=relaxed/simple;
	bh=bMm+sLeymjrAKdNsBeMElqNiDRTTgTdrTBXxBqhTOLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLWbGYutzfisfodXwde26Fw0PZRyBNG/j1Ezx1V5AdcXbhh9d7+bODCGUMP4wrREEa0gfUx2zjqqkhcnkkzIJYvGC0YY6D4EquzTuLWoTj0Z+ZinLELw+LjzZg3/7SwJMwQDyZ2Ngp8b7vJczixoBGEQftWG0q1cT6PttYd2NLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uKJi7OFH; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4xj55MlDocBT8ZtFVbla9Ambtjd/+Gpn+9EsmX20mt1tMrM3TxCXLOW8JOgK+SKbgtyQvreUzkwbdODYQVunnkaFAHjKKwaBGaWakcJ6eovi0S2BkXF19zWyPyH822hwP/Xdy7UA+Sg1kocy8IKB44Zg+ETreXMy3xfYX8ofqs29BD3gzuYAJHyz6ZMoSPqvyWqeZwthPbcL37weDZ/0LCo9ZAXrTjTfzpcJCtU85TTZqbtwLWweTb9yOsEaxVan8GX10MPzbZqw/7EU6CEuH4RYmFmKoQi6Rqw2y3CKD7q3JYpkR25sTE8tZWUQqzvOJ/qdQGeUKEpTC0JVrD/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NdlORdFDUdtUIYooeCuXWB3kB8ye50rKigjBCGpCUE=;
 b=kaOG1STeTXAg41vh6gpgdy/zuRVUBEx9f4SdHZaRWIXWWMRk++PL1s6Lo8NtGjB1gCgmpfsEummKoyd7y63cAqGT2ybuYWDKm11BiPUl9A47E15uRlaOZ4Wa3qg4D/HsnxUhsjy/BYrKv2zzKSUJgsWFZwtDx7gIfejkifZ+D1/mkqR95quMqAffR/QhjapS/Qug3WYajpWzsqevmi1nHvX9Fry4ORUDYngdglNkF346qKwh6DqkY/wJLK+1FVFN+8J5vGC9YUUAs2X+J7JPkCk1U8OHMZvkPUMpzknRyE3BKD+e1TP9vOxuRA2cNYCgy1p9IseFfHDRJ4HEG0c1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NdlORdFDUdtUIYooeCuXWB3kB8ye50rKigjBCGpCUE=;
 b=uKJi7OFHUCaw1UEmyaxRKBsyjuiPxuyO+LyETl4pYVvHyekcbFL5zCYQZGYReEyezCDgzrCk+zpvXawsx++d8ib2XrbEJVD4ilEchXauBic4M13kHbKuilFND3lK90eKfN0BXRjEEm9ZOuexL4HA0FT2mKqjy7dJIo5z6cNGyczseysB8FZ4llwTd63SpuBBrEWxlcBpnMQGFBIxQW9YWNrELtrnP50FxzFRVJbYLOLlB0Ywl3R+qicNU8XdXg6KZg5jwQnfLBH1BqUleBE8AUnrNfo/VpmD3HyvIAaRhd/bonbeISZPxR9uRiO+IDbt+X7RCbMc153lPlHNRzOsWg==
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 16:44:31 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::5f) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Wed,
 21 Jan 2026 16:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:44:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:06 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 1/8] net: core: neighbour: Add a neigh_fill_info() helper for when lock not held
Date: Wed, 21 Jan 2026 17:43:35 +0100
Message-ID: <7ec20113d5d809200e3534d3ed8f0004514914b8.1769012464.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
References: <cover.1769012464.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 45875a3c-9efe-401f-9f4f-08de590c58f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xNebgNIAgx+ovZVaFbro9KHaLMbsF64TTiCKboMBBLNMow0AYQx5Tv9nEwC?=
 =?us-ascii?Q?IqWyOPf9flhbnTZHwxbBI7PnM4ZyKnB/30vIsMp0Cox8VcLeH+HKZCKIsul/?=
 =?us-ascii?Q?aWPJuJCZ9XQFf0fzS1Lo+Zvb0Hlm3ujQg6R9sUHHb6TxE5oEi5bQCM01iBVg?=
 =?us-ascii?Q?dPSwqIfvV1ib58EFgwMFOc231YOXxMShKMwiShtKsvw2rS8xiNmFswxl3e7F?=
 =?us-ascii?Q?pf2dneHYg0ZMIxEQXITDEA83zvhHuYfk1bFamvEOgIIOWaSXJcVGqvYVunNx?=
 =?us-ascii?Q?ZceKUc6ouliYVMJjaNWprDVOSm7QRVT2WrB6QUV1tKNC+hq1jmI3Sag3wMvC?=
 =?us-ascii?Q?IQxKylovRa46NrmYLoi/47yBmYVhiY8aXH2d1aT+Rnm4voqIa4IF7Pfgm2wD?=
 =?us-ascii?Q?nKjJ2eQQNjf80829acPPzrZhquFByCPFX+VCGyHjF5ZfIk6ulh1TBj10t7MC?=
 =?us-ascii?Q?4XBNHN7LAeKr4FXYaC/lQH4mTo04GX51nccy9rBuqqnXTfLU6bqtMIkh2V2A?=
 =?us-ascii?Q?gpyjQicFwNhWiXxXwizooKdU4bd6L7A3Kl1YJlBzSkDZsTv8JdlePBR1Hn4D?=
 =?us-ascii?Q?fOK1lxN1B7xMuHgnKWVkaZ69stOpUFExCggHjKw1ax57bBnitej+m7yNlvbY?=
 =?us-ascii?Q?v1RqKh6EChkuq4r/S2ABS8E56rpMTXfIDFDVLOQW39E7H5WMw+/z8Ju7nVfq?=
 =?us-ascii?Q?9v49UeF8JicE7NOdPG4zvU6Zi5uJIGzbnQvE8LjOKHDSwFEKZBb3KYFyxo6g?=
 =?us-ascii?Q?WZG6BP66Db8OUCUcyCQB/gMEU0b9qs1a/LDTeBdqn10MXYw/h7uW9HEsPn/u?=
 =?us-ascii?Q?gn8pVU+DeKwwguVPiC/NCU5cmePtMOKZkOsWPISnBcbdTELoI0M/NR+nMAEf?=
 =?us-ascii?Q?OU/NL0JeIwelfwERQSOrQTqSDUsukIULdpO0P9e/qfMSxXyI/a/k8FoaRiHt?=
 =?us-ascii?Q?q0UW2iv8iVQgcOGMU/l8xPqErdBN3WtQJHhCZja7j4ZXuDPGmGTTDJDcdaDa?=
 =?us-ascii?Q?OOyZWGkc4z90U+QXyAV87e3RGfXH0LazBBtgJFhyE704V8fm5fBYJo7ht/YS?=
 =?us-ascii?Q?4JD8yvX+aeE57HEY5l7nyv2ZSmJTWY9Lq8qGiAa/2bBFJUgdXDzXW7sIfLT/?=
 =?us-ascii?Q?6pTM2OchOR2wme52qRS9R4hOXFpFqMftWaIQAuQnLUIpBt4nsC69Rr3LcdYD?=
 =?us-ascii?Q?UtyMjyT6DSPcwxlKwEQxpw6WTNpId80KiJAl/k5TvFgxqELyikAnFjixogr8?=
 =?us-ascii?Q?TqNYYOCp9rnRlSxByAKxxFRe3kV+CGgLVw7a8j1JiX9Jr7D1CRrz7mBhZmn6?=
 =?us-ascii?Q?bjzQ0N8k0JxA9UUgFmoxgdQDe+J9XIKg4wl2qcSjdoQBPc7cK8dVuRMnNnta?=
 =?us-ascii?Q?TAlKdFHovIbzzZwIlL4YZ+wrBrgCyBjG2mYqJ30O0mUnYFjyiinlBPVF3SFs?=
 =?us-ascii?Q?QmJ898mc1fZN9gWXRvuChYzIBrxLoxcLGj+x+5vPxW9t4EDJ/sdbx4d/j/ot?=
 =?us-ascii?Q?Icx86aPvLO/S0W6Lo4s885oizciz6rKZ1OwAHobhUy6T+zVSHew87jjaVLBP?=
 =?us-ascii?Q?LmhMOYu9aE3nEcjoXD81h456J2A7XdjEWPj03EfrSP78ZzPiQ5WvToKRG6RK?=
 =?us-ascii?Q?mA+1S8bsPKwdtfcA8si7qKC18Ut+KPbVSzaMp0slxvF6b2SZSN2ofcXfDraw?=
 =?us-ascii?Q?QN4WIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:44:29.8859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45875a3c-9efe-401f-9f4f-08de590c58f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251999-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9EA985A4CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The netlink message needs to be formatted and sent inside the critical
section where the neighbor is changed, so that it reflects the
notified-upon neighbor state. Because it will happen inside an already
existing critical section, it has to assume that the neighbor lock is held.
Add a helper __neigh_fill_info(), which is like neigh_fill_info(), but
makes this assumption. Convert neigh_fill_info() to a wrapper around this
new helper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 96a3b1a93252..6cdd93dfa3ea 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2622,8 +2622,8 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
-			   u32 pid, u32 seq, int type, unsigned int flags)
+static int __neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
+			     u32 pid, u32 seq, int type, unsigned int flags)
 {
 	u32 neigh_flags, neigh_flags_ext;
 	unsigned long now = jiffies;
@@ -2649,23 +2649,19 @@ static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
 	if (nla_put(skb, NDA_DST, neigh->tbl->key_len, neigh->primary_key))
 		goto nla_put_failure;
 
-	read_lock_bh(&neigh->lock);
 	ndm->ndm_state	 = neigh->nud_state;
 	if (neigh->nud_state & NUD_VALID) {
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, neigh, neigh->dev);
-		if (nla_put(skb, NDA_LLADDR, neigh->dev->addr_len, haddr) < 0) {
-			read_unlock_bh(&neigh->lock);
+		if (nla_put(skb, NDA_LLADDR, neigh->dev->addr_len, haddr) < 0)
 			goto nla_put_failure;
-		}
 	}
 
 	ci.ndm_used	 = jiffies_to_clock_t(now - neigh->used);
 	ci.ndm_confirmed = jiffies_to_clock_t(now - neigh->confirmed);
 	ci.ndm_updated	 = jiffies_to_clock_t(now - neigh->updated);
 	ci.ndm_refcnt	 = refcount_read(&neigh->refcnt) - 1;
-	read_unlock_bh(&neigh->lock);
 
 	if (nla_put_u32(skb, NDA_PROBES, atomic_read(&neigh->probes)) ||
 	    nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -2684,6 +2680,20 @@ static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
 	return -EMSGSIZE;
 }
 
+static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
+			   u32 pid, u32 seq, int type, unsigned int flags)
+	__releases(neigh->lock)
+	__acquires(neigh->lock)
+{
+	int err;
+
+	read_lock_bh(&neigh->lock);
+	err = __neigh_fill_info(skb, neigh, pid, seq, type, flags);
+	read_unlock_bh(&neigh->lock);
+
+	return err;
+}
+
 static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 			    u32 pid, u32 seq, int type, unsigned int flags,
 			    struct neigh_table *tbl)
-- 
2.51.1


