Return-Path: <netdev+bounces-27198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62377ADBE
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 23:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A40280F7D
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81E9461;
	Sun, 13 Aug 2023 21:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575629446
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 21:56:56 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43173198E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:56:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d62b9bd5b03so3696971276.1
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691963812; x=1692568612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KiZuHS3QoxSdwnFdy9QY8UXNOtyytTSsyW4cPJjYU4=;
        b=VTDoClbSOUt2JHky22PBhC+q2g7DbkxlILQe2Q1U1N3CWax+C7Yks1lz8vD/y3v2H2
         T28MLbhfo0yix5ETuJI7QLq/wS5H5opnfo4Lnue1r3G5epo23BaNnBzWf4KJzZYkJJsT
         gXhFm1QRsAIrjNYFghXkQ99eReFBAFv/s+yRFhZH5uFvzBNhwfIfE6JLMTXFbeJGSDzU
         b0ZLA1kgELYNc2+3eVd4sG208CVNyWDUUIGfxNAguyYKtyBXJdnyZyenVhJQGs5xHW59
         XvrTJ67fw1goDRkA51d4NjEIXhMDvVBfwjZTT+jolX7MbOzvsMAXJ6W3jXQOPIuIOAwM
         pJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691963812; x=1692568612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KiZuHS3QoxSdwnFdy9QY8UXNOtyytTSsyW4cPJjYU4=;
        b=UiAFQwov+uhB4Ojvigi5X8U2ZxgFre+D1LekJfKOMkCobIb2P1isWZzZAsLA1Kt1Ca
         SnR8sW49cNcfn0VhNf6j4FAftGphjpkdNca0GinrKP9mvI+BT3MzSMGijTdpeu5kdSXs
         Bylkt8/qj6Viwg4/UPiR3wkBoEY69UWMiZrFpUZJ8IGqsamqxlTTkycthc1wZOWtfKV5
         c99hQXY/cStPAw2D5TWEq8mSQB1kTvYifFYHpUKetl6ku35YlU3k89hZTWzjQMAUAjSJ
         yGXu0E2k7HnUgeAiPuqGd4mhqvlvVKcvaiygwvN2sjgAEnv+7sNsqkwiHF1KODrr/g8l
         GWoQ==
X-Gm-Message-State: AOJu0YzV9KynmEFsAfr2188VjjRMJqrWOUFyZ8v2eKS6UESdTfBRGrPE
	j4ZvqGutjypw0f1tOENDngnefnGC9p3Eh2508pquKQ==
X-Google-Smtp-Source: AGHT+IEhboBQj3zZsq1Vo6sWVbqHOmdmkYoZxKaIxWcEbeaL/VJi9oZP/0bLmhYZzRfIOJP/4oEJhwhK31FZEfCS+0A=
X-Received: by 2002:a0d:ed45:0:b0:583:f02e:b92c with SMTP id
 w66-20020a0ded45000000b00583f02eb92cmr8910828ywe.17.1691963812489; Sun, 13
 Aug 2023 14:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk> <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk> <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk> <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk> <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
In-Reply-To: <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 13 Aug 2023 23:56:40 +0200
Message-ID: <CACRpkdbN9Vbk+NzeLRNz9ZhSMnJEOF=Af52hjUAmnaTdK9ytvw@mail.gmail.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 2:16=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> That leaves the RTL836x driver, for which I've found:
>
> http://realtek.info/pdf/rtl8366_8369_datasheet_1-1.pdf
>
> and that indicates that the user ports use RSGMII which is SGMII with
> a clock in one direction.

Sadly that datasheet has been pretty far off the RTL8366RB,
the "RB" in the end means "revision B" and things changed a
lot there.

What I mostly used was a DD-WRT vendor code drop, which is pretty
terse, but can be used for guesswork:
https://svn.dd-wrt.com//browser/src/linux/universal/linux-3.2/drivers/net/e=
thernet/raeth/rb

> The only dts I can find is:
>
> arch/arm/boot/dts/gemini-dlink-dir-685.dts
>
> which doesn't specify phy-mode for these, so that'll be using the
> phylib default of GMII.

Hm. That file is my educated guesses and trial-and-error at times,
due to lack of documentation. It shouldn't be trusted too much.

> So for realtek, I propose (completely untested):

I applied it and it all works fine afterwards on the DIR-685.
Should I test some different configs in the DTS as well?

Yours,
Linus Walleij

