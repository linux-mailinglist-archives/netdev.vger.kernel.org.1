Return-Path: <netdev+bounces-60832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751DF821A1D
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23302282F8A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ED2D313;
	Tue,  2 Jan 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PmkeEPzZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA713D2F1
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iv8crqgMiAZjXHdAoXgKE0yfYLjRGHZYS1MYR3F1KSQ=; b=PmkeEPzZTbPBo+tOWdrIgCElpb
	UljhQGbTR2Iuake2aKEjY1anwPFnnG86MtQ/1KgnuYYTJwbiybldsGlLxWbZqufGXelclayVIlndo
	MKXpat1Lkmw7b+2JRb8gcPPJcmmnf0UdAk7+0SC6Lel/jOuhhlXCkFiAWeJ4VegXQgUWcrjBZ2AzC
	uUXBj/n+phydOYdQbshPW382/jufP0LGJl1l4llR8yHDu+cAOqKos0dv1I0hItO2EzkbWHNYle78F
	0fSNXE7j5aak0ggDf/tsB5hFQBvTxfafdH8jVSFbHfoEV2XRoFKjrCb5JPLwmpFHXQI947YkVe5iF
	4Azml0xw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcCO-0006P7-2Z;
	Tue, 02 Jan 2024 10:40:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcCP-0005CL-MA; Tue, 02 Jan 2024 10:40:41 +0000
Date: Tue, 2 Jan 2024 10:40:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 3/9] net: stmmac: dwmac-loongson: Add full
 PCI support
Message-ID: <ZZPoKceXELZQU8cq@shell.armlinux.org.uk>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <b43293919f4ddb869a795e41266f7c3107f79faf.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43293919f4ddb869a795e41266f7c3107f79faf.1702990507.git.siyanteng@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 19, 2023 at 10:17:06PM +0800, Yanteng Si wrote:
> @@ -125,42 +126,48 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_disable_device;
>  
> -	bus_id = of_alias_get_id(np, "ethernet");
> -	if (bus_id >= 0)
> -		plat->bus_id = bus_id;
> +	if (np) {
> +		bus_id = of_alias_get_id(np, "ethernet");
> +		if (bus_id >= 0)
> +			plat->bus_id = bus_id;
>  
> -	phy_mode = device_get_phy_mode(&pdev->dev);
> -	if (phy_mode < 0) {
> -		dev_err(&pdev->dev, "phy_mode not found\n");
> -		ret = phy_mode;
> -		goto err_disable_device;
> +		phy_mode = device_get_phy_mode(&pdev->dev);
> +		if (phy_mode < 0) {
> +			dev_err(&pdev->dev, "phy_mode not found\n");
> +			ret = phy_mode;
> +			goto err_disable_device;
> +		}
> +		plat->phy_interface = phy_mode;
>  	}
>  
> -	plat->phy_interface = phy_mode;
> -

So this is why phy_interface changes in patch 2. It would have been good
to make a forward reference to this change to explain in patch 2 why the
"default" value has been set there. Or maybe move the setting of that
default value into this patch?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

