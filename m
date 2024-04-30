Return-Path: <netdev+bounces-92331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3F8B6AD9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F871F2197D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B72B9A5;
	Tue, 30 Apr 2024 06:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984817731
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459715; cv=none; b=eVGEEDg95XjkTcb9KlaR5vLmvdWDMdL/9DpPYkPA7xn7yWjcrFo6MIvb9BVH71fgrVk6hNvpCTbe3HnN++aMqLzA5C1IyizCHHnhxSHOTe8ECm4tOS8Z04RNYunBh73ozv2LUzERieaPVd3fK60Rbm2oyHxVmodLa5pL3Oo/T/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459715; c=relaxed/simple;
	bh=QlWC6sF6a80KgWmsLCDwe8nl2naO+GsOgOEyO/ax9Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcUJUw+CgQdL9lXKvkT/D4FvM1v9ODnyGuOhylLEV1TjJRA8oBOLuwvT3RGUHCiscpTOuWmS+jLf350a7l1y2xBWGr8wsxBO4yFPEi6w+BZDcI2Qjwj9EPB6+cHECHoGh7eF6+lxITqfD4XQQJgQIeAgojN35cVqM9ZbotYLEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s1hHt-0007c7-Bj; Tue, 30 Apr 2024 08:48:25 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s1hHr-00F7HM-Pl; Tue, 30 Apr 2024 08:48:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s1hHr-0047M1-2H;
	Tue, 30 Apr 2024 08:48:23 +0200
Date: Tue, 30 Apr 2024 08:48:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <ZjCUN5V516RSxgoq@pengutronix.de>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <Zi--4ko_vAtFSxyn@finisterre.sirena.org.uk>
 <20240429192848.13c576b7@kmaincent-XPS-13-7390>
 <ZjBWE5XEJjHjftsn@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjBWE5XEJjHjftsn@finisterre.sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Apr 30, 2024 at 11:23:15AM +0900, Mark Brown wrote:
> On Mon, Apr 29, 2024 at 07:28:48PM +0200, Kory Maincent wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> > > On Fri, Apr 26, 2024 at 12:42:53PM +0200, Kory Maincent wrote:
> 
> > That's right I was focusing on power where I could use already implemented
> > voltage and current callbacks. Would you be interested to a new get_current()
> > callback to know the current and allows regulator to deduce the consumed power
> > or should it be specific to PSE subsystem.
> 
> That feels like it belongs in hwmon or possibly power rather than in the
> regulator API but it does feel like it's generally useful rather than
> PSE specific.

I would say, it depends on use case and abilities of HW. Power
consumption may change rapidly, so it is all about sampling rate. For
real time current measurement you wont to use iio framework. For most
cases and simple diagnostic are more interesting max and probably min
values which self cleared after last read.

If HW provides only real time measurement, then the question is, how
many samples are needed to provide some usable result.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

