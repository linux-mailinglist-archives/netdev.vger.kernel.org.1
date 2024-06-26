Return-Path: <netdev+bounces-106746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD79177CC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5336D1C22213
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 05:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61C13C810;
	Wed, 26 Jun 2024 05:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8313AD31
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378042; cv=none; b=cPSQ5tL61HeuYvl/adINLhvYrdm+hrFmJ4/3tK5sRayuaDIARBqtDgyJW29+mK+dbljvIxJm38W9/LhCFkU534Buf/o5Cl/wz3G2NfRee7g4lfK5ymarGqrnvJY7AZhMjXdJlIM7hiG9HsUiGNsGn+2ITNUjT403j9unQDXJ7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378042; c=relaxed/simple;
	bh=zo8r24JgeSRv0jIkMxYfscMZuXhJOrZk+3LzRRcnW/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+EcvUKWsX2rZpz7MjpyscJmluVrS1PVupWsT8vcT2A3vcdp69Mm9AnDIlCjrAugtrca2ihs9MVzzpDB/zo11Z7BhU5+bwOJeyX9cD5+9T/QSWp0PxgHClHlwHuHkQsZlv3CcpJ8dml60pkpJNR1DqGuyNcrXmNdeqqHTApQU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMKlQ-0007WN-UN; Wed, 26 Jun 2024 07:00:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMKlM-0053DI-Np; Wed, 26 Jun 2024 07:00:08 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMKlM-00FywX-20;
	Wed, 26 Jun 2024 07:00:08 +0200
Date: Wed, 26 Jun 2024 07:00:08 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <ZnugWNWu35eIy00M@pengutronix.de>
References: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Uwe,

On Tue, Jun 25, 2024 at 10:38:53AM +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> While add it, also remove commas after the sentinel entries.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I'm unsure if I should have split this patch further; per subdir of
> drivers/net or even per driver. If you want it split, please tell me. 
> 
> Best regards
> Uwe
> 
>  drivers/net/dsa/lan9303_i2c.c                 | 2 +-
>  drivers/net/dsa/microchip/ksz9477_i2c.c       | 4 ++--

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

>  drivers/net/pse-pd/pd692x0.c                  | 4 ++--
>  drivers/net/pse-pd/tps23881.c                 | 4 ++--

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

