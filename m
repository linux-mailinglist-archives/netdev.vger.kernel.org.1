Return-Path: <netdev+bounces-139287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954D9B145D
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 05:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E21C21119
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 03:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF71531D8;
	Sat, 26 Oct 2024 03:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F913A268
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729914547; cv=none; b=skt6Y/w8KNajlq3CAiANpBcLMYfnKoZNXdDMgODTe9/zZWis0IG32QdbusNhsD8BBBoz6kFhFNqsZW7vnQfi6FMp17ik/OSLEGGD4FZlvygM9iffYU2wMxTfGx6afkD92tJ0/nc3eGmMaKCgiQ58HcCqETcBQhFoyIC4Lswf4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729914547; c=relaxed/simple;
	bh=bV58mEwio2XO0wvHvMEcSvakJ3jtR6CiMs6yTMAbukA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+7FDl7aJUf/d9om57BmgjqCLlP1iL6GBy+6J1UJpFLvK1DwoPhBid9gGudM4CQF6uXDAVoiNFvZ3SYMMeQWAul8PnYLefw2p4y71CHuQoNQFAkgYxRPLdq2bfvqx4bEUFMUyH+asJqMttk9Mtf9IPwm8L7Ds45zQH8aOotOAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xb5Fg6JlMz2Dc85;
	Sat, 26 Oct 2024 11:47:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 85B2018001B;
	Sat, 26 Oct 2024 11:49:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 11:49:01 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/2] bna: Remove field bnad_dentry_files[] in struct bnad
Date: Sat, 26 Oct 2024 11:48:00 +0800
Message-ID: <20241026034800.450-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20241026034800.450-1-thunder.leizhen@huawei.com>
References: <20241026034800.450-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Function debugfs_remove() recursively removes a directory, include all
files created by debugfs_create_file(). Therefore, there is no need to
explicitly record each file with member ->bnad_dentry_files[] and
explicitly delete them at the end. Remove field bnad_dentry_files[] and
its related processing codes for simplification.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/ethernet/brocade/bna/bnad.h         |  1 -
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 17 ++---------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.h b/drivers/net/ethernet/brocade/bna/bnad.h
index 10b1e534030e628..4396997c59d041f 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.h
+++ b/drivers/net/ethernet/brocade/bna/bnad.h
@@ -351,7 +351,6 @@ struct bnad {
 	/* debugfs specific data */
 	char	*regdata;
 	u32	reglen;
-	struct dentry *bnad_dentry_files[5];
 	struct dentry *port_debugfs_root;
 };
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 220d20a829c8a84..7a27f9d1443bff2 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -510,12 +510,8 @@ bnad_debugfs_init(struct bnad *bnad)
 
 		for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
 			file = &bnad_debugfs_files[i];
-			bnad->bnad_dentry_files[i] =
-					debugfs_create_file(file->name,
-							file->mode,
-							bnad->port_debugfs_root,
-							bnad,
-							file->fops);
+			debugfs_create_file(file->name,	file->mode,
+					    bnad->port_debugfs_root, bnad, file->fops);
 		}
 	}
 }
@@ -524,15 +520,6 @@ bnad_debugfs_init(struct bnad *bnad)
 void
 bnad_debugfs_uninit(struct bnad *bnad)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
-		if (bnad->bnad_dentry_files[i]) {
-			debugfs_remove(bnad->bnad_dentry_files[i]);
-			bnad->bnad_dentry_files[i] = NULL;
-		}
-	}
-
 	/* Remove the pci_dev debugfs directory for the port */
 	if (bnad->port_debugfs_root) {
 		debugfs_remove(bnad->port_debugfs_root);
-- 
2.34.1


