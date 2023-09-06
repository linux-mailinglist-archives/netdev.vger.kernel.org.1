Return-Path: <netdev+bounces-32337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6E794449
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81CB281481
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3258F11CAE;
	Wed,  6 Sep 2023 20:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5511C91
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 20:10:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A39E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:10:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fb9323a27so3018757b3.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694031055; x=1694635855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMc1SrA9sdtPR5mLF/Tme9KoRwgcO3km2zNvZk7WqGU=;
        b=Dfz2X62g411Uh7gvS30TMP+Nv45JZOC37Z3Q3c5MAkM5jVvWbsGVubZfUnCDcAB28E
         eWDu84kyBVZG1SKwAq5aufuHW3fhdWJ5W0wpaj8L2/gsQ2VMZsMfrcrDd5waeqTwYyop
         H5KwdD5o6M6FkpgObPMUtE37MsrDfas81CouJtkk03M5GjcGT/Hwnxvnwie9uqT684kF
         EuHyDBStMpETcsbGY3BYwgyRmqhP6gDgb2Co6GN9i6tA7iO1sGfZlyMFhmNvIiwMnh2T
         rOGPueHnj4TfMTwaW0TCqNneGGQAiNdY5clf4kRLCHb1j/yfzeByDGImp5gvOqRdv+/J
         sNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031055; x=1694635855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMc1SrA9sdtPR5mLF/Tme9KoRwgcO3km2zNvZk7WqGU=;
        b=CxNRx3H9XBzGku5tQ6WRQw1fU+IAVXaYhwvhEEd78fVuEBPhrT9/JmsJVQjM0TsZ04
         111O9SbqW9bjvVgCt5rbhDCk9b75MtyJMQJ5QOe+YxI0Gb2SK2W01OQ+l7g0ZydRUf5p
         glP+iDE59rvQt8wdOvf2SAjBUtv5yIy0E9+d4qJG/dJE/KjzujzCPIKTV78n8h0P1IhL
         UV2WnuUK6k9i8ALziXf9tesaYb5k48TGZj8MGo43EC7QhLC5L+CFwLrsT0/2cDEVa0K3
         yCGH8lesFhZt9bf90893ROLLq205ox888vqqr2wJe5mTkiKD+f/Jbi+of8uJ5dJpg6p4
         LGzA==
X-Gm-Message-State: AOJu0Yy6VbLR4omkI6EgeOmr4XAckC/vkVwXkcGnP56W2porcUZpTtb1
	F6hNP5kp4iCELOsC5JjMOHyn/18mEnDchw==
X-Google-Smtp-Source: AGHT+IFc+Qk3k9xrwqHAGi1rCuazH9Sg+hygo+GFel1+/5/Otjv6YKfTp9ZjhBOSPC751L/+UIqzisSEgWYRmw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a745:0:b0:583:9913:f293 with SMTP id
 e66-20020a81a745000000b005839913f293mr441239ywh.1.1694031055278; Wed, 06 Sep
 2023 13:10:55 -0700 (PDT)
Date: Wed,  6 Sep 2023 20:10:44 +0000
In-Reply-To: <20230906201046.463236-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906201046.463236-3-edumazet@google.com>
Subject: [RFC net-next 2/4] net: sock_release_ownership() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sock_release_ownership() should only be called by user
owning the socket lock.

After prior commit, we can remove one condition.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b770261fbdaf59d4d1c0b30adb2592c56442e9e3..676146e9d18117e3a04fbbfb0a06e511a80d537c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1823,12 +1823,11 @@ static inline bool sock_owned_by_user_nocheck(const struct sock *sk)
 
 static inline void sock_release_ownership(struct sock *sk)
 {
-	if (sock_owned_by_user_nocheck(sk)) {
-		sk->sk_lock.owned = 0;
+	DEBUG_NET_WARN_ON_ONCE(!sock_owned_by_user_nocheck(sk));
+	sk->sk_lock.owned = 0;
 
-		/* The sk_lock has mutex_unlock() semantics: */
-		mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
-	}
+	/* The sk_lock has mutex_unlock() semantics: */
+	mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
 }
 
 /* no reclassification while locks are held */
-- 
2.42.0.283.g2d96d420d3-goog


