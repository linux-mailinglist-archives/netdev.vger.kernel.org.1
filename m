Return-Path: <netdev+bounces-15849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA274A281
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846661C20DFB
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF5CAD59;
	Thu,  6 Jul 2023 16:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2FBA23
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:51:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA171996
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awb+7AXpmYzXz/qezLtg4yD0Vv3mvjeFgM0SYmrlPEU=;
	b=ECbgPYYvL0f+cEVrAYRLS7+Eq52X+1K5XrenESByRP22dHdA1SsdiakWLGo1WEOo1ftxv/
	lk4yn3HvWbwAD65KoeqsYyXyMXNST3zK9KP9Wt5NU2O6vgckRqSxEPkIWoqm5OrftUg8Hx
	n8tVlLss4gDHljm0PekF8zbplc49+7Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382--5SCvw-aOU-TfviNTBjuFA-1; Thu, 06 Jul 2023 12:51:18 -0400
X-MC-Unique: -5SCvw-aOU-TfviNTBjuFA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so68955866b.2
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662277; x=1691254277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awb+7AXpmYzXz/qezLtg4yD0Vv3mvjeFgM0SYmrlPEU=;
        b=SW1cEy5LGN9Tmk1JiXutXsRHBjmwvhSSZFb7/rZYGuXcK6W1K4F2s5Dm36My5m/Zd2
         MIZgHMWxWMOpidFAwpHrW6NzS1Vo9YUztQRdtBzO/bv5xljocxI0DLUNqyOvPnazzmOe
         IzaU8qqZ0v4N72uoOkHjTdfjgRmSifPacXsVz5ABge6OvQRukmL9RbuApczJwgu4xMRt
         MkEW2gPTOf+NB/j2Rxmre2F12AIRtqJQWfvKuRu0qoMTjBZYXSdqwQ1f+j2jzWTBSuVs
         Lh8HVtedVHIUcJQ1usQ3/MkDTJyoC8Dhy9dXk/vCHu2uBW4z2OLCLV+7TLoDy+oqpXoX
         Ab6w==
X-Gm-Message-State: ABy/qLZ9kG9zQEImdRcRNZttoJS6s9PGXPGhtqHMfOgOrqapeUxAuwlL
	C2WGL6cNJ/ntwtU5U/c8ojBfFfTlTBIiY7cuPH22CrIgJBpjNtEmx13im0XjPeJGiz8zg307MYv
	YDDbENRnN/4BQeH+1
X-Received: by 2002:a17:906:7499:b0:992:630f:98b4 with SMTP id e25-20020a170906749900b00992630f98b4mr2090412ejl.7.1688662277386;
        Thu, 06 Jul 2023 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcjZ/elRu3NDEvZe9dL5bPtGnyqQvkazpE91J90ogdTAnM9Wru1mlG0RExbfNcoTXT5+NKlw==
X-Received: by 2002:a17:906:7499:b0:992:630f:98b4 with SMTP id e25-20020a170906749900b00992630f98b4mr2090395ejl.7.1688662276897;
        Thu, 06 Jul 2023 09:51:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id m18-20020a170906849200b0098f33157e7dsm1042403ejx.82.2023.07.06.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:51:16 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:51:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 04/17] vsock/virtio: non-linear skb handling for
 tap
Message-ID: <3klk75my4waydbvy7sa5muwattknjq2nify2myrucib5yb6maz@4a2swpu55lhv>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-5-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-5-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:34AM +0300, Arseniy Krasnov wrote:
>For tap device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Make 'skb' pointer constant because it is source.
>
> net/vmw_vsock/virtio_transport_common.c | 31 ++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e5683af23e60..dfc48b56d0a2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -106,6 +106,27 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>+						void *dst,
>+						size_t len)
>+{
>+	struct iov_iter iov_iter = { 0 };
>+	struct kvec kvec;
>+	size_t to_copy;
>+
>+	kvec.iov_base = dst;
>+	kvec.iov_len = len;
>+
>+	iov_iter.iter_type = ITER_KVEC;
>+	iov_iter.kvec = &kvec;
>+	iov_iter.nr_segs = 1;
>+
>+	to_copy = min_t(size_t, len, skb->len);
>+
>+	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+			       &iov_iter, to_copy);
>+}
>+
> /* Packet capture */
> static struct sk_buff *virtio_transport_build_skb(void *opaque)
> {
>@@ -114,7 +135,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	struct af_vsockmon_hdr *hdr;
> 	struct sk_buff *skb;
> 	size_t payload_len;
>-	void *payload_buf;
>
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
>@@ -122,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 	payload_len = pkt->len;
>-	payload_buf = pkt->data;
>
> 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
> 			GFP_ATOMIC);
>@@ -165,7 +184,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
> 	if (payload_len) {
>-		skb_put_data(skb, payload_buf, payload_len);
>+		if (skb_is_nonlinear(pkt)) {
>+			void *data = skb_put(skb, payload_len);
>+
>+			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}
> 	}
>
> 	return skb;
>-- 
>2.25.1
>


