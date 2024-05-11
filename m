Return-Path: <netdev+bounces-95733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FF38C3301
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C63281BDA
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C031C286;
	Sat, 11 May 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SOsZuazO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECB17588;
	Sat, 11 May 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715449822; cv=none; b=TiLecZLJIyd0CCsIFDSfkMqLWzgANGXGsjtrDUY3XT1MZGe2792rFnVD4/kW2EEZ3Thg6Ak/vUZEtyKymUQ7rMadB6q3PftuTT30/3vFJDuj7zMsxCSb8GvOTfBBKpJ8hq77LG88kf6gtCLeG+ThfVJLZqZ8e4XsBiHb5dcjrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715449822; c=relaxed/simple;
	bh=3qrxI+McJJ24PePgQfQ7tnTmV4FgZcW6I+hckmEOAcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmQsfDqPnOEDCJbyyFlLqvTi0KgWu4qf5nTDBAfsJ66W05Y7Aer1i4Ubq5hBusCsjMwBQhNP0hrX9DQU4aJ+tWnos33DPQ4UmQXyojJjQCaDyqQ3Z8vqY3rYWDDYBtv6H4WuwVrf8UGvU7RiZf/c3fsaLQO6nEUZbQLxvwsmfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SOsZuazO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kGaJZOB8xwTriljjslRKC+hBQsPPqyV+ILWDtae2JQY=; b=SOsZuazOcT8hf6p0za4IL+Cq4n
	rwXdOeyvV9AUqMQUGvYvejxlj2Y7/mExGSmrSMVcho/+dLImIGasUzlR4jr14gHYQ9BrlyBLnTYNk
	ykyGmPzwdKnvbxI7ImGTZf3LLl9vThkHZy8GnZnm29CNiW2MrM0q5VFQI23WcISi7ZjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5qrD-00FCyO-4C; Sat, 11 May 2024 19:50:03 +0200
Date: Sat, 11 May 2024 19:50:03 +0200
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
Message-ID: <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
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

And now you mentions legacy Fixed link:

+MODULE_DESCRIPTION("Broadcom 10G Automotive Ethernet PCIe driver");

This claims it is a 10G device. You cannot represent 10G using legacy
fixed link.

Does this MAC directly connect to the switch within the SoC? There is
no external MII interface? Realtek have been posting a MAC driver for
something similar were the MAC is directly connected to the switch
within the SoC. The MAC is fixed at 5G, there is no phylink/phylib
support, set_link_ksetting return -EOPNOTSUPP and get_link_ksettings
returns hard coded 5G.

We need a better understanding of the architecture here, before we can
advise the correct way to do this.

      Andrew

