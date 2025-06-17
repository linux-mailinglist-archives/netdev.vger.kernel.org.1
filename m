Return-Path: <netdev+bounces-198576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91CADCBD8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290C61896A05
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C16C2C032B;
	Tue, 17 Jun 2025 12:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C082290D96;
	Tue, 17 Jun 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164517; cv=none; b=sZBLct74HUZa5rOJMDSe+5x3wt3BAu71sRp+ahKDpBFgzADNLI9+kz5c610ANNwwWZP9SgUMFlu9OAa7qWKPvZoBcHS2C4CDesic7Cj/GEJP2rVFELdbLvEHSvX7JqYWYRxEgKG1+0988zhfo6/cnYCKfjVlT01nPpVPtz/VMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164517; c=relaxed/simple;
	bh=yhH9A3DVdAxdZrmhqK+CWc/OlW8R+tyhfF13mkbvm9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLHBf0Xs01MgMFWRIOV5nX0qIANkgHUc6pzmQPIESQ6MqI74TO0IegIm+7jmfimoTCF7CPndy6suT132aIQGg6Fo5CoqPNTZ8VcoBisbXXrUkdUzzHKETlis5wnGJ2Yd3CFxFFduzZYQ5PdBtmAS8tZix5RKs2ZQIdxnyN7S+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bM65J3DNmz2Cfbd;
	Tue, 17 Jun 2025 20:44:36 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 74E4C18001B;
	Tue, 17 Jun 2025 20:48:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Jun
 2025 20:48:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] tcp: Remove inet_hashinfo2_free_mod()
Date: Tue, 17 Jun 2025 21:06:13 +0800
Message-ID: <20250617130613.498659-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

DCCP was removed, inet_hashinfo2_free_mod() is unused now.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/inet_hashtables.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 4564b5d348b1..ae09e91398a5 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -202,12 +202,6 @@ static inline spinlock_t *inet_ehash_lockp(
 
 int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo);
 
-static inline void inet_hashinfo2_free_mod(struct inet_hashinfo *h)
-{
-	kfree(h->lhash2);
-	h->lhash2 = NULL;
-}
-
 static inline void inet_ehash_locks_free(struct inet_hashinfo *hashinfo)
 {
 	kvfree(hashinfo->ehash_locks);
-- 
2.34.1


