Return-Path: <netdev+bounces-123258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B779D964531
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738EC28B51A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AF1B3F0E;
	Thu, 29 Aug 2024 12:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A51B3B38;
	Thu, 29 Aug 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935353; cv=none; b=sPtSFSUHh7nbB+6oWVQQ9rff7qFiN0igVj5XF/eNvac2cmgNDPIRy8M1mYDMmz+Zxnr6VEVd901D9vXWjy7BBquRhTMER9H3DuvRGSCP7jV6h+DzuNWAeFuhMvNGT3PelbsSIzTKfyGyG/Bmj+/sfqe6Cpjyj5drwPqDKtTenAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935353; c=relaxed/simple;
	bh=/WWww8edGJg/81zfvJ1fX2eitV/el0MKwJbSOIRweb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3qBbABg2wR5q4b+8lefUFRUyrKnGGAG0YxKdcejNtuI9Ol6L27mw4tyYYQrgiNtZIaQKwBpA/i5Iz3hjjxkxG59J7N3udLZ3i459koPhmNJs57tJvuWFny8SImAeR8gyEg8j5bZUj4Mv9HaVBzoEzMxEP71pNN3UVBb/SovkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvgsN30pVz2DbZd;
	Thu, 29 Aug 2024 20:42:16 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2642A140153;
	Thu, 29 Aug 2024 20:42:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 20:42:28 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/3] cxgb3: Remove unused declarations
Date: Thu, 29 Aug 2024 20:37:05 +0800
Message-ID: <20240829123707.2276148-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829123707.2276148-1-yuehaibing@huawei.com>
References: <20240829123707.2276148-1-yuehaibing@huawei.com>
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


