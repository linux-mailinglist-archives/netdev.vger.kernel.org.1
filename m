Return-Path: <netdev+bounces-43749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681DF7D4864
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D501C20976
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE681426F;
	Tue, 24 Oct 2023 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOP7ZdKY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98A5223
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:22:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C952118
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698132167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rv0SpeFLc8EPDyVFSHvu8ODjo19NeLRxyGY2cziN3BQ=;
	b=VOP7ZdKYocMvqXbyEYvH1Nf9SwC/Vd2Yc/ssNQg3zzlvlWq2AMrXtLlT5W9NrRX7tBBoeD
	CG5xiqao0XPgey+cunthgbfJrpb8DKV5FiK30myG1I0rWVnYnFRA8YZE48pXEMyBKJpJyM
	uN8QOPByg5pdOIijLhzzJz+/o2OFCSQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-qCOdiXaeOw-kvDavWc-eew-1; Tue, 24 Oct 2023 03:22:45 -0400
X-MC-Unique: qCOdiXaeOw-kvDavWc-eew-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457d220d76fso1951695137.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132165; x=1698736965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv0SpeFLc8EPDyVFSHvu8ODjo19NeLRxyGY2cziN3BQ=;
        b=MtCMHT1IcyYIOm8TfJawPQcf+C6R0S2s5JrTG8W87ciVQ26HXpuUrd7tM7qjTD27Qf
         LZfLh5cSzs+w/Zwmye/1IToyHKup/RJ5Jt8fRBnKr0gWGK3whZQ9Y+1by49hJgeK26Sv
         ALc52rWplzE6NOiMr101tYeytbCGSsmPiRVr8vIjsK2cths84yPn4Jqvofxw3Fd+sxIJ
         40UxB2ZLj9H8v08+3mVCVC0rxfI4SQ3dUjoiUTebZzgA7zOuTnEzaU42tDMDbjGFwSPj
         gxZFXYLP6JJl3z+BcPHmrbIofoGerl+U9ERjTunfidJlp4iDRVSKuaIey316y3H5Vhhc
         rq8w==
X-Gm-Message-State: AOJu0Yy0gXYII1MeSdXJa+1aeb5Zi5e/EztRK1z7rFsjojNq/L8n79s6
	xDASWe+4ODfTwF1VZzlF6OvGu/i0UIKJ++5jwLx0drxaEdcAGBZc/Lql7ZhjAuwM7wQ4caH9ctz
	1GJtJt45fz3OwzkkXE1TeE86y
X-Received: by 2002:a05:6102:2092:b0:450:8e58:2de4 with SMTP id h18-20020a056102209200b004508e582de4mr9896269vsr.7.1698132165225;
        Tue, 24 Oct 2023 00:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSc1UnFRYGpNLAyeRqiE0mbWYzJbU92m3CE1awsD070guqv6X6NuBMOiyw9bpdIyW4han0dA==
X-Received: by 2002:a05:6102:2092:b0:450:8e58:2de4 with SMTP id h18-20020a056102209200b004508e582de4mr9896248vsr.7.1698132164898;
        Tue, 24 Oct 2023 00:22:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id g24-20020a37e218000000b007671b599cf5sm3263591qki.40.2023.10.24.00.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:22:44 -0700 (PDT)
Date: Tue, 24 Oct 2023 09:22:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mihai Petrisor <mihai.petrisor@uipath.com>, Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH v3] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <iqjmblf2n42w7afw42udxvju3znupmwrixfsbwcn247u7bayoc@zrbken7ls6m7>
References: <20231023192207.1804-1-alexandru.matei@uipath.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231023192207.1804-1-alexandru.matei@uipath.com>

On Mon, Oct 23, 2023 at 10:22:07PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If the_virtio_vsock is not initialized before,
>replies are silently dropped and do not reach the host.
>
>virtio_transport_send_pkt() can queue packets once the_virtio_vsock is
>set, but they won't be processed until vsock->tx_run is set to true. We
>queue vsock->send_pkt_work when initialization finishes to send those
>packets queued earlier.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v3:
>- renamed vqs_fill to vqs_start and moved tx_run initialization to it
>- queued send_pkt_work at the end of initialization to send packets queued earlier
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..c0333f9a8002 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -555,6 +555,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>
> 	virtio_device_ready(vdev);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
>+{
> 	mutex_lock(&vsock->tx_lock);
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>@@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -664,6 +667,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_start(vsock);
>+
>+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);

I would move this call in virtio_vsock_vqs_start() adding also a comment 
on top, bringing back what you wrote in the commit. Something like this:

         /* virtio_transport_send_pkt() can queue packets once
          * the_virtio_vsock is set, but they won't be processed until
          * vsock->tx_run is set to true. We queue vsock->send_pkt_work
          * when initialization finishes to send those packets queued
          * earlier.
          */

Just as a consideration, we don't need to queue the other workers (rx, 
event) because as long as we don't fill the queues with empty buffers, 
the host can't send us any notification. (We could add it in the comment 
if you want).

The rest LGTM!

Thanks,
Stefano

>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -736,6 +742,9 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_start(vsock);
>+
>+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>2.25.1
>


