Return-Path: <netdev+bounces-35108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C57A7163
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F46B281A20
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 04:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB61FDF;
	Wed, 20 Sep 2023 04:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23771FC1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 04:01:10 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB529AC;
	Tue, 19 Sep 2023 21:01:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c108e106f0so4493881fa.1;
        Tue, 19 Sep 2023 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695182464; x=1695787264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyKYrjr913/Mxco2pUUA8tL3BYyOou9f2SmsCpkYGHE=;
        b=jtMuw5xwK4NJRFih0YSwoU0kLX9KZORs5NlzyUgyG/3jVC+EXCouuWiYj6r3P4okOF
         iYwWtjN74UC8PQGh0rSDxG4DAi8hQ80uuEToIO/YyuyiFLybKkGRatXJ6ht5EBagaHB5
         GXWbUwMQK/RiN8tOh+0QkAX8GgZ0mpkDYnd7ZthCzBPqDYNCNt70n1h2DlgLbN7AU2xd
         G0b10HW9imQ7I/veL6fS3MActd4UUWdCYXe2xuw01NWk+9iaCRCMunNgWhfAhsZVMB0J
         IQxKSWnZ2XnIPHwcdAqtgO4NxjEKj2u8ODlBZIOzFaoMxnbZQnOsFCGnfIH/N8GmszgV
         ITSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695182464; x=1695787264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyKYrjr913/Mxco2pUUA8tL3BYyOou9f2SmsCpkYGHE=;
        b=Z2ti639Ti7T7UgFN1Dw4ZZA7cVa+M/WE6OPlQI/pg5rtaD6kYBerP0dRg0x4hmozhs
         pIBXUDspdYhDU4ms592WNvVQvzwxS916ltsHkeDYE/JDT9Ef5vzHfsGvrrZshRrXuLAE
         mgUOo5fofkTmAt/eSC/H/gsc38wSoNBYPeF8bDD6WxsK1Ap3bf3ZDGMV0RquD2zYf4XP
         D5Xb4+dQKhSkQs8vMJhlx/lqAAc44bU7iZ1ooG0vAOkr+LP0bj5K83G6dZamzLqywP9L
         1Fo18/W24KJkHd0yQbYdTARhZgNjkKegrdx6wXpUus2xGWqxbN/PXUZk/PsysqMwqO0f
         P3DQ==
X-Gm-Message-State: AOJu0Yy04zFkgUn2HlEnMZUa8VrAFXgDacRaVWDkCkfu3muFClXO0RZ1
	EdY8roSsh8tvzj1kTLObGbBsfA8cFGCvy8T2Gqg=
X-Google-Smtp-Source: AGHT+IGmu93zgplai1XsLqNBey4INMI8sChfYgKcLuu+o0njuikfwNzh9cWLULCc03wLA3fg4X/6qQZp9/+z+tPM0f4=
X-Received: by 2002:a2e:81d3:0:b0:2bc:f523:c88a with SMTP id
 s19-20020a2e81d3000000b002bcf523c88amr1062310ljg.1.1695182463657; Tue, 19 Sep
 2023 21:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916132932.361875-1-liangchen.linux@gmail.com>
 <20230916132932.361875-2-liangchen.linux@gmail.com> <ZQhdCHiqy2R6N3n0@d3>
In-Reply-To: <ZQhdCHiqy2R6N3n0@d3>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 20 Sep 2023 12:00:50 +0800
Message-ID: <CAKhg4tLCivfktmuFBUkgzU0t4f7rRUa7vV45-jEBNvbjkbgOuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] pktgen: Introducing 'SHARED' flag for
 testing with non-shared skb
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <keescook@chromium.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 10:22=E2=80=AFPM Benjamin Poirier <bpoirier@nvidia.=
com> wrote:
>
> On 2023-09-16 21:29 +0800, Liang Chen wrote:
> > Currently, skbs generated by pktgen always have their reference count
> > incremented before transmission, causing their reference count to be
> > always greater than 1, leading to two issues:
> >   1. Only the code paths for shared skbs can be tested.
> >   2. In certain situations, skbs can only be released by pktgen.
> > To enhance testing comprehensiveness, we are introducing the "SHARED"
> > flag to indicate whether an SKB is shared. This flag is enabled by
> > default, aligning with the current behavior. However, disabling this
> > flag allows skbs with a reference count of 1 to be transmitted.
> > So we can test non-shared skbs and code paths where skbs are released
> > within the stack.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
>
> In the future, please run scripts/get_maintainer.pl and cc the listed
> addresses. I'm adding them now.

Sure. Thanks!

>
> Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
>
> >  Documentation/networking/pktgen.rst | 12 ++++++++
> >  net/core/pktgen.c                   | 48 ++++++++++++++++++++++++-----
> >  2 files changed, 52 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/networking/pktgen.rst b/Documentation/networ=
king/pktgen.rst
> > index 1225f0f63ff0..c945218946e1 100644
> > --- a/Documentation/networking/pktgen.rst
> > +++ b/Documentation/networking/pktgen.rst
> > @@ -178,6 +178,7 @@ Examples::
> >                             IPSEC # IPsec encapsulation (needs CONFIG_X=
FRM)
> >                             NODE_ALLOC # node specific memory allocatio=
n
> >                             NO_TIMESTAMP # disable timestamping
> > +                           SHARED # enable shared SKB
> >   pgset 'flag ![name]'    Clear a flag to determine behaviour.
> >                        Note that you might need to use single quote in
> >                        interactive mode, so that your shell wouldn't ex=
pand
> > @@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for usi=
ng AH type and tunnel mode,
> >  you can use "pgset spi SPI_VALUE" to specify which transformation mode
> >  to employ.
> >
> > +Disable shared SKB
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +By default, SKBs sent by pktgen are shared (user count > 1).
> > +To test with non-shared SKBs, remove the "SHARED" flag by simply setti=
ng::
> > +
> > +     pg_set "flag !SHARED"
> > +
> > +However, if the "clone_skb" or "burst" parameters are configured, the =
skb
> > +still needs to be held by pktgen for further access. Hence the skb mus=
t be
> > +shared.
> >
> >  Current commands and configuration options
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -357,6 +368,7 @@ Current commands and configuration options
> >      IPSEC
> >      NODE_ALLOC
> >      NO_TIMESTAMP
> > +    SHARED
> >
> >      spi (ipsec)
> >
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index 48306a101fd9..c4e0814df325 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -200,6 +200,7 @@
> >       pf(VID_RND)             /* Random VLAN ID */                    \
> >       pf(SVID_RND)            /* Random SVLAN ID */                   \
> >       pf(NODE)                /* Node memory alloc*/                  \
> > +     pf(SHARED)              /* Shared SKB */                        \
> >
> >  #define pf(flag)             flag##_SHIFT,
> >  enum pkt_flags {
> > @@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *file,
> >                   ((pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) ||
> >                    !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))
> >                       return -ENOTSUPP;
> > -             if (value > 0 && pkt_dev->n_imix_entries > 0)
> > +             if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
> > +                               !(pkt_dev->flags & F_SHARED)))
> >                       return -EINVAL;
> >
> >               i +=3D len;
> > @@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *file=
,
> >                    ((pkt_dev->xmit_mode =3D=3D M_START_XMIT) &&
> >                    (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))=
))
> >                       return -ENOTSUPP;
> > +
> > +             if (value > 1 && !(pkt_dev->flags & F_SHARED))
> > +                     return -EINVAL;
> > +
> >               pkt_dev->burst =3D value < 1 ? 1 : value;
> >               sprintf(pg_result, "OK: burst=3D%u", pkt_dev->burst);
> >               return count;
> > @@ -1334,10 +1340,19 @@ static ssize_t pktgen_if_write(struct file *fil=
e,
> >
> >               flag =3D pktgen_read_flag(f, &disable);
> >               if (flag) {
> > -                     if (disable)
> > +                     if (disable) {
> > +                             /* If "clone_skb", or "burst" parameters =
are
> > +                              * configured, it means that the skb stil=
l
> > +                              * needs to be referenced by the pktgen, =
so
> > +                              * the skb must be shared.
> > +                              */
> > +                             if (flag =3D=3D F_SHARED && (pkt_dev->clo=
ne_skb ||
> > +                                                      pkt_dev->burst >=
 1))
> > +                                     return -EINVAL;
> >                               pkt_dev->flags &=3D ~flag;
> > -                     else
> > +                     } else {
> >                               pkt_dev->flags |=3D flag;
> > +                     }
> >
> >                       sprintf(pg_result, "OK: flags=3D0x%x", pkt_dev->f=
lags);
> >                       return count;
> > @@ -3489,7 +3504,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >       if (pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) {
> >               skb =3D pkt_dev->skb;
> >               skb->protocol =3D eth_type_trans(skb, skb->dev);
> > -             refcount_add(burst, &skb->users);
> > +             if (pkt_dev->flags & F_SHARED)
> > +                     refcount_add(burst, &skb->users);
> >               local_bh_disable();
> >               do {
> >                       ret =3D netif_receive_skb(skb);
> > @@ -3497,6 +3513,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt_d=
ev)
> >                               pkt_dev->errors++;
> >                       pkt_dev->sofar++;
> >                       pkt_dev->seq_num++;
> > +                     if (unlikely(!(pkt_dev->flags & F_SHARED))) {
> > +                             pkt_dev->skb =3D NULL;
> > +                             break;
> > +                     }
> >                       if (refcount_read(&skb->users) !=3D burst) {
> >                               /* skb was queued by rps/rfs or taps,
> >                                * so cannot reuse this skb
> > @@ -3515,9 +3535,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_d=
ev)
> >               goto out; /* Skips xmit_mode M_START_XMIT */
> >       } else if (pkt_dev->xmit_mode =3D=3D M_QUEUE_XMIT) {
> >               local_bh_disable();
> > -             refcount_inc(&pkt_dev->skb->users);
> > +             if (pkt_dev->flags & F_SHARED)
> > +                     refcount_inc(&pkt_dev->skb->users);
> >
> >               ret =3D dev_queue_xmit(pkt_dev->skb);
> > +
> > +             if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret=
))
> > +                     pkt_dev->skb =3D NULL;
> > +
> >               switch (ret) {
> >               case NET_XMIT_SUCCESS:
> >                       pkt_dev->sofar++;
> > @@ -3555,11 +3580,15 @@ static void pktgen_xmit(struct pktgen_dev *pkt_=
dev)
> >               pkt_dev->last_ok =3D 0;
> >               goto unlock;
> >       }
> > -     refcount_add(burst, &pkt_dev->skb->users);
> > +     if (pkt_dev->flags & F_SHARED)
> > +             refcount_add(burst, &pkt_dev->skb->users);
> >
> >  xmit_more:
> >       ret =3D netdev_start_xmit(pkt_dev->skb, odev, txq, --burst > 0);
> >
> > +     if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
> > +             pkt_dev->skb =3D NULL;
> > +
> >       switch (ret) {
> >       case NETDEV_TX_OK:
> >               pkt_dev->last_ok =3D 1;
> > @@ -3581,7 +3610,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >               fallthrough;
> >       case NETDEV_TX_BUSY:
> >               /* Retry it next time */
> > -             refcount_dec(&(pkt_dev->skb->users));
> > +             if (pkt_dev->flags & F_SHARED)
> > +                     refcount_dec(&pkt_dev->skb->users);
> >               pkt_dev->last_ok =3D 0;
> >       }
> >       if (unlikely(burst))
> > @@ -3594,7 +3624,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >
> >       /* If pkt_dev->count is zero, then run forever */
> >       if ((pkt_dev->count !=3D 0) && (pkt_dev->sofar >=3D pkt_dev->coun=
t)) {
> > -             pktgen_wait_for_skb(pkt_dev);
> > +             if (pkt_dev->skb)
> > +                     pktgen_wait_for_skb(pkt_dev);
> >
> >               /* Done with this */
> >               pktgen_stop_device(pkt_dev);
> > @@ -3777,6 +3808,7 @@ static int pktgen_add_device(struct pktgen_thread=
 *t, const char *ifname)
> >       pkt_dev->svlan_id =3D 0xffff;
> >       pkt_dev->burst =3D 1;
> >       pkt_dev->node =3D NUMA_NO_NODE;
> > +     pkt_dev->flags =3D F_SHARED;      /* SKB shared by default */
> >
> >       err =3D pktgen_setup_dev(t->net, pkt_dev, ifname);
> >       if (err)
> > --
> > 2.40.1
> >

