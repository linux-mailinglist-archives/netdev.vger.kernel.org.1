Return-Path: <netdev+bounces-225529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44FB95206
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD0018A54C9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A931E8AD;
	Tue, 23 Sep 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NhHdJAC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A073101B4;
	Tue, 23 Sep 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618312; cv=none; b=VUbXM0k+DToK0IR/xybzgrsS70rRwSMeCz3hjB3aCJYkGCOJ0a8x1Zdk6VymgKEIPx2oh7tOCD5uHACR4/2VNTOHWuVMTmU8S7LJxdEHJtDAWd6H9PLdFBclqdrPTiRg/FVofT4zdRCxSg2bbq8tEnuiiNtHK32JmAZrfB3W6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618312; c=relaxed/simple;
	bh=Hfg0snLcgfFu5drLfEucVNQPyA7ydLPTcft7R/VdprU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFjywXgbMX6AL7iSYNHg5nKMMYOEeh1yaNy9cDnaqj5zXlgrZC4/OoKhTyYADaEfz79omIO1bIUlnmJPq8x3PPRjDi1QcTyT7zapb0p11jc31L1Zaruk78ZcY5oOoINgZ9qTUjFOpa6bRMFwPAMuydl/mq86s4aBD2lxoHtsiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NhHdJAC5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 63868C0078E;
	Tue, 23 Sep 2025 09:04:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6829760690;
	Tue, 23 Sep 2025 09:05:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03226102F191C;
	Tue, 23 Sep 2025 11:04:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758618306; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QZg1/K8eQxDZg+ZHRMpx/uJpEdtJih4Wqz5DwLkTAs4=;
	b=NhHdJAC5RIm/LtUIxmzXVoIFWuHVZ0tCPbKn0pTjLUJe6pbxoDHnFssRCVVJazDIyoeslC
	9lJRS98MgiaLeEunfg/4U0rnpt8ZpQdifGbVj+RvPGY0g+dJPllOevjlony+90kaQyBDM8
	BeAlnh+2Xwqz8l72iUmqF54fXOJq6/erK8tCqnowJE8Pix7ciruZWqDOhDhbcPYZ61rvWR
	mCPCmPTd+RQ9oyYTx7r+ckw1nXbGChoo4phJ5TqYCP9IzJ+zE3usD6l0oUWB13JrxhtFGw
	D74d7zj4fQOxVrtJhgxJSATe+vf2hPaOSyTvPNbVULi8fgTtvj3fo2Z74BMumg==
Date: Tue, 23 Sep 2025 11:04:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Luka Perkov <luka.perkov@sartura.hr>, Robert Marko
 <robert.marko@sartura.hr>, Sridhar Rao <srao@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Message-ID: <20250923110451.6d402a79@kmaincent-XPS-13-7390>
In-Reply-To: <20250922110220.4909e58b@kernel.org>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
	<20250916165440.3d4e498a@kernel.org>
	<20250917114655.6ed579eb@kmaincent-XPS-13-7390>
	<20250917141912.314ea89b@kernel.org>
	<20250922182002.6948586f@kmaincent-XPS-13-7390>
	<20250922110220.4909e58b@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 22 Sep 2025 11:02:20 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 22 Sep 2025 18:20:02 +0200 Kory Maincent wrote:
>  [...] =20
> > >=20
> > > Right, subjectively I focused on the last sentence of Oleksij's reply.
> > > I vote we leave it out for now.   =20
> >=20
> > I would like to restart the discussion as I have one more argument besi=
des
> > the boot time optimization coming from Luka Perkov in CC.
> >=20
> > According to him, not having this feature supported also brings an issue
> > across reboot:
> > "When a network switch reboots, any devices receiving Power over
> > Ethernet (PoE) from that switch will lose power unless the PoE
> > configuration is persisted across the reboot cycle. This creates a
> > significant operational impact: WiFi access points and other
> > PoE-powered devices will experience an unplanned hard power loss,
> > forcing them offline without any opportunity for graceful shutdown.
> >=20
> > The critical issue is not the impact on the switch itself, but rather
> > the cascading effect on all dependent infrastructure. Without
> > kernel-level persistence of PoE settings, a simple switch reboot
> > (whether for maintenance, updates, or recovery) forces all connected
> > PoE devices into an abrupt power cycle. This results in extended
> > downtime as these devices must complete their full boot sequence once
> > power is restored, rather than remaining operational throughout the
> > switch's reboot process." =20
>=20
> Any sort of hot reset that maintains the pre-existing configuration=20
> and doesn't issue resets is orthogonal to storing the configuration
> into the flash.

Indeed if the switch reboot and the PSE lose its power supply, the devices =
will
in any cases face a power loss. While if the PSE does not lose its power the
configuration won't be reset whether there is a permanent configuration or
not. We just need to detect during the boot if the port matrix has already
been flashed to not reconfigure all the ports. =20
This argument is indeed not relevant.

Luka any other arguments in favor of permanent configuration support?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

