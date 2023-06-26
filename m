Return-Path: <netdev+bounces-14000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D6073E4FF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F56280E2F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83A11CAE;
	Mon, 26 Jun 2023 16:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336F101D6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:28:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A75171D
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687796932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4O/2NH0yzSJoeQQqIwYX3nixVBwHLA7LkW0cO2CrI0s=;
	b=YK1SCIj9a5n3izhSThO4IbGQEGlhHC6kjOLYdM/JC8ZFdygcgrKhST72LnnveszPJunvf9
	/tQGkkG+fq298f/YpbIRantyqN8dc+wsKjp71AE+jHL0EvT6hiqQthls8QRSN5cqohXaxJ
	hm4Qgmt7iWu+i14qgpvcbLxhImL8BFw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-sYbBhgV5NyyfozrvIabAMQ-1; Mon, 26 Jun 2023 12:28:41 -0400
X-MC-Unique: sYbBhgV5NyyfozrvIabAMQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765a6bbdd17so144258485a.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796916; x=1690388916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O/2NH0yzSJoeQQqIwYX3nixVBwHLA7LkW0cO2CrI0s=;
        b=W1r17RVt9yiDTGDoR4rjgVTB2h6EmEdE3lGi6kprEoDIKH4iENkItp9VjqrdDW2kde
         EbJL3kEQZDe6gLg1S57Zda8T2BEEqo6xkenRgkFmBWP3rxoJDEexpZ+F1QdvS1ogfb/N
         ZBN4RjnLbpdXjbsJyQisUYR/IYVkrbxbXoXBEXjjVBhNJ1NkgmGsLcz+fot6ZckPklXC
         p4KMeuHRZhIUIdNgEHGhxWw+sitI6oJsDnbbtJJopYCDw2KROtXUk0H9SWIJpU9AvTlK
         pB4tRTylivhpgp7XryGsBZQvzdZIF4TqczPDQRnYYGINQFd+OxWER1Ecd+eaNxo9mnfB
         KYUg==
X-Gm-Message-State: AC+VfDx14rUELKb4DQO4jWXy7iw0AOj/4A7P//8+zfOP3whp/G8MToHo
	0FUY712N92qnB3QtK9dgSMv9DD6CuBeuYqobEj5u2CqjNIRtPNs2LgWXXmltvxCEtu9Y2vIe4/7
	+OuTv/z5KLTYvECmN
X-Received: by 2002:a05:620a:1a93:b0:763:9e59:5f72 with SMTP id bl19-20020a05620a1a9300b007639e595f72mr25681285qkb.41.1687796916285;
        Mon, 26 Jun 2023 09:28:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5x5ugD0TqhCXgVw9va06ED6hrsB+ZQed5/Tu0Pg5AhOHB/hmdqOV0biY+XBPnHF/pES4ZZUQ==
X-Received: by 2002:a05:620a:1a93:b0:763:9e59:5f72 with SMTP id bl19-20020a05620a1a9300b007639e595f72mr25681263qkb.41.1687796916050;
        Mon, 26 Jun 2023 09:28:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id oo25-20020a05620a531900b0075c9abecdf8sm2877975qkn.1.2023.06.26.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:28:35 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:28:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <yiy3kssoiyzs6ehnlo7g2xsb26zee5vih3jpgyc7i3dvfcyfpv@xvokxez3lzpo>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
 <20230618062451.79980-3-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230618062451.79980-3-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 18, 2023 at 09:24:49AM +0300, Arseniy Krasnov wrote:
>This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>Difference with SOCK_STREAM is that this callback returns either length
>of the message or error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
> 1 file changed, 60 insertions(+), 3 deletions(-)
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

Should we return the minimum between total and len?

Thanks,
Stefano

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


