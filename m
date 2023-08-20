Return-Path: <netdev+bounces-29191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89640782011
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 23:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04297280F4C
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7DB6FD0;
	Sun, 20 Aug 2023 21:08:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B16FC8
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 21:08:21 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09255A6
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:06:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58fc4d319d2so13076857b3.1
        for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692565587; x=1693170387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD9cyaHgSU7OecxP7U/v+MRhNN5iRGNEtNN5f+NxK3E=;
        b=EkbIjelbdLkuzIuqi8lN2IaFia7QROWlfjiI7q7zlP6jDAvGYdauZr5rWGeP5TyNj/
         FTLwzTAVecCKL3BibvaoUCvO+gGncYmRqvynbSCU/H9CSnnaBpgnH1tOwcSw/jhwlTNE
         yxf9olC181R4u63D7T09ydG+I3s3ZtZ/u2PVgFULhzS48dJpD5wb5F9dF3a9Y+PsFYj+
         NHgSZ9uwlOzKa4/KiVA0h3lpcev49Jt9Lvu2vbMboOBUQF5Ovmhefg1ifsF1lEHMhDCm
         MbXMx2vz3Or/EDK9+/FBko1YDMvcoaLkgfWLakufV6DztPp4m3w4Zu6/QJHcRw+4VVzp
         LubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565587; x=1693170387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD9cyaHgSU7OecxP7U/v+MRhNN5iRGNEtNN5f+NxK3E=;
        b=g4tH8ASBVFQ2BISfo0PnE3XpM9NljM7fXHQMIHHulXkjQF/xkgY/LMEdDmBQzWPV6j
         5B5NjvG0tE/T6YI43iiA+hHNRI2jTTKImErxZQ8gYlJolU1Zxzt0iKIyyWvM1Lhv5y7I
         pIKqODS2zm3weraSWoo8dIJE9MsQJvPu8XtL+36Nt3Tq7CdTj45iDWXswyYzkihSnKBI
         S0NdGXL6YBIsFt57o9nRUkazUnFWA+egadjozcSxDcvDhWy+28A3xoqXVWcOMDWyc9Fm
         rI4fggeigovQaA5GZeaWDSbz4Qk6Pi8jmUsrtmLleTgkoLFakFnpMSH+ucYVyBmZ7XZG
         KkZw==
X-Gm-Message-State: AOJu0YzPG1orHyRtEkdQCTLGufXXxCi4W0z8upVQsDSJAvMZDRHRf8xT
	ftZJGjYtgRPXwkZuSNVQSam8XkIh0z02GKh6x2bo2g==
X-Google-Smtp-Source: AGHT+IFUaS1hymFHjE/AoExPooLhJU9s7gYCM4hD5xHtjEpweKryYFaY4soUhFjoyRUlcRmul8KDvXSLKE35vGSqXJ8=
X-Received: by 2002:a81:7283:0:b0:589:8b55:f8cf with SMTP id
 n125-20020a817283000000b005898b55f8cfmr4756130ywc.50.1692565587414; Sun, 20
 Aug 2023 14:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692376360.git.christophe.leroy@csgroup.eu> <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Aug 2023 23:06:16 +0200
Message-ID: <CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 6:41=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> From: Herve Codina <herve.codina@bootlin.com>
>
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.
>
> The framer framework provides a set of APIs for the framer drivers
> (framer provider) to create/destroy a framer and APIs for the framer
> users (framer consumer) to obtain a reference to the framer, and
> use the framer.
>
> This basic implementation provides a framer abstraction for:
>  - power on/off the framer
>  - get the framer status (line state)
>  - be notified on framer status changes
>  - get/set the framer configuration
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I had these review comments, you must have missed them?
https://lore.kernel.org/netdev/CACRpkdZQ9_f6+9CseV1L_wGphHujFPAYXMjJfjUrzSZ=
RakOBzg@mail.gmail.com/

Yours,
Linus Walleij

