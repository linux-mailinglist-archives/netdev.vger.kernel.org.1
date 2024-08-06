Return-Path: <netdev+bounces-116080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80633949037
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29041C22362
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB301D0DDC;
	Tue,  6 Aug 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OT6QJYLD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565E1CCB21
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949743; cv=none; b=VsWYONZwr6x7R6e0CqBuymDkvet1JQ8Y8jt/ZxrBghWJoWMJGD2kBphA9Ri9nxPcfAjFsLrdgbsSmszlCQsis3yNb55DjRN0NL/+V+biP3U34kHZAWUojQtjrT+tU/WdLzLl/XfQIzqT9KJfZVoSii/nC8uK6GomeoO/TUQfoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949743; c=relaxed/simple;
	bh=5BpbLxoXg8+361R9Y1jk0KstnKcaUz/iHItOz4mmkwM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=V89RD2Ifp8xpuyOToTxKWJakf5QNaW96qtBc/p/JvFygYOKLDVGH5Y2ehFACxv16pMsJycryFQAsYlzt4a+R+lOA4uEU28cpseyG2gpnEx7snnQ35n3fZ5UThXUXFzvLE7iICJj4r2taHF4IA2qng2eRunMEuzIwXGgDKZNJXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OT6QJYLD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S7MtkYDJ1rYrIhVc+sgJU5aErkd2FXVkUBn+xIwlPJs=; b=OT6QJYLDqZL/9PL2rP9dNtlHuf
	Y8ii/22Mnc9lkMkQcFnEW3B5w9/b5F+kPRaqGP4G0cynu5PhDF4MWd2ioP625l9DmoGu/5PKSEnr7
	qjdL8alNvfp5JPtjZepS8uBkrPsodg/NkujMDPgYqgaZZ0ogtkfnB7VvBNJqSUugBolMkoWKniLtG
	kywcpdLtq7CI/7orGKyrz2CNYKlc+rRBPMb89wOihHzpkcwwTQeU8p8Pj9ro7+h7F/lHvrkQB7BZj
	p6zl3ywaeHglUopFI/pNCc+VrAnFD2wSIgQXUmaJFXFbfwoj7l4MJzNg85+UC5EMhv7hhEi2CFSM9
	sy1WNErQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44594 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sbJvY-0004tP-0o;
	Tue, 06 Aug 2024 14:08:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sbJvd-001rGD-E3; Tue, 06 Aug 2024 14:08:41 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2] net: stmmac: dwmac4: fix PCS duplex mode decode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sbJvd-001rGD-E3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Aug 2024 14:08:41 +0100

dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.

Fixes: 70523e639bf8c ("drivers: net: stmmac: reworking the PCS code.")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since v1:
- remove GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK definition
- add reviewed-bys

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      | 2 --
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index d3c5306f1c41..93a78fd0737b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -573,8 +573,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 #define GMAC_PHYIF_CTRLSTATUS_LNKSTS		BIT(19)
 #define GMAC_PHYIF_CTRLSTATUS_JABTO		BIT(20)
 #define GMAC_PHYIF_CTRLSTATUS_FALSECARDET	BIT(21)
-/* LNKMOD */
-#define GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK	0x1
 /* LNKSPEED */
 #define GMAC_PHYIF_CTRLSTATUS_SPEED_125		0x2
 #define GMAC_PHYIF_CTRLSTATUS_SPEED_25		0x1
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index f98741d2607e..31c387cc5f26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -786,7 +786,7 @@ static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
 		else
 			x->pcs_speed = SPEED_10;
 
-		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
+		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD);
 
 		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
 			x->pcs_duplex ? "Full" : "Half");
-- 
2.30.2


