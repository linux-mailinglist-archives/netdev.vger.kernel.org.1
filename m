Return-Path: <netdev+bounces-155438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE8A0254B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C986162C79
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355C1DDA00;
	Mon,  6 Jan 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HPCvXjvL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B901DDA10
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166326; cv=none; b=L7JAIFU4JSG4YuX/Uh6NL69qvvMwNX/Ll4Fie4eByRR3rbs10LNTDR2KvIKO2DZ6wbWaa/CsOmHxCjq4PIjypIe5xg6EbolIRsbc7e2zDG0shtaYHpq+Tn2HBaHtgwMMPQAQ/vMJqyJSOiZxz16fGIN16hXLpFBEbB4alMUxJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166326; c=relaxed/simple;
	bh=KIk5aABLTKluoaZpZSjWp3vhzq8XCaBN4qMld3k47EA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ElbZwU8yOEIevLWDiSNtf5nzJ6QVWSW/W8DaBgPPp3n5aX0Sft7bVijePEfdV1ZCJuzDsQi5LgXRJYulxMjHTWH1uGWec09IQx69xgrfZ96U7CMNwSTckdzSKCEDKFh960YWff+fS+Qczk37MmUXqYDSl1ZqC62B1ppZFegK2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HPCvXjvL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iv3o0tQi4mVCZMUEX+EXxrZSrKEvf9ort8xPFeup/9E=; b=HPCvXjvLIYux4i2OdJkQRn7z6R
	oJ26BVHgPVWjocxdKwiWvfBfkRwSM+x2LSHwSztmG1zw67j98C7UAVWFHgybOaMAjQDNaaQmrmXco
	s2rY5V+CS6zr1EnDJcJnh1Jksbg7Irr/UrG7Aobe8ny+WkuxrotIwCkuTOM5fEQ3iDZqjjGsvsLxy
	MPLPPqht7kkgFnw9jIMlf+f6SjkatFX2Qw3fGT2roupS+G9ncLVRvyfD69xOejlOvmUMJk1gRw6o4
	ErzhJGsqoRWoB6K0PnM5PpF+T2KvWKiSP5Rj87NTEyDW3tJ7YpaLvEQvhwrQQ307wy+15/54QmJ+5
	DyjhsNng==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55610 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmAX-0005re-12;
	Mon, 06 Jan 2025 12:25:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAU-007VXD-A4; Mon, 06 Jan 2025 12:25:14 +0000
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
Subject: [PATCH net-next v2 06/17] net: stmmac: clean up
 stmmac_disable_eee_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAU-007VXD-A4@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:14 +0000

stmmac_disable_eee_mode() is now only called from stmmac_xmit() when
both priv->tx_path_in_lpi_mode and priv->eee_sw_timer_en are true.
Therefore:

	if (!priv->eee_sw_timer_en)

in stmmac_disable_eee_mode() will never be true, so this is dead code.
Remove it, and rename the function to indicate that it now only deals
with software based EEE mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f895bdd75678..47c57a558e5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -429,18 +429,13 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 }
 
 /**
- * stmmac_disable_eee_mode - disable and exit from LPI mode
+ * stmmac_disable_sw_eee_mode - disable and exit from LPI mode
  * @priv: driver private structure
  * Description: this function is to exit and disable EEE in case of
  * LPI state is true. This is called by the xmit.
  */
-static void stmmac_disable_eee_mode(struct stmmac_priv *priv)
+static void stmmac_disable_sw_eee_mode(struct stmmac_priv *priv)
 {
-	if (!priv->eee_sw_timer_en) {
-		stmmac_lpi_entry_timer_config(priv, 0);
-		return;
-	}
-
 	stmmac_reset_eee_mode(priv, priv->hw);
 	del_timer_sync(&priv->eee_ctrl_timer);
 	priv->tx_path_in_lpi_mode = false;
@@ -4490,7 +4485,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	first_tx = tx_q->cur_tx;
 
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
-		stmmac_disable_eee_mode(priv);
+		stmmac_disable_sw_eee_mode(priv);
 
 	/* Manage oversized TCP frames for GMAC4 device */
 	if (skb_is_gso(skb) && priv->tso) {
-- 
2.30.2


