Return-Path: <netdev+bounces-28841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC6E780FCA
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EE4282414
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679719BA2;
	Fri, 18 Aug 2023 16:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789CFEACB
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:06:16 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9CEE42
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:06:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d650a22abd7so1036880276.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692374773; x=1692979573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOCZ3mU0SDAqejr/PfWkmK2YNG5i91XLayQm8EMGad4=;
        b=FzOb6s8iRznl8k7Ec0NtmIb00el9lCVwdV5W0nhhyotJF6KVCVRFu7RnxjWmGyg9wu
         fx79z14Q4Oq0Fx6BeXJgLDEwtktdzmUYPKfSg5SqFhiQN5Ln9rJwBVlsbdncMHoqI53A
         tx53Cci3rErQfq8MnqJ5aX7w/Ms3vwTJCPeCzOzBsKvIDzTkROi8k5CyiRg2Hxnwxwaw
         rb/KEd+LEaxBkVv+EB540FSzrJPAFLyFCWMpIjTG4J/mqO8pEcsz4V3C625fc4llFoV1
         3XrqH+X06SLoSggpzitZle4rzg417JDVoFFPUHMfA5roavSycOZi+siMdKJTCeAuJXDY
         DrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692374773; x=1692979573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOCZ3mU0SDAqejr/PfWkmK2YNG5i91XLayQm8EMGad4=;
        b=fmug9pO+6Bdmgfkcvx5erhLiy3zfKhyl0I2sI1fghLq5oBBaKH3mxaqe+Cv4TEIBQg
         lk3lxA+dRfIj6hoDvaad5xAgIxb0N83FVntI+HsNDdB9LK8aQwT3rCaD/UZeykkj0fqD
         U238pyVK0sv3qAm9zKyR+RMCpnEJQepNK1sfBBTa9rPMnwsMDP1DGN/N41TWN/5bKAag
         29Pv5M5ETAI6jKss7ejED2i2dNAuYQmFKE62o/ZxgNPy76vu/5GuoAfWnMJmI3idFf/W
         ZLHd+grAZpSRG2G/Fml86WHdy+bj07iIhG5dblFOFzyTs0dWfZYtYYtdq33WyBYKNiKG
         yA6g==
X-Gm-Message-State: AOJu0YyGVpFghLOWraWerdOTT+iK8tMn8WdO1tpkWL6iwXm1WPlI8Min
	f4V5pzJFIJGz1C2fuVkxhMqkIgdV7i2gvbMJpTeAjg==
X-Google-Smtp-Source: AGHT+IGsNt9/vLiZtyWGdVIGJHK/q5xeYBg1Je6F5sPbbo4vC4GHp8KeqREry2fZXxa/Zx8eiAbsxlrokIDs8MI8XW0=
X-Received: by 2002:a25:a127:0:b0:d49:9ba4:bea8 with SMTP id
 z36-20020a25a127000000b00d499ba4bea8mr2706941ybh.40.1692374773302; Fri, 18
 Aug 2023 09:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk> <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk> <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <20230817182729.q6rf327t7dfzxiow@skbuf> <65657a0e-0b54-4af4-8a38-988b7393a9f5@lunn.ch>
 <20230817191754.vopvjus6gjkojyjz@skbuf> <ZN9R00LPUPlkb9sV@shell.armlinux.org.uk>
 <20230818114055.ovuh33cxanwgc63u@skbuf> <CACRpkdYf-VwCUFigjb1ZHJfieXkxqLSwVmG_S-SKJQY1bciCHA@mail.gmail.com>
 <ZN9ySD2ewIgLTtlm@shell.armlinux.org.uk>
In-Reply-To: <ZN9ySD2ewIgLTtlm@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 18 Aug 2023 18:06:01 +0200
Message-ID: <CACRpkdbMYHdNAYdS8u+jtaW8NZ7WkCPYug8Xsb2nQLjPvTxKOg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 3:29=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> > So skew-delay of 7 steps, each step is ~0.2ns so all pins have a delay
> > of 7*0.2 =3D 1.4ns.
>
> If I read this correctly, then isn't this 1.4ns delay added not only
> to the RXD and TXD signals, but also RXC and TXC - meaning that although
> there is a delay, the effect is that (e.g.) the relative delay between
> TXC and TXD is zero?

Yes seems like so.

(second instance)

> So here, the skews are:
> - GMAC0 RXD skewed by 7 =3D 1.4ns, and GMAC0 RXC by 10, making 2ns.
>         Relative skew =3D 0.6ns.
>
> - GMAC0 TXD by 5 =3D 1.0ns, and GMAC0 TXD by 10, making 2ns.
>         Relative skew =3D 1ns.
>
> I think this suggests there's additional skew by the PCB traces to make
> up to the required 1.5 to 2ns skew required by RGMII.

I believe you're right. Also when I looked at that PCB it had a few
swirly traces on it.
https://openwrt.org/_media/media/dlink/dns-313/dns-313-front-large.jpg
Again they seem to be toward the RAM mostly, but I don't know
where these vias go, and clearly the PCB designer is doing some
active work on it.

> As far as I'm concerned, I think I have an overall picture of what is
> going on here - it's whether anyone else agrees with that!
>
> Going back to the 685, the skews for the datalines and clocks are:
>
>         gmac0                          rtl8366rb
>         pinctrl ----- pcb traces ----- pinstrapped
> RXC     1.4ns         unknown          unknown
> RXD*    1.4ns         unknown          unknown
> TXC     1.4ns         unknown          unknown
> TXD*    1.4ns         unknown          unknown
>
> In the case of 313:
>
>         gmac0                          PHY
>         pinctrl ----- pcb traces ----- phy0
> RXC     2.0ns         unknown          0ns      (PHY 0ns due to using
> RXD*    1.4ns         unknown          0ns       phy-mode =3D "rgmii" on)
> TXC     2.0ns         unknown          0ns       gmac0's node.)
> TXD*    1.0ns         unknown          0ns

Yep that's how it looks.

Yours,
Linus Walleij

