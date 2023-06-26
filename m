Return-Path: <netdev+bounces-13995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160F73E45A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328C71C2081F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B095DF65;
	Mon, 26 Jun 2023 16:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B710942
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:12:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD41722
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687795940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSj67Bysge00sGJTpLw1MntXa5IUhJN9aBkXlNz5ucg=;
	b=LmaiCgGzQRbZgUlHzsRL26xROYnslXFETKYAwa6cTrhihk1tnyqV8xG/ssKGQ8FN3AWq7x
	6Fgty7u3uWBV9tIvFvIF+Qlq0b17aFNHOJZQvxTF4oYy9f2f9j3SAL2rDyjTkfs5JAdM3G
	fUKfavvcytS+fsGkbwcKFs8G27o084k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-QLaDLfzUMuSB2NhlZuo1qg-1; Mon, 26 Jun 2023 12:11:18 -0400
X-MC-Unique: QLaDLfzUMuSB2NhlZuo1qg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76594ad37fcso139240785a.2
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795862; x=1690387862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSj67Bysge00sGJTpLw1MntXa5IUhJN9aBkXlNz5ucg=;
        b=bAhwXVORo5wgPtk/6AqZsmCS73d5woUVzZG/Foh3X9lHAcww1aUGIaitGJDe9X7Gay
         TvP3LDejchvxnJU8X33kwlRLoic/4e9V/vCit6gadj9z4dZvmrBtJjj7t8ssner3lLC7
         C5JW+vwx2/YD+zuS1Wvy5dbVrhS3xBu+9Z8pyRmpgQrTYCQXWuwkwOWPQJ/F+WHqWMYv
         e0KajN1C+kxyTbAt4LM+3Z4UDXigr8jXZa2GZq0mDN6sjbzQTHyw8WWpcP0vbYocK3Sw
         CmBCDr57T6dut0q3ZL9Kp8p7/FESZRNJ0wC7NJHZDIwNNcbL8oNg1GOR0H6p1emrDpYl
         pVSw==
X-Gm-Message-State: AC+VfDx9/aE5LQ82I2fZOXdrazt/8vBK1J9NOpad2taPOtHiggkv+PHT
	Gl6SOznxGbhKuDx3qKS+fUzNDDHr17XA4iMR7LcXvh+Go8e7kUQzz6sfhMSmW4iDlfG3BGWOi1V
	UMuHrA71+zLv7j+Hk
X-Received: by 2002:a05:620a:4542:b0:75b:23a1:830c with SMTP id u2-20020a05620a454200b0075b23a1830cmr40000799qkp.7.1687795862090;
        Mon, 26 Jun 2023 09:11:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AAJeVZO0AaDvZksfxGubjZjegdRtILGSI73Wjq9DgEqaoTB4CbROal09UCjmsMp7T1Z9vfA==
X-Received: by 2002:a05:620a:4542:b0:75b:23a1:830c with SMTP id u2-20020a05620a454200b0075b23a1830cmr40000771qkp.7.1687795861845;
        Mon, 26 Jun 2023 09:11:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a11b900b007607324644asm2806347qkk.118.2023.06.26.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:11:01 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:10:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 10/17] vhost/vsock: support MSG_ZEROCOPY for
 transport
Message-ID: <cqlp2jr7laleku3reiqf64swlieso6rvi47u5cnlu24kfn3fnm@3x45ihmjox77>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-11-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-11-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 03, 2023 at 11:49:32PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for vhost transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b254aa4b756a..318866713ef7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -396,6 +396,11 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
>@@ -442,6 +447,7 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+		.msgzerocopy_allow        = vhost_transport_msgzerocopy_allow,

Can we move this after .seqpacket section?

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>-- 
>2.25.1
>


