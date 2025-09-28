Return-Path: <netdev+bounces-226983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5EBA6C59
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100E317C3A5
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B22BEFF1;
	Sun, 28 Sep 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VzPMhNEx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A8213236;
	Sun, 28 Sep 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049945; cv=none; b=K7fdOUZ7jSdT68o/xt8jusBxKtzAxVDY9nEJCY5bXjcOjuv1cz9lrge0t1lUeYMY4kFJcdv3EblnGiABzXAt0AfXgZdKPQovRM0gUxEc16bnFk7QyuRabg8HCuW+SwJJJU0blO/+vLWmnrwsXhR+cDQvbdMCrmEkLavTE9Un7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049945; c=relaxed/simple;
	bh=nvJfGrP7+h4Lfh67grIr5YrHb/pqusJhkLoty64/T78=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=p3T75A6fRt9yKLNizp0rIBfRYNBplyka9Clh9QZKZwFFs/nQgYSxhYv8o3ORzAnD5hT7+FemsyZI1NO4RfhRhFAd8xkssMDqBIE1XtjgGH0fI8lcYGsDUuF8yT/4bB+/SIbJMLWVyowfgZZADdmmF41C65Y9ECOAwMmNZ7CPdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VzPMhNEx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gu5CfNLtZRXzS+mClkrGSXL7Px/goHLl4BLV18Mh0Lw=; b=VzPMhNExNUWP+FCng16dWadnLb
	rCCms0cjwIpnVk0fA2RHBml+ZbMaUREyrvU/mXsA7thyGkWIhYw2/YcWsWUxoJJAftljeAtEeN1Fq
	zcC/IUiubpcp3Flrm6jBrv9Qws+eO61JuzavWg6CVRHExbQsSDEQcF+y4WH09JWixdbZ5pBTqlH1F
	Ft2pjM22N1aXSic6KUSVI035S5goKprqqhEJtwjdMXxPCgwOBMaJWpin46Dny7lJa+0cRDCKgOJqC
	wMiwffI1ueh5dMsHcdJ2py/S0Av1ZTL32I/XLJCcJe9/2ljuwdZKr06bmb4nlkwDjA2vzmefFsh8M
	O4PUJV6w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53250 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v2nF8-000000005Ab-426O;
	Sun, 28 Sep 2025 09:58:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v2nF8-00000007jXJ-0BUZ;
	Sun, 28 Sep 2025 09:58:54 +0100
In-Reply-To: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
References: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	 Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH RFC net-next 1/6] net: phy: add phy_can_wakeup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v2nF8-00000007jXJ-0BUZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Sep 2025 09:58:54 +0100

Add phy_can_wakeup() to report whether the PHY driver has marked the
PHY device as being wake-up capable as far as the driver model is
concerned.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phy.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index b377dfaa6801..7f6758198948 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1379,6 +1379,18 @@ static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode
 	linkmode_clear_bit(link_mode, phydev->advertising_eee);
 }
 
+/**
+ * phy_can_wakeup() - indicate whether PHY has driver model wakeup capabilities
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_capable()
+ * setting.
+ */
+static inline bool phy_can_wakeup(struct phy_device *phydev)
+{
+	return device_can_wakeup(&phydev->mdio.dev);
+}
+
 void phy_resolve_aneg_pause(struct phy_device *phydev);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev);
 
-- 
2.47.3


