Return-Path: <netdev+bounces-20896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4B761D78
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C242D1C20EED
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4523BDB;
	Tue, 25 Jul 2023 15:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C31F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:39:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331811FD0
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690299559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcCFU2Ivogkl7HFNHxFyEJm3ALVxSHEsRN1xT36+tVI=;
	b=bs5+xR6NomwkYvbPyyPgDy+5gKqCrKTEF32Ah6f7W5PJ/T5669EkDg1GVY2QAe1VBi/2cH
	8Wcu7zXR1sGLtitqZLSDmB+wbb846Yj7DcfTZpYqhXTyYNljNSNvZFvvhuFRRffeE/BevR
	L1Og6S5io9TDmd73+YM/ShyhMlLrCCU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-zYj8AniGNh-LaRSt2Y2AKA-1; Tue, 25 Jul 2023 11:39:17 -0400
X-MC-Unique: zYj8AniGNh-LaRSt2Y2AKA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a3a8d12040so11635958b6e.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299556; x=1690904356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcCFU2Ivogkl7HFNHxFyEJm3ALVxSHEsRN1xT36+tVI=;
        b=e06MotaB0neINZ8+1X74PN9xF/xC7tM88sHPQNh3CZ2H1Sr4jtd2Zht8n+28yt73TZ
         WeonUsrHd0+tKe8s6cZZHc4iP3B5QuKhQ//2oJupSYZPBttJnTnF+zkKcN0SeDppEPf3
         VPx3iGM5bhvpIyZOAC8L3klkAS9EZaSpj6z0fmBXa+U59rxdtigCQ6pkMGc4+0g280P/
         kEV9+c1NLSk5rbw35N7JAdXa5Y/BBPJxpSM4nG8zdsUdLRtexHoESIAn+ocjvigVnAIC
         qv/Zpx3/lo2G/3SAtvWX4lvh8Gcs1q2YIV9zDHJTqMd+U5cZCXUht5xA5YXEe95cdlPP
         2Kcw==
X-Gm-Message-State: ABy/qLZjtAjQazaeSNQmvScoQzLKjj4l+3csZKXKQ8Jq373zAGbLtu+t
	R8FZviFYRa5lSqsESw6880c0HCzpQ6CzYN84RIZlVIppyaEwb4FoPhcIfYpVeIxwU08QuMwKvhW
	Vk1kGrB7RR5iOZMhQ
X-Received: by 2002:aca:903:0:b0:3a4:2983:fae4 with SMTP id 3-20020aca0903000000b003a42983fae4mr13668667oij.16.1690299556758;
        Tue, 25 Jul 2023 08:39:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0TGaUqzi7xbyp+p32xHTznjTx8QeM+1IFMYrpqrtgsnqXajAIOZAP2vbA9ODUoVXO9/LaIw==
X-Received: by 2002:aca:903:0:b0:3a4:2983:fae4 with SMTP id 3-20020aca0903000000b003a42983fae4mr13668657oij.16.1690299556430;
        Tue, 25 Jul 2023 08:39:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
        by smtp.gmail.com with ESMTPSA id z9-20020a0cf249000000b005ef81cc63ccsm4396365qvl.117.2023.07.25.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:39:15 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:39:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 1/4] virtio/vsock: rework MSG_PEEK for SOCK_STREAM
Message-ID: <p5sh4fskegski2l4d5jkziaun266mjnzfpig6qs5zsxg55rc4t@vfi2icif57pj>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-2-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719192708.1775162-2-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:27:05PM +0300, Arseniy Krasnov wrote:
>This reworks current implementation of MSG_PEEK logic:
>1) Replaces 'skb_queue_walk_safe()' with 'skb_queue_walk()'. There is
>   no need in the first one, as there are no removes of skb in loop.
>2) Removes nested while loop - MSG_PEEK logic could be implemented
>   without it: just iterate over skbs without removing it and copy
>   data from each until destination buffer is not full.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 41 ++++++++++++-------------
> 1 file changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..2ee40574c339 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -348,37 +348,34 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 				size_t len)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	size_t bytes, total = 0, off;
>-	struct sk_buff *skb, *tmp;
>-	int err = -EFAULT;
>+	struct sk_buff *skb;
>+	size_t total = 0;
>+	int err;
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		size_t bytes;
>
>-		if (total == len)
>-			break;
>+		bytes = len - total;
>+		if (bytes > skb->len)
>+			bytes = skb->len;
>
>-		while (total < len && off < skb->len) {
>-			bytes = len - total;
>-			if (bytes > skb->len - off)
>-				bytes = skb->len - off;
>+		spin_unlock_bh(&vvs->rx_lock);
>
>-			/* sk_lock is held by caller so no one else can dequeue.
>-			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>-			 */
>-			spin_unlock_bh(&vvs->rx_lock);
>+		/* sk_lock is held by caller so no one else can dequeue.
>+		 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+		 */
>+		err = memcpy_to_msg(msg, skb->data, bytes);
>+		if (err)
>+			goto out;
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>-			if (err)
>-				goto out;
>+		total += bytes;
>
>-			spin_lock_bh(&vvs->rx_lock);
>+		spin_lock_bh(&vvs->rx_lock);
>
>-			total += bytes;
>-			off += bytes;
>-		}
>+		if (total == len)
>+			break;
> 	}
>
> 	spin_unlock_bh(&vvs->rx_lock);
>-- 
>2.25.1
>


