Return-Path: <netdev+bounces-34996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D97A6644
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54091C20961
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DC93FB38;
	Tue, 19 Sep 2023 14:15:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179A1863A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:14:57 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD83CC3
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:14:09 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1cca0a1b3c7so3660323fac.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695132849; x=1695737649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTJqvPxX6FaZZaFRNiPga+TAVPvYlxI3dTYbfsQ5sKo=;
        b=jN0lG3gbDl9jf+hWdP68y6br8IGs/+8SvSVkKkv1fbEK0Cq6FZFkxZ8pKmk+0CPklt
         4o/4JKSxSmVEpG/+Cw5lD2HW8hfLzGu9n+DIdfdIew5cKdMCYVRdk4btzO9qibk2tZWU
         I8epCgZrNuB7Kl7AEbaIyNMvmImXIXiIZNd89J6oQ+1hZFwxSL32YyhYbrvwqe/zMS+W
         DC4zzxygwx3kapRV4RGYGhxt9cU+s/6st9VPNgF3J4SfIRUL0jGovtgOdj3IG0DbqbzN
         Mp+QaXjhXM48HJq2V/EzHsxPKtC53GErkqlF9UFSIYzVay/Z/DEsaj8xJN4I+dFYOBOi
         vkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132849; x=1695737649;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTJqvPxX6FaZZaFRNiPga+TAVPvYlxI3dTYbfsQ5sKo=;
        b=ervDC0uCbcU91hpNev2Ly3UWCa3ewUscghGI0GxdMtaWtpsMG0jY+XY71A4ATUF1Vf
         jx+hxZyamrmqaO1LKyjNlHNq4opFKIaNcUFIL3bMxvQFwCvaHpLYTknZXU+nVKnm3LZj
         CG8dZcjzRd2o8jecxks84uLCHfuZktgw2EiWlIZ4YN7cXAkSEhrYFvakelrYI1utYKRG
         a/y5iJoEEreTL5sgWOl97FkG6se0tDNjtbklalugr3w19DNtRqOGq5mBKW2uNezlbkvx
         Voxt/S+/zzv9qqBAdp/QNW44TDDQU3AvciKmAUQhEP/KeEvjtNc17esc3fM5oLLVhxOx
         SYfA==
X-Gm-Message-State: AOJu0Yyngk5KyLZ+lRbho5AotfbIABoC0Uq85ElqLCkFlOA/mTYNEf+X
	+7rbCRCY+tEWUyI6d9mx+pk=
X-Google-Smtp-Source: AGHT+IHeWsoFSDZu2MWA9XayhVx0SaIWudSoKcQF3d7YF9LtoCqZ5iyUMLpLRfdTKxp/KN66idGCHw==
X-Received: by 2002:a05:6870:4153:b0:1d5:a6ac:ac92 with SMTP id r19-20020a056870415300b001d5a6acac92mr14839577oad.38.1695132848752;
        Tue, 19 Sep 2023 07:14:08 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id e5-20020ac80645000000b0041520676966sm3806910qth.47.2023.09.19.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:14:08 -0700 (PDT)
Date: Tue, 19 Sep 2023 10:14:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jordan Rife <jrife@google.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Cc: dborkman@kernel.org, 
 Jordan Rife <jrife@google.com>
Message-ID: <6509acb026cd0_1dda19294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230919004636.147954-1-jrife@google.com>
References: <20230919004636.147954-1-jrife@google.com>
Subject: Re: [PATCH net v3 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jordan Rife wrote:
> Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> space may observe their value of msg_name change in cases where BPF
> sendmsg hooks rewrite the send address. This has been confirmed to break
> NFS mounts running in UDP mode and has the potential to break other
> systems.
> 
> This patch:
> 
> 1) Creates a new function called __sock_sendmsg() with same logic as the
>    old sock_sendmsg() function.
> 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
>    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
>    as these system calls are already protected.
> 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
>    present before passing it down the stack to insulate callers from
>    changes to the send address.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> Signed-off-by: Jordan Rife <jrife@google.com>
> ---
> v2->v3: Add "Fixes" tag.
> v1->v2: Split up original patch into patch series. Perform address copy
> 	in sock_sendmsg() instead of sock->ops->sendmsg().
> 
>  net/socket.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index eb7f14143caed..2d34a69b84406 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -737,6 +737,14 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
>  	return ret;
>  }
>  
> +static int __sock_sendmsg(struct socket *sock, struct msghdr *msg)
> +{
> +	int err = security_socket_sendmsg(sock, msg,
> +					  msg_data_left(msg));
> +
> +	return err ?: sock_sendmsg_nosec(sock, msg);
> +}
> +
>  /**
>   *	sock_sendmsg - send a message through @sock
>   *	@sock: socket
> @@ -747,10 +755,22 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
>   */
>  int sock_sendmsg(struct socket *sock, struct msghdr *msg)
>  {
> -	int err = security_socket_sendmsg(sock, msg,
> -					  msg_data_left(msg));
> +	struct sockaddr_storage address;
> +	struct sockaddr_storage *save_addr = (struct sockaddr_storage *)msg->msg_name;

Since there's feedback on patch 3/3: please maintain reverse xmas tree:
reorder these two declarations from longest to shortest.
> +	int ret;
>  
> -	return err ?: sock_sendmsg_nosec(sock, msg);
> +	if (msg->msg_name) {
> +		if (msg->msg_namelen < 0 || msg->msg_namelen > sizeof(address))
> +			return -EINVAL;
> +
> +		memcpy(&address, msg->msg_name, msg->msg_namelen);
> +		msg->msg_name = &address;
> +	}
> +
> +	ret = __sock_sendmsg(sock, msg);
> +	msg->msg_name = save_addr;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(sock_sendmsg);
>  
> @@ -1138,7 +1158,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (sock->type == SOCK_SEQPACKET)
>  		msg.msg_flags |= MSG_EOR;
>  
> -	res = sock_sendmsg(sock, &msg);
> +	res = __sock_sendmsg(sock, &msg);
>  	*from = msg.msg_iter;
>  	return res;
>  }
> @@ -2174,7 +2194,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
>  	if (sock->file->f_flags & O_NONBLOCK)
>  		flags |= MSG_DONTWAIT;
>  	msg.msg_flags = flags;
> -	err = sock_sendmsg(sock, &msg);
> +	err = __sock_sendmsg(sock, &msg);
>  
>  out_put:
>  	fput_light(sock->file, fput_needed);
> @@ -2538,7 +2558,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
>  		err = sock_sendmsg_nosec(sock, msg_sys);
>  		goto out_freectl;
>  	}
> -	err = sock_sendmsg(sock, msg_sys);
> +	err = __sock_sendmsg(sock, msg_sys);
>  	/*
>  	 * If this is sendmmsg() and sending to current destination address was
>  	 * successful, remember it.
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 



