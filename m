Return-Path: <netdev+bounces-43489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17097D3950
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D94B20C12
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD106ABB;
	Mon, 23 Oct 2023 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQ350QqD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1D1B295
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:30:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A35810C
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698071400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kySDKR+e82Dq0GbnFVXWHHRylAyqPYM5YM7Pq4ou10o=;
	b=TQ350QqDX+coMVClVIpte16tmfDmNe3TEG6sg+lLyon4NIvhdr+jfmqT3HyfL3y8GMik9E
	yGspopHvabolJTj/WHvL3T2lxZJTcMyqOi788SdJfJoCWQW5nfvvBxNbjsrIGzsurX1vMr
	QOPEcqRoSBiDDZR1mXztxqH1YINl1eY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-3fp2GcwMOJ6X7tkLc_8I_w-1; Mon, 23 Oct 2023 10:29:58 -0400
X-MC-Unique: 3fp2GcwMOJ6X7tkLc_8I_w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-778a455f975so450376385a.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071397; x=1698676197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kySDKR+e82Dq0GbnFVXWHHRylAyqPYM5YM7Pq4ou10o=;
        b=GpUfsb3dzBrcQd8YdxQLqCARtbuBGj1LhPDhfFVSb7ltCgqn7OpjZo6I2FVVE4A8qk
         zqu3nVBZueYJGZlmLyc5e2/N/C5IB+9FJ6lO9VH8CXbfas0yVEOoTVt9kxU0tHyKoIc0
         MICFKd9kP661iN/i5SmaYJOLgZWjgXdFdtsvkn41QySSDcLHnvr8c/q7OB7VoLLtNZf4
         /voX3Nwtqn6/SOJOs93xoWWelcM9xJtj02yMFbqpt0glsN81nasZDwhqVMj9kIXla/2Y
         NozXjcCvD/5VL6G3iCYHlr4RGYPX5HkFf60e3CYczQa4ovAOI+oLe8YDQZaQE5XD5FpZ
         elSw==
X-Gm-Message-State: AOJu0Yxj4wQLA7cJrCusX8Z9CWc7Dax3rT7sLuaKOJ2BBVDsubNJWG+P
	12xTkvdFtgQTvFm9M0sNDrDp0HS6MmfKoD27KkBDrC6S32MEy08GS4FMtmKTVTIj8uhO4Rh3+Sd
	H8OasqzCTSZBIdAOAV20JWW5i
X-Received: by 2002:a05:620a:c4c:b0:778:b0f5:d4e7 with SMTP id u12-20020a05620a0c4c00b00778b0f5d4e7mr8747574qki.46.1698071397509;
        Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoIEdB7iELDRun3hsVSPuymnAKtgjwualgCraxWcYPHJJfqhEETtyAiBCcLGcgIIkq3BUmLg==
X-Received: by 2002:a05:620a:c4c:b0:778:b0f5:d4e7 with SMTP id u12-20020a05620a0c4c00b00778b0f5d4e7mr8747549qki.46.1698071397203;
        Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id k22-20020a05620a143600b00774350813ccsm2736609qkj.118.2023.10.23.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:29:56 -0700 (PDT)
Date: Mon, 23 Oct 2023 16:29:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mihai Petrisor <mihai.petrisor@uipath.com>, Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231023140833.11206-1-alexandru.matei@uipath.com>

On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host,
>it can send connection requests.  If 'the_virtio_vsock' is not
>initialized before, replies are silently dropped and do not reach the host.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..92738d1697c1 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)

What about renaming this function in virtio_vsock_vqs_start() and move 
also the setting of `tx_run` here?

Thanks,
Stefano

>+{
> 	mutex_lock(&vsock->rx_lock);
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
>@@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>2.34.1
>


