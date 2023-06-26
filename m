Return-Path: <netdev+bounces-13962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A233C73E334
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C688280D9D
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C40BE58;
	Mon, 26 Jun 2023 15:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430EBA4A
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:24:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8585011D
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687793060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pNcIf8DGlU4ngflbaStrLY/OgH3ZgZfAt2j/tScjlPs=;
	b=Dl6pKlNRhDXxOvVjstL54kQe5jsPuQwLfGaC2Hr/9G1QQzbFZlonJYVd7hAu3WVc3INDjr
	gDn+RY12p7OyR+XHfJf6Q7m66ZVjKTOySmWctLSUFEIGm9vJX6mJG5mTQV82DrF1aWkeuT
	LXQyg7bNDuRxNhzH+KBnK3RSw4MvlFQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-CXoiVzLQP8mwx3S4jva-ug-1; Mon, 26 Jun 2023 11:24:13 -0400
X-MC-Unique: CXoiVzLQP8mwx3S4jva-ug-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7624ca834b5so482862685a.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793052; x=1690385052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNcIf8DGlU4ngflbaStrLY/OgH3ZgZfAt2j/tScjlPs=;
        b=js6ERpd8rzwNR+KkamfBsfvAhBlcRGZlXjvD6Dg8lW/XOw/Ws4iInL5Y8ugvLaCfFr
         sdrsUkEDeXc1xh4eIqJ99p21aSjjQpDN7BIOR482uOtHPCtLb8C71tnYENiYC6CUoEU/
         mFiH+e+WB7e9f7SFbLyQyU62CbEG/ioALZN85VBhrI3/PDotQOs4GaCE94DHEvcLJ/N9
         Zk0+jZVEX+uZxqzNrVsC3zJ5nhBltgUB4gagf144RZPKZkTxu4XKRwoKXPUdhMe5ypSi
         AAjJ5XVznB6QahKoTqjtw/ZcdHxvDkyTaU6OmxJd416aIh8JsLTK00oToX7XK9NE6tPH
         8KNQ==
X-Gm-Message-State: AC+VfDydCIwkpcIk3QFrFEVrpepJgAYQZ3b8gzKyaoIgXpDwnwo+NUIe
	vt5QK4Xw+XlT4pqbZ+Mf103CeZirYzFLw99lcpKiIg7RunOYa/z3SFr7tYaNXU6uq4gxiiw+n9Y
	s4vYIbiv2LB+ghYL8
X-Received: by 2002:a05:620a:880f:b0:75b:23a1:363d with SMTP id qj15-20020a05620a880f00b0075b23a1363dmr20468176qkn.78.1687793052464;
        Mon, 26 Jun 2023 08:24:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67krRALDwbYzxNGPfYizrvdl7LS+HU+avZAWHRkye9gBvomn4n/ypyeI8Y0aTbS2T5cmmDUw==
X-Received: by 2002:a05:620a:880f:b0:75b:23a1:363d with SMTP id qj15-20020a05620a880f00b0075b23a1363dmr20468165qkn.78.1687793052227;
        Mon, 26 Jun 2023 08:24:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b007579ea33cdesm2785460qki.62.2023.06.26.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:24:11 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:24:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 02/17] vhost/vsock: read data from non-linear skb
Message-ID: <vpcrdclcic7oiuat4oapnkj54dolld6hh2wixe3fozlthyt2ni@omyjyem3uj3t>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-3-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-3-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:24PM +0300, Arseniy Krasnov wrote:
>This adds copying to guest's virtio buffers from non-linear skbs. Such
>skbs are created by protocol layer when MSG_ZEROCOPY flags is used. It
>changes call of 'copy_to_iter()' to 'skb_copy_datagram_iter()'. Second
>function can read data from non-linear skb.
>
>See commit to 'net/vmw_vsock/virtio_transport_common.c' with the same
>name for more details.

I think it's okay if we report the same details here.

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 6578db78f0ae..b254aa4b756a 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -156,7 +156,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
>-		payload_len = skb->len;
>+		payload_len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off;

Also here a variable should make the code more readable.

Stefano

> 		hdr = virtio_vsock_hdr(skb);
>
> 		/* If the packet is greater than the space available in the
>@@ -197,8 +197,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			break;
> 		}
>
>-		nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
>-		if (nbytes != payload_len) {
>+		if (skb_copy_datagram_iter(skb,
>+					   VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+					   &iov_iter,
>+					   payload_len)) {
> 			kfree_skb(skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
>@@ -212,13 +214,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> 		added = true;
>
>-		skb_pull(skb, payload_len);
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += payload_len;
> 		total_len += payload_len;
>
> 		/* If we didn't send all the payload we can requeue the packet
> 		 * to send it with the next available buffer.
> 		 */
>-		if (skb->len > 0) {
>+		if (VIRTIO_VSOCK_SKB_CB(skb)->frag_off < skb->len) {
> 			hdr->flags |= cpu_to_le32(flags_to_restore);
>
> 			/* We are queueing the same skb to handle
>-- 
>2.25.1
>


