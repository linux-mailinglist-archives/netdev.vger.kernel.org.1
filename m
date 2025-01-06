Return-Path: <netdev+bounces-155444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538DA0255E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BB818866FB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7631DDA1E;
	Mon,  6 Jan 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gZXTgFin"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC691DDC12
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166358; cv=none; b=b7KSjyQEyPm5Jqd8slPIbUMZzimScFX6NKaqSL7Ys2byCAKBkAufZqx4JkJ+3RCj0ngHiVfYRgz5rs04DGOhPcuKIiRD1PafpMfzcHW/Yxf7VHK44+PtHSDUgSGMu7XSNjGbzB1e6bxvhvODnNpju53zQLSwAOxotOmeAuEut5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166358; c=relaxed/simple;
	bh=fczQZll3/MovbDU9Zd37T2alkJlpe1aiEvmXL/zQKqg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=a/BG1q+cWwKa1T7h668LS+KtxF0hiFUX6rtP8gZ2yWzKLy4/u38n2YnWJZceirKXt4DHUXgo5or6Mt8YsThDgS8We2XS44iKLkBZugRLT3P+BpIdyI1+HXZbWoj1MTf1VbzzmcU4At4Os855peUWJ3sPnbKA59yxVsUZ1x8i+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gZXTgFin; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eKXXjy/uKptM2YnzYmRo9ocTbTaqXsBTlP/WP9Ye8Nk=; b=gZXTgFinuKQ/y5exjaBo1n5QZR
	KKT0eQ5c4HsCxovqCEVXOaR2vgbCupl2WwaCyELwYEQ5uQ3TlC16RkzgU6NJ2gB5jI3Es+yP847d1
	DtmS9nsJV6cHh5m7oYt+8IYZxS69XvtR8qmFsRdKbd8jK1JkAuo0HUk2mTU+EnQeXPB2c/4LNA5w9
	EtTlh35fP7uysjN+6CWEWNOmUDkYbEZaEDOcb9GjQ80Kum4XGzYK0hetIifUilrUu+/wGav+HZwGW
	0UpRnb+QKRHd6WavF8osljEfGvY5JAekLjzo7Joj7mZt4qlKgd34XSbWo4AMVQ4j4dpM6oJum8eY1
	IyQxgGVQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37426 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmB1-0005tL-3D;
	Mon, 06 Jan 2025 12:25:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAz-007VXn-0o; Mon, 06 Jan 2025 12:25:45 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 12/17] net: stmmac: move priv->eee_active into
 stmmac_eee_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAz-007VXn-0o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:45 +0000

Since all call sites of stmmac_eee_init() assign priv->eee_active
immediately before, pass this state into stmmac_eee_init() and
assign priv->eee_active within this function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cf294fe3f726..1aedb49944ec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -464,8 +464,10 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
  *  can also manage EEE, this function enable the LPI state and start related
  *  timer.
  */
-static void stmmac_eee_init(struct stmmac_priv *priv)
+static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 {
+	priv->eee_active = active;
+
 	/* Check if MAC core supports the EEE feature. */
 	if (!priv->dma_cap.eee) {
 		priv->eee_enabled = false;
@@ -972,8 +974,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-	priv->eee_active = false;
-	stmmac_eee_init(priv);
+	stmmac_eee_init(priv, false);
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
@@ -1085,8 +1086,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
 					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-		priv->eee_active = phy->enable_tx_lpi;
-		stmmac_eee_init(priv);
+		stmmac_eee_init(priv, phy->enable_tx_lpi);
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
 
-- 
2.30.2


