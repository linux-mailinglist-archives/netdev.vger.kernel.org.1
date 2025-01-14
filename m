Return-Path: <netdev+bounces-157945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8EA0FE96
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74127169E6D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474102309A1;
	Tue, 14 Jan 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ig1VG/Jv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB61230982;
	Tue, 14 Jan 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821040; cv=none; b=J91G34D6dGYIo2fzDc6US928SrVebMFo6useInrBPBPjuY/DA3l7rOkcHA6tsvIav7TwWUQ5sEj94hUUcpHLQMgBR4KJFxkcuFGWtV3JZUn3FB0wNCZh8hPv+rOSvEr1mAMwJmfWJU38vKYt4dhYR1U9hZ1PkOg3C/1sWbgXS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821040; c=relaxed/simple;
	bh=FtorzbUcyybGKCzychWUGkBpsHmzsm4YVxWyTNDQtvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1zcXRQM2UWKecgbbfw7jJ80i7iOzMPHryCc5/Q/jfLM2frJQoNDPOPEPJ7piGJhV7CJ+0daKR2rZUdPHEMX02O5R9Tm3H3opQgLLUFtdM2DA0QxSNL83zmhoIooFKdgxmH2FhsGoth/MyNRM8uAqGiwrvdG/s0AT+Cngn6f2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ig1VG/Jv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P1SIEN3E6aqrThhxwat3Nx/SdisRq4J3tMD+nuJgrUc=; b=ig1VG/JvMUnpVn3G1nBjH7GmvJ
	zoLv1nz0dIwYHbMWp7Z9UvXr/HpAd2Ze/y9+Di+8jRDXjo+sLl4ShiK2e81vMUX8yZE8X4V4rQ0NH
	C6ShuctKHa25uulz+afqGQTrob6TnSSLEQForwvpbl8KGrFEgSKsrhevMK0toA77jBts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXWUD-004Im6-Bo; Tue, 14 Jan 2025 03:16:57 +0100
Date: Tue, 14 Jan 2025 03:16:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Joey Lu <a0987203069@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, devicetree@vger.kernel.org,
	ychuang3@nuvoton.com, netdev@vger.kernel.org,
	openbmc@lists.ozlabs.org, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, joabreu@synopsys.com,
	schung@nuvoton.com, peppe.cavallaro@st.com, yclu4@nuvoton.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <e7041d36-9bc7-482a-877d-6d8f549c0ada@lunn.ch>
References: <20250113055434.3377508-1-a0987203069@gmail.com>
 <20250113055434.3377508-4-a0987203069@gmail.com>
 <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30b338f-0a6f-47e7-922b-c637a6648a6d@molgen.mpg.de>

> > +#define NVT_MISCR_RMII          BIT(0)
> > +
> > +/* 2000ps is mapped to 0x0 ~ 0xF */
> 
> Excuse my ignorance: What is ps?

picoseconds. An RGMII link needs a 2ns delay between the clock line
and the data lines. Some MACs allow you to tune the delay they can
insert, in this case in steps of 2ns / 16.

> > +#define NVT_PATH_DELAY_DEC      134
> > +#define NVT_TX_DELAY_MASK       GENMASK(19, 16)
> > +#define NVT_RX_DELAY_MASK       GENMASK(23, 20)
> > +
> > +struct nvt_priv_data {
> > +	struct platform_device *pdev;
> > +	struct regmap *regmap;
> > +};
> > +
> > +static struct nvt_priv_data *
> > +nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct nvt_priv_data *bsp_priv;
> > +	phy_interface_t phy_mode;
> > +	u32 tx_delay, rx_delay;
> 
> Please append the unit to the variable name.

Which is trick, because they are in units of 2000/16 of a picosecond.

	Andrew

