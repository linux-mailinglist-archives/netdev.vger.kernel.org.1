Return-Path: <netdev+bounces-29246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B87824F2
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05639280EC9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CE21C32;
	Mon, 21 Aug 2023 07:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F61848
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:55:04 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CFCB1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 00:55:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bee82fad0fso17038055ad.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692604502; x=1693209302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxU+EyqkkEcnemfr3bCpvA3lQfG1XU+OjBC6Fi8m8Ec=;
        b=lr4LGv5pq6xpRKLKjltisnMe6JAeSZaONGAeCvgRFRVuSQMLiHtaX8iVuwIfbwLrfg
         Pmk6y76zFhnobcINF6RKWqoWHdjcc7uF4p6jjK9DKBOE0nag+5MI9+kNFQyK9qIyQJZe
         c/X/qQ9uCPYA7Lfb/HCEKOe9J9k7Z61L3QA1gAY+kDJDRaqk//hMpA4yMtVYDoicJXEJ
         Q0j63BJlkIH+9oq8IEiRoFgKxExjktKUMsAwY18nhyWbwSq1JlD+vVt+MZadQ6SV00r2
         BQ4gnZPO+gwGopftxaHfzIfAzurSynI4p2SclCZy14Kc4EhCYc1HNZfOVAHug8opQCvR
         Bj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604502; x=1693209302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxU+EyqkkEcnemfr3bCpvA3lQfG1XU+OjBC6Fi8m8Ec=;
        b=TYEP+8D1PoaBZANKdXuUM/UQLE23MukhztoERslqD2bIMw7tA7g0KnAiznqAuN0eyz
         fzvPOIVGPKvLAy/eqqSHbA3XTc01HwfW7oc9cam01B5cKJr5Y9ZC51WlGDWsuKf9INl1
         auyXhpLcDFvQY2HBRYLVHHMbbpdzACeIqTlzVOxX0DnP7OegiJPQhntbwCEcTQ5d3Dpa
         pMNG4FhP9cYlfH+y1hvu1fF/l8OSw73R0OY6oViCKmB46381hLdvLLJdI9Qy6jXXE0LQ
         /JlTJLQvThM8k5poDVov/vzlocWP/ocfLaR5RXoB0Gtdp8xwiap/AChwzXsDui0eaS88
         84PA==
X-Gm-Message-State: AOJu0YycM6mxZRTS/lmi9ipWuRWbWToKElXSus0a0fSIfFODj9fAzemY
	/vPol1oVnI29EcRhbIIzLg0=
X-Google-Smtp-Source: AGHT+IHqKJIY80ZEZvac4WYxJkk1R5lDQ4xnmaDsAhR7Vk50qjSG4wR2iw1DrJK+t6lC5kXFNPCtww==
X-Received: by 2002:a17:902:6807:b0:1b8:94e9:e7b0 with SMTP id h7-20020a170902680700b001b894e9e7b0mr3494961plk.9.1692604502177;
        Mon, 21 Aug 2023 00:55:02 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001bba7aab826sm6348838plx.163.2023.08.21.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:55:01 -0700 (PDT)
Message-ID: <df77249e-3ac1-e933-fdfb-464f37a19df6@gmail.com>
Date: Mon, 21 Aug 2023 15:54:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net V2] virtio-net: set queues after driver_ok
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>,
 "Michael S.Tsirkin, Red Hat" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, xuanzhuo@linux.alibaba.com
References: <20230810031256.813284-1-jasowang@redhat.com>
From: Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <20230810031256.813284-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/8/2023 11:12 am, Jason Wang wrote:
> Commit 25266128fe16 ("virtio-net: fix race between set queues and
> probe") tries to fix the race between set queues and probe by calling
> _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> spec. Fixing this by setting queues after virtio_device_ready().
> 
> Note that rtnl needs to be held for userspace requests to change the
> number of queues. So we are serialized in this way.
> 
> Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe")
> Reported-by: Dragos Tatulea <dtatulea@nvidia.com>

I had the same issue to report and this fix helped me out.
Tested-by: Like Xu <likexu@tencent.com>

> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> The patch is needed for -stable.
> Changes since V1: Tweak the commit log.
> ---
>   drivers/net/virtio_net.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..ff03921e46df 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	if (vi->has_rss || vi->has_rss_hash_report)
>   		virtnet_init_default_rss(vi);
>   
> -	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>   	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>   	rtnl_lock();
>   
> @@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>   
>   	virtio_device_ready(vdev);
>   
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>   	/* a random MAC address has been assigned, notify the device.
>   	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
>   	 * because many devices work fine without getting MAC explicitly

