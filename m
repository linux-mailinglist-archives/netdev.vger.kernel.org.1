Return-Path: <netdev+bounces-170307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB148A481F3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A8A188AD11
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9F231C87;
	Thu, 27 Feb 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rtYJnuXr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A372327A7
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667099; cv=none; b=JSwY5ivQauy1AUh3AolhW8G+MLIx9vjLogeog8OHck7anZDAGFn0/zbeFzWuaqNfYIaD7/dBdOIfw1EFgNF5ZTGXgpJqPuHsH14+P2+ttRix7Ng/yGwFMOX2zIZd1Cn/z5qdCSiVFFTQUlCfjkygAjutqtjjpg4H2OdvXXRENaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667099; c=relaxed/simple;
	bh=X3LEIWki61ECSp1P06xAjGQXbK0dTbWaVnwh2syWoC4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NB3qyOoiipQCiSxyLVwel2zPpx2QzYYPNvWtXH+ps8a7dsi3Fm3oUNv1hVDihpnc1bksdl4GKxwN6Gt7ggTqTq/nvrxRRbP4MPg4bPaOgK4mvgF6IcXzjfuROE/Fmx6IQTAsXN0VJ/oJE8xv8aDU+C/8hWa9sHVQDhGVoTicuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rtYJnuXr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p1D8n6sAJQ7YC/Q50BthGw8wcmOYNk6MxTkRcRqV4ZM=; b=rtYJnuXrIe0AQCnCJTGaP+rbsD
	2pSTyrwH8a81FCamY6OfDZeHuTfe/4E0UBMj/qAeg9m6r00Q0hkXDhkAdwPIRVNUU/47h8G62AS/G
	FLJ9w/VPZ9XE336PNBWVn28tbetb6QvKIn/AJPnH8MmWOOpPy/snEUrpB/e0vvCicRsay2AxTI/eF
	ql1EcppUEMU+IStB7BNwPmEZ1fRkCVyqLK092zIkHVi7UYFagnsIQ8DDeGVk1xto4Ibm0G1FLBCyB
	4fhGDbCQ7ghIRdlfM5wCubpDrcuU+JnNLojCX0HGeU5V9/Hzrx9a7/sdSYEiLRsaTCd2bVcXEkCWh
	acPTN1Kw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36794 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tnf1b-0007QA-2x;
	Thu, 27 Feb 2025 14:38:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tnf1H-0056Kz-To; Thu, 27 Feb 2025 14:37:47 +0000
In-Reply-To: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 1/5] net: phylink: add config of PHY receive
 clock-stop in phylink_resume()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tnf1H-0056Kz-To@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 14:37:47 +0000

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a3b186ab3854..0aae0bb2a254 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2264,7 +2264,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
 
 	if (pl->mac_supports_eee_ops) {
-		/* Explicitly configure whether the PHY is allowed to stop it's
+		/* Explicitly configure whether the PHY is allowed to stop its
 		 * receive clock.
 		 */
 		ret = phy_eee_rx_clock_stop(phy,
@@ -2645,8 +2645,22 @@ EXPORT_SYMBOL_GPL(phylink_suspend);
  */
 void phylink_resume(struct phylink *pl)
 {
+	int ret;
+
 	ASSERT_RTNL();
 
+	if (pl->mac_supports_eee_ops && pl->phydev) {
+		/* Explicitly configure whether the PHY is allowed to stop its
+		 * receive clock on resume to ensure that it is correctly
+		 * configured.
+		 */
+		ret = phy_eee_rx_clock_stop(pl->phydev,
+					    pl->config->eee_rx_clk_stop_enable);
+		if (ret == -EOPNOTSUPP)
+			phylink_warn(pl, "failed to set rx clock stop: %pe\n",
+				     ERR_PTR(ret));
+	}
+
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
-- 
2.30.2


