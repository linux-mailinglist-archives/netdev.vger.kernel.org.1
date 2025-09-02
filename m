Return-Path: <netdev+bounces-219211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E2B4074B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E1157B4B4F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74D311C0C;
	Tue,  2 Sep 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eNl6RB35"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D632DEA82;
	Tue,  2 Sep 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824230; cv=none; b=NZD5pkdl9frz+J64bXxYR4MbhkcaVqqjAAj5xH3c0gKcVAXRRixop5AxqcpghwUIFHgqKtRJAlYT76uYoAI/mWykH9+zV9QpsCsCzWbfxzrIpbrwmXOxkX7SM51LLu5gHua9Wa+S86hVUPkEfaItyyPOBal0D8ZSOKbRw3+dI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824230; c=relaxed/simple;
	bh=2858mwcWdPtWthPbvme5RLc5jg06d0odNZZ8MVZPpbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPrUHL0DdgKlxtwHX3g3j1oBsYG4KWmsd8sng3yOZprYXGYsW+86ub2hStiyYBBvOq075N9D6uVmWJhOA3nVJbPKK6FjjJ69IZx0amKJm/CzUD7WUG0qKTsPd1ZFo3VPDOSjFitEU5S6kCr/YpoAd7qKUoARHF1f1TDj84Fvvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eNl6RB35; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D31BAC8F1D8;
	Tue,  2 Sep 2025 14:43:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7D3C60695;
	Tue,  2 Sep 2025 14:43:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB1C71C22D526;
	Tue,  2 Sep 2025 16:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756824225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vKSZcOB4uWRpV/PVY+TeKnenVxAEeSXVZ4M6D9Aiah0=;
	b=eNl6RB35v2CxA9uly86MnZ526K2bNz33kXu21cptn9T9+2Sbgz1MHXfspQeXLde4y485VV
	p2/3rcMDEAVqqXGq6BRRNdhHwtl38BizLTMoxCCOOm4pys9RrWsxUckU6YxrO44SaAw2xg
	bm1nHMDs9QBt3r2FJm3XRMdKZaTBuN34jQQtdPLZGBdp+bVbZL5LdhsIDUyqcpl1gQv1ET
	Kr2C6Yehjm4r2qjdcwJ5fqSF4/IwqJqu3J1Zg/iiJyJLPRO0LR9E0l983xyWcWOXZvGs33
	ojXrBfEzaDCOq/BABEFdvKtXVXUB9lxfhxAZqPX2VkRuTD28BLOw0LAyEUeP8w==
Date: Tue, 2 Sep 2025 16:43:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Message-ID: <20250902164314.12ce43b4@kmaincent-XPS-13-7390>
In-Reply-To: <20250901133100.3108c817@kernel.org>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
	<20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
	<20250901133100.3108c817@kernel.org>
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

On Mon, 1 Sep 2025 13:31:00 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 29 Aug 2025 18:28:46 +0200 Kory Maincent wrote:
> > +The ``PD692x0`` drivers implement the following driver-specific parame=
ters.
> > +
> > +.. list-table:: Driver-specific parameters implemented
> > +   :widths: 5 5 5 85
> > +
> > +   * - Name
> > +     - Type
> > +     - Mode
> > +     - Description
> > +   * - ``save_conf``
> > +     - bool
> > +     - runtime
> > +     - Save the current configuration to non-volatile memory using ``1=
``
> > +       attribute value.
> > +   * - ``reset_conf``
> > +     - bool
> > +     - runtime
> > +     - Reset the current and saved configuration using ``1`` attribute
> > +       value. =20
>=20
> Sorry for not offering a clear alternative, but I'm not aware of any
> precedent for treating devlink params as action triggers. devlink params
> should be values that can be set and read, which is clearly not
> the case here:

Ok.
We could save the configuration for every config change and add a reset-conf
action to devlink reload uAPI? The drawback it that it will bring a bit of
latency (about 110ms) for every config change.

Or adding a new devlink uAPI like a devlink conf but maybe we don't have en=
ough
cases to add such generic new uAPI.
Or get back to the first proposition to use sysfs.=20

What do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

