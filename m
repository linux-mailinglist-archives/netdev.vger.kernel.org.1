Return-Path: <netdev+bounces-35109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104657A716C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33CF1C20A76
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 04:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4C120E0;
	Wed, 20 Sep 2023 04:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CEF1FC1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:09:23 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F38B0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 21:09:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso105996831fa.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 21:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695182958; x=1695787758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ/A7cFsy6DVblmKWTcBlTrZ4v1tYFyHSz+yIRrZWTQ=;
        b=AINRmdQvFLDhFb6CP/0pzLiONdLLWX+tE9TkW96z/R5pEI8TGwIHZ5vaospJetMK0m
         6YA+UPndrGNDji/UNAuhLsROtddB0BiDpSMxgbl3uUYWrQh02xUJj8wIBH37LD1vimR5
         s/WF9kt8iOzexHj4qKJul3IbtOR0OPqwmM/Dw+WDU7KlRciHg0xL8zdo6ljDbTnRtst9
         O3682JBazdYVdBvx9kxtVYh98954JcwPtKDsntp6vrLw8pgU7F4LMiUFbOt+f37uld+C
         agE4ZHsjyAUEz4TOxn+d3SHNn5U717TyuECw9b2UgKb1EONVkY+VxaQWqMOfx9dGUffn
         lJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695182958; x=1695787758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ/A7cFsy6DVblmKWTcBlTrZ4v1tYFyHSz+yIRrZWTQ=;
        b=qqhVczyab/npRNsru4mn2kEH9Ac0SQgwQRO4hdRhXwqcRVr/Mzba91ANQX0jQ00PTA
         a1pdvv+e98JKLh5P5EiCFT5aO1SaQ02xJwgjqAo2UXzBykK06IrdWva0+HFF3xT9zPYT
         9coiURbNglmGj/yNmDZoFtJ27orS/RjjLEgFjRBajf6lq/big6AmPut5n9H2ANAlKSfW
         B4JeQojtC2XunSqARuG+WhZpgvyGzT4Y9hRhC8AB9+CT4uqD4cIQfv9Fi2YDsBIAJ2eN
         DS4P8m7G4fTP0n3UkBmckS+3DhpEMiJ3Nzm31gr9gGsNVH0olIbvjUgRBNSADw5PkkZP
         /ZkQ==
X-Gm-Message-State: AOJu0YyhdZMhKg6Hwe+kRHpJ4qzdJal2UshjLQIAdEmktI/2XzT+6AZc
	W3rvgkuuFa+SXF5thH6wqwnGgRJN8rRL7ONljpk=
X-Google-Smtp-Source: AGHT+IFUvJ9bqYGOY5x/FzZiEZdOMl2A8ExfG/SItUPcw3aK4kr1lEnJqKK8T/3kcQ7ZhzZTTUHqQ2QfEhpzs+qEHxw=
X-Received: by 2002:a2e:9603:0:b0:2b9:c046:8617 with SMTP id
 v3-20020a2e9603000000b002b9c0468617mr885472ljh.5.1695182957917; Tue, 19 Sep
 2023 21:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916132932.361875-1-liangchen.linux@gmail.com>
 <20230916132932.361875-2-liangchen.linux@gmail.com> <CANn89iLA5irwbuqvJdnptGs9pQNO_63qQsJ1jjZd1E0Cd4JVMw@mail.gmail.com>
 <4a1d7edcfae1e967eb2951f591c10c02965f6dc2.camel@redhat.com>
In-Reply-To: <4a1d7edcfae1e967eb2951f591c10c02965f6dc2.camel@redhat.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 20 Sep 2023 12:09:04 +0800
Message-ID: <CAKhg4tLbqF7CZSkp+=iNHM_7gweUv9YbXGpsZnJ1=qUh=Ho83Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] pktgen: Introducing 'SHARED' flag for
 testing with non-shared skb
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	benjamin.poirier@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 4:09=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2023-09-18 at 16:28 +0200, Eric Dumazet wrote:
> > On Sat, Sep 16, 2023 at 3:30=E2=80=AFPM Liang Chen <liangchen.linux@gma=
il.com> wrote:
> > >
> > > Currently, skbs generated by pktgen always have their reference count
> > > incremented before transmission, causing their reference count to be
> > > always greater than 1, leading to two issues:
> > >   1. Only the code paths for shared skbs can be tested.
> > >   2. In certain situations, skbs can only be released by pktgen.
> > > To enhance testing comprehensiveness, we are introducing the "SHARED"
> > > flag to indicate whether an SKB is shared. This flag is enabled by
> > > default, aligning with the current behavior. However, disabling this
> > > flag allows skbs with a reference count of 1 to be transmitted.
> > > So we can test non-shared skbs and code paths where skbs are released
> > > within the stack.
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > ---
> > >  Documentation/networking/pktgen.rst | 12 ++++++++
> > >  net/core/pktgen.c                   | 48 ++++++++++++++++++++++++---=
--
> > >  2 files changed, 52 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/networking/pktgen.rst b/Documentation/netw=
orking/pktgen.rst
> > > index 1225f0f63ff0..c945218946e1 100644
> > > --- a/Documentation/networking/pktgen.rst
> > > +++ b/Documentation/networking/pktgen.rst
> > > @@ -178,6 +178,7 @@ Examples::
> > >                               IPSEC # IPsec encapsulation (needs CONF=
IG_XFRM)
> > >                               NODE_ALLOC # node specific memory alloc=
ation
> > >                               NO_TIMESTAMP # disable timestamping
> > > +                             SHARED # enable shared SKB
> > >   pgset 'flag ![name]'    Clear a flag to determine behaviour.
> > >                          Note that you might need to use single quote=
 in
> > >                          interactive mode, so that your shell wouldn'=
t expand
> > > @@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for u=
sing AH type and tunnel mode,
> > >  you can use "pgset spi SPI_VALUE" to specify which transformation mo=
de
> > >  to employ.
> > >
> > > +Disable shared SKB
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +By default, SKBs sent by pktgen are shared (user count > 1).
> > > +To test with non-shared SKBs, remove the "SHARED" flag by simply set=
ting::
> > > +
> > > +       pg_set "flag !SHARED"
> > > +
> > > +However, if the "clone_skb" or "burst" parameters are configured, th=
e skb
> > > +still needs to be held by pktgen for further access. Hence the skb m=
ust be
> > > +shared.
> > >
> > >  Current commands and configuration options
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > @@ -357,6 +368,7 @@ Current commands and configuration options
> > >      IPSEC
> > >      NODE_ALLOC
> > >      NO_TIMESTAMP
> > > +    SHARED
> > >
> > >      spi (ipsec)
> > >
> > > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > > index 48306a101fd9..c4e0814df325 100644
> > > --- a/net/core/pktgen.c
> > > +++ b/net/core/pktgen.c
> > > @@ -200,6 +200,7 @@
> > >         pf(VID_RND)             /* Random VLAN ID */                 =
   \
> > >         pf(SVID_RND)            /* Random SVLAN ID */                =
   \
> > >         pf(NODE)                /* Node memory alloc*/               =
   \
> > > +       pf(SHARED)              /* Shared SKB */                     =
   \
> > >
> > >  #define pf(flag)               flag##_SHIFT,
> > >  enum pkt_flags {
> > > @@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *fil=
e,
> > >                     ((pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) ||
> > >                      !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING=
)))
> > >                         return -ENOTSUPP;
> > > -               if (value > 0 && pkt_dev->n_imix_entries > 0)
> > > +               if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
> > > +                                 !(pkt_dev->flags & F_SHARED)))
> > >                         return -EINVAL;
> > >
> > >                 i +=3D len;
> > > @@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *fi=
le,
> > >                      ((pkt_dev->xmit_mode =3D=3D M_START_XMIT) &&
> > >                      (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARIN=
G)))))
> > >                         return -ENOTSUPP;
> > > +
> > > +               if (value > 1 && !(pkt_dev->flags & F_SHARED))
> > > +                       return -EINVAL;
> > > +
> > >                 pkt_dev->burst =3D value < 1 ? 1 : value;
> > >                 sprintf(pg_result, "OK: burst=3D%u", pkt_dev->burst);
> > >                 return count;
> > > @@ -1334,10 +1340,19 @@ static ssize_t pktgen_if_write(struct file *f=
ile,
> > >
> > >                 flag =3D pktgen_read_flag(f, &disable);
> > >                 if (flag) {
> > > -                       if (disable)
> > > +                       if (disable) {
> > > +                               /* If "clone_skb", or "burst" paramet=
ers are
> > > +                                * configured, it means that the skb =
still
> > > +                                * needs to be referenced by the pktg=
en, so
> > > +                                * the skb must be shared.
> > > +                                */
> > > +                               if (flag =3D=3D F_SHARED && (pkt_dev-=
>clone_skb ||
> > > +                                                        pkt_dev->bur=
st > 1))
> > > +                                       return -EINVAL;
> > >                                 pkt_dev->flags &=3D ~flag;
> > > -                       else
> > > +                       } else {
> > >                                 pkt_dev->flags |=3D flag;
> > > +                       }
> > >
> > >                         sprintf(pg_result, "OK: flags=3D0x%x", pkt_de=
v->flags);
> > >                         return count;
> > > @@ -3489,7 +3504,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_=
dev)
> > >         if (pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) {
> > >                 skb =3D pkt_dev->skb;
> > >                 skb->protocol =3D eth_type_trans(skb, skb->dev);
> > > -               refcount_add(burst, &skb->users);
> > > +               if (pkt_dev->flags & F_SHARED)
> > > +                       refcount_add(burst, &skb->users);
> > >                 local_bh_disable();
> > >                 do {
> > >                         ret =3D netif_receive_skb(skb);
> > > @@ -3497,6 +3513,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt=
_dev)
> > >                                 pkt_dev->errors++;
> > >                         pkt_dev->sofar++;
> > >                         pkt_dev->seq_num++;
> >
> > Since pkt_dev->flags can change under us, I would rather read pkt_dev->=
flags
> > once in pktgen_xmit() to avoid surprises...
>
> Additionally I *think* we can't assume pkt_dev->burst and pkt_dev-
> >flags have consistent values in pktgen_xmit(). The user-space
> (syzkaller) could flip burst and flag in between the read access in
> pktgen_xmit().
>

Thanks for pointing out the issue! We are trying to fix it in the following=
 way,

 static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 {
-       unsigned int burst =3D READ_ONCE(pkt_dev->burst);
+       bool skb_shared =3D !!(READ_ONCE(pkt_dev->flags) & F_SHARED);
        struct net_device *odev =3D pkt_dev->odev;
        struct netdev_queue *txq;
+       unsigned int burst =3D 1;
        struct sk_buff *skb;
+       int clone_skb =3D 0;
        int ret;

+       if (skb_shared) {
+               burst =3D READ_ONCE(pkt_dev->burst);
+               clone_skb =3D READ_ONCE(pkt_dev->clone_skb);
+       }
+

So that pktgen_xmit will have consistent 'burst', 'clone_skb', and
'skb_shared' values. if 'skb_shared' is false, the read of possible
new values (if any) for 'burst' and 'clone_skb' will be skipped to
prevent some concurrent changes from slipping in. And the stabilized
config will be read in in the next run of pktgen_xmit.

This doesn't prevent the loads of 'READ_ONCE(pkt_dev->burst); and
READ_ONCE(pkt_dev->clone_skb);' to be speculatively run at the an
early time, but only if 'skb_shared' is true these loads will be
committed. And burst and clone_skb can change freely with a true value
of skb_shared.

> There is a later:
>
>         if (unlikely(burst))
>                WARN_ON(refcount_sub_and_test(burst, &pkt_dev->skb->users)=
);

This seems no longer an issue If 'burst' and 'skb_shared' have
consistent values throughout the function, 'pkt_dev->skb' will not be
NULL here.


Thanks,
Liang

>
> that will need explicit check for 'pkt_dev->skb' not being NULL.
>
> Cheers,
>
> Paolo
>

