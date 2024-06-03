Return-Path: <netdev+bounces-100231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA778D843D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557FA2836EA
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1612D769;
	Mon,  3 Jun 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HQNIuOPp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FA12D767;
	Mon,  3 Jun 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422119; cv=none; b=Hbd81G59Y3Ot4yHfoCLfsiHoHaPRPv0pX9xeY0R1B9adeavl/ULGqjwMiUfI9GZ9bpJTey0rFreRgep+dZ5i+EpbcYIm7qT/deieU3OX9sPmrf6w27Stohy/0b7vdeGOusrXXmwWjEH1reXz3QGNAdkHd9C5IauA0lnAMPF5V44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422119; c=relaxed/simple;
	bh=OhRPQVA+nlxtKCwbRW1dsWRDMm4egZj4cJ4Hhi74VsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GngKyfBXQ3EpElaw/lIoNCLRHpF8Ob74/srqjG94VdO9/8QipgG+jHkEzXEPMDtlp38l+MbXYC2/koAk8Mj0Dj18FT9GfqzFSuBHgsTOHTGEuxhbp40OJDdkWNxPGuQqAeIgIzdjkmX1t31RYWHCS5uV1XBEGyMT5XwjslV6uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HQNIuOPp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M5ah77INyaKh5P58D9AxRt+KkH3818+oFIrbjxKeZn4=; b=HQNIuOPpNyUPOdCjHpx4IOa0dA
	1d1T3e6XNFKcNIxNLB1yd+IcAdrHeeja7KY6gJQ8l7EnkmT8TkcE9fRwvoZiKrE4UuKeIbXS+p1Pz
	hIqFe9H/0nX7W2GCfUdm2Kj8nfTTCEL5bkiwai7t1IBmiyMRVfN4c/Gn+p+NAp6YMPrzOhP5Pm4/3
	yte5ny25yih4EIAs2voq8DE2Gft6jYXx5j1s90s5LHVA0s4t0yptm2gA2ZiR883rRPOuUzK6K6qE5
	iDr0MVNU3OSf0zG9M9/YIIIHxz6Y/jDLlcpKPwEgFuEAlfHJ8ylbsk5n9oMsIIBzwYU5aAvNZ/6Wn
	GlQqp5Wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE7wW-0002oi-0I;
	Mon, 03 Jun 2024 14:41:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE7wW-0000UV-T1; Mon, 03 Jun 2024 14:41:44 +0100
Date: Mon, 3 Jun 2024 14:41:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <Zl3IGN5ZHCQfQfmt@shell.armlinux.org.uk>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
 <Zl3ELbG8c8y0/4DN@shell.armlinux.org.uk>
 <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl3Fwoiv1bJlGaQZ@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 02:31:46PM +0100, Daniel Golle wrote:
> On Mon, Jun 03, 2024 at 02:25:01PM +0100, Russell King (Oracle) wrote:
> > On Mon, Jun 03, 2024 at 08:18:34PM +0800, Sky Huang wrote:
> > > Add support for internal 2.5Gphy on MT7988. This driver will load
> > > necessary firmware, add appropriate time delay and figure out LED.
> > > Also, certain control registers will be set to fix link-up issues.
> > 
> > Based on our previous discussion, it may be worth checking in the
> > .config_init() method whether phydev->interface is one of the
> > PHY interface modes that this PHY supports. As I understand from one
> > of your previous emails, the possibilities are XGMII, USXGMII or
> > INTERNAL. Thus:
> > 
> > > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > > +{
> > > +	struct pinctrl *pinctrl;
> > > +	int ret;
> > 
> > 	/* Check that the PHY interface type is compatible */
> > 	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL &&
> > 	    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
> > 	    phydev->interface != PHY_INTERFACE_MODE_USXGMII)
> > 		return -ENODEV;
> 
> The PHY is built-into the SoC, and as such the connection type should
> always be "internal". The PHY does not exist as dedicated IC, only
> as built-in part of the MT7988 SoC.

That's not how it was described to me by Sky.

If what you say is correct, then the implementation of
mt798x_2p5ge_phy_get_rate_matching() which checks for interface modes
other than INTERNAL is not correct. Also it means that config_init()
should not permit anything but INTERNAL.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

