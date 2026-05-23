Return-Path: <netdev+bounces-291090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPnXKTGIEWqdnAYAu9opvQ
	(envelope-from <netdev+bounces-291090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281785BE996
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625AA303ADE4
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5095388E7D;
	Sat, 23 May 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ohdwXsht"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186D34F48A;
	Sat, 23 May 2026 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533722; cv=none; b=BrB25ztWJeQCXbWrzlImCZGM0LvzhNLW4/L1hFivP6yt8H9UUe7S4MRjsrubpi6I/+PYliaD1DyZ5Av/A64896QDGe0W+zu836SNOurFlCb0jhm0xixwWI5w/B8ZTvX5V5PvMcIMy3GxI94krFdku0WJhiedhB3vaetiVT2mzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533722; c=relaxed/simple;
	bh=y/BCiDGv97cYOSDN9mdR6Qu7lNT6p5nevan7Za1EFlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMWK8YfzFs9S5au/GB0VgTekazj1gnuJjryAyY208cI6HYG1ae3QIftbOdRd5YP1/c7AoxQ+lckAZmw1qe3DcyEynK2wjh4o3EXWQFgJY75DmpUsfu5NqO0p5Tgr09EN3SZjUx2jk0g98z51KkKlqNyUkhGk+RLngH46WN6GWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ohdwXsht; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Of496qEpoMLOOs7CIOIbWkWjnXcCuZIlpv08UZPQPbQ=;
	b=ohdwXshtaNBSC0L76bwbZ6pUbTo0Jny7WiMGZ94EIA5vq6wv8SHQ3LMbXYgYQPHqjJ2OXhqTi
	a+N/XgzQLWFzXIJbutQ6uBrp46Y6oi2lylFB6/hAlX/DaeQtNWLxyAIp62jSKsUVGakxLqNV/+F
	27lai3Io3Aq2qnNjHvTuyE8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gMzPD12QMz1cyQG;
	Sat, 23 May 2026 18:47:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A7254056E;
	Sat, 23 May 2026 18:55:10 +0800 (CST)
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
Subject: [PATCH V2 net-next 4/6] net: hns3: support IP and tunnel VNI dissectors for tc flow
Date: Sat, 23 May 2026 18:54:47 +0800
Message-ID: <20260523105449.661848-5-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291090-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 281785BE996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the driver does not support FLOW_DISSECTOR_KEY_IP and
FLOW_DISSECTOR_KEY_ENC_KEYID. But the hardware supports
ip_tos (FLOW_DISSECTOR_KEY_IP) and
outer_tun_vni (FLOW_DISSECTOR_KEY_ENC_KEYID).

This patch adds support for FLOW_DISSECTOR_KEY_IP and
FLOW_DISSECTOR_KEY_ENC_KEYID.

Additionally, since tc flow cannot effectively support
l2_user_def, l3_user_def, and l4_user_def,
this patch explicitly sets them to not be used.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 79 +++++++++++++++++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  4 +
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index bbbc017a0fb7..a7320eca41d3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -16,7 +16,7 @@
 #include <linux/crash_dump.h>
 
 #include <net/rtnetlink.h>
-
+#include <net/vxlan.h>
 #include "hclge_cmd.h"
 #include "hclge_dcb.h"
 #include "hclge_main.h"
@@ -337,7 +337,9 @@ static const struct key_info tuple_key_info[] = {
 	{ OUTER_SRC_PORT, 16, KEY_OPT_LE16, -1, -1 },
 	{ OUTER_DST_PORT, 16, KEY_OPT_LE16, -1, -1 },
 	{ OUTER_L4_RSV, 32, KEY_OPT_LE32, -1, -1 },
-	{ OUTER_TUN_VNI, 24, KEY_OPT_VNI, -1, -1 },
+	{ OUTER_TUN_VNI, 24, KEY_OPT_VNI,
+	  offsetof(struct hclge_fd_rule, tuples.outer_tun_vni),
+	  offsetof(struct hclge_fd_rule, tuples_mask.outer_tun_vni) },
 	{ OUTER_TUN_FLOW_ID, 8, KEY_OPT_U8, -1, -1 },
 	{ INNER_DST_MAC, 48, KEY_OPT_MAC,
 	  offsetof(struct hclge_fd_rule, tuples.dst_mac),
@@ -5590,8 +5592,9 @@ static int hclge_init_fd_config(struct hclge_dev *hdev)
 
 	/* If use max 400bit key, we can support tuples for ether type */
 	if (hdev->fd_cfg.fd_mode == HCLGE_FD_MODE_DEPTH_2K_WIDTH_400B_STAGE_1) {
-		key_cfg->tuple_active |=
-				BIT(INNER_DST_MAC) | BIT(INNER_SRC_MAC);
+		key_cfg->tuple_active |= BIT(INNER_DST_MAC) |
+					 BIT(INNER_SRC_MAC) |
+					 BIT(OUTER_TUN_VNI);
 		if (hdev->ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V3)
 			key_cfg->tuple_active |= HCLGE_FD_TUPLE_USER_DEF_TUPLES;
 	}
@@ -5760,6 +5763,17 @@ static bool hclge_fd_convert_tuple(u32 tuple_bit, u8 *key_x, u8 *key_y,
 		*(__le32 *)key_x = cpu_to_le32(tmp_x_l);
 		*(__le32 *)key_y = cpu_to_le32(tmp_y_l);
 
+		return true;
+	case KEY_OPT_VNI:
+		calc_x(tmp_x_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
+		calc_y(tmp_y_l, *(u32 *)(&p[offset]), *(u32 *)(&p[moffset]));
+		for (i = 0; i < HCLGE_VNI_LENGTH; i++) {
+			key_x[i] = ((__force u32)cpu_to_le32(tmp_x_l) >>
+				    (i * BITS_PER_BYTE)) & 0xFF;
+			key_y[i] = ((__force u32)cpu_to_le32(tmp_y_l) >>
+				    (i * BITS_PER_BYTE)) & 0xFF;
+		}
+
 		return true;
 	default:
 		return false;
@@ -7340,6 +7354,53 @@ static void hclge_get_cls_key_port(const struct flow_rule *flow,
 	}
 }
 
+static int hclge_get_cls_enc_keyid(struct hclge_dev *hdev,
+				   const struct flow_rule *flow,
+				   struct hclge_fd_rule *rule)
+{
+	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_ENC_KEYID)) {
+		struct flow_match_enc_keyid match;
+
+		flow_rule_match_enc_keyid(flow, &match);
+
+		/* vni is only 24 bits and must be greater than 0,
+		 * and it can not be masked.
+		 */
+		if (be32_to_cpu(match.mask->keyid) !=
+		    HCLGE_FD_VXLAN_VNI_UNMASK ||
+		    be32_to_cpu(match.key->keyid) >= VXLAN_N_VID ||
+		    !match.key->keyid) {
+			dev_err(&hdev->pdev->dev, "invalid enc_keyid\n");
+			return -EINVAL;
+		}
+
+		rule->tuples.outer_tun_vni = be32_to_cpu(match.key->keyid);
+		rule->tuples_mask.outer_tun_vni =
+						be32_to_cpu(match.mask->keyid);
+	} else {
+		rule->unused_tuple |= BIT(OUTER_TUN_VNI);
+	}
+
+	return 0;
+}
+
+static void hclge_get_cls_key_ip_tos(const struct flow_rule *flow,
+				     struct hclge_fd_rule *rule)
+{
+	if (flow_rule_match_key(flow, FLOW_DISSECTOR_KEY_IP)) {
+		struct flow_match_ip match;
+
+		flow_rule_match_ip(flow, &match);
+
+		rule->tuples.ip_tos = match.key->tos;
+		rule->tuples_mask.ip_tos = match.mask->tos;
+		if (!rule->tuples.ip_tos)
+			rule->unused_tuple |= BIT(INNER_IP_TOS);
+	} else {
+		rule->unused_tuple |= BIT(INNER_IP_TOS);
+	}
+}
+
 static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
@@ -7393,6 +7454,9 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	int ret;
 
+	/* not support any user def tuples */
+	rule->unused_tuple |= HCLGE_FD_TUPLE_USER_DEF_TUPLES;
+
 	hclge_get_cls_key_basic(flow, rule);
 	hclge_get_cls_key_mac(flow, rule);
 	hclge_get_cls_key_vlan(flow, rule);
@@ -7402,8 +7466,9 @@ static int hclge_parse_cls_flower(struct hclge_dev *hdev,
 		return ret;
 
 	hclge_get_cls_key_port(flow, rule);
+	hclge_get_cls_key_ip_tos(flow, rule);
 
-	return 0;
+	return hclge_get_cls_enc_keyid(hdev, flow, rule);
 }
 
 static int hclge_check_cls_flower(struct hclge_dev *hdev,
@@ -7433,7 +7498,9 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_VLAN) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
-	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IP) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
 		dev_err(&hdev->pdev->dev, "unsupported key set: %#llx\n",
 			dissector->used_keys);
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 032b472d2368..ccb19d960690 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -645,6 +645,9 @@ struct key_info {
 #define HCLGE_FD_USER_DEF_DATA		GENMASK(15, 0)
 #define HCLGE_FD_USER_DEF_OFFSET	GENMASK(15, 0)
 #define HCLGE_FD_USER_DEF_OFFSET_UNMASK	GENMASK(15, 0)
+#define HCLGE_FD_VXLAN_VNI_UNMASK	GENMASK(31, 0)
+
+#define HCLGE_VNI_LENGTH		3
 
 /* assigned by firmware, the real filter number for each pf may be less */
 #define MAX_FD_FILTER_NUM	4096
@@ -738,6 +741,7 @@ struct hclge_fd_rule_tuples {
 	u32 l4_user_def;
 	u8 ip_tos;
 	u8 ip_proto;
+	u32 outer_tun_vni;
 };
 
 struct hclge_fd_rule {
-- 
2.33.0


