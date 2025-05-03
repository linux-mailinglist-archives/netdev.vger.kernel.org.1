Return-Path: <netdev+bounces-187595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4857FAA7F8D
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFE27B2335
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489C1B4227;
	Sat,  3 May 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ijit1WbY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6A1A5BB9
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746262921; cv=none; b=XLgEKgNy/ixACSYE0MLIRuzUhyBE2Xej2JgXEpTKx0ZUPynVDDRNAeorkXZET7DkI8d0udIYLxlqK5JCR9IV2iN6d9dpOeO9vzzHTFzD140Mg4DVqeQSh7BvxTiuypbk/aJdtMaIPqaK8hLnHYf8grhVE8pPf7qDKnFbg2jBcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746262921; c=relaxed/simple;
	bh=T8MKXV5WAx/tZWm4ASzjUlrclkJ1PW8Gx1hMA6xliQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC4bUH1mptbLJ/TIPDVZICBedUWvJgZm3lb7E49+izRmR8vc2smrvTnNnUt7LkLEhlbqFHP8829qTG/5ZRP5yP3J111ZtbmubOSlGN1+AwBy32L2YEFLrfbJ+4Y/KQuGBfgSQMoPinXNfp6xXdMIPVpnXPuTiBNB+FEb5iee1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ijit1WbY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0ccW1oXGvmd8gqUNZ/j59iLCK7owhNrD948/V9jYLGk=; b=ijit1WbYamYv45iAgfjDIPxmbA
	gyCyDXhZvfFCzv5A9UTtCUd6VQepfCR/oxIcewYTaZK8A8xEM4LqM8BN/FOSipLkFQzPXQ+NlkZHn
	NM68cSefwS5yI05VcLqzxeXT76PBNWTZzLSVaevFMyYYS2Mbo/4QgEiaoJaTqS5PaRksgRh7TVTuU
	E9eRGZRjnX9+fv6HZtXaX+7ZOrfy390fQ1FPBWD0lH9vfxO7AedsOrHO89sFFBtEbjnZXtnudoAKU
	1ZNBnXRQCfV9UesnRElx9J39kNeCrpBZ7/VmTaBPwufEdAwe5OqGN9s++jL5c2MwwQgptM0lPZJ7b
	stgI/0qw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44420)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uB8kq-0002HX-29;
	Sat, 03 May 2025 10:01:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uB8ko-0001a7-2j;
	Sat, 03 May 2025 10:01:50 +0100
Date: Sat, 3 May 2025 10:01:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+netdevbpf@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/6] net: stmmac: replace speed_mode_2500()
 method
Message-ID: <aBXbfpbmuZzQefx9@shell.armlinux.org.uk>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <174623583625.3773265.4045311227752993763.git-patchwork-notify@kernel.org>
 <aBXbAwMC4V_3cmj6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBXbAwMC4V_3cmj6@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Ignore me, not enough coffee. Sorry for the noise.

On Sat, May 03, 2025 at 09:59:48AM +0100, Russell King (Oracle) wrote:
> Err, I sent v2 a couple of days ago, did patchwork not see it?
> 
> On Sat, May 03, 2025 at 01:30:36AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> > 
> > On Thu, 1 May 2025 12:45:21 +0100 you wrote:
> > > Hi,
> > > 
> > > This series replaces the speed_mode_2500() method with a new method
> > > that is more flexible, allowing the platform glue driver to populate
> > > phylink's supported_interfaces and set the PHY-side interface mode.
> > > 
> > > The only user of this method is currently dwmac-intel, which we
> > > update to use this new method.
> > > 
> > > [...]
> > 
> > Here is the summary with links:
> >   - [net-next,1/6] net: stmmac: use a local variable for priv->phylink_config
> >     https://git.kernel.org/netdev/net-next/c/5ad39ceaea00
> >   - [net-next,2/6] net: stmmac: use priv->plat->phy_interface directly
> >     https://git.kernel.org/netdev/net-next/c/1966be55da5b
> >   - [net-next,3/6] net: stmmac: add get_interfaces() platform method
> >     https://git.kernel.org/netdev/net-next/c/ca732e990fc8
> >   - [net-next,4/6] net: stmmac: intel: move phy_interface init to tgl_common_data()
> >     https://git.kernel.org/netdev/net-next/c/0f455d2d1bbe
> >   - [net-next,5/6] net: stmmac: intel: convert speed_mode_2500() to get_interfaces()
> >     https://git.kernel.org/netdev/net-next/c/d3836052fe09
> >   - [net-next,6/6] net: stmmac: remove speed_mode_2500() method
> >     https://git.kernel.org/netdev/net-next/c/9d165dc58055
> > 
> > You are awesome, thank you!
> > -- 
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> > 
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

