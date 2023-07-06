Return-Path: <netdev+bounces-15856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968C74A2A6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D974B2813D6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D251BA2B;
	Thu,  6 Jul 2023 16:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C73BA29
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:56:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710841BF9
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DQmeZW7JJEADmCiQp/d8Tl0o1s0eDsc5Jt7E9LRdL4I=;
	b=jBT8ea68MTbatSIaWvO1KoJ8qiUiR0jMOKZplEORzMGFzjwsVXdMigjo4x0hnT9YDcYJh6
	nduRD6z6IZNeLW+3ikfx0yflJ8XsaAALCYTvVwYF86kcZasbObb+DP9lDXl83uBHbjqugx
	iJjxiY9TnHVD93pCttXhVjYfvJKJ7us=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-2IyL5kYaO1OiL_hACq3g2Q-1; Thu, 06 Jul 2023 12:56:05 -0400
X-MC-Unique: 2IyL5kYaO1OiL_hACq3g2Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51dd18ca0a2so642808a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662564; x=1691254564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQmeZW7JJEADmCiQp/d8Tl0o1s0eDsc5Jt7E9LRdL4I=;
        b=bITcRLSNGijxHyPHSce/a3PmkDbQsg5vfF7i69zRl443VQsctwC6GJaHYmanIGPyUV
         C+ozhwXmIiDGdOeWiolAdYnuwbb1lfqozHxKvKarDsZmGlO458voih+rUkbhNa/en7UJ
         Ia9WBV725eaSuRnzD45whYO8Jw5tpmEneHpfgSIZI9GwhRH2X6eMjZMeqC/kENfWFN1+
         ctvOGlA8t30qdzy6eD56q1KqcMI5+CJkoGQt5CZPBFFMlH4stRLW/NqQmhFBs+x0FNfK
         RL5UUoZsw9zoDx/j4yeT6+atrw1Z/myruAQEnoTq/YqqnerFgLgf/G5olC/GC17jH8jq
         cKLg==
X-Gm-Message-State: ABy/qLYNg8/DXAjRsJ+FjP6DNJzJAzFXvzgiv9lI6i3nw+2yjSGqGdEN
	ZEVMAdZFEszgAoTLdhTwk+yFT5qaLlf6R2w8sl1LShORbJ42mTmoY7RVtm6dS5AL3E2vq8YrAWv
	ueu/bIgMPOY7LAN/r
X-Received: by 2002:a05:6402:120b:b0:51b:ec86:b49a with SMTP id c11-20020a056402120b00b0051bec86b49amr2154467edw.7.1688662564104;
        Thu, 06 Jul 2023 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxoQPW4oanBsoLFqkOwrRRnKfPaR1KLUxeJaSGG1BqBJPWu7lxGmtL/ElaHswkY3m0t4dqDw==
X-Received: by 2002:a05:6402:120b:b0:51b:ec86:b49a with SMTP id c11-20020a056402120b00b0051bec86b49amr2154459edw.7.1688662563919;
        Thu, 06 Jul 2023 09:56:03 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id w26-20020a056402129a00b0051a1ef536c9sm961703edv.64.2023.07.06.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:56:03 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:56:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 12/17] vsock/loopback: support MSG_ZEROCOPY for
 transport
Message-ID: <p2ctmue6xm6v7px7uir2rtav6lvgenakmh45t2hd5qvdxvbeyq@cqmlufisosgx>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-13-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-13-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:42AM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for loopback transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Move 'msgzerocopy_allow' right after seqpacket callbacks.
>  * Don't use prototype for 'vsock_loopback_msgzerocopy_allow()'.
>
> net/vmw_vsock/vsock_loopback.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 5c6360df1f31..048640167411 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -47,6 +47,10 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>
> static struct virtio_transport loopback_transport = {
> 	.transport = {
>@@ -79,6 +83,8 @@ static struct virtio_transport loopback_transport = {
> 		.seqpacket_allow          = vsock_loopback_seqpacket_allow,
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
>+		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>


