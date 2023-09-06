Return-Path: <netdev+bounces-32338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8779444A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF521C20A7E
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257111CB4;
	Wed,  6 Sep 2023 20:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945011CB0
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 20:10:58 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5C198E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:10:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d782a2ba9f9so2538389276.0
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694031056; x=1694635856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RpvnQSaCTE/6zaLHNRQ0bZmi3mDkmnmHp6VTSl/j4=;
        b=WBv1pJ+lAxMcNego1CQu1zQGzp+glNmrNzuvY372eko83jFKCnRNzg5eIypQPYgsWz
         ydPNW34cS8vc/Khqm7n3MuycrOzvJ+WgXaGBaIEqpQGRK4cvVOmqhpD1ueiH4vMptCGs
         5h5ERSJTumEmmqHMmrcbRyCCZETgSzwq3odY7PT4uZxxFFw/B2APNwbpMUc1HQ/AldF/
         74FStRIAEFOqP1K3og899uAbdGRJGFqYeeqrmkOWKhQqO/WY5Q9/+23JRiljSRaup0tk
         GAxYoEnQjQ5XSfOnq1tx9IHLiWh/B0arjDTSwbPsejNXrgn3zgivN6SIbRfy6crfG9Nv
         MmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031056; x=1694635856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RpvnQSaCTE/6zaLHNRQ0bZmi3mDkmnmHp6VTSl/j4=;
        b=hNyS7BlKkNy3Ax6Zks1CCY6q2CsiI/XEbknRq/PZ01vdvSQDAAJrRLG8TD1fsKcWcH
         WEfa50X+HyaSsk1ut7uvn7BSE219vibSdLFSEbmqP36moSGUs87JDnrRkiSToh+54l5G
         kMKLEcA/3cYjMs7sntHewq9iNNuZJv3ovhtjqjem80PerA8EP3xm0VZm0YsrhhfyvPYu
         1c9c5tPpjXIRprMlgpSj/PBMSrdUl10RKfDvEz37+NedkxL5NGk1d9YL4BAJFmEqBD4d
         R/mofi9HWmpZ5tInDmgvgfthGQpN2D4/eTEwHRABC0B7aASgdv90dJN/kUrg0n1WxH3p
         1/lw==
X-Gm-Message-State: AOJu0YzwoYAJ2YFRQl4XmV8FKwiJkUSRE/4cNPTIo0f71gVLwnCfiCAX
	OOmONZdLuQ9HTe5DctU1Xawh5Qruz03hlA==
X-Google-Smtp-Source: AGHT+IF7WAyK9A02Vr+HiYtuxprMqXQ1NnJ3NyrliQpw9kGyD0yFMSim6r++3r70Vvzf8iHqjCvvxB97ovzioQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:d09:0:b0:d7b:b648:f0da with SMTP id
 y9-20020a5b0d09000000b00d7bb648f0damr17674ybp.6.1694031056751; Wed, 06 Sep
 2023 13:10:56 -0700 (PDT)
Date: Wed,  6 Sep 2023 20:10:45 +0000
In-Reply-To: <20230906201046.463236-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906201046.463236-4-edumazet@google.com>
Subject: [RFC net-next 3/4] net: call prot->release_cb() when processing backlog
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

__sk_flush_backlog() / sk_flush_backlog() are used
when TCP recvmsg()/sendmsg() process large chunks,
to not let packets in the backlog too long.

It makes sense to call tcp_release_cb() to also
process actions held in sk->sk_tsq_flags for smoother
scheduling.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 21610e3845a5042f7c648ccb3e0d90126df20a0b..bb89b88bc1e8a042c4ee40b3c8345dc58cb1b369 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3001,6 +3001,9 @@ void __sk_flush_backlog(struct sock *sk)
 {
 	spin_lock_bh(&sk->sk_lock.slock);
 	__release_sock(sk);
+
+	if (sk->sk_prot->release_cb)
+		sk->sk_prot->release_cb(sk);
 	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL_GPL(__sk_flush_backlog);
-- 
2.42.0.283.g2d96d420d3-goog


