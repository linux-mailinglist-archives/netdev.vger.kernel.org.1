Return-Path: <netdev+bounces-252005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HKOEIgPcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-252005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:40:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C25325AAAD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E66B21B1F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7D1547EE;
	Wed, 21 Jan 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIa/RSY7"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B9341062
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013907; cv=fail; b=q6q+O81AY8BK7ngnpApBtLEE73wkCaACba0ojkmg2w7wYQB3D9GfKEuYSEaaJ/5Lh9cdyubJPQbmiNj4iS8vr+uTE5jYbp3DCWZ/oiMnQ7Pgl3Hz37+CdIpxk3FSkIQXrltOXTCHKUYXPomC+jSu5jQPX39nFJzAp2/doDR+0Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013907; c=relaxed/simple;
	bh=5yNCqlktoTpwmICmVSRxpPDY5+QFPVZ1HvYrH/d7XA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEtId/0B1jeiA4S5wigS7oHfSmjWLUVwRayxUdXY4sPSDuE1qU2Otr3U/BMP8EbQbJxn9vqmtUrzHTFFK6jz4UZ1b7+x7jV5f60BAYaDtXMW0IQh9toRdnRw6dYA4imy2wXKRFqjoSc4vOGeyo+CvHlYibaC4b6LRhRoNCDX3nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIa/RSY7; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkbxHE/uYypn021X9s+R5uMXeGlueK7Ctp/Jf2XPMI+nb0/1iobstOZT2Qd/2f1EFzZFGgij3t12E2rsP6Wk0eRF+78jwZj8tXFnHqEUY5bCvxRS3XwCVfsmBQ/xpsyI1Y+Ey0WLR1dIspRRkv1Hun7JJ5v0pxoblFjjISGrJderUy2msims0Qo9srwHLkAvvHJowphNfDhocSHRhj0zkZQor0LtBYLwUt380K0BT5A23q7M34ye5sDW+843KQpcMI9wlcU9a6LHkTjfzA5fI//YBhu68H9t0ZsIg2isdXfSwq+DK4W00Y+G3cAqF8RRVs2HKXZDLIAKGukUrPqSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMIs8xQ2hkC5TmKLsZjBnHOnnFftlYkfi39+2Yargvk=;
 b=fq3r9jJ8vymUaLjXL/CWjx57Tpyl8aiddas388LBWxUVaUIbQnXvexytezNaa+T6fItyKQW7R/ELOhuYccR50wGjS1gTvX3PwDHdmedLNPqb9/If+1jJRHfWp2KDff+TaPxGRB+Ye56IXgMKzRWUnZ76puU4HmwAZ8xkaXBTRgw7+dXvQ5RjSaE1/kdbE3Utb7Iz16c1OjS/C4TEuyqJUBwulLzcIDgzxgehuT82BGc6Sxew6avP+zQot95MrrB1TdKfSmsMJzebmtr1gmpUUgEkRP4lBegWX6bl7HN+NElX3DmeP4nKW9MFRl9E+jdOik3o+KJk7LClhgiNgBk8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMIs8xQ2hkC5TmKLsZjBnHOnnFftlYkfi39+2Yargvk=;
 b=cIa/RSY739Bcldjj8ywhoXpfv0Dg9/6MmN9g2cklEZ/nVaY75Ht2qwGYSEVPSrSt1O9owIDFunEpQP0KaHJuBk1KPC6ZvC5dj01rI6m181EoRrD2Q2IVXRAi/fnuy+kAfEMc5W77bKp531IWJ3GJC33eAq8uivq7s3wgAnU7/3i1kyAZ+w8K9UGLOFuKbV0vrq6t9YvoeYRiXyQhGqL+bKZ5+Gqrnz1GFIiJULk/9lhe47DWmoJ/4tSFV986f1WJ1l26CNHuzhlRwEADmIj6wUO/P8hFiZFb5yt4GsvxXBqQOTX+JOXke9v0tJyrXf4M2RtV8ug8QwMEGO9rDrpLJw==
Received: from MW3PR06CA0021.namprd06.prod.outlook.com (2603:10b6:303:2a::26)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:45:01 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::13) by MW3PR06CA0021.outlook.office365.com
 (2603:10b6:303:2a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 16:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 16:45:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 08:44:37 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 08:44:31 -0800
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
Subject: [PATCH net-next v2 6/8] net: core: neighbour: Reorder netlink & internal notification
Date: Wed, 21 Jan 2026 17:43:40 +0100
Message-ID: <f3ef74d5460f14c4d102b8a5857d4a6624da9a5a.1769012464.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: b54acb50-e1c7-449d-4c5b-08de590c6b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nNqkFH7ii9IThrOou2HRslsRPAf29OeYPYvsqPZA4hXLRpHtSInNsreYdrq1?=
 =?us-ascii?Q?areWgJQeawtE7oiWcRJvhwoINEA3TUQ/ZjGzBDQii0FiOdwHGjbrn6O8KbKh?=
 =?us-ascii?Q?n24Mv3MrDe2XXxgX2XLrO9/RzCcjf8Y/iRV0rGGUBJsoNN9PJ5SO9qzrNiST?=
 =?us-ascii?Q?q022r7tsUdsC08iccAXZxm/4+elpcSs318Bcusg5xJdEiuq+MiQ0Ru9rOCvk?=
 =?us-ascii?Q?I5p2XPQyHZoZq4JxrwBRQNbo3XEVIxvesg8lUrE12GbE2Cz2TkznBVql+8lk?=
 =?us-ascii?Q?MSEP5OyDLdBwIOP/Go1b3ygTkzbSg+Mryui9Z8IQMYxv/nDuZ1ilvW3s2DgY?=
 =?us-ascii?Q?srLJ9kXnJ49NMD2yeCYTnuBGU4GPuAwAF5JFdWfdK/YHwW63iO5HqpxQxoJr?=
 =?us-ascii?Q?U0PxfQKlU18pXFdctthOB7rHQRwUOoi/RknJgkCHcmCBZXqlmm4/BB9tMG/N?=
 =?us-ascii?Q?s3+S8Nq+B0FHbxvc+eRFdes4MJnpAiDvj6uSqQCjifbfjvNgB+RbdVVHbA1u?=
 =?us-ascii?Q?0ycL2pGByqOtsyCRrIwu42ZtaW0Qj6h0sCSU0IpUPQjXSm6z2tMiBk/PrecX?=
 =?us-ascii?Q?b1uotO3vBRGqSrizbcxVXHqJrWvmHj82khIDwGjk11klQSE65IdXzUVOHgig?=
 =?us-ascii?Q?iyL5BJ7rgdNbl76w80jJg9NTFjpm4D/0kztZvVdPlYbPaO+su5I6N0JJzyua?=
 =?us-ascii?Q?npirtdmpKUGvBEkO0h/95TCbwmaEJkx6zF2hpEdrpP+EjRAu1H3kJEcP8x4Z?=
 =?us-ascii?Q?uC4nruKowovDGFJMb13/oSwPBH8njY8/L/zoCTDf4IzkJtgJZ50lKVj++pOI?=
 =?us-ascii?Q?CUBI5dtraSyn5TteWj9wZUDrmQ5y0mM22LciUKuuIPUTGLqB3ypUJR/7jMiL?=
 =?us-ascii?Q?SGnHLiNTOT4+etz594rf8GFPCFOdffeQ3DacLl79a9h6T8E3WgLKnFiUowSV?=
 =?us-ascii?Q?NYnKfezZQS++NemJZZYhK/P36aDuxy+sJMiuTCe1HZsODYvKfWNbM2l+FG3/?=
 =?us-ascii?Q?67/U7SoLrSjo3/VT8btVUE0Lf/jqh3oyvX9YBMhdQ1NJHXJ4iqT2hepF+eOs?=
 =?us-ascii?Q?u8hkMoCQo381cpzFcVw9r4XFvHQi9hlGrq7TUm+cOnLGZNzWEu2XGV4ePs2g?=
 =?us-ascii?Q?nxDM+kyn5cXHer0ECelwYPoraH0fCoYaRBNTXbeHYaXD1X9AaOS+IgPP8pfT?=
 =?us-ascii?Q?oW9raeYj150kleMRPlgvaFs4i3N9C4zwQEMQNofA9T8M854DQ9HFbsxQwTIX?=
 =?us-ascii?Q?4j+ZBuByKYvM8POT+1IryzLVhMYtiookDuTGKUiU+n1QEA65z6fmcR4hJ2TI?=
 =?us-ascii?Q?FXDOeCalInv8d8AfR3bUTXd90/6z1xM3XPsMKhXmzjygfCLuIhUFnxIU6sZr?=
 =?us-ascii?Q?YiQN/CnWdxdjir9Xh8knfVs7oEZZrcHcNfm6PdHrtaJjgfxNlTR+l8xgNpfb?=
 =?us-ascii?Q?mEgUBq1WmZMtgiyfzJqlgnl+V7uMHNNsT55JLn6/QMtwXlahioKhM+0tvrX7?=
 =?us-ascii?Q?+YIKaJal5BETxd6uUjmMxyLJvsLNM/GuDHzsZV03pFnqZRNkT4fiUoAjqxM0?=
 =?us-ascii?Q?MUbphhqYZgprAW/6B7Pu3Odi2bt7ouD6JX/Z4xeUtdho1g+NHlS/7zMCVJkb?=
 =?us-ascii?Q?QRqP1WI1Fa3AXCDZDVsz8eANgKrFFfzeP/nSMxD48shmz4jjq65i00oAgUbE?=
 =?us-ascii?Q?6I77kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:45:00.1980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54acb50-e1c7-449d-4c5b-08de590c6b08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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
	TAGGED_FROM(0.00)[bounces-252005-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C25325AAAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The netlink message needs to be send inside the critical section where the
neighbor is changed, so that it reflects the notified-upon neighbor state.
On the other hand, there is no such need in case of notifier chain: the
listeners do not assume lock, and often in fact just schedule a delayed
work to act on the neighbor later. At least one in fact also takes the
neighbor lock.

This requires that the netlink notification be done before the internal
notifier chain message is sent. That is safe to do, because the current
listeners, as well as __neigh_notify(), only read the updated neighbor
fields, and never modify them. (Apart from locking.)

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0fbdaae7df99..187615bcc1c3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1187,8 +1187,8 @@ static void neigh_timer_handler(struct timer_list *t)
 	}
 
 	if (notify) {
-		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 	}
 
 	trace_neigh_timer_handler(neigh, 0);
@@ -1523,8 +1523,8 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 		neigh_update_managed_list(neigh);
 
 	if (notify) {
-		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 		neigh_notify(neigh, RTM_NEWNEIGH, 0, nlmsg_pid);
+		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
 	}
 
 	trace_neigh_update_done(neigh, err);
-- 
2.51.1


