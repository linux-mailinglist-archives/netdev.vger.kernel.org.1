Return-Path: <netdev+bounces-221760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C7B51C90
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C013188B190
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26331AF2C;
	Wed, 10 Sep 2025 15:54:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819E32CF8E
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519656; cv=none; b=MDeIaZtTq5x1EkxeUKncpsxwvqBJX7Ij3AhgVhTVAuXC9qQXI4e5Kl92nYYDp5kR0sFHILIlWjbX5rKXGVtGL5xwVA+eZt0x8tOsIoh6QrF0T+BusErn9iv+p2xbHL1sAPYoOTmvtWWHejMcJ0SMHKP+riaLw5HC6kM/QUX7b1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519656; c=relaxed/simple;
	bh=C1AjRx7KnjXXSlctsl/aH4GowViazJTD/uAewQRTZB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv/YptQUh8up4SLbY0qZzbRUOyOeakRSzZEOqaxODYOBuSxh/GeGEPurpyHP4lUvqg+sqyaxZVP6xlvoIoMuq1cbWw5A/Fl/WlDkxXHwhYrqWKFs/ybNSZgFAifWFUBOqETTgUiH74pFgTQc7XBLIfC6W2NPEOWSvPmrgrd97zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwN8y-0008U5-Ku; Wed, 10 Sep 2025 17:54:00 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwN8x-000cAf-1T;
	Wed, 10 Sep 2025 17:53:59 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwN8x-00GJ0O-0v;
	Wed, 10 Sep 2025 17:53:59 +0200
Date: Wed, 10 Sep 2025 17:53:59 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Jonas Rebmann <jre@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250910155359.tqole7726sapvgzr@pengutronix.de>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
 <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
 <20250910153454.ibh6w7ntxraqvftb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153454.ibh6w7ntxraqvftb@skbuf>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 25-09-10, Vladimir Oltean wrote:
> On Wed, Sep 10, 2025 at 04:09:05PM +0100, Mark Brown wrote:
> > > And if you plan to do that from the GPIO function of your SoC, the SoC
> > > might be busy doing other stuff, like booting, and no one might be
> > > driving the RST_N voltage to a defined state.
> > 
> > I suspect you're reading too much into the datasheet there.  I suspect
> > that what it's trying to say is that the reset signal only works with
> > stable power and clocks, that it must be held low for the 5us while
> > those conditions hold and that you have to do at least one cold reset
> > after power on.  The above wording is pretty common in datasheets and I
> > know in a bunch of cases it was carried forward kind of blindly rather
> > than looking at the actual device requirements.
> 
> No, it doesn't say that, and I had discussions with the application
> engineering team for this chip about this :-/
> 
> I can't comment on anything extrapolated outside of the SJA1105/SJA1110.
> 
> > > It really depends on a lot of factors including the reset timing and
> > > supply voltage distribution of the PCB, but RST_N has essentially 2
> > > purposes. One is ensuring proper POR sequencing, the other is cold
> > > resetting at runtime. You can do the latter over SPI with identical
> > > outcome, which leaves proper POR sequencing, which is not best served by
> > > a GPIO in my experience.
> > 
> > I'm not sure not including the signal in the DT bindings is going to
> > influence board designers much either way TBH.
> 
> Either way, something has to nudge at least the software developer
> towards finding and reading the vendor's relevant documentation.
> 
> In that sense, 'reset-gpios' is misleading to say the least, because
> everyone sees a reset GPIO and has the human tendency to think there
> isn't anything more to be known about it (like I also did).
> 
> To be clear, I'm saying that supporting 'reset-gpios' in this driver was
> a mistake, at least in the form where its supplies and clocks aren't
> also under control. I'm not sure it's a mistake that we need to document,
> and if we do, there need to be a lot more disclaimers. Also, I'm pretty
> sure nothing will break if driver support for it is simply removed.

IMHO silently removing the support will break designs for sure and
should never be done. As said, imagine that the firmware will handle the
supplies and the driver only needs to release the reset. If you silently
remove the support, the device will be kept in reset-state. In field
firmware updates are seldom, so you break your device by updating to a
new kernel.

One could argue that the driver supported it but there was no dt-binding
yet, so it was a hidden/unstable feature but I don't know the policy.

Regards,
  Marco

