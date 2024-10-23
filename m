Return-Path: <netdev+bounces-138125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A081B9AC119
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCB1F221DD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD415687D;
	Wed, 23 Oct 2024 08:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FF158214
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671041; cv=none; b=Qu4MY2PrIdviFxBCleAhffqXlBZPSvQtE02G76RSi0ey+NJbHZMlLyrQtY4fgwrOTLz+B04Gjx6y3BGi/CnHpvwbPi+XZU1bOAWtHpGy+n5kYn7Aw5D8ZDq6On2DVomdw+Mi+RzNgb95sS6cjnZxK/TkCibp1f870RB+v5lJ6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671041; c=relaxed/simple;
	bh=UpOZOnv0+ZaaJXc7sUsIq1I47JTwQguJwGIp3tlQWzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLh9KRQxt6yuxcgbDGf55sMXn61kp4S9GeqWeA1V6peLxoWbaRmD4bo59DHbOJmx+4ZQNxtOuWuIxsitb5cgFo6W7b3cpXtCk/Do4nkkDfkAuMvoZ9D4LHbzz8OPMuHku94rLWqMT9CkcZr+Bb5CnjZcmGz3RIEn14/WmArWJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYMCY4Vdjz20qpP;
	Wed, 23 Oct 2024 16:09:45 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 46ABB1A0188;
	Wed, 23 Oct 2024 16:10:37 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 16:10:36 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] bna: Remove field bnad_dentry_files[] in struct bnad
Date: Wed, 23 Oct 2024 16:09:21 +0800
Message-ID: <20241023080921.326-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20241023080921.326-1-thunder.leizhen@huawei.com>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Function debugfs_remove() recursively removes a directory, include all
files created by debugfs_create_file(). Therefore, there is no need to
explicitly record each file with member ->bnad_dentry_files[] and
explicitly delete them at the end. Delete field bnad_dentry_files[] and
its related processing codes for optimization.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/net/ethernet/brocade/bna/bnad.h       |  1 -
 .../net/ethernet/brocade/bna/bnad_debugfs.c   | 22 +++++--------------
 2 files changed, 6 insertions(+), 17 deletions(-)

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
index ad0b29391f990f3..317b5c3ffb10251 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -521,13 +521,12 @@ bnad_debugfs_init(struct bnad *bnad)
 
 		for (i = 0; i < ARRAY_SIZE(bnad_debugfs_files); i++) {
 			file = &bnad_debugfs_files[i];
-			bnad->bnad_dentry_files[i] =
-					debugfs_create_file(file->name,
-							file->mode,
-							bnad->port_debugfs_root,
-							bnad,
-							file->fops);
-			if (IS_ERR(bnad->bnad_dentry_files[i])) {
+			de = debugfs_create_file(file->name,
+						 file->mode,
+						 bnad->port_debugfs_root,
+						 bnad,
+						 file->fops);
+			if (IS_ERR(de)) {
 				netdev_warn(bnad->netdev,
 					    "create %s entry failed\n",
 					    file->name);
@@ -541,15 +540,6 @@ bnad_debugfs_init(struct bnad *bnad)
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


