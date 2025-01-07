Return-Path: <netdev+bounces-155962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A6A04678
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8AD3A2ED9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A021F76C1;
	Tue,  7 Jan 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dAcy0TwS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255F1F63F4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267403; cv=none; b=ZCQQYwJc07G/ooB8SAZ2xgrsYc1/3m2tmAICxeW03qenPIXhMaRwju8HgcZz3IBLk9BUr+ZdxQS5F2Kt3Rv2+WEEP6M96k1AlDmhsC4KAjd+oiOlSzQ6yhXEjhTgdr8VanWGGOUE1TyY4VjlQhRn8PSRHvZiSqvkre3d46sIt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267403; c=relaxed/simple;
	bh=+BgHdbVcM52iUi6wURyxBWgYJXvWUdhKlW5WTBcUyYg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=W/hgL67y4+gbqWq9lZt8q25zF5TwgLp5ojxlEwf11ZV0UtHxFEXK2jzeH3+ZJw1QeLg0yaTtI2JOyDFp+vn15yJ28pnC/ib5DjszIYRBXKIgpGS7PuUA2KhBEa/h4A1yGvTIioXkGN4jM991rz7IkYs3iPsnVBU9lvHnMxCxyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dAcy0TwS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3AUocAZiwiTM1o3I9pmtV7S57CGscNwsOJhG3dqdD+Q=; b=dAcy0TwSRtzxc0Xqwrm9/xQUeJ
	Ome5mKrqurdLIfGC2+a6M6xY+zw11Dr8D8qhi4i2aoUaujt1CRyy6fTY3MpO8SjBIYfY/p/5Wriwz
	2UyMQxUr8AbMqfOjWsD62NrMzY5pnUjS4oDGiX/bSZ9vyNtSW5hgNGxQTEIyf8tiqOX7brvGesBlL
	c+058lUb46ni4zWZMF6qNv0dUh1W8iBTIHNP8pxqlNOk/vX3OAglY3cy9ZXkqn2rfK+hBtUjditz9
	unp/K1O7VP7vK60W4+vHtGEDS0WELKxNdwUqgGtWGNekiYUbhsTIXAfRqtsV28d2KFcsVkFt1wFzc
	OJAOvkfQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40852 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSl-0007p6-35;
	Tue, 07 Jan 2025 16:29:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCSi-007Y4R-V7; Tue, 07 Jan 2025 16:29:48 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 16/18] net: stmmac: remove unnecessary EEE
 handling in stmmac_release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCSi-007Y4R-V7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:48 +0000

phylink_stop() will cause phylink to call the mac_link_down() operation
before phylink_stop() returns. As mac_link_down() will call
stmmac_eee_init(false), this will set both priv->eee_active and
priv->eee_enabled to be false, deleting the eee_ctrl_timer if
priv->eee_enabled was previously set.

As stmmac_release() calls phylink_stop() before checking whether
priv->eee_enabled is true, this is a condition that can never be
satisfied, and thus the code within this if() block will never be
executed. Remove it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b003f462006d..0a1e2587f8c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4033,11 +4033,6 @@ static int stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	if (priv->eee_enabled) {
-		priv->tx_path_in_lpi_mode = false;
-		del_timer_sync(&priv->eee_ctrl_timer);
-	}
-
 	/* Stop TX/RX DMA and clear the descriptors */
 	stmmac_stop_all_dma(priv);
 
-- 
2.30.2


