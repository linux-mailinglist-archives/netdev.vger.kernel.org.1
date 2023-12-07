Return-Path: <netdev+bounces-54990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA978091EA
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A935A281396
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FB4F8B9;
	Thu,  7 Dec 2023 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMeoIOB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04310F7
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:51:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1915034144so179501066b.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701978690; x=1702583490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyNxMC5UaWA8P1oAZwMgXZGctvwxcnYFcLUj2/+v4A4=;
        b=sMeoIOB5zF8VMBBfBEWvh0cLeRB+50UV9taV/QDpYmqujSA9LYTaOO/5TPsPq9ZFY3
         CIfT0BAwYLrD3IUNCpNgUQaQ/MwCDGupoWz4ICeTNr38J4ujtAVf7+UXWkeWlbIBVZhO
         v0TESlTagtGV6ZdCroVkobHBea9Sy+SuygbS8V1gzylltOxGLsbE1TKq2GH92xccvf+7
         sas/szFF5Rx4anesbQEbnZ/dWQ72huVherJpuTgVe+yzW5SaIJqX1KdLUoSO8MsNq1yC
         OUSPVjhFgruiUL1lfO/ZkbD/GVCcz45ni2TEp/HliCKSrVxvt0Uk7pjGkOY1paZ7b6is
         gw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978690; x=1702583490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyNxMC5UaWA8P1oAZwMgXZGctvwxcnYFcLUj2/+v4A4=;
        b=bFJXjtOCNKvXbbMdU4/dfYOujcEYwyiOoFhUgrIzrPf9rBH0KkHXron5ZNipeCaDA9
         bAWPYQSdcXTiHbB9LOgQz6zRSFtx7/EACdOllr6WuMUEycNIGHknRIPJJMM5v/qqcVu5
         qQRLQ/HYAA+Thihw6c7GDnfKfNYdudmSfIilaHoBWgA0l1YhnExCbhTtdMelyHYl2D18
         dVA6WDuaxR5k21fWX2pG+iNmpQej60TKk1PaUe5Zh6l2mhbUnJ3neVTOc/08XAJs06FJ
         8bnhJbd8asXkd1VphRDQBnK75SSJ7U9Mzpt5Y/I84cp+RUDoby5WjOfRUbQficNmckeM
         fUAQ==
X-Gm-Message-State: AOJu0YyOJTADVp4X8qM0cgMi1l6+GcFwAwu4xAD2Ki0m3d5qBu6naq4g
	J/Gnc38HDnn1Hcc+4c0fUolH2q92qkLZ4PQvh5Yaxw==
X-Google-Smtp-Source: AGHT+IHn6Gpxs0pG2yGvus7gTfzV0S7QzvF4q0Z2d5XIfpkMDbFezPPz4AmGj5WO8CtAkKxxm4NQ+Hh/9bolotTv8wE=
X-Received: by 2002:a17:906:f2cf:b0:a1b:e80a:b68 with SMTP id
 gz15-20020a170906f2cf00b00a1be80a0b68mr1854717ejb.143.1701978690497; Thu, 07
 Dec 2023 11:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
 <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
 <20231130224021.41d1d453@kernel.org> <202312011018.478B0E750@keescook>
In-Reply-To: <202312011018.478B0E750@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 7 Dec 2023 11:51:18 -0800
Message-ID: <CAFhGd8pT=QoTaPAzH+NPzu=i1i9oX_7wcP6X1_aDDTJ0vUssmQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:19=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Nov 30, 2023 at 10:40:21PM -0800, Jakub Kicinski wrote:
> > On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> > > Applied to for-next/hardening, thanks!
> > >
> > > [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_string=
s()
> > >       https://git.kernel.org/kees/c/f1c7720549bf
> >
> > Please drop this, it got changes requested on our end because
> > I figured Alexander's comment is worth addressing.
>
> Done. Justin, can you please refresh this patch (or, actually, make sure
> the ethtool_puts() series lands?)

Yeah, let's let this patch die. The ethtool_puts() is on v5 and is
getting good reviewed-by's. I suspect it
will be in soon. Then I'll double back and do right by the intent of this p=
atch.

>
> --
> Kees Cook

Justin

