Return-Path: <netdev+bounces-200478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD72AE592B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856FA2C121F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F95189F3B;
	Tue, 24 Jun 2025 01:26:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021663FE7;
	Tue, 24 Jun 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728374; cv=none; b=JahFou4qS0jdqbHcI2/fYbpQXuHb84hzAc7y6G04McoRZfrAPSnlAssvzzWWpX+DUacPiT8htJ6lU8tqUprG6MWq1aoU/xzNbZk9VPA2TitP9YAC80x+KQjm58YLWOkNYKpetuYzgmhbpo0/q0VYYRbQOlQmDJm0irahufumqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728374; c=relaxed/simple;
	bh=aGnwgqdy4FtSjBe3EoNg9qVtk9DivJD9Nzt4l0iIhBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XsFmUwuSY7GHkNr73izrM/Ld5mqgNABSgQr/SCkk26j3Irf6+2wDBlSUiB08TMKx3IhvGiwfd6yAN6cs7YZ/GedJtfdxYK+ZD0JJciCfR1HBaK9L1T1Ku6OxaqxxLuVYE7SO7SXqPYB8DXekleW/E/xOc80if7lp2HgYZIgASRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bR6ch0Mjmz2Cff7;
	Tue, 24 Jun 2025 09:22:12 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 046CB140294;
	Tue, 24 Jun 2025 09:26:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 09:26:07 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/sched: Remove unused functions
Date: Tue, 24 Jun 2025 09:43:27 +0800
Message-ID: <20250624014327.3686873-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit c54e1d920f04 ("flow_offload: add ops to tc_action_ops for
flow action setup") these are unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/tc_act/tc_csum.h   | 9 ---------
 include/net/tc_act/tc_ct.h     | 9 ---------
 include/net/tc_act/tc_gate.h   | 9 ---------
 include/net/tc_act/tc_mpls.h   | 9 ---------
 include/net/tc_act/tc_police.h | 9 ---------
 include/net/tc_act/tc_sample.h | 9 ---------
 include/net/tc_act/tc_vlan.h   | 9 ---------
 7 files changed, 63 deletions(-)

diff --git a/include/net/tc_act/tc_csum.h b/include/net/tc_act/tc_csum.h
index 68269e4581b7..2515da0142a6 100644
--- a/include/net/tc_act/tc_csum.h
+++ b/include/net/tc_act/tc_csum.h
@@ -18,15 +18,6 @@ struct tcf_csum {
 };
 #define to_tcf_csum(a) ((struct tcf_csum *)a)
 
-static inline bool is_tcf_csum(const struct tc_action *a)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->id == TCA_ID_CSUM)
-		return true;
-#endif
-	return false;
-}
-
 static inline u32 tcf_csum_update_flags(const struct tc_action *a)
 {
 	u32 update_flags;
diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
index 77f87c622a2e..e6b45cb27ebf 100644
--- a/include/net/tc_act/tc_ct.h
+++ b/include/net/tc_act/tc_ct.h
@@ -92,13 +92,4 @@ static inline void
 tcf_ct_flow_table_restore_skb(struct sk_buff *skb, unsigned long cookie) { }
 #endif
 
-static inline bool is_tcf_ct(const struct tc_action *a)
-{
-#if defined(CONFIG_NET_CLS_ACT) && IS_ENABLED(CONFIG_NF_CONNTRACK)
-	if (a->ops && a->ops->id == TCA_ID_CT)
-		return true;
-#endif
-	return false;
-}
-
 #endif /* __NET_TC_CT_H */
diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index c8fa11ebb397..c1a67149c6b6 100644
--- a/include/net/tc_act/tc_gate.h
+++ b/include/net/tc_act/tc_gate.h
@@ -51,15 +51,6 @@ struct tcf_gate {
 
 #define to_gate(a) ((struct tcf_gate *)a)
 
-static inline bool is_tcf_gate(const struct tc_action *a)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->id == TCA_ID_GATE)
-		return true;
-#endif
-	return false;
-}
-
 static inline s32 tcf_gate_prio(const struct tc_action *a)
 {
 	s32 tcfg_prio;
diff --git a/include/net/tc_act/tc_mpls.h b/include/net/tc_act/tc_mpls.h
index 721de4f5733a..d452e5e94fd0 100644
--- a/include/net/tc_act/tc_mpls.h
+++ b/include/net/tc_act/tc_mpls.h
@@ -27,15 +27,6 @@ struct tcf_mpls {
 };
 #define to_mpls(a) ((struct tcf_mpls *)a)
 
-static inline bool is_tcf_mpls(const struct tc_action *a)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->id == TCA_ID_MPLS)
-		return true;
-#endif
-	return false;
-}
-
 static inline u32 tcf_mpls_action(const struct tc_action *a)
 {
 	u32 tcfm_action;
diff --git a/include/net/tc_act/tc_police.h b/include/net/tc_act/tc_police.h
index 283bde711a42..490d88cb5233 100644
--- a/include/net/tc_act/tc_police.h
+++ b/include/net/tc_act/tc_police.h
@@ -44,15 +44,6 @@ struct tc_police_compat {
 	struct tc_ratespec	peakrate;
 };
 
-static inline bool is_tcf_police(const struct tc_action *act)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	if (act->ops && act->ops->id == TCA_ID_POLICE)
-		return true;
-#endif
-	return false;
-}
-
 static inline u64 tcf_police_rate_bytes_ps(const struct tc_action *act)
 {
 	struct tcf_police *police = to_police(act);
diff --git a/include/net/tc_act/tc_sample.h b/include/net/tc_act/tc_sample.h
index b5d76305e854..abd163ca1864 100644
--- a/include/net/tc_act/tc_sample.h
+++ b/include/net/tc_act/tc_sample.h
@@ -17,15 +17,6 @@ struct tcf_sample {
 };
 #define to_sample(a) ((struct tcf_sample *)a)
 
-static inline bool is_tcf_sample(const struct tc_action *a)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	return a->ops && a->ops->id == TCA_ID_SAMPLE;
-#else
-	return false;
-#endif
-}
-
 static inline __u32 tcf_sample_rate(const struct tc_action *a)
 {
 	return to_sample(a)->rate;
diff --git a/include/net/tc_act/tc_vlan.h b/include/net/tc_act/tc_vlan.h
index 904eddfc1826..3f5e9242b5e8 100644
--- a/include/net/tc_act/tc_vlan.h
+++ b/include/net/tc_act/tc_vlan.h
@@ -26,15 +26,6 @@ struct tcf_vlan {
 };
 #define to_vlan(a) ((struct tcf_vlan *)a)
 
-static inline bool is_tcf_vlan(const struct tc_action *a)
-{
-#ifdef CONFIG_NET_CLS_ACT
-	if (a->ops && a->ops->id == TCA_ID_VLAN)
-		return true;
-#endif
-	return false;
-}
-
 static inline u32 tcf_vlan_action(const struct tc_action *a)
 {
 	u32 tcfv_action;
-- 
2.34.1


