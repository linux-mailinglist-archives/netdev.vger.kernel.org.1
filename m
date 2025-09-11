Return-Path: <netdev+bounces-222247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE34BB53B10
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C25A1C72
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FCB36209B;
	Thu, 11 Sep 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yrojD4qb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0163570B6;
	Thu, 11 Sep 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614177; cv=none; b=A9/wYIysn4vZkKLrqPG7mZ52i6N7PmnTzATlS1a9yRJOF+Cs/BgsikSSC+ACFO3FuFAJdsTGLDsaS4e6r3gOQtXDT7J/MpMKZdGFsRFzZDb4OoRCeZYjVPkl5fxMOvuxmuUzCt/MsK6bQiTPihCWbzwS1c3zFoIA4sJXNP0n02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614177; c=relaxed/simple;
	bh=7gyBEPCZbqL0kKqBIVT/lC6z6mvxa3onrOUFzkyl4KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNNDGuaIPpUg7XpBpHfBedUB+7rQOiPGmOw0BlxkjRNeJUeHfHRKvCx7UkjA2utT2u12IEvcKRXwFT2xWTno8I7kzKssAp8DY58SNeVaa2s8gqufvsluNWwqPzWREd1UHcct9WUyFQUmilL0uv+fCHPfvc5wOHzwywD7JMt+k2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yrojD4qb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VOf/scVy2/G7nPu4vUJje7URYboKIf5FDPfqbmkuw4I=; b=yrojD4qbElqBAA+wqTnlfX3xdH
	tDMGY8wVO1Lpn3f53UpM/T2uQ1OSY2ePxsyvi/UQjR8SqTMVg6ZPMCpMrc0QgPFLBx0Xj2bDEdqIq
	0EYxG60KEWIh5KFszlghcXAswWB6OLonPDIhtEwbOEa8cBfJeym1PdxqdJyUodql16E8vb1DlINni
	xhzLu2bjiSb5tBnZ++rO44wmSq5DOJLviLdvfno3H9e1R4Kq4tybrImmuGHLPjEvV4qNcoLO5Iodw
	/pyHPI/IQcmHZiGHOQCgptmRJqk8XCn6j1D50gAzuFWbt6SAHFBbmYTtmoDxjZx7VjtMZ2QW5hPsf
	Y7SxxKIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53308)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwljS-000000003Rb-0HkQ;
	Thu, 11 Sep 2025 19:09:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwljN-000000002Y4-3cKS;
	Thu, 11 Sep 2025 19:09:13 +0100
Date: Thu, 11 Sep 2025 19:09:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v4 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <aMMQSR7yYBQkY4CI@shell.armlinux.org.uk>
References: <20250908181059.1785605-1-wens@kernel.org>
 <20250908181059.1785605-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908181059.1785605-3-wens@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

I drafted this but never sent it and can't remember why, but it's
relevant for v5 that you recently posted. Same concern with v5.

On Tue, Sep 09, 2025 at 02:10:51AM +0800, Chen-Yu Tsai wrote:
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		/* default */
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		reg |= SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		reg |= SYSCON_RMII_EN;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Unsupported interface mode: %s",
> +				     phy_modes(plat->mac_interface));

I'm guessing that there's no way that plat->phy_interface !=
plat->mac_interface on this platform? If so, please use
plat->phy_interface here.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

