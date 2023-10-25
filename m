Return-Path: <netdev+bounces-44088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664B7D614E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B57281BFF
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCE11721;
	Wed, 25 Oct 2023 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRg6HQCi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACDD522
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:49:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831DD12A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698212991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmdyaZ9qXbYT3M7CCj4FId0OwQhVUrEnLkY5RdWbyec=;
	b=CRg6HQCibJX+092jcd7We3wd6c9HR1taiWXMMWVI9SoNR4eRWIKbnkJ+l5upioIvh2k3HU
	HEmS6ZM2qwNPv6B4Vf4Em+DeW0ISikdjlOqpXlaccKQHPLyyBSxhizItqpG9VJQO3131lA
	vGwqAyVXsPxBfh1PF2Mbh7hopxKsuEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-B5IBXkpSNUmxuQYCyZLbHQ-1; Wed, 25 Oct 2023 01:49:49 -0400
X-MC-Unique: B5IBXkpSNUmxuQYCyZLbHQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084d08235fso34446945e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698212988; x=1698817788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmdyaZ9qXbYT3M7CCj4FId0OwQhVUrEnLkY5RdWbyec=;
        b=aGWUGGsSyRSv46zYKLUVGR7AgZZf9pWIj7URasUyfRk95aBzU+K9NF+BHgAL9/JTzN
         cnEN2Toqln9A7qTXLLHatKwwlujnKC0kdLMYpBcr67AqVhzjx0rWNr8YWA0w/3upAzEF
         EalZ+ftdbq3vM+0wO3gigEGWrnfJJ/SG7n3Lg4UIav9oXdFDWWbN6tTeHnQPfowJVLwL
         YKvnHGdsBqN+Zw119gpg4dEZP3IOfg5Okh/K5N9f/agfbW9nAX/11nMHfneOdH/krC2r
         5LW20sNNURwyCMX6X9kmPloi9xLCNA7gYlANFlZ/jorwr118Jhmt2epkVzYC4jdPaxRK
         rarw==
X-Gm-Message-State: AOJu0YylPEtC0FBSiclaFveS2qf0KO02ITyd9BpH9OM04NpEo66AYIF4
	I+NTIkQg4s/Jy4oLBil6SxdbGyESPxXR1KtQuGPha0SXpvB10C58eJuDVkrWGUwj48i2pdVFBnt
	tmuMmSXxEFfUfPWW/
X-Received: by 2002:a05:600c:468c:b0:408:3ea0:3026 with SMTP id p12-20020a05600c468c00b004083ea03026mr10594933wmo.11.1698212988464;
        Tue, 24 Oct 2023 22:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErtELIfss3EdE6wkMvrrbrNfMHdzx0+gPrTXpCzna2cPiuLf5sUwd9EudZdDacqgHXNu1zHw==
X-Received: by 2002:a05:600c:468c:b0:408:3ea0:3026 with SMTP id p12-20020a05600c468c00b004083ea03026mr10594920wmo.11.1698212988006;
        Tue, 24 Oct 2023 22:49:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600010c400b0032da471c0c1sm11303905wrx.7.2023.10.24.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:49:47 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:49:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
Message-ID: <20231025014821-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697093455.git.hengqi@linux.alibaba.com>

On Thu, Oct 12, 2023 at 03:44:04PM +0800, Heng Qi wrote:
> Now, virtio-net already supports per-queue moderation parameter
> setting. Based on this, we use the netdim library of linux to support
> dynamic coalescing moderation for virtio-net.
> 
> Due to hardware scheduling issues, we only tested rx dim.

So patches 1 to 4 look ok but patch 5 is untested - we should
probably wait until it's tested properly.


> @Test env
> rxq0 has affinity to cpu0.
> 
> @Test cmd
> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> server: taskset -c 0 sockperf sr --tcp
> 
> @Test res
> The second column is the ratio of the result returned by client
> when rx dim is enabled to the result returned by client when
> rx dim is disabled.
> 	--------------------------------------
> 	| msg_size |  rx_dim=on / rx_dim=off |
> 	--------------------------------------
> 	|   14B    |         + 3%            |   
> 	--------------------------------------
> 	|   100B   |         + 16%           |
> 	--------------------------------------
> 	|   500B   |         + 25%           |
> 	--------------------------------------
> 	|   1400B  |         + 28%           |
> 	--------------------------------------
> 	|   2048B  |         + 22%           |
> 	--------------------------------------
> 	|   4096B  |         + 5%            |
> 	--------------------------------------
> 
> ---
> This patch set was part of the previous netdim patch set[1].
> [1] was split into a merged bugfix set[2] and the current set.
> The previous relevant commentators have been Cced.
> 
> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/
> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba.com/
> 
> Heng Qi (5):
>   virtio-net: returns whether napi is complete
>   virtio-net: separate rx/tx coalescing moderation cmds
>   virtio-net: extract virtqueue coalescig cmd for reuse
>   virtio-net: support rx netdim
>   virtio-net: support tx netdim
> 
>  drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 322 insertions(+), 72 deletions(-)
> 
> -- 
> 2.19.1.6.gb485710b


