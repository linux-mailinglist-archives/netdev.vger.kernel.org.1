Return-Path: <netdev+bounces-13055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60873A0D2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE29B281962
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D81E533;
	Thu, 22 Jun 2023 12:25:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA115AE4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:25:53 +0000 (UTC)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D641BC6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:25:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-791b8500a1dso857592241.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687436751; x=1690028751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfXyQrUfadjr8GnkWzNVYudXWoJvyTwyORcnxDrw72I=;
        b=N/OcqIg+9X1ZFyS2Xesam6kAIxWkO3Aox0KRyQupWTJt3saeePsFJmkmxqlYNtFyEz
         s93LdrFJ6Ll0U9MLdZ4/vxv+fypKnHyw67tnMDYwkhQlqB4Nv4OTWwo8l/veUJJfIWUl
         +KXTYo/S7ggyIbuSAMXfnEyIW6bhFtEWxoX+Jeg9CPj52BdOaAvv6ltkWLveKCjhI93a
         vXK7j4K6qwSa5CeAveq38n+bzTgv/FrqOhwdhhHY2PQsj483PzbG6P5LKf+XAfrHxjQd
         t4TSkVmnYUz0QlOmL+2mMesB5EyicVZsEbppQ3yCI91ufysl8E1r5Qa31fFJQvp3WXLk
         5Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687436751; x=1690028751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfXyQrUfadjr8GnkWzNVYudXWoJvyTwyORcnxDrw72I=;
        b=XDhTOSyyqumvoZuadbInakiery45NoCPMMmy7flwiBxAp8CLaoRC9SkI1B5FJipcik
         /d19bVQOEeAizwYIkgmjvPa7+RwmtCaaLdIxSHWpaJSBT+91y776plWcY+V/CMQHEprS
         SJqZnlQOhs8HOJZk+xfjrycYS6OE7zyQpOtjBXNUaShLD+jAxRL/MideT06rNefS737l
         AUZJoiHYYwyOB1+v/MkPsF061pWmC5mQCnboDSW/sDLc+mcU1FK9uSZw18MqPuPID4/N
         sTHHP63Dr/hzfQwxwrTGSg4KvYWCzLnTJT3agtz0l+IxqPdD42rjsHHLWNnbIO8LbPF4
         XSZA==
X-Gm-Message-State: AC+VfDytmDzJQYgpG/xePsfJnUwJt0obSyjxeVTk6DLQ/vHU3LRLJ/79
	q1awnuzsZc+6yDOpPUWOvnGOOnUqUdF537f0XB9oEg==
X-Google-Smtp-Source: ACHHUZ6SnNysVqnQMX32/VGp1JafxeiEraOqNdQgR8u2Q27PiGxy3hRuTzgEhX3Wz9Z/6G3DxHhWxRsPEa15hB0FdTA=
X-Received: by 2002:a67:fdc2:0:b0:440:ac0e:66e1 with SMTP id
 l2-20020a67fdc2000000b00440ac0e66e1mr5309391vsq.13.1687436751354; Thu, 22 Jun
 2023 05:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621153650.440350-1-brgl@bgdev.pl> <20230621153650.440350-8-brgl@bgdev.pl>
 <ZJQ7PX01NAXmr7RV@corigine.com>
In-Reply-To: <ZJQ7PX01NAXmr7RV@corigine.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Jun 2023 14:25:40 +0200
Message-ID: <CAMRc=McXAdvnxyULwhK_0+oLdo6s32q9bU06Upec-a3-zhrqyw@mail.gmail.com>
Subject: Re: [PATCH net-next 07/11] net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
To: Simon Horman <simon.horman@corigine.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Junxiao Chang <junxiao.chang@intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 2:15=E2=80=AFPM Simon Horman <simon.horman@corigine=
.com> wrote:
>
> On Wed, Jun 21, 2023 at 05:36:46PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a variant of stmmac_pltfr_remove() that only frees resources
> > allocated by stmmac_pltfr_probe() and - unlike stmmac_pltfr_remove() -
> > does not call stmmac_remove_config_dt().
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 20 +++++++++++++++++--
> >  .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
>
> Hi Bartosz,
>
> some minor feedback from my side as it looks like there will be a v2 anyw=
ay.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/dr=
ivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index df417cdab8c1..58d5c5cc2269 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -762,6 +762,23 @@ int stmmac_pltfr_probe(struct platform_device *pde=
v,
> >  }
> >  EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
> >
> > +/**
> > + * stmmac_pltfr_remove_no_dt
> > + * @pdev: pointer to the platform device
> > + * Description: This undoes the effects of stmmac_pltfr_probe() by rem=
oving the
> > + * driver and calling the platform's exit() callback.
> > + */
> > +void stmmac_pltfr_remove_no_dt(struct platform_device *pdev)
> > +{
> > +     struct net_device *ndev =3D platform_get_drvdata(pdev);
> > +     struct stmmac_priv *priv =3D netdev_priv(ndev);
> > +     struct plat_stmmacenet_data *plat =3D priv->plat;
>
> nit: please use reverse xmas tree - longest line to shortest - for
>      new Networking code.
>
>      e.g.:
>
>         struct net_device *ndev =3D platform_get_drvdata(pdev);
>         struct stmmac_priv *priv =3D netdev_priv(ndev);
>         struct plat_stmmacenet_data *plat =3D plat;
>
>         plat =3D priv->plat;
>

I normally stick to this convention but here, you need 5 lines for the
same effect and you make it more confusing by initializing some of the
variables at their declaration and some not. In other places in this
driver the same approach is used i.e. not adhering to reverse xmas
tree when all variables are initialized when declared.

Bart

> > +
> > +     stmmac_dvr_remove(&pdev->dev);
> > +     stmmac_pltfr_exit(pdev, plat);
> > +}
> > +EXPORT_SYMBOL_GPL(stmmac_pltfr_remove_no_dt);
> > +
> >  /**
> >   * stmmac_pltfr_remove
> >   * @pdev: platform device pointer
>
> ...

