Return-Path: <netdev+bounces-255853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNK6FSeXgGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:23:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80880CC4E1
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B07C3010170
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74249361674;
	Mon,  2 Feb 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="L0P7fYB9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03A125A9;
	Mon,  2 Feb 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034867; cv=none; b=GRE1R1LKws3Tu7Ipu+rK0Pbs+8cBUmdG2HyitpZAPI1v5vXFB2eqj4OwHDKxCfC6zSEUdUQNLdnCtsEbUF7QIfu4mYMcwl9RKsMjm6PYI/RMAcCp7AqLc5GLm5xVTB8eEl/eZRmPYXYB2Ch46lqLeXQmUY+ERZ4AOE3XLvIb0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034867; c=relaxed/simple;
	bh=AnT2YVUFFJTO+No6eubNJyX2iZEY+PrnugKi2bq8Qmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qGZf058aioP6E1h+UGV4DSiPP/bpd6UL4JQckXPa6seVijQDML/fgTuRN1so44JtVKaHCSFnx44aOB/suUvarLmXzoRJjC6xm1uTXHnSrIcuslw7PTS7XwrCKqzJ7pnRBTXu4+OHGCaiKJJXA3MwcXBzM4+BSJJLY8lgK8z4r2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=L0P7fYB9; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ryEz7iWunP67PC5bU94lyAnDGpTcxQMYgCmjDULTlMg=;
	b=L0P7fYB9UrI9o9eIxZc2flmv4Gqj4ILOnxz1Ar659XR2GeVKDjvrXIUniritYKaeGp+T/G68B
	212cX8hPa3MU/SvXygbgVKuy5UfeEjCRECa5ZvB4OMQLhEc0Qk/Qq3OUmvVwMXdTrmcyVhXfb5w
	/lBGCad1/eSCi/Yf1oTtA5A=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4Qbl3TF5zKm4p;
	Mon,  2 Feb 2026 20:17:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A12040565;
	Mon,  2 Feb 2026 20:20:55 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 2 Feb 2026 20:20:54 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net] net: hns3: fix double free issue for tx spare buffer
Date: Mon, 2 Feb 2026 18:58:37 +0800
Message-ID: <20260202105837.1909444-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255853-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80880CC4E1
X-Rspamd-Action: no action

From: Jian Shen <shenjian15@huawei.com>

The driver missed to clear ring->tx_spare to NULL when
fail to initialize tx spare buffer. And it will try to
free the tx spare buffer in hns3_fini_ring() if tx_spare
is not NULL. So it may cause double free issue.

Fixes: 907676b130711 ("net: hns3: use tx bounce buffer for small packets")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7a9573dcab74..e879b04e21b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1048,13 +1048,13 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 	int order;
 
 	if (!alloc_size)
-		return;
+		goto not_init;
 
 	order = get_order(alloc_size);
 	if (order > MAX_PAGE_ORDER) {
 		if (net_ratelimit())
 			dev_warn(ring_to_dev(ring), "failed to allocate tx spare buffer, exceed to max order\n");
-		return;
+		goto not_init;
 	}
 
 	tx_spare = devm_kzalloc(ring_to_dev(ring), sizeof(*tx_spare),
@@ -1092,6 +1092,13 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 	devm_kfree(ring_to_dev(ring), tx_spare);
 devm_kzalloc_error:
 	ring->tqp->handle->kinfo.tx_spare_buf_size = 0;
+not_init:
+	/* When driver init or reset_init, the ring->tx_spare is always NULL;
+	 * but when called from hns3_set_ringparam, it's usually not NULL, and
+	 * will be restored if hns3_init_all_ring() failed. So it's safe to set
+	 * ring->tx_spare to NULL here.
+	 */
+	ring->tx_spare = NULL;
 }
 
 /* Use hns3_tx_spare_space() to make sure there is enough buffer
-- 
2.33.0


