Return-Path: <netdev+bounces-158124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789CA10857
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976191886DCB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263F12CDAE;
	Tue, 14 Jan 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hMYYUPUz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732B232429
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863358; cv=none; b=XvFysL4o1lTlUaC4ZJgPpOYFpT3Gb1XeBGjiOX/o9M5IDQbrdfF/J/+geOqjlWXsOnCxyw/fqLLK8/sLZ/4xlId0wFUIisuIxWMiiWnV5Zz73nIxYqtgFu2HZ2x1+BFrgpbgoSZ6oLnUS6nxYVPZ6DwvTZiRksdCPG+OXDBgZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863358; c=relaxed/simple;
	bh=8J/vXutzQPcYVGy50+flvbly6N+Wl4on/P5IMOeLY8Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=asnDehYSOz/k1Dfsjxhblx6K1lRJIq1/7UDdijcv7qv4fnyR9oqNPql1q8huHhn+sVBgsp+Q57jSsRp5TiARz3yGfL0kqiTkyNjvAy/JBF8dSy5TQbz/HeomlbxtLI9aRpqgeVAZFGUrvehAPhxMWzL9ZokgSDG2vwd/FwWlUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hMYYUPUz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vaEBlUj0H2VP7EkKYD/BnxmzWZrwL5pRUBoloZUThy4=; b=hMYYUPUzpr+pwh+DjtycjF1/0w
	NTyUDBSrBz3gJBGBbnZKDzFIYm3nf7VSLpQSQm/pguT/pSXYINxi+fRrBWB1PG7DaJrGLGudGn71c
	sSHai4eR08ja1xPXXbZ1UZsov9ntvyXSm/cPw4xNVj3JmVcWb8YiQqvmrN1SlmBl9UbU0FVsftQ4Q
	XlzaETh6b0cug5Cjo8vwpbly8axZ8rA52dHjSM/jynION9dr2cK1tt5nfu8YY2MghNdIatL2GZEjU
	IP9KrfbwmRA62Jo6mumO1z4oesG7Q1vF9/ZQ0Sz18IorGPtyQO1TTm/9IzsPhQlV+CSE5N86jikK9
	dPlmsH6w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47348 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXhUy-00088x-0p;
	Tue, 14 Jan 2025 14:02:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXhUf-000n0M-3N; Tue, 14 Jan 2025 14:02:09 +0000
In-Reply-To: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 02/10] net: phy: add support for querying PHY
 clock stop capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXhUf-000n0M-3N@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 14:02:09 +0000

Add support for querying whether the PHY allows the transmit xMII clock
to be stopped while in LPI mode. This will be used by phylink to pass
to the MAC driver so it can configure the generation of the xMII clock
appropriately.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 20 ++++++++++++++++++++
 include/linux/phy.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a4b9fcc2503a..caf472b5d4e5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1640,6 +1640,26 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
+/**
+ * phy_eee_tx_clock_stop_capable() - indicate whether the MAC can stop tx clock
+ * @phydev: target phy_device struct
+ *
+ * Indicate whether the MAC can disable the transmit xMII clock while in LPI
+ * state. Returns 1 if the MAC may stop the transmit clock, 0 if the MAC must
+ * not stop the transmit clock, or negative error.
+ */
+int phy_eee_tx_clock_stop_capable(struct phy_device *phydev)
+{
+	int stat1;
+
+	stat1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_STAT1);
+	if (stat1 < 0)
+		return stat1;
+
+	return !!(stat1 & MDIO_PCS_STAT1_CLKSTOP_CAP);
+}
+EXPORT_SYMBOL_GPL(phy_eee_tx_clock_stop_capable);
+
 /**
  * phy_eee_rx_clock_stop() - configure PHY receive clock in LPI
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4875465653ca..c0b8293e0ac0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2096,6 +2096,7 @@ int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
 int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
+int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
 int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
-- 
2.30.2


