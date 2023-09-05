Return-Path: <netdev+bounces-31991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85E792030
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 05:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891911C2081B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 03:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CD648;
	Tue,  5 Sep 2023 03:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C67E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 03:41:55 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB567CCB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 20:41:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414c54b2551so325901cf.1
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 20:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693885314; x=1694490114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWGJvU3FHyMnSA/aJmpeg4rX+y72jGoAo/ag0FwtDPk=;
        b=Yov/npQ8wj0P1+fzBl6/dhC+0p8UcZvTq5v5RqsVyQZ3I5FIGFyuG0DkWP8V6FRc3s
         zastPifuoklAlVq2FX8PYFIxq7NwTFDZODZE993FXRvNARxXgusqfCNAa8cEYWZv/bqN
         zCiayZ6l8PNpopMZLLAU1jqUmkJxoNz3QTLXi2BGBOmYF+STkK8mzm+HdDYLWItry8CC
         AQn7TuwfMJzjzNxLFsBJeZQIdi0vIDuAgA1GMW4hr7zXjnxEQWKWUvg4jYnosDTn9sHM
         5atF47wEiAOSB0qKtlnU0A85AD33SCn9B75mSA1EYgtP+m5bXWjMOG5gXpFjpwCxOzCS
         i+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885314; x=1694490114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWGJvU3FHyMnSA/aJmpeg4rX+y72jGoAo/ag0FwtDPk=;
        b=kj8+5aSvSvvUvOvb+8Dsrx+DtdOIrVMghI9zDRS/ClCNzR4xYtL6VVWquWddmDjfE7
         gP8GDXVbo/YCd8J+eQSWP5+MlKrK9cyk+oRZrPLtJA8lNg7RCrlbfFe/Zbw83Geho0Z5
         i8+Jwyj/zmX/eigefp7UqmFKnyPWlRmjQSTA3ouHQPe/m0HbUlqxi5AVP3CooNVjUtNr
         JGn0cG3WfmUHxa45Zp01TrZ6Lc6Xh+V27pck5WLbsYoCLW7lkqyr+zh1aYODJhbMBh/R
         9ovDBUVve9oZbRjApv5cX4OtEEMTaQf7aFRAOHOg9iLUoaAA1kqhS1Xp/qQFi9Osj/3j
         RY6w==
X-Gm-Message-State: AOJu0Yz9yMUCNm8pwXxj10ULw5mT/wHa6RsbkFWaO8TyHzNyGCxTf72c
	N5vN1GXgF3kj/7LW3UnAXCBuqDPsmQBdVDaX+LrVDg==
X-Google-Smtp-Source: AGHT+IECpyeVKt5/IZ0cmeIdZ3MmHbub5kJYd+LpJb6s/1TIA6bY5baeOhEnPwoieGYQcHpI9ls0jKti+TxRNpMVkOc=
X-Received: by 2002:ac8:5993:0:b0:410:653f:90ea with SMTP id
 e19-20020ac85993000000b00410653f90eamr469950qte.1.1693885313661; Mon, 04 Sep
 2023 20:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831183750.2952307-1-edumazet@google.com> <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com> <ZPZtBWm06f321Tp/@westworld>
In-Reply-To: <ZPZtBWm06f321Tp/@westworld>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Sep 2023 05:41:42 +0200
Message-ID: <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
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

On Tue, Sep 5, 2023 at 1:49=E2=80=AFAM Kyle Zeng <zengyhkyle@gmail.com> wro=
te:
>
> On Mon, Sep 04, 2023 at 09:27:28AM +0000, David Laight wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > > Sent: 04 September 2023 10:06
> > > To: David Laight <David.Laight@ACULAB.COM>
> > > Cc: David S . Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kern=
el.org>; Paolo Abeni
> > > <pabeni@redhat.com>; netdev@vger.kernel.org; eric.dumazet@gmail.com; =
syzbot
> > > <syzkaller@googlegroups.com>; Kyle Zeng <zengyhkyle@gmail.com>; Kees =
Cook <keescook@chromium.org>;
> > > Vlastimil Babka <vbabka@suse.cz>
> > > Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_=
reserve()
> > >
> > > On Mon, Sep 4, 2023 at 10:41=E2=80=AFAM David Laight <David.Laight@ac=
ulab.com> wrote:
> > > >
> > > > From: Eric Dumazet
> > > > > Sent: 31 August 2023 19:38
> > > > >
> > > > > Blamed commit changed:
> > > > >     ptr =3D kmalloc(size);
> > > > >     if (ptr)
> > > > >       size =3D ksize(ptr);
> > > > >
> > > > > to:
> > > > >     size =3D kmalloc_size_roundup(size);
> > > > >     ptr =3D kmalloc(size);
> > > > >
> > > > > This allowed various crash as reported by syzbot [1]
> > > > > and Kyle Zeng.
> > > > >
> > > > > Problem is that if @size is bigger than 0x80000001,
> > > > > kmalloc_size_roundup(size) returns 2^32.
> > > > >
> > > > > kmalloc_reserve() uses a 32bit variable (obj_size),
> > > > > so 2^32 is truncated to 0.
> > > >
> > > > Can this happen on 32bit arch?
> > > > In that case kmalloc_size_roundup() will return 0.
> > >
> > > Maybe, but this would be a bug in kmalloc_size_roundup()
> >
> > That contains:
> >       /* Short-circuit saturated "too-large" case. */
> >       if (unlikely(size =3D=3D SIZE_MAX))
> >               return SIZE_MAX;
> >
> > It can also return 0 on failure, I can't remember if kmalloc(0)
> > is guaranteed to be NULL (malloc(0) can do 'other things').
> >
> > Which is entirely hopeless since MAX_SIZE is (size_t)-1.
> >
> > IIRC kmalloc() has a size limit (max 'order' of pages) so
> > kmalloc_size_roundup() ought check for that (or its max value).
> >
> > The final:
> >       /* The flags don't matter since size_index is common to all. */
> >       c =3D kmalloc_slab(size, GFP_KERNEL);
> >       return c ? c->object_size : 0;
> > probably ought to return size if c is even NULL.
> >
> >       David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
>
> > It can also return 0 on failure, I can't remember if kmalloc(0)
> > is guaranteed to be NULL (malloc(0) can do 'other things').
> kmalloc(0) returns ZERO_SIZE_PTR (16).
>
> My proposed patch is to check the return value of kmalloc, making sure it=
 is neither NULL or ZERO_SIZE_PTR. The patch is attached. It should work fo=
r both 32bit and 64bit systems.

Again, I do not want this patch, I want to fix the root cause(s).

It makes no sense to allow dev->mtu to be as big as 0x7fffffff and
ultimately allow size to be bigger than 0x80000000
I prefer waiting for net-next to open first.

Adding code in the fast path for something that must not ever happen is a n=
o go.

Only CONFIG_DEBUG_NET=3Dy stuff could be accepted.

