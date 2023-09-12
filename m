Return-Path: <netdev+bounces-33267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6379D39E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6C8280193
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16F18B09;
	Tue, 12 Sep 2023 14:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A918AFA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:29:40 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997A1123
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:29:39 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7f1bc4ece3so4905595276.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694528979; x=1695133779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHAvXUmhv/TFynk9An09BxYKhLInV6OQIi4R4+9PvUY=;
        b=DUTvl93VI/IcOGqTdlUCd1lLtCqP1VYf8q+eZjayhHPNaXNO0vsMzzkKR0PKw8OkXy
         i+N3JFB3orfh9Oc64IFZIpXyz3NWJkVWE/UOc09qEE5s3Vw4cRgWHCktHLcBJHYnQDS7
         D7dyRQxppI/bCvgEFWMbY59TqrlN99/mh82rRY/7xleiXdfR9rZcSF87ik0iKE6HOmyZ
         qowOrV8qeISE645OoiHFPJSn1bqPLq1EV/2YVtqMKw5VnfTFuCboBz7NrXJWSkoEUraM
         bofAEeW0WT1UT+UQ7qqS1hMrxU9WqZ2ir8oYV+IM62zUl7Ylo+OhgRfmqmaBJbcFGCjX
         W0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694528979; x=1695133779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHAvXUmhv/TFynk9An09BxYKhLInV6OQIi4R4+9PvUY=;
        b=IMVaqwyn9SClD/ud/Hd3ao5arhsj6btk2wbSRhP4mV6gOGBUG2/ANgE+/SKIORBx+c
         gdYIdfvnGDUdqJwDRvP45GihjC2MqxeZtl6zgOmJWVUQW8rZv6A9/L2VVdQT8JxN799q
         HqDdYxAsRmhRZBfQCZq0wPc8lVnn/vwhm6uT/JuxHR/1qN9OhyoezpfOFV8swOe1AAhv
         RLfr5XmfOsHYiR5bDLH4uQmgweEj7iJFh7s/DFIMZNgrIhqZ2uHoV4saLS/JnGADDish
         kDtUvEgg34R7Wa1CLShbcnx4WetqUFDFlybmMEjGLjO/hwjZA5XyrxhDXv8jfYyuLihu
         k3Zg==
X-Gm-Message-State: AOJu0YzSfkivtsDXoyvQ3qR+9KyIp+cS3Uy89oeOSK1sEAeHyuWIskMM
	dRNuWjUpLFSYsMirbsCnEZcIBdlm76u5cYrQsxQ=
X-Google-Smtp-Source: AGHT+IEq82mLgOTxNTCiYFliB4stq33q6msbDngEVko34jrsF2BK6yOCaiAjC3P7mqPBrNbU0s7hXQUI4KHTQYc0FZA=
X-Received: by 2002:a25:b46:0:b0:cc6:26f7:f0ea with SMTP id
 67-20020a250b46000000b00cc626f7f0eamr11917824ybl.27.1694528978578; Tue, 12
 Sep 2023 07:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZQAShrVUokZR/WGs@google.com> <20230912075907.91325-1-kuniyu@amazon.com>
In-Reply-To: <20230912075907.91325-1-kuniyu@amazon.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 12 Sep 2023 07:29:27 -0700
Message-ID: <CANaxB-zPEvvVPmNeTPtkk0oG1uT_DXK5aBXye1gQ75GTMxYTdg@mail.gmail.com>
Subject: Re: [PATCH v2 net 3/6] tcp: Fix bind() regression for v4-mapped-v6
 non-wildcard address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	joannelkoong@gmail.com, kuba@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Andrei Vagin <avagin@gmail.com>
> Date: Tue, 12 Sep 2023 00:25:58 -0700
> > On Mon, Sep 11, 2023 at 11:36:57AM -0700, Kuniyuki Iwashima wrote:
> > > Since bhash2 was introduced, the example below does not work as expec=
ted.
> > > These two bind() should conflict, but the 2nd bind() now succeeds.
> > >
> > >   from socket import *
> > >
> > >   s1 =3D socket(AF_INET6, SOCK_STREAM)
> > >   s1.bind(('::ffff:127.0.0.1', 0))
> > >
> > >   s2 =3D socket(AF_INET, SOCK_STREAM)
> > >   s2.bind(('127.0.0.1', s1.getsockname()[1]))
> > >
> > > During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find(=
)
> > > fails to find the 1st socket's tb2, so inet_bind2_bucket_create() all=
ocates
> > > a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict()=
 that
> > > checks conflicts in the new tb2 by inet_bhash2_conflict().  However, =
the
> > > new tb2 does not include the 1st socket, thus the bind() finally succ=
eeds.
> > >
> > > In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 ha=
s
> > > the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
> > > returns the 1st socket's tb2.
> > >
> > > Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0=
.1,
> > > the 2nd bind() fails properly for the same reason mentinoed in the pr=
evious
> > > commit.
> > >
> > > Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and addr=
ess")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/ipv4/inet_hashtables.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > > index a58b04052ca6..c32f5e28758b 100644
> > > --- a/net/ipv4/inet_hashtables.c
> > > +++ b/net/ipv4/inet_hashtables.c
> > > @@ -820,8 +820,13 @@ static bool inet_bind2_bucket_match(const struct=
 inet_bind2_bucket *tb,
> >
> > Should we fix inet_bind2_bucket_addr_match too?
>
> No, there's no real bug.
>
> I have this patch in my local branch and will post it against
> net-next after this series is merged.
>
> ---8<---
> commit 06333d4b0d053e4c0d40090b29e5a8546b42bb50
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Sun Sep 10 19:01:23 2023 +0000
>
>     tcp: Remove redundant sk_family check in inet_bind2_bucket_addr_match=
().
>
>     Commit 5456262d2baa ("net: Fix incorrect address comparison when
>     searching for a bind2 bucket") added the test for the KMSAN report.
>
>     However, the condition never be true as tb2 is listener's
>     inet_csk(sk)->icsk_bind2_hash and its sk_family always matches with
>     child->sk_family.
>
>     Link: https://lore.kernel.org/netdev/CAG_fn=3DUd3zSW7AZWXc+asfMhZVL5E=
TnvuY44Pmyv4NPv-ijN-A@mail.gmail.com/
>     Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index c32f5e28758b..dfb1c61c0c2b 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -149,9 +149,6 @@ static bool inet_bind2_bucket_addr_match(const struct=
 inet_bind2_bucket *tb2,
>                                          const struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> -       if (sk->sk_family !=3D tb2->family)
> -               return false;
> -
>         if (sk->sk_family =3D=3D AF_INET6)
>                 return ipv6_addr_equal(&tb2->v6_rcv_saddr,
>                                        &sk->sk_v6_rcv_saddr);
> ---8<---
>
>
> >
> > >             return false;
> > >
> > >  #if IS_ENABLED(CONFIG_IPV6)
> > > -   if (sk->sk_family !=3D tb->family)
> > > +   if (sk->sk_family !=3D tb->family) {
> > > +           if (sk->sk_family =3D=3D AF_INET)
> > > +                   return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
> > > +                           tb->v6_rcv_saddr.s6_addr32[3] =3D=3D sk->=
sk_rcv_saddr;
> >
> > I was wondering why we don't check a case when sk is AF_INET6 and tb is
> > AF_INET. I tried to run the next test:
> >
> > import socket
> > sk4 =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
> > sk6 =3D socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
> > sk4.bind(("127.0.0.1", 32773))
> > sk6.bind(("::ffff:127.0.0.1", 32773))
> >
> > The second bind returned EADDRINUSE. It works as expected only because
> > inet_use_bhash2_on_bind returns false for all v4mapped addresses. This
> > doesn't look right, and I am not sure it was intentional. I think it ca=
n
> > to be changed this way:
> >
> > @@ -158,7 +158,7 @@ static bool inet_use_bhash2_on_bind(const struct so=
ck *sk)
> >                 int addr_type =3D ipv6_addr_type(&sk->sk_v6_rcv_saddr);
> >
> >                 return addr_type !=3D IPV6_ADDR_ANY &&
> > -                       addr_type !=3D IPV6_ADDR_MAPPED;
> > +                       !ipv6_addr_v4mapped_any(&sk->sk_v6_rcv_saddr);
> >         }
> >  #endif
> >         return sk->sk_rcv_saddr !=3D htonl(INADDR_ANY);
> >
> > As for this patch, I think it may be a good idea if bind2 buckets for
> > v4-mapped addresses are created with the AF_INET family and matching
> > ipv4 addresses.
>
> Let's say we create tb2 with AF_INET for v4-mapped address.  If we bind
> ::ffff:127.0.0.1 and 127.0.0.1, in the second bind(), both tb->family and
> sk->sk_family is AF_INET.  So, we can remove this AF_INET test.
>
>   if (sk->sk_family !=3D tb->family) {
>       if (sk->sk_family =3D=3D AF_INET)
>
> But what about 127.0.0.1 and then ::ffff:127.0.0.1 ?  There tb->family is
> AF_INET and sk->sk_family is AF_INET6.  We need to add another AF_INET6
> test in the same place.
>
> So, finally we need to check the special case in either way.
>
> Also, as you may notice, we need to change inet_bind2_bucket_addr_match()
> as well.  As mentioned in my patch above, sk->sk_family always match
> tb2->family there, but v4-mapped AF_INET tb2 breaks the rule.

Thanks for the explanation. It looks quite reasonable.

>
> Using bhash2 for v4-mapped-v6 address could be done but churns code a lot=
.
> So, I think we should not include such changes as fix at least.

My mistake was to suppose that it was done unintentionally.  I didn't find =
any
explanations in commit messages and in the code. Sorry if I missed somethin=
g.
I think a comment in the code could help to avoid such questions.

The patch looks good to me.
Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei

