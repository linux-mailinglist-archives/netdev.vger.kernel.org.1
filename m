Return-Path: <netdev+bounces-34896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227927A5C01
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC189280FBC
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0138DF2;
	Tue, 19 Sep 2023 08:10:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D238BB2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:10:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89D11F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695110998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PI/+nfzFJWi3Vn25d+86T28N25J4dQrJLl3+cdAvKhM=;
	b=JB/Rux2q/Se4rJRqagkHw924T8Dx7rzIAwcRvWChM51yJw2gh4ma/xHZ/+nme/L50d0Fl9
	jiVNkEo29tL2kBzUwfXPM6pwvAZKxg+sRsmzcwDK0zkFf1uA1X+O7eGuJKFTIVXlOEvbe5
	/L+iqHyw/0sdsNsXXTkc7hNZ6LWn2RQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-9E9_0MtNOF27vNMcefhTZQ-1; Tue, 19 Sep 2023 04:09:57 -0400
X-MC-Unique: 9E9_0MtNOF27vNMcefhTZQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-404f8ccee4bso8644265e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 01:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110996; x=1695715796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PI/+nfzFJWi3Vn25d+86T28N25J4dQrJLl3+cdAvKhM=;
        b=eVfAH61gPN3Dczvr4vJ2guvyf9Emq+736jmtoDtBci/DrjWpottr2QyS0VbLpPZoJO
         8xYfUX7aDGsJyX6N4eTx9ZQWkN2NMwsrr5l/dYKSade5Tj880uleUtwkSl8b+mBTXI2l
         LdyVZ9r1aRG+fg87OYDrpxlpR+6ze2jcaR6RrVped4CnuDgo/3zncrLzN4ItY30zeHji
         Zm91w7WLUgMxuyRTbiLor3Q8d9NTUioUSbQN/QC0FcM6AvcSxCKGw0UvH/A8TmUytRJP
         fYm/vSpGdtmemLidW5K2Mt5y3hunfr/SybPnlZ9ippRq6ZWTKV2g9jyaBG+B00EXn/u+
         jELw==
X-Gm-Message-State: AOJu0YxV9BRy7ZhqKZ4pA73yourR6DAte7xX4Yzx+kxJrsAzumjSD8j0
	3+tm/a0WpGELMgDoStAGOEJRq5SkXxPaBA1+M9tDdFZbD6B60nddgJHwr7/SbcgpS2G3h9keU79
	jh+iXHbVTnBa4ydat
X-Received: by 2002:a5d:4451:0:b0:317:3a23:4855 with SMTP id x17-20020a5d4451000000b003173a234855mr8677121wrr.2.1695110995923;
        Tue, 19 Sep 2023 01:09:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnozanEdBHPHLTCvo19P7FXzd4HDI6kF6PBXgpim2pFs9vT2c/v6VyxHOXzp8X3t8uE/Wufw==
X-Received: by 2002:a5d:4451:0:b0:317:3a23:4855 with SMTP id x17-20020a5d4451000000b003173a234855mr8677104wrr.2.1695110995573;
        Tue, 19 Sep 2023 01:09:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b0031c6dc684f8sm14800648wrn.20.2023.09.19.01.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:09:55 -0700 (PDT)
Message-ID: <4a1d7edcfae1e967eb2951f591c10c02965f6dc2.camel@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] pktgen: Introducing 'SHARED' flag for
 testing with non-shared skb
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Liang Chen
 <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, benjamin.poirier@gmail.com, 
	netdev@vger.kernel.org
Date: Tue, 19 Sep 2023 10:09:53 +0200
In-Reply-To: <CANn89iLA5irwbuqvJdnptGs9pQNO_63qQsJ1jjZd1E0Cd4JVMw@mail.gmail.com>
References: <20230916132932.361875-1-liangchen.linux@gmail.com>
	 <20230916132932.361875-2-liangchen.linux@gmail.com>
	 <CANn89iLA5irwbuqvJdnptGs9pQNO_63qQsJ1jjZd1E0Cd4JVMw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 16:28 +0200, Eric Dumazet wrote:
> On Sat, Sep 16, 2023 at 3:30=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
.com> wrote:
> >=20
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
> >=20
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  Documentation/networking/pktgen.rst | 12 ++++++++
> >  net/core/pktgen.c                   | 48 ++++++++++++++++++++++++-----
> >  2 files changed, 52 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/Documentation/networking/pktgen.rst b/Documentation/networ=
king/pktgen.rst
> > index 1225f0f63ff0..c945218946e1 100644
> > --- a/Documentation/networking/pktgen.rst
> > +++ b/Documentation/networking/pktgen.rst
> > @@ -178,6 +178,7 @@ Examples::
> >                               IPSEC # IPsec encapsulation (needs CONFIG=
_XFRM)
> >                               NODE_ALLOC # node specific memory allocat=
ion
> >                               NO_TIMESTAMP # disable timestamping
> > +                             SHARED # enable shared SKB
> >   pgset 'flag ![name]'    Clear a flag to determine behaviour.
> >                          Note that you might need to use single quote i=
n
> >                          interactive mode, so that your shell wouldn't =
expand
> > @@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for usi=
ng AH type and tunnel mode,
> >  you can use "pgset spi SPI_VALUE" to specify which transformation mode
> >  to employ.
> >=20
> > +Disable shared SKB
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +By default, SKBs sent by pktgen are shared (user count > 1).
> > +To test with non-shared SKBs, remove the "SHARED" flag by simply setti=
ng::
> > +
> > +       pg_set "flag !SHARED"
> > +
> > +However, if the "clone_skb" or "burst" parameters are configured, the =
skb
> > +still needs to be held by pktgen for further access. Hence the skb mus=
t be
> > +shared.
> >=20
> >  Current commands and configuration options
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -357,6 +368,7 @@ Current commands and configuration options
> >      IPSEC
> >      NODE_ALLOC
> >      NO_TIMESTAMP
> > +    SHARED
> >=20
> >      spi (ipsec)
> >=20
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index 48306a101fd9..c4e0814df325 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -200,6 +200,7 @@
> >         pf(VID_RND)             /* Random VLAN ID */                   =
 \
> >         pf(SVID_RND)            /* Random SVLAN ID */                  =
 \
> >         pf(NODE)                /* Node memory alloc*/                 =
 \
> > +       pf(SHARED)              /* Shared SKB */                       =
 \
> >=20
> >  #define pf(flag)               flag##_SHIFT,
> >  enum pkt_flags {
> > @@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *file,
> >                     ((pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) ||
> >                      !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING))=
)
> >                         return -ENOTSUPP;
> > -               if (value > 0 && pkt_dev->n_imix_entries > 0)
> > +               if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
> > +                                 !(pkt_dev->flags & F_SHARED)))
> >                         return -EINVAL;
> >=20
> >                 i +=3D len;
> > @@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *file=
,
> >                      ((pkt_dev->xmit_mode =3D=3D M_START_XMIT) &&
> >                      (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)=
))))
> >                         return -ENOTSUPP;
> > +
> > +               if (value > 1 && !(pkt_dev->flags & F_SHARED))
> > +                       return -EINVAL;
> > +
> >                 pkt_dev->burst =3D value < 1 ? 1 : value;
> >                 sprintf(pg_result, "OK: burst=3D%u", pkt_dev->burst);
> >                 return count;
> > @@ -1334,10 +1340,19 @@ static ssize_t pktgen_if_write(struct file *fil=
e,
> >=20
> >                 flag =3D pktgen_read_flag(f, &disable);
> >                 if (flag) {
> > -                       if (disable)
> > +                       if (disable) {
> > +                               /* If "clone_skb", or "burst" parameter=
s are
> > +                                * configured, it means that the skb st=
ill
> > +                                * needs to be referenced by the pktgen=
, so
> > +                                * the skb must be shared.
> > +                                */
> > +                               if (flag =3D=3D F_SHARED && (pkt_dev->c=
lone_skb ||
> > +                                                        pkt_dev->burst=
 > 1))
> > +                                       return -EINVAL;
> >                                 pkt_dev->flags &=3D ~flag;
> > -                       else
> > +                       } else {
> >                                 pkt_dev->flags |=3D flag;
> > +                       }
> >=20
> >                         sprintf(pg_result, "OK: flags=3D0x%x", pkt_dev-=
>flags);
> >                         return count;
> > @@ -3489,7 +3504,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_de=
v)
> >         if (pkt_dev->xmit_mode =3D=3D M_NETIF_RECEIVE) {
> >                 skb =3D pkt_dev->skb;
> >                 skb->protocol =3D eth_type_trans(skb, skb->dev);
> > -               refcount_add(burst, &skb->users);
> > +               if (pkt_dev->flags & F_SHARED)
> > +                       refcount_add(burst, &skb->users);
> >                 local_bh_disable();
> >                 do {
> >                         ret =3D netif_receive_skb(skb);
> > @@ -3497,6 +3513,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt_d=
ev)
> >                                 pkt_dev->errors++;
> >                         pkt_dev->sofar++;
> >                         pkt_dev->seq_num++;
>=20
> Since pkt_dev->flags can change under us, I would rather read pkt_dev->fl=
ags
> once in pktgen_xmit() to avoid surprises...

Additionally I *think* we can't assume pkt_dev->burst and pkt_dev-
>flags have consistent values in pktgen_xmit(). The user-space
(syzkaller) could flip burst and flag in between the read access in
pktgen_xmit().=20

There is a later:

	if (unlikely(burst))
		WARN_ON(refcount_sub_and_test(burst, &pkt_dev->skb->users));

that will need explicit check for 'pkt_dev->skb' not being NULL.

Cheers,

Paolo


