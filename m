Return-Path: <netdev+bounces-19690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA575BB0B
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E2E2820DB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4FE19BD1;
	Thu, 20 Jul 2023 23:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD740168C9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 23:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C583C433C8;
	Thu, 20 Jul 2023 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689895227;
	bh=9ctZmDV13Kh+Hot8/5Y8puENl1/IkM5Fg2XggDWrado=;
	h=In-Reply-To:References:Subject:From:Cc:List-Id:To:Date:From;
	b=cYbD9BIbKe9OOqdwr3dzlL9wR5KaUX5QP2379F7HDHytuvs+1MP54q0Z68hGsKH4B
	 FYWl7tZYiSDpdOLegT+YQZM1yXUy5lwOu+8wosqMqhfiEPancQh0OsMx7gngCZFRkw
	 pJsU0gGmQ3yzb23zLs6tK4Bc3oZ1qfa0PA7RELaz/17Nk344wIVC1tSV56N7uYZFOa
	 nyr5zxSzIMgd63Ws7TvT1S5JL0M5v+l9wHZlr/Q9lh/6EOA+OyejOA9ESm2BbYF40v
	 AD9xlhIEjpsnEl3JoCBTGL1ZDlPD1p+JZWCY79kM1KNfmzIfj3Ot4lKfzjQq+kUXEx
	 1F+hprA229KgQ==
Message-ID: <11dbf88d12051497ba1e3b16c0d39066.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me> <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
Subject: Re: [PATCH v3 02/42] dt-bindings: clock: Add Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, linux-input@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: <soc.lore.kernel.org>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David S. Miller <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Dumazet <edumazet@google.com>, Guenter Roeck <linux@roeck-us.net>, Hartley Sweeten <hsweeten@visionengravers.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Kris Bahnsen <kris@embeddedTS.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lennert Buytenhek <kernel@wantstofly.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, Mark Brown <broonie@kernel.org>, Michael Peters <mpeters@embeddedTS.com>, Michael Turquette <mturquette@baylibr
 e.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, Olof Johansson <olof@lixom.net>, Paolo Abeni <pabeni@redhat.com>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, soc@kernel.org
Date: Thu, 20 Jul 2023 16:20:24 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2023-07-20 04:29:02)
> diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.ya=
ml b/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml
> new file mode 100644
> index 000000000000..111e016601fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/cirrus,ep9301-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic ep93xx SoC's clock controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-clk
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-clk
> +              - cirrus,ep9307-clk
> +              - cirrus,ep9312-clk
> +              - cirrus,ep9315-clk
> +          - const: cirrus,ep9301-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +      compatible =3D "cirrus,ep9301-clk";

Is there a reg property? The driver grabs some syscon and then iomaps
it, so presumably there is a register range. Is it part of some other
hardware block? If so, can you make that device register sub-devices
with the auxiliary bus instead of using a syscon?

