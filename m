Return-Path: <netdev+bounces-37739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBD7B6E4D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1A427281190
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152F38DEF;
	Tue,  3 Oct 2023 16:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D731A82
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:23:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71CEAB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696350201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K8nJSyCd6Mj6/uVIoeX6vSBcbL415T2j/UKJhN/9HxQ=;
	b=hk81CwSflEGJSokyTAbNUcMdF8xZNS+v68eO8Rc//7EQKONPbqd1Pdqhq6b9drubI0ZZYc
	b+Unnb0K6c3qYL8BoX9Dq0dJKlJllBbNsh3Bg9BZwIcL/KOmrdjdcpKPhW5HGw5E5u9Xaj
	U8TeX62D6aqExIUmvNRuMdIMSLXH96k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-dnaL3hl9PUWKpCZBHeB5VA-1; Tue, 03 Oct 2023 12:23:19 -0400
X-MC-Unique: dnaL3hl9PUWKpCZBHeB5VA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65b23c40cefso11266636d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350199; x=1696954999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8nJSyCd6Mj6/uVIoeX6vSBcbL415T2j/UKJhN/9HxQ=;
        b=vLkBYY6b/63M7BCuFh9AvsRfLtJXiSqvkNx7RZEy55lZdjzfX/7txg/KBURfKaX6wv
         jpVuogMZHavv6DA+s8r7ET9HcpInCOQFODqjwTS0XOFbua7i5REcW2+7iRT6YLCmKBdU
         5ZOkarKd+H8skLvK8uV3o+2gcP7GlLfY4SAUSM/DqJrl3REuXM6m1z40I/1zPRgYBpC9
         sINFXYyy6dytDvNv1/Dm7jAHMw8JNTbhTAyygSzh2I0/E6dyGJ3GrCY9b5u/W+JV7c1D
         0DxPNDA/U5dGsMOqZT6vUfNIgtJaJCl9pvtU8OpkSCMvlLMjbogILFmQg+rzveiUySp9
         QMTA==
X-Gm-Message-State: AOJu0YxTFhr9SbHyUVSe6VnV3rIVYVRl3SywvHjA0342iwgs1eN2iEbz
	SWFeIUTd8LJoIfAnDrTlpq2w+zyby/3otc7v39tHan2tr996efl+3wUWMs8bk164fYG0M9tvGpK
	ORyfi4bww6OOp0Yos
X-Received: by 2002:a0c:f04c:0:b0:658:a29a:e297 with SMTP id b12-20020a0cf04c000000b00658a29ae297mr12037757qvl.49.1696350198902;
        Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8uQkWWDZB3h/ubLuDg4GpK42nrIzlPUoFwtgf5CmfllU3UftYG/UPLqG6M4Qulj6QX9ZOAw==
X-Received: by 2002:a0c:f04c:0:b0:658:a29a:e297 with SMTP id b12-20020a0cf04c000000b00658a29ae297mr12037737qvl.49.1696350198592;
        Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id vv22-20020a05620a563600b0076ca9f79e1fsm580607qkn.46.2023.10.03.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:23:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 02/12] vsock: read from socket's error queue
Message-ID: <2o6wtfwxa3xeurri2tomed3zkdginsgu7gty7bvf5solgyheck@45pkpcol2xb3>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 12:02:58AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Place new defines for userspace to the existing file 'vm_sockets.h'
>    instead of creating new one.
>
> include/linux/socket.h          | 1 +
> include/uapi/linux/vm_sockets.h | 4 ++++
> net/vmw_vsock/af_vsock.c        | 6 ++++++
> 3 files changed, 11 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index 39b74d83c7c4..cfcb7e2c3813 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -383,6 +383,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287
>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index c60ca33eac59..b1a66c1a7054 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -191,4 +191,8 @@ struct sockaddr_vm {
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+#define SOL_VSOCK	287
>+
>+#define VSOCK_RECVERR	1

Please add good documentation for both of them. This is an header
exposed to the user space.

>+
> #endif /* _UAPI_VM_SOCKETS_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..0365382beab6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,8 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>+#include <uapi/linux/vm_sockets.h>

Let's keep the alphabetic order as it was before this change.

`net/af_vsock.h` already includes the `uapi/linux/vm_sockets.h`,
and we also use several defines from it in this file, so you can also
skip it.

On the other end it would be better to directly include the headers that
we use, so it's also okay to keep it. As you prefer.

>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -2137,6 +2139,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, VSOCK_RECVERR);
>+
> 	vsk = vsock_sk(sk);
> 	err = 0;
>
>-- 
>2.25.1
>


