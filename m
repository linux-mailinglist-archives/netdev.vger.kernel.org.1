Return-Path: <netdev+bounces-33990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3297A126F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 02:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF71C20DEB
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4636D;
	Fri, 15 Sep 2023 00:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FD36A
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 00:40:17 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40126A4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:40:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-273c6658712so314280a91.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694738417; x=1695343217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5ToPyREdPh1rsbMUg6sfRtbYcKWU8Lb0TvTCQEinDA=;
        b=gHRgidB0yf1clcECUKLQdk8whTqSMHReLdZS4WqyqAdxJtZibQ6N7xjJbIBWRmpIGk
         nD9soUqkDy4x2Dj4UBl1pCNUKhI/xXe+U3iPgW6Ks+7PpKcZF0UibnchKtEtYhhwVaOU
         xpq2ezyHJFIPlSbcoSVCxEjSdnVaYBmaKkr8tXgUCgeTRA/LP4RflDph/umCK4+FumIP
         Oy7LhrCn8LXmqJjsNQC0DxJzT/itH8DfhIBs1860zSjyeZ6RRKjGlG2i+/EFA3ggzuAl
         qWdVeYcLuZMDmsSkT21pDVsWZjj6sfKTKnR7SUGC37fOusX2WlpmzdDK5a8rC76jcsBn
         KbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694738417; x=1695343217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5ToPyREdPh1rsbMUg6sfRtbYcKWU8Lb0TvTCQEinDA=;
        b=P4Wpt/kQUBLqW8cs/iyRYbQrPVDWRB759dOUDCrWfMeNqZRb1hxmYGvR3HEHsGt5IT
         v7UTxJRJBj6ikWMffVnBi5bWwN9xQSYy7Wpk8QLH2Q+vnqeaqcDwbIWqYiRqdAHJaLkS
         V/4n1B549ItPvDyDr1ohhY5K69HbZBybfOXtVx0fp5wmdrSpt2GGrroYvfOojFaVXDgo
         J9AEqtsB1jd/z2zTPC9kQK1Ff1xqV8IC9P7/X0cp9/yGfH6WU5DdlDzrMAa+cjNWjLPq
         LOemZS8vilUQ+nHkvBWIs0/8BfgTvfCOpCpfiPutkdo7ncLMi/OYyCC7QRFWgiNDARi0
         vHsQ==
X-Gm-Message-State: AOJu0Yzd15gvuh4yls3IwF0ZW90R+WmTg/VaeZ7UqQKh7P8xvByNVMeG
	i5DxJG77IzeiAcvFU6/dWvJWuAb6fmmt+XjiCrU=
X-Google-Smtp-Source: AGHT+IGqWXY2pnqbP133lLlrYEunfsFZ8jEib+On+wm6/bDrhVtnRUnKnq6vZ2KFE+KyT0qzi5efdrs/rvp+x8h0P5k=
X-Received: by 2002:a17:90a:5aa5:b0:26d:40ec:3cf3 with SMTP id
 n34-20020a17090a5aa500b0026d40ec3cf3mr141140pji.0.1694738416824; Thu, 14 Sep
 2023 17:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com> <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
In-Reply-To: <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Sep 2023 21:40:05 -0300
Message-ID: <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Sep 14, 2023 at 6:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Unfortunately, none of my boards appear to have the reset pin wired to
> a GPIO.
>
> The 6352 data sheet documents the reset pin is active low. So i can
> understand using GPIO_ACTIVE_LOW.

What does the datasheet say about the minimal duration for the reset
pin being asserted?

Unfortunately, I don't have access to it.

Usually, the datasheets specify a minimum duration for the reset to be
at logic level low.

For example:
https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-trans=
ceivers/marvell-phys-transceivers-fast-ethernet-88e301x-functional-specific=
ations.pdf

(4.6.1 Reset and Configuration Timing - says the reset pin should be
low for at least 10 ms).

> In probe, we want to ensure the switch is taken out of reset, if the
> bootloader etc has left it in reset. We don't actually perform a reset
> here. That is done later. So we want the pin to have a high value. I

My concern is that the implemented method to bring the reset pin out
of reset may violate the datasheet by not waiting the required amount
of time.

Someone who has access to the datasheet may confirm, please.

> know gpiod_set_value() takes into account if the DT node has
> GPIO_ACTIVE_LOW. So setting a value of 0 disables it, which means it
> goes high. This is what we want. But the intention of the code is that
> the actual devm_gpiod_get_optional() should set the GPIO to output a
> high. But does devm_gpiod_get_optional() do the same mapping as
> gpiod_set_value()? gpiod_direction_output() documents says:

Yes, this is my understanding.

>  * Set the direction of the passed GPIO to output, such as gpiod_set_valu=
e() can
>  * be called safely on it. The initial value of the output must be specif=
ied
>  * as the logical value of the GPIO, i.e. taking its ACTIVE_LOW status in=
to
>  * account.
>
> I don't know how to interpret this.
>
> Is the first change on its own sufficient to make it work? As i said,

No, it is not. On my tests, I needed to force the reset GPIO to be low
for a certain duration,

