Return-Path: <netdev+bounces-24956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DFB7724E6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB422811E5
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BD101FE;
	Mon,  7 Aug 2023 13:05:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA79D51D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:05:29 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693F1701
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:05:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d2b8437d825so4572293276.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413526; x=1692018326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCHsXc+lT27JE6Z6+8ylge5LujDr0uIa0UFtHeUGk2Y=;
        b=Ut8sOt7lpFeoV7uC5nic5YMi0GUeC8HpWsn9X2ZvHUqogbJC59sug1OCXgBIO45szT
         zu/yDK65dLYqv6f+km1qpewpLLAyHgB83sO8QJplPf6Hb+zQxEgpYnezxw31ErxCfwYd
         DG1K/BD7UexEi2CLbm33TPIAEV+JP9uckCAnXOKFdFxQCTLDT9vDW0yo5WN6ssAjMwB6
         jQausBUtY12YsJG/lvlFmGhmKUqnRUZYXZJAg6WdrWcdht+kmstTdnIijp5oZIEpsXDt
         nq9gS+ZIoUWmVgbHZ6Clm4PxrSxeiApl2AxIg5A46SblXoW3BcU9kQkBbE2yZj77FvnD
         FVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413526; x=1692018326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCHsXc+lT27JE6Z6+8ylge5LujDr0uIa0UFtHeUGk2Y=;
        b=asLciD9hGSYQM/y4h4WD3kbzlRJCQxshPmcqqp3tEV2yvdnK1FWT+xp2C9EJkoHQJ1
         RG1iX75eUseSIWUeOheYWmrK9P2WQ1Kp77IyWVkoNNXaL8UZNEuYPrEXiPS89FlqnHuU
         UXeiYMQRE2U7g51ZWRoBwTccMbaxvIHFQNpTL88q2u9zxGq5uHNz36kAOQ3Zh8iHRtgv
         ymejyTYcCJCAwftFvkU0SQZqPnv//01uJ0/Cufkg4ehpVy8imtgVmtRXVXRfL0f2Rfiz
         KDMVJWPZjO0ohj6Fk+UfClgIRx1ayE22Wa2FHupAy0v1LfyXNgBudIiyoHgTlUl56J+w
         qjaQ==
X-Gm-Message-State: AOJu0YwB4kHoW5FuIgLZDIfavIxGb2Ix3UYZhbC4/pJrNELkctbIok+l
	9Hn6alKuNE4JfQENxjScaRWh3r0pLcQEupvFc433lQ==
X-Google-Smtp-Source: AGHT+IGLxVHYBN4YJi+z5+HalzYdVADQ/IRYzWidcu2Ji/atGqIFAXQgU8cOxoHK1pmjGmBx4BMj8ebAiBn6KY0iG4o=
X-Received: by 2002:a5b:5cf:0:b0:c39:9e09:2c71 with SMTP id
 w15-20020a5b05cf000000b00c399e092c71mr8293260ybp.41.1691413526341; Mon, 07
 Aug 2023 06:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726150225.483464-1-herve.codina@bootlin.com> <20230726150225.483464-25-herve.codina@bootlin.com>
In-Reply-To: <20230726150225.483464-25-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Aug 2023 15:05:15 +0200
Message-ID: <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256 pinmux
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Herve,

thanks for your patch!

First: is this patch something we could merge separately? I don't see
any dependency on the other patches.

On Wed, Jul 26, 2023 at 5:04=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
>
> This pinmux support handles the pin muxing part (pins RP(A..D) and pins
> XP(A..D)) of the PEF2256.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

So it is a bridge chip? Please use that terminology since Linux
DRM often talks about bridges.

> +++ b/drivers/pinctrl/pinctrl-pef2256-regs.h
(...)
> +#include "linux/bitfield.h"

Really? I don't think there is such a file there.

Do you mean <linux/bitfield.h> and does this even compile?

> diff --git a/drivers/pinctrl/pinctrl-pef2256.c b/drivers/pinctrl/pinctrl-=
pef2256.c
(...)
> +struct pef2256_pinctrl {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       enum pef2256_version version;
> +       struct {
> +               struct pinctrl_desc pctrl_desc;
> +               const struct pef2256_function_desc *functions;
> +               unsigned int nfunctions;
> +       } pinctrl;

Uh anonymous struct... can't you just define the struct separately
with a name? Or fold it into struct pef2256_pinctrl without the
additional struct? Thanks.

Otherwise it looks neat!

Yours,
Linus Walleij

