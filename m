Return-Path: <netdev+bounces-260391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMneCz5bnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:03:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9825A183620
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1E923038AE8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E8F36656F;
	Tue, 24 Feb 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cZ6jpdHo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA775364EB7;
	Tue, 24 Feb 2026 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920110; cv=none; b=p3uwn/nzTHBpVnkZUxb+qL1KV+UPHuL1QwAZurGU6XJ+f4QkcQw4Bj3hpKHSITnKM7YB9XBqIzPmbszbi0t/ww42CYGD1XY+c/rRXmRfM5TiUQ2HBGjjcmMF77Sklty99D0BrmnKyiDgyOFbiXkV9B+t5VnisOuTg2PWRe/ZEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920110; c=relaxed/simple;
	bh=HURnbhN5YoL2LHHe05TSwFZUPje/mL5Im+K+4MEiyVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXv+o7iOkU64Wp8V5wZySiLXM3ibJR7YRLp7HUb7yDk3SP+4nYzj77oXTZFMgFYQMXa1uf8/wr6kViRv3sJZ9z55UV6oG7a5JSHnIXsEBH0nSsFxjHrKcDC6Tw8iG94xLTBtb8MpY3bSS2KG4xZoqOWNPhcSZI/F4FU/9QuENEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cZ6jpdHo; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHnq893270545;
	Tue, 24 Feb 2026 00:01:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	rtIPZKYmKvUmfKg16zV0jWK1LpRe1Lw1CkcWq47bPg=; b=cZ6jpdHocJByjsXqe
	IdH1WpL6xC04lyDzi0nGjz+kdRl6OC2uuS0LW8vIASUu9qOxhj5oL54Am38qTphp
	bZN2Nwdq5trD7kRC0eG9waRHbYNjBNEtFPBg85Tpy4nACbacAICf2fpODtiFAt59
	8C76Sr3PHFMjK00zXk2mNmVW//z6nKGgQvXXxODuQKfa/LKC/+Iz+FfAUoWQJ36p
	TuEPIH+B70UBHuMWak4N1XplYQ8fIikQpTE5v07BM55us20YyAeVq2hT2VJ2mLFV
	XHO8JoWy9UHL66KvzbgHzmoEPlzGypAbbvZQTgb71Xkm0EPgYPe9gvieAYc5vs2q
	H2+4w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkec2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 00:01:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 00:01:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 00:01:35 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0EBE63F7082;
	Tue, 24 Feb 2026 00:01:29 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v9 11/13] octeontx2-pf: cn20k: Add TC rules support
Date: Tue, 24 Feb 2026 13:30:07 +0530
Message-ID: <20260224080009.4147301-12-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224080009.4147301-1-rkannoth@marvell.com>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d5ae2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=DpXxuF1KUPOfmLfLDTAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: VAKPn8ollzdZmBQa-u1QZEaFctEeCKwP
X-Proofpoint-GUID: VAKPn8ollzdZmBQa-u1QZEaFctEeCKwP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2OCBTYWx0ZWRfX2zaEQNcCEvKO
 vVsa+F6ntYZ4dNMwHykcbByc5f3aM0dl6Z3yyVypd5HgQWc5L77tbqJGgDKkq4AEQnQQXwNXb6W
 zLUmA9whI8QAezkkVTmZgvd4MaMxKce768lY95+awoBujI6L3t4L1kDeFzbrBMGnlSAKtp1zSFd
 HivCSQEE+WS+U6388IC4BIKil3LZxdJNtr8pksadpPvk+uevd9qR4u4VyE0akcvaIQRh55DTCQd
 3h97OLDqmka/B5EZYHXpHX6Oe56Cc/EaOhdSKwsBq0OZe1U0Ga754yHHwG75WvmxjXB4CYI9wVk
 kxMdWmKpZEOxaMN6ng/vyfMWJDV2FD4m+asSB+GbRM4JW6jrtp1D7LLvMG+OZyYCx3Kc0Wl7sVy
 CouvGWRjGNmXkNRD7d649l9d5J5jylCU19AYTOo78PzGChm65a1nQNWSsRKTTWL7OAzqeOaBZgA
 UdUsebq+np5+FkKw8cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260391-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,marvell.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9825A183620
X-Rspamd-Action: no action

From: Subbaraya Sundeep <sbhatta@marvell.com>

Unlike previous silicons, MCAM entries required for TC rules in CN20K
are allocated dynamically. The key size can also be dynamic, i.e., X2 or
X4. Based on the size of the TC rule match criteria, the AF driver
allocates an X2 or X4 rule. This patch implements the required changes
for CN20K TC by requesting an MCAM entry from the AF driver on the fly
when the user installs a rule. Based on the TC rule priority added or
deleted by the user, the PF driver shifts MCAM entries accordingly. If
there is a mix of X2 and X4 rules and the user tries to install a rule
in the middle of existing rules, the PF driver detects this and rejects
the rule since X2 and X4 rules cannot be shifted in hardware.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   5 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 266 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  14 +
 .../marvell/octeontx2/nic/otx2_common.h       |  35 +++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  79 +++---
 5 files changed, 361 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 79cb1c752c2b..2d9f6cb4820f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1875,6 +1875,11 @@ struct npc_install_flow_req {
 	u8 hw_prio;
 	u8  req_kw_type; /* Key type to be written */
 	u8 alloc_entry;	/* only for cn20k */
+/* For now use any priority, once AF driver is changed to
+ * allocate least priority entry instead of mid zone then make
+ * NPC_MCAM_LEAST_PRIO as 3
+ */
+#define NPC_MCAM_LEAST_PRIO	NPC_MCAM_ANY_PRIO
 	u16 ref_prio;
 	u16 ref_entry;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index a60f8cf53feb..a5a8f4558717 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -251,6 +251,272 @@ static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
 #endif
 }
 
+static int cn20k_tc_get_entry_index(struct otx2_flow_config *flow_cfg,
+				    struct otx2_tc_flow *node)
+{
+	struct otx2_tc_flow *tmp;
+	int index = 0;
+
+	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
+		if (tmp == node)
+			return index;
+
+		index++;
+	}
+
+	return -1;
+}
+
+int cn20k_tc_free_mcam_entry(struct otx2_nic *nic, u16 entry)
+{
+	struct npc_mcam_free_entry_req *req;
+	int err;
+
+	mutex_lock(&nic->mbox.lock);
+	req = otx2_mbox_alloc_msg_npc_mcam_free_entry(&nic->mbox);
+	if (!req) {
+		mutex_unlock(&nic->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->entry = entry;
+	/* Send message to AF to free MCAM entries */
+	err = otx2_sync_mbox_msg(&nic->mbox);
+	if (err) {
+		mutex_unlock(&nic->mbox.lock);
+		return err;
+	}
+
+	mutex_unlock(&nic->mbox.lock);
+
+	return 0;
+}
+
+static bool cn20k_tc_check_entry_shiftable(struct otx2_nic *nic,
+					   struct otx2_flow_config *flow_cfg,
+					   struct otx2_tc_flow *node, int index,
+					   bool error)
+{
+	struct otx2_tc_flow *first, *tmp, *n;
+	u32 prio = 0;
+	int i = 0;
+	u8 type;
+
+	first = list_first_entry(&flow_cfg->flow_list_tc, struct otx2_tc_flow,
+				 list);
+	type = first->kw_type;
+
+	/* Check all the nodes from start to given index (including index) has
+	 * same type i.e, either X2 or X4
+	 */
+	list_for_each_entry_safe(tmp, n, &flow_cfg->flow_list_tc, list) {
+		if (i > index)
+			break;
+
+		if (type != tmp->kw_type) {
+			/* List has both X2 and X4 entries so entries cannot be
+			 * shifted to save MCAM space.
+			 */
+			if (error)
+				dev_err(nic->dev, "Rule %d cannot be shifted to %d\n",
+					tmp->prio, prio);
+			return false;
+		}
+
+		type = tmp->kw_type;
+		prio = tmp->prio;
+		i++;
+	}
+
+	return true;
+}
+
+void cn20k_tc_update_mcam_table_del_req(struct otx2_nic *nic,
+					struct otx2_flow_config *flow_cfg,
+					struct otx2_tc_flow *node)
+{
+	struct otx2_tc_flow *first, *tmp, *n;
+	int i = 0, index;
+	u16 cntr_val = 0;
+	u16 entry;
+
+	index = cn20k_tc_get_entry_index(flow_cfg, node);
+	if (index < 0) {
+		netdev_dbg(nic->netdev, "Could not find node\n");
+		return;
+	}
+
+	first = list_first_entry(&flow_cfg->flow_list_tc, struct otx2_tc_flow,
+				 list);
+	entry = first->entry;
+
+	/* If entries cannot be shifted then delete given entry
+	 * and free it to AF too.
+	 */
+	if (!cn20k_tc_check_entry_shiftable(nic, flow_cfg, node,
+					    index, false)) {
+		list_del(&node->list);
+		entry = node->entry;
+		goto free_mcam_entry;
+	}
+
+	/* Find and delete the entry from the list and re-install
+	 * all the entries from beginning to the index of the
+	 * deleted entry to higher mcam indexes.
+	 */
+	list_for_each_entry_safe(tmp, n, &flow_cfg->flow_list_tc, list) {
+		if (node == tmp) {
+			list_del(&tmp->list);
+			break;
+		}
+
+		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
+		tmp->entry = (list_next_entry(tmp, list))->entry;
+		tmp->req.entry = tmp->entry;
+		tmp->req.cntr_val = cntr_val;
+	}
+
+	list_for_each_entry_safe(tmp, n, &flow_cfg->flow_list_tc, list) {
+		if (i == index)
+			break;
+
+		otx2_add_mcam_flow_entry(nic, &tmp->req);
+		i++;
+	}
+
+free_mcam_entry:
+	if (cn20k_tc_free_mcam_entry(nic, entry))
+		netdev_err(nic->netdev, "Freeing entry %d to AF failed\n",
+			   entry);
+}
+
+int cn20k_tc_update_mcam_table_add_req(struct otx2_nic *nic,
+				       struct otx2_flow_config *flow_cfg,
+				       struct otx2_tc_flow *node)
+{
+	struct otx2_tc_flow *tmp;
+	u16 cntr_val = 0;
+	int list_idx, i;
+	int entry, prev;
+
+	/* Find the index of the entry(list_idx) whose priority
+	 * is greater than the new entry and re-install all
+	 * the entries from beginning to list_idx to higher
+	 * mcam indexes.
+	 */
+	list_idx = otx2_tc_add_to_flow_list(flow_cfg, node);
+	entry = node->entry;
+	if (!cn20k_tc_check_entry_shiftable(nic, flow_cfg, node,
+					    list_idx, true))
+		/* Due to mix of X2 and X4, entries cannot be shifted.
+		 * In this case free the entry allocated for this rule.
+		 */
+		return -EINVAL;
+
+	for (i = 0; i < list_idx; i++) {
+		tmp = otx2_tc_get_entry_by_index(flow_cfg, i);
+		if (!tmp)
+			return -ENOMEM;
+
+		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
+		prev = tmp->entry;
+		tmp->entry = entry;
+		tmp->req.entry = tmp->entry;
+		tmp->req.cntr_val = cntr_val;
+		otx2_add_mcam_flow_entry(nic, &tmp->req);
+		entry = prev;
+	}
+
+	return entry;
+}
+
+#define MAX_TC_HW_PRIORITY		125
+#define MAX_TC_VF_PRIORITY		126
+#define MAX_TC_PF_PRIORITY		127
+
+static int __cn20k_tc_alloc_entry(struct otx2_nic *nic,
+				  struct npc_install_flow_req *flow_req,
+				  u16 *entry, u8 *type,
+				  u32 tc_priority, bool hw_priority)
+{
+	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
+	struct npc_install_flow_req *req;
+	struct npc_install_flow_rsp *rsp;
+	struct otx2_tc_flow *tmp;
+	int ret = 0;
+
+	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
+	if (!req)
+		return -ENOMEM;
+
+	memcpy(&flow_req->hdr, &req->hdr, sizeof(struct mbox_msghdr));
+	memcpy(req, flow_req, sizeof(struct npc_install_flow_req));
+	req->alloc_entry = 1;
+
+	/* Allocate very least priority for first rule */
+	if (hw_priority || list_empty(&flow_cfg->flow_list_tc)) {
+		req->ref_prio = NPC_MCAM_LEAST_PRIO;
+	} else {
+		req->ref_prio = NPC_MCAM_HIGHER_PRIO;
+		tmp = list_first_entry(&flow_cfg->flow_list_tc,
+				       struct otx2_tc_flow, list);
+		req->ref_entry = tmp->entry;
+	}
+
+	ret = otx2_sync_mbox_msg(&nic->mbox);
+	if (ret)
+		return ret;
+
+	rsp = (struct npc_install_flow_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
+							       0, &req->hdr);
+	if (IS_ERR(rsp))
+		return -EFAULT;
+
+	if (entry)
+		*entry = rsp->entry;
+	if (type)
+		*type = rsp->kw_type;
+
+	return ret;
+}
+
+int cn20k_tc_alloc_entry(struct otx2_nic *nic,
+			 struct flow_cls_offload *tc_flow_cmd,
+			 struct otx2_tc_flow *new_node,
+			 struct npc_install_flow_req *flow_req)
+{
+	bool hw_priority = false;
+	u16 entry_from_af;
+	u8 entry_type;
+	int ret;
+
+	if (is_otx2_vf(nic->pcifunc))
+		flow_req->hw_prio = MAX_TC_VF_PRIORITY;
+	else
+		flow_req->hw_prio = MAX_TC_PF_PRIORITY;
+
+	if (new_node->prio <= MAX_TC_HW_PRIORITY) {
+		flow_req->hw_prio = new_node->prio;
+		hw_priority = true;
+	}
+
+	mutex_lock(&nic->mbox.lock);
+
+	ret = __cn20k_tc_alloc_entry(nic, flow_req, &entry_from_af, &entry_type,
+				     new_node->prio, hw_priority);
+	if (ret) {
+		mutex_unlock(&nic->mbox.lock);
+		return ret;
+	}
+
+	new_node->kw_type = entry_type;
+	new_node->entry = entry_from_af;
+
+	mutex_unlock(&nic->mbox.lock);
+
+	return 0;
+}
+
 static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 			      int pool_id, int numptrs)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
index 832adaf8c57f..b5e527f6d7eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
@@ -10,8 +10,22 @@
 
 #include "otx2_common.h"
 
+struct otx2_flow_config;
+struct otx2_tc_flow;
+
 void cn20k_init(struct otx2_nic *pfvf);
 int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
 void cn20k_disable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
 void cn20k_enable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
+void cn20k_tc_update_mcam_table_del_req(struct otx2_nic *nic,
+					struct otx2_flow_config *flow_cfg,
+					struct otx2_tc_flow *node);
+int cn20k_tc_update_mcam_table_add_req(struct otx2_nic *nic,
+				       struct otx2_flow_config *flow_cfg,
+				       struct otx2_tc_flow *node);
+int cn20k_tc_alloc_entry(struct otx2_nic *nic,
+			 struct flow_cls_offload *tc_flow_cmd,
+			 struct otx2_tc_flow *new_node,
+			 struct npc_install_flow_req *dummy);
+int cn20k_tc_free_mcam_entry(struct otx2_nic *nic, u16 entry);
 #endif /* CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 255c7e2633bb..eecee612b7b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -366,6 +366,31 @@ struct otx2_flow_config {
 	u16			ntuple_cnt;
 };
 
+struct otx2_tc_flow_stats {
+	u64 bytes;
+	u64 pkts;
+	u64 used;
+};
+
+struct otx2_tc_flow {
+	struct list_head		list;
+	unsigned long			cookie;
+	struct rcu_head			rcu;
+	struct otx2_tc_flow_stats	stats;
+	spinlock_t			lock; /* lock for stats */
+	u16				rq;
+	u16				entry;
+	u16				leaf_profile;
+	bool				is_act_police;
+	u32				prio;
+	struct npc_install_flow_req	req;
+	u64				rate;
+	u32				burst;
+	u32				mcast_grp_idx;
+	bool				is_pps;
+	u8				kw_type; /* X2/X4 */
+};
+
 struct dev_hw_ops {
 	int	(*sq_aq_init)(void *dev, u16 qidx, u8 chan_offset,
 			      u16 sqb_aura);
@@ -1223,4 +1248,14 @@ void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
 int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
 void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
 			int first, int mdevs, u64 intr);
+int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry,
+			     u16 *cntr_val);
+int otx2_add_mcam_flow_entry(struct otx2_nic *nic,
+			     struct npc_install_flow_req *req);
+int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
+			     struct otx2_tc_flow *node);
+
+struct otx2_tc_flow *
+otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg,
+			   int index);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 26a08d2cfbb1..700b8e0f7481 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -31,30 +31,6 @@
 
 #define MCAST_INVALID_GRP		(-1U)
 
-struct otx2_tc_flow_stats {
-	u64 bytes;
-	u64 pkts;
-	u64 used;
-};
-
-struct otx2_tc_flow {
-	struct list_head		list;
-	unsigned long			cookie;
-	struct rcu_head			rcu;
-	struct otx2_tc_flow_stats	stats;
-	spinlock_t			lock; /* lock for stats */
-	u16				rq;
-	u16				entry;
-	u16				leaf_profile;
-	bool				is_act_police;
-	u32				prio;
-	struct npc_install_flow_req	req;
-	u32				mcast_grp_idx;
-	u64				rate;
-	u32				burst;
-	bool				is_pps;
-};
-
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
 {
@@ -971,8 +947,9 @@ static void otx2_destroy_tc_flow_list(struct otx2_nic *pfvf)
 	}
 }
 
-static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct otx2_flow_config *flow_cfg,
-							unsigned long cookie)
+static struct otx2_tc_flow *
+otx2_tc_get_entry_by_cookie(struct otx2_flow_config *flow_cfg,
+			    unsigned long cookie)
 {
 	struct otx2_tc_flow *tmp;
 
@@ -984,8 +961,8 @@ static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct otx2_flow_config
 	return NULL;
 }
 
-static struct otx2_tc_flow *otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg,
-						       int index)
+struct otx2_tc_flow *
+otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg, int index)
 {
 	struct otx2_tc_flow *tmp;
 	int i = 0;
@@ -1014,8 +991,8 @@ static void otx2_tc_del_from_flow_list(struct otx2_flow_config *flow_cfg,
 	}
 }
 
-static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
-				    struct otx2_tc_flow *node)
+int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
+			     struct otx2_tc_flow *node)
 {
 	struct list_head *pos, *n;
 	struct otx2_tc_flow *tmp;
@@ -1038,7 +1015,8 @@ static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
 	return index;
 }
 
-static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct npc_install_flow_req *req)
+int otx2_add_mcam_flow_entry(struct otx2_nic *nic,
+			     struct npc_install_flow_req *req)
 {
 	struct npc_install_flow_req *tmp_req;
 	int err;
@@ -1064,7 +1042,7 @@ static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct npc_install_flo
 	return 0;
 }
 
-static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
+int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
 {
 	struct npc_delete_flow_rsp *rsp;
 	struct npc_delete_flow_req *req;
@@ -1114,6 +1092,11 @@ static int otx2_tc_update_mcam_table_del_req(struct otx2_nic *nic,
 	int i = 0, index = 0;
 	u16 cntr_val = 0;
 
+	if (is_cn20k(nic->pdev)) {
+		cn20k_tc_update_mcam_table_del_req(nic, flow_cfg, node);
+		return 0;
+	}
+
 	/* Find and delete the entry from the list and re-install
 	 * all the entries from beginning to the index of the
 	 * deleted entry to higher mcam indexes.
@@ -1153,6 +1136,9 @@ static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
 	int list_idx, i;
 	u16 cntr_val = 0;
 
+	if (is_cn20k(nic->pdev))
+		return cn20k_tc_update_mcam_table_add_req(nic, flow_cfg, node);
+
 	/* Find the index of the entry(list_idx) whose priority
 	 * is greater than the new entry and re-install all
 	 * the entries from beginning to list_idx to higher
@@ -1172,7 +1158,7 @@ static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
 		mcam_idx++;
 	}
 
-	return mcam_idx;
+	return flow_cfg->flow_ent[mcam_idx];
 }
 
 static int otx2_tc_update_mcam_table(struct otx2_nic *nic,
@@ -1238,7 +1224,6 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		mutex_unlock(&nic->mbox.lock);
 	}
 
-
 free_mcam_flow:
 	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
 	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
@@ -1254,7 +1239,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
 	struct otx2_tc_flow *new_node, *old_node;
 	struct npc_install_flow_req *req, dummy;
-	int rc, err, mcam_idx;
+	int rc, err, entry;
 
 	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
 		return -ENOMEM;
@@ -1264,7 +1249,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 		return -EINVAL;
 	}
 
-	if (flow_cfg->nr_flows == flow_cfg->max_flows) {
+	if (!is_cn20k(nic->pdev) && flow_cfg->nr_flows == flow_cfg->max_flows) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Free MCAM entry not available to add the flow");
 		return -ENOMEM;
@@ -1292,7 +1277,23 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	if (old_node)
 		otx2_tc_del_flow(nic, tc_flow_cmd);
 
-	mcam_idx = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
+	if (is_cn20k(nic->pdev)) {
+		rc = cn20k_tc_alloc_entry(nic, tc_flow_cmd, new_node, &dummy);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MCAM rule allocation failed");
+			kfree_rcu(new_node, rcu);
+			return rc;
+		}
+	}
+
+	entry = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
+	if (entry < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Adding rule failed");
+		rc = entry;
+		goto free_leaf;
+	}
+
 	mutex_lock(&nic->mbox.lock);
 	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
 	if (!req) {
@@ -1304,7 +1305,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
 	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));
 	req->channel = nic->hw.rx_chan_base;
-	req->entry = flow_cfg->flow_ent[mcam_idx];
+	req->entry = (u16)entry;
 	req->intf = NIX_INTF_RX;
 	req->vf = nic->pcifunc;
 	req->set_cntr = 1;
@@ -1325,6 +1326,8 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	return 0;
 
 free_leaf:
+	if (is_cn20k(nic->pdev))
+		cn20k_tc_free_mcam_entry(nic, new_node->entry);
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
-- 
2.43.0


