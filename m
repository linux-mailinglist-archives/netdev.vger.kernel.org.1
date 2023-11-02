Return-Path: <netdev+bounces-45633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D117DEBE7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A145B2102F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE3EA1;
	Thu,  2 Nov 2023 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFHTDZrW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D2637
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:34:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61177A6
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698899677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpFEm29NArlyMffn6cLyxmCPyrgtdaJfg31aiJan1nE=;
	b=BFHTDZrWcAcz8REnkkZebGnrsGYLxgPXix3PhPE0rVbRBL1zg6XYxgQqVvwVIpLKO/DDFq
	4nICJ3BL0zFgBUvXDrFvufZ6nK0qEmn5QapSgAQrSG6OOjEwLMTKf0ADeDRaSHyjG2+TOE
	9Z12o+bUrOc4tVGvG6bkUwXoWn6BG+A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-TtRDsdb0NS-x84d1AvJ7Zw-1; Thu, 02 Nov 2023 00:34:36 -0400
X-MC-Unique: TtRDsdb0NS-x84d1AvJ7Zw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5af592fed43so8212767b3.2
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 21:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698899676; x=1699504476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpFEm29NArlyMffn6cLyxmCPyrgtdaJfg31aiJan1nE=;
        b=TxBX1l6NKuu6xIY58adMUz2HcA8k7VHcjmz85RLBPrYdN0mKmCuGhR76WCbdlidcJc
         hEVUxWGpubT7MwB6Rs1l+HNmAz3P/wBuAFloXQdcK9OEkN2ZVla5Lj7SZjB45g2WMhBX
         oT60KaiL1lWW0dlFFIJWONHcbtjdcz/cyRAQxRVKUtMjF72kYpb5lgFDJHBndR/JcY2b
         GNdWOmx1IoLEIAvuKTp+p303EznVZY0j8FLa+bTKxinnmHxi3leDE6X1vaQ2nP2GUIcN
         Idbu/cPvnQEQqrndR+dslgKjiMk2ypwI6cCfTE3Q0jLQnMm916Lis4IklxI9Ko1nq0Ot
         Yaww==
X-Gm-Message-State: AOJu0YzXXZiGIzOb89nqYRnhyKVfCv91ocQVNZSkQd/EQSsVjkrcm22a
	RYc9uLVvPuJU8GrMi09MDXeE2WBVMh8CvY1DrhmI6wsiE28Z3xcYVtlpr68LZiHs55K/NeD//kV
	UpPJmWwNwNH/FHFNBTbbc03M6D3KRtsJE
X-Received: by 2002:a25:b01:0:b0:da0:54f7:11cf with SMTP id 1-20020a250b01000000b00da054f711cfmr14684442ybl.49.1698899675691;
        Wed, 01 Nov 2023 21:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsr0DLVOjExS4bDDTCowgNddNfuKIoTKGW6eeX2ycBl+rpwgfp06N8w0hPu441s4dXOo9yoKU3wJY/gYL0MQ8=
X-Received: by 2002:a25:b01:0:b0:da0:54f7:11cf with SMTP id
 1-20020a250b01000000b00da054f711cfmr14684427ybl.49.1698899675399; Wed, 01 Nov
 2023 21:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com> <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
 <753ac6da-f7f1-4acb-9184-e59271809c6d@linux.alibaba.com>
In-Reply-To: <753ac6da-f7f1-4acb-9184-e59271809c6d@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 12:34:23 +0800
Message-ID: <CACGkMEsRVV9mgVe2+Qe89QZD807KV8jyBmAz5--Z3NiZBPrPVg@mail.gmail.com>
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

On Wed, Nov 1, 2023 at 5:38=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/10/25 =E4=B8=8A=E5=8D=889:18, Jason Wang =E5=86=99=E9=81=
=93:
> > On Tue, Oct 24, 2023 at 8:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2023/10/12 =E4=B8=8B=E5=8D=884:29, Jason Wang =E5=86=99=E9=
=81=93:
> >>> On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>> Now, virtio-net already supports per-queue moderation parameter
> >>>> setting. Based on this, we use the netdim library of linux to suppor=
t
> >>>> dynamic coalescing moderation for virtio-net.
> >>>>
> >>>> Due to hardware scheduling issues, we only tested rx dim.
> >>> Do you have PPS numbers? And TX numbers are also important as the
> >>> throughput could be misleading due to various reasons.
> >> Hi Jason!
> >>
> >> The comparison of rx netdim performance is as follows:
> >> (the backend supporting tx dim is not yet ready)
> > Thanks a lot for the numbers.
> >
> > I'd still expect the TX result as I did play tx interrupt coalescing
>
> Hi, Jason.
>
> Sorry for the late reply to this! Our team has been blocked by other
> priorities the past few days.
>
> For tx dim, we have a fixed empirical value internally.
> This value performs better overall than manually adjusting the tx timer
> register -->
> I'll do not have tx numbers. :( So in the short term I no longer try to
> push [5/5]
> patch for tx dim and try to return -EOPNOTSUPP for it, sorry for this.
>
> > about 10 years ago.
> >
> > I will start to review the series but let's try to have some TX numbers=
 as well.
> >
> > Btw, it would be more convenient to have a raw PPS benchmark. E.g you
>
> I got some raw pps data using pktgen from linux/sample/pktgen:
>
> 1. tx cmd
> ./pktgen_sample02_multiqueue.sh -i eth1 -s 44 -d ${dst_ip} -m ${dst_mac}
> -t 8 -f 0 -n 0
>
> This uses 8 kpktgend threads to inject data into eth1.
>
> 2. Rx side loads a simple xdp prog which drops all received udp packets.
>
> 3. Data
> pps: ~1000w

For "w" did you mean 10 million? Looks too huge to me?

> rx dim off: cpu idle=3D ~35%
> rx dim on: cpu idle=3D ~76%

This looks promising.

Thanks

>
> Thanks!
>
> > can try to use a software or hardware packet generator.
> >
> > Thanks
> >
> >>
> >> I. Sockperf UDP
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> 1. Env
> >> rxq_0 is affinity to cpu_0
> >>
> >> 2. Cmd
> >> client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
> >> server: taskset -c 0 sockperf sr -p 8989
> >>
> >> 3. Result
> >> dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
> >> dim on: 1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>
> >>
> >> II. Redis
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> 1. Env
> >> There are 8 rxqs and rxq_i is affinity to cpu_i.
> >>
> >> 2. Result
> >> When all cpus are 100%, ops/sec of memtier_benchmark client is
> >> dim off:   978437.23
> >> dim on: 1143638.28
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>
> >>
> >> III. Nginx
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> 1. Env
> >> There are 8 rxqs and rxq_i is affinity to cpu_i.
> >>
> >> 2. Result
> >> When all cpus are 100%, requests/sec of wrk client is
> >> dim off:   877931.67
> >> dim on: 1019160.31
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>
> >> Thanks!
> >>
> >>> Thanks
> >>>
> >>>> @Test env
> >>>> rxq0 has affinity to cpu0.
> >>>>
> >>>> @Test cmd
> >>>> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> >>>> server: taskset -c 0 sockperf sr --tcp
> >>>>
> >>>> @Test res
> >>>> The second column is the ratio of the result returned by client
> >>>> when rx dim is enabled to the result returned by client when
> >>>> rx dim is disabled.
> >>>>           --------------------------------------
> >>>>           | msg_size |  rx_dim=3Don / rx_dim=3Doff |
> >>>>           --------------------------------------
> >>>>           |   14B    |         + 3%            |
> >>>>           --------------------------------------
> >>>>           |   100B   |         + 16%           |
> >>>>           --------------------------------------
> >>>>           |   500B   |         + 25%           |
> >>>>           --------------------------------------
> >>>>           |   1400B  |         + 28%           |
> >>>>           --------------------------------------
> >>>>           |   2048B  |         + 22%           |
> >>>>           --------------------------------------
> >>>>           |   4096B  |         + 5%            |
> >>>>           --------------------------------------
> >>>>
> >>>> ---
> >>>> This patch set was part of the previous netdim patch set[1].
> >>>> [1] was split into a merged bugfix set[2] and the current set.
> >>>> The previous relevant commentators have been Cced.
> >>>>
> >>>> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.=
alibaba.com/
> >>>> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.al=
ibaba.com/
> >>>>
> >>>> Heng Qi (5):
> >>>>     virtio-net: returns whether napi is complete
> >>>>     virtio-net: separate rx/tx coalescing moderation cmds
> >>>>     virtio-net: extract virtqueue coalescig cmd for reuse
> >>>>     virtio-net: support rx netdim
> >>>>     virtio-net: support tx netdim
> >>>>
> >>>>    drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++--=
-----
> >>>>    1 file changed, 322 insertions(+), 72 deletions(-)
> >>>>
> >>>> --
> >>>> 2.19.1.6.gb485710b
> >>>>
> >>>>
> >>
>


