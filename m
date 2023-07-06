Return-Path: <netdev+bounces-15852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4974A295
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E392528109D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEDFBA25;
	Thu,  6 Jul 2023 16:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B3BA23
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:55:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689421BE3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78X1P2RbA2naQ6uRnxp6k32HKAIUnBp53PzVIigmGLg=;
	b=KE+98sW5HUo9y6qy3S42o6Q/92kmS0eiW1Ugg3eIuicm1eEMq//f8ZiXeYuM3EGnJOAor2
	mt5HXn6wDxJJgHv7Q6Gncuxe7dHxEQo2qX6+sTgTcP6AKXDJhMFn+CnFZ4kPY2VvpvJg1S
	y218uq3yME4sX3u68ZSw/1tEwr8BliI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-uiF7Poa0NeGQ1jPZPqzyKQ-1; Thu, 06 Jul 2023 12:55:07 -0400
X-MC-Unique: uiF7Poa0NeGQ1jPZPqzyKQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355cf318so69156966b.2
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662506; x=1691254506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78X1P2RbA2naQ6uRnxp6k32HKAIUnBp53PzVIigmGLg=;
        b=VOAuJMm7QRs/+PHZln+dQrlTWX+yx/6TPVkS/XeSVx4mcozrAxcuDjAm6ZkhRo3PwZ
         W6FJdLGF/WkpFYRGbhtcomX7543wU9lIN/EnCA+Az5wiVud0Nhqdw4kSPwGjwOXPK7x7
         09DzqLx3GDeVjRdy9j6rwyrUbNYoGWWkY21flRFr0g4wYreEzHGRI7UqNYKKBAGRt3CT
         28/RqADN9H6H6tRkBaTMsbqiH+MAHmp0gepDKO9K9b4MMxMHS4ZrtmG/Yycknrl8G/Fw
         LzHQ146SgFvfbg7aqYXjyfeQVPeKYoLq5u9yeY7CrUTSRfENuRsJ/acScbuD8qPJ2PaU
         BafQ==
X-Gm-Message-State: ABy/qLZz8bVp21kZxO4OuQPnSMZNiDvbQW8hhEo99zBaCXMkEDWlacDR
	82mMZ5f97fTb5BuC40ifW/5WWkCssMZ6Imr5gzO1qEkskaMK0G5mLugrrUTpmdD2KFXx+OhSg9J
	8zAROfilFZJj2c7az
X-Received: by 2002:a17:906:5185:b0:992:a9c3:244f with SMTP id y5-20020a170906518500b00992a9c3244fmr1583453ejk.4.1688662506005;
        Thu, 06 Jul 2023 09:55:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnbcCuNIs/OppuWQYxPKp5Z8HDqdwHBAM1xNlziO52ksP44T7cMIPX6GA9m+5cSy54n0kP6Q==
X-Received: by 2002:a17:906:5185:b0:992:a9c3:244f with SMTP id y5-20020a170906518500b00992a9c3244fmr1583447ejk.4.1688662505832;
        Thu, 06 Jul 2023 09:55:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id hk15-20020a170906c9cf00b00991bba473e1sm1041884ejb.3.2023.07.06.09.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:55:05 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 08/17] vsock: check for MSG_ZEROCOPY support on
 send
Message-ID: <xpc5urpiwj5adhqqtiumlnxwnljuv3jtepkzn6owju5quzuojh@m2bbycr6bnnj>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-9-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-9-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:38AM +0300, Arseniy Krasnov wrote:
>This feature totally depends on transport, so if transport doesn't
>support it, return error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   | 7 +++++++
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 2 files changed, 13 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 0e7504a42925..ec09edc5f3a0 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -177,6 +177,9 @@ struct vsock_transport {
>
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>+
>+	/* Zero-copy. */
>+	bool (*msgzerocopy_allow)(void);
> };
>
> /**** CORE ****/
>@@ -243,4 +246,8 @@ static inline void __init vsock_bpf_build_proto(void)
> {}
> #endif
>
>+static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
>+{
>+	return t->msgzerocopy_allow && t->msgzerocopy_allow();
>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 07803d9fbf6d..033006e1b5ad 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1824,6 +1824,12 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		goto out;
> 	}
>
>+	if (msg->msg_flags & MSG_ZEROCOPY &&
>+	    !vsock_msgzerocopy_allow(transport)) {
>+		err = -EOPNOTSUPP;
>+		goto out;
>+	}
>+
> 	/* Wait for room in the produce queue to enqueue our user's data. */
> 	timeout = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>
>-- 
>2.25.1
>


