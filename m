Return-Path: <netdev+bounces-15985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F974AC98
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED001C20F61
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A9883B;
	Fri,  7 Jul 2023 08:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60565A925
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:13:15 +0000 (UTC)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDF61FDD
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:13:13 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so2204025a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 01:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717593; x=1691309593;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo4MAJ4BG1isgQnCAcKhexSWW5SZFcBYqjHiQhX1gxE=;
        b=fF/O8/iuY9heHQv6s0uR1QLsgI0XBdxFqmEwEojcLhtCEAuoMNZQYXmGr1VV6Z6VhO
         uFcSjxeH9dzVz+NoarH0kybQq06CydNXL9QnMwvzrTPBXQlc2fBP1KA62htneXjgXIoA
         1x5mBUxrYBCt8v7CFcb7i1ttaJmQtkgknf2qbW3O5Iy8PphmwUGWqs4f2i+X62rAu+qo
         EsGnwhYMnN7n4oUh2bxGArtKBc+9r16U4i2KApjBfXZIg8cSkOX3b8oN0k3JPq+KA/Ky
         p5DlxtGZWm1Fy8uaDoVBrOMhXmqoMB5mRYWsl6jLiHuo4V4aALkIW5IeL/3n+5+Lu7EB
         omKQ==
X-Gm-Message-State: ABy/qLaQn+eeYgZmj6qbLFs5GSc3I2QBHIbz53fPSJO/pi0RCn5D3aJp
	u2ie3yrS5k53VVnwkrLmLZUcSTgpgLBwg5T2op+gydMM0NCA
X-Google-Smtp-Source: APBJJlE8hdToDJUDSlXhxZYGiozwGB/sggmA9Bou6VF3XK3kUJgxxs4q8gGavIF8Kn9djr+rnYwWBB6vWfCEmjnY26ERZZsdnAjy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:b253:0:b0:553:9efa:1159 with SMTP id
 t19-20020a63b253000000b005539efa1159mr3380049pgo.0.1688717593343; Fri, 07 Jul
 2023 01:13:13 -0700 (PDT)
Date: Fri, 07 Jul 2023 01:13:13 -0700
In-Reply-To: <2225020.1688717586@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004700d505ffe1348d@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Write in
 crypto_sha3_final (2)
From: syzbot <syzbot+e436ef6c393283630f64@syzkaller.appspotmail.com>
To: dhowells@redhat.com
Cc: davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I'm pretty certain this is the same as:
>
> 	https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
>
> as I sometimes see the same trace when running the reproducer from there.
> ---
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
>     crypto: algif/hash: Fix race between MORE and non-MORE sends
>     
>     The 'MSG_MORE' state of the previous sendmsg() is fetched without the
>     socket lock held, so two sendmsg calls can race.  This can be seen with a
>     large sendfile() as that now does a series of sendmsg() calls, and if a
>     write() comes in on the same socket at an inopportune time, it can flip the
>     state.
>     
>     Fix this by moving the fetch of ctx->more inside the socket lock.
>     
>     Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
>     Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
>     Link: https://lore.kernel.org/r/000000000000554b8205ffdea64e@google.com/
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Herbert Xu <herbert@gondor.apana.org.au>
>     cc: Paolo Abeni <pabeni@redhat.com>
>     cc: "David S. Miller" <davem@davemloft.net>
>     cc: Eric Dumazet <edumazet@google.com>
>     cc: Jakub Kicinski <kuba@kernel.org>
>     cc: linux-crypto@vger.kernel.org
>     cc: netdev@vger.kernel.org
>
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 0ab43e149f0e..82c44d4899b9 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -68,13 +68,15 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
>  	struct hash_ctx *ctx = ask->private;
>  	ssize_t copied = 0;
>  	size_t len, max_pages, npages;
> -	bool continuing = ctx->more, need_init = false;
> +	bool continuing, need_init = false;
>  	int err;
>  
>  	max_pages = min_t(size_t, ALG_MAX_PAGES,
>  			  DIV_ROUND_UP(sk->sk_sndbuf, PAGE_SIZE));
>  
>  	lock_sock(sk);
> +	continuing = ctx->more;
> +
>  	if (!continuing) {
>  		/* Discard a previous request that wasn't marked MSG_MORE. */
>  		hash_free_result(sk, ctx);
>

