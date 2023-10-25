Return-Path: <netdev+bounces-44090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288E7D6157
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EDD281B49
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A720F749F;
	Wed, 25 Oct 2023 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRoFxW/y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337763D3
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:54:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC8130
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698213238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubCPHMOlreiJtQ+N6ueZ0lVtDni4RqOGkWgFbQwJEWk=;
	b=LRoFxW/ytudAoit7OHrFqK9zMcZwXCg4FcEOKJoqTzvKASyKsTpj9Xcas/SWy2kgMoVafX
	xSJfO/DiaEP4JmEeX2pep8cuG4qcS1j4G4ioj8NlEJQ4IVh4dZ8fR+MHQeHk0Uj4HDNACk
	DUvE2gtYiQEOgGa1S/HWOXnBTfGbHZw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-twHNpj44ODKFyd2kUEVrxg-1; Wed, 25 Oct 2023 01:53:45 -0400
X-MC-Unique: twHNpj44ODKFyd2kUEVrxg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d879cac50so2389939f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213224; x=1698818024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubCPHMOlreiJtQ+N6ueZ0lVtDni4RqOGkWgFbQwJEWk=;
        b=MA9AaKJHKLpCctbQcLmNGmGMFcl6tBqr6Qo1ESBX4UTAOYZEyrqEWRGdMkn+A6qbB4
         YkgFvPcxjHs9CL761EWFP2QVpzKK28bihyRKKRYBLhMATz1CDwgDGQZXAAUpmHtQZzPO
         9xYbHvnv6poQgPAZm/Z0K7eGbsHx5SAqQCbHhwaKNZfSXhHqgYNktTwNXBACEvN0YkjK
         GBZ75K2mpqk1FzngKsbv9aAOL0cu6Dp7DZOH8pqikR74JxFGBgCfV+FlH+dV28OKEXfV
         BpVOaU8+9oIXZuRKbXLTRrWGSPVP3byZAX8IflQGuzMD1FTFs6c0a3hA9rXIVGO6I7HX
         Gfgg==
X-Gm-Message-State: AOJu0YyEDZHKmhBdtoMAe9bJ2LzkReqJ23ijODt8sUigsT7Ywgjraqay
	GLk6m+omum1qx0sQfetOhPCxdcQf0zuW8EpGpDGi5SZ0vUGh0WkwWU9Pr0iN7Q80ZTIomHRPnbu
	KT3LK7uFMuWs37WLQ
X-Received: by 2002:a5d:58d4:0:b0:32d:ba1e:5cee with SMTP id o20-20020a5d58d4000000b0032dba1e5ceemr9743308wrf.45.1698213224520;
        Tue, 24 Oct 2023 22:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5c2YSpkwKFmHyjOBWo7oEpueedhzE4gMzP/K4t5T/VbmEHDv2P9mk7ciY/fkpt2iryR0m8A==
X-Received: by 2002:a5d:58d4:0:b0:32d:ba1e:5cee with SMTP id o20-20020a5d58d4000000b0032dba1e5ceemr9743299wrf.45.1698213224157;
        Tue, 24 Oct 2023 22:53:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00326f0ca3566sm11364036wrm.50.2023.10.24.22.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:53:43 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:53:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
Message-ID: <20231025015243-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
 <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>

On Wed, Oct 25, 2023 at 09:18:27AM +0800, Jason Wang wrote:
> On Tue, Oct 24, 2023 at 8:03 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> >
> >
> > 在 2023/10/12 下午4:29, Jason Wang 写道:
> > > On Thu, Oct 12, 2023 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > >> Now, virtio-net already supports per-queue moderation parameter
> > >> setting. Based on this, we use the netdim library of linux to support
> > >> dynamic coalescing moderation for virtio-net.
> > >>
> > >> Due to hardware scheduling issues, we only tested rx dim.
> > > Do you have PPS numbers? And TX numbers are also important as the
> > > throughput could be misleading due to various reasons.
> >
> > Hi Jason!
> >
> > The comparison of rx netdim performance is as follows:
> > (the backend supporting tx dim is not yet ready)
> 
> Thanks a lot for the numbers.
> 
> I'd still expect the TX result as I did play tx interrupt coalescing
> about 10 years ago.
> 
> I will start to review the series but let's try to have some TX numbers as well.
> 
> Btw, it would be more convenient to have a raw PPS benchmark. E.g you
> can try to use a software or hardware packet generator.
> 
> Thanks

Latency results are also kind of interesting.


> >
> >
> > I. Sockperf UDP
> > =================================================
> > 1. Env
> > rxq_0 is affinity to cpu_0
> >
> > 2. Cmd
> > client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
> > server: taskset -c 0 sockperf sr -p 8989
> >
> > 3. Result
> > dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
> > dim on: 1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
> > =================================================
> >
> >
> > II. Redis
> > =================================================
> > 1. Env
> > There are 8 rxqs and rxq_i is affinity to cpu_i.
> >
> > 2. Result
> > When all cpus are 100%, ops/sec of memtier_benchmark client is
> > dim off:   978437.23
> > dim on: 1143638.28
> > =================================================
> >
> >
> > III. Nginx
> > =================================================
> > 1. Env
> > There are 8 rxqs and rxq_i is affinity to cpu_i.
> >
> > 2. Result
> > When all cpus are 100%, requests/sec of wrk client is
> > dim off:   877931.67
> > dim on: 1019160.31
> > =================================================
> >
> > Thanks!
> >
> > >
> > > Thanks
> > >
> > >> @Test env
> > >> rxq0 has affinity to cpu0.
> > >>
> > >> @Test cmd
> > >> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> > >> server: taskset -c 0 sockperf sr --tcp
> > >>
> > >> @Test res
> > >> The second column is the ratio of the result returned by client
> > >> when rx dim is enabled to the result returned by client when
> > >> rx dim is disabled.
> > >>          --------------------------------------
> > >>          | msg_size |  rx_dim=on / rx_dim=off |
> > >>          --------------------------------------
> > >>          |   14B    |         + 3%            |
> > >>          --------------------------------------
> > >>          |   100B   |         + 16%           |
> > >>          --------------------------------------
> > >>          |   500B   |         + 25%           |
> > >>          --------------------------------------
> > >>          |   1400B  |         + 28%           |
> > >>          --------------------------------------
> > >>          |   2048B  |         + 22%           |
> > >>          --------------------------------------
> > >>          |   4096B  |         + 5%            |
> > >>          --------------------------------------
> > >>
> > >> ---
> > >> This patch set was part of the previous netdim patch set[1].
> > >> [1] was split into a merged bugfix set[2] and the current set.
> > >> The previous relevant commentators have been Cced.
> > >>
> > >> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/
> > >> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba.com/
> > >>
> > >> Heng Qi (5):
> > >>    virtio-net: returns whether napi is complete
> > >>    virtio-net: separate rx/tx coalescing moderation cmds
> > >>    virtio-net: extract virtqueue coalescig cmd for reuse
> > >>    virtio-net: support rx netdim
> > >>    virtio-net: support tx netdim
> > >>
> > >>   drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
> > >>   1 file changed, 322 insertions(+), 72 deletions(-)
> > >>
> > >> --
> > >> 2.19.1.6.gb485710b
> > >>
> > >>
> >
> >


