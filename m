Return-Path: <netdev+bounces-26546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60837780F1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF971C20D6B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63F22EF9;
	Thu, 10 Aug 2023 19:02:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8D1F95D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:02:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12F2713
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691694172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwKZd9kJdARYjGG+RNfCj3MbPwhouNi+dlJfp58+jtI=;
	b=esB5CoWpHAWgvtP+4prvps4Nl/uTpeiKf6IhHrGHZmy4U7j+rLZNFKL7bzlRxWZ8uRBpiX
	4ahjxWONK56RHJ1x8TbshpYcgISYJf398Dcx9CygH5Jd8mp9M97YXEgQQnHH2CgdlHred1
	cO7tphe+9n/I+lEeFwiGU0uVRAuKGFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-wQ9TSfZIP8i9L9gcwySyXA-1; Thu, 10 Aug 2023 15:02:51 -0400
X-MC-Unique: wQ9TSfZIP8i9L9gcwySyXA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe216798e9so8196855e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 12:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694170; x=1692298970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwKZd9kJdARYjGG+RNfCj3MbPwhouNi+dlJfp58+jtI=;
        b=idXdpNQ3mezASfvZYwmPgglPIuaXAwvmTm679w6no03FGnCNcrmQYU0cJboH55YI3I
         BUDeCRx/kcm7VYgU5j+K/0rrAinb3w3Q+42nKOtWbqiRMbmXi73POm6AQUAHcQfZGhwt
         fQ5dM0jEElAanIFyJPNqTwQYnk0cVlUo+k2+MMKUK1wjvmR+f5DoAWnmVXAR1Zvo6Br0
         xGW4qEp3UqfGQTvBQHvgO4FyS9zw1hdPkI1msHCxPcaXPyTJntVpjVzI7RrKr6nD6t+S
         FolG9j/XA9folOJ2axqfzhPmPDcFcQ2OvXqLD6znCvTAHwBT1RCeWxmy7tXbpNSq6GVK
         1q4Q==
X-Gm-Message-State: AOJu0YxJjYHGwNE/VduoTg7/KHDukk4D1tSUhHWvf4rWKJ9fOxHdFO/9
	oHSJm59zK7WeT/fFEi8rnYcyyuaAsmirWrBxfKNIpT64I+KGPMSLRO7CmOdR/BDfx90fNuBqZLU
	TiX7FXK+ekIKFmLkr
X-Received: by 2002:a1c:7314:0:b0:3fa:973e:2995 with SMTP id d20-20020a1c7314000000b003fa973e2995mr2547793wmb.12.1691694169961;
        Thu, 10 Aug 2023 12:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZ6F49Kczr81tfxKe4/wLYJAobKnso77Sg3Wp4JvIX7WMl/+GBlExXHBVr9v5j92CbJJyyw==
X-Received: by 2002:a1c:7314:0:b0:3fa:973e:2995 with SMTP id d20-20020a1c7314000000b003fa973e2995mr2547777wmb.12.1691694169592;
        Thu, 10 Aug 2023 12:02:49 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a05600c364100b003fbb06af219sm2911778wmq.32.2023.08.10.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:02:48 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:02:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: xieyongji@bytedance.com, jasowang@redhat.com, david.marchand@redhat.com,
	lulu@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230810145938-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
> 
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> 
> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)

So I can put this in next, the issue I think is
that of security: currently selinux can if necessary block
access to creating virtio block devices.
But if we have more than one type we need a way for selinux to
block specific types. Can be a patch on top but pls work to
address.

Another question is that with this userspace can inject
packets directly into net stack. Should we check CAP_NET_ADMIN
or such?


> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0


