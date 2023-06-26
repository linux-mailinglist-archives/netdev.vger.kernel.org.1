Return-Path: <netdev+bounces-13967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6DA73E380
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7978A2805D3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA78C12D;
	Mon, 26 Jun 2023 15:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239FC2C1
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:37:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28353BA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687793821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71PcUdXHzfbmeSLaqcZwK2r6pjSreCaY9XzRHkKEiCA=;
	b=X9wnlP3SHxPJDeRuRmsuDmShukPHIoLjngX4QjxnXyAE0QhmY6glCT5eW66MgGUD/GWU1R
	BqxMhaKJ4LW5sgQRSo1yvtOEF9XUgL+rMsbZq7HVLsUNeR+xpSgVJg00QxSHo649Xkzmws
	Wkt2seGEXepgbqEzrPDEKkeILcAMOwY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230--Ld5YMWlNbeArmwI3yyZTA-1; Mon, 26 Jun 2023 11:36:58 -0400
X-MC-Unique: -Ld5YMWlNbeArmwI3yyZTA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62e85844711so35086896d6.2
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 08:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793817; x=1690385817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71PcUdXHzfbmeSLaqcZwK2r6pjSreCaY9XzRHkKEiCA=;
        b=hh+FU7IeMlIv2M5yBxMrlQSro9HSyemsQlizthUKpJoRUr7iLA2mdX4tAc/2FqQf8g
         zbcYWnrFDwaY0WL9+L5EQzQAiySAfSg66GgXiKmYBBxGWwGilH7jzu8Fyfb8+iagyVG/
         FLqMfyruvhYJXH4yiGUW6TN8YSgqO7s/Pg8Zx9eh5R2FqTuLsjuHhuAO0wuVWy7zstTj
         rk7vFzsJ9iRFcPE7Q92G3vYZdQW33FLsTrK+q0KkCZ7dVEoB/yEpvG0YfeTNII75Bpqy
         jDKiwn/tvTs7vDgTVPGve/VMwaCLu+cppCmiKDFcfD8OaaJMK3WmH3DE8cA7Njx1PlgJ
         qNFA==
X-Gm-Message-State: AC+VfDyu/jTbRieUyrVp3ZsRBKvEcMwp66F/OlPSU9oXBnZws/BC1SeA
	dzH3XJdYSjf6WBU5Ttlf1c2pzYFmHKRsceCgylkSYDfk/AHV9v5u+hykWJ2JT81YT9QrlHms4Qy
	HBrzEAcfflsT6cAdD
X-Received: by 2002:a05:6214:2346:b0:62f:f13e:bd73 with SMTP id hu6-20020a056214234600b0062ff13ebd73mr39396838qvb.20.1687793817546;
        Mon, 26 Jun 2023 08:36:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40I5NnfBD7e9UXdCL5E/tGBEB8QeoD2KkkaZxvewAgMci79nu2OXGaIhbm0FmSDkshqOeiBQ==
X-Received: by 2002:a05:6214:2346:b0:62f:f13e:bd73 with SMTP id hu6-20020a056214234600b0062ff13ebd73mr39396823qvb.20.1687793817297;
        Mon, 26 Jun 2023 08:36:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id dd12-20020ad4580c000000b00632191a70aesm3299770qvb.88.2023.06.26.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:36:56 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:36:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 03/17] vsock/virtio: support to send non-linear skb
Message-ID: <3lg4apldxdrpbkgfa2o4wxe4qyayj2h7b2lfcw3q5a7u3hnofi@z2ifmmzt4xpc>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:25PM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport.c | 37 ++++++++++++++++++++++++++------
> 1 file changed, 31 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..6053d8341091 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 	vq = vsock->vqs[VSOCK_VQ_TX];
>
> 	for (;;) {
>-		struct scatterlist hdr, buf, *sgs[2];
>+		/* +1 is for packet header. */
>+		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>+		struct scatterlist bufs[MAX_SKB_FRAGS + 1];
> 		int ret, in_sg = 0, out_sg = 0;
> 		struct sk_buff *skb;
> 		bool reply;
>@@ -111,12 +113,35 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
>+		sg_init_one(&bufs[0], virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>+		sgs[out_sg++] = &bufs[0];

Can we use out_sg also to index bufs (here and in the rest of the code)?

E.g.

		sg_init_one(&bufs[out_sg], ...)
		sgs[out_sg] = &bufs[out_sg];
		++out_sg;

		...
			if (skb->len > 0) {
				sg_init_one(&bufs[out_sg], skb->data, skb->len);
				sgs[out_sg] = &bufs[out_sg];
				++out_sg;
			}

		etc...

>+

For readability, I would move the smaller branch above:

		if (!skb_is_nonlinear(skb)) {
			// small block
			...
		} else {
			// big block
			...
		}

>+		if (skb_is_nonlinear(skb)) {
>+			struct skb_shared_info *si;
>+			int i;
>+
>+			si = skb_shinfo(skb);
>+
>+			for (i = 0; i < si->nr_frags; i++) {
>+				skb_frag_t *skb_frag = &si->frags[i];
>+				void *va = page_to_virt(skb_frag->bv_page);
>+
>+				/* We will use 'page_to_virt()' for userspace page here,
>+				 * because virtio layer will call 'virt_to_phys()' later
>+				 * to fill buffer descriptor. We don't touch memory at
>+				 * "virtual" address of this page.
>+				 */
>+				sg_init_one(&bufs[i + 1],
>+					    va + skb_frag->bv_offset,
>+					    skb_frag->bv_len);
>+				sgs[out_sg++] = &bufs[i + 1];
>+			}
>+		} else {
>+			if (skb->len > 0) {

Should we do the same check (skb->len > 0) for nonlinear skb as well?
Or do the nonlinear ones necessarily have len > 0?

>+				sg_init_one(&bufs[1], skb->data, skb->len);
>+				sgs[out_sg++] = &bufs[1];
>+			}
>
    ^
Blank line that we can remove.

Stefano

>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
> 		}
>
> 		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>-- 
>2.25.1
>


