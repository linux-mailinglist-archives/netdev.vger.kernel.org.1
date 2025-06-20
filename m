Return-Path: <netdev+bounces-199661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16146AE1425
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FB53A344A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 06:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529613597E;
	Fri, 20 Jun 2025 06:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFE30E82F;
	Fri, 20 Jun 2025 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401989; cv=none; b=Nw1ofjbpNHl7jevsrEvNb+3ZuStwDgm1qQlTPEUP7omBt5+Z196hrQCjdnP8zIM8MDxTncqq+JRbMBWdJElZN6bp0jJ7aOGzFqpNkQTdSLsrDhiu5ALNmsgTLjHyxrb5PhGxoDZyPQEwzNQHtn9GehF9+BVIfCnEZaeE+VBbwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401989; c=relaxed/simple;
	bh=jSBTgEJ77AgbtKSzWKekli9xxnSrcI2cPmeUlaZ86Sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsEg+KN0JelpOiJ56bAsF9xO1rGF8ECbyrdBrL7YKfv5Z6eX8VgUZ6HoPixN6aMtJlHD/Yv0kEpOoUXQsF9qy+SMoInpotb4hRkPyDliuHWRN5SzgV70GF4gA9qMEG4MaXQusOgpjFd5oUOAhJfIOL4ZYdzqNqb9I46Rq1yJqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bNny06xJ4z13McJ;
	Fri, 20 Jun 2025 14:44:08 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 059C7180B61;
	Fri, 20 Jun 2025 14:46:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Jun
 2025 14:46:21 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] Bluetooth: Remove hci_conn_hash_lookup_state()
Date: Fri, 20 Jun 2025 15:03:45 +0800
Message-ID: <20250620070345.2166957-1-yuehaibing@huawei.com>
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

Since commit 4aa42119d971 ("Bluetooth: Remove pending ACL connection
attempts") this function is unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/bluetooth/hci_core.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a760f05fa3fb..939eba829fed 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1415,26 +1415,6 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	return NULL;
 }
 
-static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
-							__u8 type, __u16 state)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type == type && c->state == state) {
-			rcu_read_unlock();
-			return c;
-		}
-	}
-
-	rcu_read_unlock();
-
-	return NULL;
-}
-
 typedef void (*hci_conn_func_t)(struct hci_conn *conn, void *data);
 static inline void hci_conn_hash_list_state(struct hci_dev *hdev,
 					    hci_conn_func_t func, __u8 type,
-- 
2.34.1


