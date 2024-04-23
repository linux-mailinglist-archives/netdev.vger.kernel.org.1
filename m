Return-Path: <netdev+bounces-90396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C698AE035
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29391C2105C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7E482FA;
	Tue, 23 Apr 2024 08:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39C1E526
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862119; cv=none; b=f+XpkUcrIuVPYXuiA0I3F6lgSVrzNo9ZL1qLfkmjy2kmH7NeqbP3DitLxxbiwWVM4whoOJzSyVP8W2MgWZksK+sEb/zJkZXXFI+YMB0fhbFS49v5zaUQ/JFurHXwftNmdWpud+DwWxTGLf0DFFjc8JcWOcED9nwl4cbOKejnSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862119; c=relaxed/simple;
	bh=g8zd7G7ZNAHafF2FAzyu3q4vLjerp9wEdhoccM4gm0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkZykBv44b2IMM8dz5LcWvJRnU70jDZdBWpNLA8xqTuBTSXmmzPsWr0lTFvcv5zqf3sWuc5HgM6kRGeO9LWKS5Phbuu0LwVaANWQW6K8STgtB0mGWC6WkppW1XIG47naphKLMDvAWPLFRqkB/0NMX9l8KMiokOcIphD1+aHhnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpD-0007F0-V4; Tue, 23 Apr 2024 10:48:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpB-00DrZr-S1; Tue, 23 Apr 2024 10:48:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBpB-009nsc-2V;
	Tue, 23 Apr 2024 10:48:25 +0200
Date: Tue, 23 Apr 2024 10:48:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Message-ID: <Zid12Z4hVQ7sThhT@pengutronix.de>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
 <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>
 <ZiZ7-n5q3COmPRx6@nanopsycho>
 <20240422182030.34524046@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422182030.34524046@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Apr 22, 2024 at 06:20:30PM +0200, Kory Maincent wrote:
> On Mon, 22 Apr 2024 17:02:18 +0200
> Jiri Pirko <jiri@resnulli.us> wrote:
> 
> > Mon, Apr 22, 2024 at 03:35:47PM CEST, kory.maincent@bootlin.com wrote:
> > >From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >
> > >Clarify PSE regulator as voltage regulator, not current.
> > >The PSE (Power Sourcing Equipment) regulator is defined as a voltage
> > >regulator, maintaining fixed voltage while accommodating varying current.
> > >
> > >Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > >Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > This looks like a fix. Can you provide "Fixes" tag please and perhaps
> > send this to -net tree?
> 
> Indeed I should have used the Fixes tag.
> The PoE patch series that introduce this issue is currently in net-next.

With Fixes tag:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

