Return-Path: <netdev+bounces-133564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138E996465
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6979E1C23E47
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56631189520;
	Wed,  9 Oct 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZvZK7DEL"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4C2A1D1;
	Wed,  9 Oct 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464708; cv=none; b=ShXpBUyFabsQiQWww4UBzcLUHmf5apRmdoQkTTPUOOY7xCkg+T1jdL6AqRfXO1a10nhTaRjUkHtzZGdYeFlJiRzlCxzUHHHr+22WUODP/ZSU4vLn1ke21qMWNUlPJ7LTQwxZ/+WGkkwetBWVj360+siM5IaWbxy1WFfOvM0nVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464708; c=relaxed/simple;
	bh=0eOIYAOLH8QgSYdiDgrU0MiiypvsMs/xVA9ijk4mDVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuwQfqbedAxvg7Ll+Vrfh9Lf2csPPTZBlJyL72ppMF2U26/ZBMyPPIsVTBvJHghn+S+zfcxXZzYF4s30yJDRmx2vDz0pRnNEE+ojfzIWXQvKOsYT2Q1n/WWAPUuMCNY8ZSeNT4br1PLFv4/6DDhKQVk79dyEt1q8j+mUIa0JWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZvZK7DEL; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA7744000C;
	Wed,  9 Oct 2024 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728464703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEp0yzzHfdaZIi2D1X1iqjCNbnFmC6EDt/wxUJK6RWc=;
	b=ZvZK7DELMmQErgSt+P5O08EfRtDGRj3Wv7N4jPTjg+LsljgQQ5hw5xIyWx6ExHKWjuvkiU
	bwkDFgfaWY+DkCDZn/R3Qbsz++eScDScjqPwFaytYAV6WZ3wOAXuBh9QcxKNXFkxdXdmA6
	e5cVzGMO7qiKPGYEPEUDOxzkz1GPH+PStRh6d46GMR4ZfiTqHCC0tFiQkJpjfKznKie2Bp
	35sUK8/gPF3WmFMXGUUpFkfjyYiCTQkOZ0b9kHZdAcohJpdOOQLJLMb24VSpfet+AuZeZo
	6MpN8BOEv5YqdwDxU/bTOAjE3Qcf9APCsaG/7aI/SsOjTTzDaUD+kXxZx6RLXA==
Date: Wed, 9 Oct 2024 11:05:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 04/12] net: pse-pd: tps23881: Add support for
 power limit and measurement features
Message-ID: <20241009110501.5f776c9b@kmaincent-XPS-13-7390>
In-Reply-To: <ZwYOboTdMppaZVmX@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-4-787054f74ed5@bootlin.com>
	<ZwYOboTdMppaZVmX@pengutronix.de>
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

On Wed, 9 Oct 2024 07:02:38 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Oct 02, 2024 at 06:28:00PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Expand PSE callbacks to support the newly introduced
> > pi_get/set_current_limit() and pi_get_voltage() functions. These callba=
cks
> > allow for power limit configuration in the TPS23881 controller.
> >=20
> > Additionally, the patch includes the detected class, the current power
> > delivered and the power limit ranges in the status returned, providing =
more
> > comprehensive PoE status reporting.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> > +static int tps23881_pi_get_class(struct tps23881_priv *priv, int id)
> > +{ =20
> ....
> > +	if (chan < 4)
> > +		class =3D ret >> 4;
> > +	else
> > +		class =3D ret >> 12; =20
>=20
> ....
> > +tps23881_pi_set_2p_pw_limit(struct tps23881_priv *priv, u8 chan, u8 po=
l)
> > +{ =20
> ....
> > +	reg =3D TPS23881_REG_2PAIR_POL1 + (chan % 4);
> > +	ret =3D i2c_smbus_read_word_data(client, reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (chan < 4)
> > +		val =3D (ret & 0xff00) | pol;
> > +	else
> > +		val =3D (ret & 0xff) | (pol << 8); =20
>=20
> This is a common pattern in this driver, we read and write two registers
> in one run and then calculate bit offset for the channel, can you please
> move it in to separate function. This can be done in a separate patch if
> you like.

The pattern is common but the operations are always different so I didn't f=
ound
a clean way of doing it.
Here is a listing of it:
	if (chan < 4)
		class =3D ret >> 4;
	else
		class =3D ret >> 12;

	if (chan < 4)
		val =3D (ret & 0xff00) | pol;
	else
		val =3D (ret & 0xff) | (pol << 8); =20

        if (chan < 4)                                                      =
    =20
                val =3D (u16)(ret | BIT(chan));                            =
      =20
        else                                                               =
    =20
                val =3D (u16)(ret | BIT(chan + 4));

	if (chan < 4)
		mW =3D (ret & 0xff) * TPS23881_MW_STEP;
	else
		mW =3D (ret >> 8) * TPS23881_MW_STEP;


Any idea?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

