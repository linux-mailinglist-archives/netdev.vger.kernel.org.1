Return-Path: <netdev+bounces-291092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGpeLdaIEWoJnQYAu9opvQ
	(envelope-from <netdev+bounces-291092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 13:00:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1A5BE9B1
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF8B3058748
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8D388382;
	Sat, 23 May 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LoP0bnHI";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LoP0bnHI"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FD34F48A;
	Sat, 23 May 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533734; cv=none; b=rWphNRLSpE/l9Au3LLHK0GZneN6SswRuu0UPdy+9wHm8xT+S935Gfihg9cFqE2jGQNC6BzujYY+/mfYjZoWRPbordPVBMHVXQG/nt1MEpzXRU5DqIAOOkDOcNFQyV0FpbIUXi39dwkH7RY9w46fW1qpCZ1mSjv0Y5Rd0dXQ68yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533734; c=relaxed/simple;
	bh=4IRMK1SH8vkPGzTRoAu/9PzlKVGstmE0gkZLpRNV7SM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKYJcLAZGA+W1NqIU87gucvMQ1keEAYEF3qtQf0fsG2PzIzT3EkVZ1vIvqDsCicKL2q58znOxENX7/12TSTMMrgEu2LgUNQVHnMpLhR29vjLJEXuGmcV6RdpjaGklRp79bBpuYUHzi/amxBMeGjrsVjEYyI1AwquhtpS0PYpP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LoP0bnHI; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LoP0bnHI; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9knPvIDKpNZX0ND2NsTb0A/XO0/cA9NffW2E5WLknz0=;
	b=LoP0bnHI79AILw9+hY4mHJUgmBSbS/FFQ9TybgkDFwNRYbXlwk2UcNNFqvdqwJhtLpZ4pU95t
	jYpu2WHM7K/79/c3j4AIeoVJuAZDW+7HT4wsnu7uOUZWG1kd44qyHx/OrMmerXi6JaTmquE4xAp
	pvTg1TaTHcNloFdTyBOitpM=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gMzYP1pxhz1BGVb;
	Sat, 23 May 2026 18:54:33 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9knPvIDKpNZX0ND2NsTb0A/XO0/cA9NffW2E5WLknz0=;
	b=LoP0bnHI79AILw9+hY4mHJUgmBSbS/FFQ9TybgkDFwNRYbXlwk2UcNNFqvdqwJhtLpZ4pU95t
	jYpu2WHM7K/79/c3j4AIeoVJuAZDW+7HT4wsnu7uOUZWG1kd44qyHx/OrMmerXi6JaTmquE4xAp
	pvTg1TaTHcNloFdTyBOitpM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gMzP91jTlzmV6Y;
	Sat, 23 May 2026 18:47:25 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id ABB3B40565;
	Sat, 23 May 2026 18:55:09 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 23 May 2026 18:55:09 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net-next 3/6] net: hns3: support two more actions for tc flow
Date: Sat, 23 May 2026 18:54:46 +0800
Message-ID: <20260523105449.661848-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260523105449.661848-1-shaojijie@huawei.com>
References: <20260523105449.661848-1-shaojijie@huawei.com>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291092-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0EE1A5BE9B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the driver supports only one action:HCLGE_FD_ACTION_SELECT_TC.

This patch adds support for HCLGE_FD_ACTION_SELECT_QUEUE and
HCLGE_FD_ACTION_DROP_PACKET.

A rule can have only one action. Therefore, the driver intercepts rules
that have multiple actions or no action.

Note: The driver considers cls_flower->classid as an action:
HCLGE_FD_ACTION_SELECT_TC.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 59 ++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6eb4c6e4df4e..bbbc017a0fb7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7344,18 +7344,45 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
 {
+	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
+	struct flow_action *action = &flow->action;
+	struct flow_action_entry *act;
 	int tc;
 
-	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
-	if (tc < 0 || tc > hdev->tc_max) {
-		dev_err(&hdev->pdev->dev, "invalid traffic class: %d\n", tc);
-		return -EINVAL;
+	if (!flow_action_has_entries(&flow->action)) {
+		tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
+		if (tc < 0 || tc > hdev->tc_max) {
+			dev_err(&hdev->pdev->dev,
+				"invalid traffic class: %d\n", tc);
+			return -EINVAL;
+		}
+
+		rule->action = HCLGE_FD_ACTION_SELECT_TC;
+		rule->cls_flower.tc = tc;
+		return 0;
 	}
 
-	rule->action = HCLGE_FD_ACTION_SELECT_TC;
-	rule->cls_flower.tc = tc;
-	return 0;
+	act = &action->entries[0];
+	switch (act->id) {
+	case FLOW_ACTION_RX_QUEUE_MAPPING:
+		if (act->rx_queue >= handle->kinfo.num_tqps) {
+			dev_err(&hdev->pdev->dev,
+				"queue id (%u) should be less than %u\n",
+				act->rx_queue, handle->kinfo.num_tqps - 1);
+			return -EINVAL;
+		}
+
+		rule->queue_id = act->rx_queue;
+		rule->action = HCLGE_FD_ACTION_SELECT_QUEUE;
+		return 0;
+	case FLOW_ACTION_DROP:
+		rule->action = HCLGE_FD_ACTION_DROP_PACKET;
+		return 0;
+	default:
+		dev_err(&hdev->pdev->dev, "unsupported action(%d)\n", act->id);
+		return -EOPNOTSUPP;
+	}
 }
 
 static int hclge_parse_cls_flower(struct hclge_dev *hdev,
@@ -7412,6 +7439,24 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 		return -EOPNOTSUPP;
 	}
 
+	/* driver will parses classid into an action */
+	if (cls_flower->classid && flow_action_has_entries(&flow->action)) {
+		dev_err(&hdev->pdev->dev,
+			"please not set classid and action together\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!flow_action_has_entries(&flow->action) && !cls_flower->classid) {
+		dev_err(&hdev->pdev->dev, "please set action or classid\n");
+		return -EINVAL;
+	}
+
+	if (flow_action_has_entries(&flow->action) &&
+	    !flow_offload_has_one_action(&flow->action)) {
+		dev_err(&hdev->pdev->dev, "unsupported multiple actions\n");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.33.0


