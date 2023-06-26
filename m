Return-Path: <netdev+bounces-13991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE573E43A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385B5280DE7
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540ED51B;
	Mon, 26 Jun 2023 16:09:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7FC2FC
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:09:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F09E72
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687795743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVw/Wv9H1+jgHlFyXB8K46FNsZdoHq7Qo4C7jHkkuH8=;
	b=TMH+rpfn9ii3H81oh2K+pvHM+pYMLnazLjqLI+6Myti3tf5rW75IHDb27J15Hakx7qoBvc
	rKz6tl/8UatpjSUzFUEomvW1C8HLtQPwfFmhxLWsJL1cTI5G5/IyFYbwUVdb0LmtJq/r0K
	e0lljxxCliF7qf+zZBhZ6HvcsgVObpQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-tngORGxpOH613wwsZsiyLg-1; Mon, 26 Jun 2023 12:08:53 -0400
X-MC-Unique: tngORGxpOH613wwsZsiyLg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635d9e482f1so18567746d6.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795722; x=1690387722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVw/Wv9H1+jgHlFyXB8K46FNsZdoHq7Qo4C7jHkkuH8=;
        b=DLZ33sezGJwreMqYpjRH3ZUt9P0pYaSe4MGXgTNl9wmezOk6Hu0WdhjMnMHvAhU5j4
         0T3OWYhe5vCM9FjEZMoZoK0R6qaw64GQGBuQ9vTaIJw4rOUNO4V0WPh+z0N0El1eDe/y
         2/9qNmgDClGNVMCPm63W7KQ03CA+lLa+oOBSN3JuYbMVQA4NGQgDwgp9QO+0UrxQe7Fa
         Ft5H2fMnOoj9qrUJI0C41SzJMM/LPwF/lfSdgkg+xxtNEUk8AnT14AYpiWUGTT9AOkpt
         N5SkJlak8pseD0rxVPfN/BvQ3MMF6Kjx+YQ4x4BaBGlz4eXMyxxjzWDv00F2S2PdYn1f
         xsWg==
X-Gm-Message-State: AC+VfDwIBu+eFs5wlxRa8wRMUX4TaMD3RPmftVAkaIuPt9DjKFfW3SN5
	yqrqO59khqFUnLQRzoe+16iibLopGiBBFL50crNClaYZSJ2ZltoaqNom3ghy6nfdVzpu2UoeZHJ
	9sZACmsEsxVQSHEOB
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id ge9-20020a05621427c900b0062df5159320mr36074267qvb.28.1687795722198;
        Mon, 26 Jun 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5raYOLH44gjALQWDUf6IbJggeYwYWXvVHtOWcRvbl3wuo2Ee6zIMMrWONEOeu5ohWrGHlbZg==
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id ge9-20020a05621427c900b0062df5159320mr36074244qvb.28.1687795721957;
        Mon, 26 Jun 2023 09:08:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id l13-20020ad44d0d000000b0063227969cf7sm3308298qvl.96.2023.06.26.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:08:41 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:08:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 07/17] vsock: read from socket's error queue
Message-ID: <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:29PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/linux/socket.h   | 1 +
> net/vmw_vsock/af_vsock.c | 5 +++++
> 2 files changed, 6 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index bd1cc3238851..d79efd026880 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -382,6 +382,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287

Maybe this change should go in another patch where we describe that
we need to support setsockopt()

>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 45fd20c4ed50..07803d9fbf6d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -2135,6 +2136,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 0);
>+
> 	vsk = vsock_sk(sk);
> 	err = 0;
>
>-- 
>2.25.1
>


