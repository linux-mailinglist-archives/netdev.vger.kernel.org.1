Return-Path: <netdev+bounces-226734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462EDBA48DB
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1F46248AC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6823C4ED;
	Fri, 26 Sep 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="geRX30Pu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC6233D9C;
	Fri, 26 Sep 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902959; cv=none; b=cGH/JrVui5kSWGrm8amvMU/PxK7fJOn36dvnTWjr7eHFtpc7mKac2iHurcR1/9W1tTWaGjPXP5VjHFOXtJ3PYY22C2hlLEFUVChSHBSOrxLCAbnEtpX9YaA8aGmV1qbu2IaDwNWFKTubJYRqiAn3RErb9zyGEq5rnCEQGpXt+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902959; c=relaxed/simple;
	bh=GNym4/5w+81H7l6wRN3iH8e8+hjR/lakXba+4WL1j3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erOPCCjZCFiNPCUboEff1X0RfH98FkQYIHGNZogGhCggue13q2fLavLOtbLK+aewxWUP70WPzVyaC0qqKVaazosdJasPYpvOClIFcWqL7gyeyjTdTCj/Oe+9p/KPo0pL2GvOQfTHQ6pcM0CJPyJiIguguYr4Vf4dKGyOXv/mKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=geRX30Pu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jYzdU0Ao4LJNRuMnMVgJnZDVBVG1X8PzBdmolRPIrdA=; b=geRX30PuNnPqBhjjaXTVjV02Nv
	CAv5DRfay6NpaBZYfgHU6tpwV/2S5l94CxE7wG/aoOnacr6YyMtCar5KRbXYbVBOw/h2AcPQkUgA1
	dByhEVWrax6msf54q7QuZmwtXKzUZM3Q6mDq/6OyDtAp6LpTccj0Ni5DDQ5EL+TuNGns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2B0Q-009a7Y-6j; Fri, 26 Sep 2025 18:09:10 +0200
Date: Fri, 26 Sep 2025 18:09:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <f7d78131-7425-487f-a8bb-ed747dd9a194@lunn.ch>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>
 <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
 <aNREByX9-8VtbH0n@shell.armlinux.org.uk>
 <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>

> > > How does the databook describe reverse SGMII? How does it differ from
> > > SGMII?
> >
> > It doesn't describe "reverse SGMII". Instead, it describes:
> >
> > 1. The TC bit in the MAC configuration register, which makes the block
> >    transmit the speed and duplex from the MAC configuration register
> >    over RGMII, SGMII or SMII links (only, not 1000base-X.)
> >
> > 2. The SGMIIRAL bit in the PCS control register, which switches where
> >    the SGMII rate adapter layer takes its speed configuration from -
> >    either the incoming in-band tx_config_reg[15:0] word, or from the
> >    MAC configuration register. It is explicitly stated for this bit
> >    that it is for back-to-back MAC links, and as it's specific to
> >    SGMII, that means a back-to-back SGMII MAC link.
> >
> > Set both these bits while the MAC is configured for SGMII mode, and
> > you have a stmmac MAC which immitates a SGMII PHY as far as the
> > in-band tx_config_reg[15:0] word is concerned.
> 
> So any conclusion? Should I go on with REV*MII, or wait for (or write
> it myself) reverse-mode flag?

Sorry, i'm missing some context here.

Why do you actually need REVSGMII, or at least the concept?

REVMII is used when you connect one MAC to another. You need to
indicate one ends needs to play the PHY role. This is generally when
you connect a host MAC to an Ethernet switch, and you want the switch
to play the PHY role.

Now consider SGMII, when connecting a host MAC to a switch. Why would
you even use SGMII, 1000BaseX is the more logical choice. You don't
want the link to run at 100Mbps, or 10Mbps. The link between the host
and the switch should run as fast as possible. And 1000BaseX is
symmetrical, you don't need a REV concept.

Also, in these cases, stmmmac is on the host, not the switch, so it
will have the host role, leaving the switch to play 'PHY'. I'm not
sure you could even embedded stmmac in a switch, where it might want
to play 'PHY', because stmmac is software driven, where as a switch is
all hardware.

So the hardware supports reverse SGMII, but it is not clear to me why
you would want to use it.

	Andrew


