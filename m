Return-Path: <netdev+bounces-59979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D350381CFA3
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 23:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE92284FE8
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 22:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C192EAF0;
	Fri, 22 Dec 2023 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9lk6z3v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDEC2EAEC
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40b5155e154so27005385e9.3
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703282999; x=1703887799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiS6gkp058Y8fuSrQA7eq2xERY/Dk0iGDdCJtRDci5U=;
        b=X9lk6z3v8KunC3RCnjV/wbkw4K0oimgUC6Dc2KhSG+OC43/fj2NNUOd3ZwV3+MKjRS
         w59a5bJJl60Iuqt88QN7/PrCK4gECJR/MGTOw0pzXmb+zLsxAtKpJQXX6/ZcC41Uqyi6
         3ExnujHbQ5jBeIEUPjB6984W3XfoZdbVeJ3SNehnXGkmV0evvs/ogmk13iwsu3fzysfE
         mNbq3JdyCmYmIRXZNIvI0oNsMZ9CHAdhlN9L6AkdxOvIYeRGrcg01wL1lGj3SkBq3DDv
         HUIDZoBIEh1bUTNWy8o+tI4eoZ0c8YBqUxV+1XHk1QM9BvnuKj+CoNoM0bVdSJdwzqh3
         89kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703282999; x=1703887799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiS6gkp058Y8fuSrQA7eq2xERY/Dk0iGDdCJtRDci5U=;
        b=XEvJe/ekbH+NS3Wv/fsE//IaFM1xMnhx906aMX04wafYdfzRgXt5KEnlVk6tQBd9PS
         BUReMcuUC0fYR3NSNMa7itZdC4J/4kUlMl9ba8jvQsFK4xKbcTaAqShCM0ox+TdBN9GS
         hzowJ0c86H4pKZAj76/gdsv6b0Nki1wWju3FmDNIeDQ0W+I6/IzAw8oriAjVORiEkF5R
         ZiQCpskKPt0ZIQUiL8L1XVyM7x1aecBY802iNgKzOnpCp8VL+SRrseaCmanxkhFnJAt+
         9Ct8TZAnaOTBh/qQ3G7kMAValvPFVET4fURR/HAxLGn/SmdylGAUI9TiLuK6XCxmiVfr
         x5Kw==
X-Gm-Message-State: AOJu0YxGQSxG1bxBwoR/TZNczB0TblCJVzW+ShNfhGZ4xAWQCpmAITOq
	U50iP+T0bo5DSjXUqVLXW0A=
X-Google-Smtp-Source: AGHT+IEjmffCYVohKjyx5HMjW6Y2M8Jz8o008zQYpVcW0YxXEoO7PKWqiiv2YHXtLZYOMvcNv9tZYQ==
X-Received: by 2002:a05:600c:4f94:b0:40c:3e0a:692e with SMTP id n20-20020a05600c4f9400b0040c3e0a692emr1037658wmq.232.1703282998527;
        Fri, 22 Dec 2023 14:09:58 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id z16-20020adfec90000000b003366fb71297sm5134645wrn.81.2023.12.22.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 14:09:58 -0800 (PST)
Date: Sat, 23 Dec 2023 00:09:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Message-ID: <20231222220955.77j7nmvhbelv2t7a@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
 <CAJq09z5zN86auxMOtfUOqSj9XzU-Vs8_=7UzfY-d=-N9dgAPyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z5zN86auxMOtfUOqSj9XzU-Vs8_=7UzfY-d=-N9dgAPyA@mail.gmail.com>

On Fri, Dec 22, 2023 at 05:03:38PM -0300, Luiz Angelo Daros de Luca wrote:
> > Having the MDIO bus described in OF, but no phy-handle to its children
> > is a semantically broken device tree, we should make no effort whatsoever
> > to support it.
> 
> OK. I was trying to keep exactly that setup working.

Which setup exactly?

> Should I keep the check and bail out with an error like:
> 
> +       dsa_switch_for_each_user_port(dp, ds) {
> +               phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> +               of_node_put(phy_node);
> +               if (phy_node)
> +                       continue;
> +               dev_err(priv->dev,
> +                       "'%s' is missing phy-handle",
> +                       dp->name);
> +               return -EINVAL;
> +       }
> 
> or should I simply let it break silently? The device-tree writers
> might like some feedback if they are doing it wrong. I guess neither
> DSA nor MDIO bus will say a thing about the missing phy-handle.

FWIW, it will not break silently, but like this (very easy to test, no need to guess):

[    7.196687] mscc_felix 0000:00:00.5 swp3 (uninitialized): failed to connect to PHY: -ENODEV
[    7.205168] mscc_felix 0000:00:00.5 swp3 (uninitialized): error -19 setting up PHY for tree 0, switch 0, port 3

If you have no other decision to make in the driver based on the
presence/absence of "phy-handle", it doesn't make much sense to bloat
the driver with dubious logic just to get an arguably prettier error.
I'm saying "dubious" because my understanding is that rtl8365mb "extint"
ports can also serve as user ports, and can additionally be fixed-links.
But arbitrary logic like this breaks that.

The cost/benefit ratio does not seem too favorable for this addition.

