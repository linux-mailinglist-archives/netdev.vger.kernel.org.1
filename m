Return-Path: <netdev+bounces-158638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0553A12CD6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EA21889364
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B3A1D88BE;
	Wed, 15 Jan 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g951auMi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2431D6199
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973780; cv=none; b=E7iFZDFf3U0cHm4F1bD47pNHUJE1sqPt1GZTE28ZtxMly+n55Rzpkqe/KJl15V3iDmAVTzVx4YupUKsTlwAcsKDbLXNHrSqBj+lSf3Kc9PFUU4c8M9HOMAgIHkIIfEf25uRb3w6XmfyORgMc4YvL+Wg/84lAKai12WU2k4yq0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973780; c=relaxed/simple;
	bh=E22Xbff9ivBMzZkOMuA/Ie9pqJp1RTzPlxxM2Lz0si4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=o10bMmdxuNNIeQyz89/9U/Unta2w9mM60amOGEsLLGsczf3j9UI786vcEUA5hPYkfnfckR5DANN+P9NNJV0fZA6sS/aaU2cxvFVP49EKKxJ1Z9B6dyR4xp5u5r8VjY58uQG9WtTmsUu0ObRwjWPCYyTT9U38f+njj8/TvA9xcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g951auMi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OZcXDFelwtfpcW3nqfH6VfMWYnTJDhzteJIFMDC1ehI=; b=g951auMiFMfH/LnUUNxnYBs3ko
	sofqGj03ShM228yfHBmAUeB0i2qqTcLp4/WARfFdwTR115QZvCjP6iTK/n3QLbPr2lfGZFGlYy5kf
	71sk5AlI4B1MXm/MfPJFJBsmuo8pJXEFiSLxpEjm1GccVHBpAwAOsNtG4xcyM2l3DSmmjH7paieVM
	JrnG1EksUuYSODjivzoeE5ZDVcOE1RIpwp45Crqe6/pWyEgROWXcPDyfYogVgjzHXFPch6rHJcfVM
	SC9SLKmXRcmKtN1tHjI0Gi29yuVD8I935PWWRu1XSdbZuUk492otTuCSHLuhksjaZkW6Z/qHndklp
	7Nwg/qEA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54724 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYADz-0001iQ-1L;
	Wed, 15 Jan 2025 20:42:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYADg-0014Pb-AJ; Wed, 15 Jan 2025 20:42:32 +0000
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
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
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 2/9] net: phy: add support for querying PHY clock
 stop capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tYADg-0014Pb-AJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Jan 2025 20:42:32 +0000

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
index c008fe050245..d0c1718e2b16 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1703,6 +1703,26 @@ void phy_mac_interrupt(struct phy_device *phydev)
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
index afaae74d0949..244f747b3cd9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2146,6 +2146,7 @@ int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
 int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
+int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
 int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
-- 
2.30.2


