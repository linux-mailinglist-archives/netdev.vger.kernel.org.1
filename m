Return-Path: <netdev+bounces-19425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFC75A99E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE2F281D88
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE2199F5;
	Thu, 20 Jul 2023 08:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CFA199F2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:54:24 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F926A6;
	Thu, 20 Jul 2023 01:54:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so724990a12.1;
        Thu, 20 Jul 2023 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689843261; x=1692435261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BGYd0XzLOZIaect1B8DLqJQBB8NGVA7ArI9KPRHwCuA=;
        b=R6F9AvgnvdC0oDU+DTR4MfnnL48BCbJgyhCk9A0VhVWOhqOQpe41/AATzBaPwXrlbp
         NiVoQ4an/IEe/zBQWtSt4j+0ECY7RSMDaQhEu0LpfpScWHmLaf5l2o7v0GzABUvd19s5
         w3jdfWKKI2Z7TETv8eOzBN9Q/hcD451Hvdx3NnYuVWduVN2kzLJ7Mi+gd7kIEYAdNLGx
         PfpKo5/5UeGO/gSzn2N0keUNKeCsk90RxfmW4xQ3nGSsJBlNdtDiyYfRTsLxuM+guq5h
         JAEcEamXP44sXSMwQx4SSiQZUZV6ASyXLRxNQClqiEF/jwHGMVw/ZkwvX6yxmHqpohoE
         Ggkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843261; x=1692435261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGYd0XzLOZIaect1B8DLqJQBB8NGVA7ArI9KPRHwCuA=;
        b=PGsOh5cyVsFDCJ9F86IunraxxFPJzqbz+HCETfFor46JupUBdghCd7ScvNA+o3/zEV
         Sf7kqVwIkqRNSIV3C2Jz6Z5A+MV70b/QAZj4c5QRjbpeOqYpknealYye7YdomL3phfcL
         s6qT8oLYaLRSp20KfPmzFWTlYypE5NNR5L+DaV78cvQbLDH3ftrYR2RDyKXV+pOiKbEc
         j/CgEhoPZF655Qx4atFhmAkrZEEQ60IBvM411bjLlYobYzGnFTe2CE5gh4Y6y70Wapss
         elOairquS19hKQ7Sbrsf5ztYxD25MJYBRO2czdZGxzuv+QIIhtKKpD1IyEBR1ShNv/gu
         7yoQ==
X-Gm-Message-State: ABy/qLbG6Hihp3ZiszXNb6mySFF6gKkZ+JJL0sHwnuTxn7+WPpuJ4M9f
	StmDqvT0ccXAQxE1bque6xA=
X-Google-Smtp-Source: APBJJlFMasg2dNIicMwfx1YyIyQvduddQCgLot96389m6Z9iDA5SQh0KK8JlI0qHyY43u+aGtpP/9g==
X-Received: by 2002:aa7:c504:0:b0:51e:10d8:e066 with SMTP id o4-20020aa7c504000000b0051e10d8e066mr1651697edq.24.1689843260572;
        Thu, 20 Jul 2023 01:54:20 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id f20-20020a50ee94000000b00521ce1f04b8sm443021edr.12.2023.07.20.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:54:20 -0700 (PDT)
Message-ID: <e4486050b95ad53ba9e1d6080c4b6de4b646dcdd.camel@gmail.com>
Subject: Re: [PATCH v3 13/42] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: nikita.shubin@maquefel.me, Hartley Sweeten
 <hsweeten@visionengravers.com>,  Lennert Buytenhek <kernel@wantstofly.org>,
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>,  Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Sebastian
 Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mark
 Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,  Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko
 <andy@kernel.org>,  Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen
 <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org,  dmaengine@vger.kernel.org,
 linux-mtd@lists.infradead.org,  linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org,  alsa-devel@alsa-project.org
Date: Thu, 20 Jul 2023 10:54:18 +0200
In-Reply-To: <20230605-ep93xx-v3-13-3d63a5f1103e@maquefel.me>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
	 <20230605-ep93xx-v3-13-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Nikita,

On Thu, 2023-07-20 at 14:29 +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add OF ID match table.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

--=20
Alexander Sverdlin.


