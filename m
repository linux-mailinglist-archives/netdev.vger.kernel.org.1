Return-Path: <netdev+bounces-263358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WISiK7Amp2k3fAAAu9opvQ
	(envelope-from <netdev+bounces-263358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:21:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A581F5374
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B86B313507E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F4347520;
	Tue,  3 Mar 2026 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8lTT7CM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4B30EF7E;
	Tue,  3 Mar 2026 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561757; cv=none; b=dQhxmZbrVOq02bKCk/Ss84PDLBQBkWzoc9x/dHZt3Zf05Fo/2/aqQW5jLpTbETlSjDJuUujLFCGQDZ+ZGCO8tmzlZaz1qsTgpVCbOEWRR3K1XrQG+cqGtMySbFCOIGbAZ08kTuBE7xhum2l3NQd+PJhBX1GVpQdqKwH1ENXBhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561757; c=relaxed/simple;
	bh=Jys+IUcjMRxDjzFvUBqJUe/6q09oMB+Hcs2zg/3Pm6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3RUFrWsMg4oh7VzE0H5SddeKZhxvOta5IYv8tduK2MLN+8pfiPWWQlMN+wBCG1v7VxYA6OgD3Usi4WNv/n8K6FSRUXbNVKhBEIJomrGSaAGz5YABX5CCipXLNRH8uVWEs2V0jC98lYpx9y3JYumzuzemFvIJpcBYjckEro6Wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8lTT7CM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F56C19425;
	Tue,  3 Mar 2026 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561757;
	bh=Jys+IUcjMRxDjzFvUBqJUe/6q09oMB+Hcs2zg/3Pm6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8lTT7CM+D7fqMiV7/NhTZKoblAb1sGupcOJhzbk+0XPz3hMt62aTIciYYBgsI7zF
	 ar+UAzg/kUZK/XPvmpTnozFtubHSHPwIAc87zdfkCciCqAoVpm162S3dCmBMI2NyNb
	 g0G/Nv4c2nueJb58gxqApLOq25uLBpASOhJAD+UpcAw+a3p4zHMqXtzYacphZqyQGM
	 dqBu+ItwE3cSqAnJ8fnkcR2f6z3TV9iIpiC+VtPUn9UBuaVBNF4kSV3hY9xhweWBFN
	 gzE3ioNmJGm9+I9BhaPqj0sOrt8kbeb6Imt+J7VAWgDgiSN4zCbhPfj9yZ1kRLwxfu
	 cTnvVo7xhOlPw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 3/5] netdevsim: Add RSS context support with dynamic table sizing
Date: Tue,  3 Mar 2026 19:15:31 +0100
Message-ID: <20260303181535.2671734-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181535.2671734-1-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 11A581F5374
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263358-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add RSS indirection table, hash key, and non-default RSS context
support to netdevsim. The create/modify/remove context callbacks are
no-ops; the core manages context state in its xarray.

The table size is dynamic: roundup_pow_of_two(channels) * 16, capped
at NSIM_RSS_INDIR_MAX (128). This mimics drivers like bnxt where the
table size changes with the queue count.

nsim_set_channels() uses the core resize helpers to fold/unfold tables
on channel count changes, exercising the full resize path.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/netdevsim/ethtool.c   | 119 +++++++++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |   4 +
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..c6d60b467054 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2020 Facebook
 
 #include <linux/debugfs.h>
+#include <linux/ethtool.h>
 #include <linux/random.h>
 #include <net/netdev_queues.h>
 
@@ -117,19 +118,121 @@ nsim_wake_queues(struct net_device *dev)
 	rcu_read_unlock();
 }
 
+static u32 nsim_get_rx_ring_count(struct net_device *dev)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	return ns->ethtool.channels;
+}
+
+static u32 nsim_rss_indir_size(u32 channels)
+{
+	return min_t(u32, roundup_pow_of_two(channels) * 16, NSIM_RSS_INDIR_MAX);
+}
+
+static u32 nsim_get_rxfh_indir_size(struct net_device *dev)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	return nsim_rss_indir_size(ns->ethtool.channels);
+}
+
+static u32 nsim_get_rxfh_key_size(struct net_device *dev)
+{
+	return NSIM_RSS_HKEY_SIZE;
+}
+
+static int nsim_get_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh)
+{
+	u32 indir_size = nsim_get_rxfh_indir_size(dev);
+	struct netdevsim *ns = netdev_priv(dev);
+
+	rxfh->hfunc = ETH_RSS_HASH_TOP;
+
+	if (rxfh->indir)
+		memcpy(rxfh->indir, ns->ethtool.rss_indir_tbl, indir_size * sizeof(u32));
+	if (rxfh->key)
+		memcpy(rxfh->key, ns->ethtool.rss_hkey, NSIM_RSS_HKEY_SIZE);
+
+	return 0;
+}
+
+static int nsim_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
+			 struct netlink_ext_ack *extack)
+{
+	u32 indir_size = nsim_get_rxfh_indir_size(dev);
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (rxfh->indir)
+		memcpy(ns->ethtool.rss_indir_tbl, rxfh->indir, indir_size * sizeof(u32));
+	if (rxfh->key)
+		memcpy(ns->ethtool.rss_hkey, rxfh->key, NSIM_RSS_HKEY_SIZE);
+
+	return 0;
+}
+
+static int nsim_create_rxfh_context(struct net_device *dev, struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_modify_rxfh_context(struct net_device *dev, struct ethtool_rxfh_context *ctx,
+				    const struct ethtool_rxfh_param *rxfh,
+				    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int nsim_remove_rxfh_context(struct net_device *dev, struct ethtool_rxfh_context *ctx,
+				    u32 rss_context, struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void nsim_rss_init(struct netdevsim *ns)
+{
+	u32 i, indir_size = nsim_rss_indir_size(ns->ethtool.channels);
+
+	for (i = 0; i < indir_size; i++)
+		ns->ethtool.rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, ns->ethtool.channels);
+}
+
 static int
 nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	u32 old_indir_size, new_indir_size;
 	int err;
 
-	err = netif_set_real_num_queues(dev, ch->combined_count,
-					ch->combined_count);
+	old_indir_size = nsim_get_rxfh_indir_size(dev);
+	new_indir_size = nsim_rss_indir_size(ch->combined_count);
+
+	if (old_indir_size != new_indir_size) {
+		if (netif_is_rxfh_configured(dev) &&
+		    ethtool_rxfh_indir_can_resize(ns->ethtool.rss_indir_tbl,
+						  old_indir_size, new_indir_size))
+			return -EINVAL;
+
+		err = ethtool_rxfh_contexts_resize_all(dev, new_indir_size);
+		if (err)
+			return err;
+
+		if (netif_is_rxfh_configured(dev))
+			ethtool_rxfh_indir_resize(ns->ethtool.rss_indir_tbl,
+						  old_indir_size, new_indir_size);
+	}
+
+	err = netif_set_real_num_queues(dev, ch->combined_count, ch->combined_count);
 	if (err)
 		return err;
 
 	ns->ethtool.channels = ch->combined_count;
 
+	if (old_indir_size != new_indir_size && !netif_is_rxfh_configured(dev))
+		nsim_rss_init(ns);
+
 	/* Only wake up queues if devices are linked */
 	if (rcu_access_pointer(ns->peer))
 		nsim_wake_queues(dev);
@@ -209,6 +312,7 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
+	.rxfh_indir_space		= NSIM_RSS_INDIR_MAX,
 	.get_pause_stats	        = nsim_get_pause_stats,
 	.get_pauseparam		        = nsim_get_pauseparam,
 	.set_pauseparam		        = nsim_set_pauseparam,
@@ -218,10 +322,18 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_ringparam			= nsim_set_ringparam,
 	.get_channels			= nsim_get_channels,
 	.set_channels			= nsim_set_channels,
+	.get_rx_ring_count		= nsim_get_rx_ring_count,
 	.get_fecparam			= nsim_get_fecparam,
 	.set_fecparam			= nsim_set_fecparam,
 	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
+	.get_rxfh_indir_size		= nsim_get_rxfh_indir_size,
+	.get_rxfh_key_size		= nsim_get_rxfh_key_size,
+	.get_rxfh			= nsim_get_rxfh,
+	.set_rxfh			= nsim_set_rxfh,
+	.create_rxfh_context		= nsim_create_rxfh_context,
+	.modify_rxfh_context		= nsim_modify_rxfh_context,
+	.remove_rxfh_context		= nsim_remove_rxfh_context,
 };
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
@@ -250,6 +362,9 @@ void nsim_ethtool_init(struct netdevsim *ns)
 
 	ns->ethtool.channels = ns->nsim_bus_dev->num_queues;
 
+	nsim_rss_init(ns);
+	get_random_bytes(ns->ethtool.rss_hkey, NSIM_RSS_HKEY_SIZE);
+
 	ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
 
 	debugfs_create_u32("get_err", 0600, ethtool, &ns->ethtool.get_err);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..3c6dd9a98deb 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -82,6 +82,8 @@ struct nsim_ethtool_pauseparam {
 	bool report_stats_tx;
 };
 
+#define NSIM_RSS_INDIR_MAX	128
+#define NSIM_RSS_HKEY_SIZE	40
 struct nsim_ethtool {
 	u32 get_err;
 	u32 set_err;
@@ -90,6 +92,8 @@ struct nsim_ethtool {
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
 	struct ethtool_fecparam fec;
+	u32 rss_indir_tbl[NSIM_RSS_INDIR_MAX];
+	u8 rss_hkey[NSIM_RSS_HKEY_SIZE];
 };
 
 struct nsim_rq {
-- 
2.53.0


