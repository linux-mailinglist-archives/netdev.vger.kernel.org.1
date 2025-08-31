Return-Path: <netdev+bounces-218566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7982B3D488
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE801894389
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404D21E0BA;
	Sun, 31 Aug 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="raf7rJg1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233E18CBE1
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659719; cv=none; b=oMSGskEzQJYN7GrBh1wGBWMRFyTRNsZzcd1vWdPvEAXxzE+qiWqNFurZanmu+7h96hsqBqxdiMwYVpsOT9GQD56FYutZaeLecRNSCiHJVLDYBA/ZVCsgIIHxppp2WjG5nXquaAvXDrWMagBm0oPtygbvsNz9exCuilWblG+x0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659719; c=relaxed/simple;
	bh=bQ0ZiWd2bp/7FWq8A5htgu0Cp+YX6mOn9S7YYgs48EM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=taN7EIC2WzWbpjRYW73jKxqo+kFuUDWlbuB/QhmbqhK1zntXKbjef/N3iBak4IXGknh/0D4BJTIfCRzx7mXU/79NJu90ffEuAjsxFE9aM2ISO0hjYxWa3CwEP9Q95TSTjb1UZUKLHW3AiRoZJoqi5ae3OQhJWhkNxNPoVB9BrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=raf7rJg1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ck3+VazGE4NZygvTC3QIoJVOltvnFU4nN07qmFlqCdQ=; b=raf7rJg1v0oEVf6cc7cbQgnfW3
	lKBTNGnZl5TSAxHUkofkiJrkZLF9meB3xbDvpqzagtOo69t8fmDJBDb0sXFdQqBKzuvCWosZLWx2Y
	gm+gFW27ll7zYtlwakLFzRTudnUPH5f5Q3lKICKaRvYfluxuTxzLcCzlvrIVKcl15PsotA/9HPpd8
	bZJ6LBEVyEgUAZYwsZozvYfbN+pD/FwzmaTq3sJEK+UeZ98v7hV1RcDVEPUqUaofkkYPWlkLz1sQ+
	199nh6DYhsZ+lqS6mMycd3G8so5O5ql1arLUjEsU5L1qvxU1VUDZLBMbjrj6w2A8WaXVDwHYJdtTJ
	UMZMuH2g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56872 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uslRB-0000000056f-1Xy7;
	Sun, 31 Aug 2025 18:01:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uslR9-00000001OxL-44CD;
	Sun, 31 Aug 2025 18:01:52 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: mvpp2: add xlg pcs inband capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uslR9-00000001OxL-44CD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 31 Aug 2025 18:01:51 +0100

Add PCS inband capabilities for XLG in the Marvell PP2 driver, so
phylink knows that 5G and 10G speeds have no inband capabilities.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
The lack of this patch meant that I didn't see the problems with 10G
SFP modules, as phylink becomes permissive without these capabilities,
thereby causing a weakness in my run-time testing.

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8ebb985d2573..35d1184458fd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6222,6 +6222,12 @@ static struct mvpp2_port *mvpp2_pcs_gmac_to_port(struct phylink_pcs *pcs)
 	return container_of(pcs, struct mvpp2_port, pcs_gmac);
 }
 
+static unsigned int mvpp2_xjg_pcs_inband_caps(struct phylink_pcs *pcs,
+					      phy_interface_t interface)
+{
+	return LINK_INBAND_DISABLE;
+}
+
 static void mvpp2_xlg_pcs_get_state(struct phylink_pcs *pcs,
 				    unsigned int neg_mode,
 				    struct phylink_link_state *state)
@@ -6256,6 +6262,7 @@ static int mvpp2_xlg_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 }
 
 static const struct phylink_pcs_ops mvpp2_phylink_xlg_pcs_ops = {
+	.pcs_inband_caps = mvpp2_xjg_pcs_inband_caps,
 	.pcs_get_state = mvpp2_xlg_pcs_get_state,
 	.pcs_config = mvpp2_xlg_pcs_config,
 };
-- 
2.47.2


