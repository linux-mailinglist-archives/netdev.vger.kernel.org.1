Return-Path: <netdev+bounces-163473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8626A2A599
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFCB3A4C1D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9322619D;
	Thu,  6 Feb 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VrGjZMXN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534522331F;
	Thu,  6 Feb 2025 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836730; cv=none; b=m89Knyqx1TokM709CrC/EieX0I1hVGF/3bnww0giyOi2xDyUfc8PcrucLXYl6IxvErfP4eA7JYSi8SAplMVFIUpQL79d+72Rlfi/Hb29L5Q6nUtoKuOOMdHdEpWivbFWmf94p49boWPrSk7u7d/mFNUW0CIt7DWGx1UWKkSucVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836730; c=relaxed/simple;
	bh=dl8ZXnQCbi3Y8kVYZFjrzTlPj5aOIr0W5r+muArOoeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkMJkWSij0OWUSTujRw8OV1dOIifjSc9oEExxXIJgc5ZZBhQ2RaeRdr3+pVRSVFA2AFaU0B05o9QthjW6ImrSSm8mHDbqJQiVK7gH4aPfsDiaN/FWMMtrvZj93YyvwZe+UhZbyla+jLPBsX9xywmerE4jnx3qXDN+YxIcF/pEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VrGjZMXN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IGtT4jJj54W9qkniOIuHDmAyLAJNfLsZ3atVdSoL2Sw=; b=VrGjZMXNKqp11sBPpNPyr9bd8j
	iDW8pjUfPny4JDeSdAM75qSlzDloRDzAuw8WPJ+YuCmZrT/uT0LWIy5VkIf9jmIxSMpOpb6SgsdTz
	+G/JpsS0x5S/EIl2UzUs7CYJrHEb12+B0+LZp+ntHccablhQbEOP6Cy+ZaXE0VSy1uFyMo53wgLfH
	2hzZRTL4roOnp4giNFVCOQ1gW/WFSYAStewJD3KnebYOAQ68PoitLuWosk5mUgkGk6NMo3H8ZUfCN
	PpjJf3Ew9XEO+zWoiOltaJbtDSQyt0EopVzMPvXzJaHI9iniyUZh974YIgNFl/TXHxlLDo/DfkjRE
	J+0zciZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58646)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfyqw-0001h6-11;
	Thu, 06 Feb 2025 10:11:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfyqn-0003LY-04;
	Thu, 06 Feb 2025 10:11:13 +0000
Date: Thu, 6 Feb 2025 10:11:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 4/7] stmmac: intel: configure SerDes
 according to the interface mode
Message-ID: <Z6SKwNF8ib2BgIsL@shell.armlinux.org.uk>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
 <20250204061020.1199124-5-yong.liang.choong@linux.intel.com>
 <Z6IDWiRF73sdVWob@shell.armlinux.org.uk>
 <f272cb2a-1167-4e34-9209-ffdbbb107bdd@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f272cb2a-1167-4e34-9209-ffdbbb107bdd@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 06, 2025 at 10:22:04AM +0800, Choong Yong Liang wrote:
> Thank you for your feedback on the patch. Based on your suggestion, I have
> updated the code to align with the mac_finish() method and included the AN
> mode as well. The updated function signature is as follows:
> 
> int (*mac_finish)(struct net_device *ndev,
>                   void *priv,
>                   unsigned int mode,
>                   phy_interface_t interface);
> 
> Could you please confirm if this meets your expectations, or if there are
> any further adjustments needed?

That's fine, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

