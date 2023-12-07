Return-Path: <netdev+bounces-54996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77E809234
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CF1C20959
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4050266;
	Thu,  7 Dec 2023 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKw4ai3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DECB1715
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 12:23:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso16450081fa.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 12:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701980583; x=1702585383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pDuSADVLpoQMP5PxroQPpBur1JJssHbSzpFJ1P/D71Y=;
        b=XKw4ai3jR00aFoBHiaLmfAMjxdF4SRc3yOi7ULqpsE5mShT75R1Gx+EVCYXhSGKFRd
         13KP8r37x0agHMYCEJBNoL6+gbTB3MYeBWrvA7dP3Zo6cdlCtEh93bCn+6r9DcWFVJxg
         dNNqpdAXTKaK3PpFnBdydaJ8gV+x24dvmtdZHvxabvAo8Vb/YwIwWjKbMhEGhhkCFH/P
         k8wTDBJXi8ro8ffHLW33hrPEBkDDkl4mhVcpHtG/39ZvrYvEab9LratBo2+kMVqWYSoc
         Uu6jNM80uVtY4aMPj2qztSaPzSI60wz+NEP9pbLfKmyiDN9tHiVTowvdozMAF+Dz4bao
         H54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980583; x=1702585383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDuSADVLpoQMP5PxroQPpBur1JJssHbSzpFJ1P/D71Y=;
        b=WcqiEzfVzXeglyCICC0+j2D0rQYR7hwm7sPtybvZ/H4gtXrGMWKiLCTiwq6C+M9TUL
         xTgXGKMw3pxuBsNhw5fsu1gKRX1uOATF+wgVRh+8KeXdfXOAwMo3Y5OaRdAIOVaw4lN/
         YIuRk4HvtvY9Ddt5lTXbPOj3pxQFc8pa6kLJTbMpa9z6uqqiUnZTOsFJyi5RqKOOsZR5
         YZK3T3r3KSrWAS13AnrMS03Uwktzq6/0guKyN5+la4hdU3+9px8fPdllBCOTlCXAhHPy
         51Cl76rLqdGoHTs/wUyVQLjvqEsOojYyVE5OvXrtvjLwm/TTO/X+5FRP9RVvPP8nxwWA
         FdxA==
X-Gm-Message-State: AOJu0YzN88qxDCdjM0ae519uJDnyDe+us6dxIIOQwgYhkK/cq4mOhXim
	miHsQKmhHzaBb0SDg4pAqay8yoIeF7AOrF5WBxc=
X-Google-Smtp-Source: AGHT+IEs3uPU+o3+4X1ZgRLE85TqZm8clsEp6fpg/xOKS0gQtU02+o1fpdDCbjoxYUjwShBre81sYoIXCOELslRqNhI=
X-Received: by 2002:a05:6512:3050:b0:50c:21d7:e1b2 with SMTP id
 b16-20020a056512305000b0050c21d7e1b2mr602094lfb.27.1701980583225; Thu, 07 Dec
 2023 12:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117235140.1178-3-luizluca@gmail.com> <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org>
 <20231120134818.e2k673xsjec5scy5@skbuf> <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org> <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com> <20231207170201.xq3it75hqqd6qnzj@skbuf>
In-Reply-To: <20231207170201.xq3it75hqqd6qnzj@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 7 Dec 2023 17:22:52 -0300
Message-ID: <CAJq09z4YzgWW8n2=yCSNtmOERAKHf-EuLqdMOk+B4dQe2DCwEw@mail.gmail.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> > I'm not sure if getting/putting a module is a problem or if I can
> > request it when missing. I would like some options on that specific
> > topic from the experts. It seems to happen in many places, even in DSA
> > tag code.
> >
> > I wouldn't say it will invariably require both interface modules to be
> > loaded. The dynamic load would be much simpler if variants request the
> > interface module as we only have two (at most 3 with a future
> > realtek-spi) modules. We would just need to call a
> > realtek_interface_get() and realtek_interface_put() on each respective
> > probe. The module names will be well-known with no issues with
> > module_alias.
> >
> > Thanks for your help, Alvin. I'll wait for a couple of more days for
> > others to manifest.
>
> I'm not an expert on this topic either, but Alvin's suggestion makes
> sense to have the switch variant drivers be both platform and MDIO
> device drivers, and call symbols exported by the interface drivers as
> needed.

Yes, it does. It looks like the driver was upside down.

> If you are able to make the variant driver depend on just the interface
> driver in use based on some request_module() calls, I don't think that
> will be a problem with Krzysztof either, since he just said to not
> duplicate the MODULE_DEVICE_TABLE() functionality.

The interface modules are quite small, multiple times smaller than the
variant module. It wasn't worth it to load them on demand as the code
to handle that might be close to the interface module size. Indeed, as
we'll have a common module, I think the best solution would be to
merge both interfaces into the common module. It would make things
much simpler: two variant/families modules that require a single
common module. It is also closer to what we see in other DSA drivers.

> I think it's down to prototyping something and seeing what are the pros
> and cons.

I already did that and I'm finishing some tests before submitting it.
It looks like it fits nicely. I avoided some struct refactoring Alvim
suggested to keep the change as small as possible but I went a little
further migrating the user mdio driver to common and use it for both
interfaces.

Regards,

Luiz

