Return-Path: <netdev+bounces-42942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2C7D0B8E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD3F1C20E8B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF95125BE;
	Fri, 20 Oct 2023 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O31p3CNy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3110A14
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:24:05 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384BD76
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:24:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso2057e87.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697793840; x=1698398640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVsFY/RycJBbaZ3+71huho7PHEWCHwdnXkSbqNMo3uY=;
        b=O31p3CNyYtgNgAkgILNLK8rpvQ/Jqx+7p6sIipiNuMptJSoLE+hdBRgty7Up6jnlOU
         omfbcLPTGM3GqqsE8UG7e9ybKnsy7EflY54GUKCMDbXOvnhMzgMw0hgZLqctq1PNNeNN
         gegOVWr9lT/+SyCBONoWiO2oyUDqKGw1vK05rRlIenWrX4Su3z+4Mf7Mq2jYDdIYx9+N
         PKJkVB5H2BsqoRzKhRSmFGXT9nTXHi3qZPA9ak5OayuHDKCI7CO7W0gLiXRgkIXOe70u
         I8FiYR8TL9RqfXIV2gydRPlhNvtcT+f1NkfpA7dY5BfDYWdH/DTl377ln9wj2/T+TzjV
         vsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793840; x=1698398640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVsFY/RycJBbaZ3+71huho7PHEWCHwdnXkSbqNMo3uY=;
        b=P/qFhJaAjBlVWjPoRT7eHPHwt8EXa6og7sssMIEY05/zbLUIBMEmTTh3oI0Zb4vOvT
         19hL0bH6VYqpCRHK3lpmZw/aaeML5CoF1z/weBLRLJCX4uvz+KoewHKVAIWm46ZarezN
         qsYjNFmi3uEiGAWRNDG1/pXqrvYqtJobGIGkUiD6GP+QO7VIwVH/bbwvolTaEdP7UWAq
         8Czhr88j4Q9vJo6C8s8hC31w951FSsmFaDYGgY3On+qiUU2ML483OzGnzc2Rb87ToFU4
         v5fj25xnsYq1vb3y6SNuoRcJcJOnYnLy69w+n4WY5U8eLRPlTRTxZsqSXvl8o0KqA9/W
         HB9A==
X-Gm-Message-State: AOJu0YxlpfljyG1gaCRGacxK7ZavVu2AFv1ih4++eandFSgJRYue9AZI
	JiymjG4f52QBXy8OLdcd8Y+qtsgbfg13dSHBryrPaA==
X-Google-Smtp-Source: AGHT+IEFBVwCuuybnWySaqd2/pGUgXRei07pukYlNc9qCmRtkPHt6ZhPJWHItuPxeuxH5DufADnDAfJTvIKs3gTHaX8=
X-Received: by 2002:ac2:5e6f:0:b0:501:b029:1a47 with SMTP id
 a15-20020ac25e6f000000b00501b0291a47mr51707lfr.1.1697793839837; Fri, 20 Oct
 2023 02:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
 <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com> <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
In-Reply-To: <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Oct 2023 11:23:46 +0200
Message-ID: <CANn89iK6WE1MUdHKfNcEf=uhKXustwQ-mtC5_toVAkz=VFctgQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 8:39=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> On Fri, Oct 20, 2023 at 1:06=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Oct 20, 2023 at 7:32=E2=80=AFAM Yan Zhai <yan@cloudflare.com> w=
rote:
> > >
> > > dst_allfrag was added before the first git commit:
> > >
> > > https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399=
.html
> > >
> > > The feature would send packets to the fragmentation path if a box
> > > receives a PMTU value with less than 1280 byte. However, since commit
> > > 9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
> > > message would be simply discarded. The feature flag is neither suppor=
ted
> > > in iproute2 utility. In theory one can still manipulate it with direc=
t
> > > netlink message, but it is not ideal because it was based on obsolete=
d
> > > guidance of RFC-2460 (replaced by RFC-8200).
> > >
> > > The feature test would always return false at the moment, so remove i=
t
> > > from the output path.
> >
> > What about other callers of dst_allfrag() ?
> >
> > This feature seems broken atm.
>
> It is broken as far as I can tell. The reason I removed just one
> caller here is to keep the code simpler and consistent. If I don't do
> so, I ought to test it for both GSO fast path and slow path to be
> logically consistent. Seems an overkill to me. For the removal of the
> rest, I'd hope it could come in as a standalone patch(set) because it
> is not just callers but also those unnecessary flags and tests on IP
> corks and sockets, not quite aligned with this patch's intention. I
> noted you have drafted something like this in the past:
>
> https://lkml.kernel.org/netdev/1335348157.3274.30.camel@edumazet-glaptop/
>
> I guess it might be a good base point to work on as a new patch(set)?
> What's your call on this?
>

I am about to send a TCP patch series to enable usec TSval (instead of ms),
and was planning to use a new RTAX_FEATURE_TCP_USEC_TS.

I also noticed that iproute2 was not supporting RTAX_FEATURE_ALLFRAG,
so we might kill it completely ?

commit b258c87639f77d772c077a4e45dad602c62c9f1c
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Oct 18 09:33:38 2023 +0000

    tcp: add RTAX_FEATURE_TCP_USEC_TS

    This new dst feature flag will be used to allow TCP to use usec
    based timestamps instead of msec ones.

    ip route .... feature tcp_usec_ts

    Also document that RTAX_FEATURE_SACK and RTAX_FEATURE_TIMESTAMP
    are unused.

    Note that iproute2 does yet support RTAX_FEATURE_ALLFRAG ?

    Signed-off-by: Eric Dumazet <edumazet@google.com>

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 51c13cf9c5aee4a2d1ab33c1a89043383d67b9cf..aa2482a0614aa685590fcc73819=
cbe1baac63d66
100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -502,13 +502,17 @@ enum {

 #define RTAX_MAX (__RTAX_MAX - 1)

-#define RTAX_FEATURE_ECN       (1 << 0)
-#define RTAX_FEATURE_SACK      (1 << 1)
-#define RTAX_FEATURE_TIMESTAMP (1 << 2)
-#define RTAX_FEATURE_ALLFRAG   (1 << 3)
-
-#define RTAX_FEATURE_MASK      (RTAX_FEATURE_ECN | RTAX_FEATURE_SACK | \
-                                RTAX_FEATURE_TIMESTAMP | RTAX_FEATURE_ALLF=
RAG)
+#define RTAX_FEATURE_ECN               (1 << 0)
+#define RTAX_FEATURE_SACK              (1 << 1) /* unused */
+#define RTAX_FEATURE_TIMESTAMP         (1 << 2) /* unused */
+#define RTAX_FEATURE_ALLFRAG           (1 << 3)
+#define RTAX_FEATURE_TCP_USEC_TS       (1 << 4)
+
+#define RTAX_FEATURE_MASK      (RTAX_FEATURE_ECN |             \
+                                RTAX_FEATURE_SACK |            \
+                                RTAX_FEATURE_TIMESTAMP |       \
+                                RTAX_FEATURE_ALLFRAG |         \
+                                RTAX_FEATURE_TCP_USEC_TS)

 struct rta_session {
        __u8    proto;

