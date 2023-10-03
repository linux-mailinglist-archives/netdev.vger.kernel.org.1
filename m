Return-Path: <netdev+bounces-37738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9475A7B6E4A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AC1901C203FF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46038DEA;
	Tue,  3 Oct 2023 16:22:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F131A82
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:22:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B649E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696350167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r147ix/t4ru4DZEC+DJrb4DBuvtWEoQLF9djs4ZSusI=;
	b=AW0A7bYACSNIqsBUhNeSOKzyPkImrppn2ZuU6YaWbGMDWhvXtkYLzGOLjUqHuXHBxtWaQi
	Y1IqT3CB8Gd+tZs2yWmq8FsyGo5CXIQBlHb1Z5eBQcYnnArKeldZmzmNaO4+6rgaqLCWRh
	scyHfCLPGyOCK1hI9Do579QraEwVsYM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-9SAo5GkEPPihbXL50wVzJA-1; Tue, 03 Oct 2023 12:22:46 -0400
X-MC-Unique: 9SAo5GkEPPihbXL50wVzJA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65aff02d602so12261296d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350166; x=1696954966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r147ix/t4ru4DZEC+DJrb4DBuvtWEoQLF9djs4ZSusI=;
        b=CPyI6c3BwxhT6yqoGgMs6KsAasIqJbIUSWMoUqsOuLugXpHhClwA0NkEY68D3UfpyY
         damaLGW9B/XJKFz/VjeSrAn/69+qCMWY87k8U7Db0rBE8SzPWFXUZolXst5pIXPewREO
         1kPtPfF2tPHlml261ye+A/ueuxOYdIeSEy/B/8CVUz5TxJepacqPkSYAUoCYPpzfYOLN
         fhAW2sftenUoaMWF68D28UfX8nhESts7tbueyPjhp9O9XcSFJiZfOMd3NFyuepgCn9mz
         FfbMM6AJBHINr1lFVBIpkFZclSefy7TDPCWIyUz0GwnLi17QIKUXaV/sFSRClBs9As+M
         FM4Q==
X-Gm-Message-State: AOJu0YwUEBQuTX5Oi8sK3X+kBNogU6oydxNw3BNNAMfzpCJ7Od8nHjwn
	6SvpoZDR+LY7kigtI9ER95ruOZ7iH4I5FRNI3l55GOk2LuDUXyoOeRaT9kB1INAiX5hTNbu384s
	3A2lSYGwygM5M37WF
X-Received: by 2002:a05:6214:488d:b0:64f:51fe:859c with SMTP id pc13-20020a056214488d00b0064f51fe859cmr17355785qvb.43.1696350165801;
        Tue, 03 Oct 2023 09:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqvM306M50A2rjJC5L4OkATm7mDAd1KWNSEosWc5K4oFW+hSL2rCEcu1U+nylxnoxNFfNg/Q==
X-Received: by 2002:a05:6214:488d:b0:64f:51fe:859c with SMTP id pc13-20020a056214488d00b0064f51fe859cmr17355759qvb.43.1696350165512;
        Tue, 03 Oct 2023 09:22:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id a21-20020a0ca995000000b0063d162a8b8bsm612637qvb.19.2023.10.03.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:22:44 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:22:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 01/12] vsock: set EPOLLERR on non-empty error
 queue
Message-ID: <qylubfxwihribskuw25sc6rvvjv7rz2loz6h6sdea464hzpq36@5gdhsu363gnx>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-2-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 12:02:57AM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>Currently for AF_VSOCK this is actual only with MSG_ZEROCOPY, as this
>feature is the only user of an error queue of the socket.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'fix' word.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
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


