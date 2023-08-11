Return-Path: <netdev+bounces-26744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D82778C07
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2011C20ABB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2606FD9;
	Fri, 11 Aug 2023 10:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262653AA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:26:47 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF111F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:26:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9338e4695so28244761fa.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691749603; x=1692354403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4hsSSkAiq6mYd6igqKSbvcJ8hkXpaI/1rGv+xIiUR8=;
        b=lDFU+4RWdofVfkZgUJP1xmOvtujLBBW5Kx912vR8HULOB02rZpWeSLtuCeHuw3Hqtb
         jpbFumkZtq+a2ak9RS3SccyXPI5huu6qKmCgi1twT3FdR6i9Fp/cS4PdP6ggK0EsbXVl
         7jtGp0ZPITfT5QW+wEvA7UWuBbz6e9ZegU1xL4Y/3As7IUmIwpztVFKvhhjL1+jv2RfN
         Zg39AJX9Crk/VCR0PIOALwE5jSVUyS5aLKfxtRn/S6Jkm++Zog8MRRvdDNeZHQtnyjtK
         2N3OPbQNYn9h4RgkF7VCgHg7t0t7HSq/ZmtO51MmR57s/c3ZyuwZ0jrVKOhijpqxR8v6
         XKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691749603; x=1692354403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4hsSSkAiq6mYd6igqKSbvcJ8hkXpaI/1rGv+xIiUR8=;
        b=lN73Ffl4ayDkyt0yfLAEVcA98de2mJZGILIxF0eekZO3uRS52cpyDNzGyZropXEtdx
         qEWjJqc2zS/Jh7CpTAoTzvGlKnzCViJa3S8NRPTqvS3BlZE06YIj8ESfpK24PB7WLBml
         l0/lZwnBXWRgdB4s/fxEVnP1bAPG/M1O4/en1ofnLZMnDjgdcdHUs8w1/S7tg/Jamvo2
         wJdqpNYB+hZWluRFXFZFdE8Vkd+SHbuoQh9Cb4j0lk/IH4gIACa/uUr58fNIbqSE2IOE
         6wmeROr2CUh8Z3igTDoe/q9Gwdhygmmyw5wBu+FZt9UHDt0YvNoDWJPNRKuMMDJTfd16
         o7+w==
X-Gm-Message-State: AOJu0YyUYA9UgwFuJLWSc3ihzDLRGFgPzdaRQDl9KRuDTVxfm9D7T57/
	xeliF4hPY6KqloowtoNscfu3sMfFu15ykJaBqTNldQ==
X-Google-Smtp-Source: AGHT+IGR6tUv1HPTrBVF3dndqDYAPRKZtFUkGz2JJe4DC4Oq8rqEHyPc+qENcm5f1E/tF1bVPBFzYVXFase/wrigPmM=
X-Received: by 2002:a2e:9347:0:b0:2b9:c4ce:558f with SMTP id
 m7-20020a2e9347000000b002b9c4ce558fmr1232034ljh.37.1691749602346; Fri, 11 Aug
 2023 03:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809214946.18975-1-luke.lu@libre.computer> <2cdc67aa-6029-7231-76a8-54c6b51b066c@gmail.com>
In-Reply-To: <2cdc67aa-6029-7231-76a8-54c6b51b066c@gmail.com>
From: Luke Lu <luke.lu@libre.computer>
Date: Fri, 11 Aug 2023 10:26:30 +0000
Message-ID: <CAAzmgs6MuoLSn=MNmKxio=MVkQq7NDs12Wwu=Sh3SeeU7YiWTA@mail.gmail.com>
Subject: Re: [PATCH net v4] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Da Xue <da@libre.computer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Heiner:

On Fri, Aug 11, 2023 at 6:07=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 09.08.2023 23:49, Luke Lu wrote:
> > From: Da Xue <da@libre.computer>
> >
> > While testing the suspend/resume function, we found the ethernet
> > is broken if using internal PHY of Amlogic meson GXL SoC.
> > After system resume back, the ethernet is down, no carrier found.
> >
> >       eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> >               DOWN group default qlen 1000
> >
> > In this patch, we re-initialize the internal PHY to fix this problem.
> >
>
> It's not an unusual case that system cuts power to the PHY during
> system suspend. So the PHY needs to be re-initialized on resume.
> That's why we call phy_init_hw() in mdio_bus_phy_resume().
>
Calling phy_init_hw() sounds a good idea, and should also fix this issue

But in the case of using stmmac in Amlogic GXL based SoC,
the phy_init_hw() will be skipped due to mac_managed_pm is true

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
static int stmmac_phy_setup(struct stmmac_priv *priv)
{
        ...
        priv->phylink_config.mac_managed_pm =3D true;
}

drivers/net/phy/phy_device.c
static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
{
        struct phy_device *phydev =3D to_phy_device(dev);
        int ret;

        if (phydev->mac_managed_pm)
                return 0;
        ...
}

> If going your way we would be better off calling .config_init()
> in genphy_resume().
I'm not sure if it's safe to go this way, which will change the generic cod=
e,
or question - does all phy devices need to call .config_init() in resume() =
path?

> Please check the MAC driver, maybe it's better
> to re-initialize the PHY in the resume path of the MAC driver.
>
Do you mean do the re-initialization in stmmac_main.c: stmmac_resume()?
It sounds like a feasible way to solve this, but as I'm not really
familiar with stmmac driver,
so, do you have some more detailed suggestions on how we should adapt
the code to fix this?

> >       eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state U=
P
> >               group default qlen 1000
> >
> > Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")
> > Signed-off-by: Da Xue <da@libre.computer>
> > Signed-off-by: Luke Lu <luke.lu@libre.computer>
> >
> > ---
> > Note, we don't Cc stable kernel tree in this patch intentionally, since
> > there will be a cherry-pick failure if apply this patch from kernel ver=
sion
> > less than v6.2, it's not a logic failure but due to the changes too clo=
se.
> >
> > Please check commit 69ff53e4a4c9 ("net: phy: meson-gxl: use MMD access =
dummy stubs for GXL, internal PHY")
> > We plan to slightly rework the patch, and send it to stable tree separa=
tely
> > once this patch is accepted into mainline.
> >
> > v4:
> >  - refactor commit message to better explain the problem & fix
> >  - check return value of genphy_resume()
> >  - add 'net' annotation
> >  - add Fixes tag
> >
> > v3: https://lore.kernel.org/netdev/20230808050016.1911447-1-da@libre.co=
mputer
> >  - fix missing parameter of genphy_resume()
> >
> > v2: https://lore.kernel.org/netdev/20230804201903.1303713-1-da@libre.co=
mputer
> >  - call generic genphy_resume()
> >
> > v1: https://lore.kernel.org/all/CACqvRUZRyXTVQyy9bUviQZ+_moLQBjPc6nin_N=
QC+CJ37yNnLw@mail.gmail.com
> > ---
> >  drivers/net/phy/meson-gxl.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> > index bb9b33b6bce2..9ebe09b0cd8c 100644
> > --- a/drivers/net/phy/meson-gxl.c
> > +++ b/drivers/net/phy/meson-gxl.c
> > @@ -132,6 +132,21 @@ static int meson_gxl_config_init(struct phy_device=
 *phydev)
> >       return 0;
> >  }
> >
> > +static int meson_gxl_phy_resume(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     ret =3D genphy_resume(phydev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D meson_gxl_config_init(phydev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> >  /* This function is provided to cope with the possible failures of thi=
s phy
> >   * during aneg process. When aneg fails, the PHY reports that aneg is =
done
> >   * but the value found in MII_LPA is wrong:
> > @@ -196,7 +211,7 @@ static struct phy_driver meson_gxl_phy[] =3D {
> >               .config_intr    =3D smsc_phy_config_intr,
> >               .handle_interrupt =3D smsc_phy_handle_interrupt,
> >               .suspend        =3D genphy_suspend,
> > -             .resume         =3D genphy_resume,
> > +             .resume         =3D meson_gxl_phy_resume,
> >               .read_mmd       =3D genphy_read_mmd_unsupported,
> >               .write_mmd      =3D genphy_write_mmd_unsupported,
> >       }, {
>

