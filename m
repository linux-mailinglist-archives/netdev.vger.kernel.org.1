Return-Path: <netdev+bounces-19517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266575B0CF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589A71C213E7
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E40182C7;
	Thu, 20 Jul 2023 14:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5A182C0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:06:50 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB88430C3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:06:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7673180224bso71323985a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689861982; x=1690466782;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um3GYCk8SWJnGTQgFbNTyU1IShfqmRaSv58Df3tF9no=;
        b=sINLqLMXtprCye1n0jwUC9n/CDvbO7hAaZvVJD2wHN+vWqFakL7mTSrQ0A01JwxYjJ
         cNkQRhue6QvzEmluUkBNpSkYwUofBcfM3Nwt/jwLUE8lfxN/lHlb7Xzj/tbj5LDt8QFf
         oKC1b1HemotsjxkNiNCrpV7ESKA0M73vm/Om1y+vhbj3twgM2D+szfpqPKySqAX2f1yv
         VtGSKBb4ZqCpEPpeFiUAawVfqltD9E6GnrS0QEZoItklDUPnS5MDtQVdbQ+Fz86gq0JV
         S6jfR0Wj/39A8oCy18D3CoM4FP8m+7Kjq4pJEcYEGzH9n6JwIKFIAMGCKqlipuHHw8uu
         Ct2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861982; x=1690466782;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=um3GYCk8SWJnGTQgFbNTyU1IShfqmRaSv58Df3tF9no=;
        b=bVYgEYZAbKEHMLXV5i/sgle8+U9OSaDY4oQ1cma11yCgWEsesqCsIt70vh9Z6m26oK
         sN2vBhJ4onEeEIpeYHxY1cVylduaVa95qf81Xq/tQkDNDFrhsn47Y6RGF+0G+wDUESSr
         CT+2qryRGtMxt14RH4cVFvVHv7CRbbjam2yj1EbUNrCViRJY4jhEVfrT9f8YmKzPOKIf
         jOaE5cq6E7OuH3QfDwFk+ReeXdc+8vkR8z7RUuhaYQiGU1mxUfp+R6vqvCVWfN4ijiEp
         XobR0FHiR5hAFqXOPLPmOSoXT354A8R9w9PRXooGXvHDs3PrKBwzvyg0a8UblSocjSfP
         Z3bA==
X-Gm-Message-State: ABy/qLan2Fy6KNDYkhBd+ZoM3bTzTWJ1KnV/l12PH3kbVyn6FjRoWWA1
	yjXrfOsx3lNQKfy46x8aUV0=
X-Google-Smtp-Source: APBJJlE4sxc1eVKNWoBz2C+jvY88YtugZPyn4tysJH5aPT0k8PnXnplvYv8cxEQk/bUQBShR/NMf1Q==
X-Received: by 2002:a05:620a:3902:b0:768:d67:ee9f with SMTP id qr2-20020a05620a390200b007680d67ee9fmr6140051qkn.77.1689861981668;
        Thu, 20 Jul 2023 07:06:21 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a166a00b007671678e325sm262889qko.88.2023.07.20.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:06:21 -0700 (PDT)
Date: Thu, 20 Jul 2023 10:06:21 -0400
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
Message-ID: <64b93f5d148e0_2ad9212944c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230720004410.87588-3-kuniyu@amazon.com>
References: <20230720004410.87588-1-kuniyu@amazon.com>
 <20230720004410.87588-3-kuniyu@amazon.com>
Subject: RE: [PATCH v2 net 2/2] af_packet: Fix warning of fortified memcpy()
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
> by struct in6_addr.  Also, Infiniband has 32 bytes as MAX_ADDR_LEN.
> 
> The write seems to overflow, but actually not since we use struct
> sockaddr_storage defined in __sys_getsockname() and its size is 128
> (_K_SS_MAXSIZE) bytes.  Thus, we have sufficient room after sll_addr[]
> as __data[].
> 
> To avoid the warning, we need to let __fortify_memcpy_chk() know the
> actual buffer size.
> 
> Another option would be to use strncpy() and limit the copied length
> to sizeof(sll_addr), but it will return the partial address and break
> an application that passes sockaddr_storage to getsockname().
> 
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

Reviewed-by: Willem de Bruijn <willemb@google.com>

