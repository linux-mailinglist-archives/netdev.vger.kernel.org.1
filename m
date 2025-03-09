Return-Path: <netdev+bounces-173317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D8A58546
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A37C3AE0B7
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E01DC9A7;
	Sun,  9 Mar 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V0LDMxA9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F91552FD;
	Sun,  9 Mar 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532574; cv=none; b=LWcVfFmaOlzZ6uvvo8ro+kKQl1jZdN4MY6+1kRGqx1TDcJcLgUe6tQAck0UGqbmRlHf+mb6KuDBgurTM7WL/nwMDjdU2GComc+a0fiDZeh7qrz0X+1Pl0Djk+MdMVVKB+DGvoJxaUNFZb/K4cZQmkwR1GGp2okNXN49dPXGwuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532574; c=relaxed/simple;
	bh=1kwvq2NYsuuJrxWJlRvbnJSoaTQgLxL3w17Tfmkb7ic=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aypmXahrrAllCKk0rm+E5uNyqRayJWxkjYksWRHBBrFCWYdmyQNVgS2F2aFv7tjvkiUwjCvwxZIGRRKTnq31TITqlbjLqJ0IvNADOUHZbLvtRIO3SSILfxHpVx9Gg1ONrfDr5wRfX0kdu0ARmGFDmbP8IZXJCQmo8W0iRwp49Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V0LDMxA9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=coDruLhzUwUWr9PQ9J/pkDgkm+WduLU7r2hwaAyS0V4=; b=V0LDMxA9XXnN23KO23D3IVotVM
	cEPL32OqeRxlXdXp7d4LH9bdhDJskMizXu0Nim7EZ9rlBmdJ8ouT6pnKAD8I/qiZ8CDEPw/+hQAoa
	2QxYbL8nky4i36uULsWeUazSRrLabCw5IXQ2dl9a/UsML7jo8up0Or1455yPxtL8ZKiFoF2rCEtW8
	TTFkUsz0bM1RR/9dJa/iMbg9einjoxtWw9jUfH8Os+x9GyscTG825Rlix5sgWnNBeeb1skUv8wibK
	bHpp+B1B0f/2gjM3UE0GEyyxNZwymji0DwcLnXsyGAcKptUIlxZDJXP4JGz62IBBh4wj6KjhxYbMX
	LveXY4zA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41688 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trIAr-0001Qu-0Z;
	Sun, 09 Mar 2025 15:02:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trIAV-005ntu-7r; Sun, 09 Mar 2025 15:02:19 +0000
In-Reply-To: <Z82tWYZulV12Pjir@shell.armlinux.org.uk>
References: <Z82tWYZulV12Pjir@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next 7/7] net: stmmac: deprecate
 "snps,en-tx-lpi-clockgating" property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1trIAV-005ntu-7r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 09 Mar 2025 15:02:19 +0000

Whether the MII transmit clock can be stopped is primarily a property
of the PHY (there is a capability bit that should be checked first.)
Whether the MAC is capable of stopping the transmit clock is a separate
issue, but this is already handled by the core DesignWare MAC code.

Therefore, snps,en-tx-lpi-clockgating is technically incorrect, and
this commit adds a warning should a DT be encountered with the property
present.

However, we keep backwards compatibility.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8dc3bd6946c6..c73eff6a56b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -497,8 +497,11 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->force_sf_dma_mode =
 		of_property_read_bool(np, "snps,force_sf_dma_mode");
 
-	if (of_property_read_bool(np, "snps,en-tx-lpi-clockgating"))
+	if (of_property_read_bool(np, "snps,en-tx-lpi-clockgating")) {
+		dev_warn(&pdev->dev,
+			 "OF property snps,en-tx-lpi-clockgating is deprecated, please convert driver to use STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP\n");
 		plat->flags |= STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
+	}
 
 	/* Set the maxmtu to a default of JUMBO_LEN in case the
 	 * parameter is not present in the device tree.
-- 
2.30.2


