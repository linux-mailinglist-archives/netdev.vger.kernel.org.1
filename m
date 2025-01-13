Return-Path: <netdev+bounces-157738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A5A0B72B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD87A16252A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17B22A4FE;
	Mon, 13 Jan 2025 12:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7622F162
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772151; cv=none; b=Mc9xrb3oYgPe5Zi80gBiNIYSJfzR4ml1wHeojirCUCOMpLa1e6jtf2IY2gjgmsXsaZJoRiB3Va/o59XMdQ/bglNxCG3Ad4Q1j4yHAdOFwf+KtCBhU5pP6Y9nyp6DWL8WDpWccOsctVGA9rJWP32uWPEd5WRH81XRD/+vxfEcCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772151; c=relaxed/simple;
	bh=O8g4Mg96eYG689tC155rLwohHCHRlBMHebjz0QN/N8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyv3DgFGt6SGl0kkF4x6lpvlp5MJAh+E9s3MPtV6qPLcBEI/UprS8N/5z+urlNL+kJKnvPxO4nGM6VnL/Kx7xHbatrkfs9aoOpqP1VIlGjy/PbTWYYHQ4sKbe8zE5huXM4bpi13636z6YkGwBkcMRqBhdF4IO3D02PpHFMlYICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tXJlf-00063V-Mf; Mon, 13 Jan 2025 13:42:07 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tXJld-000GE6-3B;
	Mon, 13 Jan 2025 13:42:06 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tXJle-007tyy-1E;
	Mon, 13 Jan 2025 13:42:06 +0100
Date: Mon, 13 Jan 2025 13:42:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4UKHp0RopBT5gpI@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
 <Z36KacKBd2WaOxfW@pengutronix.de>
 <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jan 09, 2025 at 08:33:07PM +0100, Andrew Lunn wrote:
> > Andrew had a large patch set, which added the phylib core code, and
> > fixed up many drivers. This was taken by someone else, and only
> > Andrew's core phylib code was merged along with the code for their
> > driver, thus breaking a heck of a lot of other drivers.
> 
> As Russell says, i did convert all existing drivers over the new
> internal API, and removed some ugly parts of the old EEE core code.
> I'm not too happy we only got part way with my patches. Having this in
> between state makes the internal APIs much harder to deal with, and as
> Russell says, we broke a few MAC drivers because the rest did not get
> merged.
> 
> Before we think about extensions to the kAPI, we first need to finish
> the refactor. Get all MAC drivers over to the newer internal API and
> remove phy_init_eee() which really does need to die. My patches have
> probably bit rotted a bit, but i doubt they are unusable. So i would
> like to see them merged. I would however leave phylink drivers to
> Russell. He went a slight different way than i did, and he should get
> to decide how phylink should support this.

Hi Andrew,

Ok. If I see it correctly, all patches from the
v6.4-rc6-net-next-ethtool-eee-v7 branch, which I was working on, have been
merged by now. The missing parts are patches from the
v6.3-rc3-net-next-ethtool-eee-v5 branch.

More precisely, the following non-phylink drivers still need to be addressed:
drivers/net/ethernet/broadcom/asp2
drivers/net/ethernet/broadcom/genet
drivers/net/ethernet/samsung/sxgbe
drivers/net/usb/lan78xx - this one is in progress

Unfortunately, I won’t be able to accomplish this before the merge window, as I
am currently on sick leave. However, I promise to take care of it as soon as
possible.

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

