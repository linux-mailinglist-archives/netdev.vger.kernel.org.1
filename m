Return-Path: <netdev+bounces-22306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D601767015
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FA2282752
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88413FF5;
	Fri, 28 Jul 2023 15:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EB13FEA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:25 +0000 (UTC)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A4B35A3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:23 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-403b134421cso16466401cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556603; x=1691161403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2/wDYaAN7h4XxxdM91DxAc5rbFseeRnOQQ3yh/2xlk=;
        b=N2vp1LTWm5tKVfMplTAF2PKKxyTNrMjsUIY/lsK4NA7fBFTWoPiPYwCrI8itNfokwJ
         5sSmBswq3yL676izf9SJa7m5SWRH2fGqieLqsGU6pOsmwqbSq9QI80Veog1y54h2i9xc
         ntRJjlYqsaELO4AIT9OMgo21vVF4Gz0bDmodn3SkZdj6RnKSAkU85GUfVzBCX0KcVYqA
         FrgFOYO9+Af4/7ErDlpovNmgWV8iX9SS8yEUq3YHbpW06Fn8uW7n7MtoymAUaxO/7y79
         NPO7g+D1KbKaE9/VyNcj4/hiR6Xl3XN2UhSpcESoIPtbg7k9rAyOK4aTigwnREyOb9Pl
         F+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556603; x=1691161403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2/wDYaAN7h4XxxdM91DxAc5rbFseeRnOQQ3yh/2xlk=;
        b=lTY0MACQYj180KADHyohzYP5r3HNVghmyC/EkcDWmbAddHZz5OymG7bljNq6z5tKtY
         gLvve4HbtH6EAtCbHLP7ZkOhChXtbn10RdkRqje/mtmYTBjxDFV4DHD73VxSR50RWhdH
         q2sAhqiMmdlk2LL5BIgQNUoKThLbhuQ7UUF/tJGnLsLSBxAu1JCj+jyVWRLLB2wtWEee
         xPITrmBWGLUlltYVMdR12aLbcUf/TVASEYIRq7RfrKrHPaeKCPXAAbamqijJ5XCfqyyy
         sleWy6sWUg0wCMjcXvCisaEcBuOiROqqPEotycWSiU/o9+PZaPYV8BQ2Tm8vPV8WNA9f
         q8Jg==
X-Gm-Message-State: ABy/qLZH6BU4GzLjswhNqBWy9ZDbJCzV5LDaIkSniVLprCUGYY18jz8v
	0NNP19ZPTgv/kmb+ICw2PMpvdx4k5+GbPA==
X-Google-Smtp-Source: APBJJlGUNKSS2jJY12LOXU8/i1zvpGr4lxLYz+6+3VC+XTplsALaCIsqRyGPiVJxVTNSAr+kE9qFBP2MOxenpg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:1a85:b0:3ff:2517:172 with SMTP
 id s5-20020a05622a1a8500b003ff25170172mr15735qtc.0.1690556603121; Fri, 28 Jul
 2023 08:03:23 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:08 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-2-edumazet@google.com>
Subject: [PATCH net 01/11] net: annotate data-races around sk->sk_reserved_mem
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_getsockopt() runs locklessly. This means sk->sk_reserved_mem
can be read while other threads are changing its value.

Add missing annotations where they are needed.

Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weiwan@google.com>
---
 net/core/sock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9370fd50aa2c9d84b86651433c0df338a1518547..bd201d15e72aad4ea0b11941eaaa992de706634a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1007,7 +1007,7 @@ static void sock_release_reserved_memory(struct sock *sk, int bytes)
 	bytes = round_down(bytes, PAGE_SIZE);
 
 	WARN_ON(bytes > sk->sk_reserved_mem);
-	sk->sk_reserved_mem -= bytes;
+	WRITE_ONCE(sk->sk_reserved_mem, sk->sk_reserved_mem - bytes);
 	sk_mem_reclaim(sk);
 }
 
@@ -1044,7 +1044,8 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	}
 	sk->sk_forward_alloc += pages << PAGE_SHIFT;
 
-	sk->sk_reserved_mem += pages << PAGE_SHIFT;
+	WRITE_ONCE(sk->sk_reserved_mem,
+		   sk->sk_reserved_mem + (pages << PAGE_SHIFT));
 
 	return 0;
 }
@@ -1973,7 +1974,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_RESERVE_MEM:
-		v.val = sk->sk_reserved_mem;
+		v.val = READ_ONCE(sk->sk_reserved_mem);
 		break;
 
 	case SO_TXREHASH:
-- 
2.41.0.585.gd2178a4bd4-goog


