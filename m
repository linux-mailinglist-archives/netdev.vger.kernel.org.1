Return-Path: <netdev+bounces-174139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908BA5D988
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895DD3B467E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBCE23278D;
	Wed, 12 Mar 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tQy/MXDA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEA38384;
	Wed, 12 Mar 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772085; cv=none; b=HdS+sbj16JI1ib7DJ8nNY9mXkkNmc2bOW6aVP2cuWmncVUMn1fbic/tstf/8IJHnrVyPWy7QSbCEycvyWWiXzsPHonPDWRE6RfQxDiW+NHyXzxXV/MsF915iEiof/v16iv21mAWffRtZiGSbsHnu9J1CmMZOxyzpEZnjbmag3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772085; c=relaxed/simple;
	bh=5SCu5ezk2Jh7TxbuKcyIpiUleZMJsHGmRtBgPjVeWAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lJSOyUC1uXIBAqn89hmiwrvr5zxD3nXvchsuyCzy0CHFn17lvMpTbykO1n2CFjBKQ/YrSHqWRq4uShiKhn7gZymnJWw0rJ7gFJn0xOmmufQNPcm+FZzXpppKaw200z30DvguSfd5Wn0Lbm8TlW1tZ0L1nBzFF/ya0j8/VP7li4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tQy/MXDA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wl6zOR+xtNbThqwqizqyBwsRBu7DaTBch3G1Ngsw9UI=; b=tQy/MXDASRxCbhwMAs0WOjYgC1
	m/A3j6oE1GprwCfkaAzfI5IgKGdHLWDbpQMN9g95HskKLxAUqXz1PwSKfIx+pSxAem9iS3UikdIkw
	65tdgBJZVWX6OxdzbExLxS5xmKk5xBW+dfolr3dfMMjNfSWJyFkU+hphBwtCvTMVJyvaDLqfpfwEz
	FlIxCeOnJSn1Qv09csh21n4tyDvf5ZAX2/pHiNT+YsOQpGRtTYxLzCTUg3iO9MJp1WuKm+f2U1aKM
	Xd8nkGmVayKRDZcv630OeLqrsEgQ42HLC44CN/DFPaedQvI/lIl1PRu0BCIwopVvmVI+YTLq8DlEk
	l4SzR1Ew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52664)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tsITu-0005GN-0y;
	Wed, 12 Mar 2025 09:34:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tsITk-0004R4-1o;
	Wed, 12 Mar 2025 09:34:20 +0000
Date: Wed, 12 Mar 2025 09:34:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@st.com>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Samin Guo <samin.guo@starfivetech.com>
Subject: [PATCH net-next v2 0/7] net: stmmac: deprecate
 "snps,en-tx-lpi-clockgating" property
Message-ID: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 09, 2025 at 03:01:45PM +0000, Russell King (Oracle) wrote:
Hi,

This series deprecates the "snps,en-tx-lpi-clockgating" property for
stmmac.

MII Transmit clock gating, where the MAC hardware supports gating this
clock, is a function of the connected PHY capabilities, which it
reports through its status register.

GMAC versions that support transmit clock gating twiddle the LPITCSE
bit accordingly in the LPI control/status register, which is handled
by the GMAC core specific code.

So, "snps,en-tx-lpi-clockgating" not something that is a GMAC property,
but is a work-around for phylib not providing an interface to determine
whether the PHY allows the transmit clock to be disabled.

This series converts the two SoCs that make use of this property (which,
I hasten to add, is set in the SoC code) to use the PHY capability bit
instead of a DT property, then removes the DT property from the .dtsi,
deprecates it in the snps,dwmac binding, and finally in the stmmac code.

I am expecting some discussion on how to merge this, as I think the
order in which these changes is made is important - we don't want to
deprecate the old way until the new code has landed.

Changes in v2:
- Correct Cc list

 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  1 +
 arch/arm/boot/dts/st/stm32mp151.dtsi                  |  1 -
 arch/riscv/boot/dts/starfive/jh7110.dtsi              |  2 --
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c  |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c     |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h          |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 16 ++++++++++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  5 ++++-
 include/linux/stmmac.h                                |  3 ++-
 9 files changed, 22 insertions(+), 9 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

