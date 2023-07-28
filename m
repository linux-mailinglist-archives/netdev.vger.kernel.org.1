Return-Path: <netdev+bounces-22311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A876701B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743E8280BDF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7A14279;
	Fri, 28 Jul 2023 15:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9014268
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:33 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABE3C28
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c64ef5bde93so2136258276.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556611; x=1691161411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft7NdQXHF3jUqk0jSagrDG7l3v2MbvEhxgBUX2E1pGA=;
        b=cuSRGaSnmx+YpYER3yG8y5bvb9zWzZ8dBdCAXGnfSujfCTGHlVIX+RVMeJWd9vNrsM
         kghS9yViiCMu6e5FWSl+GLXJT6Pnon63czhnWB4MQIauaYxs0WAmwbBARBQdoN9NJiYc
         UkW4dC0qYVrwk0uIwPe/fOvimxNFDF2cVHo0qe9W25UG76FjXJ/RHJZDvdgdDkmAAgBZ
         LjXjiwOyWQax8EAGOiaQNcCq7bMIeafoPCyvhnBIe7erwD1L/BPuoYGI6K01c1A4iiJN
         XOUoTr/wh6bl+U8rr0DyjdiXsyKgB3OILfUl+BZn9tPplm/GxMMtRekqffTzNFKFf0Ig
         BKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556611; x=1691161411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft7NdQXHF3jUqk0jSagrDG7l3v2MbvEhxgBUX2E1pGA=;
        b=fzht9PBYK/6A5DZodKBYbq54g9Tlpkha8tOFqaHp34RXBM+iDmBOT0MYW2fnuZwO8Z
         qH4iK30yQfDCgKmE/cKsftOWOLbzv2OpYAvt7FFUqfPaKwZKrxOWUggrqX3enjUqd2p/
         km+BpWGRU6cVE3+zbzJdiZ5yWinbnpvRhbcLe1+NDm3NkgswxKEpTUYfPpMHbqrMxRX9
         0+uMWeIkbuPUtkgctaxmSi7LK5q8H9hSQhP3V1cz25yXQEu2d/1a40t3+5S9XRqCa8y1
         A03+GyemqpNI6amI/YSkwCS/hgN+zXR5kczDW5jnSjpQHRDxxD+AqQ1D2vEqiwO4AL6i
         vPFA==
X-Gm-Message-State: ABy/qLbtMd7f9ut+B5KJNzsFZbLgXihDxp8J+0/OsQm9Hm5I1Pf+sXh5
	tYLVQt77uO5JUMdCYPsuy3mpcDI4UQcxIQ==
X-Google-Smtp-Source: APBJJlFOgkK3fDFcCqCx8J6nDiXuJ6Egz7pY4UTuqmui4NOiVUcBPTCi1zv8Q1gm+1LwS/2GgdHEVt13RGkKYA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:160e:b0:d09:6ba9:69ec with SMTP
 id bw14-20020a056902160e00b00d096ba969ecmr10279ybb.4.1690556611648; Fri, 28
 Jul 2023 08:03:31 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:13 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-7-edumazet@google.com>
Subject: [PATCH net 06/11] net: add missing READ_ONCE(sk->sk_sndbuf) annotation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_sndbuf locklessly.

Fixes: e292f05e0df7 ("tcp: annotate sk->sk_sndbuf lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 264c99c190ac9a550d93b760d78f006b216fcb75..ca43f7a302199724ecf155e3c03add7c964fd3ef 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1639,7 +1639,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_SNDBUF:
-		v.val = sk->sk_sndbuf;
+		v.val = READ_ONCE(sk->sk_sndbuf);
 		break;
 
 	case SO_RCVBUF:
-- 
2.41.0.585.gd2178a4bd4-goog


