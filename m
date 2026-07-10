Return-Path: <netdev+bounces-306721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AzG6Nql5UWqTFQMAu9opvQ
	(envelope-from <netdev+bounces-306721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:00:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867173FADA
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=GmU7iIWR;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306721-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306721-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9A2A30058E2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1449396D28;
	Fri, 10 Jul 2026 23:00:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4630C632
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 23:00:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724454; cv=fail; b=tcrTjae+nvaDAWxOfXCprFmcS2MRrqQWNf9D4JFBZ4AA3nlx6vt7zCCV8bKSy9DP0XVceR0wRVPVpUNaWHfya1PiuIirw97TgCY3EUp9L7ExY+zflTdjRE0j6NkIjKw+guS0No3EkwoKFYP5HcYznnDLJZ659NSuAF6dRH1GGRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724454; c=relaxed/simple;
	bh=TOQCJ5x3/i/WcLSM3lK++yvYVFUW0HntJ3VTY4X9eAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h7KdvqgEdJ/Yvh6pwBwB1VhgSpLWAC7QagFLRTx7Qicu3RYrsF66jC8WeQuP7cYQCx69g99JMf6nHZ6PtMj++AHs4P82wM8/AvNzff7uvEDCQwscasGReEJb/aOkhTCfYuiiLS617KrErM2mUv8/VCog0Chp8cwxPYfexzPcHs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GmU7iIWR; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XarGEqMCSBNnt10PswAKfHYQpfJbW+pTgOiYdY+4ng4Tr59SKPnb5HpgrwpMMftDgo8HDBZJGkLuJWzbCTovg/DqWCBJkQ6LaPpWS2bDKES5Y8zpNvFN8aiiCoExbs89xdffxgvduUz686E7TBR66dU+N4Vf6tPgEo5ifnCqv2vMesloh+60lraVa81Djt6wcSEawfLFT3aU6hrFHRpa/VlZ4YinkwkmBlnwLnONsFetjwj4LE1mplW4U/biCAMwC0m4+ATVuNvMWlKrNEkIS8+4D1Ks6ABsT724y7W4fWkO5YqiO+N03kppPe0Q1xf2boqvbgf+8s9d1hcnOdEXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd/PHfztKHghACdSPDXVDTfNR8h/i/iX7kIVvwkTD+I=;
 b=UCO6mXTanNfZMRSp+jikVTXmkSY6Em8YkFXrk3BKUQFhOzgqkar+/YAmKyMpQo3zS1lYroEBmUZ6wrKxE6eE6ciboDXoliCVtIs18MesQs2UW/go/7deL74oKMMiGb5VHlbufVufgQgaIXWF0808D6Q+vkfwqbI5xpsOOsITBQaNCzv33Ue1rSB3KPoc0mzxaVFeoEfIJVWF8KpMjGN//AdJJUuXyytbjomOUAN/eXj9N5KAQGTuLlvLdClOHfYHENNQtjv599NnKH6fOTnrVp45akrkkwu7Fa3VKBG2rnl9RXfiaUA9VnhHai3iKkLNdvBvNyJHUYPvppUVI12oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd/PHfztKHghACdSPDXVDTfNR8h/i/iX7kIVvwkTD+I=;
 b=GmU7iIWRusgCTLcF7qgWT7vi2VgKbubHxQ55tITLkYThBtTtUQr2mguBmexqUQG6IQ1XBZfudBL5Mi9dYcF8K1/oZMn+yL16lyCw8LP7ddqBiif0/Ga/d0yb5pVI0x4NX5N3ty9uT+YA0b4pz7DlR2gKmTcoG9CsO/V6nKHY50M=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 23:00:47 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::97) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Fri,
 10 Jul 2026 23:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 23:00:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 18:00:43 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Simon Horman
	<horms@kernel.org>, Eric Joyner <eric.joyner@amd.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Brett Creeley <brett.creeley@amd.com>,
	"Breno Leitao" <leitao@debian.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] ethtool: Embed FEC hist ranges as buffer in struct
Date: Fri, 10 Jul 2026 16:00:26 -0700
Message-ID: <20260710230026.47721-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c8f469-b358-4224-62f2-08deded713fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|13003099007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	UqE25bIooeb6tuOYp/SYVhrVxSFIpfnHGJt/WGgaN6rIWEpeoQyrzaZFziVjCzJnakvVdrVDZH2EX3Xn/OPJ1aLRd3yCK9PlAeSCP48SGtVV7RQ6+7S6XQH9azJ7MRQpZZ6ENs6lwGNmHpzTE//dqQw1+oKyCaaNQWw88f1xreOZCOZCBE1hMnKXMNA8q61zd05EHwsL6dNB87gXZ0I2JoR8hkzQj3ibtQya7ETJOT4HzTmFOWbB++Ig9jYwOZGlQ8wD7hpJGbVV1JqR+Dt6ViuoiXIi76u+94mj0LVJRpn+Pi9753Qxw4gzQy85CqejaGXZCMHJCynoUjWJtDO+qT75i9i6S0Er0HTW6xWcixvYTIQuT2QM+g8P0gaZIh0CCyIgCLVb2b/czmMgiRfI3N1HKQrVwGkHXSoLorTuwcyv40JCMutojzIYWxOOcKd9i9eTZuKWE5JPqG4MAUO/NJMTCj9ChBkQblITb7xdAto+9AWnISdd0HIHjf5Aclxx0fp2AagYqu7YC2WMguaLTI4osUXPJN1VMapc4h1lK3py03gaL937h8KZEIjUezVAsbJFoNHJ3S+/3ZUOUY8hNoL09P7YskD1S23IYVah3YyMwmdFiovblLdk33k4juk66UCuSYa5HoCvZOQoFJifSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(13003099007)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	71CiLjL/7m/z0uFB0NtWsco95O5BTBrVbUdP4Qt/Bt8EL7M/hJw9LRRgy64f4E1AQCW6SOKdRXxh9bKrE0qhuMWG6RvKO5huQ8PHqZMpGUclubNpKfapOP/XflC1/qbSpMjJvF46i9smjUHtAVI45qC+so4NEV5U/OHzIv6M1X/wEtAASlVGyf3+sP0s000Uj1KJeIx4xVCkb4QNADoN8oa8yguUnY5x/VG1pSbYWhL41sFFDHeqlcIPs8j210kivh1f0dCuyYo7EKgkeOKK0uXMc4/BbFPxG7SvXtHqIjrMp+Egy09e47PEM+zCMBf2sNsctlkX33CgEp9t3UFEfilgW4laGYRg3LinPBCPKHYfAcDI5H8yIdLQHM1iTA2isfiaAFiK5R1/lfgLoVeOlyyWwwwghn0ZGL1C/Sq9zZ/ONCZdz25jsGNeNmrPNRtC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 23:00:46.4983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c8f469-b358-4224-62f2-08deded713fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-306721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:horms@kernel.org,m:eric.joyner@amd.com,m:vadim.fedorenko@linux.dev,m:maxime.chevallier@bootlin.com,m:brett.creeley@amd.com,m:leitao@debian.org,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7867173FADA

When a driver's .get_fec_stats() handler is called and the driver
supports FEC histogram stats, the driver supplies the histogram bin
ranges via a pointer.  This pointer is assigned while under the netdev
ops lock in fec_prepare_data(), but the actual data is only read after
the lock is released; so this allows the driver to change the ranges
(e.g. from another .get_fec_stats() call) while the current call chain
is reading them in fec_fill_reply().

Fix this by embedding a buffer for the driver-supplied ranges in struct
ethtool_fec_hist instead of using a pointer; this ensures there's an
ethtool core-owned consistent copy that can be used after the netdev ops
lock is dropped and later in fec_fill_reply(). While some drivers like
bnxt use a constant struct for their ranges and won't be affected by
this issue, others like mlx5 (and eventually ionic) will use a
dynamically constructed range struct and could potentially run into an
issue.

Since the kernel API changed here, change the in-tree drivers that
report FEC histogram stats to copy their ranges instead of just
supplying a pointer.

Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---

This is a fix for the issue described by Jakub in:
https://lore.kernel.org/netdev/20260615182732.7d28e31a@kernel.org/

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  7 -------
 .../net/ethernet/mellanox/mlx5/core/en_stats.c    | 15 ++++++---------
 drivers/net/netdevsim/ethtool.c                   |  3 ++-
 include/linux/ethtool.h                           |  2 +-
 net/ethtool/fec.c                                 |  3 ++-
 7 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 62bc9cae613c..2e0ec8543f7f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3291,7 +3291,8 @@ static void bnxt_hwrm_port_phy_fdrstat(struct bnxt *bp,
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
 	if (!rc) {
-		hist->ranges = bnxt_fec_ranges;
+		memcpy(hist->ranges, bnxt_fec_ranges,
+		       ETHTOOL_FEC_HIST_MAX * sizeof(*hist->ranges));
 		for (i = 0; i <= 15; i++) {
 			__le64 sum = resp->accumulated_codewords_err_s[i];
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index d507289096c2..6867a5aed42c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -984,7 +984,6 @@ struct mlx5e_priv {
 	struct mlx5e_mqprio_rl    *mqprio_rl;
 	struct dentry             *dfs_root;
 	struct mlx5_devcom_comp_dev *devcom;
-	struct ethtool_fec_hist_range *fec_ranges;
 };
 
 static inline u16 mlx5e_stats_nch_read(const struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index aa8610cedaa8..8db235ac9ae4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6415,14 +6415,8 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 	if (!priv->channel_stats)
 		goto err_free_tx_rates;
 
-	priv->fec_ranges = kzalloc_objs(*priv->fec_ranges, ETHTOOL_FEC_HIST_MAX);
-	if (!priv->fec_ranges)
-		goto err_free_channel_stats;
-
 	return 0;
 
-err_free_channel_stats:
-	kfree(priv->channel_stats);
 err_free_tx_rates:
 	kfree(priv->tx_rates);
 err_free_txq2sq_stats:
@@ -6447,7 +6441,6 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	if (!priv->mdev)
 		return;
 
-	kfree(priv->fec_ranges);
 	for (i = 0; i < priv->stats_nch; i++)
 		kvfree(priv->channel_stats[i]);
 	kfree(priv->channel_stats);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index de38b60806c2..5f45e3c77cf1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1550,7 +1550,7 @@ static bool fec_rs_validate_hist_type(int mode, int hist_type)
 
 static u8
 fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
-			     const struct ethtool_fec_hist_range **ranges)
+			     struct ethtool_fec_hist_range *ranges)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 out[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
@@ -1558,8 +1558,6 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
 	int sz = MLX5_ST_SZ_BYTES(pphcr_reg);
 	u8 hist_type, num_of_bins;
 
-	memset(priv->fec_ranges, 0,
-	       ETHTOOL_FEC_HIST_MAX * sizeof(*priv->fec_ranges));
 	MLX5_SET(pphcr_reg, in, local_port, 1);
 	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPHCR, 0, 0))
 		return 0;
@@ -1575,12 +1573,11 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
 	for (int i = 0; i < num_of_bins; i++) {
 		void *bin_range = MLX5_ADDR_OF(pphcr_reg, out, bin_range[i]);
 
-		priv->fec_ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
-						    high_val);
-		priv->fec_ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
-						   low_val);
+		ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
+					  high_val);
+		ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
+					 low_val);
 	}
-	*ranges = priv->fec_ranges;
 
 	return num_of_bins;
 }
@@ -1622,7 +1619,7 @@ static void fec_set_histograms_stats(struct mlx5e_priv *priv, int mode,
 	case MLX5E_FEC_LLRS_272_257_1:
 	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
 		num_of_bins =
-			fec_rs_histogram_fill_ranges(priv, mode, &hist->ranges);
+			fec_rs_histogram_fill_ranges(priv, mode, hist->ranges);
 		if (num_of_bins)
 			return fec_rs_histogram_fill_stats(priv, num_of_bins,
 							   hist);
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 025ea79879f3..69849e4192d4 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -178,7 +178,8 @@ nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
 {
 	struct ethtool_fec_hist_value *values = hist->values;
 
-	hist->ranges = netdevsim_fec_ranges;
+	memcpy(hist->ranges, netdevsim_fec_ranges,
+	       ARRAY_SIZE(netdevsim_fec_ranges) * sizeof(*hist->ranges));
 
 	fec_stats->corrected_blocks.total = 123;
 	fec_stats->uncorrectable_blocks.total = 4;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5d491a98265e..d3bf1b2ddecc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -561,7 +561,7 @@ struct ethtool_fec_hist {
 		u64 sum;
 		u64 per_lane[ETHTOOL_MAX_LANES];
 	} values[ETHTOOL_FEC_HIST_MAX];
-	const struct ethtool_fec_hist_range *ranges;
+	struct ethtool_fec_hist_range ranges[ETHTOOL_FEC_HIST_MAX];
 };
 /**
  * struct ethtool_fec_stats - statistics for IEEE 802.3 FEC
diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
index e2d539271060..28373e16dd51 100644
--- a/net/ethtool/fec.c
+++ b/net/ethtool/fec.c
@@ -186,7 +186,8 @@ static int fec_put_hist(struct sk_buff *skb,
 	int i, j;
 	u64 sum;
 
-	if (!ranges)
+	if (values[0].sum == ETHTOOL_STAT_NOT_SET &&
+	    values[0].per_lane[0] == ETHTOOL_STAT_NOT_SET)
 		return 0;
 
 	for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
-- 
2.17.1


