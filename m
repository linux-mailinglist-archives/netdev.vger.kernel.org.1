Return-Path: <netdev+bounces-33430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E9279DF3D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 06:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228CE281F3F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71037F;
	Wed, 13 Sep 2023 04:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA35EC1
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 04:51:45 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF46A172A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 21:51:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bf924f39f1so47131391fa.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 21:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694580703; x=1695185503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdXwDjiZUlWAkBRUXMG4xR1X6WAv+Hu1dRU1tIsB85c=;
        b=RHEXCXwkj1Xc72cPs9DohZg4wMbMBS8hGYa+mnbB2iViGxGPyZkIOP+LCaznsmaggk
         jGFCur0D27hzjvJAENhVXnqq9iI1oDUmo7vuZ283oKQ+BNZEIH+GfAT9sL/4RklY0cQC
         r2b2e+7Hnwt+kayShl74iThe+Nem9/VHJZmNQilZFA41e7oZHUxePyT/suH0/Nj6fqzm
         8CUdgiIoCeoSpDQ6MFgeZv7JjOKWmyjHQl38kotByFKqF3QmuN5+gbaRjSbSbL5UD2vi
         H7ZL6mmH3NAOGtW0zBG4QpVActIoP5D5i+yw9NXHI1C/32no77xvMqqRLMlqO2LW3H6c
         bRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694580703; x=1695185503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdXwDjiZUlWAkBRUXMG4xR1X6WAv+Hu1dRU1tIsB85c=;
        b=L2MDNR5q8L87aMq5On5l0RExlc2KW4N239+LUfSzsDLy/xZzzfKibMnc3eFv9kvfzg
         EjzTPhg+VQAjb2CrWF4xLGJkKUHg58K6wHw3oZHHonviUYPEx1+X/t4EpX3Ykta+mlZK
         G4WvKapDUwI2hEF5lvdCaoFTxn69bbegGRw2NiXH1yZ7AULFGLKQuuihUuEU05BQhOKs
         2VfB9g1leMWBamtJ7wuYbK9BiZ83RKTlZImcrBh3TYv/XGCsSw2R+c9YRzveGT1o/22h
         tIHNJ74ZfqQ1z3egYQVrr33ohg1IoFHHo9ueeBKdVUHTb/8opjnTkkqsqLNzukqeiW+e
         l21g==
X-Gm-Message-State: AOJu0YxwYPLLlw9FhY5FR/Rwe2Tf8gDiwH8KaMTH1FZq+8QinJUVdHeq
	ib/Rc/KDXgtYxfJj666pizow83P3tLl3/hv7yVM=
X-Google-Smtp-Source: AGHT+IH4zLF1KDcAbk5SOFtIDr35XPtFjWEy4KMqT3v07PwBzuVC0LL0PjWrj8Fky/g7JqcHq/jcHEkRsjWfJ2IKcRc=
X-Received: by 2002:a2e:b6d0:0:b0:2be:4d40:f847 with SMTP id
 m16-20020a2eb6d0000000b002be4d40f847mr1423864ljo.20.1694580702753; Tue, 12
 Sep 2023 21:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906103508.6789-1-liangchen.linux@gmail.com>
 <ZPj98UXjJdsEsVJQ@d3> <CAKhg4tL+stODiv8hG0YWmU8zCKR4CsDOEvv7XD-S9PMdas5i_w@mail.gmail.com>
 <ZPowVxHPwe+Dvn0i@d3> <CAKhg4t+s1aCvR1zfkaXMFcUAvDAYsZqgOss4i=RaWV_6yn4HHw@mail.gmail.com>
In-Reply-To: <CAKhg4t+s1aCvR1zfkaXMFcUAvDAYsZqgOss4i=RaWV_6yn4HHw@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 13 Sep 2023 12:51:29 +0800
Message-ID: <CAKhg4tJzFnntRJhLyo-W3gR=kt59vrA3hiu1+shJu1G=LK_C2g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] pktgen: Introducing a parameter for
 non-shared skb testing
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 2:25=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> On Fri, Sep 8, 2023 at 4:19=E2=80=AFAM Benjamin Poirier
> <benjamin.poirier@gmail.com> wrote:
> >
> > On 2023-09-07 11:54 +0800, Liang Chen wrote:
> > > On Thu, Sep 7, 2023 at 6:32=E2=80=AFAM Benjamin Poirier
> > > <benjamin.poirier@gmail.com> wrote:
> > > >
> > > > On 2023-09-06 18:35 +0800, Liang Chen wrote:
> > > > > Currently, skbs generated by pktgen always have their reference c=
ount
> > > > > incremented before transmission, leading to two issues:
> > > > >   1. Only the code paths for shared skbs can be tested.
> > > > >   2. Skbs can only be released by pktgen.
> > > > > To enhance testing comprehensiveness, introducing the "skb_single=
_user"
> > > > > parameter, which allows skbs with a reference count of 1 to be
> > > > > transmitted. So we can test non-shared skbs and code paths where =
skbs
> > > > > are released within the network stack.
> > > >
> > > > If my understanding of the code is correct, pktgen operates in the =
same
> > > > way with parameter clone_skb =3D 0 and clone_skb =3D 1.
> > > >
> > >
> > > Yeah. pktgen seems to treat user count of 2 as not shared, as long as
> > > the skb is not reused for burst or clone_skb. In that case the only
> > > thing left to do with the skb is to check if user count is
> > > decremented.
> > >
> > > > clone_skb =3D 0 is already meant to work on devices that don't supp=
ort
> > > > shared skbs (see IFF_TX_SKB_SHARING check in pktgen_if_write()). In=
stead
> > > > of introducing a new option for your purpose, how about changing
> > > > pktgen_xmit() to send "not shared" skbs when clone_skb =3D=3D 0?
> > > >
> > >
> > > Using clone_skb =3D 0 to enforce non-sharing makes sense to me. Howev=
er,
> > > we are a bit concerned that such a change would affect existing users
> > > who have been assuming the current behavior.
> >
> > I looked into it more and mode netif_receive only supports clone_skb =
=3D 0
> > and normally reuses the same skb all the time. In order to support
> > shared/non-shared, I think a new parameter is needed, indeed.
> >
>
> Sure, we will introduce a new parameter and store the value in the
> flag, as you suggested below. Thanks.
>
> > Here are some comments on the rest of the patch:
> >
> > > ---
> > >  net/core/pktgen.c | 39 ++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 36 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > > index f56b8d697014..8f48272b9d4b 100644
> > > --- a/net/core/pktgen.c
> > > +++ b/net/core/pktgen.c
> > > @@ -423,6 +423,7 @@ struct pktgen_dev {
> > >       __u32 skb_priority;     /* skb priority field */
> > >       unsigned int burst;     /* number of duplicated packets to burs=
t */
> > >       int node;               /* Memory node */
> > > +     int skb_single_user;    /* allow single user skb for transmissi=
on */
> > >
> > >  #ifdef CONFIG_XFRM
> > >       __u8    ipsmode;                /* IPSEC mode (config) */
> > > @@ -1805,6 +1806,17 @@ static ssize_t pktgen_if_write(struct file *fi=
le,
> > >               return count;
> > >       }
> > >
> > > +     if (!strcmp(name, "skb_single_user")) {
> > > +             len =3D num_arg(&user_buffer[i], 1, &value);
> > > +             if (len < 0)
> > > +                     return len;
> > > +
> > > +             i +=3D len;
> > > +             pkt_dev->skb_single_user =3D value;
> > > +             sprintf(pg_result, "OK: skb_single_user=3D%u", pkt_dev-=
>skb_single_user);
> > > +             return count;
> > > +     }
> > > +
> >
> > Since skb_single_user is a boolean, it seems that it should be a flag
> > (pkt_dev->flags), not a parameter.
> >
> > Since "non shared" skbs don't really have a name, I would suggest to
> > avoid inventing a new name and instead call the flag "SHARED" and make
> > it on by default. So the user would unset the flag to enable the new
> > behavior.
> >
> > This patch should also document the new option in
> > Documentation/networking/pktgen.rst
> >
>
> Sure, "SHARED" sounds good to me as well, and the relevant document
> will be supplied.
>
> > >       sprintf(pkt_dev->result, "No such parameter \"%s\"", name);
> > >       return -EINVAL;
> > >  }
> > > @@ -3460,6 +3472,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt=
_dev)
> > >               return;
> > >       }
> > >
> > > +     /* If clone_skb, burst, or count parameters are configured,
> > > +      * it implies the need for skb reuse, hence single user skb
> > > +      * transmission is not allowed.
> > > +      */
> > > +     if (pkt_dev->skb_single_user && (pkt_dev->clone_skb ||
> > > +                                      burst > 1 || pkt_dev->count))
> > > +             pkt_dev->skb_single_user =3D 0;
> > > +
> >
> > count > 0 does not imply reuse. That restriction can be lifted.
> >
>
> If 'count' is set, pktgen_wait_for_skb waits for the completion of the
> last sent skb by polling the user count. So it still has an implicit
> dependency on the user count.
>
> > Instead of silently disabling the option, how about adding these checks
> > to pktgen_if_write()? The "clone_skb" parameter works that way, for
> > example.
> >
>
> Yes, silently disabling the option can be confusing for users. We will
> make this a parameter condition check instead.
>
> > >       /* If no skb or clone count exhausted then get new one */
> > >       if (!pkt_dev->skb || (pkt_dev->last_ok &&
> > >                             ++pkt_dev->clone_count >=3D pkt_dev->clon=
e_skb)) {
> > > @@ -3483,7 +3503,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_=
dev)
> > >       if (pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) {
> > >               skb =3D pkt_dev->skb;
> > >               skb->protocol =3D eth_type_trans(skb, skb->dev);
> > > -             refcount_add(burst, &skb->users);
> > > +             if (!pkt_dev->skb_single_user)
> > > +                     refcount_add(burst, &skb->users);
> > >               local_bh_disable();
> > >               do {
> > >                       ret =3D netif_receive_skb(skb);
> > > @@ -3491,6 +3512,12 @@ static void pktgen_xmit(struct pktgen_dev *pkt=
_dev)
> > >                               pkt_dev->errors++;
> > >                       pkt_dev->sofar++;
> > >                       pkt_dev->seq_num++;
> > > +
> > > +                     if (pkt_dev->skb_single_user) {
> > > +                             pkt_dev->skb =3D NULL;
> > > +                             break;
> > > +                     }
> > > +
> >
> > The assignment can be moved out of the loop, with the other 'if' in the
> > previous hunk.
> >
>
> Sure.

The assignment needs to occur after netif_receive_skb. So moving the
assignment above the loop would require netif_receive_skb and its
associated statistics being duplicated as well. Therefore, we mark the
condition 'unlikely' to optimize the case when 'burst' is set and it
loops.

>
> > >                       if (refcount_read(&skb->users) !=3D burst) {
> > >                               /* skb was queued by rps/rfs or taps,
> > >                                * so cannot reuse this skb
> > > @@ -3509,7 +3536,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_=
dev)
> > >               goto out; /* Skips xmit_mode M_START_XMIT */
> > >       } else if (pkt_dev->xmit_mode =3D=3D M_QUEUE_XMIT) {
> > >               local_bh_disable();
> > > -             refcount_inc(&pkt_dev->skb->users);
> > > +             if (!pkt_dev->skb_single_user)
> > > +                     refcount_inc(&pkt_dev->skb->users);
> > >
> > >               ret =3D dev_queue_xmit(pkt_dev->skb);
> > >               switch (ret) {
> > > @@ -3517,6 +3545,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_=
dev)
> > >                       pkt_dev->sofar++;
> > >                       pkt_dev->seq_num++;
> > >                       pkt_dev->tx_bytes +=3D pkt_dev->last_pkt_size;
> > > +                     if (pkt_dev->skb_single_user)
> > > +                             pkt_dev->skb =3D NULL;
> >
> > >                       break;
> > >               case NET_XMIT_DROP:
> > >               case NET_XMIT_CN:
> >
> > This code can lead to a use after free of pkt_dev->skb when
> > dev_queue_xmit() returns ex. NET_XMIT_DROP. The skb has been freed by
> > the stack but pkt_dev->skb is still set.
> >
> > It can be triggered like this:
> > ip link add dummy0 up type dummy
> > tc qdisc add dev dummy0 clsact
> > tc filter add dev dummy0 egress matchall action drop
> > And then run pktgen on dummy0 with "skb_single_user 1" and "xmit_mode
> > queue_xmit"
>
> Sure. Thanks for pointing out this issue! It will be fixed in v2.
>
>
> Thanks,
> Liang

