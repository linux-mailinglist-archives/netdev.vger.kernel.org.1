Return-Path: <netdev+bounces-35103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA77A6FF4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 02:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E121C20A23
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF715B7;
	Wed, 20 Sep 2023 00:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF9A49
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:47:37 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00AAB
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:47:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-273e3d8b57aso1245898a91.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695170856; x=1695775656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AlF1cRPcnyYorAHWpBa+cITvdY6lTi5Rf+RFhzV6TI=;
        b=aNz86GAFx90yJQNYB7AZRqPte8MqJlppgXdXhiJJWpR4HrlU1ixiIb9loCTumywxRA
         h/jWhcs3yhZjFM1TDz/v+d3jif+SLSsnHl2nXtOEo3yArYZgc+YEeYDhMK2SkL4EZeSb
         32g4jmhxnmxkLIWKRxPLvp6t7AE0vAxO9CT8uflwlMTFfcmPhHh1uoxhiwQQXbufSDMX
         KFPZGDHHB7iqSR4mLmXpn4Tt6UxD2yFf6uCKIILNayJH9ZDYX7JCy8ENSH49TisnsRYf
         ILeIgcUfR9/UaEIeIUX5nbYCeLu1vdTG+qszZLhrFDCsj0F9ZtFUrVC3IxFz8Ho195aA
         pm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170856; x=1695775656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AlF1cRPcnyYorAHWpBa+cITvdY6lTi5Rf+RFhzV6TI=;
        b=ntg6Qgd10EOQM1F8aTZm+akXyypwsVAQHJnc2xjqF50aCsMVQl4ZDqE9Z/DlyQnaMd
         6Mxu5JqOARUU0f5rgoDKJgl+JLsspILp87SDrNb/5q3nrCg1vXENhoUQ84UWWT9ZrxxA
         vgRbe7ac6T+v7OWphnuniydWqVnir90dcMibpspRrc67ULN04FO5km+wnm7I5oJU/xxB
         F6QxuDRM/v5aWVfuNuw0TrQusSqFsF+arytXvVByZaDJM5zdWcK6M+XNBiXnsyROSG4U
         twEY9gmDGnk1grTKWofyZqTHEbNktQL43uvGzh8WsRn/QTl//1At1V2gybvW3k0K1bHy
         qspg==
X-Gm-Message-State: AOJu0YybVCtLZeNrC06oPa9QKAWT+ek2y2spEU6esVwdW8jBqKttFkH0
	UHsrlLin6mnWKkhZfN2lSBS5nxrDBcdZ12eB1sE=
X-Google-Smtp-Source: AGHT+IHTP4svt7wOSkZQBQC1QKbA+jjgfALDS4zuzhV6liighCQOFtAZABpOYLH/h1xgZXvZEN0X84a/THkEKK7rvFQ=
X-Received: by 2002:a17:90a:7c01:b0:263:730b:f568 with SMTP id
 v1-20020a17090a7c0100b00263730bf568mr1169875pjf.3.1695170856227; Tue, 19 Sep
 2023 17:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch> <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch> <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch> <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
 <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch> <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
 <15320949-6ee3-48f3-b61d-aaa88533d652@lunn.ch>
In-Reply-To: <15320949-6ee3-48f3-b61d-aaa88533d652@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 19 Sep 2023 21:47:24 -0300
Message-ID: <CAOMZO5BV3MucdxhEXhLy+XTo7yh5vGDHuA1r82B8vdrexo+N6g@mail.gmail.com>
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

On Tue, Sep 19, 2023 at 4:44=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Good question. The datasheets i have don't actually say!
>
> I'm assuming there are two pins which can be strapped to give the
> value of SW_MODE, and a value of 2 indicates standalone. But i've no
> idea which pins they are.

What is the register I need to dump in the mv88e6xxx driver to check
the value of SW_MODE?

Thanks

