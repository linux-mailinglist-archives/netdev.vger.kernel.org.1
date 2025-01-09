Return-Path: <netdev+bounces-156806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8EA07E0F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D52188C595
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357171591E3;
	Thu,  9 Jan 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kRLQQavD"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857502B9BF;
	Thu,  9 Jan 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441398; cv=none; b=ls1eLBwEXEmQY5Dx4Kr6yRK5q+ByyrZsu5PTTHUxQFCgQffzIsI2rL8kd9Hf4XE0OVtMAWgvZlzwdCptkAORIwEqrMbhxbwNY3DxE6eujzJHxxu07T3q/FFs5yb/1e5Yx9uruHhehONjAY2T6vW3o/HSGnVEZ9ELRV+G/Nn9zgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441398; c=relaxed/simple;
	bh=KYOINm7i9VEnqxTpEy3685WzEKCTpOkGjOhUernrHqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/rq1jCPpoOQMX0KuDWMyjMeVBvidkcfCm2+dmNLCwDPfmq2JMjX+eUmelQIcdZka8AMALUZIaC+Q1ot/CREyFRqYSU3+K8OPyEAc1iVAYEFT2mhogPC5rmvPytWmg+LVPfMSL1CUj1sKN5AguJQkYlU3FmJAGwjDQ/uUGxZ0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kRLQQavD; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBBE760003;
	Thu,  9 Jan 2025 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736441388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lFuNNIQPI4nDahw9mmphg1giwpfblVA/Nb+UIaiTxA=;
	b=kRLQQavDSK58OBObxcW4mHJkHTGohvYbULw4HSckpVrl6WuZ32h1oIzBsQIz7lyI/P9D5H
	G/QUQ37/SJ1vagBD72bKEI4C9DfOt5YDgHFGOHRa/c8Zhsvp3cp0w+zmIAtLSKSl2+YZJk
	k0P8ckTlAme3ZrDYGeaWFioTQmEAHWPOFPjTElnF4ACDEEvGz8iq3A770EoXxtYlhUojkW
	FfCZVqoNeSPqEvsoR3exyW1NTdsubWrck7ITr0lwUzhJTUiilmLEOwZZfK7OLZoHSh2vmO
	8cCg0oXWD7X3sK0vSFQGmMPFUvpv4pVnez5nMlULcWqwtB/jW//T0t1IodUHjA==
Date: Thu, 9 Jan 2025 17:49:42 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <20250109174942.391cbe6a@kmaincent-XPS-13-7390>
In-Reply-To: <Z3_415FoqTn_sV87@pengutronix.de>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
	<20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
	<20250109075926.52a699de@kernel.org>
	<20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
	<Z3_415FoqTn_sV87@pengutronix.de>
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

On Thu, 9 Jan 2025 17:27:03 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Jan 09, 2025 at 05:09:57PM +0100, Kory Maincent wrote:
> > On Thu, 9 Jan 2025 07:59:26 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >  =20
> > > On Thu, 09 Jan 2025 11:18:05 +0100 Kory Maincent wrote: =20
>  [...] =20
> > >=20
> > > This index is not used in the series, I see later on you'll add power
> > > evaluation strategy but that also seems to be within a domain not
> > > device?
> > >=20
> > > Doesn't it make sense to move patches 11-14 to the next series?
> > > The other 11 patches seem to my untrained eye to reshuffle existing
> > > stuff, so they would make sense as a cohesive series.=20

I think I should only drop patch 11 and 12 from this series which add somet=
hing
new while the rest is reshuffle or fix code.

> > Indeed PSE index is used only as user information but there is nothing
> > correlated. You are right maybe we can add PSE index when we have somet=
hing
> > usable for it. =20
>=20
> No user, means, it is not exposed to the user space, it is not about
> actual user space users.

I may have understood incorrectly but still. Not sure the PSE device index =
is
interesting for now even in the budget evaluation strategy series. It is
related to PSE power domains therefore PSE power domain index solely should=
 be
sufficient.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

