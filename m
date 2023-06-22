Return-Path: <netdev+bounces-13102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620973A3D0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458D42818D0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414431F192;
	Thu, 22 Jun 2023 14:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0791E526
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 14:57:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA519A1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687445851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=StWTcZ4+l9QPhbORn1PrY5bDL4InPF3vO5n1F8OE0xo=;
	b=IxWqeDrXnLCRseigg1Smfucg6doMAZ2GsUNeZrzSI+68mgzK1CarYFG0b03nt5IUbq3O3m
	RBexMhJHYFDfUXZIa4YiKrRATdSPPPefnWrpyNMSt+5gVfWiQiJ9csmh9ql+wjszqB265+
	M4YF1AYM7BpVnHklAsCmn0vc6sNBkiE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-2OIqxhc5O-CqZpWTh0v0XA-1; Thu, 22 Jun 2023 10:57:28 -0400
X-MC-Unique: 2OIqxhc5O-CqZpWTh0v0XA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-312a08e70e3so601325f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 07:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445846; x=1690037846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StWTcZ4+l9QPhbORn1PrY5bDL4InPF3vO5n1F8OE0xo=;
        b=W3VTB8KIejmhgosX1i/FQba7vSss9iKD5iDWmSi3vucxsgddTf1oeDc9jgE0KixM0H
         YGR7xYeT7JyBWHdmyABOhRkimqTdqzCqhB1+2irJYCEoeOy4EczCiNcWIVa7uo9G50sI
         ffq8fwwIJ7QeY7cWFrFTZ4Ibv0NHoobHQsqXuf8v4hHmTOOD4oJ/Uu/AVSwLZC1GrUbr
         7nyXe3h5ajl0kWoWvJzB5NVyCQsZpPPvoEpL/1GY1/Hbr4skKVrOJNQcH6zGNdqTaAvL
         g/SweiuyF9dZzvSmPqgPv7tiOqRYV80G3gxV3Lis7u8AP3uatkyJbUB50P0MVPquMn43
         xOSw==
X-Gm-Message-State: AC+VfDzNWr2JDZ5k8x1cLDnAdyb+1YeRs28rSV1+2kiVIzijPxriHFiK
	wt6NDCxEaS7j/19vKLYY3j0PqF8Y5LsA5+0bPCQ6p6ZG4K0X3Roy+06mkdRvWwX+6YJ/9zOQqjc
	IAGrlbrmZur3KL0in
X-Received: by 2002:adf:cf11:0:b0:30a:e435:63a6 with SMTP id o17-20020adfcf11000000b0030ae43563a6mr19252145wrj.4.1687445846766;
        Thu, 22 Jun 2023 07:57:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6buBbyxIEJzfQL6PgRyTGWSK7AHMk6+0fjAWJPeOmyomH1eoQU5jcnnNJ9NYA+HxSgqoL/xA==
X-Received: by 2002:adf:cf11:0:b0:30a:e435:63a6 with SMTP id o17-20020adfcf11000000b0030ae43563a6mr19252133wrj.4.1687445846476;
        Thu, 22 Jun 2023 07:57:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d65ca000000b002f28de9f73bsm7231665wrw.55.2023.06.22.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:57:25 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:57:22 +0200
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
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 2/8] vsock: refactor transport lookup code
Message-ID: <ytlovggd6p6m5i3ye2y7qgtdhss57lqnohgkixp5z3imh6trv7@jnfdvnhstgyf>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-2-0cebbb2ae899@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v4-2-0cebbb2ae899@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 12:58:29AM +0000, Bobby Eshleman wrote:
>Introduce new reusable function vsock_connectible_lookup_transport()
>that performs the transport lookup logic.
>
>No functional change intended.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/af_vsock.c | 25 ++++++++++++++++++-------
> 1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ffb4dd8b6ea7..74358f0b47fa 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -422,6 +422,22 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
> 	vsk->transport = NULL;
> }
>
>+static const struct vsock_transport *
>+vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
>+{
>+	const struct vsock_transport *transport;
>+
>+	if (vsock_use_local_transport(cid))
>+		transport = transport_local;
>+	else if (cid <= VMADDR_CID_HOST || !transport_h2g ||
>+		 (flags & VMADDR_FLAG_TO_HOST))
>+		transport = transport_g2h;
>+	else
>+		transport = transport_h2g;
>+
>+	return transport;
>+}
>+
> /* Assign a transport to a socket and call the .init transport callback.
>  *
>  * Note: for connection oriented socket this must be called when vsk->remote_addr
>@@ -462,13 +478,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		break;
> 	case SOCK_STREAM:
> 	case SOCK_SEQPACKET:
>-		if (vsock_use_local_transport(remote_cid))
>-			new_transport = transport_local;
>-		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>-			 (remote_flags & VMADDR_FLAG_TO_HOST))
>-			new_transport = transport_g2h;
>-		else
>-			new_transport = transport_h2g;
>+		new_transport = vsock_connectible_lookup_transport(remote_cid,
>+								   remote_flags);
> 		break;
> 	default:
> 		return -ESOCKTNOSUPPORT;
>
>-- 
>2.30.2
>


