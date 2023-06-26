Return-Path: <netdev+bounces-13994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B5E73E452
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64A51C2040F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6432DF65;
	Mon, 26 Jun 2023 16:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE6D519
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:11:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D5198A
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687795886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YymWdEkHWhyai/v4Ncfq5HtLNdYJQriBatYjnpRoPBU=;
	b=iHicUcEUXYRSDAybivWEW8swzSjQqaiDV2zouBByH6HQhmF2+G8jZGa7+GqeQtqpxA4yXf
	idnAeKSBEVGW3hDv52jwzSjTyA7lpXx8ZOdevk1LSFjA45VznhNlDucYizMCkJ5qRu/aH3
	SMEKaxXsfFh4JyZKMagSrJctu7tr71E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-M0zf4rIkP6GUCC9yNFacpQ-1; Mon, 26 Jun 2023 12:11:23 -0400
X-MC-Unique: M0zf4rIkP6GUCC9yNFacpQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7659cb9c3b3so142334085a.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795881; x=1690387881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YymWdEkHWhyai/v4Ncfq5HtLNdYJQriBatYjnpRoPBU=;
        b=kgpr2ShU3KRvVh7XfH+TmLPNFvnyvgDf6WZmzuLr5Lb1e9pu2AzfA5PWpZpb0ILDeQ
         zd8HWH+ViNCYw26M8wCImHE8zt5lmrKOTOum7BVNh4fBZGDh6KwJXvvtxw/sFzu3j3xe
         sj8ng60mqjtq6MIGg6Au5309ItFHqUZ6hPrhTvM092zuK2aalCw9DA+0y676Nx9fy2Sm
         VDQ+FPojTu3jEVWVJVhPGtvr68b5mMP0pBaxJUWP8/dtpcvRY9lBeRACAaxnn9cpKOeC
         Xl3hZlY0iwZ4DtFQ7Y/K3MYPO20vfDGjTSF/c4awgtGjI1GB8f9O8rbWEtnnSTQx74O+
         wcbQ==
X-Gm-Message-State: AC+VfDxRbmA8aXD1AEGxyDZtbzhpRv5KQESpzSg3CnCn9l6Tga/NK5R7
	SdFj9blQDHjj1TSpBZtgm1eGXSPMp5UinDYCE+V497P6NSVGTTL0hAykyIEEsl+NIbYwP5hfxn7
	tNaIW5h9IT3M8mnUj
X-Received: by 2002:a05:620a:4308:b0:765:619c:cca8 with SMTP id u8-20020a05620a430800b00765619ccca8mr8196738qko.16.1687795881652;
        Mon, 26 Jun 2023 09:11:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OTPuoDBhm9NFpKvI1ovmDpK5uOGhA7usFuq/EJikHKcpNPEengaaoKEb0Pz/YsBCORIP4qQ==
X-Received: by 2002:a05:620a:4308:b0:765:619c:cca8 with SMTP id u8-20020a05620a430800b00765619ccca8mr8196717qko.16.1687795881447;
        Mon, 26 Jun 2023 09:11:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id y26-20020a37e31a000000b00765a7843382sm1252256qki.74.2023.06.26.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:11:20 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:11:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 11/17] vsock/virtio: support MSG_ZEROCOPY for
 transport
Message-ID: <fvxvln7njntjflcwbw7ypzu7jybe2cwq5xedgjcxkkubuuayp7@bs3r3r5rvifw>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-12-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-12-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:33PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for virtio transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 6053d8341091..d9ffa16dda69 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -438,6 +438,11 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport virtio_transport = {
>@@ -484,6 +489,8 @@ static struct virtio_transport virtio_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,

Ditto.

> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>-- 
>2.25.1
>


