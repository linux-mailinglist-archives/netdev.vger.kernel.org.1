Return-Path: <netdev+bounces-31082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ACD78B471
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D535B280D14
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA082134BA;
	Mon, 28 Aug 2023 15:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7746AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:30:18 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5018A8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:30:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so430811cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693236617; x=1693841417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHwiUSc+uWA1Rbd7YK/jpFoMnuVIcmjTIsyhIXRsILw=;
        b=wUmCHvKsH74G+jwdwQA+osClt1fkPRufETY3DzpYqN8TFOmqvfof6ICIDAX55z2v4T
         fHV/tZPG05meGCGSIaOyY0V56BAf/oMd9FEkB6SMsxwsLW/I4SoAyKgIBhY+dInItkXY
         9Qtw5LO83AEC46Pt3BbR1ML6MDZxkI96Rop5yqYSKu0RiIML/FBd2xAnF+t2LmRj6+0C
         ZnaLbBLNiUTWjv/hHDU4pZHOQDbauN7iDULnN66OOF1R+xOFwlSyWP0M0ELamceEu8oK
         Srsj4MfW677wg5RPB+6b//WjP5hwR30oRoP40PztIjHMZb9boS40XdJCLEoX58UgKlTY
         OM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693236617; x=1693841417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHwiUSc+uWA1Rbd7YK/jpFoMnuVIcmjTIsyhIXRsILw=;
        b=kkcR9NFAhjpHDw6weSAHpc78aiet8iPuCV3uCynBNfIhJ0RALOMqMp5a/X4wQTY/tp
         0tzIOSVG0FoqH0YgsMBLzRokjkYj8rFJGJoWRvVrdyRt+B6/Np/vT6GKhNeuZ24BSlAG
         T5wdz5DRWpf2G5L/V6mJLRQU1F2mg+oKRbxm2JoFc8M05qSeo0IJaMMBVg9MlVNpz3X9
         z9vnoH9UACU8sfW9WRXT+YLBsg6MJ0dGxWf+Zv7HQlx9zZlXGYckt3EGd9HHkdD0qUW1
         c+f0M9rO9tUAIG8qmSBEFK+s55MzW3x8iKVBCox7kdZVdim60GHdPLEMmBC29govtUYu
         usOg==
X-Gm-Message-State: AOJu0YyQAExlzBVQlJ4Aqq4cBggWXW1SJNi/FA3D+/AqGFvHnBVbWuws
	FVPrAiLfziDi+ZwGZNtXqlP7s/mBlMFWDPgySOKmQAORJapvbxAef2kt1Q==
X-Google-Smtp-Source: AGHT+IFYPClriJ4SEpYxmvRyLo5H9Vkm9XuBS2YBeD8e0WqyXw5EwmWzDXZ8Xb6JPenZS87vssc3whuGAywR5FTkKa8=
X-Received: by 2002:ac8:5b42:0:b0:410:9855:ac6 with SMTP id
 n2-20020ac85b42000000b0041098550ac6mr452516qtw.14.1693236616529; Mon, 28 Aug
 2023 08:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828113055.2685471-1-edumazet@google.com> <0cc17b1240c94bc2b44364e67afb838e@AcuMS.aculab.com>
In-Reply-To: <0cc17b1240c94bc2b44364e67afb838e@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Aug 2023 17:30:05 +0200
Message-ID: <CANn89i+GJB=ZN7q0G_i+Q2DLvw6=3Ma8L0B7dDqLXLbBKUQdOw@mail.gmail.com>
Subject: Re: [PATCH net] net: read sk->sk_family once in sk_mc_loop()
To: David Laight <David.Laight@aculab.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 4:21=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Eric Dumazet
> > Sent: 28 August 2023 12:31
> >
> > syzbot is playing with IPV6_ADDRFORM quite a lot these days,
> > and managed to hit the WARN_ON_ONCE(1) in sk_mc_loop()
> >
> > We have many more similar issues to fix.
>
> Is it worth revisiting the use of volatile?

What would you suggest ?

> If all accesses to a field have to be marked READ_ONCE()
> and WRITE_ONCE() then isn't that just 'volatile'?

Not all accesses to this field need to be volatile.

For instance, many readers also hold the socket lock,
the field can not change for them.


>
> IIRC READ_ONCE() (well ACCESS_ONCE()) was originally only
> used to stop the compiler re-reading a value.
> The current code also worries about the compiler generating
> non-atomic read/write (even to a 32bit word).
> So typically all references end up being annotated.

Not in sections with mutual exclusion.


>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

