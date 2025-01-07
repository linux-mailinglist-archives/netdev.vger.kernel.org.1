Return-Path: <netdev+bounces-155851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60EA040C8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B4C163BBB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D719CC0E;
	Tue,  7 Jan 2025 13:26:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9E1F0E36
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256413; cv=none; b=lzA9umQZ8IHtEJz+IdCM3kvoRA4YephhqqTNpuwxixNgyWOz8mz9GsEnO4MKrsii4OphVHtkfZCPfZNlcHhYn2iryG9U9BBk1nivhTYZtcqIkXGpDTLYsfS90vgvpNbrv7zPZu/+wBZ1WUm5figizRjNAJt/CJfCyrz9AJpqSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256413; c=relaxed/simple;
	bh=6GA5hOjBzeLpP/QblVqoPNmHriyPhBlC9hzbwPm3pq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0RyYAIdYKewviHR/rZVTGqNk3nk79Q7s+4PBow/DHdWEnofEksLLQgVgVoHhp99c0DpY1/rMIIVGfAYdpm8CmMo0nIobJr4TPt+nw5CP6Yj5ris75EFAefMfPAXjMkUeNJ6NBdnycEZdEtFpqwsQRst1PAyr3Z5FTOF3zbcfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tV9bP-0000CN-3U; Tue, 07 Jan 2025 14:26:35 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tV9bM-007Lur-38;
	Tue, 07 Jan 2025 14:26:33 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tV9bN-009ZSe-23;
	Tue, 07 Jan 2025 14:26:33 +0100
Date: Tue, 7 Jan 2025 14:26:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Woojung Huh <Woojung.Huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: microchip: remove
 MICREL_NO_EEE workaround
Message-ID: <Z30ricuKrGZ95Bso@pengutronix.de>
References: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
 <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
 <Z3za4bKAJWh3HO9u@pengutronix.de>
 <7742385d-3aea-4128-a04c-d86b263689cc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7742385d-3aea-4128-a04c-d86b263689cc@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 02:03:27PM +0100, Andrew Lunn wrote:
> > I have two problems with current patch set:
> > - dropped documentation, not all switches are officially broken, so
> >   keeping it documented is important.
> > - not all KSZ9xxx based switches are officially broken. All 3 port
> >   switches are not broken but still match against the KSZ9477 PHY
> >   driver:
> >   KSZ8563_CHIP_ID - 0x00221631
> >   KSZ9563_CHIP_ID - 0x00221631
> >   KSZ9893_CHIP_ID - 0x00221631
> 
> When you say "not broken", do you mean there is text in the errata
> which says they do really, truly, work, or there is simply no errata
> which says they are broken? Do you have these 3 ports switches and
> have tested them?

There are multiple true conditions in this case:
- Documentation claims EEE is supported
- Errata documentation do not recommend to disable it
- I have access to this variants, they are relatively common in
  industrial products. So far it seems to work without issues.

> It seems odd to me that the 3 port version should work. Why is it
> special?

In my case, on KSZ9477 the EEE starts to have issues as soon as i start to use
more then 2 ports. I assume, it is switch internal power domain
integration issues and not directly related to actual PHYs. May be it is
possible to handle it some how or disable EEE only for some ports, or
not enable for more then 2 ports, but if vendor removes EEE from
documentation I see it as officially not supported.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

