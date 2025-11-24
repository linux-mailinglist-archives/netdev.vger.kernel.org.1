Return-Path: <netdev+bounces-241281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBCC823C0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 768494E7DEA
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1919C566;
	Mon, 24 Nov 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QNSGELp8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B622FDE6;
	Mon, 24 Nov 2025 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011206; cv=none; b=gUdganKgDWSnEXYUimCUTnZg/UPygBMM4A3zSe2q+rag3ieejp0XY8QYeUCq8k6dikxnoJPaV7pVYJHgrw5OFAe6NqPVrQB8a2b++2y3ufEvkOYmOuMtxg+veI18qsdYzy7FKStxitYws2Sww3IeJICCCIYSm2Sf2elHtOXwGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011206; c=relaxed/simple;
	bh=fe0erM8R9qW71HS5W6EhaBBvXJPfvqC44rg6g2gDjZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC0QHOBwe5fbVw1F4x5dtb7Q3cCcsPxM3dWdmmS4g+UsA6zDv8STLXskBCDGJZoc+vAaT1J+2RN7ZpzJtte/HyEJWEVQ+jcoeLmQNAFWE5f3iO+BR7VEJuGK6un/p9kLcNNHj0JE94pguyloHB/yxzqz2nMtaZ8WVsW96g+cRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QNSGELp8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3W6tshEv8Go6fhWCI8+DSQfwCo6C/vcmIDwOMjM0L6s=; b=QNSGELp8jZV4fXBl5SnTkNMcDn
	hddd8nSyPj3BraGNiHVUKEZe1eBEMK8no+16GU0P9nRJ2XksqYAaPSQ428t12hJsHBv3o0GmdBGGW
	8LUdxlzncRWvPqGoen09Sxlf/hRt8UdcqHJ5LucyPTA601JzU6qVLXEXScy469SPjBDrG0Amr9q6G
	oqV3OfwJg1B5E7JvvkXodJVdioVr8fa6ZoorHzhXhJ/1UoFX77kbDsWImvFv2/jzohnM3MmX2byI4
	NGYIVMoj36uU31XFJ/NttxLLwke76pwmnIOimADOMGm76duMPKHgbUfYh5FoJBm3nRZdSPAwWgeRo
	psQms/vw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vNbtD-0000000025Z-2DoX;
	Mon, 24 Nov 2025 19:06:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vNbt6-000000008Tp-3SQu;
	Mon, 24 Nov 2025 19:06:12 +0000
Date: Mon, 24 Nov 2025 19:06:12 +0000
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
Message-ID: <aSSspDCPM_5-l24a@shell.armlinux.org.uk>
References: <20251124163211.54994-1-ziyao@disroot.org>
 <20251124163211.54994-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124163211.54994-3-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:
> +static int motorcomm_setup_irq(struct pci_dev *pdev,
> +			       struct stmmac_resources *res,
> +			       struct plat_stmmacenet_data *plat)
> +{
> +	int ret;
> +
> +	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> +	if (ret > 0) {
> +		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
> +		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
> +		res->irq	= pci_irq_vector(pdev, 5);
> +
> +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +
> +		return 0;
> +	}
> +
> +	dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n", ret);
> +	dev_info(&pdev->dev, "try MSI instead\n");
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to allocate MSI\n");
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +
> +	return 0;
> +}
> +
> +static int motorcomm_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
...
> +	ret = motorcomm_setup_irq(pdev, &res, plat);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to setup IRQ\n");
> +
> +	motorcomm_init(priv);
> +
> +	res.addr = priv->base + GMAC_OFFSET;
> +
> +	return stmmac_dvr_probe(&pdev->dev, plat, &res);

If stmmac_dvr_probe() fails, then it will return an error code. This
leaves the PCI MSI interrupt allocated...

> +}
> +
> +static void motorcomm_remove(struct pci_dev *pdev)
> +{
> +	stmmac_dvr_remove(&pdev->dev);
> +	pci_free_irq_vectors(pdev);

... which stood out because of the presence of this function doing
stuff after the call to stmmac_dvr_remove().

So... reviewing the other stmmac PCI drivers:

- dwmac-intel calls pci_alloc_irq_vectors() but does not call
  pci_free_irq_vectors(). This looks like a bug.
- dwmac-intel calls pcim_enable_device() in its probe function, and
  also its intel_eth_pci_resume() - pcim_enable_device() is the devres
  managed function, so we end up adding more and more devres entries
  each time intel_eth_pci_resume() is resumed. Note that
  intel_eth_pci_suspend() doesn't disable the device. So, this should
  probably be the non-devres version.
- dwmac-loongson looks sane, but the checks for ld->multichan before
  calling loongson_dwmac_msi_clear() look unnecessary, as
  pci_free_irq_vectors() can be safely called even if MSI/MSI-X have
  not been (successfully) allocated.

So, I wonder whether there is scope to have a common way to clean up
PCI drivers. Could you look into this please?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

