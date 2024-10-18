Return-Path: <netdev+bounces-136892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023809A3866
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323B01C22304
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5E186616;
	Fri, 18 Oct 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VbjfpT9G"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758915445B
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239723; cv=none; b=fjhRzW4bk/oRv9nA5vj1cqlBDZuWGHf7ewKsj9KBm3yd150RItzEyVILXqjqMPLpB99YYOtmqjZGTEOqnA3thEV+CCchD9tuktBHo7kpwNPBbFomxHeBDs8XjKEnfFZFC15QPjNChXz/KPzQMVSm74lb9Wmf1potZgH7xPKP0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239723; c=relaxed/simple;
	bh=M5xoOHQUGmy2YYGloyff6PFP7iyy6t8nTux1TWDs9T8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l20QkcIH+3IXqIHpfEPr4wpDqR23ucX35N/OXXAoo3eZKsvyueh7VQmRL6r0G2BW4mscabrBOoF8ci04meModrUr0gSFr36cRJyib2/5+f3aHvcoOC8Kyx8SdSlAT+2w/JmRPufLBmNwLs1mHU+mP7asvChnYykHSyODGUaRNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VbjfpT9G; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7410C20011;
	Fri, 18 Oct 2024 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729239712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VegGKytbtZ1k1mTUTAoj3F/CsX2QYJffH92yvb69Qw=;
	b=VbjfpT9GS5imQZ11Uvb4khjVjz3OfFXck0op2Y7bYV+rwrKhx1RiDwjhozJmVeLC2zLQzI
	5Dm8XX6zXS0nXpBid+sBhYHS1umNwemnXhkVuk4DMjaOyjTk6LjSF7lSjwY08rTIWVfebS
	l0ElmGiGmdNqXU8YEL9Ww/IWL+U4jQ46X81O2yEmf8jNKFp+ciTNXViRIXt31Ep1fDoaUg
	9kQB9mq2/JndEWXlr+GEtI4CNyfI2TJwQG/9PDiCiRthxzP77o8TiiMGV9hYKdgs6aLJlo
	DlUd/cJoYg3bvHAwZ9LEOfU6qD5EVgmSLpCdZg4SNcJG0QX5m22fh0s2AJYfUQ==
Date: Fri, 18 Oct 2024 10:21:51 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: ynl ethtool subscribe issue
Message-ID: <20241018102151.2d74cd49@kmaincent-XPS-13-7390>
In-Reply-To: <CAD4GDZzQc1M+b_um-VH1zfq5RSMNwoWNp+8yT=D-e4_pHSpBjQ@mail.gmail.com>
References: <20241017180551.1259bf5c@kmaincent-XPS-13-7390>
	<CAD4GDZzQc1M+b_um-VH1zfq5RSMNwoWNp+8yT=D-e4_pHSpBjQ@mail.gmail.com>
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

On Thu, 17 Oct 2024 23:05:14 +0100
Donald Hunter <donald.hunter@gmail.com> wrote:

> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^
> > File "/root/ynl/lib/ynl.py", line 726, in _decode raise Exception(f"Spa=
ce
> > '{space}' has no attribute with value '{attr.type}'") Exception: Space
> > 'bitset' has no attribute with value '4' =20
>=20
> The 'bitset' attribute-set is missing these attributes which are
> defined in include/uapi/linux/ethtool_netlink.h
>=20
> ETHTOOL_A_BITSET_VALUE, /* binary */
> ETHTOOL_A_BITSET_MASK, /* binary */
>=20
> This patch fixes it:
>=20
> diff --git a/Documentation/netlink/specs/ethtool.yaml
> b/Documentation/netlink/specs/ethtool.yaml
> index 6a050d755b9c..f6c5d8214c7e 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -96,7 +96,12 @@ attribute-sets:
>          name: bits
>          type: nest
>          nested-attributes: bitset-bits
> -
> +      -
> +        name: value
> +        type: binary
> +      -
> +        name: mask
> +        type: binary
>    -
>      name: string
>      attributes:
>=20
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml
> --subscribe monitor --sleep 10
> [{'msg': {'active': {'nomask': True,
>                      'size': 64,
>                      'value': b'\xb2A\x00\x00\x00\x01\x00\x00'},
>           'header': {'dev-index': 2, 'dev-name': 'enp42s0'},
>           'hw': {'mask': b'\xff\xff\xff\xff\xff\xff\xff\xff',
>                  'size': 64,
>                  'value': b'\x93I\x19\x00\x00\x1b\x00\n'},
>           'nochange': {'nomask': True,
>                        'size': 64,
>                        'value': b'\x004\x00\x00\x00\x00\x00\x00'},
>           'wanted': {'nomask': True,
>                      'size': 64,
>                      'value': b'\x92I\x00\x00\x00\x01\x00\x00'}},
>   'name': 'features-ntf'}]

Ooh nice, thanks!!

>=20
> > I used set_features netlink command but all of ethtool commands are not
> > working. I am not a ynl expert so someone may find the issue before I d=
o.
> > That would be kind! =20
>=20
> I haven't tried anything else from the ethtool spec, but plan to check
> it out tomorrow.
>=20
> I can submit a patch for this tomorrow, unless you want to?

No, go ahead.

Regards
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

