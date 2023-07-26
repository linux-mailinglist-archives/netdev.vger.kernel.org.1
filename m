Return-Path: <netdev+bounces-21392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC67637B8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C01281EEC
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A504C2E1;
	Wed, 26 Jul 2023 13:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56DBA43
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:37:29 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F21738
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:37:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40540a8a3bbso265711cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690378641; x=1690983441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RpdOu0xd89PKQIalIeVd0a7/zgKljelOof8a40L4i4=;
        b=Sf8BGGLG/YVf5hTIw2mRiYUJrhGRveUi/k+AqqMPZUmFe8p4BWsfCr5YSx/3Fwvc79
         ZAshUPiwOOOkApZoKiKbWRNO6t5pJDBwCatecPozBA+DfhQVk13eIvUYRzEHEz4SiFvj
         +fWy58gY4Al7fCx2LVYVv/Bf3PpD7ln+TIPJRMVJ9aWyMIDrF5XgH5P2xnawiBBGJd0e
         a8bWLJSYiGzOq99h6kRiUiNKkmVsXtP4HkYI8OVb+844q9c8mdXcVjWlL7Jq7Tl5XerT
         +dQnV6c6ilarTEGgJvUI4STxBLzOKdxT8LLghh3UWyrYD2Zi5ZVWt+fTeTIHGIbF4FP4
         80/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378641; x=1690983441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RpdOu0xd89PKQIalIeVd0a7/zgKljelOof8a40L4i4=;
        b=XxI3BL5rLrWfNCoy6dPo4O5F+feOOHW8t5FIpBjMKwybe0w+dj7fihBixYFKxVgDTS
         xhT5jeANa4eJwGOGK+XPuOaauxm11v9hfVq17naIVrPm43chBSdj562X+S+yKchMRzoZ
         LAxMkHKys8zbz4qUWj9Ha3OgaQreCsim4NTCrCseP1CuExiQRGVi2QR7Xg6OgOfR9eTJ
         vM3ia/RYiPLf03VgEJBBvgS2XClHgCJ/wbg6G0rMPb+KLGFNzkhPzmE+muLuomFeJAJ2
         1f7hyfIE/xd76z5ttdTqyP1H4iHTt3HQ9rzI8Lkhi6CDnq1iRakO6SdVPByuuGEX8u9x
         sQ9Q==
X-Gm-Message-State: ABy/qLaiYwVYzoGCiqEeZAqOGjfjbONdyTMAEd3xo3503y19h7HehHHm
	A5eA5wqbwsJrp8TaqzZgXBUkx9AIkp65oCLArTpUE98110g7TZZaF6Q9ZA==
X-Google-Smtp-Source: APBJJlGFdaeztCQusvefSy0cbMOpZyLsgbstEzJ1HjzRYbhG3pc0K8bPHQmSe0p0Xe0RS53yR/cpcO49PopVHt2r6ss=
X-Received: by 2002:a05:622a:1a8e:b0:3f2:2c89:f1ef with SMTP id
 s14-20020a05622a1a8e00b003f22c89f1efmr395537qtc.5.1690378640795; Wed, 26 Jul
 2023 06:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com> <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
In-Reply-To: <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 15:37:09 +0200
Message-ID: <CANn89iKTC29of9bkVKWcLv0W27JFvkub7fuBMeK_J3a3Q-B1Cg@mail.gmail.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 2:06=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> udp_lib_rehash() can get called at any time and will move a
> socket to a different hash2 chain.
> This can cause udp4_lib_lookup2() (processing incoming UDP) to
> fail to find a socket and an ICMP port unreachable be sent.
>
> Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
> that the 'end if list' marker was on the correct list.
>
> Rather than re-instate the 'nulls' list just check that the final
> socket is on the correct list.
>
> The cross-linking can definitely happen (see earlier issues with
> it looping forever because gcc cached the list head).
>
> Fixes: ca065d0cf80fa ("udp: no longer use SLAB_DESTROY_BY_RCU")
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---

Hi David, thanks a lot for the investigations.

I do not think this is the proper fix.

UDP rehash has always been buggy, because we lack an rcu grace period
between the removal of the socket
from the old hash bucket to the new one.

We need to stuff a synchronize_rcu() somewhere in udp_lib_rehash(),
and that might not be easy [1]
and might add unexpected latency to some real time applications.
([1] : Not sure if we are allowed to sleep in udp_lib_rehash())

Also note that adding a synchronize_rcu() would mean the socket would
not be found anyway by some incoming packets.

I think that rehash is tricky to implement if you expect that all
incoming packets must find the socket, wherever it is located.


>  net/ipv4/udp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ad64d6c4cd99..ed92ba7610b0 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -443,6 +443,7 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>                                      struct sk_buff *skb)
>  {
>         unsigned int hash2, slot2;
> +       unsigned int hash2_rescan;
>         struct udp_hslot *hslot2;
>         struct sock *sk, *result;
>         int score, badness;
> @@ -451,9 +452,12 @@ static struct sock *udp4_lib_lookup2(struct net *net=
,
>         slot2 =3D hash2 & udptable->mask;
>         hslot2 =3D &udptable->hash2[slot2];
>
> +rescan:
> +       hash2_rescan =3D hash2;
>         result =3D NULL;
>         badness =3D 0;
>         udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +               hash2_rescan =3D udp_sk(sk)->udp_portaddr_hash;
>                 score =3D compute_score(sk, net, saddr, sport,
>                                       daddr, hnum, dif, sdif);
>                 if (score > badness) {
> @@ -467,6 +471,16 @@ static struct sock *udp4_lib_lookup2(struct net *net=
,
>                         badness =3D score;
>                 }
>         }
> +
> +       /* udp sockets can get moved to a different hash chain.
> +        * If the chains have got crossed then rescan.
> +        */
> +       if ((hash2_rescan & udptable->mask) !=3D slot2) {

This is only going to catch one of the possible cases.

If we really want to add extra checks in this fast path, we would have
to check all found sockets,
not only the last one.

