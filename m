Return-Path: <netdev+bounces-106797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E9917ACC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736122870C0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FB15FA8F;
	Wed, 26 Jun 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BxYZylXp"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49E71750;
	Wed, 26 Jun 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390113; cv=none; b=orSi21ASzArBIjPp14Kc+3Tf0N8ELYEich+d4NDPmCg92IEBcYuc6hNWjbSm8Xqxp1lO/n0RW1zd3zVacIAOTMEB+xcHd8afRyyeqHQRZk++sfHUTBLscixv0Kgxvvx6PWdNjypE07xZHWj9gv3EhcYQLNgOFB2uMdvLSSGqlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390113; c=relaxed/simple;
	bh=iPZDnVrroO2D1Flc6sqGZhiSJ4YlhKmPPUk41D8XZyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfD4HlmVCO0sx76umf20z2Cw39vLM9X2Ikl7BM8wyH/KAzRordPCruGYuXnw7TpOGX3kvdy3BtwL4UIIttTI7Z5TcHokmvA48NxTu5ONg2PvP/X/AdtuNy7JX3uJS67FQzvSMzQRNAuZCFRiu/XHg4IIi6y5AuN3z82f03aFVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BxYZylXp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 438841C000E;
	Wed, 26 Jun 2024 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719390102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8qnKg4uujdTlh3ooNhu0wfOHPZK7SlfbfmzSG+uLRY=;
	b=BxYZylXp9trrwUQ1wFN+TlgqJQ/Ytf9R5TR2jXUZGgQDaWBdd6A5Ue3YhaXYzA5kPpHztp
	zh20ycAPIWnD3Horl4hshgEMCUKC+6uSkZMXSddddXG1//PDVw8xoQp+4aFav/2a0Idda6
	WlFSlbJoaiOscjDvbk9bxXwWHtl1+C8fOVfQKpzgvHkBcM/WKzgN9tkSUTMDruz+TPr0Cs
	DM+erYYbiqSEJDx0vZPXmlSnQGlJ1GnrE1rEyxbUHdgFyBYlkt7I2ICkQffDFn5wxbeRcC
	7sYa9LCgva36Q30xCVNVKgSRpAHvWeT8C5Adn4I3BE4vey+0H1MI6+dDGti24Q==
Date: Wed, 26 Jun 2024 10:21:40 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Dent Project <dentproject@linuxfoundation.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/7] net: pse-pd: Add new power limit get
 and set c33 features
Message-ID: <20240626102140.1aac4593@kmaincent-XPS-13-7390>
In-Reply-To: <BY3PR18MB4707C5C95955ED5CA2D7CA60A0D52@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
	<20240625-feature_poe_power_cap-v4-4-b0813aad57d5@bootlin.com>
	<BY3PR18MB4707C5C95955ED5CA2D7CA60A0D52@BY3PR18MB4707.namprd18.prod.outlook.com>
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

On Tue, 25 Jun 2024 18:49:26 +0000
Sai Krishna Gajula <saikrishnag@marvell.com> wrote:

> > + * Return: 0 on success and failure value on error  */ int
> > +pse_ethtool_set_pw_limit(struct pse_control *psec,
> > +			     struct netlink_ext_ack *extack,
> > +			     const unsigned int pw_limit)
> > +{
> > +	int uV, uA, ret;
> > +	s64 tmp_64;
> > +
> > +	ret =3D regulator_get_voltage(psec->ps);
> > +	if (!ret) {
> > +		NL_SET_ERR_MSG(extack,
> > +			       "Can't read current voltage");
> > +		return ret;
> > +	}
> > +	if (ret < 0) {
> > +		NL_SET_ERR_MSG(extack,
> > +			       "Error reading current voltage");
> > +		return ret;
> > +	} =20
>=20
> Is there any significance of checking "ret" value against '0' and '< 0'
> separately?  Just trying to understand, these checks reflect regulator
> failure etc..?

In fact having ret =3D 0 is not an error for regulator_get_voltage() but wi=
th a 0
value I can't calculate the currrent.
I will update the error message and return value:

NL_SET_ERR_MSG(extack, "Can't calculate the current, PSE voltage read is 0"=
);
return -ERANGE;
=20
>  [...] =20
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

Thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

