Return-Path: <netdev+bounces-45743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECF7DF57A
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33B7281B52
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E303015483;
	Thu,  2 Nov 2023 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/E+PpbV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC421B274
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:00:05 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096FD182
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 08:00:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d84f18e908aso1056056276.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698937199; x=1699541999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eFVUXwI8Om81YbJ5xdsRINOsftGAbfoj6aCqyXr5Co=;
        b=h/E+PpbVscsc5y7l/zbDsI0fXZMIrF9259PoxvBhLdOxbiwdOp5weasO0NCxkKgaHu
         9uk4DI0GRoEMZ/aNJ9Do90iL50Foww2nL43z05YBTPRCnAMts41Gmfijp5v5YCcwVOJt
         W6GKIppGLmJ9nYS52X2FAigtN5WDd8WPisA8RhI+rBIqmYKkXgxLcWiOP/+mLLaNprXe
         NuRfz1AcEHPRT+S9PwCOU3AiPYatwxeS3832psdsMccYUemLBvbQq+rZrk6awpAs2iIz
         1TNZWsptPHOwM11XVn/fZlOBWoZMIaeBHGNKsF6Y7xLzyZv7A/bUFGdUxNRYUTkTzLHA
         Bccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937199; x=1699541999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eFVUXwI8Om81YbJ5xdsRINOsftGAbfoj6aCqyXr5Co=;
        b=eaWnp/kDKENK+d+2/11dGvuDpcjphZWAn1dJmZcm8D79q/E0Knmwsekmf+ecslvZjI
         PcpLdDzi8uROaGS9VHi07s3jYDVUiU7xEETedPRM7buvwQgcNgG8CeV3i7Y5r9CRUla9
         XzuQZuK7P8AwXdh5b93E9aILzV9u8pO5TyU8vWcZT1G0j7LnqhVPTn7pF9rvhm/xDBUc
         Rc0xrucNAj8rbCOgJWEApbV7G0V2Fgdy804JcYBKZ7KWukrs+txfw/GUvA/J5L/7XISz
         2qnv2srpR+L10zPX5fNOEprTxMn/wH5cC9lkV4pEok0DD4oU21BTHpvn2BVFbNHfhQwG
         6Emg==
X-Gm-Message-State: AOJu0YxX/HVxrMCguMoW6BZz9RoX7Fh+k+8HE9TxoEux3ktmcVxNInPP
	Y0xr/lb78K0UFinh8Ra5BnZ70GrwetkTvdgXk0B+sw==
X-Google-Smtp-Source: AGHT+IHt0ogOOesCjoaujZGiEDIaJLtV2OUpefnZTtSx83FmIxxGdbVDgo/1usP8QYiM+nKfXTb3G/afJSRm6IweMjw=
X-Received: by 2002:a25:cfc2:0:b0:da0:c746:386c with SMTP id
 f185-20020a25cfc2000000b00da0c746386cmr18756029ybg.51.1698937199200; Thu, 02
 Nov 2023 07:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf> <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
In-Reply-To: <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 Nov 2023 15:59:48 +0100
Message-ID: <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 8:55=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> > drivers/net/dsa/realtek/Makefile
> > -obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     +=3D realtek-mdio.o
> > -obj-$(CONFIG_NET_DSA_REALTEK_SMI)      +=3D realtek-smi.o
> > +obj-$(CONFIG_NET_DSA_REALTEK_MDIO)     +=3D realtek-mdio.o realtek_com=
mon.o
> > +obj-$(CONFIG_NET_DSA_REALTEK_SMI)      +=3D realtek-smi.o realtek_comm=
on.o
>
> Just a follow up.
>
> It is not that simple to include a .c file into an existing single
> file module. It looks like you need to rename the original file as all
> linked objects must not conflict with the module name. The kernel
> build seems to create a new object file for each module. Is there a
> clearer way? I think #include a common .c file would not be
> acceptable.

I don't know if this is an answer to your question, but look at what I did =
in

drivers/usb/fotg210/Makefile:

# This setup links the different object files into one single
# module so we don't have to EXPORT() a lot of internal symbols
# or create unnecessary submodules.
fotg210-objs-y                          +=3D fotg210-core.o
fotg210-objs-$(CONFIG_USB_FOTG210_HCD)  +=3D fotg210-hcd.o
fotg210-objs-$(CONFIG_USB_FOTG210_UDC)  +=3D fotg210-udc.o
fotg210-objs                            :=3D $(fotg210-objs-y)
obj-$(CONFIG_USB_FOTG210)               +=3D fotg210.o

Everything starting with CONFIG_* is a Kconfig option obviously.

The final module is just one file named fotg210.ko no matter whether
HCD (host controller), UDC (device controller) or both parts were
compiled into it. Often you just need one of them, sometimes you may
need both.

It's a pretty clean example of how you do this "one module from
several optional parts" using Kbuild.

It's not super-intuitive, copy/paste/modify is a viable way to get to this.

Yours,
Linus Walleij

