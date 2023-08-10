Return-Path: <netdev+bounces-26225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B477735E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0478C28199A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17E1DDFE;
	Thu, 10 Aug 2023 08:53:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367A3C3C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:53:17 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4951D211F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:53:16 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-589878e5b37so8613577b3.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691657595; x=1692262395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISTwavJo5QNRA0ml/ZYkxWD9JkMB48oJk0Oc/hedKZY=;
        b=cSx8JAyGkOmdsAHLDtARFe5E+bmkrOnNzYHajkz/Im644aeTTP5xiTIfbcqyJUfyjM
         BWgv30uk2EgU3NPHpdPaFDcXp2dzkL5bmF7NQmKV/xk5hAbfSYA57I9FdoiPX6WTL5If
         h8yELZgSUyiI3o+78nsOuxVjK4znn77Cp/xnizFqIcinv/C96+9SADDtYu+wfKZEfO+c
         SqPxyPVMe1oUATXZyDVrBSxCsWaPgJv7fXDcSfajqF2J1NY6VnqOYeDWrWZNxrkG5oMc
         N+HtOZtTumcoJfYCMGjZR0FJqXZUsdejxxhXhj932VOqQMh7f/xkPB2IVDQbVJYtd2yb
         kJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657595; x=1692262395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISTwavJo5QNRA0ml/ZYkxWD9JkMB48oJk0Oc/hedKZY=;
        b=DC5BDGMv8uzLpuc0JagyWWQOefHXsWczLwH7Jn10eBX6PMEKFFsFWvzuwz3GCXPyZV
         3fR/Q6XXFUY1MujdvZzABAJm5Xb1kEhiRQkWLAYEiae4EtVa1dxSkZZwXGlj+YjCqvCj
         1so5w5fch819L3vtspLDfJyLIVB28fyy4765vOJgTISFzdldFCIQyNfb8PkpovjWvq63
         Fx8g5HuCqxUXW9nOH+z7EpH0lgThwe7GDAu0RWu5EOJq6w/VaUNcILan3dh25jA5PEzl
         NXgwZek4A5MrBqEIVj2GBbj+n1SEqQgAa+e/23tkNT4+HzRotGrkUf83NGR7dQaBbLL0
         uyug==
X-Gm-Message-State: AOJu0Yz27SqsohCg9Ov3ZgjldXA7wRJUDfzBNEHAlX24buhtdxX8jHOo
	gp7CHsd870rDDQGDV0BsLkxiF8jWquz7Kj8B0/t4Xw==
X-Google-Smtp-Source: AGHT+IHR3OcxJgk9HIqvUQ98dw3GrFDpfjo2OZ3Zn5ukK1Ej8qavilwui19M8MLrNbXgTNYPBDiu1AU0FMOIqqB8uTs=
X-Received: by 2002:a25:6993:0:b0:d63:5e7:4e1b with SMTP id
 e141-20020a256993000000b00d6305e74e1bmr2168294ybc.26.1691657595551; Thu, 10
 Aug 2023 01:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809132757.2470544-1-herve.codina@bootlin.com> <20230809132757.2470544-23-herve.codina@bootlin.com>
In-Reply-To: <20230809132757.2470544-23-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Aug 2023 10:53:04 +0200
Message-ID: <CACRpkdZWHw7sL6EKe0EP0hX5TEsdhzgkPSdVtPPYhS3LqJRHFg@mail.gmail.com>
Subject: Re: [PATCH v3 22/28] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Herve,

thanks for your patch!

On Wed, Aug 9, 2023 at 3:28=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
(...)
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        $ref: /schemas/pinctrl/pincfg-node.yaml#

Shouldn't that be pinmux-node.yaml?

> +        additionalProperties: false
> +
> +        properties:
> +          pins:
> +            enum: [ RPA, RPB, RPC, RPD, XPA, XPB, XPC, XPD ]
> +
> +          function:
> +            enum: [ SYPR, RFM, RFMB, RSIGM, RSIG, DLR, FREEZE, RFSP, LOS=
,
> +                    SYPX, XFMS, XSIG, TCLK, XMFB, XSIGM, DLX, XCLK, XLT,
> +                    GPI, GPOH, GPOL ]
> +
> +        required:
> +          - pins
> +          - function

Because those are certainly defined in that file.

Yours,
Linus Walleij

