Return-Path: <netdev+bounces-49686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216D7F3144
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0779BB216F6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570781B294;
	Tue, 21 Nov 2023 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6+Nk90D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79110D60
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 06:40:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a98517f3so7393095e87.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 06:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700577634; x=1701182434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dZuTwODiVqHA17RUelITZgUwRUupj6DZPEhIYss7YI4=;
        b=I6+Nk90DkvOp5DfsFigFoZByjCQnCXkW9qdt5I9nqzNH7j79RtVX8ve5DgMCZDNl1f
         lOHky1Fnb/AslR6l7mqu7LhjxXo/oUBCp1Oqh4CT7htuhbXc3IK6zMzJQcpKHNAACTJg
         yN1evNqEprGTFknfEOfLA9V4rYbnJzVjtB/XUvfFMA6yYdZg8KML3g268utxO/T+9v4o
         haarEDF0A4gYVTp7KJ45iVB/KpYG6ZI+keFfmFi+xwkC0ZRH4J8eMq5fYMggESLcn1at
         sEj0MZ3CAaoaTOJ+ySGh1CXMudtSsV4WIzbBs9CbRVjJIjYkz68dvPN71yUITjUiaow7
         EekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577634; x=1701182434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZuTwODiVqHA17RUelITZgUwRUupj6DZPEhIYss7YI4=;
        b=tGMZmRYLeLzwzPXnH0sBcMUSCw2vfo85IT2a2pIfJf2oDv1MMC63TPGDOzKgSXInE4
         1dvx88tjMpLoUrntGqPFP54wDE+5l0RoW4PsHARYrbPrrH528c7/LEaKQeXnxdYcdtjg
         yrpR/xpJTuBzI1HK7RJ7Xg+eyplKRnjVseiaebIQJDEhJGriEIL6sWMJb03mtrVu3zIH
         rmmnUysqQBgrOqWaQ/ScZJfqvaLLnLhEVCHD2eMcnEpm3yWl4JWZsu9Tf06gmhQWPHnb
         vxtymdlCcHQx6zQQOz3ungq7quuAl5rvr/765t5zJYPYaAqA/i7Zye5aWT3vuRRolJYN
         9xeA==
X-Gm-Message-State: AOJu0YysozvfJuvTcuJc8LoMxdJ/fXYvChUCu1sTagzuM/XZHSPY3GA5
	nmjAUUhAOYMdthDMszYWw406mDwreLDiCQ3KTBQ=
X-Google-Smtp-Source: AGHT+IHX2p3wMTjV+qdYRNUCBK42Ek5iJI0bWz/2T69TjlrGpROxMlQag+YxPFHKZ/aidS1AsodGFwRxs0SmfJnijs4=
X-Received: by 2002:ac2:5a1e:0:b0:50a:756d:4105 with SMTP id
 q30-20020ac25a1e000000b0050a756d4105mr7958358lfn.12.1700577633402; Tue, 21
 Nov 2023 06:40:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117235140.1178-1-luizluca@gmail.com> <20231117235140.1178-3-luizluca@gmail.com>
 <9460eced-5a3b-41c0-b821-e327f6bd06c9@kernel.org> <20231120134818.e2k673xsjec5scy5@skbuf>
 <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
In-Reply-To: <b304af68-7ce1-49b5-ab62-5473970e618f@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 21 Nov 2023 11:40:21 -0300
Message-ID: <CAJq09z5nOnwtL_rOsmReimt+76uRreDiOW_+9r==YJXF4+2tYg@mail.gmail.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, linus.walleij@linaro.org, 
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

> > On Mon, Nov 20, 2023 at 10:20:13AM +0100, Krzysztof Kozlowski wrote:
> >> No, why do you need it? You should not need MODULE_ALIAS() in normal
> >> cases. If you need it, usually it means your device ID table is wrong
> >> (e.g. misses either entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is
> >> not a substitute for incomplete ID table.
> >>
> >> Entire abstraction/macro is pointless and make the code less readable.
> >
> > Are you saying that the line
> >
> > MODULE_DEVICE_TABLE(of, realtek_common_of_match);
> >
> > should be put in all of realtek-mdio.c, realtek-smi.c, rtl8365mb.c and
> > rtl8366rb.c, but not in realtek-common.c?
>
> Driver should use MODULE_DEVICE_TABLE() for the table not MODULE_ALIAS()
> for each entry. I don't judge where should it be put. I just dislike
> usage of aliases as a incomplete-substitute of proper table.

MODULE_ALIAS() is in use here because of its relation with modprobe,
not inside the kernel.
MODULE_DEVICE_TABLE is also in use but it does not seem to generate
any information usable by modprobe.

> >
> > There are 5 kernel modules involved, 2 for interfaces and 2 for switches.
> >
> > Even if the same OF device ID table could be used to load multiple
> > modules, I'm not sure
> > (a) how to avoid loading the interface driver which will not be used
> >     (SMI if it's a MDIO-connected switch, or MDIO if it's an SMI
> >     connected switch)
> > (b) how to ensure that the drivers are loaded in the right order, i.e.
> >     the switch drivers are loaded before the interface drivers
>
> I am sorry, I do not understand the problem. The MODULE_DEVICE_TABLE and
> MODULE_ALIAS create exactly the same behavior. How any of above would
> happen with table but not with alias having exactly the same compatibles?

Realtek switches can be managed through different interfaces. In the
current kernel implementation, there is an MDIO driver (realtek-mdio)
for switches connected to the MDIO bus, and a platform driver
implementing the SMI protocol (a simple GPIO bit-bang).

The actual switch logic is implemented in two different switch
family/variant modules: rtl8365mb and rtl8366 (currently only for
rtl8366rb). As of today, both Realtek interface modules directly
reference each switch variant symbol, creating a hard dependency and
forcing the interface module to load both switch family variants. Each
interface module provides the same compatible strings for both
variants, but I haven't investigated whether this is problematic or
not. It appears that there is no mechanism to autoload modules based
on compatible strings from the device tree, and each interface module
is a different type of driver.

This patch set accomplishes two things: it moves some shared code to a
new Realtek common module and changes the hard dependency between
interface and variant modules into a more dynamic relation. Each
variant module registers itself in realtek-common, and interface
modules look for the appropriate variant. However, as interface
modules do not directly depend on variant modules, they might not have
been loaded yet, causing the driver probe to fail.

The solution I opted for was to request the module during the
interface probe (similar to what happens with DSA tag modules),
triggering a userland "modprobe XXXX." Even without the variant module
loaded, we know the compatible string that matched the interface
driver. We can also have some extra info from match data, but I chose
to simply keep using the compatible string. The issue is how to get
the "XXXX" for modprobe. For DSA tags, module names are generated
according to a fixed rule based on the tag name. However, the switch
variants do not have a fixed relation between module name and switch
families (actually, there is not even a switch family name). I could
(and did in a previous RFC) use the match data to inform each module
name. However, it adds a non-obvious relation between the module name
(defined in Makefile) and a string in code. I was starting to
implement a lookup table to match compatible strings to their module
names when I realized that I was just mapping a string to a module
name, something like what module alias already does. That's when the
MODULE_ALIAS("<the compatible string>") was introduced.

After this discussion, I have some questions:

I'm declaring the of_device_id match table in realtek-common as it is
the same for both interfaces. I also moved MODULE_DEVICE_TABLE(of,
realtek_common_of_match) to realtek-common. Should I keep the
MODULE_DEVICE_TABLE() on each interface module (referencing the same
table), or is it okay to keep it in the realtek-common module? If I
need to move it to each interface module, can I reuse a shared
of_device_id match table declared in realtek-common?

If MODULE_ALIAS is not an acceptable solution, what would be the right
one? Go back to the static mapping between the compatible string and
the module name or is there a better solution?

Regards,

Luiz

