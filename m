Return-Path: <netdev+bounces-196643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DEAD5A72
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DCA7A3D69
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E191C5499;
	Wed, 11 Jun 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kaybggE1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E21A317A;
	Wed, 11 Jun 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655734; cv=none; b=klIVhlKAvEUn+U7smuJ4y+kfmceOpfxluSFhvIzE0kSMIiejbz+/MqtdkmVZ4D8aUwU9b+tb/Qg0V4375nncDvq8j1l0f7tIZEngjRql+OBDIDWc4ldDGLPlZ6mntQMwvT/cqD76bVsuxsAjdo8jz8Mfn0ieoK0x2Fn43IRPaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655734; c=relaxed/simple;
	bh=yuwScAGctOlp0niszogMAEbB0PR4iR2+jwikJypvgQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgkM2xZRC1BFFEc7hcRQCQ5WlVrxZl2PJ9JMMrAES+ZtT32rsZs6jVNBXqk0Lbkz6CBSqt9TRY0ELVjEzB+Zf4VxKVDq+qN0RDb89Ca5ZcboXu6wTSdpbspmMOENxa21Yj/c8Giz2rUIQyjizxHz+cm9+PFnB1dovykZUELg8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kaybggE1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rB+IDZViBhVUmd7CnVGvTKDAaSMJSZkOj3zCM83yO+U=; b=kaybggE1EO6H0Z389UOZ+tStbq
	2UtSf9qU8IoOILCqXrCu9SAJhVQyoLF00FMti6ytyuc/eb/cYpAQb9FRD7waT17+dRCUvPAMgWL+X
	+ZVYU/svnOkPeEAjgIydHI+63a75FP7x3wEVQMajs80ftMv5hMbvXkz6BBR4elABmPEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPNNX-00FPyB-66; Wed, 11 Jun 2025 17:28:39 +0200
Date: Wed, 11 Jun 2025 17:28:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <f82a86d3-6e06-4f24-beb5-68231383e635@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
 <aElArNHIwm1--GUn@shell.armlinux.org.uk>
 <fc7ad44b922ec931e935adb96dcc33b89e9293b0.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7ad44b922ec931e935adb96dcc33b89e9293b0.camel@icenowy.me>

> Well in fact I have an additional question: when the MAC has any extra
> [tr]x-internal-delay-ps property, what's the threshold of MAC
> triggering patching phy mode? (The property might be only used for a
> slight a few hundred ps delay for tweak instead of the full 2ns one)

Maybe you should read the text.

The text says:

  In the MAC node, the Device Tree properties 'rx-internal-delay-ps'
  and 'tx-internal-delay-ps' should be used to indicate fine tuning
  performed by the MAC. The values expected here are small. A value of
  2000ps, i.e 2ns, and a phy-mode of 'rgmii' will not be accepted by
  Reviewers.

So a few hundred ps delay is fine. The MAC is not providing the 2ns
delay, the PHY needs to do that, so you don't mask the value.

> > > Well I can't find the reason of phy-mode being so designed except
> > > for
> > > leaky abstraction from phylib.
> > 
> > I have no idea what that sentence means, sorry.
> 
> Well, I mean the existence of rgmii-* modes is coupled with the
> internal of phylib, did I get it right?

This is the external API of phylib, it has nothing to do with the
internals of phylib.

/**
 * phy_attach - attach a network device to a particular PHY device
 * @dev: network device to attach
 * @bus_id: Bus ID of PHY device to attach
 * @interface: PHY device's interface
 *
 * Description: Same as phy_attach_direct() except that a PHY bus_id
 *     string is passed instead of a pointer to a struct phy_device.
 */
struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
			      phy_interface_t interface)

interface tells the PHY how it should configure its interface.

If you follow the guidelines, the PHY adds the delay if needed, you
get interface == phy-mode. However, interface and phy-mode are
different things. phy-mode describes the hardware, the PCB. interface
tells the PHY what to do. There are legitimate cases where
interface != phy-mode.

	Andrew

