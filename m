Return-Path: <netdev+bounces-55394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C3080AB98
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED4F1F20FD0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF32E41C8B;
	Fri,  8 Dec 2023 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVMfJlK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B9E9
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:05:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bfe99b6edso2818163e87.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702058753; x=1702663553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOLAJerVjusazLuaQX8KJM/6HEx0PxBCXcm0bH35Cyo=;
        b=jVMfJlK/3Wwv0cDhyVQH956oBkXWj5SizwYG4+7vMdmsS9gkJd7kOzLZgJTFhJEPkD
         3nPh2ZTKXuEN0BqasdraUuLA6GxhxTCz61F0mZ4c2uANTl/H4C2Ro+qzVxCETVJ77MGq
         00JEYUfoI+NzwYa7QGG3GoHDcuJdtTS4fBqwuJNXZXrVOG2DkQ9e8sW5PGq5pqnCp9Ic
         wtfx03GXdxA3YqXga739egu7FjQz0kLZ/5aRKgUVEDNi7o64rQHiF/xxf822YBSeAsLF
         GfOpDRi92XCrwfKitxxk8jtL8QLHdw/Ch743zbx7LU1oXWIKRny6r17x6JtgjAJOlaik
         SbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058753; x=1702663553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOLAJerVjusazLuaQX8KJM/6HEx0PxBCXcm0bH35Cyo=;
        b=cFj2ZagYPo14Hyo1ftGA6Ld+wVAvvpGFBxOtneIp3jGtIfo6k2/FM58Fqn5QsHbf4h
         Fad7bGzGlcqpL/eY2dt2nc71q1vA+9HAzDT9aO4Dw10H38yARlWk7olaJFchZPO4dNDR
         ALa3Pzc7/OMDCFdz9IhgFjhereYtyfLJ7wUv2nmktKznl1cll23uI+ds10TCC/oHtFG9
         IKlCjafDCsBLXHTfpagiu4/9CU5hBwgkZ7nLM1pNtxBxJBixsglVRDDGCbms56dYJmGg
         x3NN+mGlRwsrgQfEdjTyBxjwaYmb5CfjSwQ+X7R65OiBM/dXKBaJcW9hxRBc2jEeYZGU
         BJGg==
X-Gm-Message-State: AOJu0YwVX7HCTnGIVKvxtBQziRkWBe/PDBeVT6Cgk1DQSiigmUNgFSf8
	5Kk6bookT95BnzgKyaKK954IeMecBl3AgxuYbPQ=
X-Google-Smtp-Source: AGHT+IHfT3nvczaOV4xcdnOyBPanMsAimVxB7fqhCPSsZJWK9DCSmiZzdHuSngpdmw/op3LfOWr3+PstTucyy3yEJEc=
X-Received: by 2002:a19:6918:0:b0:50b:f375:6b63 with SMTP id
 e24-20020a196918000000b0050bf3756b63mr127480lfc.97.1702058752815; Fri, 08 Dec
 2023 10:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com> <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
In-Reply-To: <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 8 Dec 2023 15:05:41 -0300
Message-ID: <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO registration
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Fri, Dec 08, 2023 at 02:13:25AM -0300, Luiz Angelo Daros de Luca wrote:
> > > diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> > > index 755546ed8db6..ddcae546afbc 100644
> > > --- a/drivers/net/dsa/realtek/realtek-smi.c
> > > +++ b/drivers/net/dsa/realtek/realtek-smi.c
> > > @@ -389,15 +389,15 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
> > >         priv->user_mii_bus->write = realtek_smi_mdio_write;
> > >         snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
> > >                  ds->index);
> > > -       priv->user_mii_bus->dev.of_node = mdio_np;
>
> You do not really justify removing this in your patch. This is not a
> purely cosmetic change because now the associated mdiodev will not be
> associated with the OF node. I don't know if there is any consequence to
> that but it is usually nice to populate this info in the device struct
> when it is actually available.

Reviewing the code again, I believe it was not just misplacing the
of_put_node() but probably calling it twice.

devm_mdiobus_alloc() doesn't set the dev in mii_bus. So, dev is all
zeros. The dev.of_node normal place to be defined is:

devm_of_mdiobus_register()
  __devm_of_mdiobus_register()
    __of_mdiobus_register()
      device_set_node()

The only way for that value, set by the line I removed, to persist is
when the devm_of_mdiobus_register() fails before device_set_node(). My
guess is that it was set to be used by realtek_smi_remove() if it is
called when registration fails. However, in that case, both
realtek_smi_setup_mdio() and realtek_smi_setup_mdio() would put the
node. So, either the line is useless or it will effectively result in
calling of_node_put() twice.

If I really needed to put that node in the realtek_smi_remove(), I
would use a dedicated field in realtek_priv instead of reusing a
reference for it inside another structure.

I'll add some notes to the commit message about all these but moving
the of_node_put() to the same function that gets the node solved all
the issues.

Regards,

Luiz

