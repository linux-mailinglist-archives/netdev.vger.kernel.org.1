Return-Path: <netdev+bounces-110358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9B92C236
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A00FB2ED02
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3189C19F486;
	Tue,  9 Jul 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SyDIDQH5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736D158A36;
	Tue,  9 Jul 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542838; cv=none; b=ZHq+McgMJOYg069tTn3yvXM+gd4Z178HeVI9OY5Vmic8cNYUMm/5mP8HmwU9LOpEKfNs3U8t3iOwWUD4UEJxFJNTPQX8WMpgCxT6v/yGs/kUwAO5HlxKRo+ea5H3QbN53+vRkzzzmDx/V3/IZ2xc6pY5+h4wzshw3qZRnydhtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542838; c=relaxed/simple;
	bh=UK1xgHEzajeGllYI2kRF8rHmhdURPXisZUswpRuwiNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFlcIzVnpi66Ded+qjUncp+tsHZiwNNUsEAFfUoIXUnl9a7yoF9J/w2/kDsq4fME1uUovnJ79CjOaWVOUazG/o0YL1ru0x0G7sp0j7/PwJlydJOksVJmq8M5iJAEax1QsvUulr04neGTZ3i1ylI5Ga03jHNsXZlsyDx7QspLers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SyDIDQH5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A9EE20007;
	Tue,  9 Jul 2024 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720542833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x0AAyScM7vdDgaiQAw8ZvRTEHXX/3oaTOsMVo7wPHg=;
	b=SyDIDQH5kqowfxOQjM82jF1YHKDDlTbfQAV60o9gQhXcUp81yt0vhvp/I4n9kRFL6IpfNG
	cP+jI07moNTX+pL0I2WsrakLgZj3zITRy+rIi1GSmw55skV+OUmQFfovOftqdLeacvDv9w
	QS0+wvP8UO/ihaLPzhO6/lHl7BTNqyS5TmyAk9bb4rSSlVM8QiPemkY9h69tLDuF1TkzfM
	MoV7ZG5sLC05i0I1rJEiomxgGk08NyOd0ofEQtL/BXsM8TvtWFNdyMEQMtQ5gP+Ukam6xe
	LRRwg/5WB8LnYJxWmFaGTxXi2DUqP/8nXhDETKOxZEheWpl1l5WB4ZRt14EGpw==
Date: Tue, 9 Jul 2024 18:33:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ethtool: pse-pd: Fix possible null-deref
Message-ID: <20240709183351.79ba61ea@kmaincent-XPS-13-7390>
In-Reply-To: <20240709085205.0fa41f8f@kernel.org>
References: <20240709131201.166421-1-kory.maincent@bootlin.com>
	<20240709071846.7b113db7@kernel.org>
	<20240709164305.695e5612@kmaincent-XPS-13-7390>
	<20240709085205.0fa41f8f@kernel.org>
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

On Tue, 9 Jul 2024 08:52:05 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 9 Jul 2024 16:43:05 +0200 Kory Maincent wrote:
> > > Normal ethtool flow is to first fill in the data with a ->get() then
> > > modify what user wants to change.
> > >=20
> > > Either we need:
> > >  - an explanation in the commit message how this keeps old config; or
> > >  - a ->get() to keep the previous values; or
> > >  - just reject setting one value but not the other in
> > >    ethnl_set_pse_validate() (assuming it never worked, anyway).   =20
> >=20
> > In fact it is the contrary we can't set both value at the same time bec=
ause
> > a PSE port can't be a PoE and a PoDL power interface at the same time. =
=20
>=20
> In that case maybe we should have an inverse condition in validate, too?
> Something like:
>=20
> 	if ((pse_has_podl(phydev->psec) &&
> 	     GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_PODL_PSE_ADMIN_CONTROL)) ||
> 	    (pse_has_c33(phydev->psec) &&
> 	     GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_C33_PSE_ADMIN_CONTROL)))
> 		return -EINVAL;
>=20
> GENL_REQ_ATTR_CHECK will set the extack for us.

I don't think it will work.
In a case a PSE controller have one PoDL port and one PoE port.
Your code will always return EINVAL if we try to set the config of only one=
 of
those ports.=20

I think the patch I sent plus a change in pse-pd core to do nothing in case=
 of
an empty config will do.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

