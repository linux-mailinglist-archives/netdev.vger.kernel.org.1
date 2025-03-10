Return-Path: <netdev+bounces-173471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB0A59233
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C21188ED56
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35D226CFF;
	Mon, 10 Mar 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EORwAhbX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C701B4138;
	Mon, 10 Mar 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604777; cv=none; b=qx3MQdyDUE2ZDSIumIb5M7SjC0BL7n+gIsBfpOhmOwZ0HelLADswG2/f5kq5/K30MaO2NoynToTmt6a7+Uo9XykjYpLrsabr9cRR2aGYTQWmFrIPqfqRR4AzBorZ/m/lovYd6EQuzSNXGv1YjKxKSVbR9CVg2z5+xkqeh3tYjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604777; c=relaxed/simple;
	bh=+vAYszaLuAjc+++c5UH/i1OBbtRd6LtGOcYREzENjkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmuZ8DyyTAOF66xUv3V9FXvNy9zbHtDmLpXkm0cKrQwxKvYuAI1wjHnOz282llreAxvKGpqXR5AA6EpnyVOpSpP4ZOuKyEKRMYGKMHMmwVo1JOPmjbieFtmmbderRbasG/f2UwdizDYhyUDQVOsFLk9y/GQ0YH3qA11q4vSgwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EORwAhbX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iw/s6OMG43ULsx4UXStKq7FqeOmxKAHk2WEArxE2pKc=; b=EORwAhbX8xg68mKTCSZ8Cd4emp
	72FX7gvakjH7BgEDp4dCeBtZPaJNNudFmrcMoRorA8RboAINJFMXRmz18BuRI6UJOfG6NlXKAnStJ
	U1Bnz8sje/QPQhE/CsOk8XVVF2PoXdiQRWlXF9NWW22HVFvkHssgad2+BiCfQll4YgFMwGm8R+fXm
	VaFTmKi+Me65kz+CCSq7Qw6IgNgT2YUC11negNR3qvEFMmsdhU1LzWuRLB4SjEEIElcFl+iS+J8UB
	yQO4ntjt19o3zayOgCKopfjtDFP7Zdg/LozF+SZ6mkUBHm/Poj9rXthJJLKwvw0NzzvM9yqbfC9sf
	k8tjv3Ow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47598)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1traxJ-0002RJ-11;
	Mon, 10 Mar 2025 11:05:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1traxF-0002PQ-1W;
	Mon, 10 Mar 2025 11:05:53 +0000
Date: Mon, 10 Mar 2025 11:05:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 12/13] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <Z87HkcdK2QTjooDK@shell.armlinux.org.uk>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-13-ansuelsmth@gmail.com>
 <Z83WgMeg_IxgbxhO@shell.armlinux.org.uk>
 <67cec5a9.170a0220.93f86.9dcf@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67cec5a9.170a0220.93f86.9dcf@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 10, 2025 at 11:57:41AM +0100, Christian Marangi wrote:
> > > +static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> > > +			     phy_interface_t interface,
> > > +			     const unsigned long *advertising,
> > > +			     bool permit_pause_to_mac)
> > > +{
> > > +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> > > +	u32 val;
> > > +	int ret;
> > > +
> > > +	/*                   !!! WELCOME TO HELL !!!                   */
> > > +
> > [... hell ...]
> 
> Will drop :( It was an easter egg for the 300 lines to configure PCS.

That wasn't a request to drop the comment, just that I didn't want to
include all that in my reply.

> > I guess, however, that as you're only using SGMII with in-band, it
> > probably doesn't make much difference, but having similar behaviour
> > in the various drivers helps with ongoing maintenance.
> 
> Do we have some driver that implement the logic of skipping the bulk of
> configuration if the mode doesn't change?

For many, it doesn't matter, but for e.g. xpcs, there may be a reset
of the XPCS when the mode changes, and there's workarounds for the
TXGBE - both of those only happen when the interface mode actually
changes.

Re-reading my .pcs_config() documentation, I really ought to mention
that .pcs_config() will be called for both interface mode changes and
for advertisement changes, and should not disrupt the link when
nothing has changed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

