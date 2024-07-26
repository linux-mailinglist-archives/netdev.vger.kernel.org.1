Return-Path: <netdev+bounces-113153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1893CED4
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 09:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D8E1F22630
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D21741C3;
	Fri, 26 Jul 2024 07:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C323A8;
	Fri, 26 Jul 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978785; cv=none; b=sLSLyiqfke2UnhbX5GPzqfgRhdkHfHJeynoxxytb5e1ncffije18lzCKGcOQmfMIm4SfN1feI4tOSFRHFO9VS19PUw15UAF1w6eGzfUzknyK3VzRBeA2Ao8jKFmnkPZdiVFR/ejRLk4eJC6tX6MjJqbYA7hhDWoauRmNrJxB5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978785; c=relaxed/simple;
	bh=+4tNx5lAPIw3i+vKDepfBSh6/T1hhw1adM3RpZFFYaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyERvahCtdKWwzoSZk+oygmDJCYqWE31FmeB0YQMaF9e5sXsN0T1X94TJP5rL6kJJltBJZ1SLsEHr4XGsII9Q5ZlV7hjR+B3lBib2phE7mHXDf+nml0lWsCggdwuVPTFf0YPa5NAAtkPvOzk8HwwKYeFXZO3ig/4NV0R5huXAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64f4fd64773so19431277b3.0;
        Fri, 26 Jul 2024 00:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978781; x=1722583581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLV1EGDyov1edVFnSsDDjihYYooPrxLZ+s79IlkB448=;
        b=eRcnV+uY+KP00zQRhLy4p1td+GthoYGchMaaP7JxPY6nQyd7bDITX9tAQHQbk0trzI
         5UhPibFurSTI7BP3MKphPBJGm4TAeqD4Fd3Q2uYh/ArUWzetMBHH7u0TnA5bYAlx70hI
         te0XselnEdv9VrXgfRNeNdZSqxn9BKtgmGKGtwu9v+5uJ4n4HZqBNtzOdQZ81KPpX488
         80DQ1u9S8lc+pRWmbEzztJCkjPVfHE+be0OckhUakpmJFGHBwmHPTuDKEP7JsFA8v15w
         e20oRGTCk1HktleS82HMVyHe+QMRoaCjRd378xynLDg6JrTRS76ZQY31qamnJ2MZFyjT
         1HPw==
X-Forwarded-Encrypted: i=1; AJvYcCWHFlvFFGpcmnqVFhVDGl+ACJfThQCi19hBJ+OIQQcv6xxB6geNj0Mc90apkxdXZ/26ECQuOQe+OfNBcVAvDRzdk8DYZBU5wk20xzP0Os/P2tWVOcyiNOfEwEAcrtfU7YFEm6mN
X-Gm-Message-State: AOJu0YxsdFZZW4bGUq3xd+kPLZpJeFW8BBDX7xPxf/NJwqioCP88R3YD
	jAXyO+vc94WCMKCK+uBpuwYoBuWRyRYnhPa1tYpOaBSNvHd2hov0F5U79bn+VuQ=
X-Google-Smtp-Source: AGHT+IERr4Aqwh6BULsXK262U3Rz8w7RnOjbbt/MNtigiZDgBfeabvDpcdjQcnwQGjZRI/Yx21mL3A==
X-Received: by 2002:a05:6902:2407:b0:e0b:1191:3c9f with SMTP id 3f1490d57ef6-e0b2cd6e48cmr4960290276.39.1721978781279;
        Fri, 26 Jul 2024 00:26:21 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a70e8a1sm642349276.48.2024.07.26.00.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 00:26:20 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-66493332ebfso15659397b3.3;
        Fri, 26 Jul 2024 00:26:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2T7ENA8nC8iCJPYiEW8UQ1OJSuRETrNPoHEQOcwpoUb1UNY8GYSMZx33tm8xcVB1GyKyO8CbDBWkMDuz6xQOhpXs6OmnrxzQSCtAg+aosPOHTat/LH+Xl17Wv4QXcao4IO+Wu
X-Received: by 2002:a81:a20e:0:b0:64a:d9a1:db3f with SMTP id
 00721157ae682-675b3823cd3mr50786447b3.7.1721978780591; Fri, 26 Jul 2024
 00:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407260828.NQM5BhqE-lkp@intel.com>
In-Reply-To: <202407260828.NQM5BhqE-lkp@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jul 2024 09:26:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLCPcH3x+LXOCp=9qiw1WWWRtre7Lf8HqtZ1E3JwfLsg@mail.gmail.com>
Message-ID: <CAMuHMdVLCPcH3x+LXOCp=9qiw1WWWRtre7Lf8HqtZ1E3JwfLsg@mail.gmail.com>
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
To: kernel test robot <lkp@intel.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:38=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   1722389b0d863056d78287a120a1d6cadb8d4f7b
> commit: f73edc8951b2de515b5ecc8a357ccd47dd41077e kbuild: unify two modpos=
t invocations
> date:   1 year, 10 months ago
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240726=
/202407260828.NQM5BhqE-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240726/202407260828.NQM5BhqE-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407260828.NQM5BhqE-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

Nothing has changed in 5 years, mdio-cavium should be fixed instead.

https://lore.kernel.org/lkml/CAMuHMdUERaoHLNKi03zCuYi7NevgBFjXrV=3Dpt0Yy=3D=
HOeRiL25Q@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

