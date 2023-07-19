Return-Path: <netdev+bounces-19243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA075A068
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EA51C21017
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72922EE5;
	Wed, 19 Jul 2023 21:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF61BB23
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:15:12 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEF1FD2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:15:10 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-768197bad1cso14186185a.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689801310; x=1690406110;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+AuQJ811MncHuzJaQTmxyZLhN4NyQKwauvnfOHTlsA=;
        b=qc1q5+tjlE6/1x9+ZqT6Yd5Yh1IMxNDNuioOF007A6LXilNP9doHddvNKZ7N9XPld1
         YtlPIz22Uj7tk8ikOx1PCMiWk4M1UmoROsvi4AF0gF11XLXtbcT3YEvyvPUDox/LWHcb
         APAfRHtpeINaIh7o59N1EOo+va2A9NY37cFuqHWqFeS+YV9cL1NW3Sj+Po/rYZdAKCC/
         K+ZKXu1HuT2TWPhE0XVxYSHMkBWdnoEMdHYCb17ImSmagovG+v6J+4WvMpBDQVqRTMOK
         /0jWIw1v2ABh3DSZvpVDlj86LD8sPU/dRfnX7WCxO7Qg7mmKSgWtZwzqACh1kuUx8UB4
         Etyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689801310; x=1690406110;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+AuQJ811MncHuzJaQTmxyZLhN4NyQKwauvnfOHTlsA=;
        b=JU2j+DWHaYZ8gaCoR/uLmimpizbiuM1byZVlLCpSYF5m65YawYO47+S9KIpHt2a2Me
         87x8dM/Bvq3PFr3hjH2Mu6sy4+q0WZJnSp0asmyk8HqgKkAXhB3xW2LHW308IiWn57wh
         ZJTq9KWmYNsZ17BseUJMWhtR4KxKRcHKbP5RqAN9I5qI0Kf9SwzuKYnFk3K2nL9eqQMS
         kV37J5O5N9+4pbpdiwJcgr9CF7CTDiDIC6K5WKD7OksI7DLG15I6d4ynRXwkEqCNGnnE
         zt7EPBneEjO4TmfUqt74LpniegCK6ulIMjD5D/nL80IJQp9OrMOQX6ZWMDUKk58rqMNt
         PryA==
X-Gm-Message-State: ABy/qLZGkwTCP+f68ssFB/2DhlITDZixYHNP6DCh1glUpBtzh154RMYx
	EWReV5LF8Yd8lMGsveMZICLxhxdz60A=
X-Google-Smtp-Source: APBJJlHsr1Fjfh0t0ZQyRMIltfauIBm0GHHWEbomDmQA9kw7DNud+HaZDKkY/RGGkoLOByspGut0dQ==
X-Received: by 2002:a05:620a:172b:b0:763:9e42:6bf7 with SMTP id az43-20020a05620a172b00b007639e426bf7mr27065263qkb.66.1689801309722;
        Wed, 19 Jul 2023 14:15:09 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a13ef00b007684220a08csm394351qkl.70.2023.07.19.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:15:09 -0700 (PDT)
Date: Wed, 19 Jul 2023 17:15:09 -0400
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
Message-ID: <64b8525db522_2831cb294d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230719185322.44255-3-kuniyu@amazon.com>
References: <20230719185322.44255-1-kuniyu@amazon.com>
 <20230719185322.44255-3-kuniyu@amazon.com>
Subject: RE: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy()
 in packet_getname().
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kuniyuki Iwashima wrote:
> syzkaller found a warning in packet_getname() [0], where we try to
> copy 16 bytes to sockaddr_ll.sll_addr[8].
> 
> Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
> by struct in6_addr.

Some are even larger. MAX_ADDR_LEN == 32. I think Infiniband may use
that?
 
> The write seems to overflow, but actually not since we use struct
> sockaddr_storage defined in __sys_getsockname().

Which gives _K_SS_MAXSIZE == 128, minus offsetof(struct sockaddr_ll, sll_addr).

For fun, there is another caller. getsockopt SO_PEERNAME also calls
sock->ops->getname, with a buffer hardcoded to 128. Should probably
use sizeof(sockaddr_storage) for documentation, at least.

.. and I just noticed that that was attempted, but not completed
https://lore.kernel.org/lkml/20140928135545.GA23220@type.youpi.perso.aquilenet.fr/

> 
> To avoid the warning, we need to let __fortify_memcpy_chk() know the
> actual buffer size.
> 
> Another option would be to use strncpy() and limit the copied length
> to sizeof(sll_addr), but it will return the partial address and might
> break an application that passes sockaddr_storage to getsockname().

Yeah, that would break stuff.
 
> [0]:
> memcpy: detected field-spanning write (size 16) of single field "sll->sll_addr" at net/packet/af_packet.c:3604 (size 8)
> WARNING: CPU: 0 PID: 255 at net/packet/af_packet.c:3604 packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> Modules linked in:
> CPU: 0 PID: 255 Comm: syz-executor750 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> lr : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
> sp : ffff800089887bc0
> x29: ffff800089887bc0 x28: ffff000010f80f80 x27: 0000000000000003
> x26: dfff800000000000 x25: ffff700011310f80 x24: ffff800087d55000
> x23: dfff800000000000 x22: ffff800089887c2c x21: 0000000000000010
> x20: ffff00000de08310 x19: ffff800089887c20 x18: ffff800086ab1630
> x17: 20646c6569662065 x16: 6c676e697320666f x15: 0000000000000001
> x14: 1fffe0000d56d7ca x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 3e60944c3da92b00
> x8 : 3e60944c3da92b00 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff8000898874f8 x4 : ffff800086ac99e0 x3 : ffff8000803f8808
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
> Call trace:
>  packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
>  __sys_getsockname+0x168/0x24c net/socket.c:2042
>  __do_sys_getsockname net/socket.c:2057 [inline]
>  __se_sys_getsockname net/socket.c:2054 [inline]
>  __arm64_sys_getsockname+0x7c/0x94 net/socket.c:2054
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
>  el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/packet/af_packet.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 85ff90a03b0c..5eef94a32a4f 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3601,7 +3601,10 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	if (dev) {
>  		sll->sll_hatype = dev->type;
>  		sll->sll_halen = dev->addr_len;
> -		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
> +
> +		/* Let __fortify_memcpy_chk() know the actual buffer size. */
> +		memcpy(((struct sockaddr_storage *)sll)->__data +
> +		       offsetof(struct sockaddr_ll, sll_addr), dev->dev_addr, dev->addr_len);
>  	} else {
>  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
>  		sll->sll_halen = 0;
> -- 
> 2.30.2
> 



