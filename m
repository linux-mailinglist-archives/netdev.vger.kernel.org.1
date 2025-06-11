Return-Path: <netdev+bounces-196648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB87AD5B29
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DE43A7B3F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993AC1D9324;
	Wed, 11 Jun 2025 15:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F697A92E;
	Wed, 11 Jun 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657247; cv=none; b=SOYVPUNRoT60FT62rqRdukw7OM0z5P68Eb4/yj27i4RODJuB740C7bgZDURr68zct4LPiXonz9b8CHjWtsqovqQ8b3GAO/25JYx6+Eb92d85ujUG8APo2zD6s4CiCbZKCt0yw5nYcaC1cpvKYkFufDz86EQr5NhCapXkq8EnEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657247; c=relaxed/simple;
	bh=zGhDwsxwPz5TdzYzoNwFBeSmkUhU977bhXoE3/WrOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWKU+7KdfXFp+KKUsXBCazIjYuOpJMWIBftcPly/zT1QoAgN5rLbeJLJfsV90haJfRrrXLP/xKByPZ20YM1hX8hBITMysMDEGTNXizye8eQkx9yTJIaHGdYVv4H1/1s3rrB2S42MjXIjXYAO/xbJq8lZ2qzZ6q/R8tLgY4tJY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F67C4CEE3;
	Wed, 11 Jun 2025 15:54:04 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 net-next] net: hns3: Demote load and progress messages to debug level
Date: Wed, 11 Jun 2025 17:53:59 +0200
Message-ID: <c2ac6f20f85056e7b35bd56d424040f996d32109.1749657070.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No driver should spam the kernel log when merely being loaded.
The message in hclge_init() is clearly a debug message.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Jijie Shao<shaojijie@huawei.com>
---
Alternatively, the printing in hns3_init_module() could be removed
completely, but that would make hns3_driver_string[] and
hns3_copyright[] unused, which HiSilicon legal may object against?

v2:
  - Add Reviewed-by.
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b03b8758c7774ec2..5c8c62ea6ac0429f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5961,8 +5961,8 @@ static int __init hns3_init_module(void)
 {
 	int ret;
 
-	pr_info("%s: %s - version\n", hns3_driver_name, hns3_driver_string);
-	pr_info("%s: %s\n", hns3_driver_name, hns3_copyright);
+	pr_debug("%s: %s - version\n", hns3_driver_name, hns3_driver_string);
+	pr_debug("%s: %s\n", hns3_driver_name, hns3_copyright);
 
 	client.type = HNAE3_CLIENT_KNIC;
 	snprintf(client.name, HNAE3_CLIENT_NAME_LENGTH, "%s",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a7de67699a013c1d..a5b480d59fbf408c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12904,7 +12904,7 @@ static struct hnae3_ae_algo ae_algo = {
 
 static int __init hclge_init(void)
 {
-	pr_info("%s is initializing\n", HCLGE_NAME);
+	pr_debug("%s is initializing\n", HCLGE_NAME);
 
 	hclge_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, HCLGE_NAME);
 	if (!hclge_wq) {
-- 
2.43.0


