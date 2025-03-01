Return-Path: <netdev+bounces-170916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FBA4AA3D
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 11:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360E47A82D2
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B61CAA9A;
	Sat,  1 Mar 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JRb0sxvH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD323F39D
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825364; cv=none; b=g/5pMxfmFoJIazQIVdZYRoHT/aTQ8mkmPQAgWMV39hQRn3th0IfJ/ODPUWnhytk06Fxx5Pwn6KlK0iSCM/x8I/1RjvxGWkn/IKVbKYKOIM9okmhjOlUIjBlbJUVli+siyn4EQq1CkXUuP2ZtZs5weEQCn2zC8n+dcZ/gO8Lt7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825364; c=relaxed/simple;
	bh=bkCzMtITmd66ChNfEmMQxa/Yuy9+XVsN6MuATllnoSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFuCFddrKhAynhFrNm79yjdwTEfXOvHvWgMvlrcF/K2e1MjjCBkH5Ng/G2JkjdH9jJlyKWdxQuu5F7XsfNFREX36zNlKgXozqcDIAJZxh5azhJ91+bY5fzva6mWXVrqL6L6fUKfxZlUCX8VDIsH/+3xREADh9kTvDgtzDi10FVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JRb0sxvH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NbnxRDsM7wFCSn7ZwguqUBN3uLZyyPrVe6UrA+DaIdw=; b=JRb0sxvH6lL+NBhHj9/orxr4zL
	3GEuiWEMXv8XUYGrm/LlkO34tD5KfEmPRMuLBAdTDZO4ZQUpPrW56D96B3mVvokum52nAClC2TUb7
	kzp4svreaaGmBusOG3TpDLiYJJpl5X9m7QLMw/a02gDunZm324BUL3yAF3vy2aF+ECvANtzEZmVWm
	3/DncYyIBFjhgMvLIF008usQlxnHakXycvpKqltdiKsVxOuYxnPAW+jHS4JHSZLFQdHIemPCDGckc
	I+uool87P9rPNmt5+EpYOJfaDZ3oqvldYhg87+t0dUGIWs2OFX3RtHsq044yHZHt75SHoEuS6TYeA
	MzWQbBJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49338)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1toKCC-00044v-2O;
	Sat, 01 Mar 2025 10:35:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1toKC9-0001hZ-1N;
	Sat, 01 Mar 2025 10:35:45 +0000
Date: Sat, 1 Mar 2025 10:35:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev <netdev@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [QUERY] : STMMAC Clocks
Message-ID: <Z8LjAbz5QmaMeHbO@shell.armlinux.org.uk>
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 28, 2025 at 09:51:15PM +0000, Lad, Prabhakar wrote:
> Hi All,
> 
> I am bit confused related clocks naming in with respect to STMMAC driver,
> 
> We have the below clocks in the binding doc:
> - stmmaceth
> - pclk
> - ptp_ref
> 
> But there isn't any description for this. Based on this patch [0]
> which isn't in mainline we have,
> - stmmaceth - system clock
> - pclk - CSR clock
> - ptp_ref - PTP reference clock.
> 
> [0] https://patches.linaro.org/project/netdev/patch/20210208135609.7685-23-Sergey.Semin@baikalelectronics.ru/
> 
> Can somebody please clarify on the above as I am planning to add a
> platform which supports the below clocks:
> - CSR clock
> - AXI system clock
> - Tx & Tx-180
> - Rx & Rx-180

I'm afraid the stmmac driver is a mess when it comes to clocks.

According to the databook, the DW GMAC IP has several clocks:

clk_tx_i - 0° transmit clock
clk_tx_180_i - 180° transmit clock (synchronous to the above)

I've recently added generic support for clk_tx_i that platforms can
re-use rather than implementing the same thing over and over. You can
find that in net-next as of yesterday.

clk_rx_i - 0° receive clock
clk_rx_180_i - 180° of above

These are synchronous to the datastream from the PHY, and generally
come from the PHY's RXC or from the PCS block integrated with the
GMAC. Normally these require no configuration, and thus generally
don't need mentioning in firmware.

The host specific interface clocks in your case are:

- clock for AXI (for AXI DMA interface)
- clock for CSR (for register access and MDC)

There are several different possible synthesis options for these
clocks, so there will be quite a bit of variability in these. I haven't
yet reviewed the driver for these, but I would like there to be
something more generic rather than each platform implementing basically
the same thing but differently.

snps,dwc-qos-ethernet.txt lists alternative names for these clocks:

"tx" - clk_tx_i (even mentions the official name in the description!)
"rx" - clk_rx_i (ditto)
"slave_bus" - says this is the CSR clock - however depending on
   synthesis options, could be one of several clocks
"master_bus" - AHB or AXI clock (which have different hardware names)
"ptp_ref" - clk_ptp_ref_i

I would encourage a new platform to either use the DW GMAC naming for
these clocks so we can start to have some uniformity, or maybe we could
standardise on the list in dwc-qos-ethernet.

However, I would like some standardisation around this. The names used
in snps,dwmac with the exception of ptp_ref make no sense as they don't
correspond with documentation, and convey no meaning.

If we want to go fully with the documentation, then I would suggest:

	hclk_i, aclk_i, clk_app_i - optional (depends on interface)
	clk_csr_i - optional (if not one of the above should be supplied
			      as CSR clock may be the same as one of the
			      above.)
	clk_tx_i - transmit clock
	clk_rx_i - receive clock

As there is a configuration where aclk_i and hclk_i could be present
(where aclk_i is used for the interface and hclk_i is used for the CSR)
it may be better to deviate for clk_csr_i and use "csr" - which would
always point at the same clock as one of hclk_i, aclk_i, clk_app_i or
the separate clk_csr_i.

Essentially, this needs discussion before settling on something saner
than what we currently have.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

