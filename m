Return-Path: <netdev+bounces-123071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1285A963974
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6A2286E7D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3236446DC;
	Thu, 29 Aug 2024 04:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C63647
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724906496; cv=none; b=BjahelaSkMoGSWpxxK51FtcIVYLA8nI71KUmF/+EjEtxwQcBarLrOwH8u8hEgwHn0EdoK/gBxJIRkHAwMPLmhPM+07PTqhs1Oe9CmcZRfS1XtI7jCk84et2xvJ7+TnL+d3gZbAKPRjCLRHDQAXawSCsMAWmafEXbGvurh+xik+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724906496; c=relaxed/simple;
	bh=3rllQjmbEZCYwN9ErW63EE7kAPINPRUq8exZ+n/igpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThIjUXX/Pc+znGXLf6VvkOG7hFqWqDN3RneIjgii5LE6mcwzobNQCA+wCyhYQgxkMTmY30+gc1QkDz9reRf31aLDRd/F59R/RwQJqFQsuL1S5JdFQdmF7ZeWEapM3zBcQ9HOyeTA50xj9MMLTd8R21fTTQifrgWAskMeRU+D2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjWy7-0007wT-3l; Thu, 29 Aug 2024 06:41:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjWy5-003pa1-Ex; Thu, 29 Aug 2024 06:41:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjWy5-00CYNc-18;
	Thu, 29 Aug 2024 06:41:09 +0200
Date: Thu, 29 Aug 2024 06:41:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <Zs_75YSR62UF3Ffi@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
 <20240822115939.1387015-2-o.rempel@pengutronix.de>
 <20240826093217.3e076b5c@kernel.org>
 <4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
 <20240826125719.35f0337c@kernel.org>
 <Zs1bT7xIkFWLyul3@pengutronix.de>
 <20240827113300.08aada20@kernel.org>
 <Zs6spnCAPsTmUfrL@pengutronix.de>
 <20240828133428.4988b44f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828133428.4988b44f@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 28, 2024 at 01:34:28PM -0700, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 06:50:46 +0200 Oleksij Rempel wrote:
> > Considering that you've requested a change to the uAPI, the work has now become
> > more predictable. I can plan for it within the task and update the required
> > time budget accordingly. However, it's worth noting that while this work is
> > manageable, the time spent on this particular task could be seen as somewhat
> > wasted from a budget perspective, as it wasn't part of the original scope.
> 
> I can probably take a stab at the kernel side, since I know the code
> already shouldn't take me more more than an hour. Would that help?

Ack. This will be a great help.

> You'd still need to retest, fix bugs. And go thru review.. so all
> the not-so-fun parts

Sure :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

