Return-Path: <netdev+bounces-151862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C973C9F15FD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E8528318E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64B1E8854;
	Fri, 13 Dec 2024 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gXynTGLQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE118027;
	Fri, 13 Dec 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118516; cv=none; b=V7B4MA+c07IqiNDEGXmWk/pATv53k6W2upuqKkVH6+iOCXfaHMlu7d9Cah0PC5/cph91nXrzm/lfBm8mEibzHhnRWSmn3UKfqD5x7piavQWKXh+AlKVt5vdOeJv2er5QIO+AQ56v/zZxFfxzGz/RelhXwdr48Q4C/iM2o47pL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118516; c=relaxed/simple;
	bh=di1JRxgla85+qVuKC7qR3d6Rx2bf65mfYztSCcJI+FU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KMWl1VPEUn5rjN2xL/f1V0CCMXPntCP3RhdwkdihfOq5BdUUY70BMz8u/JtYysZxJzBxNIyi3HtC+j5StubSAB5FSO82uR3Y4UCUOhLFPDXZxuwJHpISdm+37gl34/yQyaKc9ZSPx5JJx6z5cXwoqav610BXF+IwtacgHegiKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gXynTGLQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GnGNXV9fY/OFbdFo3uaZITHwcc9v08Tzd5HOpCpKxEs=; b=gXynTGLQlPgMUDTLLkWjpq8Ph/
	qR4YyX4amMJGOqU7fQTxDkycDxFyDm1QcTrsGhYa0bfi9sl1r3bMwM+/nA5N1bkTfr3rQjfJxz/mY
	nolrEDppVWX45eTjXRTsM3gDNrTwRiBGHBsNRK8Ox6KFU3pSv511WhQ3PMj+cReLkHyKJ6SArutqn
	Mo3OyxJiCa7QRozYfJvqVKz5/LqqZvxIm1Iiu6j1wCW7OfgpEZuZWTFiaGJVzzqs39t0nySMMJBna
	EhZBJaXTn7SK4AhZDkvIJ6yE6AoS9XMcgiFOCL6WuU/XLKucwuNuXPIVQA3oyXDdbzYwuUCc6dijC
	VMv2DMhA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32860 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tMBRI-0007Db-0x;
	Fri, 13 Dec 2024 19:35:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tMBRF-006vae-WC; Fri, 13 Dec 2024 19:35:02 +0000
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
Subject: [PATCH net-next 3/5] net: pcs: mtk-lynxi: fill in PCS
 supported_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tMBRF-006vae-WC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Dec 2024 19:35:01 +0000

Fill in the new PCS supported_interfaces member with the interfaces
that the Mediatek LynxI supports.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 7de804535229..1377fb78eaa1 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -306,6 +306,11 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 	mpcs->pcs.poll = true;
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
 
+	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_QSGMII, mpcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, mpcs->pcs.supported_interfaces);
+
 	return &mpcs->pcs;
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_create);
-- 
2.30.2


