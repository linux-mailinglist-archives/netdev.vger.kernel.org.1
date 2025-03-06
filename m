Return-Path: <netdev+bounces-172477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E34A54EDD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE2E1896EEE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BBD20B20D;
	Thu,  6 Mar 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IGDIC4gO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F31624C8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274660; cv=none; b=izxparWbGvGrQ7uNtBacNmfV9NYBx2yogpF98SxevA/Pyur7yPnkfIe3izZjo+wNqLlD44trLy5MwcXzoXkVEg7kvrOseB5VnhjPsTIUrUEChDOT5/dln4opttMEyegDHnOF/ExN9bUaen5Do5ZyDSMg29hfoGFaQNaZMs5irKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274660; c=relaxed/simple;
	bh=WApAt6++7GITdj6KSvwB76mIhu5s7rEn4VTIzN/T73E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=G3x/jFUw1hmFgV9Bgj706sDmR5Ir18n2um0oh4Rd7IxCwwRdTAP2Y49ekaYRQNHlO/JpiiOvqmtvEFhsLQ+MlrD6ioczcYlPFWpFdyySd0QLMdrCudBf+GG3XDoVUkuN5xcxa8N/7YB1sRr7pLWOV6gbq6cRRjjLgEFg1p9gjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IGDIC4gO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v8IV8axIEzPcR53PibXsDScd8344V84cbKgGQIwvKDY=; b=IGDIC4gOxeVgiCpZ7PN0qcXlmS
	mfmA2wovWOv4rtuUp1nYniK7tfcmotFQsShY/T4GjlaOmccgE7sVvPNEeR+EPdH8Qm41jMGlTWO8p
	p0k5egQrF52qUe2xRRYfhm8EOVEtSxCzWoo8eSMlbC04QErf+OqVqeikv2PqC1bQqvhRslBqLHU9O
	dpfELnjRMA3k54U+1+NFTo8RbM8JtDneVDN4NpTR4QiIt7cyZ1q5pr0S/+qgr125QgKVLHa3DXFKD
	2f42UES+3+bvExiRstO1bl5RB4NGFM4yNWLS9kdWCrExlXudnvd2fNbAOUgii1F3s06+5hfX6cyKw
	3+1WORDg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58516 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tqD52-00065D-0M;
	Thu, 06 Mar 2025 15:24:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tqD4h-005Xx0-Ub; Thu, 06 Mar 2025 15:23:51 +0000
In-Reply-To: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
References: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>,
	 Thierry Reding <treding@nvidia.com>,
	 "Lad,
	 Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/2] net: phylink: add functions to block/unblock
 rx clock stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tqD4h-005Xx0-Ub@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Mar 2025 15:23:51 +0000

Some MACs require the PHY receive clock to be running to complete setup
actions. This may fail if the PHY has negotiated EEE, the MAC supports
receive clock stop, and the link has entered LPI state. Provide a pair
of APIs that MAC drivers can use to temporarily block the PHY disabling
the receive clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  3 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a3b186ab3854..d0926f0096b1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -88,6 +88,7 @@ struct phylink {
 	bool mac_enable_tx_lpi;
 	bool mac_tx_clk_stop;
 	u32 mac_tx_lpi_timer;
+	u8 mac_rx_clk_stop_blocked;
 
 	struct sfp_bus *sfp_bus;
 	bool sfp_may_have_phy;
@@ -2592,6 +2593,64 @@ void phylink_stop(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_stop);
 
+/**
+ * phylink_rx_clk_stop_block() - block PHY ability to stop receive clock in LPI
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Disable the PHY's ability to stop the receive clock while the receive path
+ * is in EEE LPI state, until the number of calls to phylink_rx_clk_stop_block()
+ * are balanced by calls to phylink_rx_clk_stop_unblock().
+ */
+void phylink_rx_clk_stop_block(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	if (pl->mac_rx_clk_stop_blocked == U8_MAX) {
+		phylink_warn(pl, "%s called too many times - ignoring\n",
+			     __func__);
+		dump_stack();
+		return;
+	}
+
+	/* Disable PHY receive clock stop if this is the first time this
+	 * function has been called and clock-stop was previously enabled.
+	 */
+	if (pl->mac_rx_clk_stop_blocked++ == 0 &&
+	    pl->mac_supports_eee_ops && pl->phydev &&
+	    pl->config->eee_rx_clk_stop_enable)
+		phy_eee_rx_clock_stop(pl->phydev, false);
+}
+EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_block);
+
+/**
+ * phylink_rx_clk_stop_unblock() - unblock PHY ability to stop receive clock
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * All calls to phylink_rx_clk_stop_block() must be balanced with a
+ * corresponding call to phylink_rx_clk_stop_unblock() to restore the PHYs
+ * ability to stop the receive clock when the receive path is in EEE LPI mode.
+ */
+void phylink_rx_clk_stop_unblock(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	if (pl->mac_rx_clk_stop_blocked == 0) {
+		phylink_warn(pl, "%s called too many times - ignoring\n",
+			     __func__);
+		dump_stack();
+		return;
+	}
+
+	/* Re-enable PHY receive clock stop if the number of unblocks matches
+	 * the number of calls to the block function above.
+	 */
+	if (--pl->mac_rx_clk_stop_blocked == 0 &&
+	    pl->mac_supports_eee_ops && pl->phydev &&
+	    pl->config->eee_rx_clk_stop_enable)
+		phy_eee_rx_clock_stop(pl->phydev, true);
+}
+EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
+
 /**
  * phylink_suspend() - handle a network device suspend event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 08df65f6867a..249c437d6b7b 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -698,6 +698,9 @@ int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs);
 void phylink_start(struct phylink *);
 void phylink_stop(struct phylink *);
 
+void phylink_rx_clk_stop_block(struct phylink *);
+void phylink_rx_clk_stop_unblock(struct phylink *);
+
 void phylink_suspend(struct phylink *pl, bool mac_wol);
 void phylink_resume(struct phylink *pl);
 
-- 
2.30.2


