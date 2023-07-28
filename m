Return-Path: <netdev+bounces-22345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12076716C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7A1C2193F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6B1429E;
	Fri, 28 Jul 2023 16:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4714283
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:05:10 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E53C1D;
	Fri, 28 Jul 2023 09:05:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47AE9FF802;
	Fri, 28 Jul 2023 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690560303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOwouwDm/Kasz+cImp4ZpLSYmghBWaSXArlXLO1rpH0=;
	b=ljouRWt14CzNxKdUZLfGcvVcD/MG5DdymZazb90A1RiBoJhkZfx33QMCamA/nq64KgQViJ
	5j94ziGUbCxvMyciw8LIg6YwFQkSf7yHDnrs3zIfxUjdSzdBKykEKG0kWvz/aV8i05xP78
	mqj89PddP7bz5a6JA8nBI8sawR22k7xKkRbiJMjIfLhDef/HPbnKzJyS+UFodCJ+DT53ZN
	A4VJB+/3Z1hacM8uhegA536VPmo5HTtstM9AcUBZ8j7k+5ooOrDw8+C3Kc1ufE3I2crSNT
	VFHW+ZQvhNQgc6+HqrnlnydP17EiBNygti/FGEhzRdi0EfCxPi4SUnCrthjHlQ==
Date: Fri, 28 Jul 2023 18:04:43 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Varshini Rajendran
 <varshini.rajendran@microchip.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
 andi.shyti@kernel.org, tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
 ulf.hansson@linaro.org, tudor.ambarus@linaro.org, richard@nod.at,
 vigneshr@ti.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, sre@kernel.org, p.zabel@pengutronix.de,
 olivia@selenic.com, a.zummo@towertech.it, radu_nicolae.pirea@upb.ro,
 richard.genoud@gmail.com, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
 broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
 linux@armlinux.org.uk, durai.manickamkr@microchip.com, andrew@lunn.ch,
 jerry.ray@microchip.com, andre.przywara@arm.com, mani@kernel.org,
 alexandre.torgue@st.com, gregory.clement@bootlin.com, arnd@arndb.de,
 rientjes@google.com, deller@gmx.de, 42.hyeyoo@gmail.com, vbabka@suse.cz,
 mripard@kernel.org, mihai.sain@microchip.com,
 codrin.ciubotariu@microchip.com, eugen.hristev@collabora.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 00/50] Add support for sam9x7 SoC family
Message-ID: <20230728180443.55363550@xps-13>
In-Reply-To: <20230728-floss-stark-889158f968ea@spud>
References: <20230728102223.265216-1-varshini.rajendran@microchip.com>
	<c0792cfd-db4f-7153-0775-824912277908@linaro.org>
	<20230728-floss-stark-889158f968ea@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Conor,

conor@kernel.org wrote on Fri, 28 Jul 2023 16:50:24 +0100:

> On Fri, Jul 28, 2023 at 01:32:12PM +0200, Krzysztof Kozlowski wrote:
> > On 28/07/2023 12:22, Varshini Rajendran wrote: =20
> > > This patch series adds support for the new SoC family - sam9x7.
> > >  - The device tree, configs and drivers are added
> > >  - Clock driver for sam9x7 is added
> > >  - Support for basic peripherals is added
> > >  - Target board SAM9X75 Curiosity is added
> > >  =20
> >=20
> > Your threading is absolutely broken making it difficult to review and a=
pply. =20
>=20
> I had a chat with Varshini today, they were trying to avoid sending the
> patches to a massive CC list, but didn't set any in-reply-to header.
> For the next submission whole series could be sent to the binding &
> platform maintainers and the individual patches additionally to their
> respective lists/maintainers. Does that sound okay to you, or do you
> think it should be broken up?

I usually prefer receiving the dt-bindings *and* the driver changes, so
I can give my feedback on the description side, as well as looking at
the implementation and see if that really matches what was discussed
with you :)

Thanks,
Miqu=C3=A8l

