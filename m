Return-Path: <netdev+bounces-156570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3EA070A6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC65188A479
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CCB2153C1;
	Thu,  9 Jan 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kIO3mYMU"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B721516C;
	Thu,  9 Jan 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413324; cv=none; b=dZPSs+DP46DVP61ZUti1CnyBqnvF6qngUHGxo7v5S6Lu1RDfDnSzCnl4MevnwT5oTPBR+s9QTTw32ct71HtvDpC95bSxnieWWDeh98BYHd+ylmyA2blIrNx9TsyRutXtWpBPMNTholXcDf7KB7MFLs+dVRnaGr3kcuNhrqjWlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413324; c=relaxed/simple;
	bh=U5XE7/ocxCZ27HjwI6igKzAjgsRr25w+KrS/Kviml0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXl8FlewoUTvEh+P0hVqvI2X+mqhwCEzLE8YytrfcX/z5uSnLjGlM9FGJB9QEM7yYK+XXEH8i5Xo0J3f491caUHq9wQ13iYyW3X40jpLDjU8Y+NP1NEqBpEFrfsb8stTdYBeJsrcR4klVy5rlMCZSJbjeqC7eWY6T+bE8+XRXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kIO3mYMU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C05DFF805;
	Thu,  9 Jan 2025 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736413319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+r+HpE2jxq21wWQC7BJxBYD65pu9/Yxzg8ho44GIPg=;
	b=kIO3mYMUaydX5mxReeLHUd6hOwipxGWWiXHp4HQlRRYfGEUf6MJSFpkQJ4DfQDEMBvrJpX
	yEm01m1+QOhq8GJhKKVq8Q0ImOFXii9XSyprJkaPXAlbUwQnRYO1yY1cavD9ECYrA2rLvR
	BCsDBtMIoW3wtfrkEToSgepmTY3GY3syVM7PM0dtrdFBPX54tGHT5NSqeP3ZZosRVkZOFA
	xiPp3we0r4tX1vg5tRm1+5QoV+pDVrTjXDiMUMZLdP+a200zuyG/HJqk93fRR8zGvD7Czn
	7dp8munXydRwjfP6BMG0WV712vqtl7MQGWBNy47GOvE/pIfERGtMoBdtWOvNbQ==
Date: Thu, 9 Jan 2025 10:01:54 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 08/14] net: pse-pd: Split ethtool_get_status
 into multiple callbacks
Message-ID: <20250109100154.740f9e6d@kmaincent-XPS-13-7390>
In-Reply-To: <20250108093645.72947028@kernel.org>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
	<20250104-b4-feature_poe_arrange-v1-8-92f804bd74ed@bootlin.com>
	<20250107171554.742dcf59@kernel.org>
	<20250108102736.18c8a58f@kmaincent-XPS-13-7390>
	<20250108093645.72947028@kernel.org>
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

On Wed, 8 Jan 2025 09:36:45 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 8 Jan 2025 10:27:36 +0100 Kory Maincent wrote:
> > > Is there a reason this is defined in ethtool.h?   =20
> >=20
> > I moved in to ethtool because the PSE drivers does not need it anymore.
> > I can keep it in pse.h.
> >  =20
> > > I have a weak preference towards keeping it in pse-pd/pse.h
> > > since touching ethtool.h rebuilds bulk of networking code.
> > > From that perspective it's also suboptimal that pse-pd/pse.h
> > > pulls in ethtool.h.   =20
> >=20
> > Do you prefer the other way around, ethtool.h pulls in pse.h? =20
>=20
> No, no, I'd say the order of deceasing preference is:
>  - headers are independent
>  - smaller header includes bigger one
>  - bigger one includes smaller one

Ok good to know.
=20
> > Several structure are used in ethtool, PSE core and even drivers at the=
 same
> > time so I don't have much choice. Or, is it preferable to add a new hea=
der?
> > =20
>=20
> From a quick look it seemed like pse.h definitely needs the enums from
> the uAPI. But I couldn't find anything from the kernel side ethtool.h
> header it'd actually require (struct ethtool_c33_pse_ext_state_info
> can be moved to pse.h as well?).
>=20
> Anyways, it's not a major issue for existing code, more of forward guidan=
ce.

I am fully open to guidance to have proper code.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

