Return-Path: <netdev+bounces-37740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900EE7B6E51
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A6BD21C203FF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3E38F96;
	Tue,  3 Oct 2023 16:23:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D831A82
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:23:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163BAF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696350219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfMS7si10Em3Ih0ewdIsQWk4sOjmW1agVLON4O4ZHFs=;
	b=f6CvEi7x5r1Ws+hgVRkIe507Nhga8Av2qE+oHdRjaCh8lmiAXRJQEXlnCzXfyi4oZ86ofg
	1e/Pw/wsc0cqHlrmb5NPCNQBkjGOnKm1CI4e3FaROYjgL+K/icZwInuAMg71s5XLgl/qo6
	hLKBs2Af3x9VEfDIUHHHFAsdQ0qxsto=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-QsabeDYvNdWGmLrUR0wXEQ-1; Tue, 03 Oct 2023 12:23:38 -0400
X-MC-Unique: QsabeDYvNdWGmLrUR0wXEQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4180de770f5so12496921cf.2
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350218; x=1696955018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfMS7si10Em3Ih0ewdIsQWk4sOjmW1agVLON4O4ZHFs=;
        b=VHrxw+IVqMZYiFtdpYfDS+0yHnJeczf9zOFPMuAphq6H8nVHrBzPw6Ec0I+5mjty+8
         SOlxL7llpy+lT4Efb1CKZsvrokt8xGmpGmlUPRColUsTp3dRiOKz6apLYt+4jHchTqu0
         d0hdS3HxcpNBndfLJQsxrZgmeiqY3Wk6HiBNoOiA7E3y6DjC9PkLQ4UAvUeubUNDeGDp
         4lchYJJzt9zPKe+e+yMjmMeVSMyNvQC08IHRWWmkTfs94PBFamgKKr5JK/RmUXiXTin/
         yHSyDO9k+ShV+4TKemuAs8pL0BkVDklWwvSNPr3juvk6T1lOTfJKeRsjDiljes0RuRJp
         spFQ==
X-Gm-Message-State: AOJu0Ywm/2KJoOvERAjEmMUERdOE18IcYzg/HyH1+9Lj6uiDQRSCZlnO
	+Kf9RWoyurNA2LNXJm7RqEGGG/XlLVZw8A+1+3yCUbxWRbjPIh8T5GtyFTXZVLHgd6UP/Ke9FQP
	7VQ4zoM9amItwm+jW
X-Received: by 2002:ac8:149a:0:b0:419:af26:fc72 with SMTP id l26-20020ac8149a000000b00419af26fc72mr1872212qtj.27.1696350218262;
        Tue, 03 Oct 2023 09:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQy1JM0pldsNEW5rolW8PRXJCWF1GlYH0HqlcRRXiBOMMPAuTdsJD5SqR4LDPBV8ljq34JbQ==
X-Received: by 2002:ac8:149a:0:b0:419:af26:fc72 with SMTP id l26-20020ac8149a000000b00419af26fc72mr1872186qtj.27.1696350217966;
        Tue, 03 Oct 2023 09:23:37 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id d14-20020ac8118e000000b004198d026be6sm552077qtj.35.2023.10.03.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:23:37 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:23:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 08/12] vsock: enable setting SO_ZEROCOPY
Message-ID: <rtc5f42epcmjksoyrvkbjmomucdg2xg6a6e7d3dm2ewuoaqok3@x37szdvwflm6>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-9-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-9-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 12:03:04AM +0300, Arseniy Krasnov wrote:
>For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
>be set in AF_VSOCK implementation where transport is accessible (if
>transport is not set during setting SO_ZEROCOPY: for example socket is
>not connected, then SO_ZEROCOPY will be enabled, but once transport will
>be assigned, support of this type of transmission will be checked).
>
>To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
>bit, thus handling SOL_SOCKET option operations, but all of them except
>SO_ZEROCOPY will be forwarded to the generic handler by calling
>'sock_setsockopt()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Place 'sock_valbool_flag()' in a single line.
>
> net/vmw_vsock/af_vsock.c | 45 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 43 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ff44bab05191..a84f242466cf 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,8 +1406,16 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>-		if (vsock_msgzerocopy_allow(transport))
>+		if (vsock_msgzerocopy_allow(transport)) {
> 			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>+			/* If this option was set before 'connect()',
>+			 * when transport was unknown, check that this
>+			 * feature is supported here.
>+			 */
>+			err = -EOPNOTSUPP;
>+			goto out;
>+		}
>
> 		err = vsock_auto_bind(vsk);
> 		if (err)
>@@ -1643,7 +1651,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	const struct vsock_transport *transport;
> 	u64 val;
>
>-	if (level != AF_VSOCK)
>+	if (level != AF_VSOCK && level != SOL_SOCKET)
> 		return -ENOPROTOOPT;
>
> #define COPY_IN(_v)                                       \
>@@ -1666,6 +1674,33 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>
> 	transport = vsk->transport;
>
>+	if (level == SOL_SOCKET) {
>+		int zerocopy;
>+
>+		if (optname != SO_ZEROCOPY) {
>+			release_sock(sk);
>+			return sock_setsockopt(sock, level, optname, optval, optlen);
>+		}
>+
>+		/* Use 'int' type here, because variable to
>+		 * set this option usually has this type.
>+		 */
>+		COPY_IN(zerocopy);
>+
>+		if (zerocopy < 0 || zerocopy > 1) {
>+			err = -EINVAL;
>+			goto exit;
>+		}
>+
>+		if (transport && !vsock_msgzerocopy_allow(transport)) {
>+			err = -EOPNOTSUPP;
>+			goto exit;
>+		}
>+
>+		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
>+		goto exit;
>+	}
>+
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
> 		COPY_IN(val);
>@@ -2322,6 +2357,12 @@ static int vsock_create(struct net *net, struct socket *sock,
> 		}
> 	}
>
>+	/* SOCK_DGRAM doesn't have 'setsockopt' callback set in its
>+	 * proto_ops, so there is no handler for custom logic.
>+	 */
>+	if (sock_type_connectible(sock->type))
>+		set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>+
> 	vsock_insert_unbound(vsk);
>
> 	return 0;
>-- 
>2.25.1
>


