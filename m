Return-Path: <netdev+bounces-149643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E7B9E696E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A57163592
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A21E0E0F;
	Fri,  6 Dec 2024 08:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375F1D9A48
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475411; cv=none; b=iIF50inoGtPu1T0dwgNHcyqH9l4bFG8RTvuTampuowyV/bNGWo3R+SWSCtwF+sEwqozaBjxB3kSn1gJp0zwEKKw6LugsxgK62ZXJnGiFDd8r76gu5lYvr817OSXMMNCcyStesZUj0BsgqsypWTXDOJgTuD+g8A1RmBFTmdy4CSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475411; c=relaxed/simple;
	bh=DtaruFWH6LWbTsVJRfIi7OaQAHdaqNRcHsBtbIlr3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq342dNdALinkNUT+CJaRm8vKkq+d8G6ttTvbiIRgyGy527RCbwAdiosT+fNxj/M93yLCWhiJcHRzx4nP7hDLZMRX1KcdKQRoL363BXE2Wj06giUkaZjfWAOSrJxS8xCUvAUFDKyIp5uo27eGv/o8e1OsfdqbQ65aMy1ewl0gFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tJU8e-0005HM-Hy; Fri, 06 Dec 2024 09:56:40 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJU8d-001y5P-08;
	Fri, 06 Dec 2024 09:56:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJU8d-000kIi-2G;
	Fri, 06 Dec 2024 09:56:39 +0100
Date: Fri, 6 Dec 2024 09:56:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 02/21] net: usb: lan78xx: Remove KSZ9031 PHY
 fixup
Message-ID: <Z1K8R4y-mmGRJzUO@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-3-o.rempel@pengutronix.de>
 <20241205171203.GE2581@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205171203.GE2581@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Simon,

On Thu, Dec 05, 2024 at 05:12:03PM +0000, Simon Horman wrote:
> > -		dev->interface = PHY_INTERFACE_MODE_RGMII;
> > -		/* external PHY fixup for KSZ9031RNX */
> > -		ret = phy_register_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0,
> > -						 ksz9031rnx_fixup);
> > -		if (ret < 0) {
> > -			netdev_err(dev->net, "Failed to register fixup for PHY_KSZ9031RNX\n");
> > -			return NULL;
> > -		}
> > +		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
> > +		/* The PHY driver is responsible to configure proper RGMII
> > +		 * interface delays. Disable RGMII delays on MAC side.
> > +		 */
> > +		lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
> >  
> >  		phydev->is_internal = false;
> >  	}
> 
> nit: With this change ret is now set but otherwise unused in this function.
> 
>      I would suggest a new patch, prior to this one, that drops the
>      other places where it is set. They seem to have no effect.
>      And then remove ret from this function in this patch.
> 

There is a patch in this patch stack which will address it too. There is
just limit to amount of patches I can upstream per one round.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

