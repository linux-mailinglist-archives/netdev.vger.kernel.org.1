Return-Path: <netdev+bounces-25581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4E8774D55
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ECC1C20F9E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C53174CE;
	Tue,  8 Aug 2023 21:49:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993E10FF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:49:46 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D4B1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:49:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so95510111fa.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691531382; x=1692136182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qYerQWFf1ix5KHtY99MS4jSB8DQAs9co/lnQIZ+dhI=;
        b=FrNaFxjlwpRFm2ZaqTEVKKumXjnd7ComOOWOZmrjXYgDYMvEXazM7CCXphzVh1/C/K
         NP5sjTK0dIQm0/9wGmf7nEwDV7Xk8f+T97AbHbMm4JkjPDfbkskBicWsAACfRTGKUHkG
         zuC69RP3+07PAyZhrHIpT6PPZ98X9xyJu+2DEkSGWP1HRqHeQ1YU8pWInTUVhylbG2g4
         bzAC745EN5wdU3rCMBBBZT6q6cD2O+q2EGddA4xv+55YkHsb2lE90EoPvp2S73b9Wgfa
         bcZc3s1S6HVntugMBSpBUNjQUovF4F1LmIketV9E5WzR9zdf+AT9GddV1aRJ5XYi7wY+
         qtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531382; x=1692136182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qYerQWFf1ix5KHtY99MS4jSB8DQAs9co/lnQIZ+dhI=;
        b=MVRL4ZUIFMRkAQ8hyTcE7SSpDuduxDk9rwVjgjEBzJiJ6G7hNYQxxzeqah8FkDyH4E
         +4JeDRvLmwCqPBgDPmunuN0sQm+3Cp0otxi51o6OkRuI0QOhEzrXf9PURzX5r6DQ16PG
         3PKlU0RPbEYCbNDCZv2BXBe3jNSfjrdkeAKRoiclXzPr2Au4JaNa4qp1gNhFYbxo9q5B
         m8g+E3JQmpnYgkeI58Nm+OIkoLu5tXh1zU6TP55fPxJOrJcnQdRj+Y0GlfHJlJy/nsVd
         oyY/5ahY/UEh8XJqzKoThnR1PHRzLNDiUfD+ZaeYtaF9Ql7/cKSw7dgsAuGXxTu9PbU4
         k52Q==
X-Gm-Message-State: AOJu0YxNnPiuhcUNC0G3iVNumWxJ48wIsdYLEEFk51zzCFpZeIR0BHLn
	Bnk59/Nwyd5ZfPZmpPxfIbRZWywj+/MGHcKqPC5p6w==
X-Google-Smtp-Source: AGHT+IH2g37CljZBjyKryUTqwvcCbghj2op+ujnMBCmtdJr8xIQF/zKIPIsTftv+x+by2YvZLpwCGXHcH4ENvmiFF18=
X-Received: by 2002:a2e:9b86:0:b0:2b9:e501:a6a6 with SMTP id
 z6-20020a2e9b86000000b002b9e501a6a6mr563511lji.30.1691531381689; Tue, 08 Aug
 2023 14:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808050016.1911447-1-da@libre.computer> <b8931b6c-5b35-8477-d50f-b7a43b13615f@gmail.com>
In-Reply-To: <b8931b6c-5b35-8477-d50f-b7a43b13615f@gmail.com>
From: Luke Lu <luke.lu@libre.computer>
Date: Tue, 8 Aug 2023 21:49:30 +0000
Message-ID: <CAAzmgs75L6Y3PU1SF8Uvh1Z2cqt86HmaRKFn088yzRK73mfnLA@mail.gmail.com>
Subject: Re: [PATCH v3] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Da Xue <da@libre.computer>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

HI Heiner Kallweit:

On Tue, Aug 8, 2023 at 6:42=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 08.08.2023 07:00, Da Xue wrote:
> > After suspend and resume, the meson GXL internal PHY config needs to
>
> To avoid misunderstandings:
> You mean suspend/resume just of the PHY, or of the system?
>
We found this issue during the test of whole system
suspend/resume(including ethernet/network),
so it's more proper to interpret as "the system" here

> Description sounds like this patch is a fix and should go to stable.
I agree it's worth the effort to push the patch to stable tree, but
found a conflict with
commit 69ff53e4a4c9 ("net: phy: meson-gxl: use MMD access dummy stubs
for GXL, internal PHY")
It will prevent maintainers doing a clean cherry-pick, we can slightly
rework the patch and
send it to the stable tree separately once this patch is accepted by mainli=
ne.

> So add a Fixes tag.
Sure, as the issue is introduced with first resume(), so will add
Fixes: 7334b3e47aee ("net: phy: Add Meson GXL Internal PHY driver")

> And a formal remark: Your patch misses the net / net-next annotation.
>
Not sure if we understand this correctly, do you mean the one line
summary of this patch?
or the content of the commit message that needs to improve to reflect this =
is an
ethernet/net related fix?

I'd appreciate if you can explain a little bit more, so we can better
fix this, thanks

> > be initialized again, otherwise the carrier cannot be found:
> >
> >       eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> >               DOWN group default qlen 1000
> >
> > After the patch, resume:
> >
> >       eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state U=
P
> >               group default qlen 1000
> >
> > Signed-off-by: Luke Lu <luke.lu@libre.computer>
> > Signed-off-by: Da Xue <da@libre.computer>
> > ---
> > Changes since v2:
> >  - fix missing parameter of genphy_resume()
> >
> > Changes since v1:
> >  - call generic genphy_resume()
> > ---
> >  drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> > index bb9b33b6bce2..bbad26b7c5a1 100644
> > --- a/drivers/net/phy/meson-gxl.c
> > +++ b/drivers/net/phy/meson-gxl.c
> > @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device=
 *phydev)
> >       return 0;
> >  }
> >
> > +static int meson_gxl_phy_resume(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     genphy_resume(phydev);
>
> Return value of this function should be checked.
>
will fix in v4

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
> > @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] =3D {
> >               .config_intr    =3D smsc_phy_config_intr,
> >               .handle_interrupt =3D smsc_phy_handle_interrupt,
> >               .suspend        =3D genphy_suspend,
> > -             .resume         =3D genphy_resume,
> > +             .resume         =3D meson_gxl_phy_resume,
> >               .read_mmd       =3D genphy_read_mmd_unsupported,
> >               .write_mmd      =3D genphy_write_mmd_unsupported,
> >       }, {
>

