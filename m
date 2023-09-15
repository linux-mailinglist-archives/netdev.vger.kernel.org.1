Return-Path: <netdev+bounces-34087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D77A2095
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD412823D3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF011189;
	Fri, 15 Sep 2023 14:13:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D4101D4
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:13:49 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768E1FD0
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:13:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5783e07fdcbso1280a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694787228; x=1695392028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke/S75Act/GYPOSeawP6Jdwgvv0mn/jdboBsDb1L9yQ=;
        b=JieD2Jj2FS19AtMfhHHFVzh5NoA/wuUKnKdALbdNazjTmycVIIYIQzUeLY4V0yO32r
         u79aA2Y+KAn5HMYpzxG8CMOvha24SpBkz5kYZldN1vFIHcm5JTT9gmEZ+ucDFYNpHenK
         /vCr+BKk1SlHpEaCQezdCyDvRI/XNNUnfOrcPAAADV4/JESqS7rbuyDLaYmPGHuk2tiY
         PLNz4n/3xr/ZS0rJhUe1hMT0IjCZ3COanvsVhV2DHL2Q9kTfbcTzSBzF3Vgi1vzD3kHK
         bAx/6jyYIRNhoIf1QqXisdvB24pBi5B6PLnIU3mqxDEXvEHzP6qipseP45qdbcpCGyTX
         XS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787228; x=1695392028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ke/S75Act/GYPOSeawP6Jdwgvv0mn/jdboBsDb1L9yQ=;
        b=YUIPROe5A2zElY5Gxoh8OrjqpcKvXf1XR/T8iHDxo/WFsp9lc8Ki3bE17jnsSLNPr6
         hTDsuQgOELUBAwR1dl9ihZybS99ek66c54VqSPMfYFzSR3qLnbXU2SD7z0Nfv7jJBxid
         2W2jiISbNAFIo/19A6t5BjZ3t6zYx2tgcCUWK9D6IRmkyraj66krJZf7uT+Y15hQIvan
         wRhp7ESdGEsemb4otpZimKISFhNmM1lMZLUbJtVySO5q/6FcV1hhcd4cSPwi24jsEx/b
         Ttpi3Aw7Mus2dDz/4fPW8JdXkPKeXU2gn4MUbK6LZeFpV1lnA8QwgQCPSEOera9K1sYn
         RR2Q==
X-Gm-Message-State: AOJu0Yy7MFyf3GdIkSw1kWFHeYlJXDaooD5dy8P7HkawE7Afl1lx657f
	UQOQGhJ/nsUHVKETKKAAO3FmIckXIULFkWTSJZU=
X-Google-Smtp-Source: AGHT+IFVb1QexceCNEMxn+OszAR0FB6zGhWO7Fh1x9HE0DtJcsnBh9jMrOSOQEKc8CkCl1Ut6fPMq0QVw1t9IwuapgY=
X-Received: by 2002:a17:90a:6d27:b0:26d:2635:5a7c with SMTP id
 z36-20020a17090a6d2700b0026d26355a7cmr1551869pjj.2.1694787228346; Fri, 15 Sep
 2023 07:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch> <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
In-Reply-To: <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Sep 2023 11:13:36 -0300
Message-ID: <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Fri, Sep 15, 2023 at 10:08=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> > What does the datasheet say about the minimal duration for the reset
> > pin being asserted?
>
> It is a bit ambiguous. RESETn is both an input and an output. It says
> this about input for the For the 6352:
>
>      As in input, when RESETn is driven low by an external device,
>      this device will then driver RESETn low as an output for 8 to
>      14ms (10ms typically). In this mode RESETn can be used to
>      debounce a hardware reset switch.
>
> So i would say it needs to be low long enough not to be a glitch, but
> can be short.

Thanks for confirming with the datasheet.

> Is you device held in reset before the driver loads? As i said, the

Just checked with a scope here and no, the reset pin is not held in
reset before the driver loads.

> aim of this code is not to actually reset the switch, but to ensure it
> is taken out of reset if it was being held in reset. And if it was
> being held in reset, i would expect that to be for a long time, at
> least the current Linux boot time.

That's a point I am concerned about: why don't we follow the datasheet
with respect to taking the reset pin out of reset?

Isn't the sequence I used below better suited as it follows the
datasheet by guaranteeing the 10ms at a low level?

       chip->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH=
);
       ....
       if (chip->reset) {
                usleep_range(10000, 20000);
                gpiod_set_value(chip->reset, 0);
                usleep_range(10000, 20000);
       }

