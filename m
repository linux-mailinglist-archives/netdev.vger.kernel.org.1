Return-Path: <netdev+bounces-215572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9AFB2F4CC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5984C581A4D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA952E040E;
	Thu, 21 Aug 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eGHTdq6K"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667C1D88D7;
	Thu, 21 Aug 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770445; cv=none; b=Duy5xAEaqxyolgCbCyrrBzOLFpDUjdmBTYHad9FWa+xgGDGn0D6izU6gQpIZ4vghjXlyuo+DQqW7R2tJ4cVJWXwxdwQicVsqJk9gIAswk5R+MAj/d5OVdew1oxIHqC0Cf96WG0i9/lNFeGpgtU5ffbqKe4VQIsdAy5iwsNDybTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770445; c=relaxed/simple;
	bh=mtvswiQ5SSeMSHDWeEdHhKs1GZO+3InF+83bP/3cTqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6PDZxQjtJPwq8Y9XTXghWh2k12qcr8itTNvKjhp99BQ9g0I4+Zat2rY/wld8dvT6eAK4mkUFBi5kxAHg5YW9BkejVw8KC6rfUsCci5DrvO+ys9QHHg7EY6rJt7RsrgpwBKcZdndBuseCFPUk5IBHt9YimBrlFR816xMQeQ3OfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eGHTdq6K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZlYOfAv8FjddmSPNyBHlbUXpqpO5mSxJJvCQgNxAeqg=; b=eGHTdq6KJc3fA31g82lXIkdARE
	zasAcSYoFb/iEOqKBVOnuTl1DQ+CeIt+4CYVREcC5Ihusg6O4lwhFNm6G6xMkX3ZCRKdvKhuaW7xA
	P96w8UwOAiPK8TFxEeTPPXiadm7J09f9W54eZMahnpIjQYYQOPDzep9AljC1ZwxA4y603FCfqPjsu
	OGKagLcPqJD5CuXeAzGd5Own7D0Lrx5rjp3popBLH8YaNcBGPzqDwovnWMLWEmus5c2dsA2IRUlUI
	5W61MrmHw8Y90eeczTr8hlX6WPVCXJVuMfaX1gnzu1AzWGtBOISImaaqWv2KLWydSYux0hz4devcL
	00TnaM7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34670)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1up261-000000000yD-32oU;
	Thu, 21 Aug 2025 11:00:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1up25z-000000000zb-0kcK;
	Thu, 21 Aug 2025 11:00:35 +0100
Date: Thu, 21 Aug 2025 11:00:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 3/3] net: dsa: yt921x: Add support for Motorcomm
 YT921x
Message-ID: <aKbuQ7MCbq1JL9sw@shell.armlinux.org.uk>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-4-mmyangfl@gmail.com>
 <aKbZM6oYhIN6cBQb@shell.armlinux.org.uk>
 <CAAXyoMMGCRZTuhYG0zxTgKdDdgB1brU7BAUiCVR_MheFK-n5Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMMGCRZTuhYG0zxTgKdDdgB1brU7BAUiCVR_MheFK-n5Yw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 21, 2025 at 05:25:46PM +0800, Yangfl wrote:
> On Thu, Aug 21, 2025 at 4:30 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Aug 20, 2025 at 03:54:16PM +0800, David Yang wrote:
> > > +static int
> > > +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
> > > +                const struct phylink_link_state *state)
> > > +{
> > > +     const struct yt921x_info *info = priv->info;
> > > +     struct device *dev = to_device(priv);
> > > +     enum yt921x_fixed fixed;
> > > +     bool duplex_full;
> > > +     u32 mask;
> > > +     u32 ctrl;
> > > +     int res;
> > > +
> > > +     if (state->interface != PHY_INTERFACE_MODE_INTERNAL &&
> > > +         !yt921x_info_port_is_external(info, port)) {
> > > +             dev_err(dev, "Wrong mode %d on port %d\n",
> > > +                     state->interface, port);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     fixed = YT921X_FIXED_NOTFIXED;
> > > +     ctrl = YT921X_PORT_LINK;
> > > +     if (mode == MLO_AN_FIXED)
> > > +             switch (state->speed) {
> >
> > Someone clearly doesn't believe in reading the documentation before
> > writing code. This also hasn't been tested in any way. Sorry, but
> > I'm going to put as much effort into this review as you have into
> > understanding the phylink API, and thus my review ends here.
> >
> > NAK.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> Sorry I'm quite new here. I don't understand very clearly why a
> different set of calls is involved in dsa_switch_ops, so I referred to
> other dsa drivers and made a working driver (at least tested on my
> device), but I would appreciate it much if you could point it out in
> an earlier version of series.

This isn't dsa_switch_ops, but phylink_mac_ops, which are well
documented in include/linux/phylink.h. Please read the documentation
found in that header file detailing the phylink_mac_ops methods.
You'll find a brief overview before the struct, and then in the #if 0
section, detailed per-method documentation.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

