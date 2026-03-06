Return-Path: <netdev+bounces-264842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDIPBYjvqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:15:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6307223994
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7641D3074BDD
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227B3AEF33;
	Fri,  6 Mar 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VL+94S3N"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512CE3ACF0D
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809866; cv=fail; b=oFOm/zrJ5tep8aFdOlpj9p6uPGiUyHBPWnbRdLkCgFr8TrSdNmGoAcyUe5QjKc4rL2VvAyu2+YFECAbC+CqddaNTSubb3Weus+1Xfl+4oXBcn0Ts8w7T7T/Hp4pxkTnZDfp4lWPF+ejkfJ/AlG2khjJRR+4CLLWdMYvoy2NWNz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809866; c=relaxed/simple;
	bh=MJPHGS0bCY+Qa06ON8C8/YSu6+FwGEzGVQfuRaiZ+oM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwbmxhaFKrz7CUVXGHmxLxo7bSfrDV9M47GBxI9P3hoZw+PiRsxlY8hVUJDLjSvUKCLYBYxdfPU8GGfQaf8484IOAzpkJ945dp9bxjOuvsJbKz/+oVNoSQ3YyinzY2Mv4qcMHHTL7wF5wQoDRpaTeFiPYz2rkpSCSAsQfCia0Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VL+94S3N; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L775dJZRUYcZlQUsqsmTJ73Fv/abzI2MOBnX74CardtwEiUyLl4QlOhHgMHTKetgvUDwlc+F+xwe4Fuf2br+zJtuSopoftvgJuYyfVK83Am8bKwyG17XNKDibs1ywKgBVj4DIDgwLShE40BHIb0plBRbiD4KWmarEYg4CbzhY2H0hG5zYKDwQo1a1tV4e7PXiCeu3dVfPewrBR7+bWJb5+TenmL+9vQ+4WEf9x/HVAFoHrbXIXinoGtODol0PM2rEZ5jOHd3SjOzmL04iSBwbPfNJTURp7ZCGo2EfnO6xS9xH7GEJ1o3lFjiQEs/alnkt5UCqTqnkIHw1hf3LllFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIUK0/FJHqkppJs/KlQtb1k4X821P9e+tmyw0Oq4Xcg=;
 b=A7wEFAfI2/ybb8HEC6aiEdaFNb6JWiWwvIzL3m9/HyjSuZZpA4HoWPkvZntVKp4za+gfYBVZolTiiFUHbgFXjjvwYPNLRNdTZCAt0GR62T9Ia/30ikYkdOn6E7XIY5ZgwXjlTS5bnjv7g4yPsimxRz4810iszA+U6UnkJavcFpM5/NMyPOmjH6YDadE5sr8eFpk/DBqp9utSOGJn3ouKQ/9/zn5H/Bblj70uYcotVi4raJlZ5593NJNXnoKUcg4OiXMZImgGrvplbTYbd9amTSHfUxTg3eDBUfz6tSARX7J7ske9OiGNDEDb2JjaiDmdgD2tpaQMDtnXHRIxST84MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIUK0/FJHqkppJs/KlQtb1k4X821P9e+tmyw0Oq4Xcg=;
 b=VL+94S3NfowKI9XR9DmiB/Cmk6G8Jnq9rNNdTxayFaYMv//8W6Vd7e3SVcRzQLilyalj2IHpyp0bTp2foIwxjgC732mgJfsGwAc4kZz5W1ByV/jPzuVLH1EI8fAAQvrcOvaHasNkNYCodQ487fz6UQIw0z3+6uemY2i6wEburXf1e0Yz74LhhoUaU51NolmjbtQmfcVY0ZMqxMzQ8KU1mdCX2xcWis0bmF04+Xg0XWfO8gopMI91UKgRvJ8C6M1+PBqAenhemkf6NNafxFL21IHMAqqzZr2n1LkB0KFJrVfVk3/WD0w9R1PXU+U28RfdEEpNq7A1K5XizUzKy9jctQ==
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Fri, 6 Mar 2026 15:10:56 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::3f) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:10:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 07:10:31 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 07:10:28 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v3 3/3] macsec: Support VLAN-filtering lower devices
Date: Fri, 6 Mar 2026 17:10:04 +0200
Message-ID: <20260306151004.2862198-4-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260306151004.2862198-1-cratiu@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd03035-f1cd-4c93-e1f8-08de7b9290cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014;
X-Microsoft-Antispam-Message-Info:
	UWfkWfLrTo4GjXaQMkHSnJdFTghhtJXRW4hxTQxgcAbF+CsGiTC390dXltWTZt1L2gF9Qr18swKijI4oDy3J+jBr5qI0nLBUg1mTy9aV/iqN8Hsm24Fo7npZwkw/kEz3tyjEDXzQAbOfBloZ0XPWg9P4YgGqYDF8aabd7ppyYU011je99x1IV2sCMEMgL/7WQQt+Rfha5YedeLMrpiPjiOIMUD/cCR8Fck9Rw9CNBUHiSOmLj80zWW6PdZFJt7c742ie6zgxVb1/dLsC/JzvMWifZl8eSlHrcG/tf69dmnTYLT3yfvOLiEsKEylyoIZayhahEMzfcSKL4Q3BeG5kVCniXE2WWB/GNeMmQT+uiB/lcfYogqQaKltbD0foXsNgxlliCL1V7+MqjTIO//dEXaNJ7fCnxnjOnuVFrDOkwc0LFR3nuAivzSti1dnbSLJkAmYkE+IsiVRQimBOn4bZe2x55tgKWm6FGwxqK70eCbHHzjXQCbp9bxM9GwsowUQqscleXWXidBxmmxp8nVSU/14lXe8kG6Xoips90c9v//Z/lcv2TrKlJwTunRFoxjpy2Ctb5PAjIYm7Lss2y/pDZVwZan58e8o+sCY288aScZo7uAFJczODEu2z4k7j/79SRuMRwMJLSuLyIUNCS8+RO0n/ZKuSw0pGQZIhFkFdI8YNvVtplUd5XLWQjExZiFsEKAGO21wZqzBROzG/AFPlbXcRL9gcf6W93+GIRExJGQu1uE9BkE5gDp1Fkgwt4gbGA57FCOr+YJe+dSN3N5virg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uy1sSaRbXUPTlSeMRiMqtpMMWy81ZcNlBbadMln0XjovJFRmJxXsR2btbT1+vJqJxo7td+jsq03LZRN6tmogY26KW34ig+qbLfeOOT/VXsn3TIQnF2OLKULgj8J64DVEUPcSOYF4BRUXj3jyC7jeXwWxuYpxbU2ZT+/cHDfQLTdxXC1+ojYiijX1T/3jbd9QSpzAwxL+vghCeu7f302PWgl8aS+vy15WM4LT+UwQpyflVt8qfOSBW7x7w7FGyTMdH3PEzAcEgR+fKcNLrvqUCjEYxow2afKdocv2h0WPPJPTFzkc5hifmBQcbrU9Ipp9PNui9tcEVrTI3BtsZRlpdJSVjdo14kQvdEd/8XVkwxQEJaSbRJ4zh4FsJ7RxMGmO3iog2BKK1j+opINXaWdFd0DYb2HEyuIxmVIksOUliG5DULEf9Y3LHOm3acc4aOgQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:10:55.6011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd03035-f1cd-4c93-e1f8-08de7b9290cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Rspamd-Queue-Id: C6307223994
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264842-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

VLAN-filtering is done through two netdev features
(NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).

Implement these and advertise the features if the lower device supports
them. This allows proper VLAN filtering to work on top of macsec
devices, when the lower device is capable of VLAN filtering.
As a concrete example, having this chain of interfaces now works:
vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)

Before commit [1] this used to accidentally work because the macsec
device (and thus the lower device) was put in promiscuous mode and the
VLAN filter was not used. But after commit [1] correctly made the macsec
driver expose the IFF_UNICAST_FLT flag, promiscuous mode was no longer
used and VLAN filters on dev 1 kicked in. Without support in dev 2 for
propagating VLAN filters down, the register_vlan_dev -> vlan_vid_add ->
__vlan_vid_add -> vlan_add_rx_filter_info call from dev 3 is silently
eaten (because vlan_hw_filter_capable returns false and
vlan_add_rx_filter_info silently succeeds).

For macsec, VLAN filters are only relevant for offload, otherwise
the VLANs are encrypted and the lower devices don't care about them. So
VLAN filters are only passed on to lower devices in offload mode.
Flipping between offload modes now needs to offload/unoffload the
filters with vlan_{get,drop}_rx_*_filter_info().

To avoid the back-and-forth filter updating during rollback, the setting
of macsec->offload is moved after the add/del secy ops. This is safe
since none of the code called from those requires macsec->offload.

[1] commit 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/macsec.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c2cb2d20976b..dec6a89aae2c 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2616,14 +2616,22 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	if (!ops)
 		return -EOPNOTSUPP;
 
-	macsec->offload = offload;
-
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret) {
-		macsec->offload = prev_offload;
+	if (ret)
 		return ret;
+
+	/* Remove VLAN filters when disabling offload. */
+	if (offload == MACSEC_OFFLOAD_OFF) {
+		vlan_drop_rx_ctag_filter_info(dev);
+		vlan_drop_rx_stag_filter_info(dev);
+	}
+	macsec->offload = offload;
+	/* Add VLAN filters when enabling offload. */
+	if (prev_offload == MACSEC_OFFLOAD_OFF) {
+		vlan_get_rx_ctag_filter_info(dev);
+		vlan_get_rx_stag_filter_info(dev);
 	}
 
 	macsec_set_head_tail_room(dev);
@@ -3486,7 +3494,8 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	 NETIF_F_HW_VLAN_STAG_FILTER | NETIF_F_HW_VLAN_CTAG_FILTER)
 
 #define MACSEC_OFFLOAD_FEATURES \
 	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
@@ -3707,6 +3716,29 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	return err;
 }
 
+static int macsec_vlan_rx_add_vid(struct net_device *dev,
+				  __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	if (!macsec_is_offloaded(macsec))
+		return 0;
+
+	return vlan_vid_add(macsec->real_dev, proto, vid);
+}
+
+static int macsec_vlan_rx_kill_vid(struct net_device *dev,
+				   __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	if (!macsec_is_offloaded(macsec))
+		return 0;
+
+	vlan_vid_del(macsec->real_dev, proto, vid);
+	return 0;
+}
+
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -3748,6 +3780,8 @@ static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_set_rx_mode	= macsec_dev_set_rx_mode,
 	.ndo_change_rx_flags	= macsec_dev_change_rx_flags,
 	.ndo_set_mac_address	= macsec_set_mac_address,
+	.ndo_vlan_rx_add_vid	= macsec_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= macsec_vlan_rx_kill_vid,
 	.ndo_start_xmit		= macsec_start_xmit,
 	.ndo_get_stats64	= macsec_get_stats64,
 	.ndo_get_iflink		= macsec_get_iflink,
-- 
2.49.0


