Return-Path: <netdev+bounces-123432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D7964D75
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7CF28121E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9CD1B6525;
	Thu, 29 Aug 2024 18:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F51AD9DE
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955009; cv=none; b=IOolopY/8OD5Aj8of6VjFW2gM0sks90IbMA5RolUCMoSkOLiXVb6dyrOPZQgzVMs+u/h2EKmUCvoI3WFWtzP/zc0dA7ds5zez32HPhJ0O3D/StEb/kvrKVM+a1Vgb1D+1jedbfncag7SIUt3prfDw5EJGUgyltFMNFCEsQ1ICRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955009; c=relaxed/simple;
	bh=7UzzKlbW3UeySdD52GyL382wftf/pCCXa3EMleqDW58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmRaL8S+hTv3NArpS5BKhYzNb+/ABzoJ5oaPppt5YXtOi3Le/kJ8LJuKaeC4klS6yOD0pwQ6Ug74+D/KiGPUMJjyj4OsmL4yJGjdUaJ7fdo2FhsHZBk7WmT9jaEdBLoMwV0a/f/mb7bLDd4wRNUNM5hTv64YWf9QiU27a3ZuYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjjas-0006tR-5g; Thu, 29 Aug 2024 20:10:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjjaq-003y7c-Jt; Thu, 29 Aug 2024 20:10:00 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjjaq-00Ciqv-1a;
	Thu, 29 Aug 2024 20:10:00 +0200
Date: Thu, 29 Aug 2024 20:10:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Vladimir Oltean <olteanv@gmail.com>,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <ZtC5eLe8GQRE5dU_@pengutronix.de>
References: <20240829174342.3255168-1-kuba@kernel.org>
 <20240829174342.3255168-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829174342.3255168-2-kuba@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Aug 29, 2024 at 10:43:41AM -0700, Jakub Kicinski wrote:
> Feed the existing IEEE PHY counter struct (which currently
> only has one entry) and link stats into the PHY driver.
> The MAC driver can override the value if it somehow has a better
> idea of PHY stats. Since the stats are "undefined" at input
> the drivers can't += the values, so we should be safe from
> double-counting.
> 
> Vladimir, I don't understand MM but doesn't MM share the PHY?
> Ocelot seems to aggregate which I did not expect.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Huh.. it is completely different compared to what I was thinking.
If I see it correctly, it will help to replace missing HW stats for some
MACs like ASIX. But it will fail to help diagnose MAC-PHY connections
issues like, wrong RGMII configurations or other kind of damages on the
PCB. Right?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

