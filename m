Return-Path: <netdev+bounces-21419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2537638F0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E79C1C21208
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D7253AA;
	Wed, 26 Jul 2023 14:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276FCA51
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:21:58 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C058DB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:21:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40631c5b9e9so297141cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690381311; x=1690986111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyuXVEs8kcz0o9toZkTdYvZs5CCwq9aqTzEaOXWEJ94=;
        b=TOa742d3UIFfjmXhrl6mAwd9rVg52sNGlhv/QWLbv9HmW8me5gw4GmYZsoc85+rb4y
         Gv4IkeL7ecUDn2IyM32V7J9IzI28apCjjoyyA9OCf6SpGS75Cs0uGM9MG/31AR69QhDf
         76j5p0CRvSo2l8XGPCQnyqtf1yBtE/iDdOo0D3v8VR63Z6OherbRrr60KWRSgNTRUEF9
         JKR/4//gq75xKPteXtLg5SRXZwr3xoqmN1KUa6mGN/bThlCWOArwJfRfDJOvv+EAi9RM
         /0tVwkcoCuXPVJdT/vYffEBiJHjOB2c1S/8gFyAJ0npfZ+jjab9JDx5y7SVg66zpPk6Y
         3dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381311; x=1690986111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyuXVEs8kcz0o9toZkTdYvZs5CCwq9aqTzEaOXWEJ94=;
        b=jRasCgpdT6sc99CdroBWBaXRLLXEpYX8R4+MLA6kA4N4GgT/NcOXwO8MIIt2ynvXf4
         yaTGZ7abjOEWPVZX7UzlyNpMT4zjiBVwVrceR86KyJs/SEkPPNBWtB4e2SdU6Olrif2V
         EbfTGj1HQGaNkItCHkxI2ZbQbnnwFUNo1KaSKQ2CbmI7iY+hqs5ohsdVqEcvjdbNW1OT
         tAOLn7OIwlBR4dc81rUsiaqCh4C6Ye9HXcxogw3FDWICKDfR5CmNLFmXez59TrYXcpxl
         uHdNbcwmot3AWJRBeAuuJIoWHw9dSZqbuhpanGuoHIn0yyhbtMU7K2DctcAZp9/8CtiF
         mb9Q==
X-Gm-Message-State: ABy/qLZK8AiyNTRdKi6aD2KT67LTxKmlmRuGzhrxAA/H8p3ke/iaQ0ao
	C3TNbgdu/1D+oPtY7D/jRh94HLHhpO5Y9EvKIB30aQ==
X-Google-Smtp-Source: APBJJlEjM7ekFVesrTSdyeKKsd7vNdZ9TG+x8Jg8vLRi54ZdeDBqGTHKuGIQ2wHgoWbjhIZOD2sTUh62FX47onZsdXA=
X-Received: by 2002:a05:622a:1a81:b0:403:f5b8:2bd2 with SMTP id
 s1-20020a05622a1a8100b00403f5b82bd2mr513025qtc.9.1690381311130; Wed, 26 Jul
 2023 07:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
 <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com> <CANn89iKTC29of9bkVKWcLv0W27JFvkub7fuBMeK_J3a3Q-B1Cg@mail.gmail.com>
 <fc241086b32944ecae4f467cb5b0c6c7@AcuMS.aculab.com>
In-Reply-To: <fc241086b32944ecae4f467cb5b0c6c7@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 16:21:40 +0200
Message-ID: <CANn89iLRDpAmaJVYCf+-F7mTTVkxSJMKfxZ+QhB8ATzYEi4X8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Rescan the hash2 list if the hash chains have got cross-linked.
To: David Laight <David.Laight@aculab.com>
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:13=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Eric Dumazet
> > Sent: 26 July 2023 14:37
> >
> > On Wed, Jul 26, 2023 at 2:06=E2=80=AFPM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > udp_lib_rehash() can get called at any time and will move a
> > > socket to a different hash2 chain.
> > > This can cause udp4_lib_lookup2() (processing incoming UDP) to
> > > fail to find a socket and an ICMP port unreachable be sent.
> > >
> > > Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
> > > that the 'end if list' marker was on the correct list.
> > >
> > > Rather than re-instate the 'nulls' list just check that the final
> > > socket is on the correct list.
> > >
> > > The cross-linking can definitely happen (see earlier issues with
> > > it looping forever because gcc cached the list head).
> > >
> > > Fixes: ca065d0cf80fa ("udp: no longer use SLAB_DESTROY_BY_RCU")
> > > Signed-off-by: David Laight <david.laight@aculab.com>
> > > ---
> >
> > Hi David, thanks a lot for the investigations.
> >
> > I do not think this is the proper fix.
> >
> > UDP rehash has always been buggy, because we lack an rcu grace period
> > between the removal of the socket
> > from the old hash bucket to the new one.
> >
> > We need to stuff a synchronize_rcu() somewhere in udp_lib_rehash(),
> > and that might not be easy [1]
> > and might add unexpected latency to some real time applications.
> > ([1] : Not sure if we are allowed to sleep in udp_lib_rehash())
>
> I'm also not sure that the callers would always like the potentially
> long rcu sleep.
>
> > Also note that adding a synchronize_rcu() would mean the socket would
> > not be found anyway by some incoming packets.
> >
> > I think that rehash is tricky to implement if you expect that all
> > incoming packets must find the socket, wherever it is located.
>
> I thought about something like the checks done for reading
> multi-word counters.
> Something like requiring the updater to increment a count on
> entry and exit and have the reader rescan with the lock held
> if the count is odd or changes.
>

Can you describe what user space operation is done by your precious applica=
tion,
triggering a rehash in the first place ?

Maybe we can think of something less disruptive in the kernel.
(For instance, you could have a second socket, insert it in the new bucket,
then remove the old socket)

> The problem is that a single 'port unreachable' can be treated
> as a fatal error by the receiving application.
> So you really don't want to be sending them.

Well, if your application needs to run with old kernels, and or
transient netfilter changes (some firewall setups do not use
iptables-restore)
better be more resilient to transient ICMP messages anyway.


>
> >
> >
> > >  net/ipv4/udp.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index ad64d6c4cd99..ed92ba7610b0 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -443,6 +443,7 @@ static struct sock *udp4_lib_lookup2(struct net *=
net,
> > >                                      struct sk_buff *skb)
> > >  {
> > >         unsigned int hash2, slot2;
> > > +       unsigned int hash2_rescan;
> > >         struct udp_hslot *hslot2;
> > >         struct sock *sk, *result;
> > >         int score, badness;
> > > @@ -451,9 +452,12 @@ static struct sock *udp4_lib_lookup2(struct net =
*net,
> > >         slot2 =3D hash2 & udptable->mask;
> > >         hslot2 =3D &udptable->hash2[slot2];
> > >
> > > +rescan:
> > > +       hash2_rescan =3D hash2;
> > >         result =3D NULL;
> > >         badness =3D 0;
> > >         udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> > > +               hash2_rescan =3D udp_sk(sk)->udp_portaddr_hash;
> > >                 score =3D compute_score(sk, net, saddr, sport,
> > >                                       daddr, hnum, dif, sdif);
> > >                 if (score > badness) {
> > > @@ -467,6 +471,16 @@ static struct sock *udp4_lib_lookup2(struct net =
*net,
> > >                         badness =3D score;
> > >                 }
> > >         }
> > > +
> > > +       /* udp sockets can get moved to a different hash chain.
> > > +        * If the chains have got crossed then rescan.
> > > +        */
> > > +       if ((hash2_rescan & udptable->mask) !=3D slot2) {
> >
> > This is only going to catch one of the possible cases.
> >
> > If we really want to add extra checks in this fast path, we would have
> > to check all found sockets,
> > not only the last one.
>
> I did think about that.
> Being hit by a single rehash is very unlikely.
> Being hit by two that also put you back onto the original
> chain really isn't going to happen.
>
> Putting the check inside the loop would save the test when the
> hash list is empty - probably common for the first lookup.
>
> The code in compute_score() is pretty horrid so maybe it
> wouldn't really be noticeable.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

