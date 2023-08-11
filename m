Return-Path: <netdev+bounces-26681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A805D778920
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74FE282028
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F953A2;
	Fri, 11 Aug 2023 08:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB42113
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:45:42 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47752D5B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:45:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so2787868e87.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691743538; x=1692348338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyLoP8xMKHbbGPDbJqH4l+BBAOIbu8DKdw/y5ZAFfd8=;
        b=POcjDBX8yjO/cNrmrhyKFwIYY5gNDZn8xJwHWAHnI4kGTqKPYD+mhBRshEtpBrSytD
         URgEHJoaIdNgmualJl7OPzIR7XfCX2/8M3MqaBj3+6Rv3xhb1foVimT8BFZ5JVlg15ON
         ovORAYsxUJV+6wzdHcByY9Cm604j1a1wILyHu/LA99u7SOxSspxxqAffCX5DjXK/p0xz
         XNh81xBZ8ajcckdFcOSwvPHHcAeL/AqK1wziO6IJN/WMeTGY2UOjAGaiCJ6awQ4W5ax3
         W34V1t7f1nSNvPhif3uCfEDQo8+Q4pxZAhOg+OA4VTK8MmndvEmV2RLydiCvc+kaLQUS
         IzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743538; x=1692348338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyLoP8xMKHbbGPDbJqH4l+BBAOIbu8DKdw/y5ZAFfd8=;
        b=APfb8vSWD+acyRHwnHv+NgMQxZ8WwR/tKxhH4sNoou3+ue4PIcyNhgPaE8wyaM/Xxm
         xd6kWabm+6efjHHqTZy3CXldnNgAdVWEj9iIlYqi8FQ2WXFr/e7g3NW4b9+ftZ1dTi5o
         rsEPPrqiLRl0ThoQdRuPtq6CioaXU+cu0x/BTr4d7JJO3sPSlTRkz5Ljg/RoHoiwUBUJ
         d1IZPFFWCMdoAlb476r2Nm0uUPt9KPjF1ZE4J66ixOtAC448NY6AciUnF089/KKz/dcZ
         5J1qT9kQzuStwDY2hhm0x7U8S7OAo4Tlyz5KHu8cQ+twRNJYREeICGZ2d+Gsh8k6khkx
         lIfA==
X-Gm-Message-State: AOJu0YwaQKJPiWcjpo6fbnmNePER3t2S7ofSPsXLloynlWfFt5/mCgMY
	yMD0VEQ6Icyp9bD2PN52iFks6dWX7ommUunFRZSk
X-Google-Smtp-Source: AGHT+IEs3o3OCLlXqUGMJTTKigWMXfxnbo5kLQwJsAg6qrfKzpL77GWKDVDUD9TM3uLcHetnGIr47O8aEQUeeSe/VWs=
X-Received: by 2002:ac2:58e9:0:b0:4fe:8c07:98eb with SMTP id
 v9-20020ac258e9000000b004fe8c0798ebmr747962lfo.51.1691743537923; Fri, 11 Aug
 2023 01:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809214946.18975-1-luke.lu@libre.computer> <2cdc67aa-6029-7231-76a8-54c6b51b066c@gmail.com>
In-Reply-To: <2cdc67aa-6029-7231-76a8-54c6b51b066c@gmail.com>
From: Da Xue <da@libre.computer>
Date: Fri, 11 Aug 2023 04:45:26 -0400
Message-ID: <CACqvRUYUkeU9C_W47yPLSRb=+VL4Hti1+E2YQNLKQtcXw_H-OQ@mail.gmail.com>
Subject: Re: [PATCH net v4] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luke Lu <luke.lu@libre.computer>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Fri, Aug 11, 2023 at 2:07=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
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

Thanks for the review, Heiner.

We will rework this in v5.

>
> If going your way we would be better off calling .config_init()
> in genphy_resume(). Please check the MAC driver, maybe it's better
> to re-initialize the PHY in the resume path of the MAC driver.
>
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

