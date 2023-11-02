Return-Path: <netdev+bounces-45701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714D7DF1B7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF6281A13
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAB14F6C;
	Thu,  2 Nov 2023 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXMCXtqs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7AC14F67
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:52:52 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238D193
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:52:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so33295e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698925967; x=1699530767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA/pGPBpS4VOuZlfRoaJVtaEalS/p9Ufx9nsvl1VPEo=;
        b=wXMCXtqsM1mlEWKpp50A9R0i8Nhfz6mxZE931ZoUjS9sArX14Z36P/zxlJtCvKMQK/
         8LIp0hU6vnx95ddahCAy2pnlUygl0Sci71wyxQhuA5QMpURgbSPrwacc+4i5ZC8I91Vi
         SOLdbVG2squ4lMw9d7VtdHYA4l+9PzCM9yFKvZBnkW9Y4rQBvgNDNkTgwRw1W5BT2153
         CHGOE8YKxfZrW3YCHga2J7Uz+3A5/fbq2qvdNFLh/j0W8yyMtyvHwHxBkoUwL7PtKzPb
         oOgZ4v4laxLB8hxSjGH13zbZVCjVc/yuzntTGdUWg8a3auHjg7KYC1Xbrxt037jpADa/
         Ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925967; x=1699530767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA/pGPBpS4VOuZlfRoaJVtaEalS/p9Ufx9nsvl1VPEo=;
        b=L5axT8Ln9mVRr+GecMcZzn98XIRrazwtdmJ6b5Vv/DCC7EztEjWRhw3D54Ch2dVsle
         br7ZM6YkQdhSpA5RfjZOPEnh+HORx2JKTAbsYw7v+0HnV+mjRKaqJPhXuTfYfcImnNLv
         7yQGScP9U9ASLzT5kwh03+s34UHuTYxC8mhZTs2QtbHVcH1Ybp8luQjYN90fL3IPGxfE
         lTubPs3tMADhQ6HqnrGk4OevLlBdY0MKv2LCoDRA1CGqHVyBHfk1TDCtFOfgPlbxFbtK
         MDVyfdhs29jkR6Mm3CBR7T+a8lebiRPhBmADWfzGjXPTbyujexx9BcZxJmiLa2AZTPL+
         TYlw==
X-Gm-Message-State: AOJu0YwqdczXGuChNVlbYvPObE7k8T4Ck2W0g9Me8vlkfo/A2ofTi37O
	YqKXVkbniMvtZ0XO3zxOqoHfj+UiWtha3ih/opimCadDAcln+ob5aHC7Pn6tfGs=
X-Google-Smtp-Source: AGHT+IHshEeW6f6eoywR3OQqU9pBwRBr/5Z6a59HmAhsZd8dgJ8qSeyKaF7ChSh7Ew9J+bk9QFYAjD9AHznPnsu/23w=
X-Received: by 2002:a05:600c:35c8:b0:405:320a:44f9 with SMTP id
 r8-20020a05600c35c800b00405320a44f9mr32477wmq.5.1698925967017; Thu, 02 Nov
 2023 04:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031015756.1843599-1-sunytt@google.com> <ZUNxcxMq8EW0cVUT@shredder>
In-Reply-To: <ZUNxcxMq8EW0cVUT@shredder>
From: Yang Sun <sunytt@google.com>
Date: Thu, 2 Nov 2023 19:52:28 +0800
Message-ID: <CAF+qgb4A9ge4JTqeQvQPx1cAkP_MUMMpCOzmgGk1BnDe1dVa6g@mail.gmail.com>
Subject: Re: [PATCH] net: ipmr_base: Check iif when returning a (*, G) MFC
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	nicolas.dichtel@6wind.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Is this a regression (doesn't seem that way)? If not, the change should
> be targeted at net-next which is closed right now:

> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

I see.

> > - if (c->mfc_un.res.ttls[vifi] < 255)
> > + if (c->mfc_parent =3D=3D vifi && c->mfc_un.res.ttls[vifi] < 255)

> What happens if the route doesn't have an iif (-1)? It won't match
> anymore?

Looks like the mfc_parent can't be -1? There is the check:
    if (mfc->mf6cc_parent >=3D MAXMIFS)
        return -ENFILE;
before setting the parent:
    c->_c.mfc_parent =3D mfc->mf6cc_parent;

I wrote this patch thinking (*, G) MFCs could be per iif, similar to the
(S, G) MFCs, like we can add the following MFCs to forward packets from
any address with group destination ff05::aa from if1 to if2, and forward
packets from any address with group destination ff05::aa from if2 to
both if1 and if3.

(::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
(::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved

But reading Nicolas's initial commit message again, it seems to me that
(*, G) has to be used together with (*, *) and there should be only one
(*, G) entry per group address and include all relevant interfaces in
the oifs? Like the following:

(::, ::)         Iif: if1 Oifs: if1 if2 if3   State: resolved
(::, ff05::aa)   Iif: if1 Oifs: if1 if2 if3   State: resolved

Is this how the (*, *|G) MFCs are intended to be used? which means packets
to ff05::aa are forwarded from any one of the interfaces to all the other
interfaces? If this is the intended way it works then my patch would break
things and should be rejected.

Is there a way to achieve the use case I described above? Like having
different oifs for different iif?

Thanks!


On Thu, Nov 2, 2023 at 5:52=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> + Nicolas
>
> On Tue, Oct 31, 2023 at 09:57:56AM +0800, Yang Sun wrote:
> > Looking for a (*, G) MFC returns the first match without checking
> > the iif. This can return a MFC not intended for a packet's iif and
> > forwarding the packet with this MFC will not work correctly.
> >
> > When looking up for a (*, G) MFC, check that the MFC's iif is
> > the same as the packet's iif.
>
> Is this a regression (doesn't seem that way)? If not, the change should
> be targeted at net-next which is closed right now:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> >
> > Signed-off-by: Yang Sun <sunytt@google.com>
> > ---
> >  net/ipv4/ipmr_base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> > index 271dc03fc6db..5cf7c7088dfe 100644
> > --- a/net/ipv4/ipmr_base.c
> > +++ b/net/ipv4/ipmr_base.c
> > @@ -97,7 +97,7 @@ void *mr_mfc_find_any(struct mr_table *mrt, int vifi,=
 void *hasharg)
> >
> >       list =3D rhltable_lookup(&mrt->mfc_hash, hasharg, *mrt->ops.rht_p=
arams);
> >       rhl_for_each_entry_rcu(c, tmp, list, mnode) {
> > -             if (c->mfc_un.res.ttls[vifi] < 255)
> > +             if (c->mfc_parent =3D=3D vifi && c->mfc_un.res.ttls[vifi]=
 < 255)
>
> What happens if the route doesn't have an iif (-1)? It won't match
> anymore?
>
> >                       return c;
> >
> >               /* It's ok if the vifi is part of the static tree */
> > --
> > 2.42.0.820.g83a721a137-goog
> >
> >

