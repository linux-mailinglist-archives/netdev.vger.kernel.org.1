Return-Path: <netdev+bounces-173315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A12A5853C
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD956188A194
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71891DA0E0;
	Sun,  9 Mar 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iDe6dogn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB1188CCA;
	Sun,  9 Mar 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532565; cv=none; b=pgfMhhGqbdmOc0s0xLwiSaAChgPuK44jx5/oPNCvJDUCy20DHSqXuNPHrPk/Wfl1qACgf0OZyRTaKIjcQjTYfdXwK9THsF3D31PcV95T/eOPTJMtmSR6d/GP6/VhUst6DHm+pWQ8eiMa3HXEBn0di+voMDXnG8wFjCBL+o8ljYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532565; c=relaxed/simple;
	bh=NogcCfyGdnhLsMDsQcJh0+yqnTJWn735ukbYkD2w19o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eAZbi2r4M7iJMYgNCL4zmo9NalYPDTIrsJD7WRTqlewcWrhqSufZm3amrNRGnALZQhccqjLPNtJ5vYLcyzYzwg8fL9oKdMsJHeqJv7h35uJdJ6wTOs3xDRHfuMi/D7hnjlOEU+lDWyrtg/Ho2uWIo7pyL+wtiwR7kQewhySZUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iDe6dogn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DHaJAgb84V8aMUutZwPQWCAxCUaidjZX4yslhRdqYrw=; b=iDe6dognGE1zU+dDTgL4uC9O+o
	pV5AKzWpSiMflaIy1/D/Jf4Jk0sQiHnGk/jMrSreXgd9o3ZkujReAoBy/F+Pic5YJcyKRI19A7qaa
	9m7T/lYyDfZOaadi94tzaxyx9nsR/Yo3KymdWxbVgJ3ldF84HJ4SSt7PUMQ7LJDPfiNexOVyiOy11
	X54AOnU7qAjTqMLd2XNmHu8FyOH8+tw2+3DFNiKnlsJWsFNuTXQDVvQKjtFOQYIYbqbuMV9elxkjl
	gbNDET8vp4ZU5IgfDZWtIcnGaIvHIA7IY8X4qKvzKQV58/4RPGVYNhVnySdFKT6EQt/y+aZBeUjSo
	hqfUsU/w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36620 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trIAh-0001QA-0F;
	Sun, 09 Mar 2025 15:02:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trIAK-005nti-W5; Sun, 09 Mar 2025 15:02:09 +0000
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
Subject: [PATCH net-next 5/7] ARM: dts: stm32: remove
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
Message-Id: <E1trIAK-005nti-W5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 09 Mar 2025 15:02:08 +0000

Whether the MII transmit clock can be stopped is primarily a property
of the PHY (there is a capability bit that should be checked first.)
Whether the MAC is capable of stopping the transmit clock is a separate
issue, but this is already handled by the core DesignWare MAC code.

As commit "net: stmmac: stm32: use PHY capability for TX clock stop"
adds the flag to use the PHY capability, remove the DT property that is
now unecessary.

Cc: Samin Guo <samin.guo@starfivetech.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index b9a87fbe971d..0daa8ffe2ff5 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -1781,7 +1781,6 @@ ethernet0: ethernet@5800a000 {
 				st,syscon = <&syscfg 0x4>;
 				snps,mixed-burst;
 				snps,pbl = <2>;
-				snps,en-tx-lpi-clockgating;
 				snps,axi-config = <&stmmac_axi_config_0>;
 				snps,tso;
 				access-controllers = <&etzpc 94>;
-- 
2.30.2


