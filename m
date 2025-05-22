Return-Path: <netdev+bounces-192734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD99AC0F51
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F443A1E8D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63B35977;
	Thu, 22 May 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNEJufCp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927A12CDAE
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926169; cv=none; b=Huw3HJABPUMUGNmiowslGl5byWU5MrNNUm21JDmD8aXECq42kHemqFKH75ajLp1a6AmxKVl0HziaSrUo/zrbnJ9TmZDg5lPRD3cNvvX4pT4Cjl+xSOykWTlmdUn7vTj2S7tMvY7Z19irCZBAvYoksIJy6lOry6dUshmIRj/WdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926169; c=relaxed/simple;
	bh=kuuHzrpn6+u7mqPDSoDIG0yUIkc0PThyxzK5JYfFha4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5IjGdJmbQ0UImK+DTgA9FRZgjn4zco94qyA+i8Qu+DL3RtvqzimHysnctpE773+kOc0x45BKNJlwGRY4tRlslVTyFR9A5j+6/4IaKrIZmpQgGeIlzI8BEaieJj35I4+cXbFVkLI1IZz4cvHmHRYbLwHSLqor+st5eaXdGcQnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNEJufCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5847AC4CEE4;
	Thu, 22 May 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747926169;
	bh=kuuHzrpn6+u7mqPDSoDIG0yUIkc0PThyxzK5JYfFha4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNEJufCp/uXINuDIdmsWbEiLMulbzsUTf/N6nvrYau9lh1Z/opJPsR+YKXRFIUlzD
	 BOVYpQTG5b5shmOYkqLem2LRkj92ccKH4KFhpMy81aNw3i7hV/2V7vao8sUuBiYsUR
	 L5A7zGUxgcKtSu55MJWlZ9iHKz19H+5/L2U/stHJwMeg1Id9LsKhWyNvh2Qlzv4N7z
	 4i/9c8OnKW1Bg71zMgZlzJHP9fXnuKFeKEerfPoV8KviRNVJIQlFGIle2wUqKe5oV5
	 qBvxlc04NFa9CkYZaAV/ppE+r4X/o31bublt+EynaYK32z0wBx3Qk76qPZYmVRK5YE
	 RwJwKQsxqv7SQ==
Message-ID: <a5654334-b0fc-419d-adbd-91eca9437e28@kernel.org>
Date: Thu, 22 May 2025 17:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v1 net-next 3/6] socket: Restore sock_create_kern().
Content-Language: en-GB, fr-BE
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-4-kuniyu@amazon.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250517035120.55560-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 17/05/2025 05:50, Kuniyuki Iwashima wrote:
> Let's restore sock_create_kern() that holds a netns reference.
> 
> Now, it's the same as the version before commit 26abe14379f8 ("net:
> Modify sk_alloc to not reference count the netns of kernel sockets.").
> 
> Back then, after creating a socket in init_net, we used sk_change_net()
> to drop the netns ref and switch to another netns, but now we can
> simply use __sock_create_kern() instead.
> 
>   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> 
> DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> from __net_init functions, since doing so would leak the netns as
> __net_exit functions cannot run until the socket is removed.

Thank you for working on this!

(...)

> diff --git a/net/socket.c b/net/socket.c
> index 7c4474c966c0..aeece4c4bb08 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1632,6 +1632,48 @@ int __sock_create_kern(struct net *net, int family, int type, int protocol, stru
>  }
>  EXPORT_SYMBOL(__sock_create_kern);
>  
> +/**
> + * sock_create_kern - creates a socket for kernel space
> + *
> + * @net: net namespace
> + * @family: protocol family (AF_INET, ...)
> + * @type: communication type (SOCK_STREAM, ...)
> + * @protocol: protocol (0, ...)
> + * @res: new socket
> + *
> + * Creates a new socket and assigns it to @res.
> + *
> + * The socket is for kernel space and should not be exposed to
> + * userspace via a file descriptor nor BPF hooks except for LSM
> + * (see inet_create(), inet_release(), etc).
> + *
> + * The socket bypasses some LSMs that take care of @kern in
> + * security_socket_create() and security_socket_post_create().
> + *
> + * The socket holds a reference count of @net so that the caller
> + * does not need to care about @net's lifetime.
> + *
> + * This MUST NOT be called from the __net_init path and @net MUST
> + * be alive as of calling sock_create_net().
> + *
> + * Context: Process context. This function internally uses GFP_KERNEL.
> + * Return: 0 or an error.
> + */
> +int sock_create_kern(struct net *net, int family, int type, int protocol,
> +		     struct socket **res)
> +{
> +	int ret;
> +
> +	DEBUG_NET_WARN_ON_ONCE(!net_initialized(net));
> +
> +	ret = __sock_create(net, family, type, protocol, res, 1);
> +	if (!ret)

A small suggestion if you have to send a v2: when quickly reading the
code, I find it easy to interpret the code above as: "in case of error
with __sock_create(), the refcnt is upgraded" . It might be clearer to
simply rename "ret" to "err" or use "(ret < 0)".

Up to you, a small detail for those who didn't directly realise what
"ret" is :)

> +		sk_net_refcnt_upgrade((*res)->sk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(sock_create_kern);
> +
>  static struct socket *__sys_socket_create(int family, int type, int protocol)
>  {
>  	struct socket *sock;
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


