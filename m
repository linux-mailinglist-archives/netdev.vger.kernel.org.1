Return-Path: <netdev+bounces-246881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554BCF21F4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13144301FB57
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF026C384;
	Mon,  5 Jan 2026 07:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19A275114;
	Mon,  5 Jan 2026 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596944; cv=none; b=StgDdUcsCbdv1eEtkzrZGgl5oShriZdpI0C1N2mIF1q87805BrZajVxfN/ORGTZ9+V2JIpHVeS/5scWHfYv4VPtUdk/q9IA4bFsomsksUWwBhvTWZE4cK79/E4hR40Apl/grQKV7gzYfbau7QyVulUu5+fFYR/w7UiIag2AP2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596944; c=relaxed/simple;
	bh=mJ//JkS8YYCrioy41HdvvrSy2ueQUViG0J+y0omw7Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MZGUPNFOYZxKudU6txlZpNMoDWV3taFdlt0yDYMeJEVNi5lnlNXMuq12SEDHEdKEsafAf7QJGyR1a1+zXhAtdc0nmhb/3JtE1mdnFaLx0N/4hYF1fOyFwxQuUIo2BsnpfhOtfdSzS07ILPgSnbL3ZE4hmvJkHATAIz+zMpQU1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:51 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:51 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:47 +0800
Subject: [PATCH 01/15] net: ftgmac100: List all compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-1-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=866;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=XvDL98JqW5k7R/sE+lXeDV1NIQS3w8ImXfoQEwHpsEo=;
 b=G68c3LYLm/ThUu2PXWfijPICrdeIGYVpW4SU6VGM6l9bLWEhZc8Cdkbl8Vm6ox+5n9K2OwQDP
 wV/swGZPoGcCTUSE9ukGa1ceoUt+cjGIdGBUPAbbG1z52VDlVqLWup8
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

As a step towards cleanup the probe function, list each compatible the
driver supports.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a863f7841210..bd768a93b9e6 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2091,6 +2091,9 @@ static void ftgmac100_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ftgmac100_of_match[] = {
+	{ .compatible = "aspeed,ast2400-mac" },
+	{ .compatible = "aspeed,ast2500-mac" },
+	{ .compatible = "aspeed,ast2600-mac" },
 	{ .compatible = "faraday,ftgmac100" },
 	{ }
 };

-- 
2.34.1


