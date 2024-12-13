Return-Path: <netdev+bounces-151804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0479F0F58
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07C82834DB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FC1E1C26;
	Fri, 13 Dec 2024 14:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A371DF975
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100699; cv=none; b=fcgJmeeYKw3nQWVJmOJSZReVVq3WUOByHEDPhxDOP0FDgj3t76RI0MdTLIYL0uWOM44TVT0EianNiGaVYSlp7tt5psljCyphAF9mr/owhf7pON31jVrEUVRb26/WV51NlfDBH4J2xQEeBB/V+NGoA5aDfXQnFlb6sQVB71bHWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100699; c=relaxed/simple;
	bh=dbqAQKo7bYctmTlwta11eLI/7iZ5CcH1vp60Z5LYawQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHw2/DLM+zoxjWFL5ShejvXPRfJjC5bOUDf3SWdAZlbRHiisIPPj/6DGu2+ddALj0Te5NB47k3wotY/4tOSVwDeA0X3e1aGaWbKcJ6XFDuGLzAIR+igF16lPr8pQg+9ohK9N+S5CB2D5fpMzNryL8NIfONpT6fQznLxI35b+Oz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tM6nj-0004mK-GS; Fri, 13 Dec 2024 15:37:55 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tM6nh-003DSw-19;
	Fri, 13 Dec 2024 15:37:54 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tM6ni-00ES0u-04;
	Fri, 13 Dec 2024 15:37:54 +0100
Date: Fri, 13 Dec 2024 15:37:54 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 07/11] net: usb: lan78xx: Use ETIMEDOUT
 instead of ETIME in lan78xx_stop_hw
Message-ID: <Z1xGwllbEtrVO5-O@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-8-o.rempel@pengutronix.de>
 <b7fa7a73-a1f1-4eeb-a97d-2ad25af0f0f5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7fa7a73-a1f1-4eeb-a97d-2ad25af0f0f5@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Dec 10, 2024 at 03:08:18AM +0100, Andrew Lunn wrote:
> On Mon, Dec 09, 2024 at 02:07:47PM +0100, Oleksij Rempel wrote:
> > Update `lan78xx_stop_hw` to return `-ETIMEDOUT` instead of `-ETIME` when
> > a timeout occurs. While `-ETIME` indicates a general timer expiration,
> > `-ETIMEDOUT` is more commonly used for signaling operation timeouts and
> > provides better consistency with standard error handling in the driver.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/usb/lan78xx.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index 2966f7e63617..c66e404f51ac 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> > @@ -844,9 +844,7 @@ static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
> >  		} while (!stopped && !time_after(jiffies, timeout));
> >  	}
> >  
> > -	ret = stopped ? 0 : -ETIME;
> > -
> > -	return ret;
> > +	return stopped ? 0 : -ETIMEDOUT;
> 
> I've not looked at the call stack, but tx_complete() and rx_complete()
> specifically looks for ETIME. Do they need to change as well?

No, the tx_complete() and rx_complete() will get error values in to the
urb->status from the USB stack. In this case it is a different ETIME.

I'll update commit message.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

