Return-Path: <netdev+bounces-20725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D4760C75
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DD281655
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191C134A1;
	Tue, 25 Jul 2023 07:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7512B92
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:53:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC5BF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690271597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWQd09CkgUEL/rfURKCBaafhE1vCc8Dv/cUNXDFlRRE=;
	b=AGDQ9UZ0/NQAi4wR6OmtGEnHLtnhSs4kaAqvjrs0y+zxv8x9IrjDlKcsdV0NMpcp28SHk8
	uvAf21xx5R4JVOP0oBXLlJTylJvtb5mB1RqNRGQ8+AoeBABefDuN68tjI3GXZ8QNef1xsN
	agQGqp7Ie2M7HA+YJdFZDmUzMczhmwI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-41KBW0QVO-awLRrssva5dw-1; Tue, 25 Jul 2023 03:53:14 -0400
X-MC-Unique: 41KBW0QVO-awLRrssva5dw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51e0fc38f16so4119771a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690271593; x=1690876393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWQd09CkgUEL/rfURKCBaafhE1vCc8Dv/cUNXDFlRRE=;
        b=Caez7dl6YoanQ5EcXyZtXDz2gH9GHRbcOycsokCJN1MxUKWrY1fMaJH3Ryoe2gkAH/
         j9hgl+JeQLcwbt8GEvsbx4915NwFOWRBQTEK7xSbJjTqpkU95kIbn6ZUT1ZqGCnPar+P
         0IBpdmCAgmtLhQXR8Y/wTTsZe5Du31qeQtfzsKLSjr/TB5H9fLcTKoiicwkre8Ai8GvE
         NLT7GcVIv9GdvYLQxiJRVIhr3ES9ZGLsU1TOw5GKrShY3hG+zIl0+94gs2PJwumowkAz
         iHBeX/BzXQG9zroWO9xeSsZLyvDHjy/apS5x2DZTqkocENPPWSgkGQOZHPi1t/sNrXV6
         kNNA==
X-Gm-Message-State: ABy/qLZRhdr8y2RwDzAsTsU0YKSlyeUwIfnRagiLnld37Km8OVRYqASR
	EEbEzgVKDHTCICi/+I68BSAhxKg8YccBU7omnftpGXLz48jCBFN23h16iOm903xYd5dPZbIe1bL
	RR6nQYrs8Ob1gyGwx
X-Received: by 2002:a05:6402:b11:b0:51d:e2c4:f94a with SMTP id bm17-20020a0564020b1100b0051de2c4f94amr10599773edb.20.1690271593633;
        Tue, 25 Jul 2023 00:53:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMsygKA53ZagpKmLPph+kYwIqwDrCuyagGjgnUA/UfkItMnc3GeQVj+FzWHvPMnAT7Zuyh3w==
X-Received: by 2002:a05:6402:b11:b0:51d:e2c4:f94a with SMTP id bm17-20020a0564020b1100b0051de2c4f94amr10599757edb.20.1690271593305;
        Tue, 25 Jul 2023 00:53:13 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id g1-20020aa7c841000000b0051e576dbb57sm7165932edt.61.2023.07.25.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:53:12 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:53:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
Message-ID: <20230725035120-mutt-send-email-mst@kernel.org>
References: <20230725072049.617289-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725072049.617289-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 03:20:49AM -0400, Jason Wang wrote:
> A race were found where set_channels could be called after registering
> but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> moving the virtnet_set_queues() before netdevice registering. While at
> it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> not even registered at that time.
> 
> Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

stable material I guess?

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0db14f6b87d3..1270c8d23463 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
> -- 
> 2.39.3


