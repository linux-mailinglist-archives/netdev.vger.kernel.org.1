Return-Path: <netdev+bounces-46368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28FF7E3632
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5AB280EBE
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75093D2E0;
	Tue,  7 Nov 2023 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFw76+Ds"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F331C2F0
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:04:02 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DEBF3
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:04:01 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5afbdbf3a19so62867467b3.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699344240; x=1699949040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajy15QVVitqzt8H9X7YFPvGhw3x82xp6MiRul2owJZQ=;
        b=aFw76+DscChvpdBVw3aK98x54s2JZ5kg1o3Yf0iAg4jcVk6TkTAf0NqfITk827GOQz
         vRz9XeY2enMd0IPInXR7soUnQmOkGDAaqsrSh4YVS9m4Byw227t7UK4LXrLHkdQDaD/f
         LrqH+kD/dkgVXGqCyU7tk9YljImVWF3PfqKqNietDfUolgmqsxiO/izI6s5xiz4cSi37
         BBY8Q93RSnatbkYcypTyoHLi5BnCGkz3eETi1ADYXrI3u/StO9ZtLBgltdOMTnee8LVH
         hrlflxfjstenLBgpKXIVcps6i1IPkwSa347R7pvDY5sF2xf9lXxV04in9llaMN+u3Nzm
         7ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344240; x=1699949040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajy15QVVitqzt8H9X7YFPvGhw3x82xp6MiRul2owJZQ=;
        b=rWDVvI84LlSOMWLYkUn2HYGJ5w+sUHecdxpevBzSz/gawYzI+SdfB5HEjZY5WyW9j9
         qDRpnXNUOLOQEdmnKp2mRS4O/9My6FB4NWD2RtxX8FC5TbS8ptk82b9QtinrDyMttohA
         XouXjhhDkHC+hGVeGUhrKtaiu3a8CUSmPuvl3QzToai02NHnc0fhxrKBgZLl13ij6viA
         qWPQ3lNf5FYHxv30SSP9ZpWdBmq2bABnhYEczL97JNtSS88QX6HiAR0jiV8IvWTYk2yG
         hYG35RRq3dMNhHmCDNu4S32E11FIHPIqNuWyA+tO2KOrR7JK6aJdcahg+x1szxySUhf9
         tCFQ==
X-Gm-Message-State: AOJu0YylHwvGaaDoaElb4ybApNshQfeyqNLAnpkKssgcMiWLKxEpKbQw
	QsNVbKSafOlZJENU0O442Ro6sWPuNod0NguggkMMiQ==
X-Google-Smtp-Source: AGHT+IFFDg04Njno2d5fkmBmrkGLgYlS4Cqz8KaGKFFo2fWzYfBUD9yJtAS749TKBS2NZUL1c09hMK5ja/aKyXQxMjk=
X-Received: by 2002:a81:6c4c:0:b0:5a7:f002:4fe4 with SMTP id
 h73-20020a816c4c000000b005a7f0024fe4mr13574734ywc.23.1699344240471; Tue, 07
 Nov 2023 00:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf> <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com>
 <20231102155521.2yo5qpugdhkjy22x@skbuf> <CAJq09z5muf01d1gDAP9kcsxC9-V3sbmyqTok=FPOqLXfZB9gNw@mail.gmail.com>
In-Reply-To: <CAJq09z5muf01d1gDAP9kcsxC9-V3sbmyqTok=FPOqLXfZB9gNw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 7 Nov 2023 09:03:48 +0100
Message-ID: <CACRpkdaBC7GeeGYoZ+CYjSVV657yFm=B2L6U2mNyh+AVsLbnsA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 11:37=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Your proposed Kconfig does not attempt to avoid a realtek-interface
> without both interfaces or without support for both switch families.
> Is it possible in Kconfig to force it to, at least, select one of the
> interfaces and one of the switches? Is it okay to leave it
> unconstrained?

Can't you just remove the help text under
NET_DSA_REALTEK_INTERFACE so it becomes a hidden
option? The other options just select it anyway.

> If merging the modules is the accepted solution, it makes me wonder if
> rtl8365mb.ko and rtl8366.ko should get merged as well into a single
> realtek-switch.ko. They are a hard dependency for realtek-interface.ko
> (previously on each interface module). If the kernel is custom-built,
> it would still be possible to exclude one switch family at build time.

That's not a good idea, because we want to be able to load
a single module into the kernel to support a single switch
family at runtime. If you have a kernel that boots on several
systems and some of them have one of the switches and
some of them have another switch, I think you see the problem
with this approach.

> I'll use these modules in OpenWrt, which builds a single kernel for a
> bunch of devices. Is there a way to weakly depend on a module,
> allowing the system to load only a single subdriver? Is it worth it?

Last time I looked actually having DSA:s as loadable modules
didn't work so well, so they are all compiled in. In OpenWrt
I didn't find any DSA modules packaged as modules. But maybe
I didn't try hard enough. IIRC the problem is that it needs to
also have a tag module (for NET_DSA_TAG_*) and that didn't
modularize so well.

Yours,
Linus Walleij

