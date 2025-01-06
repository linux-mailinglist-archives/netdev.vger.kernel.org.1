Return-Path: <netdev+bounces-155449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F2A02562
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8846D3A5CD8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232571DDC2D;
	Mon,  6 Jan 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xOE5YbHs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904E1DE2CE
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166382; cv=none; b=IxUQBTBi9e+cYcD3EfqYs91nUszFU2FpyQvnouu/Io8bzK0LQeIDciwutZw7iBNcQBIKqP6nsGhVgkTxmuFW7UkMa7BhMh4wDHqUJH1wKizIULqcvX42Jz0SuZ7taX64nPI39DyPact3eDxJS2q51qSzinX+4szTm3zKtcNteg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166382; c=relaxed/simple;
	bh=TwtTddOxTAnhSI4Cz9RO3L6HWoQrDfbCBTWaQUmRx7s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DT+HEk/6AB3ev3nMydTXLBf0tbeasET5vd2dueMELmxxNU74sFV3j6B/cJ4uiDQs6PkR/0XntUU95TosyQU6fd7jKNO9GuuVbhtQzYFv1NO7IEuQhPuqdQ4Pg6xbe+raNdh+sBp5KY/FFlofieGKuPpu7kA02a2l7Lbb37I6DQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xOE5YbHs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ni5k9SbRbh4aJd4zhQ7wbF1lNatzNxra2mHNYT7FdTA=; b=xOE5YbHsS3Oy0sIQfo4sieODs2
	taCC4EUr75Ivxs6qYatENyVYC0FEk5Nup53/XeVa1C8mrFuMthg5gba1xDwxx0CXzWjcReJGyczW6
	zvoqCin23cbupEFdJR8/5pgx8w1KrcNaoMkk2xlfWXp2QgPttrf5tKGNvG+nCZqRGeo/sDaSnwzXG
	OSVwO5J06mJT5OubNk3PCsCJQTUg/iycZmFCsSG36pLt9enLUNbrTJPEwDbFlTiGZY2jdTQ53Q0uS
	VOq/92LNU92OBkPnVXhXrM6/w+38Ho5DnkX8pvUnMTBEGEBLygYVtBQy7ZHgEV+LMpTGYAKolJ6Rl
	Q0qJVhuw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48134 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmBR-0005uk-1w;
	Mon, 06 Jan 2025 12:26:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmBO-007VYH-Kj; Mon, 06 Jan 2025 12:26:10 +0000
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
Subject: [PATCH net-next v2 17/17] net: stmmac: remove
 stmmac_lpi_entry_timer_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmBO-007VYH-Kj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:26:10 +0000

Remove stmmac_lpi_entry_timer_config(), setting priv->eee_sw_timer_en
at the original call sites, and calling the appropriate
stmmac_xxx_hw_lpi_timer() function. No functional change.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8d4b9c42aac0..3b600967cb65 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -402,16 +402,6 @@ static void stmmac_enable_hw_lpi_timer(struct stmmac_priv *priv)
 	stmmac_set_eee_lpi_timer(priv, priv->hw, priv->tx_lpi_timer);
 }
 
-static void stmmac_lpi_entry_timer_config(struct stmmac_priv *priv, bool en)
-{
-	/* Clear/set the SW EEE timer flag based on LPI ET enablement */
-	priv->eee_sw_timer_en = en ? 0 : 1;
-	if (en)
-		stmmac_enable_hw_lpi_timer(priv);
-	else
-		stmmac_disable_hw_lpi_timer(priv);
-}
-
 /**
  * stmmac_enable_eee_mode - check and enter in LPI mode
  * @priv: driver private structure
@@ -490,7 +480,8 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 	if (!priv->eee_active) {
 		if (priv->eee_enabled) {
 			netdev_dbg(priv->dev, "disable EEE\n");
-			stmmac_lpi_entry_timer_config(priv, 0);
+			priv->eee_sw_timer_en = true;
+			stmmac_disable_hw_lpi_timer(priv);
 			del_timer_sync(&priv->eee_ctrl_timer);
 			stmmac_set_eee_timer(priv, priv->hw, 0,
 					     STMMAC_DEFAULT_TWT_LS);
@@ -514,11 +505,15 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 	}
 
 	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
+		/* Use hardware LPI mode */
 		del_timer_sync(&priv->eee_ctrl_timer);
 		priv->tx_path_in_lpi_mode = false;
-		stmmac_lpi_entry_timer_config(priv, 1);
+		priv->eee_sw_timer_en = false;
+		stmmac_enable_hw_lpi_timer(priv);
 	} else {
-		stmmac_lpi_entry_timer_config(priv, 0);
+		/* Use software LPI mode */
+		priv->eee_sw_timer_en = true;
+		stmmac_disable_hw_lpi_timer(priv);
 		mod_timer(&priv->eee_ctrl_timer,
 			  STMMAC_LPI_T(priv->tx_lpi_timer));
 	}
-- 
2.30.2


