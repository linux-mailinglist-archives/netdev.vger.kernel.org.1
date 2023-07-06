Return-Path: <netdev+bounces-15859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D84D74A2B4
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2861C20E02
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25451BA4B;
	Thu,  6 Jul 2023 16:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED4BA49
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:58:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BADA
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glhZ+2qeJMm9MWfPWx9SoMWGjL42JiHnlLy0ooXyD8I=;
	b=P+4hpBSVGWzHRLVUC3loe0Ajb2I/6uJpQB4WjEgwzdnYVGUj15TMpIw31ISGUz1enQTLup
	8/WBgGUBu3sPHK2dVWxCaVyNacgSlTCPI+ODtxR9c57QXja7S/PKLuHaH13pvIQHO9XpyM
	nGhibDzCtSLXZ3r3yqbHF8V2yJuZpC4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-wqvwwIhPN-OT51FWzFWQiA-1; Thu, 06 Jul 2023 12:54:43 -0400
X-MC-Unique: wqvwwIhPN-OT51FWzFWQiA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9835bf83157so63646066b.2
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662482; x=1691254482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glhZ+2qeJMm9MWfPWx9SoMWGjL42JiHnlLy0ooXyD8I=;
        b=NQ+B9CLc1TgrYw6/A0elZUlidNdFa6ryAqGTeoo1JCRevDULwuNCSxSrdhI0iweUlH
         VwB4KBUFbvfmriYUNqxBCuITxtW47VLt9lio63Ysc7y5TnaDFuLqrrX2dUVAPGusplS7
         XUp6aZ8GsaDmMGP8asVWzO1fV+o6T6VvkkebzHeMk7WoG93cBJeLNbIfRcShVYL1qZQn
         ThVTqF6C/EYPTE33yc6B134xki3hMyQ6i/iucG3v5JXv5d3pnXohMdHF5OwGQLAOjVeY
         83S9INqy3MMjn+t6ez5TU5HFYloTV0SaZIhcrON84xrQDVkEGxs4lL8es8Lpv1ouAm68
         cT6g==
X-Gm-Message-State: ABy/qLZ1Iv+KCJTA47DzpXvjrAYTF8FbN8DRXFdFECd9NBGh5Dnkd1e+
	bmH39hUBmErHe5orlAxYcERHPjW/9EOxjcjMRwR8cRrnBhjS7q8mQ5LJcQLxcs/Ml/DIDbiu4q2
	baTB0bKEG1E/cjQ8V
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id gg32-20020a17090689a000b0098ccc3c194emr1668118ejc.52.1688662482341;
        Thu, 06 Jul 2023 09:54:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF62VXDxBiD2YIMucVbmZsWHocuUY9mKHoepmGkw2mj8oHke7cYIWYsLK4/i6qDTk9eWPxoDA==
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id gg32-20020a17090689a000b0098ccc3c194emr1668102ejc.52.1688662482046;
        Thu, 06 Jul 2023 09:54:42 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id k12-20020a170906970c00b0096f6a131b9fsm1034242ejx.23.2023.07.06.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:54:41 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:54:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 07/17] vsock: read from socket's error queue
Message-ID: <ho76zima4fe7yxm5ckj66ibgyl6kstjaexf4x5dxq7azjamoif@tny2uqb5yifn>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-8-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-8-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:37AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds 'SOL_VSOCK' define.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Update commit message by adding sentence that 'SOL_VSOCK' is also
>    added.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
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


