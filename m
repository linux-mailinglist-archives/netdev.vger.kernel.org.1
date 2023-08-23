Return-Path: <netdev+bounces-29847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B751784EE1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 04:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DD9281269
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3515BC;
	Wed, 23 Aug 2023 02:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CD15B5
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:48:32 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC11A5;
	Tue, 22 Aug 2023 19:48:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so6470973a12.1;
        Tue, 22 Aug 2023 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692758909; x=1693363709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVBRCz0FtwctX/FsxJ5r2bQ6j0LCaWp9EglVQZcAENc=;
        b=MOP4XuYh0256gpCDmE1yT6Cr1aYKpaF7KxQMOCK/P+pbJ5loYJpYHL2u32eNKm1zmt
         mljtx7b3m8Ziz43TGydP9W0Lmmgn/lTQx7tFXIWufkE7kK4q4OL7kX+qM5MCqNQXVIVp
         WZf7QLKquIjIMs8vXjJ5PDxCNeg5J3keWoHcR24N2CvgLa63H+X9LJQ1XUvYgpKO89e9
         +UsRr1U2xe6eXP0khCzRFdyEyNrSSQ8zotdgR6cU4D0h8HaAjPGctTnfEDAbM0y2oZqP
         Ler+yfCjSr2BtwMhJW1zCMssvEnhmHke1PqwwR4WzHc9BL4Xmc9UOO1WIvb/lpK0dD00
         Q0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692758909; x=1693363709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVBRCz0FtwctX/FsxJ5r2bQ6j0LCaWp9EglVQZcAENc=;
        b=BnF5EwxlmQJyJclJRoIQjLNp4Jk0C9bYwmT2OAoDleL/N1t/zX508BnwcQREhZDy9R
         N7IdhGVUXAFLZUqQk7vaDTfJl/vDy03SRWcBKYIxoPXrJjYN9lX118sdqdRr9wyudgpa
         jLxOrkf2MTsVQmg/HfqVu7sSiZz1WgRBHVNPMNU9yUzsiRrotUUm5V7GvVi1/SDBBHrL
         2BSHB9mcLqrg/AsAhkwPg5Zgsf3JPXLh6+6bk+hMFcyOp3fWcwWBljKF8jjh4aOzX26b
         KNaaapdAWWjr54OHZnEwzt2qOG3PyNT8LJmIhYuevwprlX12SmXS9Q4Knz95EsQLQoSH
         yBhg==
X-Gm-Message-State: AOJu0Yy4YkbSgpkJweJDEHjTNqmHDJRaEEQUdG+sVctnn96/vD0ZtgnZ
	53J25aIZj0EmHz1uFFhL8MHajAs6E1L7LCzDmso=
X-Google-Smtp-Source: AGHT+IEEmtoammYVQnitMdyPCplu8QA/DHBw30yzP7StIYtxQsK1M9uKl3jkTahi6c4fsTk+WfnsLILksJ0xiFyrA4s=
X-Received: by 2002:a05:6402:14c3:b0:523:1e18:3a78 with SMTP id
 f3-20020a05640214c300b005231e183a78mr8831836edx.12.1692758909416; Tue, 22 Aug
 2023 19:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com> <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
 <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com> <150ae6c1-8a2f-4fd7-b012-a53a909919d4@lunn.ch>
In-Reply-To: <150ae6c1-8a2f-4fd7-b012-a53a909919d4@lunn.ch>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Wed, 23 Aug 2023 10:47:53 +0800
Message-ID: <CAJhJPsUatqsa_D_RZ8ej33cGPRixhi7A2=2VBOSJVK6xNAA0jA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 11:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > > What about the other three RGMII modes? Plain rgmii is pretty unusual=
,
> > > rgmii-id is the most used.
> > >
> > According to the LS1B datasheet, only RGMII and MII are supported.
> > And I can confirm that MII mode does work for LS1B.
>
> What does your device tree look like? What are you setting phy-mode to
> in the rgmii case? As i said, "rgmii" is pretty unusual, you normally
> need "rgmii-id".
>
> Something in the system needs to add 2ns delays to the RGMII clock
> lines. Generally in device tree you pass phy-mode =3D "rgmii-id"; The
> MAC configures itself for RGMII, and passes
> PHY_INTERFACE_MODE_RGMII_ID to the PHY when it is attached. The PHY
> then inserts the delays.
>
> What is inserting the delays in your system?
>
I understand the delay issue of RGMII.
Just tried phy-mode =3D "rgmii-id", it still works.
I will use PHY_INTERFACE_MODE_RGMII_ID instead.
Thanks!

>      Andrew
>


--=20
Best regards,

Keguang Zhang

