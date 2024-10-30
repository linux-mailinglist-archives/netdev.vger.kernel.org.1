Return-Path: <netdev+bounces-140515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E829B6AF0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B01F22A44
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22781BD9D6;
	Wed, 30 Oct 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Isx38tk7"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03A1BD9C1;
	Wed, 30 Oct 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308945; cv=none; b=uT+0/2tGTzUdb4Knvmj9YbVuAWY3Y70m2aTJYjYvmCQPwwO2/Da/kdFLIgnAS4sp0TifF633shj8jSAWxpGCZAwGtmN7JmOOKgzuGhS9jv0OR1A0sErZ/tc/ZtWkvsGLrj/aGlTUk7xBOtY83SMBbwBMfpYVLI2jSV+iPVAl8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308945; c=relaxed/simple;
	bh=yJI/KN0QV+FGbBrfug/3JZ2fSgPYvKiFczHGYJW8Obg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNPgl52C25s7WSjRMoGRFQoo7cVAc3WD+84Qs2J1jkw7jU73s5AtTIB4uTIjXOEjkvrgIAhaAY4NLgGtESxmroPdHc/5wOBVnw75IsFlW8/lsAADhAmk417r0OZCTjZ3GN8kLYgUOnmUH49lXAmQLoa4IkEcpu8TliiQMRhAQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Isx38tk7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC6811BF207;
	Wed, 30 Oct 2024 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730308935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PneAeip2yThhZiBBYb/wXses00dWHbuNfa0w6dr4QhY=;
	b=Isx38tk7mCrJdHi5WFs3DqOEg3Ah3NVRqsyFAdDsOwrBAceFQeeo217YSXZITcH2dqTcGx
	M3rTbLeKmJsXYT7HC/pOOVWhtHdpavhsczuoJo8N3AIgyYDO2Loa+EjyAg0WSghAU992Bx
	G49hM+km6AIkrFwbA6yjIaefVGuIrVWhUGmPosPFqQ97BCpVLOokcrat4eK+sM0iZqUwT+
	9c428UMlSnKEAzjRwvxGniD+qAIJw6mNPbpGG+N6GEm9GpyxUlfbgnJudHKXy2G/8PNY1S
	CW+KgZagHo7/Kpgf40KWVNV5tt3MNRVt0Vp1COP23MhCHYNfV5FAGOvqmRwGMQ==
Date: Wed, 30 Oct 2024 18:22:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 11/18] regulator: Add support for power
 budget description
Message-ID: <20241030182211.748c216e@kmaincent-XPS-13-7390>
In-Reply-To: <578d2348-9a17-410e-b7c8-772c0d82c10f@sirena.org.uk>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
	<20241030-feature_poe_port_prio-v2-11-9559622ee47a@bootlin.com>
	<578d2348-9a17-410e-b7c8-772c0d82c10f@sirena.org.uk>
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

On Wed, 30 Oct 2024 17:03:06 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Oct 30, 2024 at 05:53:13PM +0100, Kory Maincent wrote:
>=20
> > +/**
> > + * regulator_get_power_budget - get regulator total power budget
> > + * @regulator: regulator source
> > + *
> > + * Return: Power budget of the regulator in mW.
> > + */
> > +int regulator_get_power_budget(struct regulator *regulator)
> > +{
> > +	return regulator->rdev->constraints->pw_budget;
> > +} =20
>=20
> This is going to go badly with multiple consumers...

On my series the available power budget of the PIs (which are consumers) is
managed in the PSE core in the PSE power domain (patch 13). We could move it
directly to regulator API.

> > +static inline int regulator_get_power_budget(struct regulator *regulat=
or)
> > +{
> > +	return 0;
> > +} =20
>=20
> We should probably default to INT_MAX here and in the case where we do
> have support, that way consumers will fail gracefully when no budget is
> specified.

That's true. Thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

