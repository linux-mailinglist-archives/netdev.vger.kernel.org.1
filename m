Return-Path: <netdev+bounces-62573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BF827E41
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 06:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475D4285A08
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 05:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74734639;
	Tue,  9 Jan 2024 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBeSIAQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABF17C2
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd5c55d6b8so14051511fa.3
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 21:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704777117; x=1705381917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhLW/BM9w95Q+LN6sI7NIblVT4LYut/ZNisgzb4yJNw=;
        b=RBeSIAQd3v57ki/+8GGoeCeX7wtLyGJXwiIqAgWolnABhGGamDb499kksoCGQP9Ddc
         rFaE0G58C5nPF0P8Zm07NZYxPpjTryk677Q/9VlM848f7dJxjuJuiXJ/WtXTbGyW7Tw0
         B5I8SWdvo2EDsZ0SNCjADeISQzrD43uHeXTADmlI+vcCJWj5mrqZMOA+42SIiiNSVxU6
         vX8IoWoLPZLYFWyxKRbc9BlLePJyyzhimMoQ4ey33qNYzfQITuQM9AJZ2ZCctu1dA6hd
         X4kxGejT4GQ0sUZHwE79tfjdWRNKx3u/QDsp5DdBXaIWi2O0Ryz0qLMb+YjS77WIotW4
         PBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704777117; x=1705381917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhLW/BM9w95Q+LN6sI7NIblVT4LYut/ZNisgzb4yJNw=;
        b=aI6IuF4axbl0q0qx67aE3ttyTj5d83YtF7FEqyQVn+HYiuZ1wOYt2j/sMB9wuT1m5u
         oq7d0kegwit0YQNWgz7kCDvwO7vse1XMxbbKX6EZ/L5zfQ8Vm32sZWWLyH+FI2px2r5q
         C5AFGtYBRYNp1/n5cX24ELeo5mXiS/JkCuOmim6jEfbBzYWX90o1aCR9kbNINh9QZXX2
         0ZoF2x0kZQhP/gB1YW85t3VOpFR0iXzacLLoYAs2s/HaJxtP13uMRsLJ2M+sLUGn6Lk+
         fvAmDH8dH1KedgkjCtdM3DvpNZ/O9Cs0viiaPUBu+Mk1SbR33irNaWYv5gvfC3DQfXC9
         xCTg==
X-Gm-Message-State: AOJu0Ywi/zGCwPyyQc6XnoQCQP0SGJ/S8n5JeCwbtIeKdsaKukwh8nv8
	vWfGratLZEfIqp+yCTSgY6DTTe2AIoCHxjod87E=
X-Google-Smtp-Source: AGHT+IEP4hCcLiqGj2HJpUZoPvrxYvNxdgl69L7vb8dB68Rsygy6I03eub8qLAfJo68h24O7wfL7oV5/y5t3LrmsjVw=
X-Received: by 2002:a2e:9d09:0:b0:2cd:dfe:74ca with SMTP id
 t9-20020a2e9d09000000b002cd0dfe74camr1177841lji.19.1704777116667; Mon, 08 Jan
 2024 21:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-5-luizluca@gmail.com>
 <20240108141103.cxjh44upubhpi34o@skbuf>
In-Reply-To: <20240108141103.cxjh44upubhpi34o@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 9 Jan 2024 02:11:45 -0300
Message-ID: <CAJq09z56YYBOe=N8be-4MPzXEMx7jUbWyEDcs=fgxe088A-a3g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] net: dsa: realtek: merge common and
 interface modules into realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> > +++ b/drivers/net/dsa/realtek/Makefile
> > @@ -1,8 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_NET_DSA_REALTEK)                += realtek-dsa.o
> > -realtek-dsa-objs                     := realtek-common.o
> > -obj-$(CONFIG_NET_DSA_REALTEK_MDIO)   += realtek-mdio.o
> > -obj-$(CONFIG_NET_DSA_REALTEK_SMI)    += realtek-smi.o
> > +realtek-dsa-objs-y                   := realtek-common.o
> > +realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
> > +realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
> > +realtek-dsa-objs                     := $(realtek-dsa-objs-y)
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
> >  rtl8366-objs                                 := rtl8366-core.o rtl8366rb.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
>
> Does "realtek-dsa-objs-y" have any particular meaning in the Kbuild
> system, or is it just a random variable name?
>
> Am I the only one for whom this is clearer in intent?
>
> diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> index cea0e761d20f..418f8bff77b8 100644
> --- a/drivers/net/dsa/realtek/Makefile
> +++ b/drivers/net/dsa/realtek/Makefile
> @@ -1,9 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_NET_DSA_REALTEK)          += realtek-dsa.o
> -realtek-dsa-objs-y                     := realtek-common.o
> -realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) += realtek-mdio.o
> -realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) += realtek-smi.o
> -realtek-dsa-objs                       := $(realtek-dsa-objs-y)
> +realtek-dsa-objs                       := realtek-common.o
> +
> +ifdef CONFIG_NET_DSA_REALTEK_MDIO
> +realtek-dsa-objs += realtek-mdio.o
> +endif
> +
> +ifdef CONFIG_NET_DSA_REALTEK_SMI
> +realtek-dsa-objs += realtek-smi.o
> +endif
> +
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
>  rtl8366-objs                           := rtl8366-core.o rtl8366rb.o
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o

I also prefer ifdef but it was suggested to use the realtek-dsa-objs-y
magic and nobody argued about that. It is an easy fix.

Regards,

Luiz

