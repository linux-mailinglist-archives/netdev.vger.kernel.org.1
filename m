Return-Path: <netdev+bounces-220898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE52B49650
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD241207A95
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DA30FC3F;
	Mon,  8 Sep 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ivj7SIcU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6D53A7;
	Mon,  8 Sep 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350667; cv=none; b=efXY0gq8fRxBG5h8l61bXX4xlpcBJMduPy8RzvytH5LgZI+rildDZtJ9fllu8Gf90NM1ZB7VtoyMOMt6wXEaGt1dsbhvqPT1ls6VFJ185BRXfUFD2eUFBnyU5K6BX9fl+/+aeUU9drYjAmDkMHDZQWseR7VRaUBaBRoDXCv0bEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350667; c=relaxed/simple;
	bh=/qelRmYr3Q/9Ite35XcawnNc4XvZolL9PylH3Ax8o+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFNqP3+a4F4B85vcjNE+ybSxwZCQNnl5tf6tD6vWhmFqLt0FcRhkCIfKZvZ/Z65k4Ym+nmwmZhWa3WDrcAERRurM/H2PhY8C3sNsg4z7ReY6j7DYvHPpKopPuWbPLBnAoAONMiYCR6hyBdH/z0srOQ9/TTaPcXhCYWtpVIZM2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ivj7SIcU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C5FE91A0964;
	Mon,  8 Sep 2025 16:57:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90FF36061A;
	Mon,  8 Sep 2025 16:57:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE512102F289F;
	Mon,  8 Sep 2025 18:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757350662; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fKXqpYuHrmlZ+6q6Sntvh/B1FhNEe/BmEN2KsR5ia3E=;
	b=ivj7SIcUAAyvLHTlvOAYjVWoumaZrgJ6KWxhna6Ur3x3D010MzqZQVXzsK92JTP78+yUZ1
	2tTwK1l9KsozoYegeThbog5kjttURzIUIm+UyCGnXtdvGUby1mcMLTzOX4UYYAjHJ414pz
	LjiOUrVvOp+LGW7bWPMGRLz4qFKSx5UKp6wW4N+Wn5FON4d8HYu14OSeN2MryXhYM29P6x
	txGVSHRrc7ZyLDrz0vCVtCq0FypfAzI4SlxvXxt26WKmnpa2O7fiaxOg1SfKxyvWk7PVR6
	vAwLRiZhyU7fXhXRY9brKLOnWNRJ0cuc/qZQwUOZSDM0xGhTJcy/4UfJgu9JlQ==
Date: Mon, 8 Sep 2025 18:57:28 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Gregory Fuchedgi <gfuchedgi@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Guenter Roeck
 <linux@roeck-us.net>, Robert Marko <robert.marko@sartura.hr>, Luka Perkov
 <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
Message-ID: <20250908185728.132e9665@kmaincent-XPS-13-7390>
In-Reply-To: <CAAcybuvqqKBniV+OtgfCLHJdmZ836FJ3p7ujp3is2B8bxQh4Kw@mail.gmail.com>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
	<4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net>
	<aL5g2JtIpupAeoDz@pengutronix.de>
	<CAAcybuvqqKBniV+OtgfCLHJdmZ836FJ3p7ujp3is2B8bxQh4Kw@mail.gmail.com>
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

On Mon, 8 Sep 2025 09:39:58 -0700
Gregory Fuchedgi <gfuchedgi@gmail.com> wrote:

> On Sun, Sep 7, 2025 at 9:51=E2=80=AFPM Oleksij Rempel <o.rempel@pengutron=
ix.de> wrote:
> >
> > On Sun, Sep 07, 2025 at 09:06:25AM -0700, Guenter Roeck wrote: =20
> > > +Cc: pse-pd maintainers and netdev mailing list
> > >
> > > On 9/4/25 10:33, Gregory Fuchedgi via B4 Relay wrote: =20
>  [...] =20
> > >
> > > This entire series makes me more and more unhappy. It is not the
> > > responsibility of the hardware monitoring subsystem to control power.=
 The
> > > hardware monitoring subsystem is for monitoring, not for control.
> > >
> > > Please consider adding a driver for this chip to the pse-pd subsystem
> > > (drivers/net/pse-pd). As it turns out, that subsystem already supports
> > > tps23881. This is a similar chip which even has a similar register se=
t.
> > >
> > > This driver could then be modified to be an auxiliary driver of that
> > > driver. Alternatively, we could drop this driver entirely since the
> > > pse-pd subsystem registers the chips it supports as regulator which h=
as
> > > its own means to handle telemetry. =20
> > Yes, Guenter is right. This driver belongs to the pse-pd framework. =20
> No disagreement here in principle. However, the current hwmon driver
> already implements power control and exposes it via in*_enable sysfs
> files. I found this a bit odd, but I don't write drivers often.
> My understanding of Guenter's suggestion is that it would require breaking
> this userspace API?
>
> From a quick look at the tps23881 datasheet I can see that it is
> similar, however, it is quite different in the context of this patch.
> tps23881 (unlike tps23861) has Port Power Allocation register that can
> limit poe power class. This register can be set prior to
> detection/classification. So the extra complexity of an interrupt
> handler that decides whether to enable the power may not be required.
>=20
> Perhaps it still makes sense to merge these drivers, but I don't have
> time or hardware to do it at the moment.

In either way the tps23861 is a PoE controller therefore the driver should =
land
into the pse-pd framework. Then tweaking tps23881 driver to support tps2361=
 or
using a standalone driver is another question.
=46rom a quick look the register map is really similar so indeed using tps238=
81
driver seems relevant.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

