Return-Path: <netdev+bounces-131209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7A98D39A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A162283AB3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0251D0156;
	Wed,  2 Oct 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YKEQ5BS6"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931091D0154;
	Wed,  2 Oct 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873223; cv=none; b=DsWDB4MGlwBnQh+aN5dAu4ezCtyETpuRSfzlCDHvNTldp2ewcvON5m0rPJYjtuhwsE5GL5QnGarnKdjxTh8z/f+MkXtZLCI3/LurlV1NZo3J0t1wkwnzkTl4Lhrf8cUy1LJF9VLz4FmPHFkrFm1gnB2wMqVZ+LhK5H7rPIJ+afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873223; c=relaxed/simple;
	bh=zhpqUVQ2nHb34lZLCPmON/Qjx9HwO+P63lEWJgcqlSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LocamKp98qe/1lk1abGQoX2VoH4wvxThyHclBo+Fh7oKl5XukATF43p2rcDC0r+BtqCQoEaGreL8Z8TrxfQj5NSD1DE2R0o1uOPCWnxaRCOwqR2S0L+RqS8M2HLyiG5NqeThZKNG/DFUekiA6G2XxW58fmyWcyUOZRxb24uyJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YKEQ5BS6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 218D120008;
	Wed,  2 Oct 2024 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727873218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbvkVMd1fGlJEismdRI4AKePJ/0dZjQyGLN1Pqox8xE=;
	b=YKEQ5BS64BhB5rX/9SH4eLPn51IFGaoNssmm0MkD5VBYwnFsfDFN3yM8iJCGx7qeF1m0PF
	xyHtClbMX0Yteo3vS015SyIuv8b/qVRoHkKti0t4TeBWiJCxks3bWrtzmOu9c66rdiSX3O
	cg2HSljWMdLrKfCKaOgNspqueDn3PrT5eMeWzaBUmfkLPLiUXuHVdDZw/XLNk7PYkNiK6Z
	8pNGWGYEYfItAXKxmoZv84R4yK9+/cOoS90qrUxN4XzZBwM77pmh++raOdp/UgQj0nZZYz
	JwA9rbEoGlq7j1cSgVdvsOR0vZfOs+uqQLE+7UNq+k5FcNaPffexsMPzTRS8Cg==
Date: Wed, 2 Oct 2024 14:46:56 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 thomas.petazzoni@bootlin.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: Fix enabled status mismatch
Message-ID: <20241002144656.31e59f0e@kmaincent-XPS-13-7390>
In-Reply-To: <965905ef-cc00-49fa-bee9-2b45d6155108@lunn.ch>
References: <20241002121706.246143-1-kory.maincent@bootlin.com>
	<965905ef-cc00-49fa-bee9-2b45d6155108@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 2 Oct 2024 14:38:19 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Oct 02, 2024 at 02:17:05PM +0200, Kory Maincent wrote:
> > PSE controllers like the TPS23881 can forcefully turn off their
> > configuration state. In such cases, the is_enabled() and get_status()
> > callbacks will report the PSE as disabled, while admin_state_enabled
> > will show it as enabled. This mismatch can lead the user to attempt
> > to enable it, but no action is taken as admin_state_enabled remains set.
> >=20
> > The solution is to disable the PSE before enabling it, ensuring the
> > actual status matches admin_state_enabled.
> >=20
> > Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE
> > framework") Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > FYI: Saving the enabled state in the driver is not a viable solution, a=
s a
> > reboot may cause a mismatch between the real and software-saved states.=
 =20
>=20
> This seems O.K. to me.
>=20
> I'm assuming the controller has turned the configuration state to off
> to stop the magic smoke escaping? Is there any sort of notification of
> this?  Does it raise an interrupt? Sometime in the future we might
> want to add a netlink notification about this?

Thanks for your review!

Yes, in case of over-current or over-temperature, there is an interrupt. The
netlink notifications support will arrive soon in the series in progress.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

