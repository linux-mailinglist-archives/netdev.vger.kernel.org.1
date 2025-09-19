Return-Path: <netdev+bounces-224681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A74B882AA
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0C1524C4D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BA2D592C;
	Fri, 19 Sep 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="pZW+VN/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949B2D47FE
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267153; cv=none; b=OJ/IUam4unEHZ4uPCYsLSwHgHccWCsQJVh2inIOg1dFpb7XVQL5W6kIVTn2PBrJ0SMIZNuYb+DVH762K5II1+6c/j90SzaGqzsQwMNNXsjbUiDEFtOj+Z1HJREmu/V+B9hm032MwH1Q5FS/oCSLdrzkr8gP+eC10dc/GJi0wF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267153; c=relaxed/simple;
	bh=QDBKRYM86Xj8SvcY0SO2armSTunx77RSYXQE6GhjxRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7c2ew2kElnYums1WQcjrJkWpSUrwuGUxJwhChITy2akXoKFV+JPHFpBUTAc9mMXd8TUkW/gOgLNDQcyp8FD4BycvulmOQ8SKF8/7QcN8F2FMtkQMJrb+1DN1w2FdyKLClyLnvPnS8VT1Z7qfwMsAVdKGC1zO8V3ZNS0x6Zi8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=pZW+VN/z; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=hb4JA4fTwI5S97+qQFy6E++mwXzjCgpI2x6Kz7sl75c=;
	b=pZW+VN/zunUr8uqIHPr8ZaMHKz5+wpBS9g8mkldWI1GlhOZ01lslSu5UYQzFFEQjJGU6szmDdCNKa
	 ySq3Dw2xuCzKeSw0pwSskYbqCuz5OEfnY7UVSvHFYKJCvZo6jQszXDWFPZ9S0lHA5mO4bq7UxDJs1q
	 xBBj42CcHzqdnv8cwgal4DV4B9DJtas2zLBBc+SXtplp2DWYC4MvM8ZMDPG+mJQw0QhmfFYwq5zgRO
	 jhAfBFwCAQrZ41fpzXDmJErIh4nugZek44vJMRmcedZPGs7MtWD1uwQ/GB2R2Bj0uLtVXBoG70fM67
	 tPnUN4xs3iJtqwqVRpwzZVXsJ+2N6Yg==
X-MSG-ID: a2929316-952a-11f0-8678-0050568164d1
Date: Fri, 19 Sep 2025 09:31:19 +0200
From: David Jander <david@protonic.nl>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jonas Rebmann <jre@pengutronix.de>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: add Protonic PRT8ML board
Message-ID: <20250919093119.24d2711a@erd003.prtnl>
In-Reply-To: <aMzlXerFpsfdHnwB@pengutronix.de>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
	<20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
	<af554442-aeec-40d2-a35a-c7ee5bfcb99a@lunn.ch>
	<20250918165156.10e55b85@erd003.prtnl>
	<7f1d9289-4102-4db9-a2bb-ff270e8871b7@lunn.ch>
	<20250918173347.28db5569@erd003.prtnl>
	<aMzlXerFpsfdHnwB@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 07:08:45 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Sep 18, 2025 at 05:33:47PM +0200, David Jander wrote:
> > On Thu, 18 Sep 2025 17:04:55 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > > Yes, unfortunately the SJA1105Q does not support PAUSE frames, and the i.MX8MP
> > > > FEC isn't able to sustain 1000Mbps (only about 400ish) due to insufficient
> > > > internal bus bandwidth. It will generate PAUSE frames, but the SJA1105Q
> > > > ignores these, leading to packet loss, which is obviously worse than
> > > > restricting this link to 100Mbps. Ironically both chips are from the same
> > > > manufacturer, yet are incompatible in this regard.    
> > > 
> > > Thanks for the explanation. Maybe add a comment that the bandwidth is
> > > limited due to the lack of flow control resulting in packet loss in
> > > the FEC.
> > >
> > > Anything which looks odd deserves a comment, otherwise somebody will
> > > question it....  
> > 
> > Yes! This is a golden tip. Ironically what I said above is incorrect. Sorry
> > for the noise.
> > 
> > Ftr: I wrote this DT about 4 years ago, so my memory failed me, and a comment
> > in the code would have saved me this embarrassment ;-)
> > 
> > The comment above applies to the i.MX6 SoC's which had this limitation. On the
> > i.MX8MP we had a different problem that also caused the SJA1105Q not to work
> > reliably at 1000Mbps either. We haven't been able to find the issue, but so far
> > this switch hasn't been able to work at 1000Mbps reliable on any platform,
> > possibly for different reasons in each case.  
> 
> May be it is doe to RGMII clock switching issue and the requirement to
> have specific silence time for proper clock frequency detection on the
> switch side?

I doubt it is that, because it works well at 100Mbps still in RGMII mode, and
according to the documentation the delay line is active for all rates.

OTOH, this switch probably has some other issues related to the RXC delay
line. It is always the RX path (RX at the switch, TX at the MAC) that
randomly does not work.

OT (but still posting in case someone here knows something):
Coincidentally I am currently working on a different design with a SJA1105Q
switch connected to a LAN743X MAC. The complication is that this MAC cannot
disable the TXC (RXC at the switch) at all. Still working on this, but right
now it looks like not even with the RX delay line deactivated (doing the delay
at the MAC) is the switch working reliably (at 1000Mbps). Investigation still
on-going so take with grain of salt.

> Or it is just artifact from iMX6 platform and it should be retested?

I remember having tested it and it not working reliably, but that was 4 years
ago or so. Drivers have evolved since, so maybe it is worth testing again?

Best regards,

-- 
David Jander


