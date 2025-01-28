Return-Path: <netdev+bounces-161367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8620A20D79
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE261882AD0
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C51D61A4;
	Tue, 28 Jan 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iKwRr8Re"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B21D61A1
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079258; cv=none; b=ldyDylfIil/4ja5pX5fntRyFIjVv1oX77snvQHLmSjpk0jA64XB8RSsSLGOG8uqAgSzuynvxRJ2z/Q3ieoUR4pUren/3ovF4QCfFr/f9IlfYE7Ss9MQ9sODuCQStSVsMQhW1X+ebRYTzaAG7E4TghAkhgQnA1g/mPKymmij6Dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079258; c=relaxed/simple;
	bh=7ZK2S3ewWJ/OUzkcElUw2MiHCaOSP8r/ZslkIY3Lk3M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=UfqK2BLkBQjZ+Qkrar9EHQIVNYuJiHyyGRp+9Ly+9e6R6fYG+k5iuM+LWS/jeSbCJwmdYfBcwBzbMCah9VTYvJRvzTgNwZRdqN/j8WKGb0GlhHYC4goNg5icsxdxQJjA6/3/kbvc+d4ywiq+LPev5d8r9kvGM3/+MpxZkilmVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iKwRr8Re; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3YIoH6VA55wVjjgJMjTs7y6r79V9JBvos9FiOPbICR8=; b=iKwRr8ReVs813x0XopkdelSqpD
	cwTu6G2N8BuZZu/v+XLIo1QH1UQho1+KfxKaOzqk1In3rfYsJi7egcVXPf/0OA+Ub74PG0uxfnKYp
	1SOeQGzjQlNiandPGVWe/3fsVw+UJJGNMeSThfhXtSlvXSqxTQheUeGPWEdkLLmLxFfzvK5sH+MNQ
	o04bdkdscv8KOe7nRevoATawh7qCVUQJuPkXQq7gAFbVOhGLno2O8nXcPi1nAzrDWdK+GbWn0Qd8D
	cXiFTdOR4FuwbPq23xECBjzqUjszwXUpMmRqoa4E7nYT5qk5UhsUgBKn3DovNKFCM4ZyKBHMoM2nv
	7xslCfvg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41988 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoH-0007Tu-2t;
	Tue, 28 Jan 2025 15:47:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnny-0037GW-Eo; Tue, 28 Jan 2025 15:47:10 +0000
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
Subject: [PATCH RFC net-next 05/22] net: stmmac: remove priv->dma_cap.eee test
 in tx_lpi methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnny-0037GW-Eo@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:10 +0000

The tests for priv->dma_cap.eee in stmmac_mac_{en,dis}able_tx_lpi()
is useless as these methods will only be called when using phylink
managed EEE, and that will only be enabled if the LPI capabilities
in phylink_config have been populated during initialisation. This
only occurs when priv->dma_cap.eee was true.

As priv->dma_cap.eee remains constant during the lifetime of the driver
instance, there is no need to re-check it in these methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3a0f1003f7a8..c2cc75624a8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1044,12 +1044,6 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 
 	priv->eee_active = false;
 
-	/* Check if MAC core supports the EEE feature. */
-	if (!priv->dma_cap.eee) {
-		priv->eee_enabled = false;
-		return;
-	}
-
 	mutex_lock(&priv->lock);
 
 	/* Check if it needs to be deactivated */
@@ -1079,12 +1073,6 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	priv->tx_lpi_timer = timer;
 	priv->eee_active = true;
 
-	/* Check if MAC core supports the EEE feature. */
-	if (!priv->dma_cap.eee) {
-		priv->eee_enabled = false;
-		return 0;
-	}
-
 	mutex_lock(&priv->lock);
 
 	if (priv->eee_active && !priv->eee_enabled) {
-- 
2.30.2


