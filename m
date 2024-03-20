Return-Path: <netdev+bounces-80766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47714881005
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676BF1C20B0A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAA18EC0;
	Wed, 20 Mar 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pdWjZIPo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3453A1B7
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931040; cv=none; b=ShYlQFeUPGYgf3GD8TicTFmZRdidHwdcNk88NmbxBjT1UxXP/JvvFl3k9G/JE6oyIYz30+vPPVFhtau6GvBgE70dgUtEZ/TTqJ+RGWunQrNUby6PR/YSCymrV+61IOOcBhJdyjmv54FbazIjfdHXHpv1dbf6B1JnM8ZEMbJ3Or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931040; c=relaxed/simple;
	bh=bGYZPRE5BeluHV9asZuVsW6WsmW9v46NpFevMLe2HF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1FuupN/va7igQz2qCt2mOE8+ynSkzW/sMAY4J0aogZjjYFxoDW4Nk97heOs1zhVxz5DByTDiHrQUlu9cMw/7eQgwdGDLeAC64PEWp4jY2KjpA2SdCMtpBEuPpoZM+yxN+sXl/JtgCMjxsMweGfVAdkKRlKYnhUXDKK9DAtFJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pdWjZIPo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GWfHJsOMo2n7O1EmxZuugc7xWe5UCPjlrv3wOd4FVfE=; b=pdWjZIPo5InxlAoatYTD67yX+l
	V8mt/v8vZ+3ot6SlaoTAVHzWMGvyRF19+QKZMoipUSSw12R+KMXlIkqjdCliK/UZbQPipeEdUxym+
	UYIgeLr5bVNzupnpg8pkdb58IhSh+iKKvtI73ry/isn0cqcU1UroRuWq15HSfgtifIheNRgKP/Jzx
	fYCP/w0mR3w2JqkZsPH81ep6yUHEEObLAO4Bp2hcuAyHgqkM+FlZNRdjhBRU04X7Beizi++wYNMFQ
	FdiNrnqHfrrAzLnWq0Yj0AfR/D1yqnKGKmsvSUmtjCOFxC1rKjK4J3WoDmJe3h7NeI1mskYokt311
	r6U7qBDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33492)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmtJf-0006S3-18;
	Wed, 20 Mar 2024 10:37:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmtJc-0002Zr-6C; Wed, 20 Mar 2024 10:37:00 +0000
Date: Wed, 20 Mar 2024 10:37:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <Zfq8TNrt0KxW/IWh@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
 <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
 <88c8f5a4-16c1-498b-9a2a-9ba04a9b0215@loongson.cn>
 <ZfF+IAWbe1rwx3Xs@shell.armlinux.org.uk>
 <cd8be3b1-fcfa-4836-9d28-ced735169615@loongson.cn>
 <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em3r6w7ydvjxualqifjurtrrfpztpil564t5k5b4kxv4f6ddrd@4weteqhekyae>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Serge,

Again, please learn to trim your replies.

On Wed, Mar 20, 2024 at 01:10:04PM +0300, Serge Semin wrote:
> > > As to this approach, I don't think it's a good model to override the
> > > stmmac MAC operations. Instead, I would suggest that a better approach
> > > would be for the platform to provide its capabilities to the stmmac
> > > core code (maybe a new member in stmmac_priv) which, when set, is used
> > > to reduce the capabilities provided to phylink via
> > > priv->phylink_config.mac_capabilities.
> > > 
> > > Why? The driver has several components that are involved in the
> > > overall capabilities, and the capabilities of the system is the
> > > logical subset of all these capabilities. One component should not
> > > be setting capabilities that a different component doesn't support.
> 
> In general you are right for sure - it's better to avoid one part
> setting capabilities and another part unsetting them at least from the
> readability and maintainability point of view. But in this case we've
> already got implemented a ready-to-use internal interface
> stmmac_ops::phylink_get_caps() which can be used to extend/reduce the
> capabilities field based on the particular MAC abilities. Moreover
> it's called right from the component setting the capabilities. Are you
> saying that the callback is supposed to be utilized for extending the
> capabilities only?

What concerns me is that the proposed code _overwrites_ the
capabilities from the MAC layer, so from a maintanability point of
view it's a nightmare, because you will now have the situation where
MACs provide their capabilities, and then platform code may overwrite
it - which means it's like a spiders web trying to work out what
capabilities are provided.

The reality is surely that the MAC dictates what it can do, but there
may be further restrictions by other components in the platform, so
the capabilities provided to phylink should be:

	mac_capabilities & platform_capabilities

And what I'm proposing is that _that_ should be done in a way that
makes it _easy_ for the platform code to get right. Overriding
stmmac_ops::phylink_get_caps() doesn't do that - as can be seen in
the proposed patch.

Help your users write correct code by adopting a structure that makes
it easy for them to do the right thing.

> If you insist on not overriding the stmmac_ops::phylink_get_caps()
> anyway then please explain what is the principal difference
> between the next two code snippets:
> 	/* Get the MAC specific capabilities */
>         stmmac_mac_phylink_get_caps(priv);
> and
> 	priv->phylink_config.mac_capabilities &= ~priv->plat->mac_caps_mask;


I was thinking:

	stmmac_mac_phylink_get_caps(priv);

	if (priv->plat->mac_capabilities)
		priv->phylink_config.mac_capabilities &=
			priv->plat->mac_capabilities;

In other words, if a platform sets plat->mac_capabilities, then it is
providing the capabilities that it supports, and those need to reduce
the capabilities provided by the MAC.

This will _also_ allow stmmac_set_half_duplex() to do the right thing.
Consider something in the platform side that doesn't allow half-duplex,
but allows tx_queues_to_use == 1. That'll set the half-duplex modes
when stmmac_set_half_duplex() is called, overriding what the platform
supports.

Now that I look at the stmmac implementation, there's even more that
is wrong. Consider plat->max_speed = 100, like
arch/arc/boot/dts/axs10x_mb.dtsi sets. If stmmac_set_half_duplex()
is called as it can be from stmmac_reinit_queues(), it'll enable
1000 half-duplex, despite the plat->max_speed = 100.

> in the MAC-capabilities update implementation? Do you think the later
> approach would be more descriptive? If so then would the
> callback-based approach almost equally descriptive if the callback
> name was, suppose, stmmac_mac_phylink_set_caps() or similar?

From what I can see of the existing stmmac MAC phylink_get_caps
implementations, there seem to be two - xgmac_phylink_get_caps()
and dwmac4_phylink_get_caps(). Both of these merely set additional
modes in priv->phylink_config.mac_capabilities. Is there a reason
to have this as an instruction stream, rather than providing data
to the core stmmac code from the MAC about its capabilities? Is
there a reason why it would be necessary for the code in a MAC backend
to make a decision about what capabilities to enable based on some
condition?

> In anyway I am sure the approach suggested in the initial patch of
> this thread isn't good since it motivates the developers to implement
> more-and-more DW MAC-specific platform capabilities flags fixing
> another flags, which makes the generic code even more complicated
> than it already is with endless if-else-plat-flags statements.

Yes, I do agree with that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

