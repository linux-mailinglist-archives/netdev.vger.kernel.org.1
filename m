Return-Path: <netdev+bounces-13996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896D73E461
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8361C20968
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07843111AE;
	Mon, 26 Jun 2023 16:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C10107BA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:14:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE69E4C
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687796056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAvdeHjRiEhExMf/8PkhS/lqlgbR8Yp8qV2L+W5RPMM=;
	b=TiPHFtJpQfN4smtdnbE8nSkFC53LbBViezBwPcvoxiQKLEuCMyZXCHwzk4oEhbBJb5xF5J
	DRAOzmWHRwnQemhjx6w/utSFzS4Qn+3rxHElG61dO+Ks5iKdV3UwtLAZypSxshBAT60wNZ
	lUE4kYFCkxp+5QLQE2RRYBTah1hrq8A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-47BeWF1PND6XQdNSAVNOTQ-1; Mon, 26 Jun 2023 12:14:14 -0400
X-MC-Unique: 47BeWF1PND6XQdNSAVNOTQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635e6c83cf0so7026636d6.3
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796054; x=1690388054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAvdeHjRiEhExMf/8PkhS/lqlgbR8Yp8qV2L+W5RPMM=;
        b=AUnABDMQZViaZoItK4/dO5R2TAZDIqHr0KioaJ7s+5EWjdfTWO4lyTD4+g7ETLjeFE
         7oY4ILY8oM5bJBA7uTLohaHc19MGaMnaH+hMUhOnOOSLaI/9fbYHVf4oYg4h6JlKQHo1
         uRvSWTrF7Wz2b3pg12w/Hd1a1DGOMxMvhxdxrwdvloge3U7jsVg7isq/a7uNt/AKklLw
         q9nFTMUWxiakJUJ5JOk9ymlGujcpOwfbWe+PvI2kKQNPNq9JDWw++FPP3qBsxKRIJbPy
         IKRUTZ5VWPwbKGYN/kaHrfWnNPm3xFQ2x+nFog5QnLv4ddePXAGv5uZZ2RrJoZtYQ795
         8xBA==
X-Gm-Message-State: AC+VfDxVbAgyC0ouq/UneRpwHFly4Mn20zpAl1Q2uG9EkUPoyVk/p3Dn
	nmIh/xPynA7Uai4DQyiXZZzJkK36hRzawuyEzKboLI15iJiCUQN3j3r3bI4+mXj9O6w8o+5zj1I
	4jOOq1aQioSx7dS/R
X-Received: by 2002:a05:6214:4015:b0:62d:d6e4:7ccf with SMTP id kd21-20020a056214401500b0062dd6e47ccfmr31955503qvb.40.1687796054280;
        Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dcXj93WXuU6BFIJYyBOMHVPNnCeqXrPEQR3X/qVTsVAuQorwHM7WjdhifsJqsX7Lt2y/AjA==
X-Received: by 2002:a05:6214:4015:b0:62d:d6e4:7ccf with SMTP id kd21-20020a056214401500b0062dd6e47ccfmr31955480qvb.40.1687796054044;
        Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id lw15-20020a05621457cf00b00626161ea7a3sm3349930qvb.2.2023.06.26.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:14:13 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:14:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 12/17] vsock/loopback: support MSG_ZEROCOPY for
 transport
Message-ID: <lex6l5suez7azhirt22lidndtjomkbagfbpvvi5p7c2t7klzas@4l2qly7at37c>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-13-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-13-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:34PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for loopback transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vsock_loopback.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 5c6360df1f31..a2e4aeda2d92 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -47,6 +47,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_msgzerocopy_allow(void);

I don't know why we did this for `vsock_loopback_seqpacket_allow`, but
can we just put the implementation here?

>
> static struct virtio_transport loopback_transport = {
> 	.transport = {
>@@ -92,11 +93,18 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,

Ditto the moving.

> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
> };
>
>+static bool vsock_loopback_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
> {
> 	return true;
>-- 
>2.25.1
>


