Return-Path: <netdev+bounces-35562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F07A9CBD
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD69CB26E99
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C144521C0;
	Thu, 21 Sep 2023 18:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7FC521A1
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:35:18 +0000 (UTC)
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72744A49B
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:35:16 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1d6ce46e952so1751115fac.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695321315; x=1695926115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2eXTdtHslQ/OUzgwWNJnSZUsT3U7dUODYgRsnKdY00U=;
        b=W1Hw3/M3Roc9LtPa4sajcr+XTr5VXQccEeGxxVU5uqtHSQHx4XVysAJEcbUZquTGO3
         8BdpGpLstRKAqLZGsBWHwDuYCUmcvyYb7ybYdkkFC2ZJYJLkwfpOeZUW1ZGtn7xgMkyV
         OGhl+YAVio9Jeu5Ynf34Sg3l0gNcwSRM9JkntLjoLVqq0vY1Ok87qXXU4DVSA9LeumJX
         9of/YTlhvov1aQeBnvFlDGq5sJ3wTBmV7MsIgwDVTFoJ+nStz2ZcajUSJQG+Mdl9swgU
         gehAn8ucKoq7qW6tO6X2hkz28ng1LAi+iFtDbO6S8o8ORRxgAoUMow5SOve3B8SwEye8
         htww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321315; x=1695926115;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eXTdtHslQ/OUzgwWNJnSZUsT3U7dUODYgRsnKdY00U=;
        b=ez2Vk16S/Dq6uk5UGnG+cdf2Hu35rofu9Q1YgCpm5Rgwr4/n/NQgNxfqgYoLzekgC9
         F4OI+d+sypJsqubqcjTOvvNuDw64BcxkplNT/JaNkcGoIkTe1tahFFHJqmlSunzD0j2K
         9D+MS4J8DX4Kcs1GnAHaE37J5yn0jdPHM1ymFymt5aBWHw5Ds6aaCl3S8F7fKTMs6uQK
         bBW2xZCsrGC+vXeQ1BYqVLRglUSxdqoBXr5f7Nou1BRXJNsFMAZ1eb7IAf9hPypmYTMG
         Hs39O08nwx3mMAG+//t72my3ZGw5Gbk1DRbTUKC1gB2gf0kPDi2sLZA9KYFvSrxBTi6a
         ZC5A==
X-Gm-Message-State: AOJu0YyHZfHrFJ/GOM6A9JsT3bRMClBqebXgi4aXJo/f4mBOZAp/wn80
	an7q3LiXMy9Bkc93eTb4qZyrapi72b/N1A==
X-Google-Smtp-Source: AGHT+IFrh8/V5VrX9bm7fYqznb7LmiXnNms89NzNpzdlj9yOOadlt6NMyWDjlFJ3TOCssh5MRtDrtemFatHU/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b228:0:b0:d74:93a1:70a2 with SMTP id
 i40-20020a25b228000000b00d7493a170a2mr58010ybj.5.1695285987503; Thu, 21 Sep
 2023 01:46:27 -0700 (PDT)
Date: Thu, 21 Sep 2023 08:46:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921084626.865912-1-edumazet@google.com>
Subject: [PATCH net] net: fix possible store tearing in neigh_periodic_work()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While looking at a related syzbot report involving neigh_periodic_work(),
I found that I forgot to add an annotation when deleting an
RCU protected item from a list.

Readers use rcu_deference(*np), we need to use either
rcu_assign_pointer() or WRITE_ONCE() on writer side
to prevent store tearing.

I use rcu_assign_pointer() to have lockdep support,
this was the choice made in neigh_flush_dev().

Fixes: 767e97e1e0db ("neigh: RCU conversion of struct neighbour")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6b76cd103195374f73786b7bb94fb2f4051a3c73..7212c7e521ef6388f450f3882077e26088bb3644 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -988,7 +988,9 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				*np = n->next;
+				rcu_assign_pointer(*np,
+					rcu_dereference_protected(n->next,
+						lockdep_is_held(&tbl->lock)));
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
-- 
2.42.0.459.ge4e396fd5e-goog


