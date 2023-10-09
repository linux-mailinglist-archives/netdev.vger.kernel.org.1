Return-Path: <netdev+bounces-39183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E680A7BE463
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1518F1C20A1C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6236AF7;
	Mon,  9 Oct 2023 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4KXQ0cf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC76358AA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:16:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D528B131
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696864617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gmTuRm7MgRiV0DIb6UC+zzg6xOoFVegXTF+vt6GHPY=;
	b=A4KXQ0cfOGlZ190obqk2bR20z3vdQ36Mgvbbh3I/MFdUSWngikDkgpkKQ+VAGeVYvr+zG/
	c63YAWDJaBHlrfdkVq8fTNWNzm8LEum4+BIfH6b0fyuYHtUsJtyoAx686vhqD26Df3Jv4y
	HtZr6vASkJQ8KvQks4e9yo48smUwu9w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-mxmzr3oROla1rhrf5K_gQA-1; Mon, 09 Oct 2023 11:16:55 -0400
X-MC-Unique: mxmzr3oROla1rhrf5K_gQA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5342c8a70a8so4057251a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864614; x=1697469414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gmTuRm7MgRiV0DIb6UC+zzg6xOoFVegXTF+vt6GHPY=;
        b=SG6NKP2ZK/fRNQ+y1FwHy0bdKACFlUDX6FyVUVpJIBf6VF9hY7rVAvYvmMHkFV4vDe
         i2QzZyk/Z1L21SrpQjh6n+1by/+qVOjvvUgKmo9t+TdTrZieopevnySqmVxESixMVzfN
         5B/SGUiJfqqAIVTh3bilbem9QqiYD4gm4ZT1/wH4/uII76b1mrTRVVTgLI0nu/S3sRss
         E3iuhMeOz/oMsQpN6i+I2kMB1VVl5RcgUauDazKPnV/Bl7FcYJKSrJIBj/NZwod7IB5s
         Dj0PglyK5KVHRzOiMMzgBYENofIhc2VpHSoed5a9bB2EAEseNNRNI2XdIwn6GNDNab4/
         NETg==
X-Gm-Message-State: AOJu0Yz3wvIQNeXHYENMdm7m7WpaMzhLhjgYm5IzqrgENkstrYyjTkh2
	FMKfJYstqgvTlyjJ2FOli4/zOwrFsMC+643VhbQfd2yIk3+wtZ9eyZYCBxvrHsHcvsZl1pwCmhB
	7uXPNfzwMprIh9c7k
X-Received: by 2002:a05:6402:1ca5:b0:53b:3225:93b2 with SMTP id cz5-20020a0564021ca500b0053b322593b2mr7407142edb.29.1696864614024;
        Mon, 09 Oct 2023 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrMTn2vJyCRndP6TodZU0FVgeIan6pJGYPn2FrcveBY88ywUI+fm3YppJUOvDo92NN8Mz+WQ==
X-Received: by 2002:a05:6402:1ca5:b0:53b:3225:93b2 with SMTP id cz5-20020a0564021ca500b0053b322593b2mr7407123edb.29.1696864613643;
        Mon, 09 Oct 2023 08:16:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402181200b0053782c81c69sm6187982edy.96.2023.10.09.08.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:16:52 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:16:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 02/12] vsock: read from socket's error queue
Message-ID: <v3w46qfwgi66omysu64ma3lac437wy3j47a6vdbtr4umxfcrvv@4y2ypaub2k22>
References: <20231007172139.1338644-1-avkrasnov@salutedevices.com>
 <20231007172139.1338644-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231007172139.1338644-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 08:21:29PM +0300, Arseniy Krasnov wrote:
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
> v2 -> v3:
>  * Add comments to describe 'SOL_VSOCK' and 'VSOCK_RECVERR' in the file
>    'vm_sockets.h'.
>  * Reorder includes in 'af_vsock.c' in alphabetical order.
>
> include/linux/socket.h          |  1 +
> include/uapi/linux/vm_sockets.h | 12 ++++++++++++
> net/vmw_vsock/af_vsock.c        |  6 ++++++
> 3 files changed, 19 insertions(+)
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
>index c60ca33eac59..d9d703b2d45a 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -191,4 +191,16 @@ struct sockaddr_vm {
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+/* For reading completion in case of MSG_ZEROCOPY flag transmission.
>+ * This is value of 'cmsg_level' field of the 'struct cmsghdr'.
>+ */
>+
>+#define SOL_VSOCK	287
>+
>+/* For reading completion in case of MSG_ZEROCOPY flag transmission.
>+ * This is value of 'cmsg_type' field of the 'struct cmsghdr'.
>+ */
>+
>+#define VSOCK_RECVERR	1

I would suggest a bit more context here, something like this:

diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index d9d703b2d45a..ed07181d4eff 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -191,14 +191,19 @@ struct sockaddr_vm {

  #define IOCTL_VM_SOCKETS_GET_LOCAL_CID         _IO(7, 0xb9)

-/* For reading completion in case of MSG_ZEROCOPY flag transmission.
- * This is value of 'cmsg_level' field of the 'struct cmsghdr'.
+/* MSG_ZEROCOPY notifications are encoded in the standard error format,
+ * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
+ * kernel source tree for more details.
+ */
+
+/* 'cmsg_level' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
   */

  #define SOL_VSOCK      287

-/* For reading completion in case of MSG_ZEROCOPY flag transmission.
- * This is value of 'cmsg_type' field of the 'struct cmsghdr'.
+/* 'cmsg_type' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
   */

  #define VSOCK_RECVERR  1

The rest LGTM.

Stefano

>+
> #endif /* _UAPI_VM_SOCKETS_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..38486efd3d05 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -89,6 +89,7 @@
> #include <linux/types.h>
> #include <linux/bitops.h>
> #include <linux/cred.h>
>+#include <linux/errqueue.h>
> #include <linux/init.h>
> #include <linux/io.h>
> #include <linux/kernel.h>
>@@ -110,6 +111,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <uapi/linux/vm_sockets.h>
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


