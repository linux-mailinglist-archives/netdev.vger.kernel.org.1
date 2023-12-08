Return-Path: <netdev+bounces-55152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E080997C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAD42821C0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F617FF;
	Fri,  8 Dec 2023 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV3bBVdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E06171E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:47:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so1718166e87.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 18:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702003618; x=1702608418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tEtf2YgUgEwdwnt/GQcXAgJlw3ccfgk9p2/Tj7cEBKA=;
        b=lV3bBVdVZjie+7T4oge76GJTzEx86JuNfkTz/HksW7VxM0+bEXHy2xpELRq81pgRgn
         cNXZpAx0m7J73sqnrmenTNOnMZmcsrDeFg9ipGZJnCVqKvBgGbhKJ0g6JJ1yLkIkj269
         byhA+iqdYXqJOfYhoNM6rzD7TVnT1gvh/LMP5XE9sfsafQThSEUZOqfa4wIghiPsiqqY
         TRzCnDgaPf9Rpz8cQYAX3NZ1DZlbcXzx9iPScWnqNzAOG1Zbz4Yg8uJ2+/TiLccJJo/2
         NULUOWkVpNxahpw1rYT/Yjcq+hj1tC5wr/gvHnmnC/D1fnruHy5TnA0qAYYQoFKmNWVE
         Nm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702003618; x=1702608418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEtf2YgUgEwdwnt/GQcXAgJlw3ccfgk9p2/Tj7cEBKA=;
        b=rc8JZ8Du2sQW41UCmAk3BH6uvs16fs0DMQtDcRIHfGD1QbWGXKTiZe8VrDjgDVvDRB
         Y6yvUbvQP8F9txsgaAdczp8GrjMXUg/ZRWfOajGfGymKVsZlE1apsLnEJoV309RscdoV
         gjssmJTeHoVYckEM/ZNadSZ78eVq39d3lpfSzR/jbg+U6ZJRRDsJZC+BTW+a2rUJKxsN
         lhKPwz2D1UG+A7MsZFgNRtDocbhYNA9IykTwod7884zyfGsvt9+gr0f2cACjv4Kem4qA
         kP3xIACmAbwdGgwsVa5BpCVhafpDRLqlW08JfyvPo1gl/j4H9wn6wfMRAWQNNzzCQR/h
         gkpw==
X-Gm-Message-State: AOJu0YwjLXOTsTkxbekU59jfmsYuYYDQPBCRfNvg2MlS6p4Kju4l9ujA
	11OA2AgcwrLoCFHr9n6w6slk07FOTYRJUovGpiM=
X-Google-Smtp-Source: AGHT+IEW2oxEqStEQUra6TuPHCzx6Jo/+gICcZXoMJ6qc4XlPzCG7akMVXMOOid6jRFdr0G3S3mDdyX/FI4qTKLCYsE=
X-Received: by 2002:a05:6512:60b:b0:50c:44:919e with SMTP id
 b11-20020a056512060b00b0050c0044919emr1927382lfe.108.1702003617952; Thu, 07
 Dec 2023 18:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120134818.e2k673xsjec5scy5@skbuf> <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
 <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
 <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org> <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>
 <20231207171941.dhgch5fs6mmke7v7@skbuf> <CAJq09z7j_gNbUcYDWXjzUNAXat-+EyryFJFEqpVG-jPcY4ZmmQ@mail.gmail.com>
 <20231207223143.doivjphfgs4sfvx6@skbuf>
In-Reply-To: <20231207223143.doivjphfgs4sfvx6@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 7 Dec 2023 23:46:46 -0300
Message-ID: <CAJq09z70hfygcB5LL3Rp9GQ0180mTJauH6qVeAPqm1zO4HiAAQ@mail.gmail.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > We discussed something about that in the past:
> >
> > https://lkml.kernel.org/netdev/20220630200423.tieprdu5fpabflj7@bang-olufsen.dk/T/#m04e6cf7d0c1f18b02c2bf40266ada915b1f02f3d
> >
> > The code is able to handle only a single node and binding docs say it
> > should be named "mdio". The compatible string wasn't a requirement
> > since the beginning and I don't think it is worth it to rename the
> > compatible string. I suggest we simply switch to
> > of_get_child_by_name() and look for a node named "mdio". If that node
> > is not found, we can still look for the old compatible string
> > (backwards compatibility) and probably warn the "user" (targeting not
> > the end-user but the one creating the DT for a new device).
> >
> > I don't know how to handle the binding docs as the compatible string
> > is still a requirement for older kernel versions. Is it ok to update
> > the device-tree bindings docs in such a way it would break old
> > drivers? Or should we keep it there until the last LTS kernel
> > requiring it reaches EOL? As device-tree bindings docs should not
> > consider how the driver was implemented, I think it would be strange
> > to have a note like "required by kernel up to 6.x".
> >
> > Regards,
> >
> > Luiz
>
> And did you ever answer this question?
>
> "And why do you even need to remove the compatible string from the MDIO
> node, can't you just ignore it, does it bother you in any way?"
>
> I'm very confused as to what you're after.

The device-tree bindings should delineate the hardware characteristics
rather than specifying the implementation details of a particular
driver. The requirement of an "mdio" node with a compatible string
such as "realtek,smi-mdio" may be misleading, implying a potential
correlation between the host-switch interface (SMI, SPI, or MDIO) and
a specific user MDIO it describes. It's important to note that how we
describe the user mdio could vary for other future switch families,
but not with a distinct management interface.

I am currently conducting tests using the same user MDIO driver for
both realtek-smi and realtek-mdio. However, it's noteworthy that
unlike realtek-smi, the current user MDIO for realtek-mdio does not
require a compatible string; only a node named "mdio". Realtek-mdio is
presently utilizing the generic DSA user MDIO, but you mentioned it's
not considered a "core functionality." I assume this implies I
shouldn't depend on it. That's the reason for my switch to the
existing user MDIO driver from realtek-smi.

Regarding the absence of a compatible string for realtek-mdio, we have
a few options: introducing a new compatible string exclusively for
realtek-mdio, such as "realtek,mdio-mdio"; creating a new generic one
for both interfaces like "realtek,user-mdio" or "rtl836x-user-mdio";
or simply ignore the compatible string, as you suggested. However, if
I opt to ignore it, I presume I should retrieve that node solely based
on the node name. That's what I'm after. Is my understanding correct?

I'll post a new series that is still compatible both with old HW
descriptions and the device-tree bindings. In that way, I'll not touch
the docs. However, given that the compatible string is unnecessary to
describe the hardware, and after we modify the code to disregard it,
it is awkward for the binding documentation to request a compatible
string that serves no purpose. Shouldn't we consider updating this
requirement at some point?

Regards,

Luiz

