Return-Path: <netdev+bounces-13989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A408F73E427
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA0280D4C
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71ED511;
	Mon, 26 Jun 2023 16:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4BCD505
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:05:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C4910FD
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687795513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0yQZBdpdUXl4YMdFLcFlkwsrjZb29VthZRnokOZ88k=;
	b=W1K6o3st3YkxrAp94QsGHdnY4/VhM9G8rsnc5+MiP7Rq6yE+lh7CIKc3QiEsXaedhpZhOO
	EkArxTjEj//NnPgVFP3axBd0Js2fTYGnYrhJbntqE5h4Fcp7MGXV1y/q1JqlWWzsdWQdyC
	sjAGiRyi5GaxnY+mHq+qsGJXJ1/hWwY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-lMWIK_PjPTizZoht8j-J1w-1; Mon, 26 Jun 2023 12:05:08 -0400
X-MC-Unique: lMWIK_PjPTizZoht8j-J1w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4008e5f1dfbso25591591cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795490; x=1690387490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0yQZBdpdUXl4YMdFLcFlkwsrjZb29VthZRnokOZ88k=;
        b=fdPFIoHuLWtaKa49q6TK3azcFdH43SC2xQvNVfhGRZCqC4rMvoTwjSvmS4iFnORxIr
         zWTGh2Dilcmg7h2FM7LNepLbB+exnVucUjBf2wjEqnCk/7Hy0qxv2eN7GULdvPow6/ga
         N860qLBvGPEkcpytvAd2ZGrmSavNGiaivSPKjwps8MrOPYzkAg5yuw2ia0hIHjtF7C5s
         cDSpVBYT+vj5VyITN8gtczlXIimYfzwzELVOUQGE4M0PuUzHa90XhCKpGC/FgzEpWWS4
         vZe3MJ3JXOfF8qXknebeIJHbPVVcJFFuoipeGZ/dZh82EOoRHb9QCjWXq7fDCnKxZqTc
         ZUrA==
X-Gm-Message-State: AC+VfDz5WKgHPqAF/D+h5IK24HiAlt1P+O1tZXmPkb1L4nEX8zACdBxv
	k3c5ZKBxsJ5awg7zopFnFHDt/fMUejUjZMUjCZIV95k5Td8Db7cP46JOCjlWEfHh0LTXeQWC8su
	R6SVjGP/h2UENiKkb
X-Received: by 2002:ac8:5dcc:0:b0:3ff:2fae:b4bb with SMTP id e12-20020ac85dcc000000b003ff2faeb4bbmr22270348qtx.37.1687795489890;
        Mon, 26 Jun 2023 09:04:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6scFxlQwYFHNY1LJg+2KYwo5IzNCiATxO/eK3932x063Eqk2Ca+8K2qyxj23DPRz3vgCwgrw==
X-Received: by 2002:ac8:5dcc:0:b0:3ff:2fae:b4bb with SMTP id e12-20020ac85dcc000000b003ff2faeb4bbmr22270315qtx.37.1687795489480;
        Mon, 26 Jun 2023 09:04:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id z6-20020a05622a124600b00400ab543858sm900265qtx.67.2023.06.26.09.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:04:48 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:04:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 06/17] vsock: check error queue to set EPOLLERR
Message-ID: <rg3qxgiqqi5ltt4jcf3k5tcnynh2so5ascvrte4gywcfffusv4@qjz3tkumeq7g>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:28PM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

This patch looks like it can go even without this series.

Is it a fix? Should we add a fixes tag?

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index efb8a0937a13..45fd20c4ed50 100644
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


