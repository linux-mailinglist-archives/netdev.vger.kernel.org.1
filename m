Return-Path: <netdev+bounces-31018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D4B78A8FA
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DE91C208EE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791A6120;
	Mon, 28 Aug 2023 09:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C566611E
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:31:44 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB52C2
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:31:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so333151cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693215103; x=1693819903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aImaCUpd15w6Z50jIH/8b5YX0+tQXUFAi5vOGxQzEg=;
        b=P6Fds/oeSwtSz5nk3ZDfBS/l2/gMH8hHwirTqw9pxlyS7CEAl/VNvYUYrfqDerOFj7
         fDXapXhXCkvq8QyJ61KGuix8kV7pb43dJix8p4DZCgzBb4+kAPAUpG4GfoVm8bWoHPN8
         mikXQHaKGDyI6MF6suOEFTZzgdP3utqVpYfPL2eerpFi91jSpLSu3BpyHDoj5vIH4I/g
         CXse9oxSTAfUjkKdYa1sagIDs/L218CN8+WRNLmslQTVXGyL666el6+B26TkQ/AidiQP
         MH/R75jFD+0aqvhNZ7ltX2mSnf6Ul1y0ezWjUhWKyMeTMXQj4ERhfNX7dHs4Fm4pZRvs
         uKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693215103; x=1693819903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aImaCUpd15w6Z50jIH/8b5YX0+tQXUFAi5vOGxQzEg=;
        b=Is5K4wV2K49duZM1tgAUfEj3tPbVYsd81swXHyTlF8xaulhouNZYXCdPIU/EQbyErJ
         8+nGZt3XHAYfBwG7zDno82HBlJvCEiCArfafka+2iw+kkJ5NnBVAjGwWw4e71YJjkJXM
         aj/TMdfQgAhf0qeuTSWZ5tGuKpaH/scAKIcJg2ZULNruodBSFHTavyPZ2tfQp0GcuJEf
         KVbq1r0bdpu5+20Xf/USMrUvHfdXiKvPdVroPYZuE/QIGccgDEX/lVxTxWcwINHl0g9e
         FwihcsAQVvS1/X62FwB6RsnwLKXHys0SuJULxF2e2PxCIlao9WDajE2CuLjHhY2t3NNX
         PZ8w==
X-Gm-Message-State: AOJu0YwMCXmTA2YDNHdF1ANcMI6g4n1wEFNEMV+ZZo8cB4g8lt2ymdbu
	e+vuQRxIg9vpYDekZI8mv9jay3RRtj3q3Mwim/Ch+Z1tp4PEYHyMB+M=
X-Google-Smtp-Source: AGHT+IGiXI80Ug9N5nOC64BTv95E0lqUHlK8/xym8ZmIhF2oPHQtZpmruRtUBsLLcvBvr4IAotf6xaWCVlYnvenqsBg=
X-Received: by 2002:a05:622a:1910:b0:412:16f:c44f with SMTP id
 w16-20020a05622a191000b00412016fc44fmr331181qtc.6.1693215102925; Mon, 28 Aug
 2023 02:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819044059.833749-1-edumazet@google.com> <20230819044059.833749-4-edumazet@google.com>
 <ZOEOS5Qf4o2xw1Gj@vergenet.net>
In-Reply-To: <ZOEOS5Qf4o2xw1Gj@vergenet.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Aug 2023 11:31:31 +0200
Message-ID: <CANn89iKXGXPQZj2nm8ZRdXJsp8A32MSp9BTxhYu7WVns2eAknA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: l2tp_eth: use generic dev->stats fields
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 8:47=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sat, Aug 19, 2023 at 04:40:59AM +0000, Eric Dumazet wrote:
> > Core networking has opt-in atomic variant of dev->stats,
> > simply use DEV_STATS_INC(), DEV_STATS_ADD() and DEV_STATS_READ().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/l2tp/l2tp_eth.c | 32 ++++++++++++--------------------
> >  1 file changed, 12 insertions(+), 20 deletions(-)
> >
> > diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
>
> ...
>
> > @@ -146,10 +138,10 @@ static void l2tp_eth_dev_recv(struct l2tp_session=
 *session, struct sk_buff *skb,
> >
> >       priv =3D netdev_priv(dev);
> >       if (dev_forward_skb(dev, skb) =3D=3D NET_RX_SUCCESS) {
> > -             atomic_long_inc(&priv->rx_packets);
> > -             atomic_long_add(data_len, &priv->rx_bytes);
> > +             DEV_STATS_INC(dev, rx_packets);
> > +             DEV_STATS_ADD(dev, rx_bytes, data_len);
>
> Hi Eric,
>
> W=3D1 builds with clang-16 and gcc-13 tell me that priv
> is set but unused if this branch is taken.

Oops, thanks, will fix in V2.

