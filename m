Return-Path: <netdev+bounces-42909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BB7D0974
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B51CB21512
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EDD51E;
	Fri, 20 Oct 2023 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TX75/Qy5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E2D2F9
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:23:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64561735
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697786630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ps48hhG6wzB4Y+L3PoxO3ps+/OQgTevPQsiK41ym/g=;
	b=TX75/Qy51C9q15LQPdZc5GIFR3rj6VVFvcwLfLYKwALGFdZj+aValLlF7Lv5twCrJFkrbs
	1SgjkAgJIBllJayFF60xkAlgoal9ZdGeZ0OJVABQk0K6kZ7kQUSIsDxiM/K6tAX8TRurfe
	Z4+F7892GBNz1TasFMpEUrrqdxWbZDs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-cTSkX-F7NSiZOUaNBInlKw-1; Fri, 20 Oct 2023 03:23:48 -0400
X-MC-Unique: cTSkX-F7NSiZOUaNBInlKw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b98d8f6bafso36858066b.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786627; x=1698391427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ps48hhG6wzB4Y+L3PoxO3ps+/OQgTevPQsiK41ym/g=;
        b=g3WychO/nzpMddMtsHFDC7Vwz3LeZLtXGlwi5pDiT3Ymb66I6ET05ayEUdoSTFV4B6
         VKOikAjl/wq1qANYjJQu3PpHEyg9wgpFBN1UJfmzXmFlfK82mD81UhXudEOowoCieRdJ
         5vrpv9iWTvRzvAZZ8YipnWhUEZTheHIcETYKxuw6ww4pAXPQjFphO7yun9sbBGavqxyn
         bbYwgyD+1iZzK05iUNJYsFQV5IL0wQLbPVvpOM4/XxjwqNvuh5GATldizRpvf0kF3oLL
         rm6LigEq8VrYaG3PgEuz4v1yV0ShR9xQBeQyeBX+koQZBB+exoL8pzQtF7xjy6XYr3fC
         Xdzg==
X-Gm-Message-State: AOJu0Yz1xZ0I8tRy4b+Hi8RhOAun8NsElZ4MUwQmf92cDx+jIPKu/tuU
	KpAzP6jKZ/eA8as53a7JXTRCvfAheVxhikMCpRxNguYQ6u1P/QXLyUvHf00am14Q6DlPEC0Zy1q
	jzhCtggiFCLczJyWH
X-Received: by 2002:a17:907:d9f:b0:9bd:d1e8:57f1 with SMTP id go31-20020a1709070d9f00b009bdd1e857f1mr730069ejc.50.1697786627590;
        Fri, 20 Oct 2023 00:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsH0nFxuej6eEPp+AcxKRS1ZQmvLl9sf1mVsowX0cImCTldmzH0B405XVBoNVXTKEyFrRrXA==
X-Received: by 2002:a17:907:d9f:b0:9bd:d1e8:57f1 with SMTP id go31-20020a1709070d9f00b009bdd1e857f1mr730049ejc.50.1697786627165;
        Fri, 20 Oct 2023 00:23:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906749b00b0097404f4a124sm935380ejl.2.2023.10.20.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:23:46 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:23:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mihai Petrisor <mihai.petrisor@uipath.com>, Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH] vsock: initialize the_virtio_vsock before using VQs
Message-ID: <uidej33c7o5gudvdvq2ggultubangijsuwyl53cmhd2jqrdxbg@2plf2qy4vyqy>
References: <20231018183247.1827-1-alexandru.matei@uipath.com>
 <a5lw3t5uaqoeeu5j3ertyoprgsyxxrsfqawyuqxjkkbsuxjywh@vh7povjz2s2c>
 <f0112021-c664-41ad-981c-08311286bb43@uipath.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f0112021-c664-41ad-981c-08311286bb43@uipath.com>

On Fri, Oct 20, 2023 at 12:12:04AM +0300, Alexandru Matei wrote:
>On 10/19/2023 11:54 AM, Stefano Garzarella wrote:
>> On Wed, Oct 18, 2023 at 09:32:47PM +0300, Alexandru Matei wrote:
>>> Once VQs are filled with empty buffers and we kick the host, it can send
>>> connection requests. If 'the_virtio_vsock' is not initialized before,
>>> replies are silently dropped and do not reach the host.
>>
>> Are replies really dropped or we just miss the notification?
>>
>> Could the reverse now happen, i.e., the guest wants to send a connection request, finds the pointer assigned but can't use virtqueues because they haven't been initialized yet?
>>
>> Perhaps to avoid your problem, we could just queue vsock->rx_work at the bottom of the probe to see if anything was queued in the meantime.
>>
>> Nit: please use "vsock/virtio" to point out that this problem is of the virtio transport.
>>
>> Thanks,
>> Stefano
>
>The replies are dropped , the scenario goes like this:
>
>  Once rx_run is set to true and rx queue is filled with empty buffers, the host sends a connection request.

Oh, I see now, I thought virtio_transport_rx_work() returned early if 
'the_virtio_vsock' was not set.

>  The request is processed in virtio_transport_recv_pkt(), and since there is no bound socket, it calls virtio_transport_reset_no_sock() which tries to send a reset packet.
>  In virtio_transport_send_pkt() it checks 'the_virtio_vsock' and because it is null it exits with -ENODEV, basically dropping the packet.
>
>I looked on your scenario and there is an issue from the moment we set the_virtio_vsock (in this patch) up until vsock->tx_run is set to TRUE.
>virtio_transport_send_pkt() will queue the packet, but virtio_transport_send_pkt_work() will exit because tx_run is FALSE. This could be fixed by moving rcu_assign_pointer() after tx_run is set to TRUE.
>virtio_transport_cancel_pkt() uses the rx virtqueue once the_virtio_vsock is set, so rcu_assign_pointer() should be moved after virtio_find_vqs() is called.
>
>I think the way to go is to split virtio_vsock_vqs_init() in two: 
>virtio_vsock_vqs_init() and virtio_vsock_vqs_fill(), as Vadim 
>suggested. This should fix all the cases:

Yep, LGTM!

Thank you both for the fix, please send a v2 with this approach!

Stefano

>
>---
> net/vmw_vsock/virtio_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index ad64f403536a..1f95f98ddd3f 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -594,6 +594,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)
>+{
> 	mutex_lock(&vsock->rx_lock);
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
>@@ -603,8 +608,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -707,6 +710,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -779,6 +783,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>


