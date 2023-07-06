Return-Path: <netdev+bounces-15857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319074A2AB
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5F2812A5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E0BA2B;
	Thu,  6 Jul 2023 16:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19189BA28
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:57:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248071996
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOn2FSR/F+AepHAW4tuhLZ6J2d0DqA3sGZENm8WNhBk=;
	b=bFs/xT7jfGCCSjIzhTxojAFmBHwReAsyyfU6NKQUL05mgJVKaoT+bPjc+eypvL0gyToZt1
	s0FmyW8uX3o3dmld/1VIVgqo8773C275+Xwq/Nf6tojptN5CKzT/JwY8/3V3ZofBXaUDqT
	qIMKYlPUzFV8QDZWyE3UeG3LCgiCE+U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-GJkuNXFzP1aQtngYHdd-Eg-1; Thu, 06 Jul 2023 12:56:28 -0400
X-MC-Unique: GJkuNXFzP1aQtngYHdd-Eg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b703d64832so10560041fa.2
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662587; x=1691254587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOn2FSR/F+AepHAW4tuhLZ6J2d0DqA3sGZENm8WNhBk=;
        b=g+R5bZBHrtt7lAe/RNqX/ngLJOFhLDYPLNGlefLU8byTYCMMCLRVzSsM8kf2BRqrpj
         sIZLdFgd8hfbf2yJsKb5MQ6QHLDpjM18+9BPPxbDW+fX8GfrvF5neaqkCTwyirgVPx1+
         WWUtLFwMOe8u9Nln+2+sJtFWbmdzwPGuV6Q3fzj8vgTaeJ5ozrYhUcfeTzVsFGad2fMI
         GSCtWH9Qa90uppqymM4LKPSbpDxCzzZhiofZ91a5QOQUJ2stRNLAhwdGcz3+3RDaBt+Z
         /9KkLKzzFnxtqTaKbM3DkCTzWsVkTniOBfpTTe/0Q6/rY7/IBQ4cbuiqObktqTt7akay
         7gbw==
X-Gm-Message-State: ABy/qLZ4fZW8iQqD1xS0Vxe3RwhCw0jwNyOXIe16vZ4ghao0BEh81MNH
	+BbbsDqEN+DGKQK7Oe8uuL/M/3bEYw6CmYEbjDVp2efhFvmFgFLeZ2pgSijwm2mPs/TgBXL1vE2
	QdP1KJi+3m91DMbfB
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id l19-20020a2e99d3000000b002b6e3e25045mr1907490ljj.18.1688662587337;
        Thu, 06 Jul 2023 09:56:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+MGDRqQfF9kapT4zmm8lQzVMW6DfZBqPPwvO/e9jD6LvFab7VnpcM4MmvpSS7cFxJwa1qgw==
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id l19-20020a2e99d3000000b002b6e3e25045mr1907472ljj.18.1688662586938;
        Thu, 06 Jul 2023 09:56:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id a6-20020aa7cf06000000b0051de20c59d7sm975495edy.15.2023.07.06.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:56:26 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:56:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 13/17] vsock: enable setting SO_ZEROCOPY
Message-ID: <di3hhsulz5smngtyfwyvnvanlju22xuii46szrn5fmu3woj2ro@3toj6n4kbks3>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:43AM +0300, Arseniy Krasnov wrote:
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
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * This patch is totally reworked. Previous version added check for
>    PF_VSOCK directly to 'net/core/sock.c', thus allowing to set
>    SO_ZEROCOPY for AF_VSOCK type of socket. This new version catches
>    attempt to set SO_ZEROCOPY in 'af_vsock.c'. All other options
>    except SO_ZEROCOPY are forwarded to generic handler. Only this
>    option is processed in 'af_vsock.c'. Handling this option includes
>    access to transport to check that MSG_ZEROCOPY transmission is
>    supported by the current transport (if it is set, if not - transport
>    will be checked during 'connect()').

Yeah, great, this is much better!

>
> net/vmw_vsock/af_vsock.c | 44 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 42 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index da22ae0ef477..8acc77981d01 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,8 +1406,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>-		if (vsock_msgzerocopy_allow(transport))
>+		if (!vsock_msgzerocopy_allow(transport)) {

Can you leave `if (vsock_msgzerocopy_allow(transport))` and just add
the else branch with this new check?

		if (vsock_msgzerocopy_allow(transport)) {
			...
		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
			...
		}

>+			/* If this option was set before 'connect()',
>+			 * when transport was unknown, check that this
>+			 * feature is supported here.
>+			 */
>+			if (sock_flag(sk, SOCK_ZEROCOPY)) {
>+				err = -EOPNOTSUPP;
>+				goto out;
>+			}
>+		} else {
> 			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+		}
>
> 		err = vsock_auto_bind(vsk);
> 		if (err)
>@@ -1643,7 +1653,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	const struct vsock_transport *transport;
> 	u64 val;
>
>-	if (level != AF_VSOCK)
>+	if (level != AF_VSOCK && level != SOL_SOCKET)
> 		return -ENOPROTOOPT;
>
> #define COPY_IN(_v)                                       \
>@@ -1666,6 +1676,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>
> 	transport = vsk->transport;
>
>+	if (level == SOL_SOCKET) {

We could reduce the indentation here:
		if (optname != SO_ZEROCOPY) {
			release_sock(sk);
			return sock_setsockopt(sock, level, optname, optval, optlen);
		}

Then remove the next indentation.

>+		if (optname == SO_ZEROCOPY) {
>+			int zc_val;

`zerocopy` is more readable.
>+
>+			/* Use 'int' type here, because variable to
>+			 * set this option usually has this type.
>+			 */
>+			COPY_IN(zc_val);
>+
>+			if (zc_val < 0 || zc_val > 1) {
>+				err = -EINVAL;
>+				goto exit;
>+			}
>+
>+			if (transport && !vsock_msgzerocopy_allow(transport)) {
>+				err = -EOPNOTSUPP;
>+				goto exit;
>+			}
>+
>+			sock_valbool_flag(sk, SOCK_ZEROCOPY,
>+					  zc_val ? true : false);

Why not using directly `zc_val`?
The 3rd param of sock_valbool_flag() is an int.

>+			goto exit;
>+		}
>+
>+		release_sock(sk);
>+		return sock_setsockopt(sock, level, optname, optval, optlen);
>+	}
>+
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
> 		COPY_IN(val);
>@@ -2321,6 +2359,8 @@ static int vsock_create(struct net *net, struct socket *sock,
> 		}
> 	}
>
>+	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>+
> 	vsock_insert_unbound(vsk);
>
> 	return 0;
>-- 
>2.25.1
>


