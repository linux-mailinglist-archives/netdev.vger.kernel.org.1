Return-Path: <netdev+bounces-151861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D69F15FA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D6188CACF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D111EBFF7;
	Fri, 13 Dec 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xummMPIN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9A18027;
	Fri, 13 Dec 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118510; cv=none; b=hdO0kuw6hBtBEfcjiILUL38spMmyY/esj3UE9buoYDDzSxyMREebkcZMNSSTZKrbpY5HBhxjKhdLYug041dg65u32c+D1bO77xqTSAvQWMHnGJD3ZguyOXrnu4gb9cUyh0pqEAkN8nA4sZf0TIhVnheSufLF4bsI7pst38NLxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118510; c=relaxed/simple;
	bh=mALPe8IHVvSk7t9f5SohClfyeGvzRb8hUiyxNJmToqY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LX71K0JL1NdZqpq1QRlPnfN/+lwDhMMIyZFdUSTJUYtykCCCTvAW5eUq0p0oPTUaXqIyQFiEnbQZs/MVdIcnxhYCnTswsj2J6B1rVSguCitvexydz5M529oj+PHIb4tXebYho08ihlOZqIWMhQtTEmo70L37pupb/DAKDnDCBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xummMPIN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pnbzjYFJC7QCn5g6ZiNpVxr72nno0JcTQWP0iYxpqpc=; b=xummMPINdqRamBjSov0p819TXB
	ALjkFaYS3mgw/pTnEHaXHZ6sc882vTo53cevOgCSHZELyZTa03evhpiJSPd866JOMDsvsx4KUTgYm
	WnLSFygA71xLrh/K73uDFmOdlif45PAgGy3OcdB8fkp/7oFwMPiADH1yroVLwyW5kaEDYLm9j76sG
	j2RyrdF9kVVR2yKr3CEFaSClAyAESPMDGPQFQ0DPYqrTcqYLlw9EbnM0DTxLb03ixoCoxKlZfy6YU
	vLPQZgnP0+bUxk2Aky78dbY84/RB1dtw/0+YwDHVho+9OMx5GY5qsCXA24nKk14hxtfLjm9YB3Cr5
	x+zTpQ4g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41828 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tMBR7-0007DA-2X;
	Fri, 13 Dec 2024 19:34:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tMBR5-006vaS-Ou; Fri, 13 Dec 2024 19:34:51 +0000
In-Reply-To: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	 Jose Abreu <joabreu@synopsys.com>,
	 Andrew Lunn <andrew+netdev@lunn.ch>,
	 davem@davemloft.net,
	 Eric Dumazet <edumazet@google.com>,
	 Jakub Kicinski <kuba@kernel.org>,
	 Paolo Abeni <pabeni@redhat.com>,
	 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	 Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>,
	 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	 netdev@vger.kernel.org,
	 linux-stm32@st-md-mailman.stormreply.com,
	 linux-arm-kernel@lists.infradead.org,
	 linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: phylink: add support for PCS
 supported_interfaces bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tMBR5-006vaS-Ou@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Dec 2024 19:34:51 +0000

Add support for the PCS to specify which interfaces it supports, which
can be used by MAC drivers to build the main supported_interfaces
bitmap. Phylink also validates that the PCS returned by the MAC driver
supports the interface that the MAC was asked for.

An empty supported_interfaces bitmap from the PCS indicates that it
does not provide this information, and we handle that appropriately.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 11 +++++++++++
 include/linux/phylink.h   |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 95fbc363f9a6..3e9960f54550 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -691,6 +691,17 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 			return -EINVAL;
 		}
 
+		/* Ensure that this PCS supports the interface which the MAC
+		 * returned it for. It is an error for the MAC to return a PCS
+		 * that does not support the interface mode.
+		 */
+		if (!phy_interface_empty(pcs->supported_interfaces) &&
+		    !test_bit(state->interface, pcs->supported_interfaces)) {
+			phylink_err(pl, "MAC returned PCS which does not support %s\n",
+				    phy_modes(state->interface));
+			return -EINVAL;
+		}
+
 		/* Validate the link parameters with the PCS */
 		if (pcs->ops->pcs_validate) {
 			ret = pcs->ops->pcs_validate(pcs, supported, state);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 5462cc6a37dc..4b7a20620b49 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -393,6 +393,8 @@ struct phylink_pcs_ops;
 
 /**
  * struct phylink_pcs - PHYLINK PCS instance
+ * @supported_interfaces: describing which PHY_INTERFACE_MODE_xxx
+ *                        are supported by this PCS.
  * @ops: a pointer to the &struct phylink_pcs_ops structure
  * @phylink: pointer to &struct phylink_config
  * @neg_mode: provide PCS neg mode via "mode" argument
@@ -409,6 +411,7 @@ struct phylink_pcs_ops;
  * the PCS driver.
  */
 struct phylink_pcs {
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
 	const struct phylink_pcs_ops *ops;
 	struct phylink *phylink;
 	bool neg_mode;
-- 
2.30.2


