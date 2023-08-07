Return-Path: <netdev+bounces-24957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971E7724FD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ABF1C20BFC
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C510784;
	Mon,  7 Aug 2023 13:07:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBEB101FB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:07:10 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47FC19A6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 06:06:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d4364cf8be3so3471194276.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413613; x=1692018413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN5TMkTY0ygg4jFnAPE5f0kWVzSNcpz9+iRD79bC3Z8=;
        b=xpSCvUoQbw1tjxn+0pZ6cSy2bPnR/cI/N5v1Xa8IkA31SVzn/S+g0e9pWhC2z1ew5h
         oU+JROfYYJZovhf186MJRP0DNrRNrtrBKPxMbRVGMSwQNFUZUm1h2qHsVrIZ/9OJIv9C
         fvgBVwcUpM2siwYe6A84FoyH8wuJBQVrP09+Zo6NBG9tl9SnLf1wNV0xx7hmw5RePlMs
         qwKSXeFlTsIy//gg+MU4nPzw9JfVuTmRxNIn+vTPB3YG30SvjpzU70gSB20XUwlCptb6
         LFbcqdFnalTPgXLGlG/1iJcEwt4cYFbpKf1ws5droSP7fBmcsG3P5llSCwvsY/eQIsiV
         maoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413613; x=1692018413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN5TMkTY0ygg4jFnAPE5f0kWVzSNcpz9+iRD79bC3Z8=;
        b=HIrlFbHCBLqiJTVK9KztAt1QjOjp9is/MMx6weaqUnUXfX8EosgDXhZf2eB0710Hq6
         uDsr7vFhbCaGRkpUklbU09OxIURD/iY7B1AWuGj1e9moAMo+/Q98XwJb2ghj3rmPvZlV
         FGftr1hKVus2YbA9kKAmrxwzXencT+qk2sx0ezMvFDMMXQ4DVGFNV8PomUDKIo6KC4gU
         dfPZ878iCzBoVxYoZumVsVVFtbuFoc9oWip/vbEGGMyJrJytj/gcMvwF5IYk9GY+UfTc
         /TvcULlX4QzM+lwsUFM2DNUpOywjjR9y6aQczIrpeUp5eSJGwCQWc/AlZcGnGnRyhPSB
         s5Dw==
X-Gm-Message-State: AOJu0YwXFlxSaHDhS2Uiuun0fkSGn2HQlgGn/zr+fYvpGJbNQXk1m4DZ
	l/7KfYr6RmrlI+AUDy8igvKmDYWqV4PdmslTeV5rvQ==
X-Google-Smtp-Source: AGHT+IEMKCq/m3/N1+FiikwFsnDje8GRItyWdNDJE1nuhiz2PrdZl+YFSqKhB6L6a9fy66xvdbZfHLOx9hNasWI6TVw=
X-Received: by 2002:a05:6902:4f4:b0:d09:85d3:4edb with SMTP id
 w20-20020a05690204f400b00d0985d34edbmr8822226ybs.7.1691413613049; Mon, 07 Aug
 2023 06:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com> <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
In-Reply-To: <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Aug 2023 15:06:42 +0200
Message-ID: <CACRpkdZebvrdGXooLXmgXhUcgdgxBczJBpdEoEyJDR39abaAqQ@mail.gmail.com>
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

On Mon, Aug 7, 2023 at 3:05=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:

> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>
> So it is a bridge chip? Please use that terminology since Linux
> DRM often talks about bridges.

Replying to self: no it's not a bridge, it's a WAN thingy.

So perhaps write that this is a WAN interface adapter chip.

Yours,
Linus Walleij

