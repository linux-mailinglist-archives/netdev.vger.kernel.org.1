Return-Path: <netdev+bounces-151863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17F9F1600
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E116AEBC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3B1EBFF7;
	Fri, 13 Dec 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rodsGVZV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346FF1EF0BA;
	Fri, 13 Dec 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118521; cv=none; b=nGGSjsAT5zX0/tCVq2OxfkQ3YykdHGcUVFxDbglt5d6OFI2b32iI75N2AJsNugcYHMr+qyeB4Fh/UWOrHoQfzDeR8q3sWiqwzbiDASOont7kE+0Ak4dxQTb2z8auLQwku2i5U6wEVujub1BZrwZOZIqOI9uPEDTfRA3vZe3F0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118521; c=relaxed/simple;
	bh=s9btBodUiB3cGnK0KICDoy591R3CdgCStze37OBzF7A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=J65n2LJmCLVRMznCRVYTzAbL7Ii2LJbETmH3hqUwCCvY3c/XwGcs7TJjbmv2tyXN8d6AHXYGd1tgEFOgiJ46Fwk2FX4PiKs8rFli/qUjIcPcZ7teNTFAE9z8ebmQPmJocLDv6Sm/Lyv5yY9ix9yCmUcvFhlxZDobyyI48jQisD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rodsGVZV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ABd+AOjaRP5bk7jBv3c6AzePtr2yGHsdlpUthvtnsxQ=; b=rodsGVZV6/+UQdxwu1Btu1TmLo
	NFw3yQRQ+LenklTb7E9BkZ4aQ4Tluk1/piS+Trnb984tMObnfu1pbT8hHGutS4I6vDQQ4XAXvxJO3
	NDgr9CoaF6Vj9wWSfAu6xoiV70mRh0WYvhqNK/BJbloPJTMWTG1ZZWV0lUXU5ZkWLDNToQSZTdtN+
	dlUv8TPQE6UBOmsWggIW8ixNdmhYncP6Ta7JPAKP27Tdpr/mZkTiDVzVVxl25SAUPjoiFLone+J1t
	aooOu3czXlAOg9MVeXVCgxN+xe/rtX4L3Ln6h4xpaOPhw6ODCToeF6DTW2CXkSZ3d97lM7WbsBybK
	CVdEZPig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41424 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tMBRN-0007Dw-0M;
	Fri, 13 Dec 2024 19:35:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tMBRL-006van-3c; Fri, 13 Dec 2024 19:35:07 +0000
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
Subject: [PATCH net-next 4/5] net: pcs: lynx: fill in PCS supported_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tMBRL-006van-3c@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Dec 2024 19:35:07 +0000

Fill in the new PCS supported_interfaces member with the interfaces
that Lynx supports.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-lynx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 767a8c0714ac..6457190ec6e7 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -334,9 +334,19 @@ static const struct phylink_pcs_ops lynx_pcs_phylink_ops = {
 	.pcs_link_up = lynx_pcs_link_up,
 };
 
+static const phy_interface_t lynx_interfaces[] = {
+	PHY_INTERFACE_MODE_SGMII,
+	PHY_INTERFACE_MODE_QSGMII,
+	PHY_INTERFACE_MODE_1000BASEX,
+	PHY_INTERFACE_MODE_2500BASEX,
+	PHY_INTERFACE_MODE_10GBASER,
+	PHY_INTERFACE_MODE_USXGMII,
+};
+
 static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 {
 	struct lynx_pcs *lynx;
+	int i;
 
 	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
 	if (!lynx)
@@ -348,6 +358,9 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
 	lynx->pcs.neg_mode = true;
 	lynx->pcs.poll = true;
 
+	for (i = 0; i < ARRAY_SIZE(lynx_interfaces); i++)
+		__set_bit(lynx_interfaces[i], lynx->pcs.supported_interfaces);
+
 	return lynx_to_phylink_pcs(lynx);
 }
 
-- 
2.30.2


