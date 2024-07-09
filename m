Return-Path: <netdev+bounces-110314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2C92BD48
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E3828B9F8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B819CCF5;
	Tue,  9 Jul 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KT/26fxX"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A001194A74;
	Tue,  9 Jul 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536191; cv=none; b=hGg2nSKSIW96U0KqYUD1N2O1PRAENywxi3SW0H/QpMjhikJipy+pKEnCP5YA6sMRgft3qUtQu+aUgpfTJXNgFo4kg0ZLk0Sb1r0obh6HkZ8RC5zYXuD4oWSbcjluVS1h0iDYIGFhtfzHIgCDxbNSgAFF2dTiX4VsXU/bsArKJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536191; c=relaxed/simple;
	bh=rJ2+lUEOswuFCrLD0pg6XwtIjRFdILBWXAuQwrljs7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZ699Te8A468GRH3hUCMcbkWopBJQsnbT3dZsf5ktZDRqTmM1NhhE+qsNYm+onfTV6JEsSqDMS1yu85EU5eSfdRT5un+/VJ2FYQZaXqAhPZr1WGG17l3rOTN9Gsp752cwrznBTKnUemx5Aju1sZA+kHJ7Fb1rckcJWKU10XMnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KT/26fxX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85F65E0003;
	Tue,  9 Jul 2024 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720536187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MkRcBwn38nsygCZVcXZUXgAB2EIe1wI/9nnc9kwKc8=;
	b=KT/26fxXreMgrKrtQYXtHlY7+qRyZ1wWaHa3NXWegWTO/5X8Q1zXzCPG+dIkpmQhugU86K
	bZ0SQaMdbBLpAYYG6HECjb6+0ag78ZBp2/5ajqzGk3Phzo26+DS7sBQLPXHxTg3K+gyDdm
	smQmYQHlsc7ElnLFMKV5APXAkYAuX3+XYO/cxa2Y+LKyA1sLv23YgzQKH2sMPHJFt0KBQw
	FP0szFhUI33jYPfbyWiX1ENjo/fFdGFa3lQ9RTvN5CfBcQ0FDgmwk4pjmYVLJub++HLnSl
	p9HL6qc8xHekc4+d5yGOzxPZ8fA2zLdYvjp6Lpfx/XNo45lTmDtC2yPBShrcNw==
Date: Tue, 9 Jul 2024 16:43:05 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ethtool: pse-pd: Fix possible null-deref
Message-ID: <20240709164305.695e5612@kmaincent-XPS-13-7390>
In-Reply-To: <20240709071846.7b113db7@kernel.org>
References: <20240709131201.166421-1-kory.maincent@bootlin.com>
	<20240709071846.7b113db7@kernel.org>
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

On Tue, 9 Jul 2024 07:18:46 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> > -	if (pse_has_podl(phydev->psec))
> > +	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL])
> >  		config.podl_admin_control =3D
> > nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
> > -	if (pse_has_c33(phydev->psec))
> > +	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL])
> >  		config.c33_admin_control =3D
> > nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);=20
> >  	/* Return errno directly - PSE has no notification */ =20
>=20
> At a glance this doesn't follow usual ethtool flow.
> If user doesn't specify a value the previous configuration should be
> kept. We init config to 0. Is 0 a special value for both those params
> which tells drivers "don't change" ?

Mmh in case of a PSE controller supporting PoE or PoDL on its ports, a 0 co=
nfig
value will return a ENOTSUPP error from the PSE core. We might have an issu=
e in
that case which doesn't exist for now as there is no such controller.

As a PSE port can't be PoE and PoDL maybe the PSE type should be related to=
 the
PSE port and not the full PSE driver.

> Normal ethtool flow is to first fill in the data with a ->get() then
> modify what user wants to change.
>=20
> Either we need:
>  - an explanation in the commit message how this keeps old config; or
>  - a ->get() to keep the previous values; or
>  - just reject setting one value but not the other in
>    ethnl_set_pse_validate() (assuming it never worked, anyway).

In fact it is the contrary we can't set both value at the same time because=
 a
PSE port can't be a PoE and a PoDL power interface at the same time.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

