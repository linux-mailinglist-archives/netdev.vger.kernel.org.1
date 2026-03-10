Return-Path: <netdev+bounces-265837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOqbFxJvr2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:08:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7899243548
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E487305F335
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7432F4A05;
	Tue, 10 Mar 2026 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fbK5H1+k"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990C2DE6FF;
	Tue, 10 Mar 2026 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104727; cv=none; b=lp//TS0M2+w0zi/HEdwbGjsP9Nk+dRIJ6q9rbSxAFp8Mk4Z4U1j1jFUUvnYepVMjIhUFgNdq9W+UGqxA4mgoInXg5tWZRSo9gjKQqrineYFs7458Nl+6rMzFy4fzq3BGb63Z6tZKs1h5rn2XWHcoNPC+c9o6hcU5pGcpKDQXHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104727; c=relaxed/simple;
	bh=eHgaqAtHbJyOpJAZlYAAYp/D85yr9tg4xNOBbnoJ7ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIWWfu9PlZO2DMHhU8XnCNzDa4usPcx/HA/iuBSVutyPkaJ1s7zSQZ68Qe6McmpX18uVcAgVDfrLCMbeTyYudrXJDY+xVxC/roQlcLpOOHdgHn4arZT67i1ZTw4CMZIPZtjwS0Trr0Haie5C1oU0A4kyKW1FucGiIjJghY3n0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fbK5H1+k; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rd9YSCz4HUPlKdajNb7K73BKr4WWIz5l0s2dAgJkSbA=;
	b=fbK5H1+kee4/CbJUdZrhvSy7GKjrgnRfSQVsJpmaqpR12uJZMkOogunPpMJmfTTtTHEPFfW2p
	PB3CKp6uS29mC86fRYVtmgVj5mBSTUSrwiE3H8kWrsg+Lx5qTBZHT1DZD9VlIH9oQe0SZTK0MDh
	125foVoexKje34vMR5PY79o=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fVFt25Rmnz1K9Cg;
	Tue, 10 Mar 2026 09:00:26 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id ED95C4056C;
	Tue, 10 Mar 2026 09:05:18 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:17 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
Subject: [PATCH net-next v03 7/9] hinic3: Add PF FLR wait and timeout handling
Date: Tue, 10 Mar 2026 09:04:55 +0800
Message-ID: <7a1b21426fd4274831733aca962eb209b806f4bd.1773062356.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773062356.git.zhuyikai1@h-partners.com>
References: <cover.1773062356.git.zhuyikai1@h-partners.com>
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
X-Rspamd-Queue-Id: D7899243548
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265837-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

  Add a mechanism for PF to wait for the completion of FLR, ensuring
hardware state consistency after an FLR event.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 1defd6800790..a6e4e9968334 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -292,6 +292,32 @@ int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth)
 	return 0;
 }
 
+#define HINIC3_FLR_TIMEOUT    1000
+
+static enum hinic3_wait_return hinic3_check_flr_finish_handler(void *priv_data)
+{
+	struct hinic3_hwdev *hwdev = priv_data;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	enum hinic3_pf_status status;
+
+	if (!hwdev->chip_present_flag)
+		return HINIC3_WAIT_PROCESS_ERR;
+
+	status = hinic3_get_pf_status(hwif);
+	if (status == HINIC3_PF_STATUS_FLR_FINISH_FLAG) {
+		hinic3_set_pf_status(hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);
+		return HINIC3_WAIT_PROCESS_CPL;
+	}
+
+	return HINIC3_WAIT_PROCESS_WAITING;
+}
+
+static int hinic3_wait_for_flr_finish(struct hinic3_hwdev *hwdev)
+{
+	return hinic3_wait_for_timeout(hwdev, hinic3_check_flr_finish_handler,
+				       HINIC3_FLR_TIMEOUT, 0xa * USEC_PER_MSEC);
+}
+
 #define HINIC3_WAIT_CMDQ_IDLE_TIMEOUT    5000
 
 static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
@@ -389,6 +415,14 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 		ret = err;
 	}
 
+	if (HINIC3_FUNC_TYPE(hwdev) != HINIC3_FUNC_TYPE_VF) {
+		err = hinic3_wait_for_flr_finish(hwdev);
+		if (err) {
+			dev_warn(hwdev->dev, "Wait firmware FLR timeout\n");
+			ret = err;
+		}
+	}
+
 	hinic3_toggle_doorbell(hwif, ENABLE_DOORBELL);
 
 	err = hinic3_reinit_cmdq_ctxts(hwdev);
-- 
2.43.0


