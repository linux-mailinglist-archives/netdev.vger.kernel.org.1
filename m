Return-Path: <netdev+bounces-237625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF8C4DEF0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19A03A4909
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2163A5E8F;
	Tue, 11 Nov 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M81qm0j8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7363A5E69;
	Tue, 11 Nov 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864400; cv=none; b=f4W11eNd69msvA/ONwc9bNl6KSe3eppBkeJStp10NVu9TlI2Gdl/KQVTBiY1SraEimOn0KPzwxy6X9kWtyVvJyd32hCtw8cVeyUolblJkI1ezIpn3p0NT76qHnBi3NeolVQQNllh9rbIQ91CSigFwGcz5olI6pSUf0OPmGG0v2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864400; c=relaxed/simple;
	bh=tUcevEml60aCxu0vcWYyki56SIwcdZnTa6MQslWRHLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap61QmzLeFQnMe47NrC/9d/YOEDYqQ9KEY3fxJBinMcwo8YCtV04P0xEXkgmkl3a5cCtPsNE3iZ59+yCZ1dnmghhk/erhn8U1MyGcXRM8PtlfZrnCHaOAxyZ/yYceF2Ohex/f6NFPvZ0rKlHvjdegJBcACsmHUYc38l/tFcAjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M81qm0j8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Al8MnEVsZ+ylXBq1N4ofH08Ykvoq5VV8Ot/D8r7iKaM=; b=M81qm0j8/9TwbBIkmlnsL2lCaW
	d6emkWPoeNCmU/+eMPYmiZKdlHtzNzFM6kRnbB09EzR1zeJ8Z5VCkieiPZ2B6p/DDuaKmU/dv8eVr
	yclseV17+yjWlKtAOohKHt7uKvA1pQ6bdoqlHBr3/san1LaxiuBpFIAFx5hSHABeRC6zl6YrPj1jP
	bPohxiAZKOU2/Xd/Ee4dyIKsTFTWTgYSm7P/oBvtMBV7AcwXwyoPgxhMFrEwG46JCEeXu43BVb3Nm
	qiLAXuLFFd55pJZZeEShjG0fSwCNF1Vh41Xr29e60PZUlsPwDeJlTS8h2YxYTwzRGrrv/P/OeRZjI
	O1rpM57A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vInYU-000000002aj-1tj1;
	Tue, 11 Nov 2025 12:33:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vInYO-000000002wW-1jkQ;
	Tue, 11 Nov 2025 12:32:56 +0000
Date: Tue, 11 Nov 2025 12:32:56 +0000
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
	Runhua He <hua@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aRMs-B2KndX-JNks@shell.armlinux.org.uk>
References: <20251111105252.53487-1-ziyao@disroot.org>
 <20251111105252.53487-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111105252.53487-3-ziyao@disroot.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 11, 2025 at 10:52:51AM +0000, Yao Zi wrote:
> +	plat->bus_id		= pci_dev_id(pdev);
> +	plat->phy_addr		= -1;
> +	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
> +	plat->clk_csr		= STMMAC_CSR_20_35M;

Could you include a comment indicating what the stmmac clock rate
actually is (the rate which is used to derive this divider) ? As
this is PCI, I'm guessing it's 33MHz, which fits with your divider
value.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

