Return-Path: <netdev+bounces-15848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4574A27E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B21C20DB0
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426FAD58;
	Thu,  6 Jul 2023 16:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429CBA23
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:51:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE751FCD
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lY92+ddtv43Js0GKJTCX1QniXKfhiDq46fV1jZcI+8=;
	b=Bj0ucICt/onfvxHKN45HfGrBZ5E6VLStsuFldGwzIHoXeclm114G+PGN44R3IE4pIEqQeP
	zS8BEAxXPb82tyuQlTJC3qXuJcnWdkLisnnqqTL/MtzsawbyEIFxRDKMev1/n620pasEdM
	mpkCVqPOTVk2rsmdt2cvzvlaH/E6WF8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Eq3RI8tQOcmCIzCT8H2vSQ-1; Thu, 06 Jul 2023 12:51:06 -0400
X-MC-Unique: Eq3RI8tQOcmCIzCT8H2vSQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355c9028so63605366b.3
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662265; x=1691254265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lY92+ddtv43Js0GKJTCX1QniXKfhiDq46fV1jZcI+8=;
        b=RH7Fzh1yyqI4xZi4N8pDKXZaXkVRPmXFu67dKCTz/z3i2xMJveh0o2dFHgg9q3vrwF
         wDWnXBJvNNct0sL1OFD1ScYGRXckg4jhjZbcZiSmurWMK0qM/9sAFH8ihd1bXRG+UknP
         IEFZZNp7ALMRTWw5/ddWSts7xql96Cs5WLJwwwlaPvmeVdb0isEbixxiibhNAPfKVw2Z
         W8HcN6RHSUOMdmZCNkjKY/nmTBm13oUdSYOwX4D3GguDzY7lgEOjPsnYzzMtqrHxCiXR
         nLHbtHS7/F2P7paRLlzQ5qZ55P/cXDG8hL0IFPZROvuH+wUMLlbvfKlPpHx4UFlhrlG9
         iRyQ==
X-Gm-Message-State: ABy/qLb10veLa0STAIiNvv80Ijoe5+7b4bYQXrm5N1StUNUXrI305eBe
	G6xDNxQnAXRC8nH+eHT5VlwU4hnKf4bBJqmOXyINh7Wl/TOLYLXIXoRqhegn94rhqRNn2AtxVI6
	WLbv9UipJtwbq9BEP+cjga53i
X-Received: by 2002:a17:906:7046:b0:992:b9f4:85db with SMTP id r6-20020a170906704600b00992b9f485dbmr1815350ejj.39.1688662264981;
        Thu, 06 Jul 2023 09:51:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqgmU14xEa56II5zxLyRGIPXThOhEyLQmB+kMCm8D12EMDJhS0ZJLYiNGRDuHhor0mACYvpg==
X-Received: by 2002:a17:906:7046:b0:992:b9f4:85db with SMTP id r6-20020a170906704600b00992b9f485dbmr1815324ejj.39.1688662264645;
        Thu, 06 Jul 2023 09:51:04 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b0096f7500502csm1023286ejd.199.2023.07.06.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:51:04 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:51:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 03/17] vsock/virtio: support to send non-linear skb
Message-ID: <joml4wolu5r2wpetvbfezu6buwfnfntu5okxjacfgdsp7uaebk@onkmwg7r7fod>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-4-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-4-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:33AM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Use 'out_sgs' variable to index 'bufs', not only 'sgs'.
>  * Move smaller branch above, see 'if (!skb_is_nonlinear(skb)').
>  * Remove blank line.
>  * R-b from Bobby Eshleman removed due to patch update.
>
> net/vmw_vsock/virtio_transport.c | 40 +++++++++++++++++++++++++++-----
> 1 file changed, 34 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..6cbb45bb12d2 100644
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
>@@ -111,12 +113,38 @@ virtio_transport_send_pkt_work(struct work_struct *work)
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
>+				void *va = page_to_virt(skb_frag->bv_page);
>
>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
>+				/* We will use 'page_to_virt()' for userspace page here,
>+				 * because virtio layer will call 'virt_to_phys()' later
>+				 * to fill buffer descriptor. We don't touch memory at
>+				 * "virtual" address of this page.
>+				 */
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


