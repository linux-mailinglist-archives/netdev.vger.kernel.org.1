Return-Path: <netdev+bounces-48386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA95E7EE38B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D596B1C20A9A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7D34542;
	Thu, 16 Nov 2023 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MVwYQt0J"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A816D50;
	Thu, 16 Nov 2023 06:59:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83E6DC000D;
	Thu, 16 Nov 2023 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700146789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qy2MqCuiLBtsbwy1ckkwuas5dPsRMMlijJE5oBD56M=;
	b=MVwYQt0JYRhlqSzgnfvLCbmFCTe+TXvL4hhSXGCD8GBXuaIkrn49XazY+RWru4WJJ75Gln
	LB5BWd3yT9l1c8D87ejob7fPsZa5ka2drJbmET/GBrG9y0+UpRdh2lvsjArtr0fKrqq4lt
	Qqt9RNYre3hxjM0zgiN6c+7ph0qjgr9QQCPtCoM0KBQ3VRgaYi6pD8dHiXn0ybPPYhADhP
	8JjzXZaaLD0FlP6koaheUj5gRlr4q9JOMsVO2YpEGchiUeCqyI9TrKjHabrwPGqkkor78O
	2Iv3piuIjnMNQxz+FAc5b9vHRE1e1dS5R925npxawnT2k4F1evQ96H1IHiE8jg==
Date: Thu, 16 Nov 2023 15:59:46 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231116155946.77441144@kmaincent-XPS-13-7390>
In-Reply-To: <faea7171-31bf-43b7-a830-62f69002b823@linaro.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
	<faea7171-31bf-43b7-a830-62f69002b823@linaro.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Thanks Krzysztof for your reviews!

On Thu, 16 Nov 2023 15:29:24 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/11/2023 15:01, Kory Maincent wrote:
> > Add a new driver for the PD692x0 I2C Power Sourcing Equipment controlle=
r.
> > This driver only support i2c communication for now.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  MAINTAINERS                  |    1 +
> >  drivers/net/pse-pd/Kconfig   |   11 +
> >  drivers/net/pse-pd/Makefile  |    1 +
> >  drivers/net/pse-pd/pd692x0.c | 1049
> > ++++++++++++++++++++++++++++++++++++++++++ 4 files changed, 1062
> > insertions(+) =20
>=20
> ....
>=20
> > +
> > +err_fw_unregister:
> > +	firmware_upload_unregister(priv->fwl);
> > +	return ret;
> > +}
> > +
> > +static void pd692x0_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct pd692x0_priv *priv =3D i2c_get_clientdata(client);
> > +
> > +	firmware_upload_unregister(priv->fwl);
> > +}
> > +
> > +static const struct i2c_device_id pd692x0_id[] =3D {
> > +	{ PD692X0_PSE_NAME, 0 },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, pd692x0_id);
> > +
> > +static const struct of_device_id pd692x0_of_match[] =3D {
> > +	{ .compatible =3D "microchip,pd69200", },
> > +	{ .compatible =3D "microchip,pd69210", },
> > +	{ .compatible =3D "microchip,pd69220", }, =20
>=20
> So they are the same from driver point of view.

Yes.
I only have the pd69200 version but the three versions are theoretically
compatible and microchip advise obviously to use the last one.
I describe the three names in case of future specific things even if I hope
there won't be and to have a clear version of which version is supported. D=
o you
prefer to use pd692x0 compatible instead?

Regards,

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

