Return-Path: <netdev+bounces-215160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D790B2D459
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441153BE833
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAD2D027F;
	Wed, 20 Aug 2025 06:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567632343C0;
	Wed, 20 Aug 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672951; cv=none; b=gulusxuBs08591afIHwRTnFqSUJ9f/2g4/BbHvLbOtfuCyZrfqfp/Ej6Nb26DlnuenXwF8I5gPKecE1R3OU+n4ul0xrJIQpE6+3L+R/8EMhp6NEnNqNoq4pRDzMlfgMsf7aRgBKdDyL3eM5T1MWNP4ml/j0zNPmFWGdWQwaQ+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672951; c=relaxed/simple;
	bh=9qDlSaoz+L6S1w1FP84KDoNHJgTm4ExxvS1BAhiYUaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WbvxDJrIApS7Yt+puuCmEFpknq9LOniAMKARUAieA2tkrie3wOhj8EXnfcDC9OZA+NbQP7Td3pyTJReSH+o1Spxkh1IeInTy75B7j2E00xnYgEOsBo9uNv3RXKUkSmJ5hIcnjPDtB+MXb27tKV0qqpSYldpUfNmuIJrYberC3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6HDC5jZPz2CgDH;
	Wed, 20 Aug 2025 14:51:23 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 81130140279;
	Wed, 20 Aug 2025 14:55:46 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 14:55:45 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<wangliang74@huawei.com>, <idosch@nvidia.com>, <rrendec@redhat.com>,
	<menglong8.dong@gmail.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: vxlan: remove unused argument of vxlan_mdb_remote_fini()
Date: Wed, 20 Aug 2025 14:56:16 +0800
Message-ID: <20250820065616.2903359-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The argument 'vxlan' is unused, when commit a3a48de5eade ("vxlan: mdb: Add
MDB control path support") add function vxlan_mdb_remote_fini(). Just
remove it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 drivers/net/vxlan/vxlan_mdb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 816ab1aa0526..e8fa9364d661 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -740,8 +740,7 @@ static int vxlan_mdb_remote_init(const struct vxlan_mdb_config *cfg,
 	return 0;
 }
 
-static void vxlan_mdb_remote_fini(struct vxlan_dev *vxlan,
-				  struct vxlan_mdb_remote *remote)
+static void vxlan_mdb_remote_fini(struct vxlan_mdb_remote *remote)
 {
 	WARN_ON_ONCE(!hlist_empty(&remote->src_list));
 	vxlan_mdb_remote_rdst_fini(rtnl_dereference(remote->rd));
@@ -1159,7 +1158,7 @@ static int vxlan_mdb_remote_add(const struct vxlan_mdb_config *cfg,
 	return 0;
 
 err_remote_fini:
-	vxlan_mdb_remote_fini(cfg->vxlan, remote);
+	vxlan_mdb_remote_fini(remote);
 err_free_remote:
 	kfree(remote);
 	return err;
@@ -1172,7 +1171,7 @@ static void vxlan_mdb_remote_del(struct vxlan_dev *vxlan,
 	vxlan_mdb_remote_notify(vxlan, mdb_entry, remote, RTM_DELMDB);
 	list_del_rcu(&remote->list);
 	vxlan_mdb_remote_srcs_del(vxlan, &mdb_entry->key, remote);
-	vxlan_mdb_remote_fini(vxlan, remote);
+	vxlan_mdb_remote_fini(remote);
 	kfree_rcu(remote, rcu);
 }
 
-- 
2.33.0


