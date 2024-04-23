Return-Path: <netdev+bounces-90399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98B8AE046
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983DC282F03
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797954FB5;
	Tue, 23 Apr 2024 08:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AF482FA
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862234; cv=none; b=gBeiFMU6p3ASysgfJFMsy59k3+TD4thrA7xQj6lbXlMQDNfNYGaWBewiGhL/wbQzn8hzQaROzmZ/8O4WhCZMGW066BXyXRHFwlnF/XSmcqfFLvViD+mqdA0+Yh1pOXg5L3edxgLelStudwBaIcFWW+3WaaTwoaN0/TXU9tjoeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862234; c=relaxed/simple;
	bh=w7FyHw/39a9sjSjgy68+TMD8GicBYwCUzwy2rFX/2gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj99ty9IHYlAGtjKN+CJWWimJjwRHJ39P3NIz/UYD+UCJVVjja/c8lvQJaiKvbcDKe6o55ZvywN9vg31u3pLE5CvLpwpcfnDtvKnpnyK+Wa0h74FrAW43GO5/+HtuBHuTzvvGSx4VDuvYU4i8spSRlF17z1G3tki7XWEbboA62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBr7-0007tc-Vk; Tue, 23 Apr 2024 10:50:25 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBr7-00Dra3-2p; Tue, 23 Apr 2024 10:50:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rzBr6-009ntL-38;
	Tue, 23 Apr 2024 10:50:24 +0200
Date: Tue, 23 Apr 2024 10:50:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v2 3/3] net: pse-pd: Kconfig: Add missing
 Regulator API dependency
Message-ID: <Zid2UJolNR0GSIeD@pengutronix.de>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
 <20240422-fix_poe-v2-3-e58325950f07@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422-fix_poe-v2-3-e58325950f07@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Apr 22, 2024 at 03:35:48PM +0200, Kory Maincent (Dent Project) wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> The PSE (Power Sourcing Equipment) API now relies on the Regulator API.
> However, the Regulator dependency was missing from Kconfig. This patch
> adds the necessary dependency, resolving the issue of the missing
> dependency and ensuring proper functionality of the PSE API.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404201020.mqX2IOu7-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200036.D8ap1Mf5-lkp@intel.com/
> Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

