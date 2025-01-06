Return-Path: <netdev+bounces-155433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746ECA02541
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD481885E85
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2F1DC982;
	Mon,  6 Jan 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h11kneiI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B691DD525
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166301; cv=none; b=Q/mL8Ea1RtDdHkN+ouPL+BFBtT1vFnyhgOOqKStr1XszVyCoSofLMj1FcEbxw3CbV15Je4qVocHxqTwJvBmkpokMdamSbvudcF9Paw8dKnxaCv/h8ndGgdGFfDOqppKBWS/lLEBtzk6XvR1ak+8gWwzTk2t+jKBiVmIHOfVq+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166301; c=relaxed/simple;
	bh=O4MlM9GRQ4VMmTJ+BrHpXuZ1spwI+aMOhgg3ziv4GMY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=I1G9fwRUh0cWxza5Oz8Dvlm0HMQcEUKcH4Y82C0wIy7GPc9iO6EBlsOraGu/QAmwpem1HRMMmGoyMB8BkgTm87qvqF+wZUerBLUHwL6m74xGDznt9WG7aVEjtTYPs5buuatTAAaPEylmRaLxo948DFlUa3C9dgfgQyNwMmq1Twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h11kneiI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CT43NNJbVwdfAfypfZGQdJlroOFKN88S2LgKWnUbjeQ=; b=h11kneiITp/NaXQfWyCCxfPLo3
	H4+v5OHtcbjf7duXrP18OusOkkmakYQMcTp6p94gE5jqjQRzRdDLI4T61AYFbeFpvQRq43UbAMIRE
	frdJAWmFsHOdNLMHxWCBKfjbrS5QiIkLgblfzpCpZWox2WhcciHXNbBmdKLeUiJsj64n1jCy83Uxx
	Smh0oJ2I12eJlRGvayQ7kmBOhXNLzYHEgWHNvhl+DKTPmRF1v+l5hnBH+KQgabkDsOcpBmMtUBFXx
	1fxQZAKaGzWx14agfAum0iFYgKhvvEGuRfQabnS0ZDRnnMQQ0rCKoEzwVfOGXnSeIvOgyKniYDhlG
	4nT/wpjg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58556 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmA7-0005qL-20;
	Mon, 06 Jan 2025 12:24:51 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmA4-007VWj-MW; Mon, 06 Jan 2025 12:24:48 +0000
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
Subject: [PATCH net-next v2 01/17] net: phy: add configuration of rx clock
 stop mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmA4-007VWj-MW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:24:48 +0000

Add a function to allow configuration of the PCS's clock stop enable
bit, used to configure whether the xMII receive clock can be stopped
during LPI mode.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 27 ++++++++++++++++++++++-----
 include/linux/phy.h   |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e4b04cdaa995..a4b9fcc2503a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1640,6 +1640,27 @@ void phy_mac_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_mac_interrupt);
 
+/**
+ * phy_eee_rx_clock_stop() - configure PHY receive clock in LPI
+ * @phydev: target phy_device struct
+ * @clk_stop_enable: flag to indicate whether the clock can be stopped
+ *
+ * Configure whether the PHY can disable its receive clock during LPI mode,
+ * See IEEE 802.3 sections 22.2.2.2, 35.2.2.10, and 45.2.3.1.4.
+ *
+ * Returns: 0 or negative error.
+ */
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable)
+{
+	/* Configure the PHY to stop receiving xMII
+	 * clock while it is signaling LPI.
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
+			      MDIO_PCS_CTRL1_CLKSTOP_EN,
+			      clk_stop_enable ? MDIO_PCS_CTRL1_CLKSTOP_EN : 0);
+}
+EXPORT_SYMBOL_GPL(phy_eee_rx_clock_stop);
+
 /**
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
@@ -1664,11 +1685,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 		return -EPROTONOSUPPORT;
 
 	if (clk_stop_enable)
-		/* Configure the PHY to stop receiving xMII
-		 * clock while it is signaling LPI.
-		 */
-		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
-				       MDIO_PCS_CTRL1_CLKSTOP_EN);
+		ret = phy_eee_rx_clock_stop(phydev, true);
 
 	return ret < 0 ? ret : 0;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5bc71d59910c..4875465653ca 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2096,6 +2096,7 @@ int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
 int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
+int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.30.2


