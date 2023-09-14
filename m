Return-Path: <netdev+bounces-33955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0F7A0DD3
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 21:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F92818E4
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725026296;
	Thu, 14 Sep 2023 19:05:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262E26281
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 19:05:55 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F79B
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 12:05:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6903caaa021so109942b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694718355; x=1695323155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWMMY0j9IRyavl4GqR5CmOhiDp9Y5r2nK5JQbIWfOeo=;
        b=Iobspjh5hI+BfP9qPLSJ9IESQ7+MKD9ZPz6C0eqfZYEA3/C+zXi1VlQ8kWpu3YSUBQ
         jx4ZxQuEfWfLeis49gAyt02HNPAfpwS5A5muXu90vLY92dQ3sNzUH7y0f1VfmPiek3vH
         beLTTm1vBQXLSZKH9NxxQjV609+zWfp8S1+EIbNBpc9JjP0rNFTdkUF3WSkRNCEdTct6
         cIzIcwJ1OQkTl8WmV/vm1urK8WFYrADI1GgILQAgj8A7jnL3jaOvaVDpDhh+siPOY7DU
         jw4fxMKtlGyd8X+cnUrItBZDVlFO1fz12IrCJcWSYxBRa+GJpqa+ufbWc207cyDbbQBs
         UVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694718355; x=1695323155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWMMY0j9IRyavl4GqR5CmOhiDp9Y5r2nK5JQbIWfOeo=;
        b=X7V4roFFkjh4aWnP7QEA8KPIobB6Sg47PTR6ahhPYSMelUf4mv3GwqDit7g2LJHdPY
         5cu7v71Nz+e1nZvV2l7QsqFq9kXYElZf3ShZWK9dpA2BirYxhYI8sFmoLKZGOlfiki7Y
         ACES16ZDxfIY23qAA805wodWz8dPCcX1AtqCzNfZ+toVFH70rFmEU/AKnzD41U7TVBy0
         7KZU0pZVheuvfy6khJBEiw481nMF6m6YY0sI2Uj7lJtEEuT3E1264YxygQJ71RDutsfV
         gv8EjZJByDMXIzVeZBDftgimJoIqWPue+xhs7We9Z0t+rpTj7Yj1O4fsv2BiJnV54TZU
         2Nmw==
X-Gm-Message-State: AOJu0YxhrR+gVG6yKf9auTRpUhYde1RnQPHeOgAWUkdo2dqr0EEatMyY
	rcj6pHCu1nHFNpxbrM1f+SxUlL9TjGxB/w9lxf4=
X-Google-Smtp-Source: AGHT+IF25s9Y/hHF+57NNwDQT0qadWFhjW5erWnyO+JJNa0SUxAE7GDhhZcoLvdBWSDr8zoflkRr2iaZjAHTVOoNbM0=
X-Received: by 2002:a17:90a:70c7:b0:26d:414d:a98a with SMTP id
 a7-20020a17090a70c700b0026d414da98amr5762566pjm.1.1694718354603; Thu, 14 Sep
 2023 12:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
In-Reply-To: <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Sep 2023 16:05:42 -0300
Message-ID: <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 1:22=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Andrew,
>
> On Thu, Sep 14, 2023 at 12:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
>
> > Does this board actually have an EEPROM attached to the switch?
>
> No, there is no EEPROM attached to the switch on this board.
>
> > In mv88e6xxx_g1_wait_eeprom_done() what value is being returned for
> > the read of MV88E6XXX_G1_STS?
>
> [    1.594043] *************** G1_STS is 0xc800
> [    1.600348] *************** G1_STS is 0xc800
> [    1.606648] *************** G1_STS is 0xc800
> [    1.612950] *************** G1_STS is 0xc800
> [    1.619250] *************** G1_STS is 0xc800
> [    1.625547] mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPR=
OM done
> [    1.673477] *************** G1_STS is 0xc801

I have the impression that the hardware reset logic is not correctly
implemented.

If I change it like this, I don't get the "Timeout waiting for EEPROM
done" error:

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7076,13 +7076,16 @@ static int mv88e6xxx_probe(struct mdio_device *mdio=
dev)

        chip->info =3D compat_info;

-       chip->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW=
);
+       chip->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIG=
H);
        if (IS_ERR(chip->reset)) {
                err =3D PTR_ERR(chip->reset);
                goto out;
        }
-       if (chip->reset)
+       if (chip->reset) {
                usleep_range(10000, 20000);
+               gpiod_set_value(chip->reset, 0);
+               usleep_range(10000, 20000);
+       }

In the devicetree I pass:
reset-gpios =3D <&gpio1 5 GPIO_ACTIVE_LOW>;

Can anyone confirm what is the recommended hardware reset sequence?

Thanks

