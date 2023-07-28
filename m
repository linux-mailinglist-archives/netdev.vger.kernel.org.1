Return-Path: <netdev+bounces-22315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF14767020
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD83E1C2196F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E113FF0;
	Fri, 28 Jul 2023 15:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52214A94
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:44 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9534227
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584341f9cb3so55867457b3.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556618; x=1691161418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eb7blXMmKT6eOuSNlN0P6HrBcwHopXvTvljt6g3ouQM=;
        b=3GQ8KYfxzU4HdS46vN3izGrixSO11p/QhCpA/isAF5l3WtApqUbIoRIFkWDPt3PO6p
         F39Y1fmCbEcc9iA6XLeerr+5XuR50v6ZeHX4rx9qEMLUz+sKvtehZ1A++WlaF31Skb93
         Y3FNh+Z2m+hNMnUDo3KdtVCFAr+ke6TjliUOAgKUgbNdPYG+dlmawCjpajaMmQWiwZKj
         drGfYaS0FL3avQPiesbuctB+X/tv8iEyjCKvbFusD4c5/oSHzKsKpt41kQEHY257XiBx
         Gj8niDoXcLyuxyym0aovB+CNDajPr3bcy4mGkOh0Jm0Nl25auCFDL7a4XKUhPiDYt3E5
         DhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556618; x=1691161418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eb7blXMmKT6eOuSNlN0P6HrBcwHopXvTvljt6g3ouQM=;
        b=bRuss7hAD06QQD7m5eYZup18OIxgf3dz3cvAYww15WANt5jKu40sECgETsYAgzPKqE
         /9P54kLq6TQpoWK0ABW06pjQquMfwU/dcoNHKZZQoF1qhZQxcs43kwamR0rWL81r5Wgn
         cyobMuYNNmLhM6Ujer984gQxGFDad/bB6/W6khCJqUt/ixFBvZsjjfEM0DCiX4XaqgoS
         MXCxv2skhuTyU6PPN9645TzHZac9s6OAj4tXMmPGPb8Hm0u4mPmPagQ2Ki+8fUVtzPXy
         uRiO6Mxrkr9OeLjHNTxGbHvlAHqR7VJQhuJ86/El3TaKRY4rjOK3IZ6p5r+aloOzrMo7
         xfHw==
X-Gm-Message-State: ABy/qLbVrX1Xjt4GpWkfqCy70B5QaVTaZnhfaeJ0heAW6Zw/RxMqm87t
	plEUgYlwxATnAThsKQoyvbtMQ5OnMXIyJA==
X-Google-Smtp-Source: APBJJlEMeKdvnTwVWR8AP5qh/zmbFFhsoPkc8Y9wIQQHeALxXjfIAZX01VP+2g+qwYt0dXJMod1n3XdARDBedQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:788e:0:b0:57a:6019:62aa with SMTP id
 t136-20020a81788e000000b0057a601962aamr21605ywc.5.1690556618740; Fri, 28 Jul
 2023 08:03:38 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:17 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-11-edumazet@google.com>
Subject: [PATCH net 10/11] net: add missing data-race annotation for sk_ll_usec
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

In a prior commit I forgot that sk_getsockopt() reads
sk->sk_ll_usec without holding a lock.

Fixes: 0dbffbb5335a ("net: annotate data race around sk_ll_usec")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d57acaee42d4b1204d34baf6f8ab64cd5a0c3abf..f11e19c7edfb46475b32cee3d1af1df45442f40c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1900,7 +1900,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	case SO_BUSY_POLL:
-		v.val = sk->sk_ll_usec;
+		v.val = READ_ONCE(sk->sk_ll_usec);
 		break;
 	case SO_PREFER_BUSY_POLL:
 		v.val = READ_ONCE(sk->sk_prefer_busy_poll);
-- 
2.41.0.585.gd2178a4bd4-goog


