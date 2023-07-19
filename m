Return-Path: <netdev+bounces-19271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1720F75A1DC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483D01C211D5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDE2516B;
	Wed, 19 Jul 2023 22:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C317FE9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 22:27:10 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E68226BF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 15:26:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-403b6b7c0f7so1774631cf.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 15:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689805596; x=1690410396;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP+JX+PW/j/FBnezQE1zfVtv5VoOh6/Tn0Ser/4xCKI=;
        b=ft3GWq6ZW2gRdoHYXcm03f7+easVJqeqUnMMNxjx+md5W/JAZ2vkPnAU5BoKnlY/dM
         EDZH3JMiG/K9skdBEBPy2QnS06qpGkOFuUL9zQrNxbuIcCCLm3//hPuq2IjGQCdCv3Rv
         Xcuny++G1KEJU7AmD0/h1OkGDofUPtgx0Z3sv7xUxm9e8TdN5plqrj3Tik9AC9Rp9YFn
         Jb5hzzH2VI2jCH4VN5jmj7q04L5SmE//jebGIJ7eCLIR2X+LHnVoexPc9ApuZ1bpYdOX
         o0StRZm3/y6seJGyqwGnOpBSdmAPCTHEY8sTLOAnLS4EqvFRN/YGbyvF4OMDa0wTSmkT
         xu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805596; x=1690410396;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hP+JX+PW/j/FBnezQE1zfVtv5VoOh6/Tn0Ser/4xCKI=;
        b=i7YbLYOZGHqWdy2QdGGis/m7poaW3mDPQUgFdzzVhto0emq0BxzXDMHUGPSTkypDpx
         HOZmztBwEPo9Pq2L8ikzfN8kAHl84A7Eg3DPXKy/oG3/2Q3JigKB1jGynI7/QnP47EeL
         U88ERf5PCF16J6fDBN3GLjKriyw4jDn5EDm6a2nWvNHZaMvqJBo4fX8QlyTL+abAZEqa
         e53uJI0cWhQzARhQes0b8/fvwH4mKn4LOAGGGWHS7AjHCqW6dNs9xCxukB20Cq8nBqJ0
         XBWRjoV5Hg5bx3CGs+6M/BPZIg8Y2eAXBE3vbS7kMS+2F2Dk7eRwVXe4eyDHBN5dJFRm
         6u8Q==
X-Gm-Message-State: ABy/qLZPUz1uNWmy0qees6ko0PcupY+6ygwkyk6V4UtIQeGwpW5X2BI4
	CMP2OYf2Xtl6vLbWEwvzRHc=
X-Google-Smtp-Source: APBJJlEGxzQjb5S5nCwuB3Bcav2ZB3YQSckU3QAylngnYSybnAmed/cXp5mhmQ7ox+BQ2rOPmjUqpg==
X-Received: by 2002:a05:622a:210:b0:403:b382:613f with SMTP id b16-20020a05622a021000b00403b382613fmr23595612qtx.44.1689805596104;
        Wed, 19 Jul 2023 15:26:36 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id qf1-20020a0562144b8100b006360931c12fsm1754380qvb.96.2023.07.19.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:26:35 -0700 (PDT)
Date: Wed, 19 Jul 2023 18:26:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Breno Leitao <leitao@debian.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org, 
 syzkaller <syzkaller@googlegroups.com>
Message-ID: <64b8631b8f1b0_286a73294cc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230719185322.44255-2-kuniyu@amazon.com>
References: <20230719185322.44255-1-kuniyu@amazon.com>
 <20230719185322.44255-2-kuniyu@amazon.com>
Subject: RE: [PATCH v1 net 1/2] af_unix: Fix fortify_panic() in
 unix_bind_bsd().
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kuniyuki Iwashima wrote:
> syzkaller found a bug in unix_bind_bsd() [0].  We can reproduce it
> by bind()ing a socket on a path with length 108.
> 
> 108 is the size of sun_addr of struct sockaddr_un and is the maximum
> valid length for the pathname socket.  When calling bind(), we use
> struct sockaddr_storage as the actual buffer size, so terminating
> sun_addr[108] with null is legitimate.
> 
> However, strlen(sunaddr) for such a case causes fortify_panic() if
> CONFIG_FORTIFY_SOURCE=y.  __fortify_strlen() has no idea about the
> actual buffer size and takes 108 as overflow, although 108 still
> fits in struct sockaddr_storage.
> 
> Let's make __fortify_strlen() recognise the actual buffer size.
> 
> [0]:
> detected buffer overflow in __fortify_strlen
> kernel BUG at lib/string_helpers.c:1031!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 255 Comm: syz-executor296 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
> lr : fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
> sp : ffff800089817af0
> x29: ffff800089817af0 x28: ffff800089817b40 x27: 1ffff00011302f68
> x26: 000000000000006e x25: 0000000000000012 x24: ffff800087e60140
> x23: dfff800000000000 x22: ffff800089817c20 x21: ffff800089817c8e
> x20: 000000000000006c x19: ffff00000c323900 x18: ffff800086ab1630
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
> x14: 1ffff00011302eb8 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 64a26b65474d2a00
> x8 : 64a26b65474d2a00 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff800089817438 x4 : ffff800086ac99e0 x3 : ffff800080f19e8c
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000000000000002c
> Call trace:
>  fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
>  _Z16__fortify_strlenPKcU25pass_dynamic_object_size1 include/linux/fortify-string.h:217 [inline]
>  unix_bind_bsd net/unix/af_unix.c:1212 [inline]
>  unix_bind+0xba8/0xc58 net/unix/af_unix.c:1326
>  __sys_bind+0x1ac/0x248 net/socket.c:1792
>  __do_sys_bind net/socket.c:1803 [inline]
>  __se_sys_bind net/socket.c:1801 [inline]
>  __arm64_sys_bind+0x7c/0x94 net/socket.c:1801
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
>  el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> Code: aa0003e1 d0000e80 91030000 97ffc91a (d4210000)
> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

The extensive comments are really helpful to understand what's
going on.

An alternative would be to just cast sunaddr to a struct
sockaddr_storage *ss and use that both here and in unix_mkname_bsd?
It's not immediately trivial that the caller has always actually
allocated one of those. But the rest becomes self documenting.

> ---
>  net/unix/af_unix.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 123b35ddfd71..e1b1819b96d1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -302,6 +302,18 @@ static void unix_mkname_bsd(struct sockaddr_un *sunaddr, int addr_len)
>  	((char *)sunaddr)[addr_len] = 0;
>  }
>  
> +static int unix_strlen_bsd(struct sockaddr_un *sunaddr)
> +{
> +	/* Don't pass sunaddr->sun_path to strlen().  Otherwise, the
> +	 * max valid length UNIX_PATH_MAX (108) will cause panic if
> +	 * CONFIG_FORTIFY_SOURCE=y.  Let __fortify_strlen() know that
> +	 * the actual buffer is struct sockaddr_storage and that 108
> +	 * is within __data[].  See also: unix_mkname_bsd().
> +	 */
> +	return strlen(((struct sockaddr_storage *)sunaddr)->__data) +
> +		offsetof(struct sockaddr_un, sun_path) + 1;
> +}
> +
>  static void __unix_remove_socket(struct sock *sk)
>  {
>  	sk_del_node_init(sk);
> @@ -1209,9 +1221,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
>  	int err;
>  
>  	unix_mkname_bsd(sunaddr, addr_len);
> -	addr_len = strlen(sunaddr->sun_path) +
> -		offsetof(struct sockaddr_un, sun_path) + 1;
> -
> +	addr_len = unix_strlen_bsd(sunaddr);
>  	addr = unix_create_addr(sunaddr, addr_len);
>  	if (!addr)
>  		return -ENOMEM;
> -- 
> 2.30.2
> 



