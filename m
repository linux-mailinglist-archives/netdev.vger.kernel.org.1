Return-Path: <netdev+bounces-45575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D587DE68D
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D774B20E22
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13B18E22;
	Wed,  1 Nov 2023 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAFF6cJ+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C221134B6
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:55:34 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53233110
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:55:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507975d34e8so132807e87.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698868531; x=1699473331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VOxunMHxAsStaiWEVeFBOXToL/YaB8picVEyKTPrus=;
        b=AAFF6cJ+erBl6NkQsmoBU/AOYyH60+PXjMKf4kBQ5OWnBdrAceOvH3e3zg5vb/M2Q2
         vfmiP4F9XwNvRhJaL9Gn18+4GWc6umX2VQYc15i6wrxD86blKJ6gQ/zTCW59v1wiaFnq
         3HW45/Sx4R0E73RSwxKKkfjwiU/CbdoY87GpVeHqYIogKw1v7gupouSDMmBeetPXpLae
         XAag55cpyM1dBBZsFf3kuNHGRj8kdoSBYqLJEOXP7TKJA3Emskui6C0jJVIIn+yUjpwm
         o3RryosBdjX4DYddCLxE9ntSfmSYY7GpptxEvSG8SOrQHbwZAn/oNsg4u4NkP4HOiweI
         Y9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698868531; x=1699473331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VOxunMHxAsStaiWEVeFBOXToL/YaB8picVEyKTPrus=;
        b=GW6gDRw6jNdzvvgy15fo7NeE472CzUN1nKiA/9/1MtDMOu4M4zkapk5dVKTQR4PcOV
         hi7uSkrm3kaP8Um7/W7csPvMfU/PcYWA+F5pxnUUGRJng3gXa3XqEmb8lPIxYIta/kjt
         emiUEpXewcIsrJ1sSMdnHjXjENSWLHI0v6veWdbS6PCSSzgS1vibmb1BGMmqbxMyw8C1
         vmiYib7kHtmOmx0aVoKcNYo4Ps0KPLLt6SCydfPZVa1PzGs/Lo7I+LBvOpYTAEI7apuK
         7KDrOmNckupHdrB2US1ijWNv8SFGquxhg1POOaqGO6uiWe2L28ULBXllzneO8UEnvftj
         dyzA==
X-Gm-Message-State: AOJu0Yz9hczLSdVgsw5Hh6Gv5ve9QBCiw9/4a/f9d4pyhTLqc3zIUZVV
	Y8IW92TooyijZ2OEn1IKNVkHOxdUNFeKIEmOobQ=
X-Google-Smtp-Source: AGHT+IHOiZCZDGRuPqKgAPGcrzghdaR2JeNmyR2ZNzP099EEftlRBfHqo1kcdzIHeUmkBxbZLztFXqyC1vmFJk9UfJM=
X-Received: by 2002:a05:6512:e95:b0:509:4405:d5a8 with SMTP id
 bi21-20020a0565120e9500b005094405d5a8mr1451677lfb.68.1698868531216; Wed, 01
 Nov 2023 12:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf> <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
In-Reply-To: <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 1 Nov 2023 16:55:19 -0300
Message-ID: <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> realtek-mdio is an MDIO driver while realtek-smi is a platform driver
> implementing a bitbang protocol. They might never be used together in
> a system to share RAM and not even installed together in small
> systems. If I do need to share the code, I would just link it twice.
> Would something like this be acceptable?
>
> drivers/net/dsa/realtek/Makefile
> -obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o
> -obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o
> +obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o realtek_common.o
> +obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o realtek_common.o

Just a follow up.

It is not that simple to include a .c file into an existing single
file module. It looks like you need to rename the original file as all
linked objects must not conflict with the module name. The kernel
build seems to create a new object file for each module. Is there a
clearer way? I think #include a common .c file would not be
acceptable.

I tested your shared module suggestion. It is the clearest one but it
also increased the overall size quite a bit. Even linking two objects
seems to use the double of space used by the functions alone. These
are some values (mips)

drivers/net/dsa/realtek/realtek_common.o  5744  without exports
drivers/net/dsa/realtek/realtek_common.o 33472  exporting the two
reset functions (assert/deassert)

drivers/net/dsa/realtek/realtek-mdio.o   18756  without the reset
funcs (to be used as a module)
drivers/net/dsa/realtek/realtek-mdio.o   20480  including the
realtek_common.c (#include <realtek_common.c>)
drivers/net/dsa/realtek/realtek-mdio.o   22696  linking the realtek_common.o

drivers/net/dsa/realtek/realtek-smi.o    30712  without the reset
funcs (to be used as a module)
drivers/net/dsa/realtek/realtek-smi.o    34604  linking the realtek_common.o

drivers/net/dsa/realtek/realtek-mdio.ko  28800  without the reset
funcs (it will use realtek_common.ko)
drivers/net/dsa/realtek/realtek-mdio.ko  32736  linking the realtek_common.o

drivers/net/dsa/realtek/realtek-smi.ko   40708  without the reset
funcs (it will use realtek_common.ko)
drivers/net/dsa/realtek/realtek-smi.ko   44612  linking the realtek_common.o

In summary, we get about 1.5kb of code with the extra functions,
almost 4kb if we link a common object containing the functions and
33kb if we use a module for those two functions.

I can go with any option. I just need to know which one would be
accepted to update my patches.
1) keep duplicated functions on each file
2) share the code including the .c on both
3) share the code linking a common object in both modules (and
renaming existing .c files)
4) create a new module used by both modules.

The devices that would use this driver have very restricted storage
space. Every kbyte counts.

Regards,

Luiz

