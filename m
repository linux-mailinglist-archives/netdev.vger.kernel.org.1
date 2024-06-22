Return-Path: <netdev+bounces-105844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A1391320B
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 07:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7C5B208F0
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 05:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927B1494BC;
	Sat, 22 Jun 2024 05:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6322F3B
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719032805; cv=none; b=Ao1DqE3ExwFtlfWCnMrjEKoHNCTPnCr7iA1A6s2pn+fKgIAddFW5hZOcfhs9TQ9a7xXKgCFBwmBgQfrmtlKqH619oyDz45ISuhc9Gbx8Bagr/tKG72cSqKVdP0b1LCG4jpbD8TLg9lQjCCh/7PB5tQwuKt843r4kCC9PZEzSj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719032805; c=relaxed/simple;
	bh=ElpnqGb2uAaNz3u3gs7mh9PIoZii/nf6yiSP2bvyY+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4Jz4wCG+CsYyzJyEoN7j9AqusWVCc4HG/aYJ0E/zzaT4njtoa5TeUvxrNyYAaweOzb7KyEV9qJK4zGYB2Jno5EODHi32g6v2S8Sa0JKnG7HIcB90PhnL3Yox+D1TkdYUqp1cbOgzH/lup+Cjc93FdrztfWjwj+aJF0482BFhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sKsxN-0000tW-6U; Sat, 22 Jun 2024 07:06:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sKsxK-0046VJ-R4; Sat, 22 Jun 2024 07:06:30 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sKsxK-008Emb-2P;
	Sat, 22 Jun 2024 07:06:30 +0200
Date: Sat, 22 Jun 2024 07:06:30 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <ZnZb1rG-ePCyoqlU@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
 <Zm15fP1Sudot33H5@pengutronix.de>
 <20240617154712.76fa490a@kmaincent-XPS-13-7390>
 <ZnCUrUm69gmbGWQq@pengutronix.de>
 <20240621182915.3efd9ccf@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621182915.3efd9ccf@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jun 21, 2024 at 06:29:15PM +0200, Kory Maincent wrote:
> On Mon, 17 Jun 2024 21:55:25 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Mon, Jun 17, 2024 at 03:47:12PM +0200, Kory Maincent wrote:
> >  [...]  
> > > 
> > > Mmh not really indeed, maybe we can put it in error_condition substate?  
> > 
> > I'm not sure how this error can help user, if even we do not understand
> > what is says. May be map everything what is not clear right not to
> > unsupported error value. This give us some time to communicate with
> > vendor and prevent us from making pointless UAPi?
> 
> Is it ok for you if I use this substate for unsupported value:
> ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS
> or do you prefer another one.

Ack, sounds good.

> > > Should I put it under MPS substate then?  
> > 
> > If my understand is correct, then yes. Can you test it? Do you have PD
> > with adjustable load?
> 
> Yes I will test it.

Thx!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

