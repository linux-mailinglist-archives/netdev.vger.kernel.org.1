Return-Path: <netdev+bounces-131254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7998DE42
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC2B2BCE2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBB12DD90;
	Wed,  2 Oct 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b2Dzfu/6"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743421D0BB2;
	Wed,  2 Oct 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881258; cv=none; b=AtVioGFu4InCAivBAZLnbRHJiQnQlNisjrYb6jaM5T3qOx9Wj9mO1AyPodZYGJPFDxkcP6T9hVyJkRYx+z9lHAMvBLz0ZEBqA511OT4633KSl4mBEqR37L9KB+Ra1sJLBtGVoqw03YSqBLrynCAVAdali8M2UMEsdISGfNACHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881258; c=relaxed/simple;
	bh=fGfUD/WiCJjI2zU5UY02wTes88pCeEuSUW2ARwzNIAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBFBggvzPz7wzOC25KVQKNwRKFdracZ19kc4u7NxdbiMDQh8A/j6SiiiW6gRU1/BjiRIvg2fXz0lotyaOTqW9VDUdo76LYYhuLRppm4Pjae/OAajtkT+IBtzo3OdB4Icy2VtjxfQlcH4SbuvoIcX9DUzgcBxLsttNwqiqz/J8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b2Dzfu/6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49E4420008;
	Wed,  2 Oct 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727881249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7PB5ODMJCF6fg5RDa64H/CMmhohH0kapUxtnCgLPSg=;
	b=b2Dzfu/6rZcd85DPtq/QA0YL20r6s5EcwrYAe1EisUoqjsKVnchTKd2XLLH5P+NiHFmLOp
	yaXsgHdB6Kz/uw2b7+WUk71qMpIF1HDES2Ekfj1PjfksfGnTWozTRCcO37nmUwOCrfljA1
	e+u7t3GvfzmkGHLz6VVDi/Zf2bd6iO2oOZuvNhdToZRRpNputDu7Nodpr9l8tR3pMuWtnC
	yg8DJCx0uTExpA2oLLuAcEw2T+8+V1uNASCj5wnEJg9iFFAX3RhKfm7njm/4VLLLOUUZ9j
	qHdJ6GMxUbB1hpmmDBpnYBQikkFtww+j27nnT2uays52b2OuDMMa6iWxx+9lHg==
Date: Wed, 2 Oct 2024 17:00:47 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation
 for bitmask checks
Message-ID: <20241002170047.2b28e740@kmaincent-XPS-13-7390>
In-Reply-To: <20241002073156.447d06c4@kernel.org>
References: <20241002102340.233424-1-kory.maincent@bootlin.com>
	<20241002052431.77df5c0c@kernel.org>
	<20241002052732.1c0b37eb@kernel.org>
	<20241002145302.701e74d8@kmaincent-XPS-13-7390>
	<20241002073156.447d06c4@kernel.org>
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

On Wed, 2 Oct 2024 07:31:56 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 2 Oct 2024 14:53:02 +0200 Kory Maincent wrote:
> > On Wed, 2 Oct 2024 05:27:32 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >  =20
> > > On Wed, 2 Oct 2024 05:24:31 -0700 Jakub Kicinski wrote:   =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Reading the discussion on v1 it seems you're doing this to be safe,
> > > because there was a problem with x &=3D val & MASK; elsewhere.
> > > If that's the case, please resend to net-next and make it clear it's
> > > not a fix.   =20
> >=20
> > Indeed it fixes this issue. =20
>=20
> Is "this" here the &=3D issue or the sentence from the commit message?
>=20
> > Why do you prefer to have it on net-next instead of a net? We agreed wi=
th
> > Oleksij that it's where it should land. Do we have missed something? =20
>=20
> The patch is a noop, AFAICT. Are you saying it changes how the code
> behaves?=20
>=20
> The patch only coverts cases which are=20
>=20
> 	ena =3D val & MASK;
>=20
> the automatic type conversion will turn this into:
>=20
> 	ena =3D bool(val & MASK);
> which is the same as:
> 	ena =3D !!(val & MASK);
>=20
> The problem you were seeing earlier was that:
>=20
> 	ena &=3D val & MASK;
>=20
> will be converted to:
>=20
> 	ena =3D ena & (val & MASK);
>=20
> and that is:
>=20
> 	ena =3D bool(int(ena) & (val & MASK));
>                    ^^^
>=20
> IOW ena gets promoted to int for the & operation.
> This problem does not occur with simple assignment.

Indeed you are totally right! It is a noop! Thanks!
Should I drop it?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

