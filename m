Return-Path: <netdev+bounces-164650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425AA2E9A1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C093A2768
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBA91CCB4B;
	Mon, 10 Feb 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JPCmuPeP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5C15624D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183834; cv=none; b=U9y9bQpLj/RawwpJcoAGwqR9LXk7KVQUwXQOTWwUej4hWRTJafBMUrjXnCsg+OXfOzIc2LPwyBdBMuDeYufeuSD2A4OuLTQXDFNLNKrnTgB12mXyVEr6P1o4FZj/w8A8cOxk3eNvSt71wcXtgcc9U6VjVUaWcCMWhqCZw1dhS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183834; c=relaxed/simple;
	bh=QrrJZJAMX9KtEMw78bOC5inI5qhfnPipR9iewb2NaaQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=q+LGupCtBFDT1amCbVeDAYSeS/zkUt67LobbjCSABfas3blSO755rMLmDW80ggMbIx68Qx299YH7wYzarYSxS9tLf9AA5CIL29HtdXKE4C+lOobPeUQvk2kMHT8aJefpqZxDegCtABtUX1ckRX3GkGIs3djA45PELR+8cCZxMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JPCmuPeP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D+5GmaJXZT5l+1wfRT+lAuNHUWIAAutwCYXRr+Clwac=; b=JPCmuPePd7jTYiDqDPokBnue46
	/9xMdoIUYYDcVPJ05GeL1wPwv7vD7p4UIFjcfxdyBdJW8TY+rnBurXP4Ojaskp1ARp9fFUb+/zwBs
	YYK44ibenMmQ8C3PoShh5YHSxA4v5X17S2LQvqn5OAaLuDvLypzvzTGYCftG6RM6Vm1ebyEB/nG3t
	4nWxVpDSd016hRl9Fid8HKe64fMgmIJUG+dLkb9slFLpX5G6uZQdnSPn5AmobsiMB6AXi/iE8oQJR
	HIsvK9i6PYrZ+473VHiS8OJGqxTOFVovHt04pSKV+pwkbZ2DlR6WnGX4t4gEGzyPgEd73jJhcnUZP
	hEm+eEyg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48962 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1thR9z-0006R3-2P;
	Mon, 10 Feb 2025 10:37:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1thR9g-003vX6-4s; Mon, 10 Feb 2025 10:36:44 +0000
In-Reply-To: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
References: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v3 1/3] net: phylink: provide
 phylink_mac_implements_lpi()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1thR9g-003vX6-4s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Feb 2025 10:36:44 +0000

Provide a helper to determine whether the MAC operations structure
implements the LPI operations, which will be used by both phylink and
DSA.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c |  3 +--
 include/linux/phylink.h   | 12 ++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 214b62fba991..6fbb5fd5b400 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1957,8 +1957,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	pl->mac_supports_eee_ops = mac_ops->mac_disable_tx_lpi &&
-				   mac_ops->mac_enable_tx_lpi;
+	pl->mac_supports_eee_ops = phylink_mac_implements_lpi(mac_ops);
 	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
 			       pl->config->lpi_capabilities &&
 			       !phy_interface_empty(pl->config->lpi_interfaces);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 898b00451bbf..0de78673172d 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -737,6 +737,18 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 	}
 }
 
+/**
+ * phylink_mac_implements_lpi() - determine if MAC implements LPI ops
+ * @ops: phylink_mac_ops structure
+ *
+ * Returns true if the phylink MAC operations structure indicates that the
+ * LPI operations have been implemented, false otherwise.
+ */
+static inline bool phylink_mac_implements_lpi(const struct phylink_mac_ops *ops)
+{
+	return ops && ops->mac_disable_tx_lpi && ops->mac_enable_tx_lpi;
+}
+
 void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
 				      unsigned int neg_mode, u16 bmsr, u16 lpa);
 void phylink_mii_c22_pcs_get_state(struct mdio_device *pcs,
-- 
2.30.2


