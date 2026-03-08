Return-Path: <netdev+bounces-265301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA7jGhh2rWkC3QEAu9opvQ
	(envelope-from <netdev+bounces-265301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:14:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27F223059B
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE76303AF31
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACFB3806A5;
	Sun,  8 Mar 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWIYuY0K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747536212B;
	Sun,  8 Mar 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975551; cv=none; b=snsWUMyeZClXWSLjhOwk+9f9fPvmzQGt59o96rOt0cdL6CiqNQAYQKMCh6a4dwWT09BcSzm1HWzvRgyDL95FLU6Rge5M/FxBwTDcpctoj3Eky4Y7b+Z86Pt9VVe5apBXnCTkd4Zwd7NGpBGgXeStwAq0zfzjtw8YYI4I5Zc6P4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975551; c=relaxed/simple;
	bh=tUMIy6Rh0xANH3/H5q6ZWePe3fnfyPGevW5WgIJCTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7YF8JSWkmq81RmA4zobYChCDtoQ7yX2o85e8z/65UuVpxu/psQ2A4Qzgt/tG5LYeEGdNW3RtxFl7G+hYPOXZifuvAJHe6gCWeFhKygcPvfUAxT4xW+nxPwxtenP6mAReJGN07y5dO+BP3nBrx9NRqhFK+loGIWEfXRCnVB9Gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWIYuY0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FF8C19423;
	Sun,  8 Mar 2026 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772975551;
	bh=tUMIy6Rh0xANH3/H5q6ZWePe3fnfyPGevW5WgIJCTWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWIYuY0KMxr7kEfxNc028Xk7Y82YN3hnFZljeF3MJ3mMkcXJdpR2M10er9mg7Jclz
	 jcHQ/8KfluS1uvuKnXnNY7w4RpQc1HZsxqwSiHbOZR3LeYflAOswaV+bQ/uTc169Kc
	 iLP3TdWDgRgwgbXiiJQezGqIfpGtd9QgBVjvr4Tqxk84t1ag5TKXYm3ymP6Il7tyLl
	 Ot/A422zNHMhg/9eLNMC+GjlM+tnqXPB6f8elzTtNhQispgCDklSHVHcxHpXzCjfqk
	 P8qbclZSDoNTsQ1moZVT0de75h9DydKbb3h07Z+1VOwAcToJ0KVA6NCZhzlIMkj1+X
	 kQ83G/MyoYXQw==
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
Subject: [PATCH net-next v3 2/3] bnxt_en: Resize RSS contexts on channel count change
Date: Sun,  8 Mar 2026 14:12:16 +0100
Message-ID: <20260308131218.3172332-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308131218.3172332-1-bjorn@kernel.org>
References: <20260308131218.3172332-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C27F223059B
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
	TAGGED_FROM(0.00)[bounces-265301-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

bnxt_set_channels() rejects channel changes that alter the RSS table
size when IFF_RXFH_CONFIGURED is set, because non-default context
sizes were locked at creation.

Replace the rejection with the new resize helpers. All validation runs
before the device is closed; actual resize is deferred until after
bnxt_close_nic():

 1. ethtool_rxfh_can_resize() checks context 0.
 2. ethtool_rxfh_ctxs_can_resize() validates all non-default contexts.
 3. After bnxt_close_nic(), ethtool_rxfh_resize() applies context 0
    changes, and ethtool_rxfh_ctxs_resize() resizes non-default
    contexts.

RSS table size only changes on P5 chips with older firmware; newer
firmware always uses the largest table size.

When context 0 uses defaults (!IFF_RXFH_CONFIGURED), steps 1 and 3 are
skipped; the driver regenerates the table via
bnxt_set_dflt_rss_indir_tbl().

Tested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 26fcd52c8a61..dc3eb24c9c0b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -942,6 +942,7 @@ static int bnxt_set_channels(struct net_device *dev,
 {
 	struct bnxt *bp = netdev_priv(dev);
 	int req_tx_rings, req_rx_rings, tcs;
+	u32 new_tbl_size = 0, old_tbl_size;
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
@@ -977,19 +978,33 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
-	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
-	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
-	    netif_is_rxfh_configured(dev)) {
-		netdev_warn(dev, "RSS table size change required, RSS table entries must be default to proceed\n");
-		return -EINVAL;
-	}
-
 	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
 	if (rc) {
 		netdev_warn(dev, "Unable to allocate the requested rings\n");
 		return rc;
 	}
 
+	/* RSS table size only changes on P5 chips with older firmware;
+	 * newer firmware always uses the largest table size.
+	 */
+	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
+	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings)) {
+		new_tbl_size = bnxt_get_nr_rss_ctxs(bp, req_rx_rings) *
+			       BNXT_RSS_TABLE_ENTRIES_P5;
+		old_tbl_size = bnxt_get_rxfh_indir_size(dev);
+
+		if (netif_is_rxfh_configured(dev) &&
+		    !ethtool_rxfh_can_resize(bp->rss_indir_tbl,
+					     old_tbl_size, new_tbl_size)) {
+			netdev_warn(dev, "RSS table resize not possible\n");
+			return -EINVAL;
+		}
+
+		rc = ethtool_rxfh_ctxs_can_resize(dev, new_tbl_size);
+		if (rc)
+			return rc;
+	}
+
 	if (netif_running(dev)) {
 		if (BNXT_PF(bp)) {
 			/* TODO CHIMP_FW: Send message to all VF's
@@ -999,6 +1014,13 @@ static int bnxt_set_channels(struct net_device *dev,
 		bnxt_close_nic(bp, true, false);
 	}
 
+	if (new_tbl_size) {
+		if (netif_is_rxfh_configured(dev))
+			ethtool_rxfh_resize(bp->rss_indir_tbl,
+					    old_tbl_size, new_tbl_size);
+		ethtool_rxfh_ctxs_resize(dev, new_tbl_size);
+	}
+
 	if (sh) {
 		bp->flags |= BNXT_FLAG_SHARED_RINGS;
 		bp->rx_nr_rings = channel->combined_count;
-- 
2.53.0


