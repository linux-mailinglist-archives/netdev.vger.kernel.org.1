Return-Path: <netdev+bounces-105768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0960D912B54
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1996289254
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420F115FCFE;
	Fri, 21 Jun 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kdhJHB5p"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E215FA65;
	Fri, 21 Jun 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987362; cv=none; b=kH9DFOMYTP7Pqb/BXvFNeYom/jf1p1lt3oONk3camdziuDN89dtFkbGQEBqJ1j+mo2FSV+jbi0pL6sbUV1TriybjEkLFUALbrnLqdnPPm8zEMP7BjusuPu/xjzPQ/4nzMil9hdbWDtpFMsq3UBKV5YVABinqKf7ZdtIk/+4V7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987362; c=relaxed/simple;
	bh=FxBvFuYD5hrFQUJN1N4ag6bR5iXAGaCbxNaZ9XTQDaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXBOFcxPcB2+4+SPEmSh4JGp0BuA+on1IFedsXRH+MnFd0mb1tCz1kIGD/RPLxulfWIcYV/h5w6Pm1Ir5pO2j92mUsF0LM6hnJNiuG6mHSHM73L4AG3i3MGsGGxiQ2sc2FrAelf8AtMNAlVb3VXZlWRGMEB0p6hgQNdon2dYXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kdhJHB5p; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AEB1C40002;
	Fri, 21 Jun 2024 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718987357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ7LpcaHTzpOkXr2f3P+YAPN8LFusCgiYt9CIVPUBcM=;
	b=kdhJHB5pfJ5sAzuClexAuSKbl187w6QgZy/6lkn+jF/idI7zV3PA3KHX8MZHtrUHyfERq5
	r9y5c4z7uGUGryIDzFGw3y96QZT0egTJtsM/9P6WIMKH6jXzisa/Bx+zTb9a/hkKvva2bv
	o9gQrpBluVw1piVLuG8fNQTTdlb9/57kYnZkfX8/oIIorzZBEoF9nYktJoN2Odef6ZD/hl
	MPYOIUkFNn67hyQDi+uya8+OfORPh+KqgCPhYK3PUa0PDHoMugenior0lmvTDDXFXMwp8m
	2utCBxeUbKat0amNlXKmkF1cJC7b32WboX7EbjJwSfy2/vG+EH4F6FNaQdOFmg==
Date: Fri, 21 Jun 2024 18:29:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <20240621182915.3efd9ccf@kmaincent-XPS-13-7390>
In-Reply-To: <ZnCUrUm69gmbGWQq@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
	<20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
	<Zm15fP1Sudot33H5@pengutronix.de>
	<20240617154712.76fa490a@kmaincent-XPS-13-7390>
	<ZnCUrUm69gmbGWQq@pengutronix.de>
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

On Mon, 17 Jun 2024 21:55:25 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Mon, Jun 17, 2024 at 03:47:12PM +0200, Kory Maincent wrote:
>  [...] =20
> >=20
> > Mmh not really indeed, maybe we can put it in error_condition substate?=
 =20
>=20
> I'm not sure how this error can help user, if even we do not understand
> what is says. May be map everything what is not clear right not to
> unsupported error value. This give us some time to communicate with
> vendor and prevent us from making pointless UAPi?

Is it ok for you if I use this substate for unsupported value:
ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS
or do you prefer another one.

> > Should I put it under MPS substate then? =20
>=20
> If my understand is correct, then yes. Can you test it? Do you have PD
> with adjustable load?

Yes I will test it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

