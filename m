Return-Path: <netdev+bounces-36298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B927AED4C
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 09564281499
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB72771C;
	Tue, 26 Sep 2023 12:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCB26E28
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 12:55:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05A10C
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695732900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uW5BPkL7G62EXjKucVaT4hjcyiDQF9d1Ksud/nFSa4=;
	b=F2uh2LRekgMw6h7iAASK4puNgf47moQBrHHV9zbt4iArrZCvarzcQl8kRlER7L3WZVDVPF
	lgZUk6csC65UEYfebH7mHXVT0CRtJQEedTzJuSLimKtBnuQS7Qi0xpomu7n1j2fNRNJtfo
	3UjjVFS6SYBsfFzvfS5frMXHT8DPLw8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-Lv0VoWzVM76cfozGQioDDg-1; Tue, 26 Sep 2023 08:54:58 -0400
X-MC-Unique: Lv0VoWzVM76cfozGQioDDg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c038a1e2f6so134383461fa.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732897; x=1696337697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uW5BPkL7G62EXjKucVaT4hjcyiDQF9d1Ksud/nFSa4=;
        b=OTQMxPNP2/UEflT5JVmf1qgBlu+is4yfjupf+Fw1VedAZTaWzmrH2Su0rbUIjU9elm
         pGnd9koLk/brlB5/Cf0qTOxRrdrVC4/lpDIN2pwLMTHDq4Q0++62/I2mI/z4C8jwCmcj
         ZxTt/gk4+SnusIn1bkD11AATKmiqySzXye61snbTRt+Ih81RUiQ3NwY6ttAUYgXjOsma
         TVDcRe+lOdnbhngbD9SnP9priKqH2Wwy4qN9BMtaNLU1IAJFef8lqQN5oacUMTPLZqmW
         6IygLj3WdEPDvF4NV3OYK3L4K4dqsyPyKxE0/2B6CrvaRMbyRIZmsZ5e8x+4h5wH0Bz+
         tlzg==
X-Gm-Message-State: AOJu0YzzdUUfQikuMeMnJbmIgwkCc0n7oBzEXeo9Ri3SRF+AgGxoPn7U
	3vUZRppHiAkWg8nmAzLssnqVzIzOAW5lR91WmGo8FZa7oRB9geIWXq2sz18caOztsTmau24KqjO
	MQkB28ug5LUCb4lCz
X-Received: by 2002:a2e:b04c:0:b0:2bb:a28b:58e1 with SMTP id d12-20020a2eb04c000000b002bba28b58e1mr8106209ljl.41.1695732897290;
        Tue, 26 Sep 2023 05:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5q2QvU/4B+w5gQ4LBJ4yGShJuspgZAbJhAjCh9mTkszev9SWItBdbop+W/rBkb0q5Yimnxw==
X-Received: by 2002:a2e:b04c:0:b0:2bb:a28b:58e1 with SMTP id d12-20020a2eb04c000000b002bba28b58e1mr8106195ljl.41.1695732896938;
        Tue, 26 Sep 2023 05:54:56 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906279100b0099329b3ab67sm7735262ejc.71.2023.09.26.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:54:56 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:54:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1 01/12] vsock: fix EPOLLERR set on non-empty
 error queue
Message-ID: <lj3wjq4ccplc6ia7mehuu4onzpgntaykvwpyzlavqj5uek2amg@oo3vyfiteysx>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922052428.4005676-2-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 08:24:17AM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>Currently for AF_VSOCK this is reproducible only with MSG_ZEROCOPY, as
>this feature is the only user of an error queue of the socket.

So this is not really a fix. I'd use a different title to avoid
confusion on backporting this on stable branches or not.

Maybe just "vsock: set EPOLLERR on non-empty error queue"

The change LGTM.

Stefano

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 013b65241b65..d841f4de33b0 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1030,7 +1030,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 	poll_wait(file, sk_sleep(sk), wait);
> 	mask = 0;
>
>-	if (sk->sk_err)
>+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
> 		/* Signify that there has been an error on this socket. */
> 		mask |= EPOLLERR;
>
>-- 
>2.25.1
>


