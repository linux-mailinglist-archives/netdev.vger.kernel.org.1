Return-Path: <netdev+bounces-239514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5CBC69082
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B6F9F2AD51
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38A3254AB;
	Tue, 18 Nov 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jhYjBCC+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E934B410
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464691; cv=none; b=lY2hpA/yvHUbK0clSWrG87eWw90bC5d8c8F2nvdDz7mOVM7YZB26NW4zYchMTJmnPwvn4NqbKw5bee+ZcSq1PcQecv9oE/U/3zBt+QhJwyUM0ZxZcquMfE0Sq/YcMIaVvOAfhLnjb7J3bagC2GlpJgP4V6vnsy1EGlthD7UvwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464691; c=relaxed/simple;
	bh=QRHp+DsGTm8b5PvkICjRrpHlNWDxvoVOz4LnUfqhxVU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Y45blLjc53ZOEMm+1lsT8/DwfrY7wsyOWAVEJQfO1kNty9kw9iTX7TeVY8xuG6IgOy6vlYB90M62KHu5YSHQOmZ8B+qM3KQPVlotW9aZbGzbPkimvHy+kC7OFCbE9fKVRKEcnLWIGVuEyqsFyiGVJz3zzNUaNlHsYp0ou+hPGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jhYjBCC+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gw2RAS9z2/AKPOpj9C3KeuA6m32UimKQaTe/G+VHdaE=; b=jhYjBCC+RZJsFwpImZv35aSNd7
	7DgFCeD6yzUJOdWGMUH+2zB3A1lOU7gmkGVDf0PLk/Fn5vUunP7N/SRT4cjW9yixxIc/YHxAQpqhX
	zr1XCrRxmhT+2dQZspqPSWGGt5hC6OHdBdyJRS7swVA8zBSXT1KpMFgi4pOAjrTxumlQTcWWZTAh1
	JJnWfV3ujDvz4SMtsmO1C2Whk9wRc6TxhmWT13xGDDn7p2Ah1h88fMTughel8iUPB+fkv8Dr2OAzX
	CombRCgVYXTyWhvpsLVVlyw/DfKBYdxgdn3yq5dv7houpuLPfe05MUii9U2woqG34NzAwzaU7iyn1
	Yib9ydsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57464 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLJik-0000000039I-2tXE;
	Tue, 18 Nov 2025 11:18:02 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLJij-0000000ExKZ-3C9s;
	Tue, 18 Nov 2025 11:18:01 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: dwc-qos-eth: simplify switch() in
 dwc_eth_dwmac_config_dt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLJij-0000000ExKZ-3C9s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Nov 2025 11:18:01 +0000

Simplify the the switch() statement in dwc_eth_dwmac_config_dt().
Although this is not speed-critical, simplifying it can make it more
readable. This also drastically improves the code emitted by the
compiler.

On aarch64, with the original code, the compiler loads registers with
every possible value, and then has a tree of test-and-branch statements
to work out which register to store. With the simplified code, the
compiler can load a register with '4' and shift it appropriately.

This shrinks the text size on aarch64 from 4289 bytes to 4153 bytes,
a reduction of 3%.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 26 +++----------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index c7cd6497d42d..e6d5893c5905 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -84,29 +84,9 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 	device_property_read_u32(dev, "snps,burst-map", &burst_map);
 
 	/* converts burst-map bitmask to burst array */
-	for (bit_index = 0; bit_index < 7; bit_index++) {
-		if (burst_map & (1 << bit_index)) {
-			switch (bit_index) {
-			case 0:
-			plat_dat->axi->axi_blen[a_index] = 4; break;
-			case 1:
-			plat_dat->axi->axi_blen[a_index] = 8; break;
-			case 2:
-			plat_dat->axi->axi_blen[a_index] = 16; break;
-			case 3:
-			plat_dat->axi->axi_blen[a_index] = 32; break;
-			case 4:
-			plat_dat->axi->axi_blen[a_index] = 64; break;
-			case 5:
-			plat_dat->axi->axi_blen[a_index] = 128; break;
-			case 6:
-			plat_dat->axi->axi_blen[a_index] = 256; break;
-			default:
-			break;
-			}
-			a_index++;
-		}
-	}
+	for (bit_index = 0; bit_index < 7; bit_index++)
+		if (burst_map & (1 << bit_index))
+			plat_dat->axi->axi_blen[a_index++] = 4 << bit_index;
 
 	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
 	plat_dat->core_type = DWMAC_CORE_GMAC4;
-- 
2.47.3


