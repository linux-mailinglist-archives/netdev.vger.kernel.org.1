Return-Path: <netdev+bounces-173314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E09A5853E
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE27E3AD984
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718E6188CCA;
	Sun,  9 Mar 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CIT2vDEc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A215170A2C;
	Sun,  9 Mar 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532560; cv=none; b=BwvCHnrET4/XJtV9k2EHzYc7tYIdw46L7OX+jMrz1xB/J1wu0xGtJixdtytyOrrJlLgRLnDsMKFdpS3c9FhfV+/aNdbIrrbAQFZX0YcpEPoENqWmE8gzPtooz5KsDZi56oBOwWcv4GElA/NKT8Pvwdls/Dr2+7zGPVoUj2lx96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532560; c=relaxed/simple;
	bh=Fv51lGzIhSwcD6MF0P9EgVTGETEk9K/zQkUanRLoIlU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gjNk5jswgfcj4i3tyFttg0DTRtOlO8hMt8MgNLypNVF0GsGHhezTnlRCMtjAXBUoUUwDYcuTeiOGPuJeDyXB/z0tzjcbTUT/LLIGlpFdQ5OwHOFOZq2FmPC9CTRl/Kd+5tMuwl9naLEQrnqjhtcRLdxh4YLbtWvPTZqISKtfVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CIT2vDEc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EjTTpaZia4xPDrHFP8XfvKcQeiE7s1ZisD7eXsEguQI=; b=CIT2vDEcIkQZahNG9MZxS/nLAd
	IKQ5L2mYxMAkoITqMILETe6PkR1T2SY2U700eCD3oLMDMnwdSyr3OWM7nhmpv4YvKn0z3UrttyCHw
	WqNEtu+VY4rqYEV8+KpHJbiZzdWAscHKk/sNH21fV8lwWtTPapOuNC7QdWqi9FYbZAOn5603Pnw6X
	Z2T3jqMbVPMSvFACFljYDt2DoQ/M+5WCc6LgClKZJ2H5KG9QbrGm7w/UYBdsC3Kb2RcgOTyI1aHaz
	5x/AcRIQ9wI8mJNtNhsIEDp4TQLPs2q3JRh2CcvfBlEL0fBWQ92YF00tjrJzq6qtd1wscNChx8GJB
	PHksNOcw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36610 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trIAb-0001Pn-0p;
	Sun, 09 Mar 2025 15:02:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trIAF-005ntc-S5; Sun, 09 Mar 2025 15:02:03 +0000
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
	Rob Herring <robh@kernel.org>,
	Samin Guo <samin.guo@starfivetech.com>
Subject: [PATCH net-next 4/7] riscv: dts: starfive: remove
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
Message-Id: <E1trIAF-005ntc-S5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 09 Mar 2025 15:02:03 +0000

Whether the MII transmit clock can be stopped is primarily a property
of the PHY (there is a capability bit that should be checked first.)
Whether the MAC is capable of stopping the transmit clock is a separate
issue, but this is already handled by the core DesignWare MAC code.

As commit "net: stmmac: starfive: use PHY capability for TX clock stop"
adds the flag to use the PHY capability, remove the DT property that is
now unecessary.

Cc: Samin Guo <samin.guo@starfivetech.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 0d8339357bad..a7aed4a21b65 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1022,7 +1022,6 @@ gmac0: ethernet@16030000 {
 			snps,force_thresh_dma_mode;
 			snps,axi-config = <&stmmac_axi_setup>;
 			snps,tso;
-			snps,en-tx-lpi-clockgating;
 			snps,txpbl = <16>;
 			snps,rxpbl = <16>;
 			starfive,syscon = <&aon_syscon 0xc 0x12>;
@@ -1053,7 +1052,6 @@ gmac1: ethernet@16040000 {
 			snps,force_thresh_dma_mode;
 			snps,axi-config = <&stmmac_axi_setup>;
 			snps,tso;
-			snps,en-tx-lpi-clockgating;
 			snps,txpbl = <16>;
 			snps,rxpbl = <16>;
 			starfive,syscon = <&sys_syscon 0x90 0x2>;
-- 
2.30.2


