Return-Path: <netdev+bounces-20897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A88761D7A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D892B1C20EEB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FC23BE3;
	Tue, 25 Jul 2023 15:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975F1F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 15:39:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172F1FD2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690299579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hl7TlGBY8KC9fCz4U38u+w32QQOwR9hjmIKn/+TtjDc=;
	b=JFw/mf6BAqOtHghRikFI0lG54Y4iKmaaoslTNFB/YDZcU0WvlmQ2/u2nrISPb3eC++rCx4
	cT68kAx1Jr3yPx5bM29F6NJ5XoSmOb4mwmgC5gL2NWcPIFY1eHwF8K+EFzAU51ohvzZ9dW
	Vdb/AjjnQear3spVy58zkOF/arwGSfQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-FMI1KvZNMICs2Hw1nC6Dfg-1; Tue, 25 Jul 2023 11:39:36 -0400
X-MC-Unique: FMI1KvZNMICs2Hw1nC6Dfg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-403ad9d7951so71398481cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299576; x=1690904376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl7TlGBY8KC9fCz4U38u+w32QQOwR9hjmIKn/+TtjDc=;
        b=BAEwrfu6ZV9enalWhKPbbWIatFPqfr4g6MPJtzp4hM2flO6yXnrl7zCYMCKrMDk2/O
         oPvuRKJm20YxJSq/UMV8aR38j6a+/HhbzQ49rzfj9IHv7pqILWBQzYUytDxv9micoAUD
         tc8JQR8e3i+Y8JWWvm/syRm2alzhYU3Vrcc8+3c80R5ZZvzj8Jt7ji2zkT2hJC9d9jx0
         omrW55DzIdxeAOWsXUsTDgV7XhX4xMO5f+rScbCJ3GrbphBxnGaY/rE55idtihw5sFoc
         2L4Uge5bwS3oZf6+ysf57I4DaXO25Xmrf3S5hgRWYazebB05yvzgO7l81QRG0RpaUuUB
         JNtA==
X-Gm-Message-State: ABy/qLbQHNlsr7DgzehdwU03gS434/n8w7iaHMEq9Dv+ljsgOpWTekAh
	6p23ZitbW591GvNQLJhZs64fYAhsMwdaZOyTCR8RC5HBnzwoDBGE+J/4NWbbNZdaNINkVje/V5X
	DrGD9fXmghIZpvDSQ
X-Received: by 2002:a05:622a:1013:b0:402:76e3:59f6 with SMTP id d19-20020a05622a101300b0040276e359f6mr3746329qte.9.1690299576272;
        Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPTRjdLNSLA8c7aE0osG3x1L3hWBx5nQgehQrRb2Vj3GyGN/3UVxsy9bokM2ED6bC9iQzVnw==
X-Received: by 2002:a05:622a:1013:b0:402:76e3:59f6 with SMTP id d19-20020a05622a101300b0040276e359f6mr3746308qte.9.1690299576067;
        Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
        by smtp.gmail.com with ESMTPSA id s21-20020ac85ed5000000b00403b44bc230sm4085933qtx.95.2023.07.25.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:39:35 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:39:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <hwdcuy3wwlrirpgphlex6omdnrztz7hqhu4447nmqml5sjqx5x@7y45zuyto7yq>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-3-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719192708.1775162-3-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:27:06PM +0300, Arseniy Krasnov wrote:
>This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>Difference with SOCK_STREAM is that this callback returns either length
>of the message or error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
> 1 file changed, 60 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 2ee40574c339..352d042b130b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -460,6 +460,63 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static ssize_t
>+virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
>+				   struct msghdr *msg)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct sk_buff *skb;
>+	size_t total, len;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (!vvs->msg_count) {
>+		spin_unlock_bh(&vvs->rx_lock);
>+		return 0;
>+	}
>+
>+	total = 0;
>+	len = msg_data_left(msg);
>+
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		struct virtio_vsock_hdr *hdr;
>+
>+		if (total < len) {
>+			size_t bytes;
>+			int err;
>+
>+			bytes = len - total;
>+			if (bytes > skb->len)
>+				bytes = skb->len;
>+
>+			spin_unlock_bh(&vvs->rx_lock);
>+
>+			/* sk_lock is held by caller so no one else can dequeue.
>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+			 */
>+			err = memcpy_to_msg(msg, skb->data, bytes);
>+			if (err)
>+				return err;
>+
>+			spin_lock_bh(&vvs->rx_lock);
>+		}
>+
>+		total += skb->len;
>+		hdr = virtio_vsock_hdr(skb);
>+
>+		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
>+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
>+				msg->msg_flags |= MSG_EOR;
>+
>+			break;
>+		}
>+	}
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	return total;
>+}
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 int flags)
>@@ -554,9 +611,9 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   int flags)
> {
> 	if (flags & MSG_PEEK)
>-		return -EOPNOTSUPP;
>-
>-	return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>+		return virtio_transport_seqpacket_do_peek(vsk, msg);
>+	else
>+		return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>-- 
>2.25.1
>


