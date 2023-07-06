Return-Path: <netdev+bounces-15845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4374A26D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBAA280AC4
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408CAD53;
	Thu,  6 Jul 2023 16:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C28F65
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:47:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA221BD3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CIjV3nrO4jNdql8yp29S+96UpDACpGjeOguVgyJZq6o=;
	b=fKK2bspkT+qVUAjRgYONxhA206wLU1mbjz1ZATdpQPUvPDEOE4fXIpEbExhjffcjUinaLe
	zN0670lagnnwN2GYNyR3h742CJ1dA7hZSI6zvZPK09qxKozCPREvmA1cZUCkqsRvm64nOy
	3lpJ6rVR2vxvjXsi8RgHB+hFF+h1QKY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-UCgf3F5BPIOlOvMhxn-_eA-1; Thu, 06 Jul 2023 12:47:55 -0400
X-MC-Unique: UCgf3F5BPIOlOvMhxn-_eA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50a16ab50e6so625055a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662074; x=1691254074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIjV3nrO4jNdql8yp29S+96UpDACpGjeOguVgyJZq6o=;
        b=L+pEwsZE0nME9x/H7QlnhjVZZDUvLzlq9WoJcoDUNIO+Ul+hIApSjuDs9mwulnOoSg
         WF6xDtceLbCJeixvJvMiZtmYnaWFtssfbaEF99s69XAlOfYc2n4gmK5U9ehmws+PV7i2
         GbNNhOAa1VeowtuQAXUOiiwNRhVvPvMyATKp3f9bzBNkjneEiJWzuwYZ7VV8ks4p4Khm
         J0yb9VjQj6XgtII/GwmwwSrChdY2XHV8s1jBpPDCwOnkrZMxlQ7EjdUPwaYPgeDyZhLA
         Dfdxvh9T6nuPuVa5evG2JJbCOImd0TpEJujmiGIu4xKfpeUjrTTzimC1JULRwrFPoLlg
         +sGw==
X-Gm-Message-State: ABy/qLZ4XcKJ0A30QBVvhVlHd6u16n+FkEoq0Bet1ZuXdexQmd69XAZH
	tvVAgULaMm6fkHT1xtyokVx6Ad0SEPntyayv8uLvdCTUKDYimdbQURgkRmcNN2rgQCYZWaS/UwE
	1EkT2uL36sfqMR2VZoibxJD24
X-Received: by 2002:a50:ec99:0:b0:51d:f74c:1d44 with SMTP id e25-20020a50ec99000000b0051df74c1d44mr2453335edr.31.1688662074128;
        Thu, 06 Jul 2023 09:47:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsgBZKktKUKDnMD4AGXhJM/rSYMTYzoTBTMz/PUfXFIbgHcwyix502QSKdumliEmlDeazbpg==
X-Received: by 2002:a50:ec99:0:b0:51d:f74c:1d44 with SMTP id e25-20020a50ec99000000b0051df74c1d44mr2453315edr.31.1688662073762;
        Thu, 06 Jul 2023 09:47:53 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id i22-20020aa7c716000000b0051df13f1d8fsm973950edq.71.2023.07.06.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:47:53 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:47:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 01/17] vsock/virtio: read data from non-linear skb
Message-ID: <xz2elkpzzgn6zfm2e7lpognwgwm3leexyjm65qn54xwxlvbxmb@l5mhnorcbuez>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-2-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-2-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:31AM +0300, Arseniy Krasnov wrote:
>This is preparation patch for non-linear skbuff handling. It replaces
>direct calls of 'memcpy_to_msg()' with 'skb_copy_datagram_iter()'. Main
>advantage of the second one is that is can handle paged part of the skb

s/is that is/is that it/

>by using 'kmap()' on each page, but if there are no pages in the skb,
>it behaves like simple copying to iov iterator. This patch also adds
>new field to the control block of skb - this value shows current offset
>in the skb to read next portion of data (it doesn't matter linear it or
>not). Idea is that 'skb_copy_datagram_iter()' handles both types of
>skb internally - it just needs an offset from which to copy data from
>the given skb. This offset is incremented on each read from skb. This
>approach allows to avoid special handling of non-linear skbs:
>1) We can't call 'skb_pull()' on it, because it updates 'data' pointer.
>2) We need to update 'data_len' also on each read from this skb.

I would mention that this change is in preparation of zero-copy support.

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Use local variable for 'frag_off' in stream dequeue calback.
>  * R-b from Bobby Eshleman removed due to patch update.
>
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 30 ++++++++++++++++++-------
> 2 files changed, 23 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c58453699ee9..17dbb7176e37 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -12,6 +12,7 @@
> struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
>+	u32 frag_off;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..e5683af23e60 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -355,7 +355,7 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 	spin_lock_bh(&vvs->rx_lock);
>
> 	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+		off = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>
> 		if (total == len)
> 			break;
>@@ -370,7 +370,10 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 			 */
> 			spin_unlock_bh(&vvs->rx_lock);
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>+			err = skb_copy_datagram_iter(skb, off,
>+						     &msg->msg_iter,
>+						     bytes);
>+
> 			if (err)
> 				goto out;
>
>@@ -411,27 +414,35 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	}
>
> 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
>+		u32 skb_rest_len;
>+
> 		skb = skb_peek(&vvs->rx_queue);
>
> 		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		skb_rest_len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>+
>+		if (bytes > skb_rest_len)
>+			bytes = skb_rest_len;

What about just:
		bytes = min_t(size_t, len - total,
			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off);

The rest LGTM!

Stefano

>
> 		/* sk_lock is held by caller so no one else can dequeue.
> 		 * Unlock rx_lock since memcpy_to_msg() may sleep.
> 		 */
> 		spin_unlock_bh(&vvs->rx_lock);
>
>-		err = memcpy_to_msg(msg, skb->data, bytes);
>+		err = skb_copy_datagram_iter(skb,
>+					     VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+					     &msg->msg_iter, bytes);
>+
> 		if (err)
> 			goto out;
>
> 		spin_lock_bh(&vvs->rx_lock);
>
> 		total += bytes;
>-		skb_pull(skb, bytes);
>
>-		if (skb->len == 0) {
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += bytes;
>+
>+		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->frag_off) {
> 			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>
> 			virtio_transport_dec_rx_pkt(vvs, pkt_len);
>@@ -503,7 +514,10 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 				 */
> 				spin_unlock_bh(&vvs->rx_lock);
>
>-				err = memcpy_to_msg(msg, skb->data, bytes_to_copy);
>+				err = skb_copy_datagram_iter(skb, 0,
>+							     &msg->msg_iter,
>+							     bytes_to_copy);
>+
> 				if (err) {
> 					/* Copy of message failed. Rest of
> 					 * fragments will be freed without copy.
>-- 
>2.25.1
>


