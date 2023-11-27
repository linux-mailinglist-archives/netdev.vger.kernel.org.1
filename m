Return-Path: <netdev+bounces-51481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7777FAD6C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 23:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7251228175C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060448CD4;
	Mon, 27 Nov 2023 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoughhNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DC1FE5
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:24:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso15568e87.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 14:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701123868; x=1701728668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6VLrEUvqHC0YBPwbIr6G0BEQgOpSxxPm3byO5bHjsjw=;
        b=HoughhNrKmoY7GrvfvgRDFN74XE+IA9HWCQWreAlocXqfN1eVqGukGrrQSC07CQAk7
         z5ANHYpzZ+pI7Po78Z8Jhfpgk64Z+cNvw0XYwcT9PDGDtTLkZbbZC2oisP5S4R1P26DA
         vlhzCl79vxDHN2+JdAKAumyINLqVlmqcAGqsxD+lImOYIhYuUh0QBVL2u752QIvJSv75
         JFkoqLP6eXJmM216yp7pOPub35dNq0Y89JwKbpJErVf3qqAasRAoMIFY+vxy5Cd/B1ga
         e39WPtuXNUbcd86WJC3c7pg7iZ2CyKUWQlIHWgfml7yaM/jsuXKam9diZpfkEGLLhP2v
         KvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123868; x=1701728668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VLrEUvqHC0YBPwbIr6G0BEQgOpSxxPm3byO5bHjsjw=;
        b=mXIRWn8mhrnqvB8DMPC4ePW20ol9Mg05lE6vXfBOUzv3R1BJjWtuHhMJImF7Igcj37
         JsaCPbJ+tRwZ702nh8HogBnQM3pJEahyl8CDG5UvzdPWR/1iDSjK0yYNxqHunlJopJVt
         V42/Z+AigUQtHlUom1cNqI5y+cdHVPXoVmCbEazGwQQlE2ZeY9X0BYZky+zhsiM8gKIQ
         pWp186dNGSri7H4SrJ7irrIWcm/zGQSf035Mf9NmUUizzppRsiM/KA3c5FYR1wEVVdIk
         p3ppS0fphFmNItAhzAwJ6xZQkEbCuiAguO8wLqLkcM69wePFRwU914Bq+8FMjvmgoTAj
         xmjw==
X-Gm-Message-State: AOJu0YxseMA4460+xHX+7eav9JrQC5vkBTuKrmT+k7H1GtI06rC2Y2Hq
	tYwysY44Wd7dpur958shgId0R6s3w5wmjFnurpA=
X-Google-Smtp-Source: AGHT+IFtl4rzEkwogQ2yBM0isaoao/8/3oVPveCVna6Xco3l9EhmrDAs805nFzGq+aPf54Gkrpe5her/Yyj1bm7OIKc=
X-Received: by 2002:a05:6512:400d:b0:503:38fe:4590 with SMTP id
 br13-20020a056512400d00b0050338fe4590mr9359020lfb.60.1701123867396; Mon, 27
 Nov 2023 14:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117235140.1178-1-luizluca@gmail.com> <20231117235140.1178-3-luizluca@gmail.com>
 <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org> <20231120134818.e2k673xsjec5scy5@skbuf>
 <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org> <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org> <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com> <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
In-Reply-To: <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 27 Nov 2023 19:24:16 -0300
Message-ID: <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	Vladimir Oltean <olteanv@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alvin,

> > 4) Introduce a realtek-common module, a module for each interface,
> > both repeating the compatible strings for all families, and expect the
> > family module to be already loaded.
>
> The kernel should be able to autoload. Skip.
>
> > 5) Introduce a realtek-common module, a module for each interface,
> > both repeating the compatible strings for all families, and request
> > the family module to be loaded (the last patch in this series).
>
> I had reservations before about this approach and I think I am not
> the only one. Let's consider the other options.

I'm not sure if getting/putting a module is a problem or if I can
request it when missing. I would like some options on that specific
topic from the experts. It seems to happen in many places, even in DSA
tag code.

> > 6) Introduce a realtek-common module, merging everything from
> > realtek-smi and realtek-mdio but the driver declarations and implement
> > each family as a single module that works both as a platform and an
> > mdio driver.
> > 7) Introduce a realtek-common module, merging everything from
> > realtek-smi and realtek-mdio but the driver declarations and create
> > two modules for each family as real drivers, repeating the compatible
> > strings on each family (e.g., {rtl8366rb, rtl8365mb}_{smi,mdio}.ko).
>
> Yeah, something like this. Roughly I think we want:

Just to be sure, you are suggesting something like 6), not 7), right?

> - generic boilerplate probe/remove and regmap setup code in
>   realtek-common.c
> - interface code in realtek-{smi,mdio}.c
> - chip variant code in rtl8365mb.c and rtl8366rb.c
>
> The module dependencies only need to go upwards, i.e.:
>
>        realtek-common
>          ^       ^
>          |       |  use symbols realtek_common_probe()
>          |       |              realtek_common_remove()
>          |       |
>  realtek-smi   realtek-mdio
>       ^   ^     ^   ^
>       |   |     |   |  use symbols realtek_mdio_probe()
>       |    \   /    |              realtek_mdio_remove()
>       |     \ /     |
>       |      X      |  or symbols realtek_smi_probe()
>       |     / \     |             realtek_smi_remove()
>       |    /   \    |
>       |   /     \   |  or both
>       |  /       \  |
>   rtl8365mb     rtl8366rb

It makes sense to turn rtl8365mb/rtl8366rb into both a platform and an
MDIO driver, similar to the merge between realtek-mdio/realtek-smi
Vladmir suggested before, with a custom module_init/exit doing the
job. I didn't invest too much time thinking about how data structures
would fit in this new model. realtek_priv would probably be allocated
by the variant modules with little left for interface to probe/setup.

> The setup_interface function pointer is only needed for SMI, and
> currently the chip interface drivers are the ones calling it. It is kind
> of ugly that this gets passed all the way up, copied into realtek_priv,
> and then called all the way down again... there is probably a more
> elegant solution. I am mainly trying to illustrate how to handle the
> module knot you are trying to unpick.

The "realtek_smi_setup_mdio()" used in setup_interface isn't really
necessary (like it happens in realtek-mdio). It could be used (or not)
by both interfaces. The "realtek,smi-mdio" compatible string is
misleading, indicating it might be something specific to the SMI
interface HW while it is just how the driver was implemented. A
"realtek,slave_mdio" or "realtek,user_mii" would be better.

I believe the strange relations between realtek interface modules and
variants tend to go away if we put things in the right place. The
probe will happen mostly in common and variant modules, leaving just a
minor probe job for the interface module called from the variant
driver (using pre/post approach) or from common (using a
realtek_interface_ops). Anyway, I'll leave the discussion of who calls
who after we settle the role of each module.

The most likely proposal is to convert both variant modules from a
subdriver code into a both platform(for SMI) and mdio driver. Probe
will use both realtek_<interface>_probe() and realtek_common_probe()
when appropriated. Variants will call the interface and not the other
way around.

> > Solutions 1, 2, and 3 may use more resources than needed. My test
> > device, for example, cannot handle them. Solution 7 is similar to the
> > examples I found in the kernel. Solutions 1 and 6 are the only ones
> > not repeating the same compatible strings in different modules, if
> > that's a problem.
>
> You will have noticed that with the above solution, the chip variant
> modules will invariably require both interface modules to be loaded if
> the kernel is built with both REALTEK_SMI and REALTEK_MDIO. I hope that
> your resource-constrained system has enough headroom to accommodate
> that. If not then I am afraid you might simply be out of luck.

I wouldn't say it will invariably require both interface modules to be
loaded. The dynamic load would be much simpler if variants request the
interface module as we only have two (at most 3 with a future
realtek-spi) modules. We would just need to call a
realtek_interface_get() and realtek_interface_put() on each respective
probe. The module names will be well-known with no issues with
module_alias.

Thanks for your help, Alvin. I'll wait for a couple of more days for
others to manifest.

Regards,

Luiz

