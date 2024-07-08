Return-Path: <netdev+bounces-109799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB0929F40
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929EB1F23F0F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7256452;
	Mon,  8 Jul 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cu1rHfE1"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F73307B;
	Mon,  8 Jul 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431533; cv=none; b=Lb5SZC8DAREQhxDqgiB0ddufinTRw985JwdsqITzIvq/t5PnXtJSNTL5b65uW8XRW+edliyo9AcjOq892bPXmM5quHUMhsEcTSYX4gZewlpj2z4mhnS2IV2c8bGHsuQH/OopTaX9YAvGeYBAmbFuGzJT3ulq8J+Ts12t1vIKoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431533; c=relaxed/simple;
	bh=TWEraFY57JPqsQkwWlsujpwcx804dr83NSVrRLQlsew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEjTqlbDquE8+B6IMYCBbXx6sVn9cbnhr7rOowSiiKBLNJDsy3NvLiojGJ+6SL/qhyd3sQvPFuMjbDMu3n5PuytwLSO29VByNikbBpKoPw7Z7h6YgNtjbQkL7h2x6YYP0mLfQCNAdkAhvZymiB+Jx5xz2BUtgedM0IG/kGF2D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cu1rHfE1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1944E000A;
	Mon,  8 Jul 2024 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720431529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBfIxKe4rTb0db0/aTl46JjinrlFkxyBKK4Tc4qLO2A=;
	b=cu1rHfE1R2OdeprgUda1/8bnOa0TFTLhTjvY8UpiBAinvA78btCT0cr3wAUtbiRhmSVTeR
	wpuTMrSZdslw+wYqJTXRRfYoTMHvg7TNEDt7zlthqirAk3YwRl0AAtPgAwnF8G1yup2PoV
	Rt8MtCtcddIE0pvKaCYI+5a81mEarhq4FwBZGISvamMm6N2qGE8CGCSGqpvrybSGFGVcjR
	AF1mpbE/WehihhdooHRD2zo49diYjD0koNrWT/6bP7NnoOL+rpkyKNKRU6BJiY0cypFmvC
	zkRBoEQeUkjcosodmQHNAt8MWRLgff9pS1VEFsEVK1oHzZ1qtyMVXCM8jLIC2A==
Date: Mon, 8 Jul 2024 11:38:46 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <20240708113846.215a2fde@kmaincent-XPS-13-7390>
In-Reply-To: <20240705184116.13d8235a@kernel.org>
References: <20240704-feature_poe_power_cap-v6-0-320003204264@bootlin.com>
	<20240704-feature_poe_power_cap-v6-5-320003204264@bootlin.com>
	<20240705184116.13d8235a@kernel.org>
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

On Fri, 5 Jul 2024 18:41:16 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 04 Jul 2024 10:12:00 +0200 Kory Maincent wrote:
> > +	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] ||
> > +	    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]) {
> > +		struct pse_control_config config =3D {};
> > +
> > +		if (pse_has_podl(phydev->psec))
> > +			config.podl_admin_control =3D
> > nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
> > +		if (pse_has_c33(phydev->psec))
> > +			config.c33_admin_control =3D
> > nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]); =20
>=20
> This smells of null-deref if user only passes one of the attributes.
> But the fix should probably be in ethnl_set_pse_validate() so it won't
> conflict (I'm speculating that it will need to go to net).

Mmh, indeed if the netlink PSE type attribute is different with the support=
ed
PSE type we might have an issue here.

I am wondering, if I fix it in net won't it conflict with net-next now that
this series is merged?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

