Return-Path: <netdev+bounces-249883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A44D20289
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF39830B7AF8
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64D3A35CB;
	Wed, 14 Jan 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UglqIB+1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4C11CBA;
	Wed, 14 Jan 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407414; cv=none; b=e+U2157A2TzjWFW/tMCQV/XC2LVD4H5A/iN1i8g2tbIlbtLtem28YH2cOjyYXCFVLBb7zhCr1w0CDbJ8TMTpZC5mLJBV0wVDQtll3PTm+YJX7djkGovqEINZsO+NvXIcQdY9Kix6ifR4YsZo5yT1FqHR5/Q7rMnmjG5AQhatPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407414; c=relaxed/simple;
	bh=Lu0FQTjo6owgFDAe5auJaLSofFYoxVkva31bfcDtA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZU5FOpA6cP7nam3X6kKmX+tyZcjMVos1LX/ojnu5dFVFtMSm93CsHV9z4BTpVG6pjaSpnmigGRDQ+V5QgPn5lTFl7tnGiDW9yL6l2TfayP/BZi2CKojvpwXIYVebTdMKkOyyZ5wG90j5WK434s14IjGWhJL3qNz+DxPEM90OFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UglqIB+1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jDEZj2tQ/lWE441pwvzkJV5WL54sUoxA3nZX64TSvWs=; b=UglqIB+1S2BMn0y/oTec/Afhcf
	yhA5dUCtFPFLb/p3Om/n3BSg5GuABbW0u7WsnGhQfh25a6uF/CH6zjb+LpEDzP7RQBsKWjKoQKTcU
	FAVu2lNhugMS8uZCf/X+urcd9gkmUMfVIfWEreUbEXt+/dWDSfUh38OEszcOlHG1Mi0mmS0DT5AT3
	B/Z1SSOSOcstJIDGAWbP8iEIvaxp7CLyuKt3sTuW9g6ZQLRNbwgqP+8VE6On97ZJxB8wUzIcCbDuW
	ga+f5WTl2BgzLwOknYY4qVSP4BmbGvyj/PpVGJTlBgnscypeUWszsgGhB9vvttXMcWfGHXN6nnfiP
	AgGXLAQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52560)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vg3Xi-000000000M3-0AFG;
	Wed, 14 Jan 2026 16:16:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vg3Xd-000000001mY-0K7W;
	Wed, 14 Jan 2026 16:16:17 +0000
Date: Wed, 14 Jan 2026 16:16:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: SHUKLA Mamta <mamta.shukla@leica-geosystems.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] net: stmmac: socfpga: add call to assert/deassert
 ahb reset line
Message-ID: <aWfBUPxvykOdygLO@shell.armlinux.org.uk>
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
 <20260108-remove_ocp-v3-1-ea0190244b4c@kernel.org>
 <aV_W2yLmnHrTvbTP@shell.armlinux.org.uk>
 <a2dc72ae-0798-4baa-b4d2-fa66c334576a@kernel.org>
 <c18fbdf0-b8e2-4fa7-8bb7-a3fed8960970@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18fbdf0-b8e2-4fa7-8bb7-a3fed8960970@leica-geosystems.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 14, 2026 at 02:09:27PM +0000, SHUKLA Mamta wrote:
> Hello Dinh,
> 
> On Arria10 socfpga, both reset lines i.e stmmac_ocp_rst and stmmac_rst 
> are needed since EMAC Controller on Arria10 supports Tx Rx FIFO with ECC
> 
> RAM and as per datasheet[1]:
> 
> `An EMAC ECC RAM reset asserts a reset to both the memory and the 
> multiplexed EMAC bus interface clock, ap_clk. You should ensure that 
> both the EMAC ECC RAM and the EMAC Module resets are deasserted before 
> beginning transactions. Program the emac*ocp bits and the emac* bits in 
> the per0modrst register of the Reset Manager to deassert reset in the 
> EMAC's ECC RAM and the EMAC module, respectively.`
> 
> [1]https://docs.altera.com/r/docs/683711/22.3/intel-arria-10-hard-processor-system-technical-reference-manual/taking-the-ethernet-mac-out-of-reset

Let's look at exactly what this is saying.

"An EMAC ECC RAM reset asserts a reset to both the memory and the
multiplexed EMAC bus interface clock, ap_clk."

1. Asserting the EMAC ECC RAM reset asserts reset to two items:
    - memory
    - the EMAC bus interface clock, ap_clk.
   This is not referring to any other modules, but it does suggest that
   the bus clock will be affected in some way, potentially stopping the
   clock.

"You should ensure that both the EMAC ECC RAM and the EMAC Module resets
are deasserted before beginning transactions."

2. This states that both resets (EMAC ECC RAM and EMAC module) need to
   be deasserted in order to access the EMAC. This is logical.

   If the EMAC ECC RAM reset is asserted, then, because it affects the
   bus interface clock, this may mean that accesses over the APB bus
   can not be performed because there could be no clock to allow them
   to complete. Thus attempting an access will probably stall the
   processor. (We've seen SoCs where this happens.)

   As having the DWMAC reset asserted means that the entire DWMAC
   hardware would be held in reset, including the bus interface,
   meaning that it will not respond to accesses. Whether that also
   hangs the processor is questionable, because APB has error reporting.

"Program the emac*ocp bits and the emac* bits in the per0modrst register
of the Reset Manager to deassert reset in the EMAC's ECC RAM and the EMAC
module, respectively.`

3. This states where the reset bits allegedly are in the register set.
   There is a link to https://docs.altera.com/r/docs/683711/22.3/intel-arria-10-hard-processor-system-technical-reference-manual/module-reset-signals
   but interestingly, the per0modrst (which implies per0 group) doesn't
   list emac*ocp resets. In fact, there is only one reference to "ocp"
   on that web page, which is in a diagram of the reset controller,
   specifically its bus interface.

So, the quoted section doesn't state anything about the requirements for
resetting the dwmac core.

What it does state is that both resets need to be deasserted before any
access is made, which is reasonable.

> OTOH, we can't have both scp and ahb rst together while setting phy 
> mode, since they are basically same reset lines and having both leads to 
> warning:

So it seems that you actually have a single reset bit, and you have
that represented as a single shared reset - shared between your
"stmamc_rst" and "stmmac_ocp_rst".

I notice Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
doesn't describe the resets, but has:
  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
  # does not validate against net/snps,dwmac.yaml.

as dwmac describes at least one reset between one called "stmmaceth"
and the other called "ahb".

The only possibility I see for these "EMAC ECC RAM" resets are in
Table 25.  RAM Clear Group, Generated Module Resets, there's a bunch
of signals described there "emacN(tx|rx)_sec_ram_rst_n, and that
table suggests that these resets are asserted and deasserted on
cold and warm system level resets.

Given that there seems to be no way for software to control these
EMAC ECC RAM resets, they seem to be outside the realm of needing
to be handled within the driver, and also should not be described
in DT.

Maybe I missed something?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

