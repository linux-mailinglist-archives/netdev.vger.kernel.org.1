Return-Path: <netdev+bounces-14956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7AA7448FC
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D641C20873
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629E5CBB;
	Sat,  1 Jul 2023 12:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC351857
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:39:51 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E23C07
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 05:39:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401d1d967beso170471cf.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688215189; x=1690807189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsoGkzXUZgV3rrFVZEoOErHbIlZc25ECeNo393XHNHE=;
        b=J4aLc5BqAZ+6U0viLVYruoFt/p8FYudNjHLtvzUz9DzC4W814tsfpyUK/6OuF6y1km
         Ekak8xGBJ6z2EwbUJnSRcq9qj41Zobxj0tmnkaQD1F2Jsa3qIOngVQGpuu2LkkGpZrGC
         OhVTZwi80XilEXOOsoGnkj6QWoCCcHnXwWyZ5HkseNweEG7fVr6fkVY2rxj3AOHwoOy2
         pTH018mWECXGY1/aIPxd/MFH6SEvT7PgUQWeqtUotmVHeT3rB2LqxWNSFaBHPuxm66P4
         A00b8WtrJA77YHKjVMtqa1xSKgrDtEmTWOG2qPBcumIDLqm5WlU762qvkvCqogWdLHrz
         infg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688215189; x=1690807189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsoGkzXUZgV3rrFVZEoOErHbIlZc25ECeNo393XHNHE=;
        b=KHkeo5+3ZXyqBVtzefYrRglbGKxAV5aZWuQpcG9/VzLX5VCHh6lCsi2Ougz/jHmBSm
         AIn+IokmpSD07m5UECccoakXMEZ4qOkFI8Gx4MMjwL/Nkz2bb2NlA9f8X8jGNLJeEJvT
         lpW8nBtDD0v4ohonpUTgQrKXtlPPpy1lKEeosWDy+2Aoc1f0x8XRhxcAoroEkijCoh5y
         In5lQHJBW+8AgUNEF3CsZ0ZIs8esS8wr0ZHHLOHXpjiTYJ5Yg3c9O7wmvh2LZ/eyptfs
         /1jmtetisF+8qXv+EJ0zIfO7Tx3R1pKqmdUMjZeSAGEtb3xtFv+A9SYq91x5D9wHhGWt
         k0tA==
X-Gm-Message-State: ABy/qLZjx2rufMpyaj2ZmPQQPvqM7j8MZLZy+IvfvA79x5sgTagoSa7T
	C6Gfz/1Hs+eRWs5dFp2Ccoe4e0uYm4DFhAfh6NdfUQ==
X-Google-Smtp-Source: APBJJlFy7/Zi/ECoz4QtnslHlNX0ELzBY3qMzA6QCom4x7KM6IXUId6d3oDaxUL9cJ5cyz6qwVpS8PJz50SMd1YQYS8=
X-Received: by 2002:a05:622a:1044:b0:3f5:49b6:f18d with SMTP id
 f4-20020a05622a104400b003f549b6f18dmr67553qte.11.1688215189229; Sat, 01 Jul
 2023 05:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630153759.3349299-1-maze@google.com> <ZJ/bAeYnpnhEPJXb@gondor.apana.org.au>
 <CANP3RGduOc4UgNoeHE+jcDw7ExrbCm64LX6zwgyh5FfyYzGSGA@mail.gmail.com>
In-Reply-To: <CANP3RGduOc4UgNoeHE+jcDw7ExrbCm64LX6zwgyh5FfyYzGSGA@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 1 Jul 2023 14:39:36 +0200
Message-ID: <CANP3RGemhoHyeki_ZzbX4JAWuCq3YZOOs64=T5YZ0XSaK8wbpA@mail.gmail.com>
Subject: Re: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Benedict Wong <benedictwong@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 1, 2023 at 2:27=E2=80=AFPM Maciej =C5=BBenczykowski <maze@googl=
e.com> wrote:
> On Sat, Jul 1, 2023 at 9:51=E2=80=AFAM Herbert Xu <herbert@gondor.apana.o=
rg.au> wrote:
> > > xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> > > xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)-=
>protocol:17
> >
> > This seems to make no sense.  UDP encapsulation is supposed to sit
> > on the outside of ESP.  So by the time we hit xfrm_input it should
> > be lone gone.  On the inside of the packet, as it's tunnel mode we
> > should have either IPIP or IPV6, definitely not UDP.
>
> It's triggering in testIPv4UDPEncapRecvTunnel() in xfrm_test.py.
> Specifically, it's the self.ReceivePacketOn(netid, input_pkt) a dozen
> lines higher.
>
> The packet we end up writing into the tap fd is
> 02 00 00 00 C8 01 02 00 00 00 C8 00 08 00
> 45 00 00 44 00 01 00 00 40 11 98 96 08 08 08 08 0A 00 C8 02
> 11 94 BF 12 00 30 1C D0
> 00 00 12 34 00 00 00 01
> 45 00 00 20 00 01 00 00 40 11 98 BA 08 08 08 08 0A 00 C8 02
> 01 BB 7D 7B 00 0C 9B 7A
> 01 02 02 11
>
> You can decode this with https://hpd.gasmi.net/ or https://packetor.com/
>
> You can decode the inner packet (this is null esp crypto) by passing in
> 00 00 00 00 00 00 00 00 00 00 00 00 08 00
> 45 00 00 20 00 01 00 00 40 11 98 BA 08 08 08 08 0A 00 C8 02
> 01 BB 7D 7B 00 0C 9B 7A
> 01 02 02 11
> instead.
>
> Note that the protocol the kernel's printk I added prints is the
> *outer* encap UDP protocol, not the inner UDP.
> ie. you can change the scapy.UDP to scapy.TCP in the 'inner_pkt =3D' assi=
gnment,
> and the warning still triggers.  The resulting packet is:
> 02 00 00 00 FA 01 02 00 00 00 FA 00 08 00
> 45 00 00 50 00 01 00 00 40 11 66 8A 08 08 08 08 0A 00 FA 02
> 11 94 A7 EB 00 3C 33 E0
> 00 00 12 34 00 00 00 01
> 45 00 00 2C 00 01 00 00 40 06 66 B9 08 08 08 08 0A 00 FA 02
> 01 BB 7D 7B 00 00 00 00 00 00 00 00 50 02 20 00 F9 82 00 00
> 01 02 02 11
>
> ie. the inner packet is IPv4/TCP:
> 00 00 00 00 00 00 00 00 00 00 00 00 08 00
> 45 00 00 2C 00 01 00 00 40 06 66 B9 08 08 08 08 0A 00 FA 02
> 01 BB 7D 7B 00 00 00 00 00 00 00 00 50 02 20 00 F9 82 00 00
> 01 02 02 11

It looks like the problem is that final '11', and thus the fix is in
the python test itself:

https://android-review.googlesource.com/c/kernel/tests/+/2647762

-      data +=3D xfrm_base.GetEspTrailer(len(data), IPPROTO_UDP)
+      data +=3D xfrm_base.GetEspTrailer(len(data), {4: IPPROTO_IPIP, 6:
IPPROTO_IPV6}[version])

I guess it's OK that this WARN_ON is remotely triggerable?

