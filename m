Return-Path: <netdev+bounces-41407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B527CADE2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E20B20E6C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C22C85F;
	Mon, 16 Oct 2023 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KqeONs3E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FB2C86D;
	Mon, 16 Oct 2023 15:43:14 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E467083;
	Mon, 16 Oct 2023 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=soSU2MGTCT6ib3yKWFkcFVy9AAMSw/XWVbMCp1pCqhg=; b=KqeONs3E6YFOOlSFETWK7Q8GTY
	YlS08xPPKyljyRF/L6L9u2r4vHOaWuzSBCr6Ur2EuGs6zNkCf1EPNFn9hCya1Nika9GANUrqU1vjB
	a8j2f+ABuA1AXR42UydnF8eJob4tg3u7HoWDVaV/CSWaCT73CeHPIfN575EcaL9qfOvt/AnQOc/xu
	yF5nEZwn9+JWisbExtpNqhB2+oswuT40un0/mdDNk7NIN26yyUCEaXYVrsw44FIaqOBF15bCxIGeL
	ldgQadxFadc4sBt6N4pIpWUgVTFBaKJUCn7XJyd8KJBLwMLm6cvI8634KD5+j1LfetC7Us4L+10Gs
	maISKUiw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51926 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qsPkJ-0001fm-2J;
	Mon, 16 Oct 2023 16:43:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qsPkK-009wip-W9; Mon, 16 Oct 2023 16:43:09 +0100
In-Reply-To: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
References: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH net-next 4/4] net: phylink: remove a bunch of unused
 validation methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qsPkK-009wip-W9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Oct 2023 16:43:08 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove exports for phylink_caps_to_linkmodes(),
phylink_get_capabilities(), phylink_validate_mask_caps() and
phylink_generic_validate(). Also, as phylink_generic_validate() is no
longer called, we can remove its implementation as well.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 35 ++++++++---------------------------
 include/linux/phylink.h   | 11 -----------
 2 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1c7e73fa58e4..6712883498bb 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -257,7 +257,8 @@ static int phylink_interface_max_speed(phy_interface_t interface)
  * Set all possible pause, speed and duplex linkmodes in @linkmodes that are
  * supported by the @caps. @linkmodes must have been initialised previously.
  */
-void phylink_caps_to_linkmodes(unsigned long *linkmodes, unsigned long caps)
+static void phylink_caps_to_linkmodes(unsigned long *linkmodes,
+				      unsigned long caps)
 {
 	if (caps & MAC_SYM_PAUSE)
 		__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, linkmodes);
@@ -400,7 +401,6 @@ void phylink_caps_to_linkmodes(unsigned long *linkmodes, unsigned long caps)
 		__set_bit(ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT, linkmodes);
 	}
 }
-EXPORT_SYMBOL_GPL(phylink_caps_to_linkmodes);
 
 static struct {
 	unsigned long mask;
@@ -477,9 +477,9 @@ static unsigned long phylink_cap_from_speed_duplex(int speed,
  * Get the MAC capabilities that are supported by the @interface mode and
  * @mac_capabilities.
  */
-unsigned long phylink_get_capabilities(phy_interface_t interface,
-				       unsigned long mac_capabilities,
-				       int rate_matching)
+static unsigned long phylink_get_capabilities(phy_interface_t interface,
+					      unsigned long mac_capabilities,
+					      int rate_matching)
 {
 	int max_speed = phylink_interface_max_speed(interface);
 	unsigned long caps = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
@@ -606,7 +606,6 @@ unsigned long phylink_get_capabilities(phy_interface_t interface,
 
 	return (caps & mac_capabilities) | matched_caps;
 }
-EXPORT_SYMBOL_GPL(phylink_get_capabilities);
 
 /**
  * phylink_validate_mask_caps() - Restrict link modes based on caps
@@ -618,9 +617,9 @@ EXPORT_SYMBOL_GPL(phylink_get_capabilities);
  * @supported and @state based on that. Use this function if your capabiliies
  * aren't constant, such as if they vary depending on the interface.
  */
-void phylink_validate_mask_caps(unsigned long *supported,
-				struct phylink_link_state *state,
-				unsigned long mac_capabilities)
+static void phylink_validate_mask_caps(unsigned long *supported,
+				       struct phylink_link_state *state,
+				       unsigned long mac_capabilities)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	unsigned long caps;
@@ -634,24 +633,6 @@ void phylink_validate_mask_caps(unsigned long *supported,
 	linkmode_and(supported, supported, mask);
 	linkmode_and(state->advertising, state->advertising, mask);
 }
-EXPORT_SYMBOL_GPL(phylink_validate_mask_caps);
-
-/**
- * phylink_generic_validate() - generic validate() callback implementation
- * @config: a pointer to a &struct phylink_config.
- * @supported: ethtool bitmask for supported link modes.
- * @state: a pointer to a &struct phylink_link_state.
- *
- * Generic implementation of the validate() callback that MAC drivers can
- * use when they pass the range of supported interfaces and MAC capabilities.
- */
-void phylink_generic_validate(struct phylink_config *config,
-			      unsigned long *supported,
-			      struct phylink_link_state *state)
-{
-	phylink_validate_mask_caps(supported, state, config->mac_capabilities);
-}
-EXPORT_SYMBOL_GPL(phylink_generic_validate);
 
 static int phylink_validate_mac_and_pcs(struct phylink *pl,
 					unsigned long *supported,
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 0cf559bae1ff..875439ab45de 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -613,17 +613,6 @@ void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
 #endif
 
-void phylink_caps_to_linkmodes(unsigned long *linkmodes, unsigned long caps);
-unsigned long phylink_get_capabilities(phy_interface_t interface,
-				       unsigned long mac_capabilities,
-				       int rate_matching);
-void phylink_validate_mask_caps(unsigned long *supported,
-				struct phylink_link_state *state,
-				unsigned long caps);
-void phylink_generic_validate(struct phylink_config *config,
-			      unsigned long *supported,
-			      struct phylink_link_state *state);
-
 struct phylink *phylink_create(struct phylink_config *,
 			       const struct fwnode_handle *,
 			       phy_interface_t,
-- 
2.30.2


