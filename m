Return-Path: <netdev+bounces-224669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABDB87E34
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 07:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DE7A82BC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C8257852;
	Fri, 19 Sep 2025 05:09:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985801DF26E
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258550; cv=none; b=j/WgFizfILFEMLLp3yJfSjgmkR4EdAjTUAXimmXJUJuuEYUOuuVtGVceYYAxkUPBFHwOnPQMfYdTt36sGLVFAg/PKnSXsnS8k5wLbjylfoDmDvM74odSAJ9BwwZeXklG2n2/heb0k7DK6aJWlJQG5JpfR5/jV7pQBtbr8iBfp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258550; c=relaxed/simple;
	bh=/4nb5SwtO1+qhbWcQguFHi/RCylMvbzqH7v8r5OAzmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGrR3b3MZ7c8cmt7EbcoWUwoYIPvn7avVJT2xRAICy7xp1NpmgbDwcXY6hiMzbnNiGAw35LkqIIUz9D4zu5nh/ExO43BfIjfnj3Y4vM22Cgo++49I2JdSqGwMMYSIFTe6MDGmUdIxNxhn/RLkN6M4pm9v7hEBPwSFAZtAehfDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uzTMW-0001ef-2U; Fri, 19 Sep 2025 07:08:48 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uzTMT-0023Em-1q;
	Fri, 19 Sep 2025 07:08:45 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uzTMT-000Jiu-1I;
	Fri, 19 Sep 2025 07:08:45 +0200
Date: Fri, 19 Sep 2025 07:08:45 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: David Jander <david@protonic.nl>
Cc: Andrew Lunn <andrew@lunn.ch>, Jonas Rebmann <jre@pengutronix.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: add Protonic PRT8ML board
Message-ID: <aMzlXerFpsfdHnwB@pengutronix.de>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
 <af554442-aeec-40d2-a35a-c7ee5bfcb99a@lunn.ch>
 <20250918165156.10e55b85@erd003.prtnl>
 <7f1d9289-4102-4db9-a2bb-ff270e8871b7@lunn.ch>
 <20250918173347.28db5569@erd003.prtnl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918173347.28db5569@erd003.prtnl>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Sep 18, 2025 at 05:33:47PM +0200, David Jander wrote:
> On Thu, 18 Sep 2025 17:04:55 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > Yes, unfortunately the SJA1105Q does not support PAUSE frames, and the i.MX8MP
> > > FEC isn't able to sustain 1000Mbps (only about 400ish) due to insufficient
> > > internal bus bandwidth. It will generate PAUSE frames, but the SJA1105Q
> > > ignores these, leading to packet loss, which is obviously worse than
> > > restricting this link to 100Mbps. Ironically both chips are from the same
> > > manufacturer, yet are incompatible in this regard.  
> > 
> > Thanks for the explanation. Maybe add a comment that the bandwidth is
> > limited due to the lack of flow control resulting in packet loss in
> > the FEC.
> >
> > Anything which looks odd deserves a comment, otherwise somebody will
> > question it....
> 
> Yes! This is a golden tip. Ironically what I said above is incorrect. Sorry
> for the noise.
> 
> Ftr: I wrote this DT about 4 years ago, so my memory failed me, and a comment
> in the code would have saved me this embarrassment ;-)
> 
> The comment above applies to the i.MX6 SoC's which had this limitation. On the
> i.MX8MP we had a different problem that also caused the SJA1105Q not to work
> reliably at 1000Mbps either. We haven't been able to find the issue, but so far
> this switch hasn't been able to work at 1000Mbps reliable on any platform,
> possibly for different reasons in each case.

May be it is doe to RGMII clock switching issue and the requirement to
have specific silence time for proper clock frequency detection on the
switch side?

Or it is just artifact from iMX6 platform and it should be retested?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

