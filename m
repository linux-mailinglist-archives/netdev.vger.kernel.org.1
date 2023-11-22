Return-Path: <netdev+bounces-50284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF87F53A1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465FF1C20380
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873E1C686;
	Wed, 22 Nov 2023 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/S4s/r4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26B10E4
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:44:58 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso314426e87.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693097; x=1701297897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LlcQa22/A/31/lDqd4zSOfgP1U3Gwyos/ffYp6hXWXg=;
        b=b/S4s/r46KwPfeiBFMgdlX2WBQ6t4Kml6p7v774ASxwulf1FfaiycJFrVClhMFGE+z
         GfBqWgT54HDKr4j9FtHa1r/wvglX9J3MrZokb7ZuPa6duB2qxPbzlha2rGdsxjXIFCX1
         QQaKiKUNhXBH18XTnknDJfir3pZOzBruT5Dwgg9mSlJwFLNz55nSyT7ETTrO/ylsMiX5
         d07QkHuslL99rWh/GR4O1c7ZOXxIDYKCeXteYa8b4EFZDI0fowuyXv3ARhaLmxYF124H
         D3972F8JBFqnx+KYIBqjnAvye/n2Y69c9jZVSzABtFq2nNJQWNVP1MVdZhcXfV/i2KFb
         pgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693097; x=1701297897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlcQa22/A/31/lDqd4zSOfgP1U3Gwyos/ffYp6hXWXg=;
        b=ktHIJ5bYCqTL+FCIAxOf2jdt+Bv2SlCO6u0fRwhb9DMQXgEM5RoqsClCL+dk6/gQnz
         QyoUfZC2nywdHkVBKAXOomSaO+Z2DSFoEJlSZy2c9K4sm3KR/h+j73lT4KxXuHtkLJOs
         E/tiXIyPwtIruCWSiAkaJDLjNq2GaCqWb7yP4BMED5r+T91o5HD/lIjH5J9ELb4m0OQ0
         4W7cxQbV6w1aKSVcQ1jnjatFzoCBEh7TZ6IpbS55K/gXg2wRLLEfe3afcZdxylSVvLFb
         qOaRfVUkAeD36h3jVa8Hixi0RdnPXOOj8i+spW3cYan6aLVgPa/Lput32RfBdQGm2ASw
         G/7Q==
X-Gm-Message-State: AOJu0YzC8PGEq/nsz5t7Lt9Wb6J0crXHyI/Uqm52uZziWz8fn4mh5yU+
	dPBU+4C2k0a8SGs614wQ4Nl/pU20FigIYrD6ofo=
X-Google-Smtp-Source: AGHT+IFi1dTxd34xFWv+pGJUjcFPCUTuyBnrR9uEKdeFr26YZ/Yt/rlA2g35fVUJJURufT0YnJAE7uunwwDsrFEXaKU=
X-Received: by 2002:ac2:4a9d:0:b0:507:a9b7:f071 with SMTP id
 l29-20020ac24a9d000000b00507a9b7f071mr2593796lfp.1.1700693096762; Wed, 22 Nov
 2023 14:44:56 -0800 (PST)
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
In-Reply-To: <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 22 Nov 2023 19:44:44 -0300
Message-ID: <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
To: Krzysztof Kozlowski <krzk@kernel.org>, linus.walleij@linaro.org, alsi@bang-olufsen.dk
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, andrew@lunn.ch, 
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On 21/11/2023 23:15, Krzysztof Kozlowski wrote:
> > How is this even related to the problem? Please respond with concise
> > messages.
> >
> >> the "XXXX" for modprobe. For DSA tags, module names are generated
> >> according to a fixed rule based on the tag name. However, the switch
> >> variants do not have a fixed relation between module name and switch
> >> families (actually, there is not even a switch family name). I could
> >> (and did in a previous RFC) use the match data to inform each module
> >> name. However, it adds a non-obvious relation between the module name
> >> (defined in Makefile) and a string in code. I was starting to
> >> implement a lookup table to match compatible strings to their module
> >> names when I realized that I was just mapping a string to a module
> >> name, something like what module alias already does. That's when the
> >> MODULE_ALIAS("<the compatible string>") was introduced.
> >>
> >> After this discussion, I have some questions:
> >>
> >> I'm declaring the of_device_id match table in realtek-common as it is
> >> the same for both interfaces. I also moved MODULE_DEVICE_TABLE(of,
> >> realtek_common_of_match) to realtek-common. Should I keep the
> >> MODULE_DEVICE_TABLE() on each interface module (referencing the same
> >> table), or is it okay to keep it in the realtek-common module? If I
> >
> > Why would you have the same compatible entries in different modules? You
> > do understand that device node will become populated on first bind (bind
> > of the first device)?
> >
> >> need to move it to each interface module, can I reuse a shared
> >> of_device_id match table declared in realtek-common?
> >>
> >> If MODULE_ALIAS is not an acceptable solution, what would be the right
> >> one? Go back to the static mapping between the compatible string and
> >> the module name or is there a better solution?
>
> Probably the solution is to make the design the same as for all other
> complex drivers supporting more than one bus. If your ID table is
> defined in modules A and B, then their loading should not depend on
> aliases put in some additional "common" module. We solved this many
> times for devices residing on multiple buses (e.g. I2C and SPI), so why
> this has to be done in reverse order?
>
> If you ask what would be the acceptable solution, then my answer is: do
> the same as for most of other drivers, do not reinvent stuff like
> putting same ID table or module alias in two modules. The table is
> defined only once in each driver being loaded on uevent. From that
> driver you probe whatever device you have, including calling any common
> code, subprobes, subvariants etc.

Thank you, Krzysztof. I didn't design the driver in question; I was
just trying to cooperate.

Linus, Alvin, these are originally your work. I might have
misunderstood something and would appreciate some help in this
discussion.

I noticed that drivers like bmp280, inv_mpu6050, and adxl345 share a
common core with two interface drivers, both declaring the same
compatible strings. Is it an issue to have the same compatible string
in different modules? Is there a better reference to follow?

In realtek DSA drivers, the "interface" modules (realtek-smi and
realtek-mdio) are the actual drivers, containing compatible strings.
The subdriver/variant/family modules are just the switch logic with no
driver declaration. Currently, all subdrivers are loaded, which might
not be necessary as a device may not use two different realtek switch
families. Ideally, only one should be loaded. Can we request a module
at runtime, and is it acceptable to use MODULE_ALIAS() for a
"non-driver module" to make that easier?

The driver works without the module alias/request if it was loaded
before the interface driver. I aim to make it work in more scenarios.
These drivers are for embedded systems, so handling uevents might not
be feasible. I used the compatible string to avoid creating a new
string for the family name, but I could use anything else like
"rtl8366rb" only when the module name does not match the model used by
the compatible string. I didn't expect it to be used by anything
monitoring uevents.

For the driver structure, we have a few options:

1) Merge everything into a single realtek-switch, declaring the
compatible strings once and implementing it as both a platform and an
mdio driver.
2) Have a module for each interface (realtek-smi and realtek-mdio),
both repeating the compatible strings for all families, and load the
family as an interface dependency (the current approach).
3) Introduce a realtek-common module, a module for each interface,
both repeating the compatible strings for all families, and load the
family as an interface dependency (the first patch in this series).
4) Introduce a realtek-common module, a module for each interface,
both repeating the compatible strings for all families, and expect the
family module to be already loaded.
5) Introduce a realtek-common module, a module for each interface,
both repeating the compatible strings for all families, and request
the family module to be loaded (the last patch in this series).
6) Introduce a realtek-common module, merging everything from
realtek-smi and realtek-mdio but the driver declarations and implement
each family as a single module that works both as a platform and an
mdio driver.
7) Introduce a realtek-common module, merging everything from
realtek-smi and realtek-mdio but the driver declarations and create
two modules for each family as real drivers, repeating the compatible
strings on each family (e.g., {rtl8366rb, rtl8365mb}_{smi,mdio}.ko).

Solutions 1, 2, and 3 may use more resources than needed. My test
device, for example, cannot handle them. Solution 7 is similar to the
examples I found in the kernel. Solutions 1 and 6 are the only ones
not repeating the same compatible strings in different modules, if
that's a problem.

Regards,

Luiz

