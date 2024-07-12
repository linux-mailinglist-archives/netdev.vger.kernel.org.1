Return-Path: <netdev+bounces-111097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6E92FD7F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68BB2823B2
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC23173359;
	Fri, 12 Jul 2024 15:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFE171075
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797950; cv=none; b=tgbWmaHfoXRV0P6Yt/r4kA5KW1gjeAtSE251z5DeE5HVaQJkcunO5m7cKuTBtTYvXoO66PnUdDvr2fH6tAddxz9nlyNA/ZpGKLL6IjF/2KXP5k6hlQuF3ggHKuMPzcNxb53cZrvs9L+xUxCpol5TqQo0+0Il/8YLtw2fXPOCDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797950; c=relaxed/simple;
	bh=3eUESbWw7CZsZFdS41zOQ9g+h/GToJLx+xh933r+pfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjosPQ+p7bUYkkeVZ2DAKgeMNUP4diTdNLv4te571tZdUaH1HwrYQxKnY/72kp/WIk+Ro23hH6v0fWjZVtsJBvswF14cf+uGhAcqnQ2ig6vrczhAjiHJ1d8eMqC45rjXPnA/UuKjgpN6XskdesM3OlPDvN5DwJ3TeB4hpgEawVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sSI9U-00037k-C6; Fri, 12 Jul 2024 17:25:40 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sSI9T-0091pv-Hx; Fri, 12 Jul 2024 17:25:39 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sSI9T-00CLua-1U;
	Fri, 12 Jul 2024 17:25:39 +0200
Date: Fri, 12 Jul 2024 17:25:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83td510: add cable testing
 support
Message-ID: <ZpFK8-1d9ZAPUF_m@pengutronix.de>
References: <20240708140542.2424824-1-o.rempel@pengutronix.de>
 <a14ae101-d492-45a0-90fe-683e2f43fa3e@lunn.ch>
 <ZpE_WwtSSdxGyWtC@pengutronix.de>
 <3e1103cf-6023-475d-9532-2e5840ed14f8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e1103cf-6023-475d-9532-2e5840ed14f8@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jul 12, 2024 at 05:20:06PM +0200, Andrew Lunn wrote:
> > > > +#define DP83TD510E_TDR_CFG2			0x301
> > > > +#define DP83TD510E_TDR_END_TAP_INDEX_1		GENMASK(14, 8)
> > > > +#define DP83TD510E_TDR_END_TAP_INDEX_1_DEF	36
> > > > +#define DP83TD510E_TDR_START_TAP_INDEX_1	GENMASK(6, 0)
> > > > +#define DP83TD510E_TDR_START_TAP_INDEX_1_DEF	3
> > > 
> > > Does this correspond the minimum and maximum distance it will test?
> > > Is this 3m to 36m?
> > 
> > No. At least, i can't confirm it with tests.
> > 
> > If I see it correctly, this PHY is using SSTDR instead of usual TDR.
> > Instead of pulses it will send modulated transmission with default
> > length of 16ms
> > 
> > I tried my best google foo, but was not able to find anything
> > understandable about "Start/End tap index for echo coeff sweep for segment 1"
> > im context of SSTDR. If anyone know more about this, please tell me :)
> 
> I was just curious. Does not really matter with respect to getting the
> patch applied.
 
No problem, I was so nerd sniped that I had to dive deeper into the
matter :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

