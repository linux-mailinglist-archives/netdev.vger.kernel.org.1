Return-Path: <netdev+bounces-183515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E8A90E5F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DAD188B175
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D72236F8;
	Wed, 16 Apr 2025 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dXwleSZs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251242BAF4
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840926; cv=none; b=Ha0tIphrXAqoY8ixyet3NystzKEJ3TC6anDZq9EKcO4U5U+HDuSzl5J8HGTij6FrPFA7lE/mF+B9nAtJryDihkKcZTH8PcrvLS4hnAeocKz6qEAEHGCCUgES7SwhiNFfM3u70rovKOVOHckfLFjcVFqy6I2KZJ+DMXh7ovZHtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840926; c=relaxed/simple;
	bh=XEFjz1BLdrJC/SCjbanmWnla0BiSg4VgDX6TI4CwoDw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=eCWrksgHl+ZTEV3pAy8JQ5muXM5V2189lI78APj6OUGeaJK9cCMtxeRFE0zqOSb7hT4A/FrkYj4xve9yBusz5K7yok7BFEzRTxepOsGOlleoDB1EtM0sxNo5uXBbPmmJGX3wYqNZA27DGd7or37uDoMfmqQhNJFFwYWvw33+V60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dXwleSZs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DyJM2Wqc0DHebDP6gR70VQ+7vKOaNKRNS6QP6hMxcyc=; b=dXwleSZsQF3aq/4Mh7F8R97StF
	KkxlaemvYUx0vOZX45MfpnodaM6GbtvAFqO9ICZxUovI/K0MS3E5e+kylgG4adqy1PEyGappcdwHH
	rIaILK/ykwlRT1ZQK7M0XiHkVAUOdhqIAJift1ibmaIz8a/EB8sZBbmhxP25o8Rg0FTVvhGqYnsP1
	Cny71XuxwAZkFyFTsqOFIjcsnXQguKZa0ug+GRntb/TbiLBpwcN0YwROiyiMIBGuNs6pICd9xT4hr
	aj7gYdvBdXMGzYaAxcbm46iRv9yifW2QoanP+NHZLU9+rNbXGb68qruI82THNLn+Lu2P8SWsHueNJ
	WNjtKfbw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53808 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u5Ahg-0001xX-24;
	Wed, 16 Apr 2025 22:53:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u5Ah5-001GO1-7E; Wed, 16 Apr 2025 22:53:19 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: phylink: mac_link_(up|down)() clarifications
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u5Ah5-001GO1-7E@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Apr 2025 22:53:19 +0100

As a result of an email from the fbnic author, I reviewed the phylink
documentation, and I have decided to clarify the wording in the
mac_link_(up|down)() kernel documentation as this was written from the
point of view of mvneta/mvpp2 and is misleading.

The documentation talks about forcing the link - indeed, this is what
is done in the mvneta and mvpp2 drivers but not at the physical layer
but the MACs idea, which has the effect of only allowing or stopping
packet flow at the MAC. This "link" needs to be controlled when using
a PHY or fixed link to start or stop packet flow at the MAC. However,
as the MAC and PCS are tightly integrated, if the MACs idea of the
link is forced down, it has the side effect that there is no way to
determine that the media link has come up - in this mode, the MAC must
be allowed to follow its built-in PCS so we can read the link state.

Frame the documentation in more generic terms, to avoid the thought
that the physical media link to the partner needs in some way to be
forced up or down with these calls; it does not. If that were to be
done, it would be a self-fulfilling prophecy - e.g. if the media link
goes down, then mac_link_down() will be called, and if the media link
is then placed into a forced down state, there is no possibility
that the media link will ever come up again - clearly this is a wrong
interpretation.

These methods are notifications to the MAC about what has happened to
the media link state - either from the PHY, or a PCS, or whatever
mechanism fixed-link is using. Thus, reword them to get away from
talking about changing link state to avoid confusion with media link
state.

This is not a change of any requirements of these methods.

Also, remove the obsolete references to EEE for these methods, we now
have the LPI functions for configuring the EEE parameters which
renders this redundant, and also makes the passing of "phy" to the
mac_link_up() function obsolete.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phylink.h | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1f5773ab5660..30659b615fca 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -361,23 +361,29 @@ int mac_finish(struct phylink_config *config, unsigned int mode,
 		phy_interface_t iface);
 
 /**
- * mac_link_down() - take the link down
+ * mac_link_down() - notification that the link has gone down
  * @config: a pointer to a &struct phylink_config.
  * @mode: link autonegotiation mode
  * @interface: link &typedef phy_interface_t mode
  *
- * If @mode is not an in-band negotiation mode (as defined by
- * phylink_autoneg_inband()), force the link down and disable any
- * Energy Efficient Ethernet MAC configuration. Interface type
- * selection must be done in mac_config().
+ * Notifies the MAC that the link has gone down. This will not be called
+ * unless mac_link_up() has been previously called.
+ *
+ * The MAC should stop processing packets for transmission and reception.
+ * phylink will have called netif_carrier_off() to notify the networking
+ * stack that the link has gone down, so MAC drivers should not make this
+ * call.
+ *
+ * If @mode is %MLO_AN_INBAND, then this function must not prevent the
+ * link coming up.
  */
 void mac_link_down(struct phylink_config *config, unsigned int mode,
 		   phy_interface_t interface);
 
 /**
- * mac_link_up() - allow the link to come up
+ * mac_link_up() - notification that the link has come up
  * @config: a pointer to a &struct phylink_config.
- * @phy: any attached phy
+ * @phy: any attached phy (deprecated - please use LPI interfaces)
  * @mode: link autonegotiation mode
  * @interface: link &typedef phy_interface_t mode
  * @speed: link speed
@@ -385,7 +391,10 @@ void mac_link_down(struct phylink_config *config, unsigned int mode,
  * @tx_pause: link transmit pause enablement status
  * @rx_pause: link receive pause enablement status
  *
- * Configure the MAC for an established link.
+ * Notifies the MAC that the link has come up, and the parameters of the
+ * link as seen from the MACs point of view. If mac_link_up() has been
+ * called previously, there will be an intervening call to mac_link_down()
+ * before this method will be subsequently called.
  *
  * @speed, @duplex, @tx_pause and @rx_pause indicate the finalised link
  * settings, and should be used to configure the MAC block appropriately
@@ -397,9 +406,9 @@ void mac_link_down(struct phylink_config *config, unsigned int mode,
  * that the user wishes to override the pause settings, and this should
  * be allowed when considering the implementation of this method.
  *
- * If in-band negotiation mode is disabled, allow the link to come up. If
- * @phy is non-%NULL, configure Energy Efficient Ethernet by calling
- * phy_init_eee() and perform appropriate MAC configuration for EEE.
+ * Once configured, the MAC may begin to process packets for transmission
+ * and reception.
+ *
  * Interface type selection must be done in mac_config().
  */
 void mac_link_up(struct phylink_config *config, struct phy_device *phy,
-- 
2.30.2


