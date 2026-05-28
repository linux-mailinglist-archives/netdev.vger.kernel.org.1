Return-Path: <netdev+bounces-292629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BQgLLwLGGpzbAgAu9opvQ
	(envelope-from <netdev+bounces-292629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:32:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D235EFA75
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8725D3000BB5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D506C3AEF4E;
	Thu, 28 May 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bI9vXmGV"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A4361DC3;
	Thu, 28 May 2026 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960620; cv=none; b=rdi06KdwTPldBYlYBSvvKzU5ddpyP0HC46eKbJ6aRFgvMOjFYzSan9w7+6+lBO280ym1jyDi03s5o/dGPNSSwNlc8lhUoig9te01/1ksIPRuUtQ9hgjOQ/g5wLw8lkV6VTJeSo06h3/TFwKZ5tNXtVJQEYk1HGWEwN/pwhbqjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960620; c=relaxed/simple;
	bh=VE/Uvxdg8FIwvx0f/2zMHUwgBpRKzFjfxBzOtBOVQAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPokoUI5Jb/XdZdVDxQAKZ8FUDNadh/J4upMjZ6oddCf/yIaSXWLZFYCWSfvOWUIwi8RxDfzazxT5vXITKGqvDFSxIqa+R5mbAfsvyIZ/GMgSpxbQdChRNS2LCH1yR7Oz+sVtfG9MtWAJtyC645efL84tCW7JpofgXHIKFf1txs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bI9vXmGV; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C81T0rToaJN6ExYp0e3pyEuR4fh2BEpwPsJlpuc/7PM=;
	b=bI9vXmGVv28Gf7/iVuyWUYGioKWXkOOW0MYcrdGhJbyGacXNnhazDG2pGwLcyKcZbIQ8lFJ3c
	fhimCgLLK3xmYqktytMO2d9auFMEkpDFvpwRpFRU/3V5O8sunV9CbesPlHPJ0Pt/FYzTgdQpP0v
	1gFFOOQ2oYLon8GqrszW38w=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gR1Gb1xjDznTv3;
	Thu, 28 May 2026 17:22:15 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C869340563;
	Thu, 28 May 2026 17:30:11 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 28 May 2026 17:30:10 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v07 6/6] hinic3: Remove unneeded coalesce parameters
Date: Thu, 28 May 2026 17:29:53 +0800
Message-ID: <278906719ed4a0fe649eb954feec2bb7cebee10d.1779940072.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1779940072.git.zhuyikai1@h-partners.com>
References: <cover.1779940072.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-292629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,h-partners.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 00D235EFA75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Remove unneeded coalesce parameters in irq handling.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c | 6 +-----
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h  | 3 ---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index cc43773c1984..97dd2a029703 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -149,13 +149,9 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 		nic_dev->intr_coalesce[q_id].resend_timer_cfg;
 
 	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
-	if (err) {
+	if (err)
 		netdev_err(netdev,
 			   "Failed to modify moderation for Queue: %u\n", q_id);
-	} else {
-		nic_dev->rxqs[q_id].last_coalesc_timer_cfg = coalesc_timer_cfg;
-		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
-	}
 
 	return err;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index c11d080408a7..2ab691ed11a9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -111,9 +111,6 @@ struct hinic3_rxq {
 	dma_addr_t             cqe_start_paddr;
 
 	struct dim             dim;
-
-	u8                     last_coalesc_timer_cfg;
-	u8                     last_pending_limit;
 } ____cacheline_aligned;
 
 struct hinic3_dyna_rxq_res {
-- 
2.43.0


