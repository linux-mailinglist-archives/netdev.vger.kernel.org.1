Return-Path: <netdev+bounces-250380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E22D29E9B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01A013005F39
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E6314B6E;
	Fri, 16 Jan 2026 02:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05463370F9;
	Fri, 16 Jan 2026 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529364; cv=none; b=Ros1lJ578qj7nAT2GHSQBcb315MA9WgCXWGJqT9A5u3hKZQDT2ps7ejeAI35LXIrohbw05Te+HpAB8R1RPJ3q1S4koGS23CbrG4U8dz4pPuUTzwee3PjPr0LOmvnGh0DBMcS4T1TTeA4G6yUGVooPDne7CKRQ+B3zAFrI65NjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529364; c=relaxed/simple;
	bh=rPxIS+uhUzsKBY2yjgyhHwqeU3SRBIHj4tyBgoBhwGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dhm3VuV0Newai4qF4NALzqCK3ph+frqsEwjSYS0frStRkrfENuU6kHr0O373VlwZQ4tENtRql8M8UUHzTKtZD4I80dBuY30VyDR0qP8njwgxJyM5ifgxC6xoBtVyhUA1oMfHcOVIZXqTAgZ8upawmw4txGN5/qDAiokiGYYlPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:15 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:15 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:12 +0800
Subject: [PATCH net-next v2 01/15] net: ftgmac100: List all compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-1-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=912;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=VB5Hr6O+hVDiNqHf4IWzXWWPmq/hUMTRLmT1UTc/XL8=;
 b=DIsYhZC6fluAzuT+9OWl9PRKCBs1z1c832YUnagRjFo2fmLdCTCMwDbGv9qcJVNEEtZwFMEi+
 E60TRM8mzSCA3nZNofLbnK6PNQlTlwZfjXupXSDJ1UY6sA2IgadHvz1
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

As a step towards cleanup the probe function, list each compatible the
driver supports.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
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


