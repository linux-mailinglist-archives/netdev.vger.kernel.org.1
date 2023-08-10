Return-Path: <netdev+bounces-26300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA27776B1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E686282030
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016E1F93F;
	Thu, 10 Aug 2023 11:17:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48881DDF0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:17:23 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B882686
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:17:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso699542276.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666241; x=1692271041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADRnTf+HtriZ7mqwDU3wWvmXrT7FB+Ztxvgw7H2KXeU=;
        b=QFhKu9tkFZ+fkU1lcY4zVfF0dk/FWoUgZD0eH36Sz7H5E6vylleVAxrx4pnTaXqwhk
         0+gy/gZj3JZk12Km6iz/EZoWzKbi128l5ProuMk6rD8PXzxfQdAWHaHfYFH+hT3tRM5T
         JhuEe8IlHx2uTiKvZWsgQrv6fkFqrBx0+2vETEZCqjNX/pWDMRwL/0BRd5MvDHtFVvKa
         BM/Lp+D9Uqm7WCUrVCer3WiE1OLLbVSPYEz4lyAydeXxxun5B/2ka3EMFk7a+ErH42db
         gw2/aA6IBStBu2S2LDjrdyts3q5jk/zxoySCSTATECPSlKOeat6hCKBGV6ZorzoWY9HV
         DN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666241; x=1692271041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADRnTf+HtriZ7mqwDU3wWvmXrT7FB+Ztxvgw7H2KXeU=;
        b=litJAYw6ZdgvNQFN+MDxtzcCkfgbokoNoFjk825ShQ2JK4A5kHpDAMQX4RKSUN2AM9
         9hcjY7xU9/Fbz7naa87TUzRYepsaEZaXrgHci2MnAL6pPJ7i0QTdqZDUIpnFMFHI4iba
         7cPTGKJzyc6N9XsCOf6nWGbIhbUvtgjNGc1KmW3qd+w5lh6NFvUNvICy1yGFYjhQMGOA
         n97+IXJCPxG3uQ5VIZ8BX+l6vyxetNryCveT9b+OQZHO9wVKUNBdysH44ygFQ+Cbm5JZ
         E5PqYIGrnml0SedkZbZOSWPaV1MsC0zd1evT1OKKmmju+k1/bALPIYNXWo1wnclKCK/9
         X7gA==
X-Gm-Message-State: AOJu0Yx6wNCYO6eOw5uRMn8z9OFuf9TT2cJ5ha1Gi8Mna4HjvZl8OiF2
	BeZ1T4j+q4KMim3/tvW6Ler+hDcT+XZQKqgr/5/KkA==
X-Google-Smtp-Source: AGHT+IG0cc60EKwg6aO/Vl/FWx+h3xKBM7qpk0WTUOrKZYJlTlQ3xEW/05G+n7KdFt0H+qP3lFIXHa3H2q7KcJby2j8=
X-Received: by 2002:a25:250f:0:b0:cea:6760:d2c6 with SMTP id
 l15-20020a25250f000000b00cea6760d2c6mr2046852ybl.41.1691666241474; Thu, 10
 Aug 2023 04:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809132757.2470544-1-herve.codina@bootlin.com> <20230809132757.2470544-22-herve.codina@bootlin.com>
In-Reply-To: <20230809132757.2470544-22-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Aug 2023 13:17:09 +0200
Message-ID: <CACRpkdZQ9_f6+9CseV1L_wGphHujFPAYXMjJfjUrzSZRakOBzg@mail.gmail.com>
Subject: Re: [PATCH v3 21/28] net: wan: Add framer framework support
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

On Wed, Aug 9, 2023 at 3:28=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:

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

I love it, very clear commit message telling us what it is all
about.

The placement in the WAN subsystem also hints that this has
something to do with long distance links (relative to something)
so maybe mention that?

> +menu "Framer Subsystem"
> +
> +config GENERIC_FRAMER
> +       bool "Framer Core"
> +       help
> +         Generic Framer support.
> +
> +         This framework is designed to provide a generic interface for f=
ramer
> +         devices present in the kernel. This layer will have the generic
> +         API by which framer drivers can create framer using the framer
> +         framework and framer users can obtain reference to the framer.
> +         All the users of this framework should select this config.

But this description just says this is a framing framer that frames frames =
;)

So please copy some of the nice description from the commit message
into this Kconfig helptext.

Is "long distance link time division multiplexing (TDM) framer" more
to the point for example? Or is the ambition to frame other multiplexing
techniques as well with this subsystem? Such as FDM? Then mention
that.

Yours,
Linus Walleij

