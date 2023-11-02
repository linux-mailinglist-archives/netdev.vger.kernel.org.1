Return-Path: <netdev+bounces-45632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7623D7DEBE3
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E791C20DC7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4B315B8;
	Thu,  2 Nov 2023 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2zhB8SZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B210EF
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:33:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38240DE
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698899595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y98Oj+fTiOqVHZf5XNKpFyZowS6KE9Dc3E1VJK061b4=;
	b=D2zhB8SZAL5k/tNZ2HguCSBrVfCCsGH7ep9AyPhgTlItKZQatyE/UZlyxV942uur0QOMB0
	D72ruZUW58Gb6M0lj135NXCs9WDtgZ+k9FO9obpVdYTH5p7R2E2kPCdlywowNduF5snegd
	WFp7PaX/iyswajiCBJB2/uwNxecB0DU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-7xGu0ZU8MROKFv9zAeqSgQ-1; Thu, 02 Nov 2023 00:33:13 -0400
X-MC-Unique: 7xGu0ZU8MROKFv9zAeqSgQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6707401e1aeso7219746d6.0
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 21:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698899593; x=1699504393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y98Oj+fTiOqVHZf5XNKpFyZowS6KE9Dc3E1VJK061b4=;
        b=iqVaYheI37z9ZIFnEOI96Wi81PugUf2qZaKrohd5EeYprdgUCO5+x8X+brdkGmGMdb
         URWEc+KNDS18IYyAhIqbM2LnJnpE96eOkZQpvfA3IWPvTctjnWw9kUYrjCrJQB164Vt8
         BXRU1cbKMUf8mmCG+bJYT+1vAgHIohul1nl+AuJnT77NcP+cCcMijHq2KxpIP6iMAFuO
         1XwJKDY7buJI7dli15fM4vczOjdup+UYbxdAm+XmX49YakCf++fXe/RLUkNAmne6h8ti
         5xx++Zbf45PyQOl9S639e9y73zC3bFBiBJYKGIuMYxs/OPpi3jgc6Bvj4eMzIfaK2QCc
         0mvQ==
X-Gm-Message-State: AOJu0Yx9Up0TP3G2xnwkiLOcWNoFTaVOe7fGeZXn2mkqQ3s8BMsCuqyR
	+ubjyae+p5iwVqVc7GPIMXWVtUeGUxe3sP197AhLK0MhZM1CDXMoux78R88o+olpWQDa6PoQDVi
	kP+gtm4I/fAX0BtBneaMF3h/SzULxt9x6
X-Received: by 2002:a05:6214:aca:b0:673:b0e7:1916 with SMTP id g10-20020a0562140aca00b00673b0e71916mr10917468qvi.2.1698899593191;
        Wed, 01 Nov 2023 21:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7nlFlO39vZUy7zUX/dKshbsIenSEP1pKRrU9XA0UfkY4zAhtRq4JUZ77uWhbM/nKAkjBU1ml5Ybe7rqUC4Yw=
X-Received: by 2002:a05:6214:aca:b0:673:b0e7:1916 with SMTP id
 g10-20020a0562140aca00b00673b0e71916mr10917453qvi.2.1698899592888; Wed, 01
 Nov 2023 21:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com> <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
 <20231025015243-mutt-send-email-mst@kernel.org> <d3b9e9e8-1ef4-48ac-8a2f-4fa647ae4372@linux.alibaba.com>
In-Reply-To: <d3b9e9e8-1ef4-48ac-8a2f-4fa647ae4372@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 12:33:01 +0800
Message-ID: <CACGkMEsQ4oDbXPQZ2boB-Bj36qzWs9Sx_Du9ZiJLe+-99DOtwQ@mail.gmail.com>
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

On Wed, Nov 1, 2023 at 7:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/10/25 =E4=B8=8B=E5=8D=881:53, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > On Wed, Oct 25, 2023 at 09:18:27AM +0800, Jason Wang wrote:
> >> On Tue, Oct 24, 2023 at 8:03=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>>
> >>>
> >>> =E5=9C=A8 2023/10/12 =E4=B8=8B=E5=8D=884:29, Jason Wang =E5=86=99=E9=
=81=93:
> >>>> On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> >>>>> Now, virtio-net already supports per-queue moderation parameter
> >>>>> setting. Based on this, we use the netdim library of linux to suppo=
rt
> >>>>> dynamic coalescing moderation for virtio-net.
> >>>>>
> >>>>> Due to hardware scheduling issues, we only tested rx dim.
> >>>> Do you have PPS numbers? And TX numbers are also important as the
> >>>> throughput could be misleading due to various reasons.
> >>> Hi Jason!
> >>>
> >>> The comparison of rx netdim performance is as follows:
> >>> (the backend supporting tx dim is not yet ready)
> >> Thanks a lot for the numbers.
> >>
> >> I'd still expect the TX result as I did play tx interrupt coalescing
> >> about 10 years ago.
> >>
> >> I will start to review the series but let's try to have some TX number=
s as well.
> >>
> >> Btw, it would be more convenient to have a raw PPS benchmark. E.g you
> >> can try to use a software or hardware packet generator.
> >>
> >> Thanks
> > Latency results are also kind of interesting.
>
> I test the latency using sockperf pp:
>
> @Rx cmd
> taskset -c 0 sockperf sr -p 8989
>
> @Tx cmd
> taskset -c 0 sockperf pp -i ${ip} -p 8989 -t 10
>
> After running this cmd 5 times and averaging the results,
> we get the following data:
>
> dim off: 17.7735 usec
> dim on: 18.0110 usec

Let's add those numbers to the changelog of the next version.

Thanks

>
> Thanks!
>
> >
> >
> >>>
> >>> I. Sockperf UDP
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>> 1. Env
> >>> rxq_0 is affinity to cpu_0
> >>>
> >>> 2. Cmd
> >>> client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
> >>> server: taskset -c 0 sockperf sr -p 8989
> >>>
> >>> 3. Result
> >>> dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
> >>> dim on: 1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>>
> >>>
> >>> II. Redis
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>> 1. Env
> >>> There are 8 rxqs and rxq_i is affinity to cpu_i.
> >>>
> >>> 2. Result
> >>> When all cpus are 100%, ops/sec of memtier_benchmark client is
> >>> dim off:   978437.23
> >>> dim on: 1143638.28
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>>
> >>>
> >>> III. Nginx
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>> 1. Env
> >>> There are 8 rxqs and rxq_i is affinity to cpu_i.
> >>>
> >>> 2. Result
> >>> When all cpus are 100%, requests/sec of wrk client is
> >>> dim off:   877931.67
> >>> dim on: 1019160.31
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>>
> >>> Thanks!
> >>>
> >>>> Thanks
> >>>>
> >>>>> @Test env
> >>>>> rxq0 has affinity to cpu0.
> >>>>>
> >>>>> @Test cmd
> >>>>> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size=
}
> >>>>> server: taskset -c 0 sockperf sr --tcp
> >>>>>
> >>>>> @Test res
> >>>>> The second column is the ratio of the result returned by client
> >>>>> when rx dim is enabled to the result returned by client when
> >>>>> rx dim is disabled.
> >>>>>           --------------------------------------
> >>>>>           | msg_size |  rx_dim=3Don / rx_dim=3Doff |
> >>>>>           --------------------------------------
> >>>>>           |   14B    |         + 3%            |
> >>>>>           --------------------------------------
> >>>>>           |   100B   |         + 16%           |
> >>>>>           --------------------------------------
> >>>>>           |   500B   |         + 25%           |
> >>>>>           --------------------------------------
> >>>>>           |   1400B  |         + 28%           |
> >>>>>           --------------------------------------
> >>>>>           |   2048B  |         + 22%           |
> >>>>>           --------------------------------------
> >>>>>           |   4096B  |         + 5%            |
> >>>>>           --------------------------------------
> >>>>>
> >>>>> ---
> >>>>> This patch set was part of the previous netdim patch set[1].
> >>>>> [1] was split into a merged bugfix set[2] and the current set.
> >>>>> The previous relevant commentators have been Cced.
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux=
.alibaba.com/
> >>>>> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.a=
libaba.com/
> >>>>>
> >>>>> Heng Qi (5):
> >>>>>     virtio-net: returns whether napi is complete
> >>>>>     virtio-net: separate rx/tx coalescing moderation cmds
> >>>>>     virtio-net: extract virtqueue coalescig cmd for reuse
> >>>>>     virtio-net: support rx netdim
> >>>>>     virtio-net: support tx netdim
> >>>>>
> >>>>>    drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-=
------
> >>>>>    1 file changed, 322 insertions(+), 72 deletions(-)
> >>>>>
> >>>>> --
> >>>>> 2.19.1.6.gb485710b
> >>>>>
> >>>>>
> >>>
>


