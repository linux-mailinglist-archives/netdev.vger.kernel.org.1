Return-Path: <netdev+bounces-129457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096A984017
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E612840AB
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A61494D4;
	Tue, 24 Sep 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DQf4msGG"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E53143759;
	Tue, 24 Sep 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165736; cv=none; b=FTvtH5q6kL42C7ilb0IuGMY4K0vtkrZFtN1y129icf+S+xt5R2vAfbVERJnNxpOIeMeUWoUZmnvZIm1V/mUsgTdHIIOSjUhS6u7TjWUR7pi6p4nMifHbehJn4F1XwsjcK5WndsyF5KXw361A0W2Bq0j4fcmskBjvMnlY//rbgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165736; c=relaxed/simple;
	bh=cEHa90cDZNUSlLeKkPmlcNUdPSszKvv7iGDQsFEjVUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulpPUB31GsEbMRAZ4PVh62D8nrtp6ahZo02SE04CY8/cyzhYPCntp0W+qG7iZVT9/UTlBvjbolrAopYS7QwW9JmxtMo/lkoae2JLChNmLateZe3W8qHADPk2o3b7ryTZIK+Z3c2U/vxMjrqmJ8UUavuvhl5T2omKfPrVFi/8N6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DQf4msGG; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DE1240007;
	Tue, 24 Sep 2024 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727165732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0L+Om6PLDpKynIImN0hHGd04qXus2NawEL//O2kxuv0=;
	b=DQf4msGGEusRQ8On6dHpueMru7O+igVbcS8ujR236Woq0PXEwp8cu4JudaOoou7IKA8ebi
	5LqgR8ThknC1W0l0DUPobsREeheCkDwbDWG+a1B2bm/42iBn91o5kqfPl1/cdGYppuLwff
	9bbyZWmjGtlGDNiv6tXcDXrnfYXA00E+i3DD1NZqnJ1xyAqR5obhg+sGm8LEH7DdYymPEh
	aQB781zDdsw717Tg8yWylVZZX44A+pvuCGRwcOxoNgH4L7Ccb8XdYIyc05X0OjiOx1zg2X
	0VbOQyt8AtpJJhUUBXhEVKSX6uHmvwpceA9lz4wEvLhKlnGCE4Ysd3pKm67kwA==
Date: Tue, 24 Sep 2024 10:15:29 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 thomas.petazzoni@bootlin.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for
 bitmask checks
Message-ID: <20240924101529.0093994d@kmaincent-XPS-13-7390>
In-Reply-To: <20240924071839.GD4029621@kernel.org>
References: <20240923153427.2135263-1-kory.maincent@bootlin.com>
	<20240924071839.GD4029621@kernel.org>
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

On Tue, 24 Sep 2024 08:18:39 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Sep 23, 2024 at 05:34:26PM +0200, Kory Maincent wrote:
>  [...] =20
>=20
> Thanks Kory,
>=20
> I agree that these changes are correct.
> But are they fixes; can this manifest in a bug?

I didn't face it but I think yes.
In case of a 4 pairs PoE ports without the fix:

        chan =3D priv->port[id].chan[0];                                   =
      =20
        if (chan < 4) {                                                    =
    =20
                enabled =3D ret & BIT(chan);                               =
  =20
                delivering =3D ret & BIT(chan + 4);                        =
  =20
	...                         =20
        }                                                                  =
    =20
                                                                           =
    =20
        if (priv->port[id].is_4p) {                                        =
    =20
                chan =3D priv->port[id].chan[1];                           =
      =20
                if (chan < 4) {
                        enabled &=3D !!(ret & BIT(chan));                  =
      =20
                        delivering &=3D !!(ret & BIT(chan + 4));

If enabled =3D 0x2 here, enabled would be assigned to 0 instead of 1.
...

		}=20
	} =20

I have an issue using 4pairs PoE port with my board so I can't test it.


> (If so, I suspect the Kernel is riddled with such bugs.)

Don't know about it but if I can remove it from my driver it would be nice.=
 :)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

