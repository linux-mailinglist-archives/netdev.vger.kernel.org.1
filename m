Return-Path: <netdev+bounces-25486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B07743C0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DE42817A2
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B91CA00;
	Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569B198A6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD77A9E8C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:46:20 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40fcc91258fso39135361cf.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691516779; x=1692121579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFaCPHe174CVGEE8zH9Ahbm1V8fDZn/hHt9ByI29bII=;
        b=LLAuc9lPT9y7KA88WtNEI+tQco1CXaGOWy6PCbKgGXDK7qVadR6DxaEhkaBuXS1Du/
         aW5gk8YcSlokO3BCowzJQTPbwov1HYKwsKAoA5Kku5B1AZbHSxAVR90VOysgj1xgqvfW
         7p4O0SwEEIf2Jhr+k9tXfL8WV2Tv0Inem6A5SqMcbuy2AQuUubaNG71TQz9wTvHyqb2m
         x9sRdNd0NZLMcPNegA1NjozTmaH/4zenIC6smN3+xJZSmcFOFUwHdy/H9bKjtB/snE8N
         f7lwCnxHStfRbsYwiqxnOUYCYEuG8XWF4ER+GTUNOw7D9umn80xk9xstq9fYg3lSNVMx
         aPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516779; x=1692121579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFaCPHe174CVGEE8zH9Ahbm1V8fDZn/hHt9ByI29bII=;
        b=Jb9C6aP/W7I6NiyOyZBZkI6xmfXGSyONT0O+ugumLgg8kunQn75IjaIxRKsAjgd5kB
         LpU4fLK7B2Etj8e5XbXpNvOLW5SP2eYi/HMuZ3rktAN2ZdnCKv309PD9OLFrcOToOggy
         aqNyWU1NLN/S2VgX7Lvn6Dnu98oWsH7WPOvtCyIMUvThU5RjDteVN4m+Ev1fawXSHTK1
         2Lrb2R83PNSXQWiB3Be8Zm7ApF4VqlLZp0mVC/r6bEXUJyamKYh3VxwLznTR0qfiJe5Q
         DSkMbKtqDo/zpUf4DNZMfr8dy3E2CT973L+ascl4zvCa1B82sXwPHCV2fSDf3on7xf8u
         aL/g==
X-Gm-Message-State: AOJu0YzaeX+IMa1Xhpi4iBFOZjIrf5a4uIzT10WODTX28UPgjBYPGBPU
	dZg58td4mabjzFyOj5FVlwLSoq1twY4TJFbnnOxTQ7CzdS7b1luDi+kcrA==
X-Google-Smtp-Source: AGHT+IHJBjMCQdov9YPeDDL3pj/hzheBYljv6pXkkWjpc+VqMX3zeR6MAG9XffwSYmTvNmQRvGVPCfEVk5oblz/k9hQ=
X-Received: by 2002:a67:d095:0:b0:444:e9a0:13f7 with SMTP id
 s21-20020a67d095000000b00444e9a013f7mr5544633vsi.5.1691482400513; Tue, 08 Aug
 2023 01:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
In-Reply-To: <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Aug 2023 10:13:09 +0200
Message-ID: <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 9:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 07, 2023 at 09:31:00PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Two MACs may share MDIO lines to the PHYs. Let's allow that in the
> > stmmac driver by providing a new device-tree property allowing one MAC
> > node to reference the MDIO bus defined on a second MAC node.
>
> I don't understand why this is needed. phy-handle can point to a phy
> on any MDIO bus. So it is no problem for one MAC to point to the other
> MACs MDIO bus as is.
>
> You do sometimes get into ordering problems, especially if MAC0 is
> pointing to a PHY on MAC1 MDIO bus. But MAC0 should get a
> -EPROBE_DEFER, MAC1 then probes, creating its MDIO bus and the two
> PHYs on it, and then later MAC0 is probes again and is successful.
>
>      Andrew

Ok so upon some further investigation, the actual culprit is in stmmac
platform code - it always tries to register an MDIO bus - independent
of whether there is an actual mdio child node - unless the MAC is
marked explicitly as having a fixed-link.

When I fixed that, MAC1's probe is correctly deferred until MAC0 has
created the MDIO bus.

Even so, isn't it useful to actually reference the shared MDIO bus in some =
way?

If the schematics look something like this:

--------           -------
| MAC0 |--MDIO-----| PHY |
-------- |     |   -------
         |     |
-------- |     |   -------
| MAC1 |--     ----| PHY |
--------           -------

Then it would make sense to model it on the device tree?

Anyway, this can be discussed later, I will drop this for now and send
a fix for stmmac mdio code instead to get this upstream.

Bart

