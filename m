Return-Path: <netdev+bounces-203255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3BAF107B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063FF520F40
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDB248893;
	Wed,  2 Jul 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q3GJtkiT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF60248886
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449522; cv=none; b=odWsRa53awpMzp2+zcHLe3IoMLTp6KVDQRuAPgdXbQ/rlP/OPcAFqenGqkMrs4JWqnzn/SNCI8ap+gnS69R+58GKmMkN2fBWFWWWAsJ7vpLzTWd5B+KdzHdQSoxOTITh+caiq9+L54tLEel1q0/xRY3ZJlVvO3h/2j1GhZlVqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449522; c=relaxed/simple;
	bh=2O+MhMKdnbIbEJONlQxrJ5VAqwuESrIqBoVbNioUGQ8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=i9aue02E9ELuGZs7NgS9qTU6FYhIrlZ1xj2NxT5f0pUmKctBx7taDL89vZWUmDdbN6TNfZ2OVpGxOSL/dDghamLknPvOOkkVsQRQEyAmm5cAIJWL6hFOtybRBz6x4+YESxADqroKPVGeA7ANJC6j6MYpYavbblA0T2A3ya5x5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q3GJtkiT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=21FXeyp5fcxCa1dzbyfJfckjUlTEeCyNDaa79Lfp0NA=; b=Q3GJtkiTjxVTVNT+t56sqJmcru
	luDgFxZUgDknRtZU7IrBzFLToN/hC+UCGd/GVWYQeqmz5r4lLoFjlP0tdCOptTDw1+/9knWnyTg+f
	iE27MUZ//+1DMXoNf4F6nDW2/a8HLeauNp7tIA0+3eL/ri8dXNkvQKsqxwm3336hmfXY20YnrjuIB
	bOhshDTtL05y0GbVRUf26BA9RH5KPhsA04iM0BrgW00Esu+yCYY6QVmEquKVoTEO+tAK3re6xHUiu
	SzRmh9WclP0wKMWuvH5SeSNBPay0VS3fbax25R0xsmsCD/q+/d5hVdJ1dxH5+K5ZLx9jtQuuQ/3++
	NNginPig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37232 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uWu1k-0007Oc-13;
	Wed, 02 Jul 2025 10:45:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uWu14-005KXo-IO; Wed, 02 Jul 2025 10:44:34 +0100
In-Reply-To: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 02 Jul 2025 10:44:34 +0100

Add phylink_sfp_select_interface_speed() which attempts to select the
SFP interface based on the ethtool speed when autoneg is turned off.
This allows users to turn off autoneg for SFPs that support multiple
interface modes, and have an appropriate interface mode selected.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 41 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c92a878ab717..f5473510b762 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2709,6 +2709,39 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 	return interface;
 }
 
+static phy_interface_t phylink_sfp_select_interface_speed(struct phylink *pl,
+							  u32 speed)
+{
+	phy_interface_t best_interface = PHY_INTERFACE_MODE_NA;
+	phy_interface_t interface;
+	u32 max_speed;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(phylink_sfp_interface_preference); i++) {
+		interface = phylink_sfp_interface_preference[i];
+		if (!test_bit(interface, pl->sfp_interfaces))
+			continue;
+
+		max_speed = phylink_interface_max_speed(interface);
+
+		/* The logic here is: if speed == max_speed, then we've found
+		 * the best interface. Otherwise we find the interface that
+		 * can just support the requested speed.
+		 */
+		if (max_speed >= speed)
+			best_interface = interface;
+
+		if (max_speed <= speed)
+			break;
+	}
+
+	if (best_interface == PHY_INTERFACE_MODE_NA)
+		phylink_err(pl, "selection of interface failed, speed %u\n",
+			    speed);
+
+	return best_interface;
+}
+
 static void phylink_merge_link_mode(unsigned long *dst, const unsigned long *b)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask);
@@ -2911,8 +2944,14 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 	 * link can be configured correctly.
 	 */
 	if (pl->sfp_bus) {
-		config.interface = phylink_sfp_select_interface(pl,
+		if (kset->base.autoneg == AUTONEG_ENABLE)
+			config.interface =
+				phylink_sfp_select_interface(pl,
 							config.advertising);
+		else
+			config.interface =
+				phylink_sfp_select_interface_speed(pl,
+							config.speed);
 		if (config.interface == PHY_INTERFACE_MODE_NA)
 			return -EINVAL;
 
-- 
2.30.2


