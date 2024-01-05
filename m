Return-Path: <netdev+bounces-61755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1F824CD8
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 03:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F145E1C21C1E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016151FB4;
	Fri,  5 Jan 2024 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG2Vrn5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51405442C
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso13772791fa.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421172; x=1705025972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RqgnvE53r5bKhWAy2LwI/FlGiDQhzV2yESnCu1PHzE=;
        b=JG2Vrn5K4ERwI/Uk2O+yOmAdTi1Cq93h1y+0oCmreeLRw6gfT91elQUIWESvXjMZ43
         JaW0bb9eo/DpTv6sU/zjT2/Pz/H3h6Ox3Rv3NQnj8lo2z0QUx7hNV1hZsfAhdunAwyno
         8GMyjDRvgNCP2K+r9xNRgzkF5vSa+lRKfnn5ApASC3zT6ve+caGnZ6JG/eglRvCsmWJH
         lSo9d0n7vn+xA+lZTl9Le8cRr6Jx88bm17mdyLs9do7dUC0WtFx1yGqFWZw0/IcoPwym
         31i3B5XiJjiAPTixrDnWeGCMMZ1jEphxySo5bC2tU4Ft4OwKHuwUjONrB7t7gd9CIF/e
         6dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421172; x=1705025972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RqgnvE53r5bKhWAy2LwI/FlGiDQhzV2yESnCu1PHzE=;
        b=bqWsCukRviA9MS4fPIzpgd0pGHBP+8pb4jy2EHDmh0XwCYEXjnYmgeW5vCtaoy7GQW
         UcCzRmcyS7rZcEoPhXdP1oGKBk58wsfdeTGpphs5Vsd6d/lYZmeV8FcGS+dg8NWqJ22O
         Zqj8Wrij5FVHFcGsyKp+WoJcFl78gIsHR/uVhPu4L1A2BJXgVMyJn1eseVPROTH/mEF+
         sIJGyRm0CtUKVEFFZ1N/fBvqn05GydFMWq8xp9tFZWBpIfpk5xzhNwZzQeeQtWCyYMqW
         VW+bBiiwbvMPqbt8q8PCtrl5BIrF+AgecKiqXIwPM0zOkTbKBFvZJcgYVmHv2VIwujVp
         UHKg==
X-Gm-Message-State: AOJu0YwzYvX2iuIhUoN8yCLauulkVcPlihQ/mTXCVKYdswphDLN+9uKz
	Rj2NJpofWKg0qjJGECz4iezIxQY3R8vomJXHTDQ=
X-Google-Smtp-Source: AGHT+IHOCdBj8uZO6NI5d/x9hrA6vwTF0w0eLU7X5CmjODWe7mED2WXmfPuYUASRIIDbkdnZQEVrVBHToUomyQissTQ=
X-Received: by 2002:a2e:990b:0:b0:2cc:bf05:25a1 with SMTP id
 v11-20020a2e990b000000b002ccbf0525a1mr408263lji.24.1704421172028; Thu, 04 Jan
 2024 18:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104140037.374166-1-vladimir.oltean@nxp.com> <20240104140037.374166-6-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-6-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 4 Jan 2024 23:19:20 -0300
Message-ID: <CAJq09z4--Ug+3FAmp=EimQ8HTQYOWOuVon-PUMGB5a1N=RPv4g@mail.gmail.com>
Subject: Re: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation if
 its OF node has status = "disabled"
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em qui., 4 de jan. de 2024 =C3=A0s 11:01, Vladimir Oltean
<vladimir.oltean@nxp.com> escreveu:
>
> Currently the driver calls the non-OF devm_mdiobus_register() rather
> than devm_of_mdiobus_register() for this case, but it seems to rather
> be a confusing coincidence, and not a real use case that needs to be
> supported.
>
> If the device tree says status =3D "disabled" for the MDIO bus, we
> shouldn't need an MDIO bus at all. Instead, just exit as early as
> possible and do not call any MDIO API.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k=
-8xxx.c
> index 5f47a290bd6e..21e36bc3c015 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -949,9 +949,11 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>         struct dsa_switch *ds =3D priv->ds;
>         struct device_node *mdio;
>         struct mii_bus *bus;
> -       int err;
> +       int err =3D 0;
>
>         mdio =3D of_get_child_by_name(priv->dev->of_node, "mdio");
> +       if (mdio && !of_device_is_available(mdio))
> +               goto out;

Hum.. that's why you moved this call here in the previous patch.

Don't you still need to put the node that is not available? Just put
it unconditionally whenever you exit this function after you get it.
of_node_put() can handle even NULL.

I'm not sure if this and other simple switches can be useful without a
valid MDIO. Anyway, wouldn't it be equivalent to having an empty mdio
node? It looks like it would work as well but without a specific code
path.

>         bus =3D devm_mdiobus_alloc(ds->dev);
>         if (!bus) {
> @@ -967,7 +969,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>         ds->user_mii_bus =3D bus;
>
>         /* Check if the devicetree declare the port:phy mapping */
> -       if (of_device_is_available(mdio)) {
> +       if (mdio) {
>                 bus->name =3D "qca8k user mii";
>                 bus->read =3D qca8k_internal_mdio_read;
>                 bus->write =3D qca8k_internal_mdio_write;
> @@ -986,7 +988,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>
>  out_put_node:
>         of_node_put(mdio);
> -
> +out:
>         return err;
>  }
>
> --
> 2.34.1
>

