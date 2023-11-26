Return-Path: <netdev+bounces-51144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339907F952F
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C761C203A7
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC6412E51;
	Sun, 26 Nov 2023 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caNhYdGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38E1DB
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 12:11:40 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5c08c47c055so34064677b3.1
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701029500; x=1701634300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T46UpkrmjcXMYW2/kbuQ/hVmyB9TC43EVzJzlD0Woo=;
        b=caNhYdGK09L/2IMZpmG03p7RQnRhavLM/h/YORx+G36iJEPHJHNMZpLHduNtXxnT66
         EU82QcR86vaz0avKia57Wzikqt69Mp4rN1JYibzi4oVvfqLo32C2dkR43AFbcbiJE/+O
         g1FaKG3YeTHtod1JHj6qPTByel5dkjaOuocGl6wExYe15TEPQBSrECAjdMTVmjRuoSR6
         UMZ1+EiIcRRARNduHTiEkGUWC2kClWOrqmdbe3Nx7OUE1eGkubNvRCdj2xsdnGr5OH8e
         0JOlopOy3ezbnTSoaTOObqCSUBEL/BJFGbhfevftoSKX14iLOCnefSSv9VBTTEg6l86w
         GpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701029500; x=1701634300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4T46UpkrmjcXMYW2/kbuQ/hVmyB9TC43EVzJzlD0Woo=;
        b=Qh/MJNe1S76hTRNGhZ1sNWqXPqfLFmdMRlcz/GkIkRo50wfmOBrCj9sXA4e9GjMaXU
         JtpM75qvbAf/aNwv1ccXiIej4R/EDr4BINMH5rCAAiv22HnWPTqCH5GPSOy9V2zGrP1t
         JWozd7YiXvzVqhsYzL8xQAqXCHv9MMBD4Q1Rp3vYLIWsN2B+5JPtreHnzMvqleNf4XeY
         DHG8CRkgj8bDnvxlJqT3YjuCu5v1jbVHtV8s/96dNV51yP65dxPW1z7CTewVfW/uWwG0
         uC5DycuE9rkTDsRDBWKsfKMfmQ2drxDbX21Y0dfl49mnZEqtRGJLhMPzMppTZ56t1ppN
         NlLw==
X-Gm-Message-State: AOJu0YxomIfnXzJvUrrywjxK/iXjuxZnJnfokGi6GzBuHNYa505pZtLa
	9KXR6tvChepFIcbVaF6dyuS0Jf6YjsSo2SbxyF+cEQ==
X-Google-Smtp-Source: AGHT+IGfLw/SDGe/gYpJa4dniTOtRwCls16YgDDg9+5Pqoln5DS1pKvBvZxkFYeLoJoMsAlIZBk0JH34c62eYGUr5ag=
X-Received: by 2002:a81:9290:0:b0:5a7:bc0e:193e with SMTP id
 j138-20020a819290000000b005a7bc0e193emr10448152ywg.18.1701029499882; Sun, 26
 Nov 2023 12:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org>
 <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch> <CACRpkdY+T8Rqg_irkLNvAC+o_QfwO2N+eB9X-y24t34_9Rg3ww@mail.gmail.com>
 <4bd8642c-988f-4b99-944a-da573d0ef2c3@lunn.ch>
In-Reply-To: <4bd8642c-988f-4b99-944a-da573d0ef2c3@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 26 Nov 2023 21:11:28 +0100
Message-ID: <CACRpkdYp76UK3uC=3JrbZ5MhPRn7CkAbO1fezrSCNfDqobjZww@mail.gmail.com>
Subject: Re: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 5:45=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> On Sun, Nov 26, 2023 at 12:46:03AM +0100, Linus Walleij wrote:
> > On Thu, Nov 23, 2023 at 5:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> >
> > > What i would really like to see happen is that the DSA core handles
> > > the registration of the LEDs, similar to how phylib does. The DT
> > > binding should be identical for all DSA devices, so there is no need
> > > for each driver to do its own parsing.
> > >
> > > There are some WIP patches at
> > >
> > > https://github.com/lunn/linux.git leds-offload-support-reduced-auto-n=
etdev
> > >
> > > which implement this. Feel free to make use of them.
> >
> > Oh it's quite a lot of patches, I really cannot drive that because ther=
e are
> > so many things about them that I don't understand the thinking behind..=
.
> > But I like what I see!
>
> O.K. Let me dust them off, rebase them on net-next and see what is
> missing.

Thanks Andrew, appreciated!

I'll be happy to rebuild it on top of what you put as the baseline,
hopefully it will help Christian with the qca8k support as well?

> You have some fibre things i don't have. I don't have a
> machine with fibre so i cannot test that.

I can test that, the way I check for its presence is through device tree lo=
oking
for an "sfp" phandle, AFAICT I don't see that the hardware can tell be
when there
is a fiber connected, but alas I don't have any datasheet.

Yours,
Linus Walleij

