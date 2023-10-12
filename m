Return-Path: <netdev+bounces-40297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE597C6910
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56322282840
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEFA1F19A;
	Thu, 12 Oct 2023 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOKB/WnD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39624210E0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:11:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EAB7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697101866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2ul78a+hZKKQoapj3GAU9FVBpVNy3dwXsHSe4SyE4s=;
	b=eOKB/WnDObyE3Os5ZyxHXEy6DprcZ9XF+Ibx842TjauMEwDmshhipLDTvTgeTICfp9HW0F
	5q0Y5pl4X9GXQScpldxLoto78cHsZiabJbTzZ2d9LL2gl03Eqv9UcGm3dkovLamYnC3HUA
	unIf2i6M2dsAvV/SPiMZycM349CRWpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-3t45BuuVMsyh8CEDLC7vdw-1; Thu, 12 Oct 2023 05:11:00 -0400
X-MC-Unique: 3t45BuuVMsyh8CEDLC7vdw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4059475c174so6283865e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101859; x=1697706659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ul78a+hZKKQoapj3GAU9FVBpVNy3dwXsHSe4SyE4s=;
        b=uVxhyMOCJBtqS1NIlhulQe0P6GClBL061lln9+5bsAhcWbaPVLqKtzZnruOQCdjhgk
         +SdvZpPtFJxSTNrQnEWbmAyup4BzZOn0W3yut/QMRyGP8wbfSZ5MHmSbaO6eJUYUbl3A
         7FvnxE0e3HMC7muF7WT7cgMXbnZD58LWy85xqDSE8ccSe81jhA+uIOMlp8QwgudYlysl
         HK92D++UMQCWlI2oi2DMrJGOgrFC225pZ68n+56cSaAuJD5UfMCsdmIPDd9nkhOXCFua
         gUx+zHxSA2h+JtnJJThgiT0CXujWuzqR7rjiCmp2EJKf4vml66/GLIR+T+0VykaNtc5l
         ULRA==
X-Gm-Message-State: AOJu0YwHpPwUOChrusIgiaubnrEo2NfdoqbIeKimh6ksbIh0Zm2B5I6Q
	i713XOJ+65M2QoeBFT54cX4/HEd1NmOAjsLvqhn5BGdRSjsQ8sUFAY8X9K98wFnCdn1r1e0uJWE
	0b6PFly78tQz1qJNB
X-Received: by 2002:a05:600c:21d5:b0:402:ee71:29 with SMTP id x21-20020a05600c21d500b00402ee710029mr21887106wmj.10.1697101859466;
        Thu, 12 Oct 2023 02:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuGS+ZPrNCjZO/nefYmxLR7WYca/gn0IK+gNcR2C/7QxR8YxUcJKE4ATwpT+VU575s2Y1WmA==
X-Received: by 2002:a05:600c:21d5:b0:402:ee71:29 with SMTP id x21-20020a05600c21d500b00402ee710029mr21887081wmj.10.1697101859026;
        Thu, 12 Oct 2023 02:10:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003fbe791a0e8sm19097092wml.0.2023.10.12.02.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:10:58 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:10:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012050936-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> If send queue sent some packets, we update the tx timeout
> record to prevent the tx timeout.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/xsk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 7abd46bb0e3d..e605f860edb6 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  
>  	virtnet_xsk_check_queue(sq);
>  
> +	if (stats.packets) {
> +		struct netdev_queue *txq;
> +		struct virtnet_info *vi;
> +
> +		vi = sq->vq->vdev->priv;
> +
> +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> +		txq_trans_cond_update(txq);
> +	}
> +
>  	u64_stats_update_begin(&sq->stats.syncp);
>  	sq->stats.packets += stats.packets;
>  	sq->stats.bytes += stats.bytes;

I don't get what this is doing. Is there some kind of race here you
are trying to address? And what introduced the race?

> -- 
> 2.32.0.3.g01195cf9f


