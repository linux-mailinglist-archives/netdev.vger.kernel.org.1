Return-Path: <netdev+bounces-147373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E39D946B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15551643C4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0781C3050;
	Tue, 26 Nov 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="12TN4zo5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE61C4616
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613145; cv=none; b=FbjIE9mSCTyL/5mpncY1TwAGhPBoNEct1VOJj3kcJXG5VIDzBAAPqEAtZud5UbltFfYIGl6B0iydWmvYCkcf8zAeI33QkfE8MTCQk4bSk/wch1nrBAKiudsn5/rf4rSh8bFjhLIoIl8Vx+YkDCm4PgEPYooZEp3BdAGT61Nj/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613145; c=relaxed/simple;
	bh=Os4VsgzXjBhPZmUspXh/221AhUe6eUkXlatUL0yIKMU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ri2LUNUYhvF1ltsY09KVRdn6nIffrUgysK6EKT4Quy1w2NBkbRc3so39rtFpvq77OlBWyenM8bSBEhBVR81862mwYpDAE9B/0mwlM9GhJhaBgMpMNug8ToT+Cvid8Grkw1dndFkkS7yGtzfo0pSa/Ky85UtCHq46XXo9lwpld6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=12TN4zo5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qeEQYmHFBqqeSJrmP9qmqrphebl43pVxJVKiNxT2TKM=; b=12TN4zo56C06Has6SuhG9dq6i8
	jdFY2+qKj/Lnr5TlqMu8AJiA8Tys8naY/sxIMZgRRw0NYWJYLzekXJ8SAcSpXzlSc7BL7khiVNcbG
	5aQQiZKirC/z5/aDUJrgYPzzpGG/MQzt+dlV/P9q45OKiMqQ/W6SqZe1FCbeViIE+QGZfxnjfDZ8g
	1b+wtHfxE+XSUWHEyOT01IeLUkSiHVnI0wDRy4QVZLeiwOqXttfv2uu2Qc1HhUmMLGF/KC10AjIBv
	oPgWbjTY23DXEGgJS/esEt8ft4/XjRuxX4xNSfM1yzlclnGXNYKKYVJ5grKPH9dyiLhPT1El+8hm5
	dt4dsFuw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59992 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFrp2-0006W6-1W;
	Tue, 26 Nov 2024 09:25:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFrp1-005xQw-2y; Tue, 26 Nov 2024 09:25:27 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 14/16] net: pcs: xpcs: implement
 pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFrp1-005xQw-2y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:25:27 +0000

Report the PCS inband capabilities to phylink for XPCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 7246a910728d..f70ca39f0905 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -567,6 +567,33 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 	return 0;
 }
 
+static unsigned int xpcs_inband_caps(struct phylink_pcs *pcs,
+				     phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+	const struct dw_xpcs_compat *compat;
+
+	compat = xpcs_find_compat(xpcs, interface);
+	if (!compat)
+		return 0;
+
+	switch (compat->an_mode) {
+	case DW_AN_C73:
+		return LINK_INBAND_ENABLE;
+
+	case DW_AN_C37_SGMII:
+	case DW_AN_C37_1000BASEX:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	case DW_10GBASER:
+	case DW_2500BASEX:
+		return LINK_INBAND_DISABLE;
+
+	default:
+		return 0;
+	}
+}
+
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 {
 	const struct dw_xpcs_compat *compat;
@@ -1306,6 +1333,7 @@ static const struct dw_xpcs_desc xpcs_desc_list[] = {
 
 static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_validate = xpcs_validate,
+	.pcs_inband_caps = xpcs_inband_caps,
 	.pcs_pre_config = xpcs_pre_config,
 	.pcs_config = xpcs_config,
 	.pcs_get_state = xpcs_get_state,
-- 
2.30.2


