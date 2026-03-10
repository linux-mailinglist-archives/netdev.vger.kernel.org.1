Return-Path: <netdev+bounces-265839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOBAK01vr2m6YQIAu9opvQ
	(envelope-from <netdev+bounces-265839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:09:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF1243574
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 825F23008CB6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87BF305047;
	Tue, 10 Mar 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CbM3ef6Z"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C82F83B7;
	Tue, 10 Mar 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104736; cv=none; b=ptXyzC0pcDxOLfNKiDO/d03CuAk5vBW+lQPRY1Xd8ViJhKy20cuqyVKPRDhzcI+t68Qh62QmBcpGsHTpsbuhoeICL+5rQ7IMWDtLinJhAYdXVP7csRz4mT7hGo3oCuXNhkksK7g2rN3ToCc5ur6nLJQndtCW1jjQINbc8XlLaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104736; c=relaxed/simple;
	bh=cvjmKAKhEq1h4g27mLn1x/IfFjZtptKlo2+AsMA7DS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx9gYQjBEVODUmfzYzVLpGsCGvO+E2Z1wY2nXz14StVsUp67THupW2VA2ZHWLEpLBdaBwaW0jdNSz2QWJR2VVYGlp7E3T8cpR3jo4EAxEANmt+JdjppVpTkIed4QIfh/iWFu6fK9KImdfpT6+QjRTmEb2xErVxSW1yYS+Q0egZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CbM3ef6Z; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MFA1o2Bv6mBXv9NnXLBlEOC0J1Am8EXz+TrfM0cRERo=;
	b=CbM3ef6ZVrXSdKqOIhEYrjVDz/6YTv54D8jw4h+wqcg3Hec27M4Kp157Dnrs3fitpfVZZQ1W4
	bycR/I4Iws5r3qasZY5AYgxnIU01x0yXPcctf0/6LdJqmA/FAUNWNzDo8mfh/1nTKQV3vwa2rPN
	p2WzLqvV51v2x95WodYLVEg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fVFt25Q6zz1cyT6;
	Tue, 10 Mar 2026 09:00:26 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CAFD4055B;
	Tue, 10 Mar 2026 09:05:21 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 10 Mar 2026 09:05:19 +0800
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
Subject: [PATCH net-next v03 8/9] hinic3: Add PF/VF capability parsing and parameter validation
Date: Tue, 10 Mar 2026 09:04:56 +0800
Message-ID: <ac4733f2c0409bb778b4624ed1632dcb2ded6632.1773062356.git.zhuyikai1@h-partners.com>
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
X-Rspamd-Queue-Id: B5DF1243574
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265839-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

  Add the ability to parse PF and VF capabilities and validate
related parameters(SQ & RQ).

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 47 +++++++++++++++++--
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  8 ++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index ca60cf4b6282..2dfa4fb39627 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -17,6 +17,17 @@ static void hinic3_parse_pub_res_cap(struct hinic3_hwdev *hwdev,
 {
 	cap->port_id = dev_cap->port_id;
 	cap->supp_svcs_bitmap = dev_cap->svc_cap_en;
+
+	cap->cos_valid_bitmap = dev_cap->valid_cos_bitmap;
+	cap->port_cos_valid_bitmap = dev_cap->port_cos_valid_bitmap;
+
+	if (type != HINIC3_FUNC_TYPE_VF)
+		cap->max_vf = dev_cap->max_vf;
+	else
+		cap->max_vf = 0;
+
+	dev_dbg(hwdev->dev, "Port_id: 0x%x, cos_bitmap: 0x%x, Max_vf: 0x%x\n",
+		cap->port_id, cap->cos_valid_bitmap, cap->max_vf);
 }
 
 static void hinic3_parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
@@ -28,6 +39,13 @@ static void hinic3_parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
 
 	nic_svc_cap->max_sqs = min(dev_cap->nic_max_sq_id + 1,
 				   HINIC3_CFG_MAX_QP);
+
+	nic_svc_cap->max_rqs = min(dev_cap->nic_max_rq_id + 1,
+				   HINIC3_CFG_MAX_QP);
+	nic_svc_cap->default_num_queues = dev_cap->nic_default_num_queues;
+
+	dev_dbg(hwdev->dev, "L2nic resource capbility, max_sqs: 0x%x, max_rqs: 0x%x\n",
+		nic_svc_cap->max_sqs, nic_svc_cap->max_rqs);
 }
 
 static void hinic3_parse_dev_cap(struct hinic3_hwdev *hwdev,
@@ -44,8 +62,8 @@ static void hinic3_parse_dev_cap(struct hinic3_hwdev *hwdev,
 		hinic3_parse_l2nic_res_cap(hwdev, cap, dev_cap, type);
 }
 
-static int get_cap_from_fw(struct hinic3_hwdev *hwdev,
-			   enum hinic3_func_type type)
+static int hinic3_get_cap_from_fw(struct hinic3_hwdev *hwdev,
+				  enum hinic3_func_type type)
 {
 	struct mgmt_msg_params msg_params = {};
 	struct cfg_cmd_dev_cap dev_cap = {};
@@ -69,6 +87,29 @@ static int get_cap_from_fw(struct hinic3_hwdev *hwdev,
 	return 0;
 }
 
+static int hinic3_get_dev_cap(struct hinic3_hwdev *hwdev)
+{
+	enum hinic3_func_type type = HINIC3_FUNC_TYPE(hwdev);
+	int err;
+
+	switch (type) {
+	case HINIC3_FUNC_TYPE_PF:
+	case HINIC3_FUNC_TYPE_VF:
+		err = hinic3_get_cap_from_fw(hwdev, type);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to get FW capability\n");
+			return err;
+		}
+		break;
+	default:
+		dev_err(hwdev->dev, "Unsupported PCI Function type: %d\n",
+			type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
@@ -215,7 +256,7 @@ void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
 
 int hinic3_init_capability(struct hinic3_hwdev *hwdev)
 {
-	return get_cap_from_fw(hwdev, HINIC3_FUNC_TYPE_VF);
+	return hinic3_get_dev_cap(hwdev);
 }
 
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
index 58806199bf54..361c0b6a70f0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -26,6 +26,8 @@ struct hinic3_irq_info {
 
 struct hinic3_nic_service_cap {
 	u16 max_sqs;
+	u16 max_rqs;
+	u16 default_num_queues;
 };
 
 /* Device capabilities */
@@ -34,6 +36,12 @@ struct hinic3_dev_cap {
 	u16                           supp_svcs_bitmap;
 	/* Physical port */
 	u8                            port_id;
+
+	u8                            cos_valid_bitmap;
+	u8                            port_cos_valid_bitmap;
+	/* max number of VFs that PF supports */
+	u16                           max_vf;
+
 	struct hinic3_nic_service_cap nic_svc_cap;
 };
 
-- 
2.43.0


