Return-Path: <netdev+bounces-15051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45639745715
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F160A280C8E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F017E2;
	Mon,  3 Jul 2023 08:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144215AB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:14:18 +0000 (UTC)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487091
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:14:17 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-45739737afcso1025148e0c.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688372056; x=1690964056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11QJYwMbaUBpF9NueY3t6DsMt9/06w7p8RRvTfLIaJc=;
        b=L0Xoku72iyScuyAAlvdURXBApKe96vcZyauApjEXYrGVlSdQ5+Noqx/dJGtVL5x6q/
         jlFR5a9BhO9sA8f3jeglFFz63W5kpnijEXV3GbujV4lA4VrnyUUly7d3Wcix3txlUZKX
         0zTnULX0ieClGA2akWPTDF84ad2rXwBO7fEXhu1OYcHAAKgyVmkRs6hX/zxDaek+K+yy
         +Dq303IKCVITitnmnDhFbe5F+dSDTjXUpTQlniD7u22PH7eeed9b8JO4qs6ZdKwCYj/I
         dMxjHx7kBRx/dGnktAFbMiPelHl/QS1H0Ujo5z344HSwUz0dNoig8gIxg/cBlzWUnRon
         rbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372056; x=1690964056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11QJYwMbaUBpF9NueY3t6DsMt9/06w7p8RRvTfLIaJc=;
        b=eGoCHM0UugXDLri2yGhOZlVJ9WrlK8I2EyS35/l1QOedJB0068M5bPs6sWIkSuqm3N
         dzSqoJsgCh8hClylnJEPLDryLfzplCJqG2c+5WYUUluOd5Xq6SrhedI5El/bGOAGZJLO
         cIk4PFLuNazjwb+KAepx4sIe0Drf0eLthXJm+c7YXrn/hZPFy5NdLUDaRZ9KJXW10ry7
         BIQXxand4yuFObPNZMhDWINcTxD/Dth4Ppqs0UGT5uzHCZlJgdZScFDsoFL+DJ3rY4g2
         4koc0BQNv8V09WkrylPxbEugYpOQ6WmTso37jIynNXPQ9zGe8ux8p5LGk5vCcNcp6g8z
         qNwQ==
X-Gm-Message-State: ABy/qLb0+TTnmZicFPtf9Ij2/dzdjRYSFrX0bCAbBiu4WkTc6PNKzn3v
	MvBrDvfyx8/nhTbOGZ++YjN8teQv3AD/fNTQiuxtVg==
X-Google-Smtp-Source: APBJJlGUXmmzazOU3H2rwPItzzs5yY59Pr2doU3bzs7pqr02Nwa0JTfP80SKVHXrdbTVZhHGNnsVQtkzPqxhjzQX+Tw=
X-Received: by 2002:a1f:c1d0:0:b0:471:5939:f4f2 with SMTP id
 r199-20020a1fc1d0000000b004715939f4f2mr3056599vkf.8.1688372056011; Mon, 03
 Jul 2023 01:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-11-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-11-fb6ab3dea87c@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Jul 2023 10:14:04 +0200
Message-ID: <CAMRc=McTEPt_gb5HX98khmxvQDX-VQQ62uBF=p4dr_QqouL0kQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] dt-bindings: gpio: gpio_oxnas: remove obsolete bindings
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-oxnas@groups.io, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 6:58=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 gpio bindings.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

