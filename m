Return-Path: <netdev+bounces-174143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1EA5D99B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A5D3B6342
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308C23BCF4;
	Wed, 12 Mar 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X7IJpKnr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E517BB6;
	Wed, 12 Mar 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772117; cv=none; b=ljf11FizNSdZlu/Z12dRB0KBJwE/JnT0X+umbqveLAYnw9dfuw5gnNrg4Ks4OCKYGaVeNF7ExGBGqQj+SPdrtw5/CnknSCBhj5yAFKSK0XqI5uLNbKzq+CyiOnAo8U7N4sT4b2d+yp/836mYqGAHTHF6khIPpMJUVY2cRdnV6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772117; c=relaxed/simple;
	bh=EbqFigB/rACpiBc5IEuy5oZksTCmTjC+erFhm6xiNGQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=guaRdph42HoE5z/dEtwlvwHsAD2raWBbwyaQnIB1OGXc1jIxBZKsfFwKrbQGhUpeYJodOOyBDGa3RzwRLPmkRNybYHRO8DTqs3PDFLdFxMigCCBVinDLi1gph0KRl+5AxImU/ibQWDd9DlvE6NSpqL6CU5s478el/xUUxKz0pnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X7IJpKnr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WlnjW2BpfjiM63UcojgauSdWRDJorCLGfJ2ZQigHONw=; b=X7IJpKnrsZz4mMD/Y0Imd0BscY
	ScXYdYmGGHGxceZABGH59dKp6Op9aD6N+QknONUFwhjdzmLrB1JoE+PsYvugL8vWxnuFbfKUx7XAi
	VEDp3Oc4nYVDL+5TQHgU0c7U6wQHIPi/qVz5A/1YrKHwhemAqcu9zAFG3SGbdPFS5aa15Vy366BfO
	UTmmU1lHl/mLEjniFwD3m95kk4T8lhPNCKvVHZrwttWqEeGkI6wl87mQHSzC85vsZ6i3VTH1dK8gH
	B6/yYn4HNBY771Peqn7tumWy1Hpmw1YBOpmcgSdAkcaWU4TmmMiXHEDJDOgr2DM5haKaqBE4GBjzs
	mpTA2naw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38170 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tsIUS-0005Hh-0g;
	Wed, 12 Mar 2025 09:35:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tsIU5-005vGR-4c; Wed, 12 Mar 2025 09:34:41 +0000
In-Reply-To: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
References: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
Subject: [PATCH net-next v2 4/7] riscv: dts: starfive: remove
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
Message-Id: <E1tsIU5-005vGR-4c@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 12 Mar 2025 09:34:41 +0000

Whether the MII transmit clock can be stopped is primarily a property
of the PHY (there is a capability bit that should be checked first.)
Whether the MAC is capable of stopping the transmit clock is a separate
issue, but this is already handled by the core DesignWare MAC code.

As commit "net: stmmac: starfive: use PHY capability for TX clock stop"
adds the flag to use the PHY capability, remove the DT property that is
now unecessary.

Cc: Samin Guo <samin.guo@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


