Return-Path: <netdev+bounces-150234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74809E98A7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52902855F0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949241ACEDB;
	Mon,  9 Dec 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ObSA/Svn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782335946
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754211; cv=none; b=arernDW5N80hIkm6LEtkSbMb1Xh0WLRIjipPV0wpcoAQd+CDzIiKzOoOfp6Ui7ZVsOfOYl5SvFbTqv29nT2U6ZyVk1unai3jVD2PgMXbOjq7KfVnZCmp5xEJLqQhwJ3uXOP5vjkh7bC9BRBnOXo104Q7Dfu7ZhZWc6rwZD6OPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754211; c=relaxed/simple;
	bh=MZYe5i/gCE9W+qO7CgFie9mOnhZOcd8fdPES9L6GszI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mxzWxTz+rXkDCe0YJ3zRHMwv5Ci8iDkNqPTrwqwxGAusoRmGSY+fDf+ao/Ut2MMq9XM/1mLFdxps3zXfKrfF8wWebJqcxLAz0dxpQ/+qYdqcFz2x0lmA4ydWOLpvGwVW8/4Dk1TGNbxBbRoY4ri89ZXbrlseqJexdPFygvUakf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ObSA/Svn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KENiKZXXRHtKc0DZuMawWizxcvBnZqzaK5OBy4l7tt8=; b=ObSA/SvnxBW1W23bJP3AtcZQCE
	nFkqclfYSSR5LlaoN6lA9uhkeeMlHwJ1fUQTIH5EOgZhPpwIlze5Q1ajZlBmyAjRLi1uNM8bwPucY
	8EyXT8uzswNHSo7Ucb9pQN3bWZrFTIJ5vse+90Zedz1dlsUnUqctf/8XCfVDQLULm78iuP8h51J4w
	LNg/wGiN8lVX24e/qEj+8MEY7D9pp9BSL6x5FUrub1FjvkH2IQdmlL3hjjZK4y6vUdwG0n5PtrX25
	/YxpA3vZ6TVhCOsjgdWgWu/WaBK3plvtVg4JcGG05DnYdz4N4I/f4TT83Nd0JG0pgVqRTkuy7MIMm
	wrp5oxVw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39380 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKefU-0000wS-1p;
	Mon, 09 Dec 2024 14:23:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKefT-006SMS-6y; Mon, 09 Dec 2024 14:23:23 +0000
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 02/10] net: phy: add support for querying PHY clock
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
Message-Id: <E1tKefT-006SMS-6y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Dec 2024 14:23:23 +0000

Add support for querying whether the PHY allows the transmit xMII clock
to be stopped while in LPI mode. This will be used by phylink to pass
to the MAC driver so it can configure the generation of the xMII clock
appropriately.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 20 ++++++++++++++++++++
 include/linux/phy.h   |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e4b04cdaa995..8fb4224c7576 100644
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
  * phy_init_eee - init and check the EEE feature
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bb157136351e..267de08c227c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2072,6 +2072,7 @@ int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
 int phy_unregister_fixup_for_id(const char *bus_id);
 int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
+int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data);
-- 
2.30.2


