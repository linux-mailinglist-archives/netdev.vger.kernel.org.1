Return-Path: <netdev+bounces-122401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D696111E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF028B2691B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B761C688E;
	Tue, 27 Aug 2024 15:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCC17C96;
	Tue, 27 Aug 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771784; cv=none; b=Fuy6dUOHGH4ckROOxGB5NJ79qeXQfwh1jwmAuQ51bwcleaI6UJyptan4i8AILfFJaLEquUmYFtnP8mgvwRcoDxJxUro8j8z/IBqZfPUKjlCvms3I+ZJL30FAR2LxFrT3c323ycZ1YyVFT3zBYkOZviHjjXFIKwu331NkSK0Fxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771784; c=relaxed/simple;
	bh=SujO2EBqBW/YHO37ijRzZexZ0ocHpWynJ+ne0STqsAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUO2Tp0AgCEVg1gN8wC0xHJ3LrCT++ht8b7DPdc0BJSx7Vv4Qowm5w3XIg+ro+pgWBsmnKa6S/t1WPKjLBNb1ugv1qPbhHGrh86a9p68GMKMUUq6nI65U9e2P2B1r4u+SK7EAtb8oa/UtZaCIHV0iEcrpR7oemXSV5a3zcjw0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sixvQ-000000006K5-3LeN;
	Tue, 27 Aug 2024 15:16:04 +0000
Date: Tue, 27 Aug 2024 16:15:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <Zs3trawXqPjVK0LF@makrotopia.org>
References: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
 <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>
 <a59be297-1a55-4cce-a3e1-7568e3d4e66c@lunn.ch>
 <ZsYTZK4Ku2LoZ4SA@makrotopia.org>
 <71391388-4c18-4239-b74d-807dfc48bbc5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71391388-4c18-4239-b74d-807dfc48bbc5@lunn.ch>

On Fri, Aug 23, 2024 at 03:28:39AM +0200, Andrew Lunn wrote:
> On Wed, Aug 21, 2024 at 05:18:44PM +0100, Daniel Golle wrote:
> > On Wed, Aug 21, 2024 at 06:07:06PM +0200, Andrew Lunn wrote:
> > > On Wed, Aug 21, 2024 at 01:46:50PM +0100, Daniel Golle wrote:
> > > > Normally, the MDI reversal configuration is taken from the MDI_CFG pin.
> > > > However, some hardware designs require overriding the value configured
> > > > by that bootstrap pin. The PHY allows doing that by setting a bit which
> > > > allows ignoring the state of the MDI_CFG pin and configuring whether
> > > > the order of MDI pairs should be normal (ABCD) or reverse (DCBA).
> > > > 
> > > > Introduce two boolean properties which allow forcing either normal or
> > > > reverse order of the MDI pairs from DT.
> > > 
> > > How does this interact with ethtool -s eth42 [mdix auto|on|off]
> > > 
> > > In general, you want mdix auto, so the two ends figure out how the
> > > cable is wired and so it just works.
> > 
> > It looks like Aquantia only supports swapping pair (1,2) with pair (3,6)
> > like it used to be for MDI-X on 100MBit/s networks.
> > 
> > When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
> > come up with pair order is not configured correctly, either using MDI_CFG
> > pin or using the "PMA Receive Reserved Vendor Provisioning 1" register.
> > 
> > And yes, I did verify that Auto MDI-X is enabled in the
> > "Autonegotiation Reserved Vendor Provisioning 1" register.
> 
> Is it possible to read the strap configuration?  All DT needs to
> indicate is that the strap is inverted.

Sadly no, because there is only a single r/w bit which could already
have been changed by the bootloader as well. We risk that vendor
bootloader updates then require modifying DT again once they "fix it"
there. I'd rather have two properties to force either ABCD or DCBA pair
order.

If it got to be a single property, then we can either use a string with
pre-defined values "abcd" and "dcba", or use macro defined integer
values in include/dt-bindings such as

#define AQUANTIA_MII_PAIR_ORDER_ABCD 0
#define AQUANTIA_MII_PAIR_ORDER_DCBA 1

In both when using a single property for overriding the bootstrap value,
absence of that property would mean to not touch what ever has been
setup by bootstrap pin (or force-mode configured by the bootloader,
which I've also seen already, and that also seems to survive PHY
resets).


