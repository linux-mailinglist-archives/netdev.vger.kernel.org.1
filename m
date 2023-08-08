Return-Path: <netdev+bounces-25416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17B773EAA
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0441C20FD0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E013FF3;
	Tue,  8 Aug 2023 16:33:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7926B21
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:33:49 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41324332AA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:33:37 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63d1238c300so29465286d6.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512393; x=1692117193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1jWjdgcMtkS8z/zWGRD8ihE010a+ozHwBFvKhqo23k=;
        b=odM2CEY1FRyCoab/fC1eNBUzNXqqakMfkwAgLHsbSO+VTQHRpWzo+5hHv6o++4FEeE
         gDXmHxCVWpOuyMw9v5BdhQhAkMVpH4QcxCeNp6Mh8x6MtW2Uq+xx1iMORxREVYOa4+dT
         7inlQa5LbDVHN8N74x0BzdSr+MHx1UPCLhKPJQfDP06NiyljUJBblFEPqyp64EMQnyi+
         /nq20T4xJe5rPOmIrifSlWDULzDchzhLYW7bpVgOa8zxsCQRCVeGBLylbOkqqxxYCTBm
         gmYhKN4fSz//RH2XuUafiGZSqUh5O7HY/UsdIeXv1+8X+CozZEcwSey4xoQhR+yVIjbA
         WH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512393; x=1692117193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1jWjdgcMtkS8z/zWGRD8ihE010a+ozHwBFvKhqo23k=;
        b=la5SA7HVOIQqHp/sIO2/1YeCuE0TDDkClXxdv4/LG9dV7Tz8l4Dk5RnuDS98TFoU1N
         MQLVRqnvbXfgR0iAGERaMPzXAr2JEvCdH3fQFiiSP4shsKGD8Ne4wEVsd9vyZPX8YyIW
         OOZ0hvm4C7NY9lO0W0++ujbXAco7XckePHRPKtcedciulAq1w5Anp6rmu6n0f5/HWt4q
         eDf1v9d0YHs2D3iNeb3jxUdqyTDg0XkKr5zJUqFxuaCEp0G3MsyOudPfLq4Zb9CrQPdM
         MqTgQluB+ArXddYWmv6m3bzPiOjNaUCu1k40ua2eKQr1tXK0O0g65K0o25UaDddzXsSn
         oaWg==
X-Gm-Message-State: AOJu0Yx/gWE22uMpoNfv/4ESclnRhTLtBMw/dwOLed71VY5LTQ0iDs35
	U2pJVVdwwZsxQrCplnumTaYOcUfSELs0lci2d2TxG+Av0Plq+r4p
X-Google-Smtp-Source: AGHT+IE/m/O86+1kRO0A1smGtafOuu/t8la0fmfi5L2yurMCmbtwgtH9QAEdX4VoPwi2Z4+7B32cwpghwJP0TuXuQTc=
X-Received: by 2002:a25:5083:0:b0:d47:5994:c0fd with SMTP id
 e125-20020a255083000000b00d475994c0fdmr6301271ybb.49.1691485264866; Tue, 08
 Aug 2023 02:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com> <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
 <8f80edf2-c93d-416f-bcab-f7be3badf64a@sirena.org.uk>
In-Reply-To: <8f80edf2-c93d-416f-bcab-f7be3badf64a@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 8 Aug 2023 11:00:53 +0200
Message-ID: <CACRpkdYuJ+4hccip+m9SDv63DZQ1+knFnUm431Ki-K5qi49ExQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256 pinmux
To: Mark Brown <broonie@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	alsa-devel@alsa-project.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 3:10=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Mon, Aug 07, 2023 at 03:05:15PM +0200, Linus Walleij wrote:
> > On Wed, Jul 26, 2023 at 5:04=E2=80=AFPM Herve Codina <herve.codina@boot=
lin.com> wrote:
>
> > > +#include "linux/bitfield.h"
>
> > Really? I don't think there is such a file there.
>
> > Do you mean <linux/bitfield.h> and does this even compile?
>
> #include "" means "try the local directory first then fall back to
> system includes" so it'll work, it picks up extra stuff on top of what
> <> does.  There's a stylistic issue though.

Wow that's a neat trick, I learn something new every day!

But we probably wanna be sure to get the system include.

Yours,
Linus Walleij

