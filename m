Return-Path: <netdev+bounces-52654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF07FF94E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5061C20C0B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD559172;
	Thu, 30 Nov 2023 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuMvlF2X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A57D6C
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701368848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RZA0GAnzMmQmnt7J4v4F0BWd31On6guabFGK6t1c+KI=;
	b=YuMvlF2XagICl/diVYIMMCkMqGup0zcNYcKxo6+tFEFItD+8nTp1rRlF/de5qR6UBV1V7j
	mOikr5uyqW4526oo1HanleoJUEwsNbheaVWgB4WjhAyyGs/B/tqBeYkzrS1bmLKY6cZlrn
	o7AjvQZ9Ty9DVkOYUPly3p4pgRQuUWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-I6TKYoq2NtOklvhEbMEWgA-1; Thu, 30 Nov 2023 13:27:27 -0500
X-MC-Unique: I6TKYoq2NtOklvhEbMEWgA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332efd3aa1fso1060158f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368846; x=1701973646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZA0GAnzMmQmnt7J4v4F0BWd31On6guabFGK6t1c+KI=;
        b=jqbUmEAduE+Jb91PT0+QO7LvN5Q8uZ8+lUysYYIh7shV5HhNCs+mO9PX+jmqKv0wC1
         UkSYTAmH0hUQ7EbNKOUkRGO1IxUA0m9L8CegtdsPuW0W64k85PKDGu32zbUsov3NFTCD
         MdfNuyENhn5aXbf2z9F8cMBCQf1tZLrsJ3X/ty4EvxJzgLnYPZ0macufqlw28Cs4lg8y
         oK8cqirgb7pe1iyC4ZWspbwlV9BpUp1axkXnbx+JiIlnSp4WxoTXf4jlg642tFVLHqU2
         VOAKc0WpSq5edyVXhrckZzIAm0cNZHr2ywVUl/uw0ismNf2fF3fBfQGhrAflIqNJKNwv
         BcQw==
X-Gm-Message-State: AOJu0YyBK99SaODpszY+CoKwhtSWfU7F90BWv0oeGeqB/0XQVu1HeNrZ
	X4rIS95BuJK4S84oRfXZYgmNycrBJITtocJY5JVGoQs7Ew0Xab5nmddC0ug7U3qD6093zKVNHwM
	DlkeOUmla3hq9cVzb
X-Received: by 2002:a05:6000:11c7:b0:332:f578:8763 with SMTP id i7-20020a05600011c700b00332f5788763mr16287wrx.58.1701366377632;
        Thu, 30 Nov 2023 09:46:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJHdlKzDLGKZRCik8JIeZpJ/scQ9w1/+X1RYF1icQUTtUJPu1cnWdj/y1c9yXcUWnqvcXUQg==
X-Received: by 2002:a05:600c:4e87:b0:40b:4fd5:2b31 with SMTP id f7-20020a05600c4e8700b0040b4fd52b31mr2100wmq.36.1701366048081;
        Thu, 30 Nov 2023 09:40:48 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b0040b34409d43sm2727966wms.11.2023.11.30.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:40:47 -0800 (PST)
Date: Thu, 30 Nov 2023 12:40:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v5 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <20231130123815-mutt-send-email-mst@kernel.org>
References: <20231130130840.253733-1-avkrasnov@salutedevices.com>
 <20231130130840.253733-3-avkrasnov@salutedevices.com>
 <20231130084044-mutt-send-email-mst@kernel.org>
 <02de8982-ec4a-b3b2-e8e5-1bca28cfc01b@salutedevices.com>
 <20231130085445-mutt-send-email-mst@kernel.org>
 <pbkiwezwlf6dmogx7exur6tjrtcfzxyn7eqlehqxivqifbkojv@xlziiuzekon4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pbkiwezwlf6dmogx7exur6tjrtcfzxyn7eqlehqxivqifbkojv@xlziiuzekon4>

On Thu, Nov 30, 2023 at 03:11:19PM +0100, Stefano Garzarella wrote:
> On Thu, Nov 30, 2023 at 08:58:58AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 30, 2023 at 04:43:34PM +0300, Arseniy Krasnov wrote:
> > > 
> > > 
> > > On 30.11.2023 16:42, Michael S. Tsirkin wrote:
> > > > On Thu, Nov 30, 2023 at 04:08:39PM +0300, Arseniy Krasnov wrote:
> > > >> Send credit update message when SO_RCVLOWAT is updated and it is bigger
> > > >> than number of bytes in rx queue. It is needed, because 'poll()' will
> > > >> wait until number of bytes in rx queue will be not smaller than
> > > >> SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
> > > >> for tx/rx is possible: sender waits for free space and receiver is
> > > >> waiting data in 'poll()'.
> > > >>
> > > >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > > >> ---
> > > >>  Changelog:
> > > >>  v1 -> v2:
> > > >>   * Update commit message by removing 'This patch adds XXX' manner.
> > > >>   * Do not initialize 'send_update' variable - set it directly during
> > > >>     first usage.
> > > >>  v3 -> v4:
> > > >>   * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
> > > >>  v4 -> v5:
> > > >>   * Do not change callbacks order in transport structures.
> > > >>
> > > >>  drivers/vhost/vsock.c                   |  1 +
> > > >>  include/linux/virtio_vsock.h            |  1 +
> > > >>  net/vmw_vsock/virtio_transport.c        |  1 +
> > > >>  net/vmw_vsock/virtio_transport_common.c | 27 +++++++++++++++++++++++++
> > > >>  net/vmw_vsock/vsock_loopback.c          |  1 +
> > > >>  5 files changed, 31 insertions(+)
> > > >>
> > > >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > >> index f75731396b7e..4146f80db8ac 100644
> > > >> --- a/drivers/vhost/vsock.c
> > > >> +++ b/drivers/vhost/vsock.c
> > > >> @@ -451,6 +451,7 @@ static struct virtio_transport vhost_transport = {
> > > >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> > > >>
> > > >>  		.read_skb = virtio_transport_read_skb,
> > > >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> > > >>  	},
> > > >>
> > > >>  	.send_pkt = vhost_transport_send_pkt,
> > > >> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > >> index ebb3ce63d64d..c82089dee0c8 100644
> > > >> --- a/include/linux/virtio_vsock.h
> > > >> +++ b/include/linux/virtio_vsock.h
> > > >> @@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > > >>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> > > >>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> > > >>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> > > >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> > > >>  #endif /* _LINUX_VIRTIO_VSOCK_H */
> > > >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > >> index af5bab1acee1..8007593a3a93 100644
> > > >> --- a/net/vmw_vsock/virtio_transport.c
> > > >> +++ b/net/vmw_vsock/virtio_transport.c
> > > >> @@ -539,6 +539,7 @@ static struct virtio_transport virtio_transport = {
> > > >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> > > >>
> > > >>  		.read_skb = virtio_transport_read_skb,
> > > >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> > > >>  	},
> > > >>
> > > >>  	.send_pkt = virtio_transport_send_pkt,
> > > >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > >> index f6dc896bf44c..1cb556ad4597 100644
> > > >> --- a/net/vmw_vsock/virtio_transport_common.c
> > > >> +++ b/net/vmw_vsock/virtio_transport_common.c
> > > >> @@ -1684,6 +1684,33 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> > > >>  }
> > > >>  EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
> > > >>
> > > >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk,
> > > >> int val)
> > > >> +{
> > > >> +	struct virtio_vsock_sock *vvs = vsk->trans;
> > > >> +	bool send_update;
> > > >> +
> > > >> +	spin_lock_bh(&vvs->rx_lock);
> > > >> +
> > > >> +	/* If number of available bytes is less than new SO_RCVLOWAT value,
> > > >> +	 * kick sender to send more data, because sender may sleep in
> > > >> its
> > > >> +	 * 'send()' syscall waiting for enough space at our side.
> > > >> +	 */
> > > >> +	send_update = vvs->rx_bytes < val;
> > > >> +
> > > >> +	spin_unlock_bh(&vvs->rx_lock);
> > > >> +
> > > >> +	if (send_update) {
> > > >> +		int err;
> > > >> +
> > > >> +		err = virtio_transport_send_credit_update(vsk);
> > > >> +		if (err < 0)
> > > >> +			return err;
> > > >> +	}
> > > >> +
> > > >> +	return 0;
> > > >> +}
> > > >
> > > >
> > > > I find it strange that this will send a credit update
> > > > even if nothing changed since this was called previously.
> > > > I'm not sure whether this is a problem protocol-wise,
> > > > but it certainly was not envisioned when the protocol was
> > > > built. WDYT?
> > > 
> > > >From virtio spec I found:
> > > 
> > > It is also valid to send a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet without previously receiving a
> > > VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows communicating updates any time a change
> > > in buffer space occurs.
> > > So I guess there is no limitations to send such type of packet, e.g. it is not
> > > required to be a reply for some another packet. Please, correct me if im wrong.
> > > 
> > > Thanks, Arseniy
> > 
> > 
> > Absolutely. My point was different - with this patch it is possible
> > that you are not adding any credits at all since the previous
> > VIRTIO_VSOCK_OP_CREDIT_UPDATE.
> 
> I think the problem we're solving here is that since as an optimization we
> avoid sending the update for every byte we consume, but we put a threshold,
> then we make sure we update the peer.
> 
> A credit update contains a snapshot and sending it the same as the previous
> one should not create any problem.

Well it consumes a buffer on the other side.

> My doubt now is that we only do this when we set RCVLOWAT , should we also
> do something when we consume bytes to avoid the optimization we have?
> 
> Stefano

Isn't this why we have credit request?

-- 
MST


