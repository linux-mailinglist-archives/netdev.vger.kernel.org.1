Return-Path: <netdev+bounces-177130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC696A6E004
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86289188F346
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E5263C91;
	Mon, 24 Mar 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="juF2w3fy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159112638B0
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834446; cv=none; b=RRMM4e5270/zrJuj855roMjZiBnklHoSQxkLg5qOjeKvtiVRmQCA6986akXsaY4XMqNKsxaSWJjhczI941gU4KuXCxJ21Fk2ldUl/mw6+FT0r8Xh6aLgic0qt5CIWmJwLG4rOUibEF/EhbBRTRAeN2/SRBaEiknZ7Ut7PGKL1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834446; c=relaxed/simple;
	bh=CoaoaItT6ngOPjWLeVv8s3EE4bnrFax4CzzAt1jbklQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=UcnAanB5A+h7XFeRViNFQC1pBTTpowdDG4Qn8V/k+y4oSGc6Nwb72RzpoU2oHSIt9GNsWRAU7ZdUEruHrY0mrthfhD/X/hFLRY82V7774LgJEIBH840ihjeaASNm71LlC6UXx1lSKKpMbRZ8dDXfM3lmC1NFsly3tE2BDt56q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=juF2w3fy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MYyp8xOp5CqL3tk5cl2ZZNgAxtFYffkmMs1CgaTsZaI=; b=juF2w3fyLqp3ZtLtNWSF24YWo2
	9c1cnybZkIV3Zq+CUyzDjFyj4op7Q25sVIK5/TFjENPEX/7A46imXV9tpDhoCs9LEg/s2hDVx0yIC
	1wP4PIjfcNYikyWnjRI5rAg1AGbGLmDSN1zNTDjXnT8JRHTnv/4oebfevEWTq4nR0BwKC97zAiBH5
	0R5rFqU/KjPDtTPRLo15571uoRFCY/NC0c8awKYMPN8hJvja/QW3KVUmjMJxi9vYxVMayY3eaNqcr
	YtMO5oTKPSWAsn6LQKmeZSAnOycxZZTKlajXpKf9dSZUoShyWC5DvIjyBgkYW8RCACJxwfyq3tUWM
	abxqCd2g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53274 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1twkqu-0003oP-09;
	Mon, 24 Mar 2025 16:40:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1twkqO-0006FI-Gm; Mon, 24 Mar 2025 16:40:08 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phylink: force link down on major_config
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1twkqO-0006FI-Gm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 24 Mar 2025 16:40:08 +0000

If we fail to configure the MAC or PCS according to the desired mode,
do not allow the network link to come up until we have successfully
configured the MAC and PCS. This improves phylink's behaviour when an
error occurs.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 42 +++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0f70a7f3dfcc..047ebb5d5f8c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -83,6 +83,7 @@ struct phylink {
 	unsigned int pcs_state;
 
 	bool link_failed;
+	bool major_config_failed;
 	bool mac_supports_eee_ops;
 	bool mac_supports_eee;
 	bool phy_enable_tx_lpi;
@@ -1217,12 +1218,16 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		    phylink_an_mode_str(pl->req_link_an_mode),
 		    phy_modes(state->interface));
 
+	pl->major_config_failed = false;
+
 	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs)) {
 			phylink_err(pl,
 				    "mac_select_pcs unexpectedly failed: %pe\n",
 				    pcs);
+
+			pl->major_config_failed = true;
 			return;
 		}
 
@@ -1244,6 +1249,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		if (err < 0) {
 			phylink_err(pl, "mac_prepare failed: %pe\n",
 				    ERR_PTR(err));
+			pl->major_config_failed = true;
 			return;
 		}
 	}
@@ -1267,19 +1273,27 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 
 	phylink_mac_config(pl, state);
 
-	if (pl->pcs)
-		phylink_pcs_post_config(pl->pcs, state->interface);
+	if (pl->pcs) {
+		err = phylink_pcs_post_config(pl->pcs, state->interface);
+		if (err < 0) {
+			phylink_err(pl, "pcs_post_config failed: %pe\n",
+				    ERR_PTR(err));
+
+			pl->major_config_failed = true;
+		}
+	}
 
 	if (pl->pcs_state == PCS_STATE_STARTING || pcs_changed)
 		phylink_pcs_enable(pl->pcs);
 
 	err = phylink_pcs_config(pl->pcs, pl->pcs_neg_mode, state,
 				 !!(pl->link_config.pause & MLO_PAUSE_AN));
-	if (err < 0)
-		phylink_err(pl, "pcs_config failed: %pe\n",
-			    ERR_PTR(err));
-	else if (err > 0)
+	if (err < 0) {
+		phylink_err(pl, "pcs_config failed: %pe\n", ERR_PTR(err));
+		pl->major_config_failed = true;
+	} else if (err > 0) {
 		restart = true;
+	}
 
 	if (restart)
 		phylink_pcs_an_restart(pl);
@@ -1287,16 +1301,22 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pl->mac_ops->mac_finish) {
 		err = pl->mac_ops->mac_finish(pl->config, pl->act_link_an_mode,
 					      state->interface);
-		if (err < 0)
+		if (err < 0) {
 			phylink_err(pl, "mac_finish failed: %pe\n",
 				    ERR_PTR(err));
+
+			pl->major_config_failed = true;
+		}
 	}
 
 	if (pl->phydev && pl->phy_ib_mode) {
 		err = phy_config_inband(pl->phydev, pl->phy_ib_mode);
-		if (err < 0)
+		if (err < 0) {
 			phylink_err(pl, "phy_config_inband: %pe\n",
 				    ERR_PTR(err));
+
+			pl->major_config_failed = true;
+		}
 	}
 
 	if (pl->sfp_bus) {
@@ -1640,6 +1660,12 @@ static void phylink_resolve(struct work_struct *w)
 		}
 	}
 
+	/* If configuration of the interface failed, force the link down
+	 * until we get a successful configuration.
+	 */
+	if (pl->major_config_failed)
+		link_state.link = false;
+
 	if (link_state.link != cur_link_state) {
 		pl->old_link_state = link_state.link;
 		if (!link_state.link)
-- 
2.30.2


