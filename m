Return-Path: <netdev+bounces-23386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE776BC3D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D813B281191
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05171235BA;
	Tue,  1 Aug 2023 18:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D1200AC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:22:07 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C342D6D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:21:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso33191cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690914118; x=1691518918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbG0nyY/AjsbcG4S3rmD3TLsWvnfk1smjHET5BfHHnA=;
        b=jPzPd8uk1aszQhIp2MX9n1uCDtpjJiX3Tbw837lMuMa7NjLCTEaLEUwJsI5Q85I20z
         l0Besy2MFYZfsTj4CqxADx6vWh/Kr2JKN8Bv+I2dvPZvMsBs765YrBYvaTzGpHEKLE0H
         4jj0WfZqrjYZCv0WclIqc/CM8LeqEcE4FG9WpfhRGKuBniilN2lIGIdG1YoWDg/tpHhD
         mJgXJ13V0k2VqkmyT6Hvai7KdqhVqxIiwnHHvsz7ih1+ofcRSGoLYH+wUazxHSZKuMSh
         8Fu7dJh7pq8QjBXsIgf+WDOhO1eyzv6jtnctsjYlwhtdkFuM4kDK/u4z2ZUo5t5w+Z/R
         55Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914118; x=1691518918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbG0nyY/AjsbcG4S3rmD3TLsWvnfk1smjHET5BfHHnA=;
        b=fjuhwr1dC8/izE+jfX7V7jHTRTMh5qFwYnik9jx5FsvHN9NTTBS+D+cHsOA8YRw3Qm
         H/g7vrfPFNMokiuIkLdQmJ+KTpWIkMXDEkg6UiaaVigZ8VKPP70iDsThTbaMxdC+6b7H
         WdNaZYvDG/nF6MOX2cnLs0UToOF/v11WJJr5WzcRcPLszio9kNVM6dkAunHXrw8cVipX
         tfWm+RkT6AK64+tG8ecCBKbs4knytIgdj4/GlbAYxEeSDmFIM3c80I6LkGQ3/DSDKV4n
         Ig6tPHeJmlEs2B0feBHGyZ+SlTN7QWt+1vJYdTLDJV5g1o7F+3N8R0rUx0+EMBuj9HDN
         HE/Q==
X-Gm-Message-State: ABy/qLZkF3LdzahQqtY7P1SB0e5X7l9QMMNSid7YSaLTt9lrQbjm13/A
	VmtrAPZB3qYRYNIOCY2Lpt+onV48fDH7Ehvw5O/wD4+9oEtlBKYGMAeiZQ==
X-Google-Smtp-Source: APBJJlFdxOWSjBBAGkcuv36yJLLFFG2xk5+xLdDPfKwJCVqSwsoSLjq7PbJIDDB7zQAvbknJa1NjxLfgRQBhTt3FVLs=
X-Received: by 2002:ac8:5704:0:b0:403:d35d:4660 with SMTP id
 4-20020ac85704000000b00403d35d4660mr856772qtw.11.1690914118263; Tue, 01 Aug
 2023 11:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com> <20230801135455.268935-2-edumazet@google.com>
 <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
 <CANn89iJwP_Ar57Te0EG2fAjM=JNL+N0mYwnEZDrJME4nhe4WTg@mail.gmail.com>
 <64c947578a8c7_1c9eb8294e6@willemb.c.googlers.com.notmuch> <CANn89iK80Oi6Hg90DXbXk=cyJxbzGD3zaFGGTSuWVvC5mNnR_Q@mail.gmail.com>
In-Reply-To: <CANn89iK80Oi6Hg90DXbXk=cyJxbzGD3zaFGGTSuWVvC5mNnR_Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 20:21:47 +0200
Message-ID: <CANn89iJQfmc_KeUr3TeXvsLQwo3ZymyoCr7Y6AnHrkWSuz0yAg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to
 allocate bigger packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Aug 1, 2023 at 7:56=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
>
> > Thanks for the explanation. For @data_len =3D=3D 5000, you would want t=
o
> > allocate an order-1?
>
> Presumably we could try a bit harder, I will send a V2.

I will squash the following part:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0ac70a0144a7c1f4e7824ddc19980aee73e4c121..c6f98245582cd4dd01a7c4f5708=
163122500a4f0
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6233,7 +6233,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned
long header_len,
        while (data_len) {
                if (nr_frags =3D=3D MAX_SKB_FRAGS - 1)
                        goto failure;
-               while (order && data_len < (PAGE_SIZE << order))
+               while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order)=
)
                        order--;

                if (order) {

