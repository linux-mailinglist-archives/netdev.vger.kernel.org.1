Return-Path: <netdev+bounces-46322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F57E3322
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8509A1C2091B
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417EA20;
	Tue,  7 Nov 2023 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JlfLPzha"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AE651
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 02:37:29 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E6FD51
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 18:37:27 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5056059e0so74173561fa.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699324645; x=1699929445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ag1vqlZRaktWdg6szgML9cajZnEi6ZYK3MTjrbTdg=;
        b=JlfLPzha0yJfaAZPfxhTA4qtghQ2mVNhXKnfKH4oLwhrZ5J4nCBj85RbmFTYcrIk3D
         PSV89sEKZa3FL/pYfI2dG/2W47xLvaMSX0JqrT9PelxlH9gmfDMGl/lJ8sEpe5ef+DiJ
         HSVeCntlxRdN3GyC3R/7tfvtcy6RNZws7bp3m/rO4ls/SdOLBINJMRT6ZyQZSW1c+UbT
         JNjFHuaXNCLG8wHl1vM2sWEW9szBELg1PwHJx4zr8HtBYPShh1kg+F8CuGHHgGunZNQC
         ZqpeAK+HFahN7OInPsPbCiA9PCYsW9RPZRppA0qYAT4pl8U8AZ+6mViZuBOfDLAyCKk6
         S8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699324645; x=1699929445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2ag1vqlZRaktWdg6szgML9cajZnEi6ZYK3MTjrbTdg=;
        b=jZeYQx5cRaANCwnWf6lpuXE9DH8bFn1RhOqhnBesx7UKpdzW6RyB9VjHFKM8K1Qtxp
         a4uS4NASSXlqYfcU/FZtopYQctvCO5nQnO0jitD7C7S2/7skiZ0VZ1YO6fxUH36Q6W9Y
         DjWRykfweMuXSby1Oxeir2pGm0UnPpGUK6IS2WK2zzFWhXSBIMh0bsTBffZmoAKPhxF1
         TK5sZ6KlwpRKcFLedpdBFUBo0PeczPo3gyCbO/l298JLgQl7Mx6QDGEIrAIOSErXjB5H
         ABc28+HP5UHjn1LFjAXheE6nkyV27jD4oCgQeyPNkqtO62OmlRTETxdxZo/f6Mk+k0J3
         lfdw==
X-Gm-Message-State: AOJu0YyaZ+1eygjU5t5+votTzUE+Knd+T91mfGCNN71CE+pbqric/XZN
	OZQA4gUm2s7oAuthKWmZgVnkbQ==
X-Google-Smtp-Source: AGHT+IHW1r1GDscl/3LTXeATPrP+sGKKFYl+mpOOf5TrjPtTC+ZJxF1cjKDEqt+QizXIr6dGf0sv7g==
X-Received: by 2002:a2e:b0dc:0:b0:2c5:174b:9a53 with SMTP id g28-20020a2eb0dc000000b002c5174b9a53mr23870747ljl.26.1699324645325;
        Mon, 06 Nov 2023 18:37:25 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003fc16ee2864sm13949594wmo.48.2023.11.06.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 18:37:24 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Salam Noureddine <noureddine@arista.com>,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: ahash - Set using_shash for cloned ahash wrapper over shash
Date: Tue,  7 Nov 2023 02:37:17 +0000
Message-ID: <20231107023717.820093-1-dima@arista.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cloned child of ahash that uses shash under the hood should use
shash helpers (like crypto_shash_setkey()).

The following panic may be observed on TCP-AO selftests:

> ==================================================================
> BUG: KASAN: wild-memory-access in crypto_mod_get+0x1b/0x60
> Write of size 4 at addr 5d5be0ff5c415e14 by task connect_ipv4/1397
>
> CPU: 0 PID: 1397 Comm: connect_ipv4 Tainted: G        W          6.6.0+ #47
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x46/0x70
>  kasan_report+0xc3/0xf0
>  kasan_check_range+0xec/0x190
>  crypto_mod_get+0x1b/0x60
>  crypto_spawn_alg+0x53/0x140
>  crypto_spawn_tfm2+0x13/0x60
>  hmac_init_tfm+0x25/0x60
>  crypto_ahash_setkey+0x8b/0x100
>  tcp_ao_add_cmd+0xe7a/0x1120
>  do_tcp_setsockopt+0x5ed/0x12a0
>  do_sock_setsockopt+0x82/0x100
>  __sys_setsockopt+0xe9/0x160
>  __x64_sys_setsockopt+0x60/0x70
>  do_syscall_64+0x3c/0xe0
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> ==================================================================
> general protection fault, probably for non-canonical address 0x5d5be0ff5c415e14: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 1397 Comm: connect_ipv4 Tainted: G    B   W          6.6.0+ #47
> Call Trace:
>  <TASK>
>  ? die_addr+0x3c/0xa0
>  ? exc_general_protection+0x144/0x210
>  ? asm_exc_general_protection+0x22/0x30
>  ? add_taint+0x26/0x90
>  ? crypto_mod_get+0x20/0x60
>  ? crypto_mod_get+0x1b/0x60
>  ? ahash_def_finup_done1+0x58/0x80
>  crypto_spawn_alg+0x53/0x140
>  crypto_spawn_tfm2+0x13/0x60
>  hmac_init_tfm+0x25/0x60
>  crypto_ahash_setkey+0x8b/0x100
>  tcp_ao_add_cmd+0xe7a/0x1120
>  do_tcp_setsockopt+0x5ed/0x12a0
>  do_sock_setsockopt+0x82/0x100
>  __sys_setsockopt+0xe9/0x160
>  __x64_sys_setsockopt+0x60/0x70
>  do_syscall_64+0x3c/0xe0
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>  </TASK>
> RIP: 0010:crypto_mod_get+0x20/0x60

Make sure that the child/clone has using_shash set when parent is
an shash user.

Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 crypto/ahash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index deee55f939dc..80c3e5354711 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -651,6 +651,7 @@ struct crypto_ahash *crypto_clone_ahash(struct crypto_ahash *hash)
 			err = PTR_ERR(shash);
 			goto out_free_nhash;
 		}
+		nhash->using_shash = true;
 		*nctx = shash;
 		return nhash;
 	}

base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
-- 
2.42.0


