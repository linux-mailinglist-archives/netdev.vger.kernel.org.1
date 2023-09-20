Return-Path: <netdev+bounces-35115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E877A7276
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14281C208DD
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A43D72;
	Wed, 20 Sep 2023 06:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009363D65
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:01:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51000AC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695189677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGfKkJsepvR4kBsaXF3GXtbg+1VdmRbs53lEbz8EQd0=;
	b=R0ywnuKtAuEGjOWK/ji0YXL9gOgKorqCH+386qT2AzcOHJCf9RClyawM5o4nR2sNauqLGs
	wPMBQJQknmRF/qf+JxmD04oeS3ZO5kON0StTJWrtNWFbhUb8yRXXs9cadWg9rqLTnlxCEe
	B3Fp9d/HJA+Ws8AyCWR4OwCeJQM5BWA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-6HNhjw63PiS-qobeTWVs_A-1; Wed, 20 Sep 2023 02:01:16 -0400
X-MC-Unique: 6HNhjw63PiS-qobeTWVs_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-404df8f48ccso13370565e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 23:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695189675; x=1695794475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGfKkJsepvR4kBsaXF3GXtbg+1VdmRbs53lEbz8EQd0=;
        b=p3ndB3W0cIXqL3s1z1EttM4/lBJ+yME6lu3pUGNXJBZ6zTcFyLU5t3ZRQdzWrtyWYS
         A8ofhLiCodtBdPZxUR5LCsEt9Vrem/4Go50zKm48yMNleZtwQTpzYc5PVnqa5IB2wTOj
         5RyS2tFXaSBosdTkfS81TPutxKLxe0MRymfX5nBMjfCJWGaH3aO8usb/PUvzkweZvJqC
         d3ARHOsMPbY6M87xsOCMQIN/Gfy16dsVFJMGSm3Enz5sQ815k7O+ulgcoCSyahkMLwwV
         YpS7CofhKXj9aZtjLyq5QXs3+aaMLdwY+2laGCgcmviXzqz74mle9vZ9IamwOxg7whCu
         e0Wg==
X-Gm-Message-State: AOJu0YyNySa5VH2PRTkTfLp5nMgozG2Fid/UpKkRufKpIAY3k3MXX2De
	Bgy7NxZ4ylepJ+aauTrkKPIDpG/msHhkyMKz1hFX7mCFnu+sLrY7uDIWK8PCqBHtNATiIaZcSJl
	R1LoaiWdg7hNFa/Silam8TS1p
X-Received: by 2002:adf:f751:0:b0:319:7624:4c8d with SMTP id z17-20020adff751000000b0031976244c8dmr1333706wrp.0.1695189674634;
        Tue, 19 Sep 2023 23:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA/NWpypaoDi1tmx5V3ywdJAcy2gwM7pniiZMTzWEbKb397zA5Us+DM6enaHqkri6VJo2xPg==
X-Received: by 2002:adf:f751:0:b0:319:7624:4c8d with SMTP id z17-20020adff751000000b0031976244c8dmr1333686wrp.0.1695189674190;
        Tue, 19 Sep 2023 23:01:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-56.dyn.eolo.it. [146.241.242.56])
        by smtp.gmail.com with ESMTPSA id o12-20020adfeacc000000b003176c6e87b1sm8606771wrn.81.2023.09.19.23.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:01:13 -0700 (PDT)
Message-ID: <ec657ec745dc4d5d3caf84a6458fe64bf5b990d0.camel@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] pktgen: Introducing 'SHARED' flag for
 testing with non-shared skb
From: Paolo Abeni <pabeni@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 kuba@kernel.org,  benjamin.poirier@gmail.com, netdev@vger.kernel.org
Date: Wed, 20 Sep 2023 08:01:12 +0200
In-Reply-To: <CAKhg4tLbqF7CZSkp+=iNHM_7gweUv9YbXGpsZnJ1=qUh=Ho83Q@mail.gmail.com>
References: <20230916132932.361875-1-liangchen.linux@gmail.com>
	 <20230916132932.361875-2-liangchen.linux@gmail.com>
	 <CANn89iLA5irwbuqvJdnptGs9pQNO_63qQsJ1jjZd1E0Cd4JVMw@mail.gmail.com>
	 <4a1d7edcfae1e967eb2951f591c10c02965f6dc2.camel@redhat.com>
	 <CAKhg4tLbqF7CZSkp+=iNHM_7gweUv9YbXGpsZnJ1=qUh=Ho83Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-20 at 12:09 +0800, Liang Chen wrote:
> On Tue, Sep 19, 2023 at 4:09=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Mon, 2023-09-18 at 16:28 +0200, Eric Dumazet wrote:
> > > On Sat, Sep 16, 2023 at 3:30=E2=80=AFPM Liang Chen <liangchen.linux@g=
mail.com> wrote:
> > > >=20
> > > > Currently, skbs generated by pktgen always have their reference cou=
nt
> > > > incremented before transmission, causing their reference count to b=
e
> > > > always greater than 1, leading to two issues:
> > > >   1. Only the code paths for shared skbs can be tested.
> > > >   2. In certain situations, skbs can only be released by pktgen.
> > > > To enhance testing comprehensiveness, we are introducing the "SHARE=
D"
> > > > flag to indicate whether an SKB is shared. This flag is enabled by
> > > > default, aligning with the current behavior. However, disabling thi=
s
> > > > flag allows skbs with a reference count of 1 to be transmitted.
> > > > So we can test non-shared skbs and code paths where skbs are releas=
ed
> > > > within the stack.
> > > >=20
> > > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > > ---
> > > >  Documentation/networking/pktgen.rst | 12 ++++++++
> > > >  net/core/pktgen.c                   | 48 ++++++++++++++++++++++++-=
----
> > > >  2 files changed, 52 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/networking/pktgen.rst b/Documentation/ne=
tworking/pktgen.rst
> > > > index 1225f0f63ff0..c945218946e1 100644
> > > > --- a/Documentation/networking/pktgen.rst
> > > > +++ b/Documentation/networking/pktgen.rst
> > > > @@ -178,6 +178,7 @@ Examples::
> > > >                               IPSEC # IPsec encapsulation (needs CO=
NFIG_XFRM)
> > > >                               NODE_ALLOC # node specific memory all=
ocation
> > > >                               NO_TIMESTAMP # disable timestamping
> > > > +                             SHARED # enable shared SKB
> > > >   pgset 'flag ![name]'    Clear a flag to determine behaviour.
> > > >                          Note that you might need to use single quo=
te in
> > > >                          interactive mode, so that your shell would=
n't expand
> > > > @@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for=
 using AH type and tunnel mode,
> > > >  you can use "pgset spi SPI_VALUE" to specify which transformation =
mode
> > > >  to employ.
> > > >=20
> > > > +Disable shared SKB
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +By default, SKBs sent by pktgen are shared (user count > 1).
> > > > +To test with non-shared SKBs, remove the "SHARED" flag by simply s=
etting::
> > > > +
> > > > +       pg_set "flag !SHARED"
> > > > +
> > > > +However, if the "clone_skb" or "burst" parameters are configured, =
the skb
> > > > +still needs to be held by pktgen for further access. Hence the skb=
 must be
> > > > +shared.
> > > >=20
> > > >  Current commands and configuration options
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > @@ -357,6 +368,7 @@ Current commands and configuration options
> > > >      IPSEC
> > > >      NODE_ALLOC
> > > >      NO_TIMESTAMP
> > > > +    SHARED
> > > >=20
> > > >      spi (ipsec)
> > > >=20
> > > > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > > > index 48306a101fd9..c4e0814df325 100644
> > > > --- a/net/core/pktgen.c
> > > > +++ b/net/core/pktgen.c
> > > > @@ -200,6 +200,7 @@
> > > >         pf(VID_RND)             /* Random VLAN ID */               =
     \
> > > >         pf(SVID_RND)            /* Random SVLAN ID */              =
     \
> > > >         pf(NODE)                /* Node memory alloc*/             =
     \
> > > > +       pf(SHARED)              /* Shared SKB */                   =
     \
> > > >=20
> > > >  #define pf(flag)               flag##_SHIFT,
> > > >  enum pkt_flags {
> > > > @@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *f=
ile,
> > > >                     ((pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) ||
> > > >                      !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARI=
NG)))
> > > >                         return -ENOTSUPP;
> > > > -               if (value > 0 && pkt_dev->n_imix_entries > 0)
> > > > +               if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
> > > > +                                 !(pkt_dev->flags & F_SHARED)))
> > > >                         return -EINVAL;
> > > >=20
> > > >                 i +=3D len;
> > > > @@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *=
file,
> > > >                      ((pkt_dev->xmit_mode =3D=3D M_START_XMIT) &&
> > > >                      (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHAR=
ING)))))
> > > >                         return -ENOTSUPP;
> > > > +
> > > > +               if (value > 1 && !(pkt_dev->flags & F_SHARED))
> > > > +                       return -EINVAL;
> > > > +
> > > >                 pkt_dev->burst =3D value < 1 ? 1 : value;
> > > >                 sprintf(pg_result, "OK: burst=3D%u", pkt_dev->burst=
);
> > > >                 return count;
> > > > @@ -1334,10 +1340,19 @@ static ssize_t pktgen_if_write(struct file =
*file,
> > > >=20
> > > >                 flag =3D pktgen_read_flag(f, &disable);
> > > >                 if (flag) {
> > > > -                       if (disable)
> > > > +                       if (disable) {
> > > > +                               /* If "clone_skb", or "burst" param=
eters are
> > > > +                                * configured, it means that the sk=
b still
> > > > +                                * needs to be referenced by the pk=
tgen, so
> > > > +                                * the skb must be shared.
> > > > +                                */
> > > > +                               if (flag =3D=3D F_SHARED && (pkt_de=
v->clone_skb ||
> > > > +                                                        pkt_dev->b=
urst > 1))
> > > > +                                       return -EINVAL;
> > > >                                 pkt_dev->flags &=3D ~flag;
> > > > -                       else
> > > > +                       } else {
> > > >                                 pkt_dev->flags |=3D flag;
> > > > +                       }
> > > >=20
> > > >                         sprintf(pg_result, "OK: flags=3D0x%x", pkt_=
dev->flags);
> > > >                         return count;
> > > > @@ -3489,7 +3504,8 @@ static void pktgen_xmit(struct pktgen_dev *pk=
t_dev)
> > > >         if (pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) {
> > > >                 skb =3D pkt_dev->skb;
> > > >                 skb->protocol =3D eth_type_trans(skb, skb->dev);
> > > > -               refcount_add(burst, &skb->users);
> > > > +               if (pkt_dev->flags & F_SHARED)
> > > > +                       refcount_add(burst, &skb->users);
> > > >                 local_bh_disable();
> > > >                 do {
> > > >                         ret =3D netif_receive_skb(skb);
> > > > @@ -3497,6 +3513,10 @@ static void pktgen_xmit(struct pktgen_dev *p=
kt_dev)
> > > >                                 pkt_dev->errors++;
> > > >                         pkt_dev->sofar++;
> > > >                         pkt_dev->seq_num++;
> > >=20
> > > Since pkt_dev->flags can change under us, I would rather read pkt_dev=
->flags
> > > once in pktgen_xmit() to avoid surprises...
> >=20
> > Additionally I *think* we can't assume pkt_dev->burst and pkt_dev-
> > > flags have consistent values in pktgen_xmit(). The user-space
> > (syzkaller) could flip burst and flag in between the read access in
> > pktgen_xmit().
> >=20
>=20
> Thanks for pointing out the issue! We are trying to fix it in the followi=
ng way,
>=20
>  static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  {
> -       unsigned int burst =3D READ_ONCE(pkt_dev->burst);
> +       bool skb_shared =3D !!(READ_ONCE(pkt_dev->flags) & F_SHARED);
>         struct net_device *odev =3D pkt_dev->odev;
>         struct netdev_queue *txq;
> +       unsigned int burst =3D 1;
>         struct sk_buff *skb;
> +       int clone_skb =3D 0;
>         int ret;
>=20
> +       if (skb_shared) {
> +               burst =3D READ_ONCE(pkt_dev->burst);
> +               clone_skb =3D READ_ONCE(pkt_dev->clone_skb);
> +       }
> +
>=20
> So that pktgen_xmit will have consistent 'burst', 'clone_skb', and
> 'skb_shared' values.=C2=A0

I agree it makes sense and address the potential issues.

Thanks,

Paolo


