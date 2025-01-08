Return-Path: <netdev+bounces-156366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F422A062A5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D44167959
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAFF1FF1DC;
	Wed,  8 Jan 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v+FHQnl9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F291FFC7F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354964; cv=none; b=TdWyczkMIsjgoK6Fnb2BZt0+rmQThHh1mxNfQp/G3GOZKQe+q/rxjdKWlSPC5g2MZqR7T7kTFiY7Rf6PYqshknqU199dViQseteMaZqbqStGS+2F1iI68EzB+umI7O+1hUQNX4V/vuCojGrC8Mc8Pfx25ZgHRCXKOka0THTkjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354964; c=relaxed/simple;
	bh=6wqtdHOfXbChWcIH8GUqt9x5Guymy+RDP6z5pjSWCEM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oW0WDmJOnrRInuffaDhoh8gaNhC505zpy2PTgnZ2nx3TgAsPBFJDCA21buHRNi6Hkz1L0AW6P175jPbHGuQkGsOzPGGe5fpua58pZp8UigStxUrz+AW2vM41Bsvge0Jofet76bnrRGb90iwWZfqPZqO+ucLm4fcEO2/FGA8wTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v+FHQnl9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=++e+SDGClfcRyopadSBzqoMp8DLijqiGn3Srrs12xlo=; b=v+FHQnl9Wtbhw5yWW4uWiy+g+d
	f9Qxz4ZbJSIbuWmJJ81czZacO5Gr0CETG2vyREjCnrrW9RE+kb8JYfMeECPFLwy7v0emigc5pMiqw
	aCXIFl2Denk+6oNBOjEPB0VJP3hBn0nPutUQ8bgvF3NyVwIWf9pJnLdE/BIToIqoQwL9ONZQgjPZG
	WJv2N56ZbbHPX5SHgAhbo7Xf5ynkRiKaNGAangRGiqWapFILn02YNr9oKyRwQ4GomTsUt2mEQ+sYu
	jl2MYlDec2e5qgdxszOaAjjit4Piszp8TEuUKwrqzpfJV/TKOdbKQZxb9nno+6EILda3+3yAm/YUg
	0S7qLBOw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56706 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZF4-0000z4-2i;
	Wed, 08 Jan 2025 16:49:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZEl-0002LK-LA; Wed, 08 Jan 2025 16:48:55 +0000
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
Subject: [PATCH net-next v4 17/18] net: stmmac: split hardware LPI timer
 control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZEl-0002LK-LA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:48:55 +0000

Provide stmmac_disable_hw_lpi_timer() and stmmac_enable_hw_lpi_timer()
to control the hardware transmit LPI timer.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6d01dcafaf15..05fee963c1c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -390,14 +390,24 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 	return dirty;
 }
 
-static void stmmac_lpi_entry_timer_config(struct stmmac_priv *priv, bool en)
+static void stmmac_disable_hw_lpi_timer(struct stmmac_priv *priv)
+{
+	stmmac_set_eee_lpi_timer(priv, priv->hw, 0);
+}
+
+static void stmmac_enable_hw_lpi_timer(struct stmmac_priv *priv)
 {
-	u32 tx_lpi_timer;
+	stmmac_set_eee_lpi_timer(priv, priv->hw, priv->tx_lpi_timer);
+}
 
+static void stmmac_lpi_entry_timer_config(struct stmmac_priv *priv, bool en)
+{
 	/* Clear/set the SW EEE timer flag based on LPI ET enablement */
 	priv->eee_sw_timer_en = en ? 0 : 1;
-	tx_lpi_timer = en ? priv->tx_lpi_timer : 0;
-	stmmac_set_eee_lpi_timer(priv, priv->hw, tx_lpi_timer);
+	if (en)
+		stmmac_enable_hw_lpi_timer(priv);
+	else
+		stmmac_disable_hw_lpi_timer(priv);
 }
 
 /**
-- 
2.30.2


