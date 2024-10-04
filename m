Return-Path: <netdev+bounces-131963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E89900C7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8211F23178
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598D14BF8A;
	Fri,  4 Oct 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="On19GnzH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787D14BF97
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037277; cv=none; b=QNNof76f4tx8wh4Dbmc52TCHbHtXqZtZsiS4ta2w4ET7CbzMLxLnO+uOTNl/DAPNEFKTFl1dELqb+tIpO+dcO1tQmOt35BHv1wL4lVKXK8YNo9lWRoQedGBI5ze18Cg3OSesdKGkIpD7T9/ydIkrxineqqtwnygcfFm9Ec/lO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037277; c=relaxed/simple;
	bh=mZTLRd1la8SV4EzWLdN3AstdSp6+nuAlPC2ZHN3Yeck=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=AFgHBb0bXUy/MuokFPFsoxJVRaZj3jdnwF7p1TRo67tmZS7BfGLg7i1TKV9OuFIKup+G3KmNfW+lHHN8wnzGX6mgIbBbCvmaiIqTXAneEk3VEZ4YAA/bbBYlYIRmIZVoyCP0VFCiWMftPmayc7hb/VMXzdJWDZH6mHDzpmkQiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=On19GnzH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ohWG0r7paqKLARJ0HLIf2BALfXfBnJ2YtdHxdpM8IJQ=; b=On19GnzHYHH4/04lL9T2d2Ptd4
	BV7luodr+/skt1VeQ1yQmcOGeuvifvZlNixmQnChrahC7mkOXfdSkYnrHzT+lTFThJrfJ/tPd3WFm
	ZF8JhFYMBYVhGHhWGcDxzpxMFwRONI/KPHQd/bopBz30DJ9X444tdpyCMgQ7bm/qWtFoZu1X+1Kbo
	JIfr5UK7bGN7gyNEIaDTkifwBA4OQJ5hd16XupAaPSzPIDQXq8wpEuB7xIsBxz51hQWRCv0L25W4S
	ebhsk/XGM4dsNwvk6nlg/nfRXrMFChRFMEJmTWJq6BKVsW3WnAGs+blpO+NHQwJVEc4QAhext/LQ2
	GKXUUvsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39954 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfQh-0001gZ-2y;
	Fri, 04 Oct 2024 11:20:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfQe-006DfI-Mj; Fri, 04 Oct 2024 11:20:56 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 04/13] net: pcs: xpcs: provide a helper to get the
 phylink pcs given xpcs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfQe-006DfI-Mj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:20:56 +0100

Provide a helper to provide the pointer to the phylink_pcs struct
given a valid xpcs pointer. This will be necessary when we make
struct dw_xpcs private to pcs-xpcs.c

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 +-
 drivers/net/pcs/pcs-xpcs.c                        | 6 ++++++
 include/linux/pcs/pcs-xpcs.h                      | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 83ad7c7935e3..48acba5eb178 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -451,7 +451,7 @@ static struct phylink_pcs *intel_mgbe_select_pcs(struct stmmac_priv *priv,
 	 * should always be an XPCS. The original code would always
 	 * return this if present.
 	 */
-	return &priv->hw->xpcs->pcs;
+	return xpcs_to_phylink_pcs(priv->hw->xpcs);
 }
 
 static int intel_mgbe_common_data(struct pci_dev *pdev,
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 8bde87ab971f..a7f6d56183a7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -132,6 +132,12 @@ xpcs_find_compat(struct dw_xpcs *xpcs, phy_interface_t interface)
 	return NULL;
 }
 
+struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs)
+{
+	return &xpcs->pcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_to_phylink_pcs);
+
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index abda475111d1..868515f3cc88 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -64,6 +64,7 @@ struct dw_xpcs {
 	bool need_reset;
 };
 
+struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs);
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
-- 
2.30.2


