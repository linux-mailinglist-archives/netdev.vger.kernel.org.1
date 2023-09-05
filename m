Return-Path: <netdev+bounces-31992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C590792034
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 05:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F71E1C208CA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 03:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171FA64D;
	Tue,  5 Sep 2023 03:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096397E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 03:49:32 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7810ECC7
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 20:49:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c334b2bb80so271435ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 20:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693885771; x=1694490571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDLId4TsosB+qEb7Rzbnrce1ZoEBg6EkK/XtsNqDzWs=;
        b=7t9+w4r55RqVT9Xq8fZKRo0unvcq6Zb1DQ57MSZWBh8+0B+EU0devNjlcFoS+kjtN+
         OuulkOieyiWfxgDFUcHY3FeIcefmXH1+AuwZoaeuB1kS28pGJFK7BzNz/GKvi1K48Ze2
         O8YHpYNdyf/Vyw8Zp0/9VFUzCSuUsXCqoges6JUK8538OOsFf+62y9vVS6wCMP0PnKQ+
         Sv+NUZQxjCIYfE/UcEQxsyDF7tgvQchP9w8/h+swbLbrBwJu6K+oU8fQsfakCfF1Y4pk
         ek2f10sNIMDE/jsAsFBKcAoL9UQQBogmRgTadFWPOJlzir7/rh3deAWd/d6y/qxK5QqW
         Byng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885771; x=1694490571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDLId4TsosB+qEb7Rzbnrce1ZoEBg6EkK/XtsNqDzWs=;
        b=hraVGZmCYtJtvBG6V8/y9tKX/E9FLw12kPNARB0yakgyLLkQ5ZC+tAZhtCC+fr2KVA
         ffmqzMR1t0UY7gNuq25D0c3E/DmbattWiCdQ1lSn2viJ/ArTWzZTHjEgpeDBcU6yShuU
         JE2IUh/SO2TqA2kgAo044+BYX2X47qhldNXivO8L/Rjr6nFkRZBC02S80/74y0ci8Ehh
         /lmKOEpHm6hAyjuqhArXA2ahqb0H+tczSKjGBStMNgIHX6QhK9CNc9tW0TpfegK59L8g
         ptN1bGtee5IPLF/EVI0RdRjJgG9K4R6I0WVptfhMJzGdkhMOK1emlKY2+i/Q5fmMvIVs
         eyeQ==
X-Gm-Message-State: AOJu0YxQ8dLgfe3LIJwZCwJdhXALOdHRy1ake33K0dvOCe0ZAM4uyMEE
	yG+PkfKBldacpE4C/9O855V5f6IGKkWjZeqLBOMs4A==
X-Google-Smtp-Source: AGHT+IFN1MsXoc6i0dmksoV6OMb+OrlWA7r66XnZebeyxIqtq0zfhVi8u/+N9Q5Dkx3mQ/BNNbkfGwcDhbKpsIA0/CY=
X-Received: by 2002:a17:902:ecc9:b0:1bc:4452:59c6 with SMTP id
 a9-20020a170902ecc900b001bc445259c6mr544982plh.18.1693885770576; Mon, 04 Sep
 2023 20:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831183750.2952307-1-edumazet@google.com> <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com> <ZPZtBWm06f321Tp/@westworld>
 <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
In-Reply-To: <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Sep 2023 05:49:19 +0200
Message-ID: <CANn89i+UN32c+-1RdtcuUF0+pDEG5dMGtO41tNZtz4Y=V7f87A@mail.gmail.com>
Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
To: Kyle Zeng <zengyhkyle@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	syzbot <syzkaller@googlegroups.com>, Kees Cook <keescook@chromium.org>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 5, 2023 at 5:41=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 5, 2023 at 1:49=E2=80=AFAM Kyle Zeng <zengyhkyle@gmail.com> w=
rote:
> >
> > On Mon, Sep 04, 2023 at 09:27:28AM +0000, David Laight wrote:
> > > From: Eric Dumazet <edumazet@google.com>
> > > > Sent: 04 September 2023 10:06
> > > > To: David Laight <David.Laight@ACULAB.COM>
> > > > Cc: David S . Miller <davem@davemloft.net>; Jakub Kicinski <kuba@ke=
rnel.org>; Paolo Abeni
> > > > <pabeni@redhat.com>; netdev@vger.kernel.org; eric.dumazet@gmail.com=
; syzbot
> > > > <syzkaller@googlegroups.com>; Kyle Zeng <zengyhkyle@gmail.com>; Kee=
s Cook <keescook@chromium.org>;
> > > > Vlastimil Babka <vbabka@suse.cz>
> > > > Subject: Re: [PATCH net] net: deal with integer overflows in kmallo=
c_reserve()
> > > >
> > > > On Mon, Sep 4, 2023 at 10:41=E2=80=AFAM David Laight <David.Laight@=
aculab.com> wrote:
> > > > >
> > > > > From: Eric Dumazet
> > > > > > Sent: 31 August 2023 19:38
> > > > > >
> > > > > > Blamed commit changed:
> > > > > >     ptr =3D kmalloc(size);
> > > > > >     if (ptr)
> > > > > >       size =3D ksize(ptr);
> > > > > >
> > > > > > to:
> > > > > >     size =3D kmalloc_size_roundup(size);
> > > > > >     ptr =3D kmalloc(size);
> > > > > >
> > > > > > This allowed various crash as reported by syzbot [1]
> > > > > > and Kyle Zeng.
> > > > > >
> > > > > > Problem is that if @size is bigger than 0x80000001,
> > > > > > kmalloc_size_roundup(size) returns 2^32.
> > > > > >
> > > > > > kmalloc_reserve() uses a 32bit variable (obj_size),
> > > > > > so 2^32 is truncated to 0.
> > > > >
> > > > > Can this happen on 32bit arch?
> > > > > In that case kmalloc_size_roundup() will return 0.
> > > >
> > > > Maybe, but this would be a bug in kmalloc_size_roundup()
> > >
> > > That contains:
> > >       /* Short-circuit saturated "too-large" case. */
> > >       if (unlikely(size =3D=3D SIZE_MAX))
> > >               return SIZE_MAX;
> > >
> > > It can also return 0 on failure, I can't remember if kmalloc(0)
> > > is guaranteed to be NULL (malloc(0) can do 'other things').
> > >
> > > Which is entirely hopeless since MAX_SIZE is (size_t)-1.
> > >
> > > IIRC kmalloc() has a size limit (max 'order' of pages) so
> > > kmalloc_size_roundup() ought check for that (or its max value).
> > >
> > > The final:
> > >       /* The flags don't matter since size_index is common to all. */
> > >       c =3D kmalloc_slab(size, GFP_KERNEL);
> > >       return c ? c->object_size : 0;
> > > probably ought to return size if c is even NULL.
> > >
> > >       David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,=
 MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> >
> > > It can also return 0 on failure, I can't remember if kmalloc(0)
> > > is guaranteed to be NULL (malloc(0) can do 'other things').
> > kmalloc(0) returns ZERO_SIZE_PTR (16).
> >
> > My proposed patch is to check the return value of kmalloc, making sure =
it is neither NULL or ZERO_SIZE_PTR. The patch is attached. It should work =
for both 32bit and 64bit systems.
>
> Again, I do not want this patch, I want to fix the root cause(s).
>
> It makes no sense to allow dev->mtu to be as big as 0x7fffffff and
> ultimately allow size to be bigger than 0x80000000
> I prefer waiting for net-next to open first.
>
> Adding code in the fast path for something that must not ever happen is a=
 no go.
>
> Only CONFIG_DEBUG_NET=3Dy stuff could be accepted.

I will shortly submit this fix for igmpv3_newpack().

It will be useful even if we allow dev->mtu to be in the vicinity of
KMALLOC_MAX_SIZE

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 0c9e768e5628b1c8fd7e87bebe528762ea4a6e1e..418e5fb58fd3f2443f3c88fde5c=
0776805a832ef
100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -353,8 +353,9 @@ static struct sk_buff *igmpv3_newpack(struct
net_device *dev, unsigned int mtu)
        struct flowi4 fl4;
        int hlen =3D LL_RESERVED_SPACE(dev);
        int tlen =3D dev->needed_tailroom;
-       unsigned int size =3D mtu;
+       unsigned int size;

+       size =3D min(mtu, IP_MAX_MTU);
        while (1) {
                skb =3D alloc_skb(size + hlen + tlen,
                                GFP_ATOMIC | __GFP_NOWARN);

