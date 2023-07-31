Return-Path: <netdev+bounces-22828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5076972C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A521C20BFF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C69182C2;
	Mon, 31 Jul 2023 13:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC74429
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:08:02 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C311BD1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:07:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so1215952e87.3
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690808865; x=1691413665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sloIk4WWUeov37xdllLzD6j7lRUmJiAHMp2I8RnM0nQ=;
        b=PXIv4WwQfZUPVLFdmtmO6wanYZ+Ol6lwdLMgNcjYxT4+ZPqxs1vC98OJfVI/kKv+Bp
         ST/1YvhrXuSdz0U9bdNcG7TNHoDor8Cd67JVrK0Igz9dCCvFJ3DeAHky/y/zV68f7jnb
         /CTpftBeqjrEpoD4Fy9Pq6/nCMBZLob334QXhnlOdXchs02ZrYO5HYY/DW002vpSwQ1N
         LbfAphyjIITncn82tuK5vOnTYSfzjAq5LlTA1IrWISZgtPdHLAfBZGC7AlQzFZcOFWsT
         tc/+hq8KF8lVA5DkC43KllU9fg0KeBJw5vHgP/4QIfij3QOntAT+kGm/3Fwj+ahdSRk5
         t9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808865; x=1691413665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sloIk4WWUeov37xdllLzD6j7lRUmJiAHMp2I8RnM0nQ=;
        b=RmB+Y9hB9o1+afIuDh3NPCFXMReBZ4bZMNasyvwgHubLcY6lXNMN3klCD/BafBx+3J
         dnpusl2RBp70V8ZiTLdrFhL7PbY8GvFBN4Wb0ZiLWOo7pxRjrhhf3PKrRDFTwg+Ks+9h
         XB2fq9Kxyoc5gawOjMPWXElu6GFEOnVxBfShjqHfU43/YYDAolz+HyAl34pnNYue+0Cv
         g5YPdjofz/15NS/bGPgrxxAsQRteBgYUr8FnhLQogBFdQTFEdsIIYBIdugb6RNYbpUjt
         Oh+zv/Vy3VfFXopaarGHNi06jfO2UkuMnL76JBGhcU31Q2xzRyRmjlYnQXXk/kvPJC5l
         9o5A==
X-Gm-Message-State: ABy/qLZDz+IM12veHvQrtltfjrDL1UMGND2gcGsLoPH9vReDRarSDFB5
	NtvI78gNYsIAqoTyWjPrlwWkDvNBP0+1nRm3EMo/Y3pIIlhIiiH8ZI9vJw==
X-Google-Smtp-Source: APBJJlF8otKcRiEBYT+w5swQvKj8Vmx/DdTyLNpFy7XON+JoUQyxVul5eQy7lVIbhbUN5//cv00xJntHIwYuqlbtBa8=
X-Received: by 2002:a05:6512:358c:b0:4fe:3e89:fcb2 with SMTP id
 m12-20020a056512358c00b004fe3e89fcb2mr141079lfr.34.1690808865288; Mon, 31 Jul
 2023 06:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org> <CAMj1kXF_AZ9bFWHPjDURkZUdAdrX0Qh2Q03FNYq99pfrJGtFjQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF_AZ9bFWHPjDURkZUdAdrX0Qh2Q03FNYq99pfrJGtFjQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 31 Jul 2023 16:07:09 +0300
Message-ID: <CAC_iWjKL0ejVAeZfcY7unc2KeM73+_jzXdZ=cn0=XOrYMikfQw@mail.gmail.com>
Subject: Re: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 31 Jul 2023 at 13:54, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 31 Jul 2023 at 12:48, Mark Brown <broonie@kernel.org> wrote:
> >
> > As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> > property on ACPI systems") the SocioNext SynQuacer platform ships with
> > firmware defining the PHY mode as RGMII even though the physical
> > configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
> > ("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
> > misconfiguration of the PHY, rendering the network unusable.
> >
> > This was worked around for ACPI by ignoring the phy-mode property but
> > the system is also used with DT.  For DT instead if we're running on a
> > SynQuacer force a working PHY mode, as well as the standard EDK2
> > firmware with DT there are also some of these systems that use u-boot
> > and might not initialise the PHY if not netbooting.  Newer firmware
> > imagaes for at least EDK2 are available from Linaro so print a warning
> > when doing this.
> >
> > Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> > Signed-off-by: Mark Brown <broonie@kernel.org>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> > ---
> > Changes in v3:
> > - Typo fixes.
> > - Link to v2: https://lore.kernel.org/r/20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org
> >
> > Changes in v2:
> > - Unlike ACPI force what appears to be the correct mode, there are
> >   u-boot firmwares which might not configure the PHY.
> > - Link to v1: https://lore.kernel.org/r/20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org
> > ---
> >  drivers/net/ethernet/socionext/netsec.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> > index 2d7347b71c41..0dcd6a568b06 100644
> > --- a/drivers/net/ethernet/socionext/netsec.c
> > +++ b/drivers/net/ethernet/socionext/netsec.c
> > @@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
> >                 return err;
> >         }
> >
> > +       /*
> > +        * SynQuacer is physically configured with TX and RX delays
> > +        * but the standard firmware claimed otherwise for a long
> > +        * time, ignore it.
> > +        */
> > +       if (of_machine_is_compatible("socionext,developer-box") &&
> > +           priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
> > +               dev_warn(&pdev->dev, "Outdated firmware reports incorrect PHY mode, overriding\n");
> > +               priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> > +       }
> > +
> >         priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> >         if (!priv->phy_np) {
> >                 dev_err(&pdev->dev, "missing required property 'phy-handle'\n");
> >
> > ---
> > base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> > change-id: 20230727-synquacer-net-e241f34baceb
> >
> > Best regards,
> > --
> > Mark Brown <broonie@kernel.org>
> >

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

