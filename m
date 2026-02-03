Return-Path: <netdev+bounces-256475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGk/K4d3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:32:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E126DF4C0
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E49530EE18C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA6377578;
	Tue,  3 Feb 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JkHgLmHl"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A982374748
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157789; cv=fail; b=rQ4wPH2y82e0EZ0iLXqIBMEa0esw0EhrLiR7r7r+pZoaIvyh2JHJhxGRcwv+gkphFfeA1Gc7rF+3uhXWLOwDHnm9uzD4K08eLNk/7JQU2tJegmeOShCbtazHGkAu+S5+wMP1bYocnn4pxHzeLDhnMg7eV1I5poZq9OMtpWWWAVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157789; c=relaxed/simple;
	bh=8eVqJNRcMKcsZIjnQ8IhIdQ+B3AmfU3xtHTyLsmaV9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu0UdZVDuw2PuI1H/kmqHReLxZ7fmwVJphewixO7FmKQr7ywjqdX6jk7MhqSDO2SjpPhYTOgYU1Ia9uqAQZv5LwtjrWhj67D4w8BCHQaw5XFnMFV9FuGfAjIPUR1cPQ4Xi2cw79V+D4uiEf/KwDPXejl8yx4IdnLKaHDqber+OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JkHgLmHl; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqjgLkzPF7qlRUBa/JZYPwlLLpn+bifkoh0ll86ljsM03NBpSa9zrvyjaNJeYLxrAdh4vVEsQeZkTODwqkHFwQJOMrwBVaFbTmtRbO9EA1NRdKGI+K554yp82qx2OZ+S+I+T29rX/Me4OXcaJ/7NZEgmBiKj9DXQEDaTVQud0kqs9TtQNOXZ70/4sYAgXOTtVtgILCWsZPJcP+RkJmc7oH3RNUMxM9rYqLsCUte6yDpCE85URUgBaqW9D8osAIIK64rlwLoGuYvRFwqdxnfWkSspmV0GK2iiRtXYbsdts+7ZFjw7FRJuVR+modVsrr2BQw+RrZh8Ul3usBf07+uwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRxcCHGmqoVqN971N2OmjIP2KHZfgGJ63tA+GZMVNDg=;
 b=rsAnngGEod6Kkh5meX0LKnq+8f09H7q4x0ht9RgvJS/n+UV+HkiqA6lmoti60ofV9Pq7EsTPf7ca27shed5jZ7V/MprU0akAsQTwDtcfrDYQbMiekmm2WgpfZvdWj9hK5qjENTjxx+UUROLmu9POmfWVo36I4ER3D6b1y5oeHihYreaEJIiG4k7vlpcM4HPS96u4rfVtvBY2qkQD+7Y5GtaDM8XNZtTdCaYlyIVzyymG7VruzFt+disqG+/Q+EzxtU9Eq9BoKDagMKSluHWjBljbJ175eo1hvqtDQ55G8MLNm5FKuea631In7Jcsrp2Ozt85D1iIicbsP3vsCajU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRxcCHGmqoVqN971N2OmjIP2KHZfgGJ63tA+GZMVNDg=;
 b=JkHgLmHlJn6tTYuLQ1i07/OXwdz5cQgX6rM3iuxJOgD1y8kRhhF377Nbtp0s8jaukTRqFQpHflFxsN6nZdg/qy5Gyw8ne27GF5fJsVth9u7SE4uJHIU3EBbc8ixz6pEVgQlIA9av+arZBwEDIxNO3JU9AVKdVe8X44lgueyAyqoNAky9UvcW6bhQjUiCJR19NndDDLiWOmGHivzIlAQ7EGdzgPvtwWWUQTWtW3NMwvQSn4PxoB8R4LJm3O9GJld9+PirCbB7EZlnJxyeFRYccPnaDK68JPB+zRdnVOiFnn17RVdoCp4Siin85OS+t618cWrJy7xccRT72FwT4LQDLw==
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 22:29:37 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::9f) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:19 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:19 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:18 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Tue, 3 Feb 2026 16:28:56 -0600
Message-ID: <20260203222859.4219-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 5440c72d-037c-42cb-7b1e-08de6373b6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PY+T+hfpCZbQoSBjJPjfpFnYMDch2fqB8WOvgeVRFsZjX/lg2no+h2zhVSrx?=
 =?us-ascii?Q?4mnoxRRTiKHuC2FFtMnuEluXOsVbl6MsqK30hpQZMlsNCFM4juRuXxiJcYJZ?=
 =?us-ascii?Q?QRQDZkV2TwhLhysoFKkHYLQ2RAeRQnndwVTTlajS20Rn9VV5/SokDviN2Z5F?=
 =?us-ascii?Q?cD0I0hjj1IQQPPeEhp+mXC439KehF3o55/vyoUts1BFdsR7cPpDoyS42cC5B?=
 =?us-ascii?Q?vJpKm/1M+c/aswvARMremJgag2bqs91UfrsL1g8raPNvvJJj6PqI1pxLwg0b?=
 =?us-ascii?Q?dtN5NkDhQcTZTrdKNgbBQRr+49VK0To2m4nrmovZs+3xGKh6vyHfRaT6fM6G?=
 =?us-ascii?Q?RDTXmKvC7jUKFkXNQituEq2ZV5idR7JyowDbodzZg3BRUL7uUsS31T3L9Iap?=
 =?us-ascii?Q?pq8BUN8bXQDq46qbqqG32yY0RZ90PNgJ2f6DzweUi3PvIv0COmSZmY0pIwp5?=
 =?us-ascii?Q?w2ih1ADI9us7uC7ogx6M8+X0pvKHDwbBR7pkGAZH9RAGvyPr3zLbIV0LmxCQ?=
 =?us-ascii?Q?ruJovWlaA3YN+BgHJu0nKeXV0XyqqdwtOr73BDvB3d7DKY5WP9G1FW5HES8K?=
 =?us-ascii?Q?xRfJvqD+klEioy7x7hCQCnM/ktS71zQ3JlKAxqP2NA+Y+c4pEQZczqk+jTsy?=
 =?us-ascii?Q?FSM4qx0VdUR831R5rmJyBu4zlIKKKlmaZOno5+mv4V/+6LcJu8OgYnsWMRk8?=
 =?us-ascii?Q?QVl8n5exQX3boc3e9Je189UksBcynLy1LxeWGD7GDRpe9cBZPr1H7t8cF3sh?=
 =?us-ascii?Q?LoG7LQZtoa8cX7vWP30wqIut4GA3aVmTnRYHcHql1aiizllVwQYCpf65K6gW?=
 =?us-ascii?Q?PEZp33z4EtZWNTEfhJMlSvKSKCSb3IERZR6nqzezswrzhnM1rrtrfKVC9M0Q?=
 =?us-ascii?Q?XvU6b/zWmWe4TW2+Ho84JLSB+kZTzcJqwqWK1KnmzwIolMRuRVfmEHZvUg5t?=
 =?us-ascii?Q?IfhjzGzOzMQvEgiU8EmzrD5m8+D6thEmRzeIB/7v71oE7ALyp3SsTuBvCgco?=
 =?us-ascii?Q?/TNQZS19uxC7U3ipzbGL6Z69bNv4vqZZpbC7yYRHdZiWhZFLx/C2YfKQlAqE?=
 =?us-ascii?Q?GHPpB3w/kyHJKwyUyeooDqiTdU1FWorbpen4SKxHowZEADVJlUPCTNsoptKV?=
 =?us-ascii?Q?fPrGdHoGDEKm1E5gUyjlaFDuVXfd5h/tBKJfROGrVthTO8BMiYLtXoJXy6uq?=
 =?us-ascii?Q?fumWF/oUpZzm9nHBrUyBbpCn04ocij1ZiNEL8YiNC8IFZLW8BmvQMio12C9x?=
 =?us-ascii?Q?1tIOvOUXgUvKesM9MIJJB0huPChIv9DJtNz1ZeXdsoeq75CqbIbvLHCtjrR8?=
 =?us-ascii?Q?rJ2x13Fnptbqh//ruXklPFEKkcOsybiweJhl0d+XwTOsHRRHQ/2p7ghafOLZ?=
 =?us-ascii?Q?1LRaiTj11dklqzOkmgSWp57stFx1JwPsuQ1/Nhn4ZDdKnGqBSb5PKycwt9gE?=
 =?us-ascii?Q?Pp5bXxVW0FEsrATb2Uj2GWVVWRAthes4ZkRcmIaVl2JRi6ZzTOhCyHkg979Y?=
 =?us-ascii?Q?Q9eLAtfTLEVeJvt8zVs+5CUVZpqUhztTt08L0VECdpOoBWtog+1yD1+Xlc67?=
 =?us-ascii?Q?B11QrX/zFmFpXStkaQl/0PB7oDPoA8tb55s0nR6pVhFUndfbl3Lph+rT67jQ?=
 =?us-ascii?Q?fAQW7FPR4c39YL2sVkFqhcu2wX+9zF9HcJVpJ+oAOwKOwBjDn65f3UE8YBXh?=
 =?us-ascii?Q?MDDdHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bxbg2ATxBadyFSlp40qOgPB2nwU9GKLzs9v08NEx/874vdDJ+tD0ShUtyngVW9Js7CxMCAcQBheF1e7im2ZKvYfZjYqaXUHQ1wOEvPPQH7UWRpXfIat5rhx5r+4xy31sGPGf5ehxRHI9/zCDxqNmck65Dusm24zjTRUJLZfLt0WTxFvyWlpflX4wHSCsJLNTxIC2/EwOmqr63/BfBEOqpAZHTMCuSiCbQExjbddg71js75iOOEsWLMEaMTd4pp6DirHut/T9NHp4yHHWqo4/R2ukuANSvrvPE2Ot5uW614sUnnoOMGE+3k7Ep4MBGSBUyAlZaEz2ZCFtXwRKn6NInv+rj5YAH5NA9491zsWwtSHh16MdYxgN2uMbLIuqH8QMNd9zbaLfYHlL/wEkfWIly0ui6Nsvmp+T4Jq5KWuj4UN+ysU6+Bjeyvmt0Iku/5WO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:36.7627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5440c72d-037c-42cb-7b1e-08de6373b6a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256475-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1E126DF4C0
X-Rspamd-Action: no action

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.

v12
    - refactor calculate_flow_sizes to remove goto. MST
    - refactor build_and_insert to remove goto validate. MST
    - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
    - Check saddr/daddr mask before copying in parse_ip4. MST
    - Remove tos check in setup_ip_key_mask.
    - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
    - changed return of setup_ip_key_mask to -EINVAL.
    - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST

v13:
    - Set tos field if applicable in parse_ip4. MST
    - Check tos in validate_ip4_mask. MST
    - check l3_mask before setting addr and mask in parse_ip4. MST
    - use has_ipv4 vs numhdrs for branching in build_and_insert. MST

v17:
    - Fixed portability bugs for unaligned reads and writes. MST
---
---
 drivers/net/virtio_net.c | 130 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5cbf26d8f7ad..92e34f51737c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <linux/unaligned.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5818,6 +5819,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (get_unaligned(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (get_unaligned(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5829,11 +5863,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	if (l3_mask->ip4src) {
+		memcpy(&mask->saddr, &l3_mask->ip4src, sizeof(mask->saddr));
+		memcpy(&key->saddr, &l3_val->ip4src, sizeof(key->saddr));
+	}
+
+	if (l3_mask->ip4dst) {
+		memcpy(&mask->daddr, &l3_mask->ip4dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, &l3_val->ip4dst, sizeof(key->daddr));
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -5969,6 +6033,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6000,8 +6065,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -6013,8 +6088,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -6022,8 +6098,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6045,6 +6148,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -6082,7 +6192,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.50.1


