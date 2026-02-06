Return-Path: <netdev+bounces-257435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBtkNX9dhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:18:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06BF99E7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910B730276A0
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4B330322;
	Fri,  6 Feb 2026 03:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F502D322E;
	Fri,  6 Feb 2026 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347868; cv=none; b=K9m62C5+X/RH8t89mo4in2IBPblf9tSCbPIgMPu6SenAHAKREY8WepC366nY4o1vuMv5Ms3N4qavb5VdkaznjiXUv4ZjiU3kz22P5UEgCjnR0Okkk+7Q+uMz8xfKsQBNzBBJK7xTNl3gwzjrPPqVx1LTF186Y3fUr3uvjnndytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347868; c=relaxed/simple;
	bh=rPxIS+uhUzsKBY2yjgyhHwqeU3SRBIHj4tyBgoBhwGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TiSe1HVyz6OVqfLVjhMllk5nlacf1DBh9K8DjJKbjZiz1fW2mqhxmexmGPgzhRhp1qn2l9yJv0JXztHelPZSqGChYCRaNXCKUP0138GqVVo1rSPLc0y/y9d+VEm0KCGfsrDFZScEEv6JGfduOBkrnfjI14mENJGEmid+DzatF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Feb
 2026 11:17:44 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Feb 2026 11:17:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 6 Feb 2026 11:17:41 +0800
Subject: [PATCH net-next v5 01/15] net: ftgmac100: List all compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260206-ftgmac-cleanup-v5-1-ad28a9067ea7@aspeedtech.com>
References: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
In-Reply-To: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770347864; l=912;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=VB5Hr6O+hVDiNqHf4IWzXWWPmq/hUMTRLmT1UTc/XL8=;
 b=DVMNZJJFM2kyOGc0fg3AROPbEbyMedcgMnwEzIJZ/FDX+baSlC97xD7c3fzIKmo+Q2LplEpnn
 dN9zwzv65FnDj/exO5Cy/4SnL+OQ+4JV7f3EibnBIsNipr7ALUVV6uv
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257435-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: 3D06BF99E7
X-Rspamd-Action: no action

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


