Return-Path: <netdev+bounces-160539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8FA1A1BD
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA213A4937
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628C20DD67;
	Thu, 23 Jan 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcScvTBI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7F20D513;
	Thu, 23 Jan 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627814; cv=none; b=uHd2dkH/Mqe3kYqWXeSJMKfGHH3vZhISNMwJx7Ql5dbSG7nQ7umB8vljEC8q/IOKupJZqXQ9srtgAND8TGeNtNF10LoiZ9467HV6a2r1ebmcC3jwsigddjdr0ISO608R77OXDCmfIPtyg5Oo5ycTcPqrgLwe50HLd277N3AvoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627814; c=relaxed/simple;
	bh=RbxG41sC6Zb/IZnTPFnaZuAqpCDE7huLIDeKbm4yWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u00LQ87nbR4WDZeFbA6J8C3KpX/WpRk4PlkWp45L8y04TsyGcIi/H0iz2egsZBFXk4BmpIcuQ+86f+M1fEeanNrM/wo2MvAX7zWOo6/GoWenB/GhHbjBetC9Apx+SFhr41NRGaG4/iyzLZk4xojFiLECsw3D9f5B11iJNk44S3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcScvTBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD8AC4CED3;
	Thu, 23 Jan 2025 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737627813;
	bh=RbxG41sC6Zb/IZnTPFnaZuAqpCDE7huLIDeKbm4yWEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcScvTBIDGMKTtBpFfokk5p4jxl7li+MuuiyxRxLKq+jtUG3cYdEGxwWTZ9cJ7JNM
	 T5UWiY+on/yIXt9u6i9OinZHTHneiu/Qy2nrAQZq3kXg1CC0yvWEGBqvsuPrJ+o4pC
	 x3VIbnVYVdTuRZsZEYp8UjY48mKuPj9Pdw42Y7xHe7viDQ+V+Xm23EXbo2yKhUX/j4
	 zW0kLuyY+P/wQckpqIowQpwGDMZsVz9ay2UPYjXEbl+0i9GwXthrQmnkC8snk2v1rc
	 s/9pSZx7W1kmDcPna8u9K86iUUQpk+XPCWoc3ACIAZbzjKXnM460Mn0lx4QXbtFRd0
	 wtGQBpqXJY8zg==
Date: Thu, 23 Jan 2025 10:23:27 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 4/6] net: phy: Introduce PHY ports
 representation
Message-ID: <20250123102327.GI395043@kernel.org>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
 <20250122174252.82730-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122174252.82730-5-maxime.chevallier@bootlin.com>

On Wed, Jan 22, 2025 at 06:42:49PM +0100, Maxime Chevallier wrote:
> Ethernet provides a wide variety of layer 1 protocols and standards for
> data transmission. The front-facing ports of an interface have their own
> complexity and configurability.
> 
> Introduce a representation of these front-facing ports. The current code
> is minimalistic and only support ports controlled by PHY devices, but
> the plan is to extend that to SFP as well as raw Ethernet MACs that
> don't use PHY devices.
> 
> This minimal port representation allows describing the media and number
> of lanes of a port. From that information, we can derive the linkmodes
> usable on the port, which can be used to limit the capabilities of an
> interface.
> 
> For now, the port lanes and medium is derived from devicetree, defined
> by the PHY driver, or populated with default values (as we assume that
> all PHYs expose at least one port).
> 
> The typical example is 100M ethernet. 100BaseT can work using only 2
> lanes on a Cat 5 cables. However, in the situation where a 10/100/1000
> capable PHY is wired to its RJ45 port through 2 lanes only, we have no
> way of detecting that. The "max-speed" DT property can be used, but a
> more accurate representation can be used :
> 
> mdi {
> 	port-0 {
> 		media = "BaseT";
> 		lanes = <2>;
> 	};
> };
> 
> >From that information, we can derive the max speed reachable on the
> port.
> 
> Another benefit of having that is to avoid vendor-specific DT properties
> (micrel,fiber-mode or ti,fiber-mode).
> 
> This basic representation is meant to be expanded, by the introduction
> of port ops, userspace listing of ports, and support for multi-port
> devices.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

...

> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c

...

> +/**
> + * phy_port_destroy: Free a struct phy_port
> + */
> +void phy_port_destroy(struct phy_port *port)

nit: The Kernel doc for this function should include documentation of
     the port parameter.

     Flagged, along with several other Kernel doc issues,
     by ./scripts/kernel-doc -none

...

