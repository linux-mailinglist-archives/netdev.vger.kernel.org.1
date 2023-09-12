Return-Path: <netdev+bounces-33246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9C79D266
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32C6281F87
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14639182C3;
	Tue, 12 Sep 2023 13:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300F377
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:33:07 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD735B1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:33:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76ef8b91a4bso356127085a.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694525586; x=1695130386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DXIfxcA+W4Tii01douSDuJYCKDJaXmQc6RC3kf6JyY=;
        b=TeFUeEBYX4s1xSO7yfp4lUyWM9nodOUts46jguHoQ19VRRh/dL+hKDsgvBCdGsjNna
         4Nxa4r7T7eROw5JCkDyck3Mon2O382MfYRDIbuofaKhWfSdq7NUNaKeDsjzjgnXuxCK8
         JMnVrHc1Tf/WkVw100xltlGeJC6zdchiqVueVwea79NKWy2LzXyOUpoc9/n098HZJLCV
         MMRPBLTlWfIs1HP4Li93NeStB9m7YC32pJlzBPgQZoQMyw7GVD33GsIU1725J16eO9tf
         8cV4ebucl5RfPeoto0wuI7E63bv5B0tgeQmi6fFWZA3mb44fK17QhwdbXgH4azY6uOmP
         RWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525586; x=1695130386;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8DXIfxcA+W4Tii01douSDuJYCKDJaXmQc6RC3kf6JyY=;
        b=Yyf+8STgq+JLQ8U/VoqgzZrJi5pcXS2O5h2MDaMachthc2oOPYGplPSgBUU9PdE2eQ
         eCytKmky/JoFbnp6O9fS3AbhX4RUfrFT7qkAQn8W2S5hY3I7NfGoq6sl/+KrFXoNu44g
         3VspCTdjPF9a2njXPIj28drVb/aijgK/lMQJpc9CWzLqvt1rsYQBrpQYXCgyPEa/p4TP
         ZWaNdHTNG1JZL+dmn4sLkV5yQs3ai9vMtv7dmuBFyIBJx6vb5H3In8nMPqISn2FHf0Q2
         dqwnQQIFQyMHXb2CJ8IPF7kB6/dYT8zJkz+VHq3FUIg66Z3CzkN7mt35KD4LTHytu9ME
         ZQoQ==
X-Gm-Message-State: AOJu0YzPmuGS1dpKGhhL2V12kqjzdslanXQzod3pP64y9XwOGGyN8b56
	8VKrT61qy5/0ID8FfmRch7g=
X-Google-Smtp-Source: AGHT+IGQH9rwoMcI12A7S5V6Y8G3yAM09A6GUbYnxCLU4YCyas8UER070ke0zTSkzjDd+bQDqVf48Q==
X-Received: by 2002:a05:620a:ccb:b0:76a:eeb6:dd7b with SMTP id b11-20020a05620a0ccb00b0076aeeb6dd7bmr11219901qkj.75.1694525586179;
        Tue, 12 Sep 2023 06:33:06 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a136500b0076f206cf16fsm3192159qkl.89.2023.09.12.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:33:05 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:33:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jordan Rife <jrife@google.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org
Cc: dborkman@kernel.org, 
 Jordan Rife <jrife@google.com>
Message-ID: <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230912013332.2048422-1-jrife@google.com>
References: <20230912013332.2048422-1-jrife@google.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and
 sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jordan Rife wrote:
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. However,
> there remain other cases where BPF hooks can overwrite an address held
> by a kernel client.
> 
> ==Scenarios Tested==
> 
> * Code in the SMB and Ceph modules calls sock->ops->connect() directly,
>   allowing the address overwrite to occur. In the case of SMB, this can
>   lead to broken mounts.

These should probably call kernel_connect instead.

> * NFS v3 mounts with proto=udp call sock_sendmsg() for each RPC call,
>   passing a pointer to the mount address in msg->msg_name which is
>   later overwritten by a BPF sendmsg hook. This can lead to broken NFS
>   mounts.

Similarly, this could call kernel_sendmsg, and the extra copy handled
in that wrapper. The arguments are not exacty the same, so not 100%
this is feasible.

But it's preferable if in-kernel callers use the kernel_.. API rather
than bypass it. Exactly for issues like the one you report.
 
> In order to more comprehensively fix this class of problems, this patch
> pushes the address copy deeper into the stack and introduces an address
> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all callers
> from address rewrites.
> 
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
>  net/ipv4/af_inet.c | 18 ++++++++++++++++++
>  net/ipv4/udp.c     | 21 ++++++++++++++++-----
>  net/ipv6/udp.c     | 23 +++++++++++++++++------
>  net/socket.c       |  7 +------
>  4 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 3d2e30e204735..c37d484fbee34 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -568,6 +568,7 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
>  {
>  	struct sock *sk = sock->sk;
>  	const struct proto *prot;
> +	struct sockaddr_storage addr;
>  	int err;
>  
>  	if (addr_len < sizeof(uaddr->sa_family))
> @@ -580,6 +581,14 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
>  		return prot->disconnect(sk, flags);
>  
>  	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
> +		if (uaddr && addr_len <= sizeof(addr)) {
> +			/* pre_connect can rewrite uaddr, so make a copy to
> +			 * insulate the caller.
> +			 */
> +			memcpy(&addr, uaddr, addr_len);
> +			uaddr = (struct sockaddr *)&addr;
> +		}
> +
>  		err = prot->pre_connect(sk, uaddr, addr_len);
>  		if (err)
>  			return err;
> @@ -625,6 +634,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  			  int addr_len, int flags, int is_sendmsg)
>  {
>  	struct sock *sk = sock->sk;
> +	struct sockaddr_storage addr;
>  	int err;
>  	long timeo;
>  
> @@ -668,6 +678,14 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  			goto out;
>  
>  		if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
> +			if (uaddr && addr_len <= sizeof(addr)) {
> +				/* pre_connect can rewrite uaddr, so make a copy to
> +				 * insulate the caller.
> +				 */
> +				memcpy(&addr, uaddr, addr_len);
> +				uaddr = (struct sockaddr *)&addr;
> +			}
> +
>  			err = sk->sk_prot->pre_connect(sk, uaddr, addr_len);
>  			if (err)
>  				goto out;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index f39b9c8445808..5f5ee2752eeb7 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1142,18 +1142,29 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	}
>  
>  	if (cgroup_bpf_enabled(CGROUP_UDP4_SENDMSG) && !connected) {
> +		struct sockaddr_in tmp_addr;
> +		struct sockaddr_in *addr = usin;
> +
> +		/* BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK can rewrite usin, so make a
> +		 * copy to insulate the caller.
> +		 */
> +		if (usin && msg->msg_namelen <= sizeof(tmp_addr)) {
> +			memcpy(&tmp_addr, usin, msg->msg_namelen);
> +			addr = &tmp_addr;
> +		}
> +
>  		err = BPF_CGROUP_RUN_PROG_UDP4_SENDMSG_LOCK(sk,
> -					    (struct sockaddr *)usin, &ipc.addr);
> +					    (struct sockaddr *)addr, &ipc.addr);
>  		if (err)
>  			goto out_free;
> -		if (usin) {
> -			if (usin->sin_port == 0) {
> +		if (addr) {
> +			if (addr->sin_port == 0) {
>  				/* BPF program set invalid port. Reject it. */
>  				err = -EINVAL;
>  				goto out_free;
>  			}
> -			daddr = usin->sin_addr.s_addr;
> -			dport = usin->sin_port;
> +			daddr = addr->sin_addr.s_addr;
> +			dport = addr->sin_port;
>  		}
>  	}
>  
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 86b5d509a4688..cbc1917fad629 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1506,26 +1506,37 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	fl6->fl6_sport = inet->inet_sport;
>  
>  	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
> +		struct sockaddr_in6 tmp_addr;
> +		struct sockaddr_in6 *addr = sin6;
> +
> +		/* BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK can rewrite sin6, so make a
> +		 * copy to insulate the caller.
> +		 */
> +		if (sin6 && addr_len <= sizeof(tmp_addr)) {
> +			memcpy(&tmp_addr, sin6, addr_len);
> +			addr = &tmp_addr;
> +		}
> +
>  		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,
> -					   (struct sockaddr *)sin6,
> +					   (struct sockaddr *)addr,
>  					   &fl6->saddr);
>  		if (err)
>  			goto out_no_dst;
> -		if (sin6) {
> -			if (ipv6_addr_v4mapped(&sin6->sin6_addr)) {
> +		if (addr) {
> +			if (ipv6_addr_v4mapped(&addr->sin6_addr)) {
>  				/* BPF program rewrote IPv6-only by IPv4-mapped
>  				 * IPv6. It's currently unsupported.
>  				 */
>  				err = -ENOTSUPP;
>  				goto out_no_dst;
>  			}
> -			if (sin6->sin6_port == 0) {
> +			if (addr->sin6_port == 0) {
>  				/* BPF program set invalid port. Reject it. */
>  				err = -EINVAL;
>  				goto out_no_dst;
>  			}
> -			fl6->fl6_dport = sin6->sin6_port;
> -			fl6->daddr = sin6->sin6_addr;
> +			fl6->fl6_dport = addr->sin6_port;
> +			fl6->daddr = addr->sin6_addr;
>  		}
>  	}
>  
> diff --git a/net/socket.c b/net/socket.c
> index c8b08b32f097e..39794d026fa11 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -3570,12 +3570,7 @@ EXPORT_SYMBOL(kernel_accept);
>  int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
>  		   int flags)
>  {
> -	struct sockaddr_storage address;
> -
> -	memcpy(&address, addr, addrlen);
> -
> -	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
> -					     addrlen, flags);
> +	return READ_ONCE(sock->ops)->connect(sock, addr, addrlen, flags);
>  }
>  EXPORT_SYMBOL(kernel_connect);
>  
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 



