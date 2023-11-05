Return-Path: <netdev+bounces-46109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D37E16A7
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 21:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D325B20C93
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7F179A4;
	Sun,  5 Nov 2023 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDJJexQ7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027E11723
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:56:38 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD3EDE
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 12:56:36 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7dd65052aso45819957b3.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217796; x=1699822596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6QEyl2SUHinJLODwuehCU3YQb03M8xY6TOhu/4Xq68=;
        b=CDJJexQ7h/6F+C6pkgO0vRYt3HKgKk9/8ZbVT/xo0Lxp1uC40IP7On1djHawUiEJzO
         c9uDlO5ATBKKhUchIQAle270lZrKmyqg9+FG+yZxzj5ADbWeCfgzQ2rbgsn1qC1FxEi6
         B47k0NY7RZbuwrLvaFo/cytLtwvsfpHDW+r0CThA0DtErzveKf5fSGhZwA73pJ/JNqkI
         nWzYpP7eUW9QB1BWT7YjAUNQsWYQumPQzIIFegFBR35RXCccy4vKLgzFZsaVs2GBk5Fj
         vfAp5YnrdaRnHRn61Wg0qDzNihObHKmD9WUhrotRx+0Pz2i5dfWR6vB5L643rzu+18qL
         OeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217796; x=1699822596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6QEyl2SUHinJLODwuehCU3YQb03M8xY6TOhu/4Xq68=;
        b=ZcY3rh87RkxAMqmfO1HKD+uUc3Sb96+kawXdGNwFPrQJ3tZzFoW/XlL15um1E3HCpV
         6WSitnng0cVu+54HZQTxLs1LvD7oJdEe1tpFF0nQuXKTCNUinsfas5VYNornjJjVdEVH
         huBJ5lvaII5F3Nei8QPJxiXcIp4bFQxI2/Ev6sG+pBhQoaazcM3M8UacdNR9Aaef2iVS
         hQcX0X9W/NE6gbO6DrdPMYpexITW+aeULkxDnLl2hBeW9gcWfg2qOHT+PD/0N/f5pm1K
         oFVLJfgYwlRe6jQggJaAIKMq/uO1CUC6ypbXX7fA5e/TYouyg+P6pkyrB4IHfT1nRlUV
         k0GQ==
X-Gm-Message-State: AOJu0YzWuMSXs88JKiKkPx7iwUPmqSXz5sgomH0s6g/TYnA3cKs4wpxU
	WKntZ+l7aNWBcOlpX+HH553U7YV/fLoZKK3i/rG/aA==
X-Google-Smtp-Source: AGHT+IGrBlLDBzl5QYMUEq8ZYbSLDgWpthp2RHHdVa+K8PvdjwCEDI/B3NFocFtHXGZ/fdZx5BrNzzTlf4Vzkt9zu6k=
X-Received: by 2002:a05:690c:a:b0:59e:9a44:9db9 with SMTP id
 bc10-20020a05690c000a00b0059e9a449db9mr8923885ywb.26.1699217795923; Sun, 05
 Nov 2023 12:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org> <036b481e-ac5b-4e77-b93a-4badaf19e185@lunn.ch>
In-Reply-To: <036b481e-ac5b-4e77-b93a-4badaf19e185@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 5 Nov 2023 21:56:23 +0100
Message-ID: <CACRpkdYp1kiGY0K7kNF+qadPyq1hu3G=2oc1gXnCt3DjtiJxag@mail.gmail.com>
Subject: Re: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Vladimir Oltean <olteanv@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 3:57=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> > +              * Just bypass on bigger frames.
> > +              */
> > +             word1 |=3D TSS_BYPASS_BIT;
> > +     } else if (skb->ip_summed !=3D CHECKSUM_NONE) {
>
> I've never looked at how the network stack does checksums. But looking
> at this patch, it made me wounder, how do you tell the stack it needs
> to do a software checksum because the hardware cannot?

I read up on it: the documentation is in
Documentation/networking/checksum-offloads.rst
and in the header for skbuff, include/linux/skbuff.h

Actually we should check for =3D=3D CHECKSUM_PARTIAL which means
we need to do the checksum (!=3D CHECKSUM_NONE is not inclusive)
then I call a software fallback directly from the driver if I need to.

> Or for this
> driver, is it always calculating a checksum, which is then ignored?
> Maybe you can improve performance a little but disabling software
> checksum when it is not needed?

The ping was somehow working without proper checksum
before, but I think I'm doing the right thing now, also tested with
HTTP traffic, check out v2.

Thanks for pointing it out, the patch looks way better now.

Yours,
Linus Walleij

