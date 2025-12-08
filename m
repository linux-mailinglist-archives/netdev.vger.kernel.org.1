Return-Path: <netdev+bounces-243987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03494CACD66
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A843430111BF
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E990A31062D;
	Mon,  8 Dec 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mCYicAZS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436222D9ECA;
	Mon,  8 Dec 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188996; cv=none; b=QcPQN4POTHYWa76u3LQ0C22qZ0Nk8rIw+T97MJ1OSbQl5+WMoFVpKavBCfbbhvTW+vARvMXsfnY+JBJEHXTUv3VjCqkP37Wqw+I11wBA0RJ8lhy5VNO0fF5x/O2M+rXCwmDBdSZeBW/pJsJ+4UUxJSN/Gps0uzmPPXj6hpAXk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188996; c=relaxed/simple;
	bh=sSYWE0plVcot7u1OFG1+iTrk3wemFOg/XOLqsK5k8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asE/L+QGXR9arSPELmj8RMw6QW2f67dSuKcrkUQlSzzFoCnjKt8QB6YKuQNIDJRoSYLIryk461c0wgPD0XLxfhG5KYNz8CTKLGeA3keCcUqxSLvT/DceowFpcru10S6zZknmJPP/5O/KLwUfTGbXpLCRx7oG0jfhgyDIb9W5T4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mCYicAZS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8gpVs/bBnQZWYunBAJLd91l6PxkU8SbY1fqcBlsvY4g=; b=mCYicAZS+ZfG0qb1iMzqaXJLRb
	zO9v361xTCLjsBnGfTwKH0I5iLv3JAa8b7xLwyVOJLSGg1607ErOH4sJ7ie9m0/A+Z/W5Qr4qnH91
	i9Uzid6YnpF5Ux1bexWLl8vlTBxP4mnDH0/CZpkhT7hzOqdLwnhVU1LUJ5tyJrKjNYRSQ9YUk99QX
	GjLnyxmg3HRP7aLwNnPXi4YjrJD8p/xfGDUU4pQ/TVdpGWMir3aNyVVRXnnNeOLmtcPgqHHdGSnr2
	0ldN4KSZaiakABkoDpyIpI60YpwfWrISK7ugjx15LhG38qHsV3DgOPz8HlVQOYmLfyI9k/3nFLm8q
	zfqbCNOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSYHo-000000007c9-1cvc;
	Mon, 08 Dec 2025 10:16:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSYHf-000000004wb-45Pa;
	Mon, 08 Dec 2025 10:15:59 +0000
Date: Mon, 8 Dec 2025 10:15:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: phasta@kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Yao Zi <ziyao@disroot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <aTalXy_85pvLraIy@shell.armlinux.org.uk>
References: <20251205221629.GA3294018@bhelgaas>
 <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 08, 2025 at 10:54:36AM +0100, Philipp Stanner wrote:
> The bad news is that it's not super trivial to remove. I looked into it
> about two times and decided I can't invest that time currently. You
> need to go over all drivers again to see who uses pcim_enable_device(),
> then add free_irq_vecs() for them all and so on…

So that I can confirm, you're saying that all drivers that call
pci_alloc_irq_vectors() should call pci_free_irq_vectors() in their
->remove() method and not rely on the devres behaviour that
pcim_enable_device() will permit.

In terms of whether it's safe to call this twice, pci_free_irq_vectors()
calls pci_disable_msix() and pci_disable_msi().

pci_disable_msix() checks:

        if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
                return;

which will set dev->msix_enabled to 0 via pci_msix_shutdown().

pci_disable_msi() does a similar check:

        if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
                return;

and similarly pci_msi_shutdown() sets dev->msi_enabled to 0.

So my conclusion is it's safe to call pci_free_irq_vectors() twice for
the same device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

