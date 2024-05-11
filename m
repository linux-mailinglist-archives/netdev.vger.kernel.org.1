Return-Path: <netdev+bounces-95728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C68C32E3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B0EB2105E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19221B966;
	Sat, 11 May 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xDGCoYOq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5C1C286;
	Sat, 11 May 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447965; cv=none; b=KPSTwGvIJ60tv5/GcjviLVns++jhwIfkYABheS6UZARUIMS0JNmlEb2QaLu/rnaP0ehMWaCfj2Z7gKHsFjFGqECrXLN0s8ydECd57hjbMpQY5tPDVeHOcmebvRQCniU0pGDBeVb5/g6YTdeyEljyaGb+afcg4YX1DEJqe8Wvdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447965; c=relaxed/simple;
	bh=JtxrfXquorAq2bYCxyWwuvOZACiGSKXrqHZI31bJbrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYljZr0CS9R/sIobF7hEjqcURfEjqzpeeF/JXeZIpqDt8oiUemA4C3fei17T9ezrENuSBqQVs25z1O8V4e/SZQKiWj/ffu3NUZO/a9x7i22VydHEwwlECSDc/9bZEUj5xSQabwq74T+sxApDCuVeJgh+Bg96/3PhWtIORi6wjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xDGCoYOq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=59ogc1letU28eIr+Nqtw/+iuMiLVkRN/Xzvbe5jpoVo=; b=xDGCoYOqA3ZePLHzgyyNU8baNs
	cMh46enKLDcmsupbkSUaxNCYBv3dbLF3DYISeVT9gQXO7TlumS8YV5niIOTjDNE+aVQ1K/ThimNzB
	eqFr1Z1IbYywhZernKUwrz8hMWtj+6rrejvhxbntgZd6YA62cGxNdvX4/2tN1ro3Dc4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5qNH-00FCtF-Gz; Sat, 11 May 2024 19:19:07 +0200
Date: Sat, 11 May 2024 19:19:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <63c3efa6-94a2-40c7-b47d-876ff330d261@lunn.ch>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>

On Sat, May 11, 2024 at 06:12:38PM +0100, Russell King (Oracle) wrote:
> On Sat, May 11, 2024 at 06:16:52PM +0200, Andrew Lunn wrote:
> > > +	/* This device interface is directly attached to the switch chip on
> > > +	 *  the SoC. Since no MDIO is present, register fixed_phy.
> > > +	 */
> > > +	brcm_priv->phy_dev =
> > > +		 fixed_phy_register(PHY_POLL,
> > > +				    &dwxgmac_brcm_fixed_phy_status, NULL);
> > > +	if (IS_ERR(brcm_priv->phy_dev)) {
> > > +		dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __func__);
> > > +		return -ENODEV;
> > > +	}
> > > +	phy_attached_info(brcm_priv->phy_dev);
> > 
> > What switch is it? Will there be patches to extend SF2?
> 
> ... and why is this legacy fixed_phy even necessary when stmmac uses
> phylink which supports fixed links, including with custom fixed status?

It might be because it is a PCI device, and they are trying to avoid
DT? Maybe because they have not figured out how to add DT properties
to a PCI device. It is possible.

	Andrew

