Return-Path: <netdev+bounces-20732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27CC760CCC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EABD2817F1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788813AF2;
	Tue, 25 Jul 2023 08:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA80134A3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:18:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093E10C3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690273083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yzqiXhC1UF6kcx0o3Qs1VmhKMD7xafUTqbIR8LZgYk=;
	b=HySbZRwszuaN2E1+A3ae8Ra/sk0h8tlmrHDv7TWPB5IxaFbTU/3qSHLO5fqi2CMI8liDvF
	fK0gM0YjKbpuo2HqQq7WY1pE+UIWmA6/vhw6xR6Z9clRxQJ8zzgou8SP7QVgp3q4RZvUHs
	HqiS9Ue2fpEi1QYLJlr6ub0BkqwPscg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-lNRDZiEwPJy_yyUVy7N8xA-1; Tue, 25 Jul 2023 04:18:01 -0400
X-MC-Unique: lNRDZiEwPJy_yyUVy7N8xA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3176ace3f58so237607f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273080; x=1690877880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yzqiXhC1UF6kcx0o3Qs1VmhKMD7xafUTqbIR8LZgYk=;
        b=WFQzpgBoryo2BsbizwAcSNGFbnI2i3hk4uLg+bOIrirezsAmCAqTccrScOFFgoSH98
         F82VnKQYRRyJYAFaXghN1Bh0SN3GL0HcHiminQ0KIXTLkKJMzv4s9F83o57IVvum/hD9
         AMV4fUMU4hPt3O5TassXS45HTcVAInEC34VbdVFIhq0DHkXualQWyoZyyaElgxYM3M0m
         srpxk3WwlSj2bTy4HYGBu3EaY1ZuYVxbHZtYid/BVr11Y5kOqCtIhSLZr8tB2ur69Ks6
         9YmRcrHolN7cReoK9EZkF6HveVbpYp5AqXfhCjmmrNTZc1IYHhav2oQr0tpKomWjEJ8A
         5+Uw==
X-Gm-Message-State: ABy/qLZFX1eHW7u20etgt++UOW7sYem90aerKpz+n58f63pHElkFNZvX
	n7r6RJ/L888Pch+jQ7STAqgOu7x2W3ghPz+IGEeN7sah9oO81TnWiHDMc+dnT4oyZbtEZxloOGr
	gCrLTBwxhwp8ndYlr
X-Received: by 2002:a5d:6507:0:b0:313:ef96:84c8 with SMTP id x7-20020a5d6507000000b00313ef9684c8mr8687885wru.67.1690273080448;
        Tue, 25 Jul 2023 01:18:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPc/VAU250QGQYgpOMkW4RaBwKVZ3ddrW1YR4h8aiQOpLSV8Prs3MtGQBtJV+o8e48BrZ/aw==
X-Received: by 2002:a5d:6507:0:b0:313:ef96:84c8 with SMTP id x7-20020a5d6507000000b00313ef9684c8mr8687872wru.67.1690273080102;
        Tue, 25 Jul 2023 01:18:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.123])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm15506412wrr.109.2023.07.25.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:17:59 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:17:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <5lemb27slnjt3hieixwa744ghzu6zj5fc3eimfng7a2ba7y2as@ueve2vn2cxpl>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-3-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230720214245.457298-3-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 12:42:43AM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> Changelog:
> v2 -> v3:
>  * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>    as this change is quiet small I guess.

Ack!

Thanks,
Stefano

>
> net/vmw_vsock/virtio_transport.c | 41 +++++++++++++++++++++++++++-----
> 1 file changed, 35 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..7bbcc8093e51 100644
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
>@@ -111,12 +113,39 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
>+		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
>+			    sizeof(*virtio_vsock_hdr(skb)));
>+		sgs[out_sg] = &bufs[out_sg];
>+		out_sg++;
>+
>+		if (!skb_is_nonlinear(skb)) {
>+			if (skb->len > 0) {
>+				sg_init_one(&bufs[out_sg], skb->data, skb->len);
>+				sgs[out_sg] = &bufs[out_sg];
>+				out_sg++;
>+			}
>+		} else {
>+			struct skb_shared_info *si;
>+			int i;
>+
>+			si = skb_shinfo(skb);
>+
>+			for (i = 0; i < si->nr_frags; i++) {
>+				skb_frag_t *skb_frag = &si->frags[i];
>+				void *va;
>
>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
>+				/* We will use 'page_to_virt()' for the userspace page
>+				 * here, because virtio or dma-mapping layers will call
>+				 * 'virt_to_phys()' later to fill the buffer descriptor.
>+				 * We don't touch memory at "virtual" address of this page.
>+				 */
>+				va = page_to_virt(skb_frag->bv_page);
>+				sg_init_one(&bufs[out_sg],
>+					    va + skb_frag->bv_offset,
>+					    skb_frag->bv_len);
>+				sgs[out_sg] = &bufs[out_sg];
>+				out_sg++;
>+			}
> 		}
>
> 		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>-- 
>2.25.1
>


