Return-Path: <netdev+bounces-242463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F221C907F7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2CB93468FA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3137221FDA;
	Fri, 28 Nov 2025 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DE9GfBT/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BF1E7C2E;
	Fri, 28 Nov 2025 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293285; cv=none; b=fmiH7P5tci18Flrz+YrV3XsNAaJWSTrQIWsPvvwOaiQAJtDKceobrIJ3SKVLR1uiTItoC7AdNAASSCFuRwjVcyCmo1Z2ulJSZjCX81+CH28CRkEiQ1hA+cB78xVagxYoh9hDmS6z/aM6DsyeWA5P25XrmTWKeS8esRy+I40b0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293285; c=relaxed/simple;
	bh=EC6VIpvMvX58MclFq67zD2UtPTyZSIAX4lQ8cdYwdo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulWclq2JUcaDxbEzRAGMC1gd0RoSGYucYxwTpxG9vD0B8sAOjlqWMysZpHsfLMSgm/N99jCjfo8jtnrwUyJVPA2+lB0BZrYvB/CWGlyalmPB+6bYEOM20Rzt3KsLMZFi862YNzDkSjQEwLkrfvS46v3pP8dQRb38cMY2vkxKjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DE9GfBT/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dTaHVwsRkYwxuIRYsPLfSzXVgx9uJH+oKCS18QdO5tg=; b=DE9GfBT/+j+8/MiNxh1Y7gM0HQ
	1RddE73cNm4qRiBMgtuTk/yz4utXJtAggjenghzXoJp631wPogneY8SttmFIVEiKozkv8PAlkBYfr
	LbOY4QdLIqXHGyHbPwUd1Q0DUY0+C0eKHgzhdNCkzgYVt05+qCNtWFZK077ORBqZ58+OlK3jD0rV/
	W0cbDb+2tGmtRx2SwxP9sz3Wf1BYZHvwWwyNwk4uw2R8/j893A0wtZ7w5x6RWcjKMDbKJO56KEixY
	Zqv6ffQRcKoo+Fm7TJqNG1QJV4CaXTzNVks/VlhAAfDrFgxcbpagBKQqxBXPmcF96kv+fXs7LkGHb
	ZLwba0Qw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vOnGp-000000005q0-1y8C;
	Fri, 28 Nov 2025 01:27:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vOnGj-000000003B4-0c5I;
	Fri, 28 Nov 2025 01:27:29 +0000
Date: Fri, 28 Nov 2025 01:27:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aSj6gM_m-7ZXGchw@shell.armlinux.org.uk>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
 <20251125181957.5b61bdb3@kernel.org>
 <aSa8Gkl1AP1U2C9j@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSa8Gkl1AP1U2C9j@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 09:36:42AM +0100, Oleksij Rempel wrote:
> My current understanding is that get_pauseparam() is mainly a
> configuration API. It seems to be designed symmetric to
> set_pauseparam(): it reports the requested policy (autoneg flag and
> rx/tx pause), not the resolved MAC state.
> 
> In autoneg mode this means the user sees what we intend to advertise
> or force, but not necessarily what the MAC actually ended up with
> after resolution.
> 
> The ethtool userspace tool tries to fill this gap by showing
> "RX negotiated" and "TX negotiated" fields, for example:
> 
>   Pause parameters for lan1:
>     Autonegotiate:  on
>     RX:             off
>     TX:             off
>     RX negotiated:  on
>     TX negotiated:  on
> 
> As far as I can see, these "negotiated" values are not read from hardware or
> kernel. They are guessed in userspace from the local and link partner
> advertisements

They are not "guessed". IEEE 802.3 defines how the negotiation resolves
to these, and ethtool implements that, just the same as how we resolve
it in phylib.

Whether the MAC takes any notice of that or not is a MAC driver problem.

> , assuming that the kernel follows the same pause resolution
> rules as ethtool does. If the kernel or hardware behaves differently, these
> values can be wrong.

If it doesn't follow IEEE 802.3 resolution, then it's quite simply
broken. IEEE 802.3 requires certain resolution methods from the
negotiation in order for both link partners to inter-operate.

Don't make this more complex than it needs to be!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

