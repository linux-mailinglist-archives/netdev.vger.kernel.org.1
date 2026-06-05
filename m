Return-Path: <netdev+bounces-295493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yKY1K8EYImrPSQEAu9opvQ
	(envelope-from <netdev+bounces-295493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA96441E7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OIE8UR4W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295493-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295493-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 456BD30602B5
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6512153EA;
	Fri,  5 Jun 2026 00:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786324466C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619382; cv=none; b=MuPlaqTWyFhcAamjLjfPSLyhSf7PqPNmQyfy/2hf1Sm6h4dksLg1rpqAbsCs00MQs4heTFR9IvLaG1Bmdc6bxPTqN6+9zEVbFV3kL5OpM7WLT2euRYM8IO/sP2K7dqdDX1PLVfc2PsWWRFWf3aKDACF3dEXfG9Ki1XewabivYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619382; c=relaxed/simple;
	bh=06MOT3LN/EUUzEVUVMr4YbSbZIZ/l8QjLuAmnYYy8dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhM0mA+U/YSTD6kGbl3R1/b+QFzweBOw9AEMkdmDiQ1GlfZ1UseaCORHm8PA6yaecjLaB6zIHNzirYJxcVCZjSh6YXJF9gPr31actvtziI4Zb9jK4Rc4ROHAOic/o2eWxJEvcOWquXlCoBJhqPE0avQ4wYNmGEICEwHq3RTGzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIE8UR4W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99AE1F00893;
	Fri,  5 Jun 2026 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619380;
	bh=fIXTG9lBX9li9Zpe2fiNJvh+o9tNfH0O0sHmsUVP4kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIE8UR4WeNOv/52kig5yM8zk58Og1CRss09pk1TXTlee1pejYiWSiUzJRWCtTvaBj
	 dIuzkbqCWG4+11wq49qOBxdOM4IFRV5cd45ibk+sw+SPrzim+/G1F4x9tvMcXHEed+
	 ONYlfwSSZWRXmcFi0dCXlcGIXduVvRDa2QM9R04um8cqi3MB4BajQGW2Wa1gu4o7Eo
	 LqWT1rLiwL0QCWzbWtPwJyBt8cPOvpV8KhBeGA+b/r+v6H1asrTb2/Tn0CpIJCCOMs
	 LvNgt6fRuCH3AyFz297Mta9KhNKAjqHeYhjW+nhCn3oiu/AZ2AjhmrXcYpBENewabG
	 pWLgYU92LuCWg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/12] net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
Date: Thu,  4 Jun 2026 17:29:05 -0700
Message-ID: <20260605002912.3456868-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295493-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ECA96441E7

Make ethtool not take rtnl_lock for SET commands when operation
is performed on an ops-locked driver. cfg/cfg_pending are now
ops-locked, since only ethtool modifies them.

Some SET driver callbacks will still need rtnl_lock, most notably
those which may end up calling netdev_update_features() or the qdisc
layer (via netif_set_real_num_tx_queues()). Let drivers selectively
opt back into the rtnl_lock with a new bitfield in ops.

We need two helpers since Netlink and ioctl cmds have different
values. Keep the helpers side by side in common.h to make sure
they get updated together, even tho they will only get called
from ioctl.c and netlink.c.

SET commands which don't use ethnl_default_set_doit() are converted
by subsequent commits.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h                       | 10 ++++++-
 include/linux/netdevice.h                     |  2 +-
 net/ethtool/common.h                          | 30 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  2 ++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  3 ++
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 ++
 .../mellanox/mlx5/core/ipoib/ethtool.c        |  2 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  5 +++-
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 ++
 drivers/net/netdevsim/ethtool.c               |  1 +
 net/ethtool/netlink.c                         |  9 ++++--
 12 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1da49161d36f..74c8109b0cf3 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -935,7 +935,13 @@ struct kernel_ethtool_ts_info {
  * these bits separate, per GET and SET. GET is much easier to "unlock".
  */
 #define ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS	BIT(0)
-#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(1)
+#define ETHTOOL_OP_NEEDS_RTNL_SPFLAGS		BIT(1)
+#define ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM	BIT(2)
+#define ETHTOOL_OP_NEEDS_RTNL_SCHANNELS		BIT(3)
+#define ETHTOOL_OP_NEEDS_RTNL_SCOALESCE		BIT(4)
+#define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(5)
+#define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
+#define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)
 
 /**
  * struct ethtool_ops - optional netdev operations
@@ -970,6 +976,8 @@ struct kernel_ethtool_ts_info {
  *	The following commonly used core APIs currently require rtnl_lock
  *	(this list may not be exhaustive):
  *	 - phylink helpers (note that phydev is currently unsupported!)
+ *	 - netdev_update_features()
+ *	 - netif_set_real_num_tx_queues()
  *
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a8709d0cc8d4..403b6d1c67f8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2584,7 +2584,7 @@ struct net_device {
 	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
 	 * Ops protects:
-	 *	@hwprov
+	 *	@cfg, @cfg_pending, @hwprov
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 391c41ca56be..e3052972f953 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -95,10 +95,24 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
 
 	switch (cmd) {
 	case ETHTOOL_MSG_LINKINFO_GET:
+	case ETHTOOL_MSG_LINKINFO_SET:
 	case ETHTOOL_MSG_LINKMODES_GET:
+	case ETHTOOL_MSG_LINKMODES_SET:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS;
+	case ETHTOOL_MSG_PRIVFLAGS_SET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPFLAGS;
+	case ETHTOOL_MSG_RINGS_SET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM;
+	case ETHTOOL_MSG_CHANNELS_SET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SCHANNELS;
+	case ETHTOOL_MSG_COALESCE_SET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SCOALESCE;
 	case ETHTOOL_MSG_PAUSE_GET:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM;
+	case ETHTOOL_MSG_PAUSE_SET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM;
+	case ETHTOOL_MSG_RSS_SET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
 	}
 	return false;
 }
@@ -119,9 +133,25 @@ ethtool_ioctl_needs_rtnl(const struct net_device *dev, u32 ethcmd)
 	switch (ethcmd) {
 	case ETHTOOL_GLINKSETTINGS:
 	case ETHTOOL_GSET:
+	case ETHTOOL_SLINKSETTINGS:
+	case ETHTOOL_SSET:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS;
+	case ETHTOOL_SPFLAGS:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPFLAGS;
+	case ETHTOOL_SRINGPARAM:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM;
+	case ETHTOOL_SCHANNELS:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SCHANNELS;
+	case ETHTOOL_SCOALESCE:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SCOALESCE;
 	case ETHTOOL_GPAUSEPARAM:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM;
+	case ETHTOOL_SPAUSEPARAM:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM;
+	case ETHTOOL_SRSSH:
+	case ETHTOOL_SRXFH:
+	case ETHTOOL_SRXFHINDIR:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
 	}
 	return false;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index edafa79f636c..56d74a3c24b7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5729,6 +5729,10 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.rxfh_max_num_contexts		= BNXT_MAX_ETH_RSS_CTX + 1,
 	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
 	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
+	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+					  ETHTOOL_OP_NEEDS_RTNL_SCOALESCE |
+					  ETHTOOL_OP_NEEDS_RTNL_RSS,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 7cd43e082b2a..7cc22916852f 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -983,6 +983,8 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 				 ETHTOOL_RING_USE_RX_BUF_LEN,
+	.op_needs_rtnl = ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+			 ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
 	.get_drvinfo = gve_get_drvinfo,
 	.get_strings = gve_get_strings,
 	.get_sset_count = gve_get_sset_count,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 61993485e451..2f5b626ba33f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2719,6 +2719,9 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.rxfh_per_ctx_fields	= true,
 	.rxfh_per_ctx_key	= true,
 	.rxfh_max_num_contexts	= MLX5E_MAX_NUM_RSS,
+	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+				  ETHTOOL_OP_NEEDS_RTNL_SPFLAGS,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index ba6c0f38cc73..1a8a19f980d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -418,6 +418,8 @@ static const struct ethtool_ops mlx5e_rep_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
+	.op_needs_rtnl	   = ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+			     ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
 	.get_drvinfo	   = mlx5e_rep_get_drvinfo,
 	.get_link	   = ethtool_op_get_link,
 	.get_strings       = mlx5e_rep_get_strings,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 3b2f54ca30a8..9b3b32408c64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -285,6 +285,8 @@ const struct ethtool_ops mlx5i_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
+	.op_needs_rtnl	    = ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+			      ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
 	.get_drvinfo        = mlx5i_get_drvinfo,
 	.get_strings        = mlx5i_get_strings,
 	.get_sset_count     = mlx5i_get_sset_count,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index a2c16d599389..cb34fc166ef9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2021,7 +2021,10 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 					  ETHTOOL_RING_USE_HDS_THRS,
 	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
 	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS |
-					  ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM,
+					  ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM |
+					  ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM |
+					  ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 04350973e19e..55df44d728a0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -575,6 +575,8 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 
 const struct ethtool_ops mana_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
+	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
+				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..9350ba48eb81 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -209,6 +209,7 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
+	.op_needs_rtnl			= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS,
 	.get_pause_stats	        = nsim_get_pause_stats,
 	.get_pauseparam		        = nsim_get_pauseparam,
 	.set_pauseparam		        = nsim_set_pauseparam,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 2c30eb1f4666..1af395b54330 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -903,6 +903,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const u8 cmd = info->genlhdr->cmd;
 	struct ethnl_req_info *req_info;
 	struct net_device *dev;
+	bool need_rtnl;
 	int ret;
 
 	ops = ethnl_default_requests[cmd];
@@ -927,8 +928,11 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev = req_info->dev;
+	need_rtnl = !netdev_need_ops_lock(dev) ||
+		    ethtool_nl_msg_needs_rtnl(dev, cmd);
 
-	rtnl_lock();
+	if (need_rtnl)
+		rtnl_lock();
 	netdev_lock_ops(dev);
 	dev->cfg_pending = kmemdup(dev->cfg, sizeof(*dev->cfg),
 				   GFP_KERNEL_ACCOUNT);
@@ -958,7 +962,8 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 out_tie_cfg:
 	dev->cfg_pending = dev->cfg;
 	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	if (need_rtnl)
+		rtnl_unlock();
 out_dev:
 	ethnl_parse_header_dev_put(req_info);
 out_free_req:
-- 
2.54.0


