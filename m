Return-Path: <netdev+bounces-242636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B314C933E1
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 23:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCDDE34A0F9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A32C08B6;
	Fri, 28 Nov 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeSOjpZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCE339A8;
	Fri, 28 Nov 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368233; cv=none; b=KiKdmFyo8mNbwqgLKZsnUnaBrFdm5hhkh326X+QMb2pn6RPsOLRFM+SMIkyEf8IbdTWHvfGcoXSF41wJlXgBuj2hGUJPOHnmGNxE0tkQW+dUMtb1tWSbeKmkNGtPCY/baImOKE2pS/1ugcTnh89l00ljRawZfL+fGjjrNTfb1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368233; c=relaxed/simple;
	bh=VK3TROkm++47NldOYtUn5768UQNgyjfwlBEzoPIfPwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=desVnFZjlAH+vFfWSfNESQSj00E6pQBg1Xe3H6wMOyKA7J/tPsmP7yO7ZTV07ewIlz6Zllq+RHNBOST1ugbp5Q7v/jevlzcNEgyJEayRZWw7LRRvPhys8CZ+IcXTkI26zpDGfnyFG6/jEeCe3+fKUR0UfWeWrdT8bskgv8XwFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeSOjpZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA1CC4CEF1;
	Fri, 28 Nov 2025 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764368233;
	bh=VK3TROkm++47NldOYtUn5768UQNgyjfwlBEzoPIfPwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DeSOjpZMMzqaR0W4PR0o3fCvOkMhFOJ7Rw8Ru6e5xod68/kQi1y2eMmMEsvoKf4Df
	 YHbzCcmJlNVFWfncGpG5Dti5kPYMbLhcvDDBKoLavDfnN20NCQMzWPwAWdXbTlv3Ih
	 OgaiNsYwVPXqz+OwqgrUHuQxR4233qQ7QgJ+uAHcPyHPMA28N/ipdK30JNPvvUv5pD
	 fc6M6vUKkM2ZgvyuQDZIkiFoPHc2s/g+28dqeik++BjGSuVjxhJpo6oNrlzCXPxOik
	 ih31NtB2FPmSXWoKTja6iJ2PVn9Tpta6Lql5QK47BcFslkSPaThvcNzrrH6x16au5L
	 spxINepkPoUrA==
Date: Fri, 28 Nov 2025 14:17:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov
 <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Rob Herring
 <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Jonathan
 Corbet <corbet@lwn.net>, John Fastabend <john.fastabend@gmail.com>, Lukasz
 Majewski <lukma@denx.de>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Divya.Koppera@microchip.com, Kory
 Maincent <kory.maincent@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, Sabrina Dubroca
 <sd@queasysnail.net>, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20251128141710.4fa38296@kernel.org>
In-Reply-To: <aSoIREdMWGeygnD_@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
	<20251125181957.5b61bdb3@kernel.org>
	<aSa8Gkl1AP1U2C9j@pengutronix.de>
	<aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
	<aSj_OxBzq_gJOb4q@shell.armlinux.org.uk>
	<aSljeggP5UHYhFaP@pengutronix.de>
	<20251128103259.258f6fa5@kernel.org>
	<63082064-44b1-42b0-b6c8-a7d9585c82f5@lunn.ch>
	<aSoIREdMWGeygnD_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 20:38:28 +0000 Russell King (Oracle) wrote:
> On Fri, Nov 28, 2025 at 09:16:24PM +0100, Andrew Lunn wrote:
> > > Can you please tell me what is preventing us from deprecating pauseparam
> > > API *for autoneg* and using linkmodes which are completely unambiguous.  
> > 
> > Just to make sure i understand you here...
> > 
> > You mean make use of
> > 
> >         ETHTOOL_LINK_MODE_Pause_BIT             = 13,
> >         ETHTOOL_LINK_MODE_Asym_Pause_BIT        = 14,
> > 
> > So i would do a ksettings_set() with
> > 
> > __ETHTOOL_LINK_MODE_LEGACY_MASK(Pause) | __ETHTOOL_LINK_MODE_LEGACY_MASK(Asym_Pause)
> > 
> > to indicate both pause and asym pause should be advertised.
> > 
> > The man page for ethtool does not indicate you can do this. It does
> > have a list of link mode bits you can pass via the advertise option to
> > ethtool -s, bit they are all actual link modes, not features like TP,
> > AUI, BNC, Pause, Backplane, FEC none, FEC baser, etc.  
> 
> I see the latest ethtool now supports -s ethX advertise MODE on|off,
> but it doesn't describe that in the parameter entry for "advertise"
> and doesn't suggest what MODE should be, nor how to specify multiple
> modes that one may wish to turn on/off. I'm guessing this is what you're
> referring to.
> 
> The ports never get advertised, so I don't think they're relevant.
> 
> However, the lack of the pause bits means that one is forced to use
> the hex number, and I don't deem that to be a user interface. That's
> a programmers interface, or rather a nightmare, because even if you're
> a programmer, you still end up looking at include/uapi/linux/ethtool.h
> and doing the maths to work out the hex number to pass, and then you
> mistype it with the wrong number of zeros, so you try again, and
> eventually you get the advertisement you wanted.
> 
> So no, I don't accept Jakub's argument right now. Forcing people into
> the nightmare of working out a hex number isn't something for users.

I did some digging, too, just now. Looks like the options are indeed
not documented in the man page but ethtool uses the "forward compatible"
scheme with strings coming from the kernel. So this:

  ethtool -s enp0s13f0u1u1 advertise Pause on Asym_Pause on

works just fine, with no changes in CLI.

We should probably document that it works in the ethtool help and man
page. And possibly add some synthetic options like Receive-Only /
Transmit-Only so that users don't have to be aware of the encoding
details? Let me know if it's impractical, otherwise I think we'll
agree that having ethtool that makes it obvious how to achieve the
desired configuration beats best long form docs in the kernel..

