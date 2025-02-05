Return-Path: <netdev+bounces-163015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3752A28C0E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73491889CF5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDDF14A4FF;
	Wed,  5 Feb 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OdP9VR1n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C013B791
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762849; cv=none; b=mA0ATLXqx0HA9yXtoNohXIoq/6TGYC9CgwzVic8T7W0g4TjnY0zMMlx2tkpLekorrtLNYM2RFe2LkFXKCvwXp6MiCg5dDTwNxSXUWe5ebhjznqju3GqaVBrPkkiUkogln7VCy+VWIQQioQLH3j0p50pZ/TvyrzguRK2fpcZwDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762849; c=relaxed/simple;
	bh=XZYVx6PZcu1Pdwx7uT/YzDHmiHzac1cx2roXT9imieE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oES9TqLwplQtTLg9wSCMAXq8uv4Z8iZpur5hFX0OSUtT/BojObuWmN9YYvDQXTBuVCUTCuM5C5Hc+gDe1v3yloQRUZ6kPVbqoX8D9D6x9RTQCdLnrfdtlmuq+myPyQbE1Dab4LhFMoY0mnZMxtdK972KLChtPjd++fCISgqwfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OdP9VR1n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VqQ9wOEeNNoSXc7LFs7yK01bxEBFYf/myvKZXQahAvs=; b=OdP9VR1n3lyYx8tbk029AvOhUM
	4+8N7SDwhuYRZkItwrwvjBS/bcJO8xN12H1pLf0NL+TnzZ9SmPqL4lREYvmEHurBEvB4TQigTlwaG
	wwfW/u2zUrdM8yGhlq2OIy3rkskjw8hdMfpPiC5ngmKpOAvUPvS817I+vrLz0gr6n8lft9VHd1JpJ
	r0685XRvvdrRq8f62tdxeVyJojCOdo5e9OQ/wIzme8h0eJNBNdkeeB/DERxB53/9Odl39tUVljUHk
	jR9srBQ6C668XhoWv36FGedEZ11b4dWRUlVQGTnd1elYUTY9vMCK1O+KhkJtnbNV6VoeelNbEJDdz
	LL8arbqQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60764 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdw-0007Bg-2E;
	Wed, 05 Feb 2025 13:40:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdd-003ZIB-22; Wed, 05 Feb 2025 13:40:21 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 08/14] net: stmmac: clear priv->tx_path_in_lpi_mode
 when disabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffdd-003ZIB-22@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:40:21 +0000

As other code paths do, clear priv->tx_path_in_lpi_mode when disabling
LPI. This is done after the software timer has been deleted and
hardware LPI has been disabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 695e75de41b3..3cb5645673cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1052,6 +1052,8 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	priv->eee_sw_timer_en = false;
 	del_timer_sync(&priv->eee_ctrl_timer);
 	stmmac_reset_eee_mode(priv, priv->hw);
+	priv->tx_path_in_lpi_mode = false;
+
 	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
 	if (priv->hw->xpcs)
 		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
-- 
2.30.2


