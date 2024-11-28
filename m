Return-Path: <netdev+bounces-147688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A99B9DB354
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4044F28247B
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC4149C57;
	Thu, 28 Nov 2024 07:57:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488B1482E1
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780675; cv=none; b=febRIuM2P5EFCadK3p0bVoBRfqMibtwZlCah6/efefXAuR95R8MwMxLyEYCNT/VCiEs8n2M2sWxgOvS/CUlT164bOH+XyYBvc1+hF/1uSd72YdOto7/mMf1UiZ4g2AVIIdenCSySQnrdRLdpkyEjsilFGa02h7AU6D8gKsXeHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780675; c=relaxed/simple;
	bh=hozTocJT2iKXBY9S5dg3BDzFJxp3Ezg8eYStAMLE8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+Dv3uz4NB3Pdj7OVHgVZDkbYWK2Lw6M/+twiseQwjqBIe3G/y/a8ICnn4sFr4DGakK4ftwo4tRW42ji3PRa3Of+yEenrsmh3ibbFQQFN2smKrGTQWbfqeZTXTzDr3xtHWDER3u0X/duewXOHM6UJuvfV+KJilIAq/xnzVkwaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGZPB-0001O4-AJ; Thu, 28 Nov 2024 08:57:41 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGZP8-000Zj0-2l;
	Thu, 28 Nov 2024 08:57:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGZP9-002pKH-1h;
	Thu, 28 Nov 2024 08:57:39 +0100
Date: Thu, 28 Nov 2024 08:57:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC net-next v1 2/2] net. phy: dp83tg720: Add randomized
 polling intervals for unstable link detection
Message-ID: <Z0gic12YXSrnGuKl@pengutronix.de>
References: <20241127131011.92800-1-o.rempel@pengutronix.de>
 <20241127131011.92800-2-o.rempel@pengutronix.de>
 <dabcacd6-6e51-489c-b8f1-bd104ac4186f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dabcacd6-6e51-489c-b8f1-bd104ac4186f@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Nov 27, 2024 at 06:33:03PM +0100, Heiner Kallweit wrote:
> On 27.11.2024 14:10, Oleksij Rempel wrote:
> > Address the limitations of the DP83TG720 PHY, which cannot reliably detect or
> > report a stable link state. To handle this, the PHY must be periodically reset
> > when the link is down. However, synchronized reset intervals between the PHY
> > and its link partner can result in a deadlock, preventing the link from
> > re-establishing.
> > 
> Out of curiosity: This PHY isn't normally quirky, but completely broken.
> Why would anybody use it?

Is it rhetorical question, or you are really curios? I can answer it, but it
will not be a short one ¯\_(ツ)_/¯

> >  /* MDIO_MMD_VEND2 registers */
> > @@ -355,6 +374,11 @@ static int dp83tg720_read_status(struct phy_device *phydev)
> >  		if (ret)
> >  			return ret;
> > 
> > +		/* The sleep value is based on testing with the DP83TG720S-Q1
> > +		 * PHY. The PHY needs some time to recover from a link loss.
> > +		 */
> What is the issue during this "time to recover"?
> Is errata information available from the vendor?

I didn't found errata documentation for this chip. But there is
"DP83TC81x, DP83TG72x Software Implementation Guide" SNLA404, describing
the need of reset each 100ms and PHY Reset + PHY Initialization
sequences:
https://www.ti.com/lit/an/snla404/snla404.pdf

So far, i was not able to find any justification for this delay, except
it helped to reduce amount of PHY resets. 
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

