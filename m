Return-Path: <netdev+bounces-130941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3718098C234
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88081F26054
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F21CB50F;
	Tue,  1 Oct 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rZa45PIC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BE1CB314
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798673; cv=none; b=XOo2iGIm5Rc1vUhwTyGILJcnXBuNFeT1bnXodJK0bKmJV5nkMsQp8ND9gs0IV9lKM0Xjg/R77S3BoeuCgNw3nb8kHusm+trXBNb8wqQBM9Uisz22Pn3s9hKBv5xNfmGi/OArreiKyIrNYBvfuyX0ATrBKlh4fRjae3vB/sd80so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798673; c=relaxed/simple;
	bh=tA0qYrU9GysOFh7YatZuKYiBqfIbE15URCojk0wDFKs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Qny9av6sqwfOM32nSNia/UwUQfwMuQ01w1NFPAN7a4/KT4kh120micWpEyj/DActGzsZxFGM1QPJ4I94KJlfs73n8apiAjxaqxdprf/XmWK6UN45mUEiIETSzKk5pwAg5yBalVI2SjFh8e+Ew0sLb3hodUBIIxJWvBGyh5UWsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rZa45PIC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GgfhbirJwQyLShHHDUmwT1nOPTwLg0zxTxgh9d2blI0=; b=rZa45PICuvvUtmMJcptq+KXDJv
	Sn+uq7heKi3UnM1ynm1liEdE2H6o/w5RS7gdlE1v9nZ30eayDSuagVqxhvGnWNGEDBg2yBzrX95SG
	wj202KIyIqNM+bnKx19M0T1So/9uZ49173QtAgqQxSs6FGMt64kJx15PoGXLoPyK4h6P7rEzpYevs
	7tRIv/kpmcnTJvQHcumKDGNaEDa4tUcoQRzDUgv3Ha8t4Bp9PVEb0k8iMVtjm2gXO38wllF2hMZa4
	JZMpCm2MVhCUM8HWFxmZLSYDZ9wejTbzGy7Xkbe561QTMOJqvf1q7EibQ/Sh15xwwT5JW/EVKT9O5
	GADzzr/Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34708 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1svfMH-00065K-1y;
	Tue, 01 Oct 2024 17:04:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1svfMG-005ZI9-3k; Tue, 01 Oct 2024 17:04:16 +0100
In-Reply-To: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 02/10] net: pcs: xpcs: drop interface argument from
 internal functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1svfMG-005ZI9-3k@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 01 Oct 2024 17:04:16 +0100

Now that we no longer use the "interface" argument when creating the
XPCS sub-driver, remove it from xpcs_create() and xpcs_init_iface().

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 7c6c40ddf722..2d8cc3959b4c 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1483,7 +1483,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 	return 0;
 }
 
-static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
+static int xpcs_init_iface(struct dw_xpcs *xpcs)
 {
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs->pcs.poll = false;
@@ -1493,8 +1493,7 @@ static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 	return 0;
 }
 
-static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
-				   phy_interface_t interface)
+static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 {
 	struct dw_xpcs *xpcs;
 	int ret;
@@ -1511,7 +1510,7 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 	if (ret)
 		goto out_clear_clks;
 
-	ret = xpcs_init_iface(xpcs, interface);
+	ret = xpcs_init_iface(xpcs);
 	if (ret)
 		goto out_clear_clks;
 
@@ -1546,7 +1545,7 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 	if (IS_ERR(mdiodev))
 		return ERR_CAST(mdiodev);
 
-	xpcs = xpcs_create(mdiodev, interface);
+	xpcs = xpcs_create(mdiodev);
 
 	/* xpcs_create() has taken a refcount on the mdiodev if it was
 	 * successful. If xpcs_create() fails, this will free the mdio
@@ -1584,7 +1583,7 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
 	if (!mdiodev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	xpcs = xpcs_create(mdiodev, interface);
+	xpcs = xpcs_create(mdiodev);
 
 	/* xpcs_create() has taken a refcount on the mdiodev if it was
 	 * successful. If xpcs_create() fails, this will free the mdio
-- 
2.30.2


