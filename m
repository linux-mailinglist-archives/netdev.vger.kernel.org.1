Return-Path: <netdev+bounces-156361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22001A0629F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CEB167B4F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE31FECC1;
	Wed,  8 Jan 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="clpE6C01"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893A1FF1DB
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354953; cv=none; b=DuIylhn38a/S/dxmsgNiCn7rlSx2CskA44CeycpynkVv0mnx5BNyg21LsXKyBSxPLxcBv+VvYQvlLHBYbA/+MYcjgMxkbz3b1iNW0UmJZQC1ffKziOcSzL96vKVqabhAEO7TDOO0Jw8YvjSWwW7ng6W5XaoJQsNtzzLP3HCXTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354953; c=relaxed/simple;
	bh=fSLzNnUhJVq4m12WlxRoJ/Wbivbi+44MjHxD7ojy6RU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Us9qn7skWkHrGMP/A3KCHHzAmjVnbTe/aU2EyPf5FsKVNXDCQrvY/Yp0Dcbd0U/z2oOBEW5O1B8GZXgLIkQ1LxiKJ878mXzm9NMAInuYXl1orLT86IhM1VD0LkMSZilsUQ8m79njjhdrJjGno1BhcyYkK1qpJ9XO0bB42y59PgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=clpE6C01; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7qLLbaaYFisIspn/SUJF7U5WjZqj+c1h7oIc0JP/qVk=; b=clpE6C01hPneWqNs2huudpuNHk
	gQVnLguolncvySvzMVxCb+VPX/EnJkRwt6ZEayDTC2YeB1oAn26GEzLqaoYOAd9f+NnI8PhdgX6F6
	hewjyLkGFZCyY/SPh2cqn9ltxrihSgJr+Bhvf+Br5ZHoMqcXpRi1IhVIaCuQxkpAFFxf+tvVmhsV/
	WwN5dMJI2jkMD30/j0KRY0qm3RRyoRqv/ddRI1kHtDSxMddkxS9QB/LEfqEyu07Kr/21Kdg0lzgv+
	6NkbPRKSq0QuWPX+QDzPFARAOQ4oZ9aoptklYMikV9BJrFock6nRaBmtuxHF0HyY/luuj8wKk7il7
	9T93YpqQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46344 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZEn-0000xb-0F;
	Wed, 08 Jan 2025 16:48:57 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZER-0002Kv-5O; Wed, 08 Jan 2025 16:48:35 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v4 13/18] net: stmmac: move priv->eee_active into
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
Message-Id: <E1tVZER-0002Kv-5O@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:48:35 +0000

Since all call sites of stmmac_eee_init() assign priv->eee_active
immediately before, pass this state into stmmac_eee_init() and
assign priv->eee_active within this function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c492f14f56f..f2038dca8a02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -457,13 +457,16 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
 /**
  * stmmac_eee_init - init EEE
  * @priv: driver private structure
+ * @active: indicates whether EEE should be enabled.
  * Description:
  *  if the GMAC supports the EEE (from the HW cap reg) and the phy device
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
@@ -970,8 +973,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-	priv->eee_active = false;
-	stmmac_eee_init(priv);
+	stmmac_eee_init(priv, false);
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
@@ -1083,8 +1085,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
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


