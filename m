Return-Path: <netdev+bounces-42165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B67CD70F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C78B2103F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDF15AC8;
	Wed, 18 Oct 2023 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/Pk8h49"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05014F8F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:53:16 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E5F9
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:53:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8628e54d4so30647957b3.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619193; x=1698223993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIfc9x+57+MR4MQsFxr/3D1qUh4GWaKbi6uC5iQj2KM=;
        b=A/Pk8h49ehZ29O0w0iKml7ynBA8zowwZ5tmiz45VAgsXWt7kmtGmzeQLBfhkHzocYl
         Krfv2TOEq2SVD/VItz5ABk6HxJbMYAFmI5NgVtu8e2f9RgaU5s7jlgzu9SMwYQOLxWAS
         qZxzejJDGQAomxCUjC+c/WlbPPjnrnBX9GwoRbM0oRAzJYgoKmhIJ/edzmtE4aYiUWgl
         FAp+pMvng8pSd6SIYe2AueMxTEYhSOyi3nXpbYUix38ROoX4JexPwxOnk1JP7IFWHIgT
         BTeuw3dZ3A3PBzYvmuDC/Z0RgtQOnTttCGN9mrOb+G7+VBRzuMmpanNXn+LX/K05Tsbc
         2hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619193; x=1698223993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIfc9x+57+MR4MQsFxr/3D1qUh4GWaKbi6uC5iQj2KM=;
        b=tzCKosUqegLiqJt7vEkT2bzNK1L0NJa+knP2QV9ZogoV7Pc19avK9ipQreVxd7nee5
         vPAepdXmKk2NhyU+XXGQ1I/PTAy22LFLAFlveuTjqUyuD+IClJ3wJGg0L/amEhIIB4Ty
         n32d1Re9+8wSCHOnboKadIAmCvKvjkmBNME7S868F0jwQAlFEpTGm7VKpiun/g2PEsvu
         3aJxsKkL+ceMu9G0O3elcj3Mo6ZxoSt+vaRqIiMJC2BhWSfWBBFxhDGEbQ4upAlHaD1n
         a4eK19mQHWJ/dlSRkWEJIkDxx9laIBXyfh6Q9qBJ/7W1kjUBOt+C76E7MBjaWjBTdZRR
         Rxfg==
X-Gm-Message-State: AOJu0YzfC/9HHC1Sov+S3j0xojSeLuRRW9kAmFRM65a42bvkgbtbitoz
	AOiUx0QEdvl4JK1MIGgFLuPnuGTylDo7NV4UHsDEjQ==
X-Google-Smtp-Source: AGHT+IFeFSERqZ0ts/x8xJld6sINEyqZb9YdNFdgX/IXWU45eqvj1p1KrrBezJyPl0/qLY0DPRMIhme6p1Fr7jMtf+o=
X-Received: by 2002:a05:690c:ed1:b0:5a7:cb5f:ee0a with SMTP id
 cs17-20020a05690c0ed100b005a7cb5fee0amr4033573ywb.17.1697619193088; Wed, 18
 Oct 2023 01:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
In-Reply-To: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Oct 2023 10:53:01 +0200
Message-ID: <CACRpkdaie8-0W+=9AD49KqyW+-Zrtkhs8BjHJCVDrkxF6hVAkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] dt-bindings: net: Child node schema cleanups
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	John Crispin <john@phrozen.org>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 11:44=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> This is a series of clean-ups related to ensuring that child node
> schemas are constrained to not allow undefined properties. Typically,
> that means just adding additionalProperties or unevaluatedProperties as
> appropriate. The DSA/switch schemas turned out to be a bit more
> involved, so there's some more fixes and a bit of restructuring in them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Oh this drives a truck through my Marvell binding work. Luckily it
also solves my most annoying problems so I will just rebase on this
and continue, all good!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

