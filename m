Return-Path: <netdev+bounces-219887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA6B43980
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4433D7B686E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E62FB97A;
	Thu,  4 Sep 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HP6SOgLB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFC2D060C;
	Thu,  4 Sep 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983930; cv=none; b=X++/n38m7NA/d6xpycjAll4C72KvEGLJxK9ltfeOgVc9Hr70XjoxqqW4wsEV4DPevGANH2QJ2jgTmbnETDMyi2BI7yhbU/Nl+MI2JPoHiXGMkiC3GqZ42bqNhoFKqjbXlMB1zmx391ZPGfJhFmMGLNnjE/16VXy6FxYwd7oHJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983930; c=relaxed/simple;
	bh=Gq4KK+DL4/6/PRowWsDzwgVo5Z+T+vaBBB89gBy5UIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMCKhtrU3RqT0IXMH4IO97vxwu+zia0EzJ8Z2ova6hY/L/NCiTyBQG1t/c6CVlxIKLnkqgmn7ZPyAHlwDRqjr/rbW2UUHfR2RTdBJdtX8lnDVuxnZwPryByERghpwErVFrl1FxMWmw8yBGujN9FcSEj/mNMDtiK4d42auUfwDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HP6SOgLB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PrZXrE8m4b6VE58jUKKj5WGOEJfOjU7pp7prPNE0Z9Y=; b=HP6SOgLB686PBk0qc6hRAnXjUl
	oPUd/osUYYtpYBh5wkx/Rfzj6j9ZinhRXVFxvPPYqhvXiolj2mhJRuRoehEWoowWGTrGM3TiOHV38
	c5ZVuOH8GhNJaiyknBgBhWrHz9HDxW0aZp7QzPzUZYluQWqgV4f2f5WzenHosRWXBBpf840z3gee6
	6pHV291CkgIU6+BzO2B+LSnW7XYPgFRsc96fcTTFqITKaD2WHoy4NDVJSFiiuDhUJlyQHn9LfmcL3
	rte8Tjwko4kcKaL4feZNoElphViui4rHHlfyVxYOm9zWw6EtBUjf9xTx8h2UIjVqtD2Simm5b576W
	fVnviNVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33562)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu7mL-000000001rr-0hSY;
	Thu, 04 Sep 2025 12:05:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu7mJ-000000001SE-17WY;
	Thu, 04 Sep 2025 12:05:19 +0100
Date: Thu, 4 Sep 2025 12:05:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't
 contain invalid address
Message-ID: <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
 <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 07:03:10PM +0800, Chaoyi Chen wrote:
> 
> On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
> > On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
> > >   	if (plat->phy_node) {
> > >   		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
> > >   		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
> > > -		/* If it is not integrated_phy, clk_phy is optional */
> > > +		/*
> > > +		 * If it is not integrated_phy, clk_phy is optional. But we must
> > > +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
> > > +		 * the error code could be wrongly taken as an invalid pointer.
> > > +		 */
> > I'm concerned by this. This code is getting the first clock from the DT
> > description of the PHY. We don't know what type of PHY it is, or what
> > the DT description of that PHY might suggest that the first clock would
> > be.
> > 
> > However, we're geting it and setting it to 50MHz. What if the clock is
> > not what we think it is?
> 
> We only set integrated_phy to 50M, which are all known targets. For external PHYs, we do not perform frequency settings.

Same question concerning enabling and disabling another device's clock
that the other device should be handling.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

