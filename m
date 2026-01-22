Return-Path: <netdev+bounces-252237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JFKAGnbcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:10:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A563B62DC7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A742235CC57
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049947DD74;
	Thu, 22 Jan 2026 08:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044694611DE;
	Thu, 22 Jan 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068816; cv=none; b=jQ8+dbjobTJHR/ZB3VwjERLwTFhSfHTo13XbxeZV4+5zh7lwcu/Keq1c6OiyNQKDsKN3GFLXqNtrcuPxXvhUqUP6YVEEJFvVqVWo9TiT5JPLzpA59nXjcD4WiKYx8oYUqL7Kgv9mXKkOWqxZKEhaHrw/DZQcisTSzHmeARIJfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068816; c=relaxed/simple;
	bh=2Kbbpw7k4ZLrOOMERt+hZB/Uhv6WiiMOowYOXwsXAAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gEW/tvqi1JpovA2eRfaeZApibWABRvQTUs89AWlGiJfqpuOFEdhsepqmaYk7vVZGnA7iLIXRLzLMoOEqxjWBWfYYmsuNnrYNt7J0h3SUM0Bfy2B3WaZVrvNJshZ+6c7KQENtTJXBeHufuvH/DN1MSVSsNRQwCXZxYPpDpRHYwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.187])
	by smtp.qiye.163.com (Hmail) with ESMTP id 319205517;
	Thu, 22 Jan 2026 16:00:08 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Yixun Lan <dlan@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	netdev@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] net: spacemit: display phy driver information
Date: Thu, 22 Jan 2026 16:00:01 +0800
Message-Id: <20260122080001.73921-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be4b7c84003a2kunmc46be4a346813
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx9IVklMGEMaGk1KTh5JT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSkNMWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[jmu.edu.cn : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252237-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amadeus@jmu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: A563B62DC7
X-Rspamd-Action: no action

Print the PHY driver used and interrupt status after connection.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index c85dc742c404..afb5b6a61c2c 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1568,6 +1568,7 @@ static int emac_phy_connect(struct net_device *ndev)
 	struct device *dev = &priv->pdev->dev;
 	struct phy_device *phydev;
 	struct device_node *np;
+	char *irq_str;
 	int ret;
 
 	ret = of_get_phy_mode(dev->of_node, &priv->phy_interface);
@@ -1610,6 +1611,11 @@ static int emac_phy_connect(struct net_device *ndev)
 		goto err_node_put;
 	}
 
+	irq_str = phy_attached_info_irq(phydev);
+	netdev_info(ndev, "PHY driver [%s] (irq=%s)\n",
+		    phydev->drv->name, irq_str);
+	kfree(irq_str);
+
 	phydev->mac_managed_pm = true;
 
 	emac_update_delay_line(priv);
-- 
2.25.1


