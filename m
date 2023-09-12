Return-Path: <netdev+bounces-33285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA579D4CB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860D1281DE1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A321418C10;
	Tue, 12 Sep 2023 15:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB4179A0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:27:58 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAFA10D9;
	Tue, 12 Sep 2023 08:27:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44ee7688829so1788671137.2;
        Tue, 12 Sep 2023 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694532476; x=1695137276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CLI398SomQRHnRFi4Yn15PWIFt7cG4DGoVX4ALzoiY=;
        b=iEELa+gTjW0CxMMqduuIM14ugvQYyFCiWUlVGaYQC1gTL7uGx8VqLTB4IlRMXH4lDL
         9MIaZeIR8e8mBZSJXy8EOXcG+28Btfn9u5jZjh4pCRLPUflw80cNlYoRMjTH+I1JGyp5
         6oB/0pvQpIIPGnEWPRRIiM8RMta0WPhQNEnlLxWK1CLcDi/UvUiWOe1ATitNkHPISUrk
         9lUw2YfmDpmxmDLId0mGqyfIcXoSImyDgZ1CLVxJawnDAagWwd8ayFu2vMd9HZjuHPHg
         DidwtBp5UCyZi9IVrflOFJNVrK4aXdi8BxFqg8HtMHPrBo5XsKN+bTel/kFS4C6xM3x4
         UZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694532476; x=1695137276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CLI398SomQRHnRFi4Yn15PWIFt7cG4DGoVX4ALzoiY=;
        b=wLxnyfrShijGOdLygRMhxCz+ODZ72pRi3mpWCbKG5Q4nmT9WirMVzb8P5QrJ+kGKb3
         L2sQ3e0XIznA3yy0vr5bM/IFYWRQj723kGwxgh+GLqzWBfIqC2AHY62c5rKAPdyB7EmA
         Zv7TzFuZ0TZLdAsZBvMb9T3OShGpfDT4h1ppGvN/HDIZov+gEGyQAdpgK0egowLVY3du
         V+2w8cdzqewONotz7MLQf4J/qiM2JpQUOEWcFZ512I7cABEnjYvSzkFixzbUMaVdIQXZ
         OACYQPRFCoH1Ayjn1k9YstI9A0m1lMXDUyeFwtiU+s5LkTVweCbSRTj1gIhDEvLrOPdC
         lEfQ==
X-Gm-Message-State: AOJu0Yxrhrzj+p58LUkjNHqHBrtTdHUAEYkapJwrGv8bw17GBMhQtZrt
	oWxvt70+VJh+yAPceNshAHkklE+7l7hCB0JAR5Y=
X-Google-Smtp-Source: AGHT+IGNYfBTL0I4cm2uj9UK7cr02IvbbSDPc3Eaaon84WVvyCYvZkPmOV7QyFgdfxzoDC0XWMSMNQr4acJduBTdxQk=
X-Received: by 2002:a67:fc05:0:b0:44e:82e2:b0f0 with SMTP id
 o5-20020a67fc05000000b0044e82e2b0f0mr9124209vsq.25.1694532476574; Tue, 12 Sep
 2023 08:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-5-paweldembicki@gmail.com> <20230912144802.czdpb6hpn2yiewvf@skbuf>
In-Reply-To: <20230912144802.czdpb6hpn2yiewvf@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Tue, 12 Sep 2023 17:27:45 +0200
Message-ID: <CAJN1Kkyn4V2FNVdZZMWHTSqP+=5bKacKSEpkF5t4sNptc1vtCg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] net: dsa: vsc73xx: add port_stp_state_set function
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Simon Horman <simon.horman@corigine.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 12 wrz 2023 o 16:48 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(a=
):
>
> Hi Pawel,
>
Hi Vladimir,

Thank you for Your time.

> On Tue, Sep 12, 2023 at 02:21:58PM +0200, Pawel Dembicki wrote:
> > This isn't a fully functional implementation of 802.1D, but
> > port_stp_state_set is required for a future tag8021q operations.
> >
> > This implementation handles properly all states, but vsc73xx doesn't
> > forward STP packets.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index 8f2285a03e82..541fbc195df1 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -1033,9 +1031,59 @@ static int vsc73xx_get_max_mtu(struct dsa_switch=
 *ds, int port)
> >       return 9600 - ETH_HLEN - ETH_FCS_LEN;
> >  }
> >
> > +static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> > +{
>
> For bisectability, the series must build patch by patch.
> Here, you are missing:
>
>         struct vsc73xx *vsc =3D ds->priv;
>
> ../drivers/net/dsa/vitesse-vsc73xx-core.c:1038:3: error: use of undeclare=
d identifier 'vsc'
>                 vsc->forward_map[CPU_PORT] =3D VSC73XX_SRCMASKS_PORTS_MAS=
K &
>                 ^
> ../drivers/net/dsa/vitesse-vsc73xx-core.c:1041:3: error: use of undeclare=
d identifier 'vsc'
>                 vsc->forward_map[port] =3D VSC73XX_SRCMASKS_PORTS_MASK &
>                 ^
> 2 errors generated.
>
> > +     /* Configure forward map to CPU <-> port only */
> > +     if (port =3D=3D CPU_PORT)
> > +             vsc->forward_map[CPU_PORT] =3D VSC73XX_SRCMASKS_PORTS_MAS=
K &
> > +                                          ~BIT(CPU_PORT);
>
>                 vsc->forward_map[CPU_PORT] =3D dsa_user_ports(ds);
>
> > +     else
> > +             vsc->forward_map[port] =3D VSC73XX_SRCMASKS_PORTS_MASK &
> > +                                      BIT(CPU_PORT);
>
>                 vsc->forward_map[port] =3D BIT(CPU_PORT);
>
> > +
> > +     return 0;
> > +}
> > +
> > +/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
> > + * forwarded only from and to PI/SI interface. For more info see chapt=
er
> > + * 2.7.1 (CPU Forwarding) in datasheet.
> > + * This function is required for tag8021q operations.
> > + */
> > +
> > +static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port=
,
> > +                                    u8 state)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +
> > +     if (state =3D=3D BR_STATE_BLOCKING || state =3D=3D BR_STATE_DISAB=
LED)
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_RECVMASK, BIT(port), 0);
> > +     else
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_RECVMASK, BIT(port), BIT(port=
));
> > +
> > +     if (state =3D=3D BR_STATE_LEARNING || state =3D=3D BR_STATE_FORWA=
RDING)
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_LEARNMASK, BIT(port), BIT(por=
t));
> > +     else
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_LEARNMASK, BIT(port), 0);
> > +
> > +     if (state =3D=3D BR_STATE_FORWARDING)
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_SRCMASKS + port,
> > +                                 VSC73XX_SRCMASKS_PORTS_MASK,
> > +                                 vsc->forward_map[port]);
>
> To forward a packet between port A and port B, both of them must be in
> BR_STATE_FORWARDING, not just A.
>

In this patch bridges are unimplemented. Please look at 8/8 patch [0].

> > +     else
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_SRCMASKS + port,
> > +                                 VSC73XX_SRCMASKS_PORTS_MASK, 0);
> > +}
> > +
> >  static const struct dsa_switch_ops vsc73xx_ds_ops =3D {
> >       .get_tag_protocol =3D vsc73xx_get_tag_protocol,
> >       .setup =3D vsc73xx_setup,
> > +     .port_setup =3D vsc73xx_port_setup,
> >       .phy_read =3D vsc73xx_phy_read,
> >       .phy_write =3D vsc73xx_phy_write,
> >       .phylink_get_caps =3D vsc73xx_phylink_get_caps,
> > @@ -1049,6 +1097,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops=
 =3D {
> >       .port_disable =3D vsc73xx_port_disable,
> >       .port_change_mtu =3D vsc73xx_change_mtu,
> >       .port_max_mtu =3D vsc73xx_get_max_mtu,
> > +     .port_stp_state_set =3D vsc73xx_port_stp_state_set,
> >  };
> >
> >  static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offse=
t)
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitess=
e-vsc73xx.h
> > index f79d81ef24fb..224e284a5573 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx.h
> > +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> > @@ -18,6 +18,7 @@
> >
> >  /**
> >   * struct vsc73xx - VSC73xx state container
> > + * @forward_map: Forward table cache
>
> If you start describing the member fields, shouldn't all be described?
> I think there will be kdoc warnings otherwise.
>

Jakub in v1 series points kdoc warn in this case. I added a
description to the field added by me. Should I prepare in the v4
series a separate commit for other descriptions in this struct?

> >   */
> >  struct vsc73xx {
> >       struct device                   *dev;
> > @@ -28,6 +29,7 @@ struct vsc73xx {
> >       u8                              addr[ETH_ALEN];
> >       const struct vsc73xx_ops        *ops;
> >       void                            *priv;
> > +     u8                              forward_map[VSC73XX_MAX_NUM_PORTS=
];
> >  };
> >
> >  struct vsc73xx_ops {
> > --
> > 2.34.1
> >

[0] https://lore.kernel.org/netdev/20230912122201.3752918-9-paweldembicki@g=
mail.com/T/#u

