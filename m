Return-Path: <netdev+bounces-139413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6CA9B229A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F89F1C20F45
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0135149E00;
	Mon, 28 Oct 2024 02:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883461422AB
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081448; cv=none; b=XWzvKbGJU/uAF5ZKw+cKqZvBBwS5yWc5jZMfJEHJwSvDR2Q4ghbr3GIttzQLuTqGND7/raismcswLbQN8J+tdIj/EkkHo2P5z4HxlfTVwClPcqIvjhiguxVd5Vad/hMlGl3rX2pxfcny4U1ZOiSYba4C5G1tlyPitARlaeEu4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081448; c=relaxed/simple;
	bh=qbgx5DLORqE6SkvXD1UlPEtKtCsrL4bVzXHlKZMZfbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0PuxH9vrtR6DP3r85r3jutQfHQJ/REdD5ePXVzDaAGIUJLdG2j3y/yE/LniSH5zTWNy0hdXg6+GqEUGEizSEAT+ATSfhwrv73PHXBts5r5NE39Dg1Smt3M7rHIUhLF2qxiy+YVrHyH46vjl2sVSoks3qjO8vKf4BkSEYVyav+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XcGyk22RQzpXPQ;
	Mon, 28 Oct 2024 10:08:46 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 536FA14039E;
	Mon, 28 Oct 2024 10:10:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 10:10:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 2/2] bna: Remove field bnad_dentry_files[] in struct bnad
Date: Mon, 28 Oct 2024 10:09:43 +0800
Message-ID: <20241028020943.507-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20241028020943.507-1-thunder.leizhen@huawei.com>
References: <20241028020943.507-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Function debugfs_remove() recursively removes a directory, include all
files created by debugfs_create_file(). Therefore, there is no need to
explicitly record each file with member ->bnad_dentry_files[] and
explicitly delete them at the end. Remove field bnad_dentry_files[] and
its related processing codes for simplification.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/brocade/bna/bnad.h       |  1 -
 .../net/ethernet/brocade/bna/bnad_debugfs.c   | 20 +++++--------------
 2 files changed, 5 insertions(+), 16 deletions(-)

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
index 1a3a8bd133706ad..8f0972e6737c12d 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -512,12 +512,11 @@ bnad_debugfs_init(struct bnad *bnad)
 
 		for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
 			file = &bnad_debugfs_files[i];
-			bnad->bnad_dentry_files[i] =
-					debugfs_create_file(file->name,
-							file->mode,
-							bnad->port_debugfs_root,
-							bnad,
-							file->fops);
+			debugfs_create_file(file->name,
+					    file->mode,
+					    bnad->port_debugfs_root,
+					    bnad,
+					    file->fops);
 		}
 	}
 }
@@ -526,15 +525,6 @@ bnad_debugfs_init(struct bnad *bnad)
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


