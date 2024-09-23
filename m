Return-Path: <netdev+bounces-129317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B797ECC2
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1681F2225F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654119DF7D;
	Mon, 23 Sep 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wGe9GIK1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44419D098
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100121; cv=none; b=HgIIVMoLcGHFlwUpDQxLAY/GvMjKHaZ9eZtcgX5aupbyO6DjS0+oGosN2UQKBqn+iRdbD3kebWV4itR36jQaOmcjmGasCw73Q7ZUDyoRhx/PNA+zenbXmAXaUy/7NOtAnas6fpaUucbAwD021B61RdRAXBZbDwCl27CEB9W0DZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100121; c=relaxed/simple;
	bh=53KOB7Rz0K8CZNMQtowYdfJyOc0kVU6V5c11QdTU3I0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PIwV/1Q2zLhP/2MKj4I/lhTXGdMXcrUEri50R21MLIqpAvpbpQJG8pO/lFFS+8IHdp5AUCmcR9cUYua+BvkcKD2nwuysds1NZYVxLYrq8382sMGPEfV+a8UZwMaNLqIOc2l/kBgHn/SMHckm9IUm5PpNvgej2ZUzQM6yt1iTpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wGe9GIK1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bY3z2RcnlrW6NZx3SjF3mc/qDdc0FOQ37w3w0FJ6+a4=; b=wGe9GIK1sV6Ljq2Gau4H9zeNbT
	tlTnAJLU87GjtZgejJky7K6jNwNX5CwVvCXFL41KyzTIJJ+xEKbgkr8ePpB0XBzECzsYvu2SOzCTE
	35nXUfQYwGKDtIcX+xMizyebX8MIetBGcFmUNfqXdqu5sjDsnBUECKijeg2z2BTUaJF7QLL8KeOLY
	Z9HGz0r6te/rucQFkwVUsDOH+Xer/qP+rGEu1kSnnU4+Q2wosdZNTGTsuOMhxqclVAIn03DXY6jBe
	/nQuyvqRNIOAsOncvomnBnCLk40iWuL3la2j9TO3xYAM5RDG8smipALG1d2J14qNimYNgfTMbCGRQ
	vmUL4Yaw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34902 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjdM-0004Jb-2R;
	Mon, 23 Sep 2024 15:01:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjdJ-005NsX-S8; Mon, 23 Sep 2024 15:01:45 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 10/10] net: pcs: xpcs: make xpcs_do_config() and
 xpcs_link_up() internal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ssjdJ-005NsX-S8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:01:45 +0100

As nothing outside pcs-xpcs.c calls neither xpcs_do_config() nor
xpcs_link_up(), remove their exports and prototypes.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c   | 11 +++++------
 include/linux/pcs/pcs-xpcs.h |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index f25e7afdfdf5..0a01c552f591 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -851,8 +851,9 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
 }
 
-int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
-		   const unsigned long *advertising, unsigned int neg_mode)
+static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
+			  const unsigned long *advertising,
+			  unsigned int neg_mode)
 {
 	const struct dw_xpcs_compat *compat;
 	int ret;
@@ -905,7 +906,6 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xpcs_do_config);
 
 static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		       phy_interface_t interface,
@@ -1207,8 +1207,8 @@ static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
 		pr_err("%s: xpcs_write returned %pe\n", __func__, ERR_PTR(ret));
 }
 
-void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
-		  phy_interface_t interface, int speed, int duplex)
+static void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
+			 phy_interface_t interface, int speed, int duplex)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
@@ -1219,7 +1219,6 @@ void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (interface == PHY_INTERFACE_MODE_1000BASEX)
 		return xpcs_link_up_1000basex(xpcs, neg_mode, speed, duplex);
 }
-EXPORT_SYMBOL_GPL(xpcs_link_up);
 
 static void xpcs_an_restart(struct phylink_pcs *pcs)
 {
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 758daabb76c7..abda475111d1 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -65,10 +65,6 @@ struct dw_xpcs {
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
-		  phy_interface_t interface, int speed, int duplex);
-int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
-		   const unsigned long *advertising, unsigned int neg_mode);
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces);
 int xpcs_config_eee(struct dw_xpcs *xpcs, int mult_fact_100ns,
 		    int enable);
-- 
2.30.2


