Return-Path: <netdev+bounces-252733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBlYOV1Ec2lEuQAAu9opvQ
	(envelope-from <netdev+bounces-252733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:50:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D5C739C6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58D8302BE18
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9400B3783BC;
	Fri, 23 Jan 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gHP7Sm1z"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756362874E1;
	Fri, 23 Jan 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161772; cv=none; b=eQpAqDYAXmv6PrOkYfGlhpR92vPcwsxhUavrvJNTYq1veOwPkzyU43ANNpS3Ie3ExuauC08tsaieuNx6LQCZcVfnvmk5gc9NrHf/lTPBKkkVyDq4zEO8rJ7qiJWn3+K54Ig/fqCwSy7U1zwRglzmL5at7+5TpM/JRmiaP0Lbn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161772; c=relaxed/simple;
	bh=ctRYPaoSJckZixvRzJhk2k/Q/Ye3rJqrslt9/IjuSko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abgOxwEEBP5TTu64Hm2KnbmawnK8Ad7HSgIuSIwl1NpRAe6YdTN5mvCV0LhF64KaDh6Gi0tZB97ef8qvm6USh5M0Z0saFEEhLPbIaoUwZsKr5dl6PIczFFyA58YOp2nusxTrZKUMEM7XOMy3PDoB7mr3Nl/Ht2RiHQqNzW4Pc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gHP7Sm1z; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JhoRHwQY9BvoOWVz7LKr53DJxhG4keQmUnjazSxPcYo=;
	b=gHP7Sm1zTlUAeimEbt7Sxvw8XC1Y8U6eSwYGBQ+oWpxrpgPmETl/k6fSujhhmc72fJQ0PXw1i
	0Ai9HcfgpUV/j+EgDzZ/j0ghgtNb6M/Jy1RE5OSoeMK8l87zq7/fIcRpjikf46tc32+76lLPMbw
	bag7/JYiHZNG26pPwkMUHmI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dyCht26Ftzcb0n;
	Fri, 23 Jan 2026 17:45:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 25981404AD;
	Fri, 23 Jan 2026 17:49:19 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 23 Jan 2026 17:49:18 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 1/2] net: hns3: extend HCLGE_FD_AD_QID to 11 bits
Date: Fri, 23 Jan 2026 17:47:55 +0800
Message-ID: <20260123094756.3718516-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260123094756.3718516-1-shaojijie@huawei.com>
References: <20260123094756.3718516-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,huawei.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252733-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53D5C739C6
X-Rspamd-Action: no action

Currently, HCLGE_FD_AD_QID has only 10 bits and supports a
maximum of 1023 queues. However, there are actually scenarios
where the queue_id exceeds 1023.

This patch adds an additional bit to HCLGE_FD_AD_QID to ensure
that queue_id greater than 1023 are supported.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 5 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 416e02e7b995..bc333d8710ac 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -727,8 +727,8 @@ struct hclge_fd_tcam_config_3_cmd {
 
 #define HCLGE_FD_AD_DROP_B		0
 #define HCLGE_FD_AD_DIRECT_QID_B	1
-#define HCLGE_FD_AD_QID_S		2
-#define HCLGE_FD_AD_QID_M		GENMASK(11, 2)
+#define HCLGE_FD_AD_QID_L_S		2
+#define HCLGE_FD_AD_QID_L_M		GENMASK(11, 2)
 #define HCLGE_FD_AD_USE_COUNTER_B	12
 #define HCLGE_FD_AD_COUNTER_NUM_S	13
 #define HCLGE_FD_AD_COUNTER_NUM_M	GENMASK(19, 13)
@@ -741,6 +741,7 @@ struct hclge_fd_tcam_config_3_cmd {
 #define HCLGE_FD_AD_TC_OVRD_B		16
 #define HCLGE_FD_AD_TC_SIZE_S		17
 #define HCLGE_FD_AD_TC_SIZE_M		GENMASK(20, 17)
+#define HCLGE_FD_AD_QID_H_B		21
 
 struct hclge_fd_ad_config_cmd {
 	u8 stage;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b8e2aa19f9e6..a90f1a91f997 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5679,11 +5679,13 @@ static int hclge_fd_ad_config(struct hclge_dev *hdev, u8 stage, int loc,
 		hnae3_set_field(ad_data, HCLGE_FD_AD_TC_SIZE_M,
 				HCLGE_FD_AD_TC_SIZE_S, (u32)action->tc_size);
 	}
+	hnae3_set_bit(ad_data, HCLGE_FD_AD_QID_H_B,
+		      action->queue_id >= HCLGE_TQP_MAX_SIZE_DEV_V2 ? 1 : 0);
 	ad_data <<= 32;
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_DROP_B, action->drop_packet);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_DIRECT_QID_B,
 		      action->forward_to_direct_queue);
-	hnae3_set_field(ad_data, HCLGE_FD_AD_QID_M, HCLGE_FD_AD_QID_S,
+	hnae3_set_field(ad_data, HCLGE_FD_AD_QID_L_M, HCLGE_FD_AD_QID_L_S,
 			action->queue_id);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_USE_COUNTER_B, action->use_counter);
 	hnae3_set_field(ad_data, HCLGE_FD_AD_COUNTER_NUM_M,
-- 
2.33.0


