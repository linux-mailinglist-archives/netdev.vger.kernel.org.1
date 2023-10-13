Return-Path: <netdev+bounces-40582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BD7C7B55
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3923B282CC1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CCA29;
	Fri, 13 Oct 2023 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OucJC2Ld"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146181D
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:54:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E8BB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697162047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzCwnSkLK4z8nW8eRHDCWg2SmXFxgaZjbH2hutqa4/I=;
	b=OucJC2LdwcN/rfYdQHMKdO/kLZnWiNpRTjxJy3xPr9Isfn5jlH9AL/R+7J8kMtG0qaal/w
	LgSF2ZXM/277cgmWutcMzZjEEjSfakNH2qWug/VlAi+X98N7KHmdXK6x620yfeBS1dTfM6
	nc7yTXIoqSz7WCRoH/F/AxAi1bYZp1Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-s0nz_KjPNx-eBfgiD0gkpQ-1; Thu, 12 Oct 2023 21:54:06 -0400
X-MC-Unique: s0nz_KjPNx-eBfgiD0gkpQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ff15946fso14978261fa.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697162045; x=1697766845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzCwnSkLK4z8nW8eRHDCWg2SmXFxgaZjbH2hutqa4/I=;
        b=h3QeSAfL/hGH1ygyCXaNqSQk5k0Ywa7N1zdbouSRq7ulT93wi23B4IVD66Pq7FV3MY
         K/jllrWMzb9WvvavKN5CrqD+v9cJaZTnRIknvgIVZ34F/gC5FXKknY0tE8jlP7unGCMY
         x0alvRNWmZjM7083V8qBWJXpNYNKbZJDylIOb/+ElacuGU1W8dsOy2Sz8hS0J6dEdVRH
         129UmpnmyKl75JuHQbMOzmY7vXPh9ZJc5pCNpQePntnCOlsaWNomv/g/YzwaXOWWIdkB
         Pyq8iy2ezyDRh9oFoSnTw1cuBwYFOYZNOQMuh0gb6ko/Gy4KCKAPUFtXqbaVsusDzmqM
         vjrA==
X-Gm-Message-State: AOJu0YxqFgA0drhZyluuoa0kNk9Ypmh18ISHSb0yxi2hzgtTkN+JNHQE
	4zf+KG6u5ARb1rxaA6BoyPZ4CUciMNFvaWjCP5PzRa9u2JH668qCKSs6tIkVEAcfmL5sTwDrwCA
	Nud5gDgeidikZr6Dh6zUiQEYQOn0V/zaS
X-Received: by 2002:a05:6512:398d:b0:507:8c55:39f9 with SMTP id j13-20020a056512398d00b005078c5539f9mr5344942lfu.49.1697162045070;
        Thu, 12 Oct 2023 18:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYb4LeCe4Fje2tNzGbkvrJkssqt3nF37jxl4CADpfU3I/mxG0byPqvUsoUYvZGYy6fP0/Wg34Cz+06KTOgLTA=
X-Received: by 2002:a05:6512:398d:b0:507:8c55:39f9 with SMTP id
 j13-20020a056512398d00b005078c5539f9mr5344931lfu.49.1697162044757; Thu, 12
 Oct 2023 18:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com> <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
In-Reply-To: <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 09:53:53 +0800
Message-ID: <CACGkMEshFckmtY3RyNYiEATFkDkCvQSMWq1-3LwbM2gVgqPxVw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing moderation
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Liu, Yujie" <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 4:29=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > Now, virtio-net already supports per-queue moderation parameter
> > setting. Based on this, we use the netdim library of linux to support
> > dynamic coalescing moderation for virtio-net.
> >
> > Due to hardware scheduling issues, we only tested rx dim.
>
> Do you have PPS numbers? And TX numbers are also important as the
> throughput could be misleading due to various reasons.

Another consideration:

We currently have two TX mode, NAPI by default, and orphan. Simple
pktgen test shows NAPI can only achieve 30% of orphan. So we need to
make sure:

1) dim helps for NAPI, and if NAPI can compete with orphan, we can
drop the orphan code completely which is a great release and
simplification of the codes. And it means we can have BQL, and other
good stuff on top easily.
2) dim doesn't cause regression for orphan

Thanks

>
> Thanks
>
> >
> > @Test env
> > rxq0 has affinity to cpu0.
> >
> > @Test cmd
> > client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> > server: taskset -c 0 sockperf sr --tcp
> >
> > @Test res
> > The second column is the ratio of the result returned by client
> > when rx dim is enabled to the result returned by client when
> > rx dim is disabled.
> >         --------------------------------------
> >         | msg_size |  rx_dim=3Don / rx_dim=3Doff |
> >         --------------------------------------
> >         |   14B    |         + 3%            |
> >         --------------------------------------
> >         |   100B   |         + 16%           |
> >         --------------------------------------
> >         |   500B   |         + 25%           |
> >         --------------------------------------
> >         |   1400B  |         + 28%           |
> >         --------------------------------------
> >         |   2048B  |         + 22%           |
> >         --------------------------------------
> >         |   4096B  |         + 5%            |
> >         --------------------------------------
> >
> > ---
> > This patch set was part of the previous netdim patch set[1].
> > [1] was split into a merged bugfix set[2] and the current set.
> > The previous relevant commentators have been Cced.
> >
> > [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.ali=
baba.com/
> > [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.aliba=
ba.com/
> >
> > Heng Qi (5):
> >   virtio-net: returns whether napi is complete
> >   virtio-net: separate rx/tx coalescing moderation cmds
> >   virtio-net: extract virtqueue coalescig cmd for reuse
> >   virtio-net: support rx netdim
> >   virtio-net: support tx netdim
> >
> >  drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 322 insertions(+), 72 deletions(-)
> >
> > --
> > 2.19.1.6.gb485710b
> >
> >


