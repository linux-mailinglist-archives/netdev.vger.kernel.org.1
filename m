Return-Path: <netdev+bounces-44061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CA7D5F75
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF61F218B3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33D15B6;
	Wed, 25 Oct 2023 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeG2Ep3R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6515B5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:18:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871E199
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698196722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+sYLcUznLWz6ItrEA9/mdy00grfjauD3njlab1BHl8=;
	b=HeG2Ep3R3ouYd4KGz2w8Im5wqN8NRNgaMraeMe5WB5r7H+t1xOHQmcChbNxLKmK42lqsXQ
	2cBzrx/RXrPSbP/M8+fJSXfjhqiXNtxvS5q+DzHy57yB2cKxomHpqLyqAedQ+MFcji0PGt
	mzRWbR/WCReHILvP41OLzP2eM2VVp6Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-RmNubyw6NUKeeUsvJi97nw-1; Tue, 24 Oct 2023 21:18:40 -0400
X-MC-Unique: RmNubyw6NUKeeUsvJi97nw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507a3426041so5504212e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698196719; x=1698801519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+sYLcUznLWz6ItrEA9/mdy00grfjauD3njlab1BHl8=;
        b=uUdkKaqYsijBNQOTfOImnaRNpOWHaGRpdhEPLz8WCS6NXhuC62UStB226N9FE54j2E
         VMaWpXJsxVNLI5ieSuty2RpG2eXOLbC9k4pP22VXLRDlSNWeBC5nWfpTbAWcFMZYttu4
         6pFbb+9UwmL0R+fz639j9AzoCfb0QpzzgFHBul1IKezucP9qYGMgXFZfF863jM5NuyYY
         DiNM9O1EnYOYGrcBmI95/k+Qap9YCSfMXhRyN0X4DZZobTfeB1WW44aeLANeZKz37RZY
         RpxQM2E1c2bgumZ51murPzAKQrIgPOcqpeC6CGPFgYEvoT7MDG58jslYsW1lLSJnunRl
         OLcw==
X-Gm-Message-State: AOJu0YyaEbAESgGGI4VaEBPJ/9OnWnoDV7UwikXAVd1vyYGBJirP0Y6/
	zJhk1K69rOnRbvfPYj+nnBVYorvbJKSrXMJgJb+1MCttH5oECoLlRpQDyLiLgv5f8i4+96C3WEy
	UWcO+EjLNT+WFtvLBQmoN7hspJqp196G6
X-Received: by 2002:a05:6512:2098:b0:4fe:ecd:4950 with SMTP id t24-20020a056512209800b004fe0ecd4950mr8324343lfr.1.1698196718822;
        Tue, 24 Oct 2023 18:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4xiciGsLWrc8jU7nWVlxCfaJXZLHo7Wgqcioh9NM4+EkVTjHFntGoxrq0EFHdcfAj2XvFbsBZLNlWPys+h8=
X-Received: by 2002:a05:6512:2098:b0:4fe:ecd:4950 with SMTP id
 t24-20020a056512209800b004fe0ecd4950mr8324332lfr.1.1698196718401; Tue, 24 Oct
 2023 18:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com> <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
In-Reply-To: <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 09:18:27 +0800
Message-ID: <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
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

On Tue, Oct 24, 2023 at 8:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/10/12 =E4=B8=8B=E5=8D=884:29, Jason Wang =E5=86=99=E9=81=
=93:
> > On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> Now, virtio-net already supports per-queue moderation parameter
> >> setting. Based on this, we use the netdim library of linux to support
> >> dynamic coalescing moderation for virtio-net.
> >>
> >> Due to hardware scheduling issues, we only tested rx dim.
> > Do you have PPS numbers? And TX numbers are also important as the
> > throughput could be misleading due to various reasons.
>
> Hi Jason!
>
> The comparison of rx netdim performance is as follows:
> (the backend supporting tx dim is not yet ready)

Thanks a lot for the numbers.

I'd still expect the TX result as I did play tx interrupt coalescing
about 10 years ago.

I will start to review the series but let's try to have some TX numbers as =
well.

Btw, it would be more convenient to have a raw PPS benchmark. E.g you
can try to use a software or hardware packet generator.

Thanks

>
>
> I. Sockperf UDP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Env
> rxq_0 is affinity to cpu_0
>
> 2. Cmd
> client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
> server: taskset -c 0 sockperf sr -p 8989
>
> 3. Result
> dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
> dim on: 1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> II. Redis
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Env
> There are 8 rxqs and rxq_i is affinity to cpu_i.
>
> 2. Result
> When all cpus are 100%, ops/sec of memtier_benchmark client is
> dim off:   978437.23
> dim on: 1143638.28
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> III. Nginx
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Env
> There are 8 rxqs and rxq_i is affinity to cpu_i.
>
> 2. Result
> When all cpus are 100%, requests/sec of wrk client is
> dim off:   877931.67
> dim on: 1019160.31
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thanks!
>
> >
> > Thanks
> >
> >> @Test env
> >> rxq0 has affinity to cpu0.
> >>
> >> @Test cmd
> >> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> >> server: taskset -c 0 sockperf sr --tcp
> >>
> >> @Test res
> >> The second column is the ratio of the result returned by client
> >> when rx dim is enabled to the result returned by client when
> >> rx dim is disabled.
> >>          --------------------------------------
> >>          | msg_size |  rx_dim=3Don / rx_dim=3Doff |
> >>          --------------------------------------
> >>          |   14B    |         + 3%            |
> >>          --------------------------------------
> >>          |   100B   |         + 16%           |
> >>          --------------------------------------
> >>          |   500B   |         + 25%           |
> >>          --------------------------------------
> >>          |   1400B  |         + 28%           |
> >>          --------------------------------------
> >>          |   2048B  |         + 22%           |
> >>          --------------------------------------
> >>          |   4096B  |         + 5%            |
> >>          --------------------------------------
> >>
> >> ---
> >> This patch set was part of the previous netdim patch set[1].
> >> [1] was split into a merged bugfix set[2] and the current set.
> >> The previous relevant commentators have been Cced.
> >>
> >> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.al=
ibaba.com/
> >> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alib=
aba.com/
> >>
> >> Heng Qi (5):
> >>    virtio-net: returns whether napi is complete
> >>    virtio-net: separate rx/tx coalescing moderation cmds
> >>    virtio-net: extract virtqueue coalescig cmd for reuse
> >>    virtio-net: support rx netdim
> >>    virtio-net: support tx netdim
> >>
> >>   drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-----=
--
> >>   1 file changed, 322 insertions(+), 72 deletions(-)
> >>
> >> --
> >> 2.19.1.6.gb485710b
> >>
> >>
>
>


