Return-Path: <netdev+bounces-31447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA4478DEC0
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 22:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21421C203B4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824BE79D2;
	Wed, 30 Aug 2023 20:04:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AE749D
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 20:04:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1D22EBB
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693425781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
	b=GIuIwfpWVtTGz78C9yHAFve5/kpZJmQ4PduysdJIf2P/805gNYYrLkxJLXf4aPudMry7Gp
	S5+d88wICuTWu6mPPoUHvg1WKGX0W6bSwn60M4A/v/JfUIR8bhqbHbtsjjKT2oLdSaH7gs
	/p57M/NQFnS6qsWXE/iUkOHH0+hem9E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-biN2LO7TMuSKR7ElYgrWRg-1; Wed, 30 Aug 2023 15:48:40 -0400
X-MC-Unique: biN2LO7TMuSKR7ElYgrWRg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a348facbbso400366b.1
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 12:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424919; x=1694029719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
        b=dyBNOgCxmG1Ga55X594WcfYnGNxWH8kFHioehDpCHiE/KNensdrDWbSpAxrsBXowFM
         q6THvf90WQcoHcXGiDP65B9CQYphMJW8GOJst5p1wahSN1BAFjN8h/Yc9pZAmR7xtuUp
         IaXzAaf/sg1D22Jzi9pLs0za3+BhDJtHtWIA68HwtFUXD9RjJRV8cjFt3bDN/ltCJkgX
         ec3gJSVpk1Vaglvp9Mq+4JQv/UfrECWwjuhI9fiRuXCu+3V+/51Xt21AqdXZxvAP71jd
         znfZZCyOM2nAWDxE5MQetIAmW0s4V6cJvnOugwlHaXYAw/WW2yf+teFC2yLCCAy95o8H
         qDWw==
X-Gm-Message-State: AOJu0YznIoNhkyGHiT3nsAgHrr8KeTOHrinlDuV3STl7mjK5PYEsIZms
	S8uUBkH9rVrS2ZwYTH07Vov38WrFk7wC7qZUJ8YDxhkjtWwdqLuK3S05EHftEF92JY2CyCa1gk2
	0BHEEBwQoLL2Ulksh
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id 13-20020a170906018d00b009a216a70fd0mr2423122ejb.21.1693424537375;
        Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPl2d8yog5OYYxnVfR719SFpTMzeSHrPCryTF2nxMjc68c11HQgd4yjH64I6CkiNALUEQ33w==
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id 13-20020a170906018d00b009a216a70fd0mr2423093ejb.21.1693424537027;
        Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
Received: from redhat.com ([2.55.167.22])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709064e0300b009a19fa8d2e9sm7490757eju.206.2023.08.30.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:42:16 -0700 (PDT)
Date: Wed, 30 Aug 2023 15:42:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	jiri@nvidia.com, dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230830154200-mutt-send-email-mst@kernel.org>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230713074001-mutt-send-email-mst@kernel.org>
 <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 10:10:51AM +0800, Xuan Zhuo wrote:
> On Thu, 13 Jul 2023 07:40:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> > > Currently, coalescing parameters are grouped for all transmit and receive
> > > virtqueues. This patch series add support to set or get the parameters for
> > > a specified virtqueue.
> > >
> > > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > > is busy and another virtqueue is idle, then it will be very useful to
> > > control coalescing parameters at the virtqueue granularity.
> >
> > series:
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Why?
> 
> This series has the bug I reported.
> 
> Are you thinking that is ok? Or this is not a bug?
> 
> Thanks.
> 
> 


I missed that mail. What's the bug?

> >
> >
> >
> > > Example command:
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> > > Would set max_packets=10 to VQ 1.
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> > > Would set max_packets=10 to VQ 0.
> > > $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> > >  Queue: 0
> > >  Adaptive RX: off  TX: off
> > >  stats-block-usecs: 0
> > >  sample-interval: 0
> > >  pkt-rate-low: 0
> > >  pkt-rate-high: 0
> > >
> > >  rx-usecs: 222
> > >  rx-frames: 0
> > >  rx-usecs-irq: 0
> > >  rx-frames-irq: 256
> > >
> > >  tx-usecs: 222
> > >  tx-frames: 0
> > >  tx-usecs-irq: 0
> > >  tx-frames-irq: 256
> > >
> > >  rx-usecs-low: 0
> > >  rx-frame-low: 0
> > >  tx-usecs-low: 0
> > >  tx-frame-low: 0
> > >
> > >  rx-usecs-high: 0
> > >  rx-frame-high: 0
> > >  tx-usecs-high: 0
> > >  tx-frame-high: 0
> > >
> > > In this patch series:
> > > Patch-1: Extract interrupt coalescing settings to a structure.
> > > Patch-2: Extract get/set interrupt coalesce to a function.
> > > Patch-3: Support per queue interrupt coalesce command.
> > > Patch-4: Enable per queue interrupt coalesce feature.
> > >
> > > Gavin Li (4):
> > >   virtio_net: extract interrupt coalescing settings to a structure
> > >   virtio_net: extract get/set interrupt coalesce to a function
> > >   virtio_net: support per queue interrupt coalesce command
> > >   virtio_net: enable per queue interrupt coalesce feature
> > >
> > >  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> > >  include/uapi/linux/virtio_net.h |  14 +++
> > >  2 files changed, 154 insertions(+), 29 deletions(-)
> > >
> > > --
> > > 2.39.1
> >


