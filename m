Return-Path: <netdev+bounces-13111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7E73A500
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B842804BE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141E1F93E;
	Thu, 22 Jun 2023 15:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC31F18B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:30:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124C35AE
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687447757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHj7B9f0CgOb6vLBDwdZy7CybIY89mtFfpP8ghtMr90=;
	b=BBbQ/XEkfPLfLhlzVsPylri+KzQNuht4+dLtJapR5hYxs/tGKWUVdx+4hxBiV6J9agvGWf
	0khb109E09wqggl6u5yHdkJZpSexy12D++Fb5Nw1BZekablYAsM6i3pJQt1O4Db2c9ycdQ
	cDUKGdNVeGHMv3fZoqEk2GrosyZfEow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Oo-7bLBgN6SFpOsgWeKalw-1; Thu, 22 Jun 2023 11:29:15 -0400
X-MC-Unique: Oo-7bLBgN6SFpOsgWeKalw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31114af5e45so3372344f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447753; x=1690039753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHj7B9f0CgOb6vLBDwdZy7CybIY89mtFfpP8ghtMr90=;
        b=AA3MzSuoGKlxif23BdXBXX1bL5Es3mBKym7bPXTotrbq7NVb9rVezcZxXqi9wmBQwN
         zRspC/PkOsXJtSdNlrgY/RTO3mBvWXRfh+ZE+9MkRRkiYm4wnMj4GzVNz58dbSAWSLM/
         b4ctokX5h5GuI1uS2fCU7IIXbtNLwtzQvbvW00X+AoE1wC96JjPi+F1favj7rgj9h+Nu
         LOX/bo2LpqLvHQUDiRe4L5z3FU/84IqGIIidaA4LlHMGoCss7dvtVxhWE7e/c7FsIiLo
         okJkIszpjx2HL10GA52stK1lYCUrK9oDa8uSBOFCIXFKbQvfJegia+CitTHEAj/0Tz9V
         WzUQ==
X-Gm-Message-State: AC+VfDxGQInqwblgzg7i5ppjMrJFP1n3bb7PKRz1erLo/vJ9q0LeWh8G
	tb/mU09CIFL6hXi8YWjSVjFf7XYFE36sc7OlEggNRUGR80ZC/pbRKjqSmgW2d8Yhj1fCEeIHKnb
	lmqe7rhVTK9g/zmUz
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id v5-20020a5d4a45000000b0030fb9a292c5mr16230770wrs.49.1687447752864;
        Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wJek32JccOCrkY+bAzshAWmkfVijJZJwTebxPvorEXZQJ+vqataOybeRtTQvOfMVty8q+6Q==
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id v5-20020a5d4a45000000b0030fb9a292c5mr16230739wrs.49.1687447752542;
        Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b00307acec258esm7389420wro.3.2023.06.22.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
Date: Thu, 22 Jun 2023 17:29:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Simon Horman <simon.horman@corigine.com>, Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 5/8] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <med476cdkdhkylddqa5wbhjpgyw2yiqfthvup2kics3zbb5vpb@ovzg57adewfw>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 12:58:32AM +0000, Bobby Eshleman wrote:
>This commit adds a feature bit for virtio vsock to support datagrams.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> include/uapi/linux/virtio_vsock.h | 1 +
> 1 file changed, 1 insertion(+)

LGTM, but I'll give the R-b when we merge the virtio-spec.

Stefano

>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..9c25f267bbc0 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>
>-- 
>2.30.2
>


