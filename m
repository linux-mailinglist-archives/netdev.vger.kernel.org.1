Return-Path: <netdev+bounces-119160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD71F95468C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B32F1C219EA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5744E172BCE;
	Fri, 16 Aug 2024 10:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471413E88B;
	Fri, 16 Aug 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803148; cv=none; b=diAeY13f8bVnq7W4zu7VNhG8zdZf7DfHZcfaKqTptmi4vzje64g9RqK6m/B4Q/v5fzma8IJIrAtqI8Ql70GyVHEopP53XS4sudNsc++wqr3GtqRpoWW2kmpoP7c0hevdjwaoukhTb/JewrVZvvGEoIrAFyD2qdAVyzEhzykoPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803148; c=relaxed/simple;
	bh=8QV8I6F6hCq6HuYp+q0VpWSM3GKbCa3W9vKRJRdFmZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oF8aUoioF3d3KThOkANM8wwmN+DySFCRpsz5zbuGq5THgsc1PH8K8ml68+6+UOOpc64hwo+T5AhqMDjIiAPCqubvPg9H9199z+eXoNUCEUshQo36SsJ46rDpcGJQ58qP+ZLG4WCvgf0RUpPyEx90XHeFpOjcoeo6EJYzqlr733w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wld2m6fWLz1j6VJ;
	Fri, 16 Aug 2024 18:07:28 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CAF2180019;
	Fri, 16 Aug 2024 18:12:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:12:22 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <matttbe@kernel.org>, <martineau@kernel.org>, <geliang@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] mptcp: Remove unused declaration mptcp_sockopt_sync()
Date: Fri, 16 Aug 2024 18:04:04 +0800
Message-ID: <20240816100404.879598-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit a1ab24e5fc4a ("mptcp: consolidate sockopt synchronization")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/mptcp/protocol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 60c6b073d65f..08387140a646 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1154,7 +1154,6 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
-- 
2.34.1


