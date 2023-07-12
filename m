Return-Path: <netdev+bounces-17319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7DE751393
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0061C211B7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141E1D2E2;
	Wed, 12 Jul 2023 22:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED4384
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:31:37 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BBB1FDB;
	Wed, 12 Jul 2023 15:31:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55adfa61199so131285a12.2;
        Wed, 12 Jul 2023 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689201095; x=1691793095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCpvGyW7ZNtzKpBm2Ry0x2qGxhjvzST5Bf86BqgznXA=;
        b=KHsoBgFNhngzZ+1XI0HfDDPczhjyvQZMxkyeCW532jV+dpvmTISH8pxMzBXTzY2VMv
         0GOFXFF3czKZl7IYWVBjWCsmAG31URAjWou4msKKQgdAPo3MuaUtZDGyz3iQmaA6LKF7
         m8MIl1dtM9VRCrsi0OnumUM1v+hTPFLHeKySR8Fdwpp/qymtg+J16kTeNwUsSUagsxKM
         yCQ2h7AM1uZm7LP8hp4vEqoKNvw0Pi1/8Sj4Gg9yCRDHTnjX6t2vIdYNjruqbHEcQfWu
         ykBxbabQv1Gp7zg4Btj5zQc6uFIDnifVZEULqgCa72IRqH0dJOFcf9FYq3UCM/NbXBP8
         j33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201095; x=1691793095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCpvGyW7ZNtzKpBm2Ry0x2qGxhjvzST5Bf86BqgznXA=;
        b=GML2O/ByfTI5GxWV9Ufkzk/N68/Azx09nYGd/n7sqBn0dJoqxAPq/i9i9CmJ8mRNKq
         UFwC5dnl5uwIl4PDbVbcsJt9jNqFWdSYDFs2q7St5kp4FZvgu96CUtYj/1nuOIJzZIAb
         6trouAlimmgFHvjTD2AWk5sDdKyiKBvzDtxIFOjT/SXfGROXaWFcBWgdykcoQVcN7fPH
         aZtVm66BwXPmr0nex4y7vL9UOKDDRfYbhE5VxHLE3IPYRqbm+vfDzYgsUmuMc1DLcEre
         CunmiyynpYhS3MCtZ1MND5FWfRkDC4qtod1UIbB4gD735R+PW1+RN2mXsIrlog32YInr
         VT6w==
X-Gm-Message-State: ABy/qLaGKOAXrK5FpH6YKn/IeEdC/lFRJ0e+oyB4P9IhWmUkNbuIwoOT
	DdDpLcDyldiSmn6RkKU7hKQ=
X-Google-Smtp-Source: APBJJlF6okL7Dglm5S6RpST3VlKIYHaPb/KgL/WI8M8bciN3EtB5A+GR1rnB0ASkVIGOKLFR21m7fw==
X-Received: by 2002:a17:902:d4d1:b0:1b8:a234:7617 with SMTP id o17-20020a170902d4d100b001b8a2347617mr23278580plg.5.1689201095479;
        Wed, 12 Jul 2023 15:31:35 -0700 (PDT)
Received: from localhost (ec2-54-67-115-33.us-west-1.compute.amazonaws.com. [54.67.115.33])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902b18a00b001b9dfa8d884sm4466924plr.226.2023.07.12.15.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:31:35 -0700 (PDT)
Date: Wed, 12 Jul 2023 22:31:34 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 13/17] vsock: enable setting SO_ZEROCOPY
Message-ID: <ZK8pxrbkrH2bEgw7@bullseye>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:43AM +0300, Arseniy Krasnov wrote:
> For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
> be set in AF_VSOCK implementation where transport is accessible (if
> transport is not set during setting SO_ZEROCOPY: for example socket is
> not connected, then SO_ZEROCOPY will be enabled, but once transport will
> be assigned, support of this type of transmission will be checked).
> 
> To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
> bit, thus handling SOL_SOCKET option operations, but all of them except
> SO_ZEROCOPY will be forwarded to the generic handler by calling
> 'sock_setsockopt()'.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Changelog:
>  v4 -> v5:
>   * This patch is totally reworked. Previous version added check for
>     PF_VSOCK directly to 'net/core/sock.c', thus allowing to set
>     SO_ZEROCOPY for AF_VSOCK type of socket. This new version catches
>     attempt to set SO_ZEROCOPY in 'af_vsock.c'. All other options
>     except SO_ZEROCOPY are forwarded to generic handler. Only this
>     option is processed in 'af_vsock.c'. Handling this option includes
>     access to transport to check that MSG_ZEROCOPY transmission is
>     supported by the current transport (if it is set, if not - transport
>     will be checked during 'connect()').
> 
>  net/vmw_vsock/af_vsock.c | 44 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index da22ae0ef477..8acc77981d01 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1406,8 +1406,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>  			goto out;
>  		}
>  
> -		if (vsock_msgzerocopy_allow(transport))
> +		if (!vsock_msgzerocopy_allow(transport)) {
> +			/* If this option was set before 'connect()',
> +			 * when transport was unknown, check that this
> +			 * feature is supported here.
> +			 */
> +			if (sock_flag(sk, SOCK_ZEROCOPY)) {
> +				err = -EOPNOTSUPP;
> +				goto out;
> +			}
> +		} else {
>  			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> +		}
>  
>  		err = vsock_auto_bind(vsk);
>  		if (err)
> @@ -1643,7 +1653,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  	const struct vsock_transport *transport;
>  	u64 val;
>  
> -	if (level != AF_VSOCK)
> +	if (level != AF_VSOCK && level != SOL_SOCKET)
>  		return -ENOPROTOOPT;
>  
>  #define COPY_IN(_v)                                       \
> @@ -1666,6 +1676,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  
>  	transport = vsk->transport;
>  
> +	if (level == SOL_SOCKET) {
> +		if (optname == SO_ZEROCOPY) {
> +			int zc_val;
> +
> +			/* Use 'int' type here, because variable to
> +			 * set this option usually has this type.
> +			 */
> +			COPY_IN(zc_val);
> +
> +			if (zc_val < 0 || zc_val > 1) {
> +				err = -EINVAL;
> +				goto exit;
> +			}
> +
> +			if (transport && !vsock_msgzerocopy_allow(transport)) {
> +				err = -EOPNOTSUPP;
> +				goto exit;
> +			}
> +
> +			sock_valbool_flag(sk, SOCK_ZEROCOPY,
> +					  zc_val ? true : false);
> +			goto exit;
> +		}
> +
> +		release_sock(sk);
> +		return sock_setsockopt(sock, level, optname, optval, optlen);
> +	}
> +
>  	switch (optname) {
>  	case SO_VM_SOCKETS_BUFFER_SIZE:
>  		COPY_IN(val);
> @@ -2321,6 +2359,8 @@ static int vsock_create(struct net *net, struct socket *sock,
>  		}
>  	}
>  
> +	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
> +

I found that because datagrams have !ops->setsockopt this bit causes
setsockopt() to fail (the related logic can be found in
__sys_setsockopt). Maybe we should only set this for connectibles?

Best,
Bobby

>  	vsock_insert_unbound(vsk);
>  
>  	return 0;
> -- 
> 2.25.1
> 

