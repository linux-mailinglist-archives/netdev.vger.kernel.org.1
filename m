Return-Path: <netdev+bounces-243999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20FCACF60
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 12:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5D33033681
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 11:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9DC30FC26;
	Mon,  8 Dec 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TpMAM5IR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F829B8E0;
	Mon,  8 Dec 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765192299; cv=none; b=cw8mkvONWClc0JvqkIYmT2gg8kV3QJiNHs9eNmkBx1uuv4DGN1Nwa0J7s3SYZTUsBfKQIIuSiNNnAiuHm6A7Mg2cScSvV6zeEAsi6Xi9wiPn/xfrtNGgkNeRuENvkvQborqjaAp3xruZB9sTTKvt/DootcQFViC0MAwUHEEZjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765192299; c=relaxed/simple;
	bh=cAOFMLZtlWzWNVHgoq9j0kKv5kLNN9Pud2AYSf1LPX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsXBaPM3gfa6f4cRW1LvSfhlc3O1Dmq1+amTUlrA8ssyiNxXM8JHLKozZxJNUT5ygRExrvclfV3k1nM562Z3XUMhJkiP8X9KqTXhVPXoxVxsUuIMaFRxOqG3zvEUxu/N4Pf+8WUMR7RfYMFtkGBYr5/Zyn9tcpVlMrHklHhDWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TpMAM5IR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=axT8z7YgLiqlRNGL8DP15zzMN8+hVawuLiVTX/OxMiM=; b=TpMAM5IRCqW8oz5CIlMHHFPKf2
	ebqn29dJEPwmk4p0EfzkL9SIKkKP6VKTGm7Gj0VWqhBD1r3LWMHM3oY3VObRZaZZ8ISmCea903Qb8
	XdkTuLlCWFUNMUN9UCAy8VtMIWHtpMP06rznOVofuJI/iU2knGaUilUdnx89d053Xh9NeZYSf1FP+
	ZXf0nPbo3umEQhDgDcNaLztKyAAn+vEd5Wm2uFvr3xjglBt9zEbPIosbGGsCI9ytjRBZCpB7Dl7zI
	YUkFoGbxcW8nGH6VA0KTQ47iWIufMwGEM6ekYWj5WqCVAijUWp6Bg73q8TxZSp0oWuu7PUtz1nqz7
	YcbIxh5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50284)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSZ9J-000000007fl-1nD8;
	Mon, 08 Dec 2025 11:11:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSZ9E-000000004yv-3jQ9;
	Mon, 08 Dec 2025 11:11:20 +0000
Date: Mon, 8 Dec 2025 11:11:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yao Zi <ziyao@disroot.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aTayWGy5LOOITFHH@shell.armlinux.org.uk>
References: <20251124163211.54994-1-ziyao@disroot.org>
 <20251124163211.54994-3-ziyao@disroot.org>
 <aSSspDCPM_5-l24a@shell.armlinux.org.uk>
 <aTJuNk4zF8CLtt9S@pie>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTJuNk4zF8CLtt9S@pie>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 05, 2025 at 05:31:34AM +0000, Yao Zi wrote:
> Hi Russell,
> 
> Sorry for the late reply,
> 
> On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
> > > +static int motorcomm_setup_irq(struct pci_dev *pdev,
> > > +			       struct stmmac_resources *res,
> > > +			       struct plat_stmmacenet_data *plat)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> > > +	if (ret > 0) {
> > > +		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
> > > +		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
> > > +		res->irq	= pci_irq_vector(pdev, 5);
> > > +
> > > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > +
> > > +		return 0;
> > > +	}
> > > +
> > > +	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", ret);
> > > +	dev_info(&pdev->dev, "try MSI instead\n");
> > > +
> > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "failed to allocate MSI\n");
> > > +
> > > +	res->irq = pci_irq_vector(pdev, 0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > ...
> > > +	ret = motorcomm_setup_irq(pdev, &res, plat);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
> > > +
> > > +	motorcomm_init(priv);
> > > +
> > > +	res.addr = priv->base + GMAC_OFFSET;
> > > +
> > > +	return stmmac_dvr_probe(&pdev->dev, plat, &res);
> > 
> > If stmmac_dvr_probe() fails, then it will return an error code. This
> > leaves the PCI MSI interrupt allocated...
> 
> This isn't true. MSI API is a little magical: when the device is enabled
> through pcim_enable_device(), the device becomes devres-managed, and
> a plain call to pci_alloc_irq_vectors() becomes managed, too, even if
> its name doesn't indicate it's a devres-managed API.
> 
> pci_free_irq_vectors() will be automatically called on driver deattach.
> See pcim_setup_msi_release() in drivers/pci/msi/msi.c, which is invoked
> by pci_alloc_irq_vectors() internally.

As discussed in the sub-thread with Philipp Stanner, please explicitly
call pci_alloc_irq_vectors() in the cleanup path to avoid adding to
the burden of drivers that need to be fixed allow this "magical"
behaviour to be removed in the future.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

