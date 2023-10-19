Return-Path: <netdev+bounces-42533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51E7CF34D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5735D281D38
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF315AEF;
	Thu, 19 Oct 2023 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqtpNseF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C716401
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:54:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F8AB
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697705670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEAJ+VDUrNVXU5xbHG/3Z3vLqN5pIVSHhZmt7Niw3wo=;
	b=NqtpNseF/ro67oDdwHxRPxrvti6lW2IjbvU708bshs34mJMSwCwyNsxtITXl6pZsztDbir
	stfhdd3ral3HkAQc6RDE8IO4LWHyV9z5Tt2bO+GOSV+F/A10qRgOZQaI5mkhG8xQRJGzBX
	V313ThuZdXz7h5TRrJzryxTWuaap6L4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-c1QuE9sPMF6Nuqt7n0flCg-1; Thu, 19 Oct 2023 04:54:29 -0400
X-MC-Unique: c1QuE9sPMF6Nuqt7n0flCg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53ec72af708so3315425a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705668; x=1698310468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEAJ+VDUrNVXU5xbHG/3Z3vLqN5pIVSHhZmt7Niw3wo=;
        b=BThwcURl5fdtOw5aAiYKNCRFlthsmyE0OZtL0C5dgrzz43Drok9a0IzMq0v4npyTzJ
         TePZ8kQ+YbIWE9mXipFyFudUgnLU6KJv8AY/dDMFoqoRa05kxFmPyTll2iA6vi7N5FUM
         6gEqB2CV+JpR9+3Kn+RFPBuDqoKQms/8piJMoiSsXUcKAJw0Y8XueFMtLm2IDMofOsaH
         hew9HmhXHG/otHElLW5lNcheb02tpB8AnVp5rlSvy+cdTJKM2KnsbQrx1ZWPHtPz0/v4
         a8EnZpu1vqSGyN3qGND5ANb5dXl5GATGdIuN+z2paGiF7BsLjGUIwJJgFq8Z3Gomq9bh
         idBg==
X-Gm-Message-State: AOJu0Yy7oOO66U64944CUNxBkAXAbTFUzWv3NRHq5NrPQUavi9ndBntd
	vqIaShsI6JKzw7oNzI/e7n3Zkrv/ejDh1dk1UmS5FRgoNn9O9zeIx7v/4iJbMg87k/n2ebsALp+
	YeAcHVpXIzvl6FhHztew7qqP4
X-Received: by 2002:a05:6402:3483:b0:53e:3fce:251 with SMTP id v3-20020a056402348300b0053e3fce0251mr1126826edc.0.1697705668234;
        Thu, 19 Oct 2023 01:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFACpGM/rzsBWnQw0oghgETBEoNMcsod/FUAw+yf7qyqXIbwEBgi5TL8hRsdtikCm2vUW/WVg==
X-Received: by 2002:a05:6402:3483:b0:53e:3fce:251 with SMTP id v3-20020a056402348300b0053e3fce0251mr1126810edc.0.1697705667920;
        Thu, 19 Oct 2023 01:54:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b0053e2a64b5f8sm4088664edi.14.2023.10.19.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:54:27 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:54:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mihai Petrisor <mihai.petrisor@uipath.com>, Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH] vsock: initialize the_virtio_vsock before using VQs
Message-ID: <a5lw3t5uaqoeeu5j3ertyoprgsyxxrsfqawyuqxjkkbsuxjywh@vh7povjz2s2c>
References: <20231018183247.1827-1-alexandru.matei@uipath.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231018183247.1827-1-alexandru.matei@uipath.com>

On Wed, Oct 18, 2023 at 09:32:47PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If 'the_virtio_vsock' is not initialized before,
>replies are silently dropped and do not reach the host.

Are replies really dropped or we just miss the notification?

Could the reverse now happen, i.e., the guest wants to send a connection 
request, finds the pointer assigned but can't use virtqueues because 
they haven't been initialized yet?

Perhaps to avoid your problem, we could just queue vsock->rx_work at the 
bottom of the probe to see if anything was queued in the meantime.

Nit: please use "vsock/virtio" to point out that this problem is of the 
virtio transport.

Thanks,
Stefano

>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
> net/vmw_vsock/virtio_transport.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..eae0867133f8 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -658,12 +658,13 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		vsock->seqpacket_allow = true;
>
> 	vdev->priv = vsock;
>+	rcu_assign_pointer(the_virtio_vsock, vsock);
>
> 	ret = virtio_vsock_vqs_init(vsock);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		rcu_assign_pointer(the_virtio_vsock, NULL);
> 		goto out;
>-
>-	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	}
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>-- 
>2.34.1
>
>


