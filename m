Return-Path: <netdev+bounces-272477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOOJC/xRxmk2IgUAu9opvQ
	(envelope-from <netdev+bounces-272477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:46:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1F341F5E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE45B303F052
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39F3DBD64;
	Fri, 27 Mar 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KdJrE2SA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC573DC4A2
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604414; cv=none; b=cDgrcxN5+hUZA7/TVfGIyoHML8ajUnbNr9Vm5S0CRaQ/l6/xihIEEQEI98D65T8YdcXTq9cdX8VRDW8/tze4HnabBbota78GG8OoK9YV8hi7ULv78oEKlgZZPbfbHnntHCSTQupNu45+h0pt11rwTiJLSDKUgIJo1F2+XiaXhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604414; c=relaxed/simple;
	bh=ARykOgF1ogLE3yb9zU7bL7htK7WT+Mj0HXFNCBzV548=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PbaTsQLGIpyyk6mSt8MT9CwyVIykiTgFGjyhALdKJIzqHdCt26xvt7ybeWNsPBDRiT1s7dzBvwLELf8MRdcXnoOX4WMiH/WHXfQuiF48E/PGNS3K8jKAwmGZFgC6UZa+Dn3yR/qr9yCH0hf6fSbuQFVRaxxINL4+kdDGYGY5ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KdJrE2SA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3LV1laEMu9jar4IK+tGUj5RMNZqQQYZz0sT0ngSImkk=; b=KdJrE2SA9LmUOn09s+tNDIfBRQ
	pVdF5mJYW8XQJYQkuekbBX4G2gCN48fhnH2FG2X7AjjruWSodx6ns/cOJfXDZQ4YeqQniSDA09CW8
	yx5nOf3t1ryqgjZFLgSZaLCY9mB9+8tVK2tKoOKV3VfV6Whusy9sP3ShBAaX4cT1mDykOsYJixPaW
	66XoGZHffwJUruml/p8iZTq2/OPSyqQ5BAdTa4uEMVxSkD91d9AJYFUiqD73oX7FZfvtqvunDt3Uj
	OYlqPttutYaSyCNmpLb0t++qlAjwMYEnNlPCc7dL4xGo7Kf5+lT292CfBx9qbFcOv8tIgv6r2z5CJ
	O947mlWA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45432 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w63fh-000000005xW-1qMH;
	Fri, 27 Mar 2026 09:40:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w63fg-0000000E3VV-2n9Q;
	Fri, 27 Mar 2026 09:40:04 +0000
In-Reply-To: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
References: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] net: stmmac: fix .ndo_fix_features()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w63fg-0000000E3VV-2n9Q@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Mar 2026 09:40:04 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272477-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AD1F341F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netdev features documentation requires that .ndo_fix_features() is
stateless: it shouldn't modify driver state. Yet, stmmac_fix_features()
does exactly that, changing whether GSO frames are processed by the
driver.

Move this code to stmmac_set_features() instead, which is the correct
place for it. We don't need to check whether TSO is supported; this
is already handled via the setup of netdev->hw_features, and we are
guaranteed that if netdev->hw_features indicates that a feature is
not supported, .ndo_set_features() won't be called with it set.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9b6b49331639..8203d6845b00 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6068,14 +6068,6 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
 		features &= ~NETIF_F_CSUM_MASK;
 
-	/* Disable tso if asked by ethtool */
-	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
-		if (features & NETIF_F_TSO)
-			priv->tso = true;
-		else
-			priv->tso = false;
-	}
-
 	return features;
 }
 
@@ -6102,6 +6094,8 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
+	priv->tso = !!(features & NETIF_F_TSO);
+
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;
 	else
-- 
2.47.3


