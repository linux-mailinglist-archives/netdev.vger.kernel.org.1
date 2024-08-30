Return-Path: <netdev+bounces-123626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB4965D14
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401311C228A9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B52175D3A;
	Fri, 30 Aug 2024 09:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96984171650;
	Fri, 30 Aug 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010638; cv=none; b=r+g7hPwSRCkVa8CdzZeuZrRr5Ym2DrdEqcRSA4GqWPf0k9zct3/ilbd3GR1iE6PGkg4mOwXVY15kPFzOVik7W2zfsDyWUj6oyDWJVZ6taEOhz6rmgo6kuQkulN/EQ4yNYpzwMuMHe93JNEqYc34tHMbqaVe4BGFXnhsmtmHWSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010638; c=relaxed/simple;
	bh=Ue6hzO5wKNvu0e1zjQMqu86LRGzoP9vHLUacDW7ykYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pr9BQv0fsNcd9U+zMcTRpZx0AqFeqM88wM+oYi4r/2F2Ip5ZwiBOlyEukk9aW/mTi/VavXoC0v4Cj2kH8XcYka3GrQS7gYBaYQ+ga6d+crQbTsCPswLxOOyKs4mYuRxHbQLzraTubGm8VyW3xsEBSUzCAreVfPy+RLosMuPGiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WwChQ2nf4z14F6P;
	Fri, 30 Aug 2024 17:36:22 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 24CEE18007C;
	Fri, 30 Aug 2024 17:37:13 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 17:37:12 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 1/3] cxgb3: Remove unused declarations
Date: Fri, 30 Aug 2024 17:33:36 +0800
Message-ID: <20240830093338.3742315-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830093338.3742315-1-yuehaibing@huawei.com>
References: <20240830093338.3742315-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 4d22de3e6cc4 ("Add support for the latest 1G/10G Chelsio adapter,
T3.") declared but never implemented these.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h
index f04e81f33795..a08fc762a438 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_defs.h
@@ -106,6 +106,4 @@ static inline struct t3c_tid_entry *lookup_atid(const struct tid_info *t,
 	return &e->t3c_tid;
 }
 
-int attach_t3cdev(struct t3cdev *dev);
-void detach_t3cdev(struct t3cdev *dev);
 #endif
-- 
2.34.1


