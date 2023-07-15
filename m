Return-Path: <netdev+bounces-18056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8487546CF
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 06:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479031C2169D
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C20DEC5;
	Sat, 15 Jul 2023 04:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4DEA6
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 04:19:49 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849835A8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 21:19:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8c81e36c0so16414515ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 21:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689394787; x=1691986787;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Abwx+jAeM+t7u/g3iVkLqbv1gBJmiEHwP823l6qDQ74=;
        b=oLWJlS5qYV2Be1oLkRUnz4ZbDpt6H0p51n3ZUVSlZR631xydMyE8zd3GK3yiO0NHop
         ugwHmubh9yFq51NDySx7LrOJI2oYPEmVSvaxDZVTh+qTbvf+zeJNgrvRncmxeuUpBX0P
         rH9M0QgNCLcEy9dvLyWEZPMhniEJI6o2cl8gzBQ1El8NdkKzfm4sCueXWtqzZB0GfFej
         jT7eB6boNUgTOjB4TxveKJ8jvhwUgfg8SHDjCTtGdDt+ZV9nMEE94mc7hCY1m2m2UaSg
         iLtQEm8xoY0tF1zWCWp+0iJar087+S0Om+689weRM4QQt1PdW7//46lAwOJGygYEj1Cw
         aE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689394787; x=1691986787;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abwx+jAeM+t7u/g3iVkLqbv1gBJmiEHwP823l6qDQ74=;
        b=QGpy0kMt6SCebj9rIs+7FFOZXmoYthOcIpnig1J9IcV3vMJmP5jG/uUFG7gzAy+ikx
         srJDWORe5/THWgRSYxILRcha4XEtuEtdaZCLsYCLDmYnplITgIrQ/lnsQM2GMOnvysUg
         qYY3sRHCEpDBOXR5h1OZfXwSWmujHK5LP5YfIsLMcX5E1DWcvl9fYAtFKQwHx5XhHuD6
         /vapPfc4oVMsJ0reTQ1Qw5C6nidod7FBu8zWj40mCrVU/vlCSFykHgyeRQXoghGo+wKh
         /vvOxT5uWNdyUgHxPb01x5ek6ma33cPAmitQ3coIE8X7MLKqBp5WuHIrAyH3u214lNby
         Fiiw==
X-Gm-Message-State: ABy/qLa0S1J4qbrB79E6NtUXVR64zDo1LI38b4ylZeW+h+bdzZ8EsJ7h
	l3AR9qinMd03bAJYijg3kk/wNLfocJQ=
X-Google-Smtp-Source: APBJJlFFTxHgFKhMt1ee3H6NfMo72QQfmXUh3dX+VUwOcjVB1cZ0O2xFdUBzRlUVmlTQ2HQYoqNzWA==
X-Received: by 2002:a17:903:244c:b0:1b7:f443:c7f8 with SMTP id l12-20020a170903244c00b001b7f443c7f8mr7607945pls.15.1689394787477;
        Fri, 14 Jul 2023 21:19:47 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:7012:79ba:4cb7:19db:2d75:7405])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902b09000b001b8422f1000sm8507921plr.201.2023.07.14.21.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 21:19:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Query on acpi support for dsa driver
Date: Fri, 14 Jul 2023 21:19:35 -0700
Message-Id: <90E52C81-147B-4EA1-8AB7-359BE342986C@gmail.com>
References: <4370398e-fe9b-44f6-bba5-c0bb2ead9d58@lunn.ch>
Cc: netdev@vger.kernel.org
In-Reply-To: <4370398e-fe9b-44f6-bba5-c0bb2ead9d58@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you Andrew for the quick reply and helping this. I will have a look in=
to the sample driver code you provided  and let you know if I have any more q=
ueries.=20



Regards
Simon

Sent from my iPhone

> On Jul 14, 2023, at 8:17 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> =EF=BB=BFOn Fri, Jul 14, 2023 at 07:46:27PM -0700, SIMON BABY wrote:
>=20
>> Thanks Andrew . So if I add a platform driver, will it get triggered
>> by ACPI table or Device Tree or by some other mechanism?
>=20
> There are a couple of options.
>=20
> You can just load the module, e.g. via /etc/modules. That is the
> simplest solution.
>=20
> If your board has unique BIOS identity strings, you can use that to
> trigger loading. e.g. look at drivers/platform/x86/pcengines-apuv2.c.
>=20
> apu_gpio_dmi_table[] __initconst =3D {
>=20
>        /* APU2 w/ legacy BIOS < 4.0.8 */
>        {
>                .ident          =3D "apu2",
>                .matches        =3D {
>                        DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
>                        DMI_MATCH(DMI_BOARD_NAME, "APU2")
>                },
>                .driver_data    =3D (void *)&board_apu2,
>        },
>=20
> But they BIOS strings need to be unique to your product. If you have a
> generic ComExpress module for example as the core of your product, you
> need to customise the BIOS strings. Otherwise this platform driver
> module will be loaded for any product which happens to have that
> ComExpress card, not just your product.
>=20
>> My goal is to see all the switch ports in Linux kernel . The switch
>> is connected via I2C bus .
>=20
> Yes, that is the idea of DSA. You can treat the switch ports as Linux
> interfaces. All you need is the control plain bus, i2c in your case,
> and a 'SoC' Ethernet interface connected to one of the ports of the
> switch. I say 'SoC' because such systems are typically ARM or MIPS
> systems with an integrated Ethernet controller, but i guess you have a
> PCIe NIC? i210 or something like that? That works equally as well.
>=20
>     Andrew

