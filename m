Return-Path: <netdev+bounces-169901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C6A46583
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E9B7AC60F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F5225779;
	Wed, 26 Feb 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QudsgOBL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7921CC5A;
	Wed, 26 Feb 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584624; cv=none; b=uzunRmLQXAAQ/59X8IrCJtcs7zfDs+HfsSQ/IImyEA1AyJFUyS3rNM9SreCbvpbDWq4CjanHg0JoF85mkQPG+8jsHrFGHCyKunt9qybdMjy6xXjfWN0de5tehnt/X1zfsdqLjeFnnXnDw9QIsbDhucwV6gTB0pFOH92fptDOjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584624; c=relaxed/simple;
	bh=W2mrQHahTBEUsp/oHyu49BwYHBcOXCuizUf355LxUDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6DVBrYMJ/dzmOVw0n8yN8OGp6b8SaYuLUSr9y3zdtgj3/ht1VLp/teuBL4YgxXotszgSO/ehAqOXUVP3GkPjQO0ul4MM94iTpQpdVSxiWlEitLkA9D52Lo8V2TwtNp97rBMynfB3JhTZResTVBLhElOJ3qZ34N2FnlqoQNW7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QudsgOBL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a/Qb5wr4Rktc7tGiLjgQsav252MOo0XtSMwhk7qeqzs=; b=QudsgOBLA9IYJ3c1Izp+exRAYJ
	I6tGKvgOw4TgPpxeHoFVHf4MSl9ILu7W+9BjMZHD6rWe+ZyqrdbM6uZFpBUI5XCZ+irh8rJE0wyx6
	BWjjWJRHN7p+ZRePLH+aQnZAq6pvC8LgE3WdRL6pVN01ai14LVj8M3qpmBgvIeeO1twxc5/Z+slHJ
	kkivBkwv2WLg9kLWreuvHJ6zhSzamCKGFVRiAC9UZHNPEn4WGBod2FefrsfgHXEk2XaMcgL84Bu1Z
	YwWqkWFwZSnzxGFIDlwzLUBRXGQsNf4oNRFb2YAEkqoVl3SoHzvZN3nxQk0JbJOG87KUJtRuQGzOI
	H50kXAJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40300)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnJZ1-0004ky-0z;
	Wed, 26 Feb 2025 15:43:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnJYx-0007Dk-1g;
	Wed, 26 Feb 2025 15:43:07 +0000
Date: Wed, 26 Feb 2025 15:43:07 +0000
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
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v8 4/6] stmmac: intel: configure SerDes
 according to the interface mode
Message-ID: <Z782i67tlpj6d57m@shell.armlinux.org.uk>
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
 <20250226074837.1679988-5-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074837.1679988-5-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 03:48:35PM +0800, Choong Yong Liang wrote:
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 6d2aa77ea963..af22a11c2b8a 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -236,6 +236,10 @@ struct plat_stmmacenet_data {
>  	int (*serdes_powerup)(struct net_device *ndev, void *priv);
>  	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
>  	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
> +	int (*mac_finish)(struct net_device *ndev,
> +			  void *priv,
> +			  unsigned int mode,
> +			  phy_interface_t interface);
>  	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
>  	int (*init)(struct platform_device *pdev, void *priv);
>  	void (*exit)(struct platform_device *pdev, void *priv);

This should be part of patch 5, and the order of patches 4 and 5
reversed.

The subject line should also be "net: stmmac: ..."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

