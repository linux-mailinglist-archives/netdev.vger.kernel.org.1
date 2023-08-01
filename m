Return-Path: <netdev+bounces-23136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D580A76B1AD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119CC1C20DF5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCF20F92;
	Tue,  1 Aug 2023 10:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF420F82
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:24:06 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213871706;
	Tue,  1 Aug 2023 03:24:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C9AFC0003;
	Tue,  1 Aug 2023 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690885443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh049SisoIWliG3uyLlXHzxD5wRc/J6bqr8r19ynpGo=;
	b=f9mqi/1Oxj+4XOaIlU22+7chRim64bLbHC89dhnq9NrYZHmPLGlNes8J8KY24lP6ZgYAlD
	eD6x5iT8jEr2zsXSVJJPvtYx5/BCSTIVTF4upPsbtDnfanTrKZzsr/NZcmTGpMMRPsbiwu
	MfI8n7wdawYwlc8X3XOv1bqEp5cuwBk81jBVGgET6qkiT/ubH6LAoCaSPNevEy1yMF9GlQ
	BgQ3xYH3kfMmnr/GZ5pgzGZmS4ZwoDWBx5Za0/Ne59WHOdLeHgCl4tpOQtBywFMYlG7Rki
	nuJbeHCb5FilfHYhV0dpg93ttgFZRXaEugYAZsyN24ghg5tiOBCl9ltTL4+hNA==
Date: Tue, 1 Aug 2023 12:23:59 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Randy Dunlap <rdunlap@infradead.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 10/28] soc: fsl: cpm1: qmc: Introduce
 qmc_chan_setup_tsa*
Message-ID: <20230801122359.6b22784c@bootlin.com>
In-Reply-To: <252d6a49-4a97-4ecc-844e-f23bda55debf@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
	<20230726150225.483464-11-herve.codina@bootlin.com>
	<252d6a49-4a97-4ecc-844e-f23bda55debf@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 1 Aug 2023 11:36:43 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static inline void qmc_clrsetbits16(void __iomem *addr, u16 clr, u16 set)
> > +{
> > +	qmc_write16(addr, (qmc_read16(addr) & ~clr) | set);
> > +}
> > +  
> 
> Please don't use inline in .c files. Let the compiler decide.
> 
>        Andrew

Ok, I will remove the inline in the next iteration.
I will also remove the inline of all other similar functions (probably a
separate patch in the series).

Regards,
Hervé

