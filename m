Return-Path: <netdev+bounces-234948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD7C2A166
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 06:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32AA6344AD8
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 05:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843BB17A2F0;
	Mon,  3 Nov 2025 05:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555D5695;
	Mon,  3 Nov 2025 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762148782; cv=none; b=mR+v0301CnN9l72jJWgSxbv0F0oXVFwNYmS0DmvrhxHsPHA6l/l7lQS83LZQ4NjQ9C3yVTkNJPI0F40gEjf76tD880MsQTxgP95HBpIlnoKsDrfInwkLviVGuH0C2w+89CBx+UGsS8SpMPr8iGFiWSHFLTUpt/DKZQH0RMEHT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762148782; c=relaxed/simple;
	bh=lmdvFZmuC47ZDhcf5I/FHsn3O13bSXuC/1ludIdyEiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3Dpp9SwShQidYSRABr9zBaaCSrJRKgnVtbodFUNhEK+KOakF3HOeRrKxE950qIh57LIUE24N/GwnLWewoy13OX7Yv2k9GJ+fFvXASPnrI+uRQ+jAqj/UCgeC3ISqsi4N7/ZJ73WAa7nNN6OK33kx5n31J5L2SrLOr1jDAmvojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202511031346010428;
        Mon, 03 Nov 2025 13:46:01 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 13:45:59 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 13:45:59 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDwD_qWQQhpl7cJAA--.13467S4;
	Mon, 03 Nov 2025 13:45:59 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH] net: sungem_phy: Fix a typo error in sungem_phy
Date: Mon, 3 Nov 2025 13:44:43 +0800
Message-ID: <20251103054443.2878-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDwD_qWQQhpl7cJAA--.13467S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF
	04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?+a+4KJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KV4QW92Y+U3fDwLdmbxaXwqGEL1URZtEu8am3brerhYPFdyOvr8SFzF9TnCopT05gNEM
	QO5EYHN1SSQvpFdNPvs=
Content-Type: text/plain
tUid: 20251103134601a89007328d44a3fb94094b7e61516df4
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix a spelling mistakes for regularly

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/net/sungem_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index 55aa8d0c8e1f..c10198d44576 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -1165,7 +1165,7 @@ int sungem_phy_probe(struct mii_phy *phy, int mii_id)
 	int i;
 
 	/* We do not reset the mii_phy structure as the driver
-	 * may re-probe the PHY regulary
+	 * may re-probe the PHY regularly
 	 */
 	phy->mii_id = mii_id;
 
-- 
2.43.7


