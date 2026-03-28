Return-Path: <netdev+bounces-272755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFB8BKaXx2mFZgUAu9opvQ
	(envelope-from <netdev+bounces-272755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:56:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD4534DDF2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF35D301DB89
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A33314DE;
	Sat, 28 Mar 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="cw/PSUbN"
X-Original-To: netdev@vger.kernel.org
Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095E25487C;
	Sat, 28 Mar 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774688161; cv=none; b=cNb+QmYdqdqSlrD4Ro/fph4wfYIdVkBABVNGhqkUpeRftP9gD15P/3bOQLoE/uvONdSojX8aZcJMWq1HzA+tYzXViqiziubCakCoSmfLRMgcmPjBWwgfhFarkNBJxgWX08UdvFzyr0ja0Hq2JENdebLhlUZhFi3rDiadqOslNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774688161; c=relaxed/simple;
	bh=lmB9RkAsJOKKgD5XsOpXtoTGuYHWZeBiE4dI8gGBpmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ii3VkVhfarlJV+6Z80mYpwTrmN9UfMh/RLFWZt+65NrGzDbhMAMBxbdFVP8Qj89hNqmvspNTIOcE1PiLkGxJwlErBx4znzVIiHYq/8ZDeBPf2mxcbPtWJ7I29x/PtMdqJit7eyxPjpl8Qiof//7zKu0jLkPQyrhndT2ZPgVYm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=cw/PSUbN; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W9D8vCzCrRJ5LPPbiAlFNwBx1RgUj04xH732MSvsX1E=; b=cw/PSUbNcg/qV3aSySproi+46b
	W4YCBnfrBl1BwW4KsBBH2MU+F7BBr+tZt9Y2yRpuGWgva3tHHyVfLXwyh5aquGvXq1VwiafVvt6hi
	aiT66Pq0eHtSdMZz1fm+MgNFToKjNZkrgnQosP+xCFgbp/qOEwxkSeh63mSsUmpUNnXF5sye27KaR
	CBpKQSo80mC7QpIm15t913/z4BipHh/rzUdNYV0rERciL6UCmefkJQkdrXJAlaGWktL3IpOtOU+fz
	lWRHOV1woaQ2E9zC5FO++SeCUVB8o68Ott/DIUMu2dC+fyjRs/7QjsIPuH0sVYdRnppWDwqsrVkK/
	OwMxtMnA==;
Received: from user-5-173-16-20.play-internet.pl ([5.173.16.20] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1w6PSU-00000002znC-02RV;
	Sat, 28 Mar 2026 09:55:54 +0100
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sat, 28 Mar 2026 09:55:51 +0100
Subject: [PATCH v4] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-vlan-restore-error-v4-1-f88624c530dc@mmpsystems.pl>
X-B4-Tracking: v=1; b=H4sIAJaXx2kC/33NSwrCMBCA4atI1kaaZ6sr7yEuYjpjA32RlGApv
 btJV0WKy3+Y+WYhAbyDQG6nhXiILrihTyHPJ2Ib07+Bujo14QXXhWCSxtb01EOYBg8UvB88xeo
 lDLMlqsKQdDh6QPfZ0MczdePy9rz9iCxP/3KRUUYlWm0FcMYU3rtuDHOYoAuXsSWZjHzHcHbI8
 Mwoi0obxbmojxixZ6pDRiSmRlmaQlytRv3LrOv6BRYVpxFGAQAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774688151; l=3201;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=lmB9RkAsJOKKgD5XsOpXtoTGuYHWZeBiE4dI8gGBpmE=;
 b=k0d4LG2qW5S5JB0Fw6C5IlvnEM6iE36A+wAxwIDuP+cwTUSfPySgFjTY8DhZb7fP9denByW3G
 X1IW0pnaROsDzVv+iTBKmYEfIuVIHP+iXVC3oPv1jrAgIM5eUD2bwuS
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[mmpsystems.pl:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[mmpsystems.pl : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272755-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.770];
	FROM_NEQ_ENVFROM(0.00)[michal.piekos@mmpsystems.pl,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mmpsystems.pl:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CD4534DDF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
-EINVAL via stmmac_do_void_callback(), resulting in a spurious
"Failed to restore VLANs" error even when no VLAN filtering is in use.

Remove not needed comment.
Remove not used return value from stmmac_vlan_restore().

Tested on Orange Pi Zero 3.

Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
This patch fixes a noisy "Failed to restore VLANs" message on platforms
where stmmac VLAN hash ops are not implemented.
stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
VLAN hash ops presence which results in -EINVAL. 
---
Changes in v4:
- Remove not used return value of stmmac_vlan_restore()
- Link to v3: https://lore.kernel.org/r/20260328-vlan-restore-error-v3-1-df47a039c6f6@mmpsystems.pl

Changes in v3:
- Remove the offending comment
- Restore the original check for NETIF_F_VLAN_FEATURES
- Link to v2: https://lore.kernel.org/r/20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl

Changes in v2:
- Replace check for hash ops with check for HW FILTER flags
- Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6827c99bde8c..13d3cac056be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -156,7 +156,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue);
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan);
-static int stmmac_vlan_restore(struct stmmac_priv *priv);
+static void stmmac_vlan_restore(struct stmmac_priv *priv);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -6859,21 +6859,15 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	return ret;
 }
 
-static int stmmac_vlan_restore(struct stmmac_priv *priv)
+static void stmmac_vlan_restore(struct stmmac_priv *priv)
 {
-	int ret;
-
 	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
-		return 0;
+		return;
 
 	if (priv->hw->num_vlan)
 		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
 
-	ret = stmmac_vlan_update(priv, priv->num_double_vlans);
-	if (ret)
-		netdev_err(priv->dev, "Failed to restore VLANs\n");
-
-	return ret;
+	stmmac_vlan_update(priv, priv->num_double_vlans);
 }
 
 static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)

---
base-commit: be762d8b6dd7efacb61937d20f8475db8f207655
change-id: 20260314-vlan-restore-error-f8b3a1c7f50a

Best regards,
-- 
Michal Piekos <michal.piekos@mmpsystems.pl>


