Return-Path: <netdev+bounces-45736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2E7DF484
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C72B2117A
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968919BC2;
	Thu,  2 Nov 2023 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ3YFMKC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6E1BDC6
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:04:19 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE831134
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 07:04:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso146309566b.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 07:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933853; x=1699538653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5EJIoq2bDZmEvNsejkgU0daQGsLajwd1Zhwe2psAIY=;
        b=bJ3YFMKChIZPi3S7pHe0BGSzQwZrHIFPQ7tMjF+E9ONM5VG3qBLHOcSvKR41V1JJIY
         ZnEPVW5nUabO1QpFRQcPLbKVWXM8qdtWyXrvNWMWdHiX4LFIIYbyJJWQei6KEdq82Eht
         S8pjYA21ZGnN+4Dv4/xlzJG3oDT93wPTU24/q745Qu/+idUuP8UrGgZJbW6D/LDrpAts
         IAQpTlyb5gwW4iFq6QO0CC4s3uGdbKzXtpd8O2ZG6OsP+ktgixAr529oE43Vnyq5y0vV
         vZMrvrtdQjzELlaScps1Te9AFH3UWQa1auKoQa2/v9u1B4cbkwhNVAj3kNMmbiMWEBPC
         lLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933853; x=1699538653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5EJIoq2bDZmEvNsejkgU0daQGsLajwd1Zhwe2psAIY=;
        b=txBjOpLvXWC+An64Weg7KrS+T8kVu42yvUQzg2i3Ox7kTyhLA4/hQTual5VZKMK4yp
         7eRPpun/3voxlix8uIuKmY3T/jHe1K+F9cJbtqh4y8d43SyXLS4QmbwFkfgOaN8BdjQl
         EIuvUYdcl03+NwrpT0ebmmaOyEXxZai5mDAxi2TBIBGFvT9g4GaYl14BjNkhZr1GAxrp
         1NcArJHCF42lzcvglVdHH9zuVe+2IQUlhKuCugY1ilR7CXAuv1O3QA+T+tzFc09N4Ukn
         If/lgcyxUdiDhTR4Ec56iSvEq1RPjGoj24t6dbI8t6i8tnTxqNl0U3HevbyotIzFbcvj
         K+dA==
X-Gm-Message-State: AOJu0YziG/Adk/lHb5FGOJgovoHcgN2H3B4snXJAhX9I86pVcmzfPBAH
	vSFxPOZTuNqyWoX4g9DH95awnHWQndcWIQ==
X-Google-Smtp-Source: AGHT+IEiUHNZfjaUczZ72FtIOYZpSddsQmwgW4+Uyv0QLBoWhC/rLTsKP1f1j00FHF7ZAyt2F0PfLw==
X-Received: by 2002:a17:906:da87:b0:9b7:37de:601a with SMTP id xh7-20020a170906da8700b009b737de601amr4577089ejb.49.1698933853018;
        Thu, 02 Nov 2023 07:04:13 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906359500b009b97d9ae329sm1172707ejb.198.2023.11.02.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:04:12 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:04:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzk+dt@kernel.org, arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20231102140410.ohfp2r7yiuw5gsps@skbuf>
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
 <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf>
 <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>

On Wed, Nov 01, 2023 at 04:55:19PM -0300, Luiz Angelo Daros de Luca wrote:
> Hi Vladimir,
> 
> > realtek-mdio is an MDIO driver while realtek-smi is a platform driver
> > implementing a bitbang protocol. They might never be used together in
> > a system to share RAM and not even installed together in small
> > systems. If I do need to share the code, I would just link it twice.
> > Would something like this be acceptable?
> >
> > drivers/net/dsa/realtek/Makefile
> > -obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o
> > -obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o
> > +obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     += realtek-mdio.o realtek_common.o
> > +obj-$(CONFIG_NET_DSA_REALTEK_SMI)      += realtek-smi.o realtek_common.o

You cannot link realtek_common.o into multiple .ko files. It generates
build warnings and it is being phased out.
https://patchwork.kernel.org/project/netdevbpf/cover/20221119225650.1044591-1-alobakin@pm.me/

> Just a follow up.
> 
> It is not that simple to include a .c file into an existing single
> file module. It looks like you need to rename the original file as all
> linked objects must not conflict with the module name. The kernel
> build seems to create a new object file for each module. Is there a
> clearer way? I think #include a common .c file would not be
> acceptable.
> 
> I tested your shared module suggestion. It is the clearest one but it
> also increased the overall size quite a bit. Even linking two objects
> seems to use the double of space used by the functions alone. These
> are some values (mips)
> 
> drivers/net/dsa/realtek/realtek_common.o  5744  without exports
> drivers/net/dsa/realtek/realtek_common.o 33472  exporting the two reset functions (assert/deassert)
> 
> drivers/net/dsa/realtek/realtek-mdio.o   18756  without the reset funcs (to be used as a module)
> drivers/net/dsa/realtek/realtek-mdio.o   20480  including the realtek_common.c (#include <realtek_common.c>)
> drivers/net/dsa/realtek/realtek-mdio.o   22696  linking the realtek_common.o
> 
> drivers/net/dsa/realtek/realtek-smi.o    30712  without the reset funcs (to be used as a module)
> drivers/net/dsa/realtek/realtek-smi.o    34604  linking the realtek_common.o
> 
> drivers/net/dsa/realtek/realtek-mdio.ko  28800  without the reset funcs (it will use realtek_common.ko)
> drivers/net/dsa/realtek/realtek-mdio.ko  32736  linking the realtek_common.o
> 
> drivers/net/dsa/realtek/realtek-smi.ko   40708  without the reset funcs (it will use realtek_common.ko)
> drivers/net/dsa/realtek/realtek-smi.ko   44612  linking the realtek_common.o
> 
> In summary, we get about 1.5kb of code with the extra functions,
> almost 4kb if we link a common object containing the functions and
> 33kb if we use a module for those two functions.
> 
> I can go with any option. I just need to know which one would be
> accepted to update my patches.
> 1) keep duplicated functions on each file

Disadvantage: need to update the same functions twice, it becomes
possible for them to diverge, increases maintenance difficulty.

> 2) share the code including the .c on both

Including a .c file with a preprocessor #include is fragile, has to be
placed very carefully, etc. So it is also a time bomb from a maintenance
PoV. Maybe a header with static inline function definitions would be
worth considering, although I don't think it's common practice to do
this.

> 3) share the code linking a common object in both modules (and
> renaming existing .c files)

Sharing object files is being phased out.

> 4) create a new module used by both modules.

I am suspicious of the numbers you provided above. What needs to be
compared is the reduction in size of realtek_mdio.ko and realtek_smi.ko,
compared to the size of the new realtek_common.ko. Also, this starts
being more and more worthwhile as more code goes into realtek_common.ko,
and I also mentioned a common probe/remove/shutdown as being viable
candidates. Looking at your figures, I'm not sure at which ones I need
to look in order to compute that metric.

> The devices that would use this driver have very restricted storage
> space. Every kbyte counts.

Well, in that case you could compile the code as built into the kernel,
and the module overhead would go away.

