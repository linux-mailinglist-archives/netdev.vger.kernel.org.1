Return-Path: <netdev+bounces-161368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D9A20D7E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2D63A7E8D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B41D5AD8;
	Tue, 28 Jan 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DUoJvcMN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7619DF61
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079262; cv=none; b=N7GaPbsIFtSpDuaJbV4cy29cgihSivN9exPjrvDdsgDodn5gSMUvk6ogRD8ycdggZcrGTcI14BP2glxFky7HRw/nPdPpi1iPoYqzQxvY1eB0FwXzaviOF4ovCiI8QufGDvxqBh+oC6y7bTepGf2dtsuGOTV6yYBaIK+uV/DvVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079262; c=relaxed/simple;
	bh=RdRPUWxHH2zg99KBNU5MMpU/DLZx/CwYivYJG0OSqiA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=THSPw3DwDIdH03sQATisSIaWQXJjaaLZO/5glhP1HDK/HcjblXuHesZ4bLRBtEkJiijcJRZa5PaFV5tp1jgt0ayYzE1vQYOS3ZIsCPVt5HVgSH2hPBBlUbnQ4TSNMgcIbDCHI9A922px5fLUJBu0rVlWcgiWeBZF1rzF0XpKCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DUoJvcMN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RdaJHDcetawhw7n/tKdXgSJrOfxgqAK1m9UgeH2faDY=; b=DUoJvcMNtYWYHhnUOG2+m3iGt+
	mh0kg9EQjZsMkN0tcXxx5jOE+j6mkcveB1SZXSIf6JsPVg10V5bNRMxXGwhqQZbsCqH+Gg70y9D55
	ogY9tG1X7hK5MJEq4qn1jyUb5P8EfJVreJugMzX2i2389hJaksgvxcmdy+VgpR8s/iTUEhWi24YYl
	ZGlp2FBeC9ByMclEpVkel4GTKeK34cYFSPiP8CmMpMssP92iAx/68KS1EDDhLZVYVConBlRoHv2UN
	VfpRqXRrwicQlrf7zFUEUMwIM5shpWuOV9BRfptBzfuxMKHJHFoTJUOC4PlzCvPv6+uQ/5e7B8MkX
	rxQg27dQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45790 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoM-0007UD-35;
	Tue, 28 Jan 2025 15:47:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcno3-0037Gc-Is; Tue, 28 Jan 2025 15:47:15 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 06/22] net: stmmac: remove unnecessary
 priv->eee_active tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcno3-0037Gc-Is@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:15 +0000

Since priv->eee_active is assigned with a constant value in each of
these methods, there is no need to test its value later. Remove these
unnecessary tests.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2cc75624a8c..f63946eb6747 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1047,21 +1047,17 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	mutex_lock(&priv->lock);
 
 	/* Check if it needs to be deactivated */
-	if (!priv->eee_active) {
-		if (priv->eee_enabled) {
-			netdev_dbg(priv->dev, "disable EEE\n");
-			priv->eee_sw_timer_en = false;
-			del_timer_sync(&priv->eee_ctrl_timer);
-			stmmac_reset_eee_mode(priv, priv->hw);
-			stmmac_set_eee_timer(priv, priv->hw, 0,
-					     STMMAC_DEFAULT_TWT_LS);
-			if (priv->hw->xpcs)
-				xpcs_config_eee(priv->hw->xpcs,
-						priv->plat->mult_fact_100ns,
-						false);
-		}
-		priv->eee_enabled = false;
+	if (priv->eee_enabled) {
+		netdev_dbg(priv->dev, "disable EEE\n");
+		priv->eee_sw_timer_en = false;
+		del_timer_sync(&priv->eee_ctrl_timer);
+		stmmac_reset_eee_mode(priv, priv->hw);
+		stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+		if (priv->hw->xpcs)
+			xpcs_config_eee(priv->hw->xpcs,
+					priv->plat->mult_fact_100ns, false);
 	}
+	priv->eee_enabled = false;
 	mutex_unlock(&priv->lock);
 }
 
@@ -1075,13 +1071,12 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	mutex_lock(&priv->lock);
 
-	if (priv->eee_active && !priv->eee_enabled) {
+	if (!priv->eee_enabled) {
 		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
 				     STMMAC_DEFAULT_TWT_LS);
 		if (priv->hw->xpcs)
 			xpcs_config_eee(priv->hw->xpcs,
-					priv->plat->mult_fact_100ns,
-					true);
+					priv->plat->mult_fact_100ns, true);
 	}
 
 	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
-- 
2.30.2


