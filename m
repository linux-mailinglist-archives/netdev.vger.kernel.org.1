Return-Path: <netdev+bounces-25690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11680775303
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425B61C210E3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A57F3;
	Wed,  9 Aug 2023 06:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D662C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:40:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1091986
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691563227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJJ3jCTu6LtoeROu3S/wj01MIog+Ejx9gJ/wdAIt/q8=;
	b=i0mTPqgmUhK4wBdB7qbhgd3p205Vdi7Ew7S2sBbXw9ErWLCgS+h2kkCk3De9rsQpunSbMj
	Xzl9krO3Ucl3tZEff0M5kNaYoq4uGlkqr0p9TQ/XTJ7rp4e6Kb0ms5AkOvq5mjgNxBy2Pw
	BfOLv6dCbjW0L494VsBcezFqMSUXtds=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-6pbdqsXOPzqJIU6bMBEfgw-1; Wed, 09 Aug 2023 02:40:25 -0400
X-MC-Unique: 6pbdqsXOPzqJIU6bMBEfgw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993c2d9e496so436259566b.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563224; x=1692168024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJJ3jCTu6LtoeROu3S/wj01MIog+Ejx9gJ/wdAIt/q8=;
        b=hYyeUPWQDwQbJrEX348BFwM0QfIaSIn5WmGw/TP0DLkLruzHo1VoGMzD2h+X/1yBXO
         TvhKbLF5hm77o/TVo45CtW30GPJgWAXdApm6O4t+BSAodnzzHN85gTnCMlNY0VCIFNSr
         mkCSCaJtrQTtWPUfeAnl23v19TA+tlBS2HSKdCRFsxsmXOPXTREcnz0l7I2hBDjey3cx
         qfV+S0kxKsDQleyZSzucDPu/clYkNDV2sk+5NP+/HC8wxO0byoBh4URyQ3cPNjtmpopn
         saDQSfKs0QbNp465V6vGSuIM5KmaRVkd8lbcTTyIn9F+OU6SMBGa9qI8MzpNJyNaAv2g
         h3hQ==
X-Gm-Message-State: AOJu0YyhZUcaSDLSQ4UugBCGQ8crZ3CZIG7OxTXnDsq9j06ugGUPLIOD
	5P2lPxA4tXT4tyg0RqpZM4klFS7PZ2bRatU0KYiTo5yNYAR0/lK5Wiv8WXOQkfjh2Gm1mtvnDW/
	1eBTn0wmjTZWGztZL
X-Received: by 2002:a17:907:a073:b0:99b:5e5f:1667 with SMTP id ia19-20020a170907a07300b0099b5e5f1667mr1495506ejc.15.1691563224621;
        Tue, 08 Aug 2023 23:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg8T51M5Yw9NGLLwVCRBOtdjLe2xwQK0NK5aYDOQNXcPWOdFN2HnOZIeRflZV1n7ejsAacOA==
X-Received: by 2002:a17:907:a073:b0:99b:5e5f:1667 with SMTP id ia19-20020a170907a07300b0099b5e5f1667mr1495493ejc.15.1691563224263;
        Tue, 08 Aug 2023 23:40:24 -0700 (PDT)
Received: from redhat.com ([2.52.159.103])
        by smtp.gmail.com with ESMTPSA id re8-20020a170906d8c800b00992076f4a01sm7594060ejb.190.2023.08.08.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:40:23 -0700 (PDT)
Date: Wed, 9 Aug 2023 02:40:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
Message-ID: <20230809024013-mutt-send-email-mst@kernel.org>
References: <20230809031329.251362-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809031329.251362-1-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 11:13:29PM -0400, Jason Wang wrote:
> Commit 25266128fe16 ("virtio-net: fix race between set queues and
> probe") tries to fix the race between set queues and probe by calling
> _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> spec. Fixing this by setting queues after virtio_device_ready().
> 
> Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe")
> Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> The patch is needed for -stable.
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..ff03921e46df 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> -	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>  	/* a random MAC address has been assigned, notify the device.
>  	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
>  	 * because many devices work fine without getting MAC explicitly
> -- 
> 2.39.3


