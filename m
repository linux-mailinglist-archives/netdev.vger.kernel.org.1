Return-Path: <netdev+bounces-303978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MhKrFDrvRWp4GwsAu9opvQ
	(envelope-from <netdev+bounces-303978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A86F37A3
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=dl5NKEO+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303978-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303978-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F33C30A555A
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E736E484;
	Thu,  2 Jul 2026 04:51:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695E431E76;
	Thu,  2 Jul 2026 04:51:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967869; cv=none; b=fq3SqxaA7uStFXSG9+554EXAURzARgSBk11QGmTGiFgR/6CB1pBvRDC91RanfOWIeHWztYfbBeJ1CmVi5TVb2D6bh/MkXSP61q06EZtbgtbDLFtPpFbs4HpCz8WyhBDxFGd2coMk8eXyro7c8xfZMCt6P3xOaPMLWl71fAov3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967869; c=relaxed/simple;
	bh=m3GTuk7zcCs2/hx+l99+GY/oJ+083zuv76hdOcw8P2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZC1oSV83wMA+4hWBJ6L7m2djRfDsEB0QhlbAwdeCvDv3wBYbykwmsjPTKv1MWOx0Lg9YHnB7I2TyxRFBE6QHxfSJJvbv8WmRs2sc4EmHSM4DxyogaAn7TQOi5C1SDmDNyk7dL3Ft/IPt7PU9xSFzN4tr+1nKfYDm+2d/iVxbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dl5NKEO+; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MDw5213818;
	Wed, 1 Jul 2026 21:50:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
	i82gMCOQTV+y0TU68gfc5j+poi2m4QpcF6frhBkSNs=; b=dl5NKEO+IXjQKdo0G
	gMnTRYiIE8jC/p12vIaQizC91ARDdCphf9T3YKYK0BES3XsL1dT4CelpsWBplcds
	QAVs6D/xZ1gu5bp92o0op5WuGrkvWP0akzUuNUOWDs3SofTh2vbq1vF+4ORlmdSt
	kMRHM9DL+ZAmmGNbTebFiZV3w7qmEKkEappaiDeez8fqaUg7R2FvWreJfDs7FV7C
	CWKb5JYdx7ukeKeSRHV6petiKyk4nwOh5vxcFO64wrck6itDrxFFKCAKcfqfGs/z
	nwG0BiHJMbCxGzl6/pqwalEGtwJKIVDaMLujkjXib3RbopnLpUzoPX+uThiqMU62
	7mjkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f52krbdt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:50:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:50:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:50:58 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5D08B3F708F;
	Wed,  1 Jul 2026 21:50:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 9/9] octeontx2: add TC flow offload path for switch flows
Date: Thu, 2 Jul 2026 10:20:26 +0530
Message-ID: <20260702045026.2914748-10-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702045026.2914748-1-rkannoth@marvell.com>
References: <20260702045026.2914748-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfX8YSF5ToQN8zS
 rJ8tV232UxkZd8UiLJQ70UoNCJDVwpaHrsuQ/Otdip+tV70l0QnM4Ply+g7EUvtVaGWYb42ca+N
 YSe2yPdrx/hlev5F2YNd10dSjyueZeQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfX9NfmEWeKWGjX
 4VdhzDdLGViyPhKb8WiGQF2uw2wH3mRu06NzIBeff2dGuRou8SZ916hNgs7YIlQEY7hF5c76u3a
 t/XFhk13LLIM3IXafpeJ3HR4tTfyMZtPwKNDaFaJEu2bgxkIiQDeTpDXzZaHKrDeoUMT0kpSiAr
 fR0Nw4UFt1RsbI5mVsW8mg1mK6RxeY8mxO+5PX3kArXB5/Hs60J3oLZm3K4ceZssuz8sxqKIocg
 5X9AzeQbf+VJrgts7mBUqpyX9oMZhLpQz+C2p2Qlo0kji7T1l7dVGtsDeAP1qDLn3p0sWOFtvcQ
 kh652X7GhEBp3cT3PmP8HNCedjbuqZ6W0I0vIZlJ70h17iZGsAFJs7yQY5gBmcgfWhIL57kG9ZJ
 rZwfMBh0h7HmVpZQdw2tZDxjmfixDCJY+6CYjBcdteS7W1PAeWD0w+oDKruBFJWB3cZCnL5Yf30
 FlGNd7Ay6ZiEvx6HfMg==
X-Proofpoint-GUID: qNOmeTwe6bYpmMUJBgv6lJjN2nLkffgb
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a45ee32 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=3qAIO7Ey0xqG5MIJW-MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qNOmeTwe6bYpmMUJBgv6lJjN2nLkffgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303978-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B58A86F37A3

Register an ingress flow-table offload callback that translates TC
flower rules into fl_tuple state, resolves ingress and egress
pcifunc via FIB for accelerated ports, and notifies the RVU AF over
the PF mailbox.  The AF forwards flow updates to switchdev and
keeps per-cookie packet counters in sync using NPC MCAM multi-stats
when the switch requests SWDEV2AF refresh.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   9 +-
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 305 ++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |   2 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 565 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      |   2 +
 .../marvell/octeontx2/nic/switch/sw_trace.c   |  13 +
 .../marvell/octeontx2/nic/switch/sw_trace.h   |  82 +++
 8 files changed, 977 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 6a2a3a03523d..f075da1507e7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -7,14 +7,14 @@
 
 #include <linux/bitfield.h>
 #include "rvu.h"
-#include "rvu_sw.h"
 #include "rvu_sw_l2.h"
 #include "rvu_sw_l3.h"
 #include "rvu_sw_fl.h"
+#include "rvu_sw.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
-	u32 port_id;
+	u16 port_id;
 	u16 rep_id;
 
 	rep_id  = rvu_rep_get_vlan_id(rvu, pcifunc);
@@ -39,6 +39,10 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
 		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
 		break;
+
+	case SWDEV2AF_MSG_TYPE_REFRESH_FL:
+		rc = rvu_sw_fl_stats_sync2db(rvu, req->fl, req->cnt);
+		break;
 	}
 
 	return rc;
@@ -48,4 +52,5 @@ void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
 	rvu_sw_l3_shutdown();
+	rvu_sw_fl_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
index 1f8b82a84a5d..6788cfc640c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -4,12 +4,257 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_fl.h"
+
+#define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
+static struct _req_type __maybe_unused					\
+*otx2_mbox_alloc_msg_ ## _fn_name(struct rvu *rvu, int devid)		\
+{									\
+	struct _req_type *req;						\
+									\
+	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
+		&rvu->afpf_wq_info.mbox_up, devid, sizeof(struct _req_type), \
+		sizeof(struct _rsp_type));				\
+	if (!req)							\
+		return NULL;						\
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
+	req->hdr.id = _id;						\
+	return req;							\
+}
+
+MBOX_UP_AF2SWDEV_MESSAGES
+#undef M
+
+static struct workqueue_struct *sw_fl_offl_wq;
+
+struct fl_entry {
+	struct list_head list;
+	struct rvu *rvu;
+	u32 port_id;
+	unsigned long cookie;
+	struct fl_tuple tuple;
+	u64 flags;
+	u64 features;
+};
+
+static DEFINE_MUTEX(fl_offl_llock);
+static LIST_HEAD(fl_offl_lh);
+static bool fl_offl_work_running;
+
+static struct workqueue_struct *sw_fl_offl_wq;
+static void sw_fl_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(fl_offl_work, sw_fl_offl_work_handler);
+
+struct sw_fl_stats_node {
+	struct list_head list;
+	unsigned long cookie;
+	u16 mcam_idx[2];
+	u64 opkts, npkts;
+	bool uni_di;
+};
+
+static LIST_HEAD(sw_fl_stats_lh);
+static DEFINE_MUTEX(sw_fl_stats_lock);
+
+static int
+rvu_sw_fl_stats_sync2db_one_entry(unsigned long cookie, u8 disabled,
+				  u16 mcam_idx[2], bool uni_di, u64 pkts)
+{
+	struct sw_fl_stats_node *snode, *tmp;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		if (snode->cookie != cookie)
+			continue;
+
+		if (disabled) {
+			list_del_init(&snode->list);
+			mutex_unlock(&sw_fl_stats_lock);
+			kfree(snode);
+			return 0;
+		}
+
+		if (snode->uni_di != uni_di) {
+			snode->uni_di = uni_di;
+			snode->mcam_idx[1] = mcam_idx[1];
+		}
+
+		if (snode->opkts == pkts) {
+			mutex_unlock(&sw_fl_stats_lock);
+			return 0;
+		}
+
+		snode->npkts = pkts;
+		mutex_unlock(&sw_fl_stats_lock);
+		return 0;
+	}
+
+	if (disabled) {
+		mutex_unlock(&sw_fl_stats_lock);
+		return 0;
+	}
+
+	snode = kcalloc(1, sizeof(*snode), GFP_KERNEL);
+	if (!snode) {
+		mutex_unlock(&sw_fl_stats_lock);
+		return -ENOMEM;
+	}
+
+	snode->cookie = cookie;
+	snode->mcam_idx[0] = mcam_idx[0];
+	if (!uni_di)
+		snode->mcam_idx[1] = mcam_idx[1];
+
+	snode->npkts = pkts;
+	snode->uni_di = uni_di;
+	INIT_LIST_HEAD(&snode->list);
+
+	list_add_tail(&snode->list, &sw_fl_stats_lh);
+	mutex_unlock(&sw_fl_stats_lock);
+
+	return 0;
+}
+
+int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt)
+{
+	struct npc_mcam_get_mul_stats_req *req = NULL;
+	struct npc_mcam_get_mul_stats_rsp *rsp = NULL;
+	int tot = 0;
+	u16 i2idx_map[256];
+	int rc = 0;
+	u64 pkts;
+	int idx;
+
+	if (cnt > 256)
+		return -ENOMEM;
+
+	for (int i = 0; i < cnt; i++) {
+		tot++;
+		if (fl[i].uni_di)
+			continue;
+
+		tot++;
+	}
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+	if (!req) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	rsp = kcalloc(1, sizeof(*rsp), GFP_KERNEL);
+	if (!rsp) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	req->cnt = tot;
+	idx = 0;
+	for (int i = 0; i < tot; idx++) {
+		i2idx_map[i] = idx;
+		req->entry[i++] = fl[idx].mcam_idx[0];
+		if (fl[idx].uni_di)
+			continue;
+
+		i2idx_map[i] = idx;
+		req->entry[i++] = fl[idx].mcam_idx[1];
+	}
+
+	if (rvu_mbox_handler_npc_mcam_mul_stats(rvu, req, rsp)) {
+		dev_err(rvu->dev, "Error to get multiple stats\n");
+		rc = -EFAULT;
+		goto fail;
+	}
+
+	for (int i = 0; i < tot;) {
+		idx = i2idx_map[i];
+		pkts =  rsp->stat[i++];
+
+		if (!fl[idx].uni_di)
+			pkts += rsp->stat[i++];
+
+		rc |= rvu_sw_fl_stats_sync2db_one_entry(fl[idx].cookie, fl[idx].dis,
+							fl[idx].mcam_idx,
+							fl[idx].uni_di, pkts);
+	}
+
+fail:
+	kfree(req);
+	kfree(rsp);
+	return rc;
+}
+
+static int rvu_sw_fl_offl_rule_push(struct fl_entry *fl_entry)
+{
+	struct af2swdev_notify_req *req;
+	struct rvu *rvu;
+	int swdev_pf;
+
+	rvu = fl_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	req->tuple = fl_entry->tuple;
+	req->flags = fl_entry->flags;
+	req->cookie = fl_entry->cookie;
+	req->features = fl_entry->features;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static void sw_fl_offl_work_handler(struct work_struct *work)
+{
+	struct fl_entry *fl_entry;
+
+	mutex_lock(&fl_offl_llock);
+	fl_entry = list_first_entry_or_null(&fl_offl_lh, struct fl_entry, list);
+	if (!fl_entry) {
+		mutex_unlock(&fl_offl_llock);
+		return;
+	}
+
+	list_del_init(&fl_entry->list);
+	mutex_unlock(&fl_offl_llock);
+
+	rvu_sw_fl_offl_rule_push(fl_entry);
+	kfree(fl_entry);
+
+	mutex_lock(&fl_offl_llock);
+	if (!list_empty(&fl_offl_lh))
+		queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to_jiffies(10));
+	mutex_unlock(&fl_offl_llock);
+}
 
 int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
 				  struct fl_get_stats_req *req,
 				  struct fl_get_stats_rsp *rsp)
 {
+	struct sw_fl_stats_node *snode, *tmp;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		if (snode->cookie != req->cookie)
+			continue;
+
+		rsp->pkts_diff = snode->npkts - snode->opkts;
+		snode->opkts = snode->npkts;
+		break;
+	}
+	mutex_unlock(&sw_fl_stats_lock);
 	return 0;
 }
 
@@ -17,5 +262,65 @@ int rvu_mbox_handler_fl_notify(struct rvu *rvu,
 			       struct fl_notify_req *req,
 			       struct msg_rsp *rsp)
 {
+	struct fl_entry *fl_entry;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return 0;
+
+	fl_entry = kcalloc(1, sizeof(*fl_entry), GFP_KERNEL);
+	if (!fl_entry)
+		return -ENOMEM;
+
+	fl_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	fl_entry->rvu = rvu;
+	INIT_LIST_HEAD(&fl_entry->list);
+	fl_entry->tuple = req->tuple;
+	fl_entry->cookie = req->cookie;
+	fl_entry->flags = req->flags;
+	fl_entry->features = req->features;
+
+	mutex_lock(&fl_offl_llock);
+	list_add_tail(&fl_entry->list, &fl_offl_lh);
+
+	if (!fl_offl_work_running) {
+		sw_fl_offl_wq = alloc_workqueue("sw_af_fl_wq", 0, 0);
+		if (sw_fl_offl_wq)
+			fl_offl_work_running = true;
+	}
+	mutex_unlock(&fl_offl_llock);
+	queue_delayed_work(sw_fl_offl_wq, &fl_offl_work, msecs_to_jiffies(10));
+
 	return 0;
 }
+
+void rvu_sw_fl_shutdown(void)
+{
+	struct sw_fl_stats_node *snode, *tmp;
+	struct fl_entry *entry;
+	LIST_HEAD(tlist);
+
+	if (!sw_fl_offl_wq)
+		return;
+
+	cancel_delayed_work_sync(&fl_offl_work);
+	destroy_workqueue(sw_fl_offl_wq);
+
+	mutex_lock(&fl_offl_llock);
+	while (1) {
+		entry = list_first_entry_or_null(&fl_offl_lh,
+						 struct fl_entry, list);
+		if (!entry)
+			break;
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	mutex_unlock(&fl_offl_llock);
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		list_del_init(&snode->list);
+		kfree(snode);
+	}
+	mutex_unlock(&sw_fl_stats_lock);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
index cf3e5b884f77..f117a96fc33e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
@@ -7,5 +7,7 @@
 
 #ifndef RVU_SW_FL_H
 #define RVU_SW_FL_H
+int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt);
+void rvu_sw_fl_shutdown(void);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 0e12659876e0..871a55ee3798 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o \
-	       switch/sw_fdb.o switch/sw_fl.o
+	       switch/sw_fdb.o switch/sw_fl.o switch/sw_trace.o
 
 ifdef CONFIG_OCTEONTX_SWITCH
 rvu_nicpf-y += switch/sw_nb.o switch/sw_fib.o \
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
index 36a2359a0a48..3cf4c40b1059 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -4,13 +4,578 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/nexthop.h>
+#include <net/netfilter/nf_flow_table.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_trace.h"
 #include "sw_fl.h"
 
+#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv)
+{
+	return -EOPNOTSUPP;
+}
+
+#else
+
+static DEFINE_SPINLOCK(sw_fl_lock);
+static LIST_HEAD(sw_fl_lh);
+
+struct sw_fl_list_entry {
+	struct list_head list;
+	u64 flags;
+	unsigned long cookie;
+	struct otx2_nic *pf;
+	struct fl_tuple tuple;
+};
+
+static struct workqueue_struct *sw_fl_wq;
+static struct work_struct sw_fl_work;
+
+static int sw_fl_msg_send(struct otx2_nic *pf,
+			  struct fl_tuple *tuple,
+			  u64 flags,
+			  unsigned long cookie)
+{
+	struct fl_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fl_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	req->tuple = *tuple;
+	req->flags = flags;
+	req->cookie = cookie;
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fl_wq_handler(struct work_struct *work)
+{
+	struct sw_fl_list_entry *entry;
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fl_lock);
+	list_splice_init(&sw_fl_lh, &tlist);
+	spin_unlock(&sw_fl_lock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fl_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fl_msg_send(entry->pf, &entry->tuple,
+			       entry->flags, entry->cookie);
+		dev_put(entry->pf->netdev);
+		kfree(entry);
+	}
+
+	spin_lock(&sw_fl_lock);
+	if (!list_empty(&sw_fl_lh))
+		queue_work(sw_fl_wq, &sw_fl_work);
+	spin_unlock(&sw_fl_lock);
+}
+
+static int
+sw_fl_add_to_list(struct otx2_nic *pf, struct fl_tuple *tuple,
+		  unsigned long cookie, bool add_fl)
+{
+	struct sw_fl_list_entry *entry;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->pf = pf;
+	entry->flags = add_fl ? FL_ADD : FL_DEL;
+	if (add_fl)
+		entry->tuple = *tuple;
+	entry->cookie = cookie;
+	entry->tuple.uni_di = netif_is_ovs_port(pf->netdev);
+
+	spin_lock(&sw_fl_lock);
+	dev_hold(pf->netdev);
+	list_add_tail(&entry->list, &sw_fl_lh);
+	queue_work(sw_fl_wq, &sw_fl_work);
+	spin_unlock(&sw_fl_lock);
+
+	return 0;
+}
+
+static int sw_fl_parse_actions(struct otx2_nic *nic,
+			       struct flow_action *flow_action,
+			       struct flow_cls_offload *f,
+			       struct fl_tuple *tuple, u64 *op)
+{
+	struct flow_action_entry *act;
+	struct otx2_nic *out_nic;
+	int err;
+	int used = 0;
+	int i;
+
+	if (!flow_action_has_entries(flow_action))
+		return -EINVAL;
+
+	flow_action_for_each(i, act, flow_action) {
+		if (used >= MANGLE_ARR_SZ) {
+			netdev_err(nic->netdev,
+				   "%s: More entries than supported %u\n",
+				   __func__, used);
+			return -ENOMEM;
+		}
+
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
+			tuple->in_pf = nic->pcifunc;
+			out_nic = netdev_priv(act->dev);
+			tuple->xmit_pf = out_nic->pcifunc;
+			*op |= BIT_ULL(FLOW_ACTION_REDIRECT);
+			break;
+
+		case FLOW_ACTION_CT:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
+			err = nf_flow_table_offload_add_cb(act->ct.flow_table,
+							   sw_fl_setup_ft_block_ingress_cb,
+							   nic);
+			if (err != -EEXIST && err) {
+				netdev_err(nic->netdev,
+					   "%s:%d Error to offload flow, err=%d\n",
+					   __func__, __LINE__, err);
+				break;
+			}
+
+			*op |= BIT_ULL(FLOW_ACTION_CT);
+			break;
+
+		case FLOW_ACTION_MANGLE:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
+			tuple->mangle[used].type = act->mangle.htype;
+			tuple->mangle[used].val = act->mangle.val;
+			tuple->mangle[used].mask = act->mangle.mask;
+			tuple->mangle[used].offset = act->mangle.offset;
+			tuple->mangle_map[act->mangle.htype] |= BIT(used);
+			used++;
+			break;
+
+		default:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
+			break;
+		}
+	}
+
+	tuple->mangle_cnt = used;
+
+	if (!*op) {
+		netdev_dbg(nic->netdev, "%s:%d Op is not valid\n", __func__, __LINE__);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int sw_fl_get_route(struct fib_result *res, __be32 addr)
+{
+	struct flowi4 fl4;
+
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.daddr = addr;
+	return fib_lookup(&init_net, &fl4, res, 0);
+}
+
+static int sw_fl_get_pcifunc(struct otx2_nic *pf, __be32 dst, u16 *pcifunc,
+			     struct fl_tuple *ftuple, bool is_in_dev)
+{
+	struct fib_nh_common *fib_nhc;
+	struct net_device *dev, *br;
+	struct fib_result res;
+	struct list_head *lh;
+	struct otx2_nic *nic;
+	int err;
+
+	rcu_read_lock();
+
+	err = sw_fl_get_route(&res, dst);
+	if (err) {
+		netdev_err(pf->netdev,
+			   "%s:%d Failed to find route to dst %pI4\n",
+			   __func__, __LINE__, &dst);
+		goto done;
+	}
+
+	if (res.fi->fib_type != RTN_UNICAST) {
+		netdev_err(pf->netdev,
+			   "%s:%d Not unicast  route to dst %pi4\n",
+			   __func__, __LINE__, &dst);
+		err = -EFAULT;
+		goto done;
+	}
+
+	fib_nhc = fib_info_nhc(res.fi, 0);
+	if (!fib_nhc) {
+		err = -EINVAL;
+		netdev_err(pf->netdev,
+			   "%s:%d Could not get fib_nhc for %pI4\n",
+			   __func__, __LINE__, &dst);
+		goto done;
+	}
+
+	if (unlikely(netif_is_bridge_master(fib_nhc->nhc_dev))) {
+		br = fib_nhc->nhc_dev;
+
+		if (is_in_dev)
+			ftuple->is_indev_br = 1;
+		else
+			ftuple->is_xdev_br = 1;
+
+		lh = &br->adj_list.lower;
+		if (list_empty(lh)) {
+			netdev_err(pf->netdev,
+				   "%s:%d Unable to find any slave device\n",
+				   __func__, __LINE__);
+			err = -EINVAL;
+			goto done;
+		}
+		dev = netdev_next_lower_dev_rcu(br, &lh);
+
+	} else {
+		dev = fib_nhc->nhc_dev;
+	}
+
+	if (!dev || !sw_nb_is_valid_dev(dev)) {
+		netdev_err(pf->netdev,
+			   "%s:%d flow acceleration support is only for cavium devices\n",
+			   __func__, __LINE__);
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
+	nic = netdev_priv(dev);
+	*pcifunc = nic->pcifunc;
+
+done:
+	rcu_read_unlock();
+	return err;
+}
+
+static int sw_fl_parse_flow(struct otx2_nic *nic, struct flow_cls_offload *f,
+			    struct fl_tuple *tuple, u64 *features)
+{
+	struct flow_rule *rule;
+	u8 ip_proto = 0;
+
+	*features = 0;
+
+	rule = flow_cls_offload_flow_rule(f);
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+
+		/* All EtherTypes can be matched, no hw limitation */
+
+		if (match.mask->n_proto) {
+			tuple->eth_type = match.key->n_proto;
+			tuple->m_eth_type = match.mask->n_proto;
+			*features |= BIT_ULL(NPC_ETYPE);
+		}
+
+		if (match.mask->ip_proto &&
+		    (match.key->ip_proto != IPPROTO_TCP &&
+		     match.key->ip_proto != IPPROTO_UDP)) {
+			netdev_dbg(nic->netdev,
+				   "ip_proto=%u not supported\n",
+				   match.key->ip_proto);
+		}
+
+		if (match.mask->ip_proto)
+			ip_proto = match.key->ip_proto;
+
+		if (ip_proto == IPPROTO_UDP) {
+			*features |= BIT_ULL(NPC_IPPROTO_UDP);
+		} else if (ip_proto == IPPROTO_TCP) {
+			*features |= BIT_ULL(NPC_IPPROTO_TCP);
+		} else {
+			netdev_dbg(nic->netdev,
+				   "ip_proto=%u not supported\n",
+				   match.key->ip_proto);
+		}
+
+		tuple->proto = ip_proto;
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_match_eth_addrs match;
+
+		flow_rule_match_eth_addrs(rule, &match);
+
+		if (!is_zero_ether_addr(match.key->dst) &&
+		    is_unicast_ether_addr(match.key->dst)) {
+			ether_addr_copy(tuple->dmac,
+					match.key->dst);
+
+			ether_addr_copy(tuple->m_dmac,
+					match.mask->dst);
+
+			*features |= BIT_ULL(NPC_DMAC);
+		}
+
+		if (!is_zero_ether_addr(match.key->src) &&
+		    is_unicast_ether_addr(match.key->src)) {
+			ether_addr_copy(tuple->smac,
+					match.key->src);
+			ether_addr_copy(tuple->m_smac,
+					match.mask->src);
+			*features |= BIT_ULL(NPC_SMAC);
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs match;
+
+		flow_rule_match_ipv4_addrs(rule, &match);
+
+		if (match.key->dst) {
+			tuple->ip4dst = match.key->dst;
+			tuple->m_ip4dst = match.mask->dst;
+			*features |= BIT_ULL(NPC_DIP_IPV4);
+		}
+
+		if (match.key->src) {
+			tuple->ip4src = match.key->src;
+			tuple->m_ip4src = match.mask->src;
+			*features |= BIT_ULL(NPC_SIP_IPV4);
+		}
+	}
+
+	if (!(*features & BIT_ULL(NPC_DMAC))) {
+		if (!tuple->ip4src || !tuple->ip4dst) {
+			netdev_err(nic->netdev,
+				   "%s:%d Invalid src=%pI4 and dst=%pI4 addresses\n",
+				   __func__, __LINE__, &tuple->ip4src, &tuple->ip4dst);
+			return -EINVAL;
+		}
+
+		if ((tuple->ip4src & tuple->m_ip4src) == (tuple->ip4dst & tuple->m_ip4dst)) {
+			netdev_err(nic->netdev,
+				   "%s:%d Masked values are same; Invalid src=%pI4 and dst=%pI4 addresses\n",
+				   __func__, __LINE__, &tuple->ip4src, &tuple->ip4dst);
+			return -EINVAL;
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		flow_rule_match_ports(rule, &match);
+
+		if (ip_proto == IPPROTO_UDP) {
+			if (match.key->dst)
+				*features |= BIT_ULL(NPC_DPORT_UDP);
+
+			if (match.key->src)
+				*features |= BIT_ULL(NPC_SPORT_UDP);
+		} else if (ip_proto == IPPROTO_TCP) {
+			if (match.key->dst)
+				*features |= BIT_ULL(NPC_DPORT_TCP);
+
+			if (match.key->src)
+				*features |= BIT_ULL(NPC_SPORT_TCP);
+		}
+
+		if (match.mask->src) {
+			tuple->sport = match.key->src;
+			tuple->m_sport = match.mask->src;
+		}
+
+		if (match.mask->dst) {
+			tuple->dport = match.key->dst;
+			tuple->m_dport = match.mask->dst;
+		}
+	}
+
+	if (!(*features & (BIT_ULL(NPC_DMAC) |
+			   BIT_ULL(NPC_SMAC) |
+			   BIT_ULL(NPC_DIP_IPV4) |
+			   BIT_ULL(NPC_SIP_IPV4) |
+			   BIT_ULL(NPC_DIP_IPV6) |
+			   BIT_ULL(NPC_SIP_IPV6) |
+			   BIT_ULL(NPC_DPORT_UDP) |
+			   BIT_ULL(NPC_SPORT_UDP) |
+			   BIT_ULL(NPC_DPORT_TCP) |
+			   BIT_ULL(NPC_SPORT_TCP)))) {
+		return -EINVAL;
+	}
+
+	tuple->features = *features;
+
+	return 0;
+}
+
+static int sw_fl_add(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	struct fl_tuple tuple = { 0 };
+	struct flow_rule *rule;
+	u64 features = 0;
+	u64 op = 0;
+	int rc;
+
+	rule = flow_cls_offload_flow_rule(f);
+
+	rc = sw_fl_parse_actions(nic, &rule->action, f, &tuple, &op);
+	if (rc)
+		return rc;
+
+	if (op & BIT_ULL(FLOW_ACTION_CT))
+		return 0;
+
+	rc  = sw_fl_parse_flow(nic, f, &tuple, &features);
+	if (rc) {
+		trace_sw_fl_dump(__func__, __LINE__, &tuple);
+		return -EFAULT;
+	}
+
+	if (!netif_is_ovs_port(nic->netdev)) {
+		rc = sw_fl_get_pcifunc(nic, tuple.ip4src, &tuple.in_pf,
+				       &tuple, true);
+		if (rc) {
+			trace_sw_fl_dump(__func__, __LINE__, &tuple);
+			return rc;
+		}
+
+		rc = sw_fl_get_pcifunc(nic, tuple.ip4dst,
+				       &tuple.xmit_pf, &tuple, false);
+		if (rc) {
+			trace_sw_fl_dump(__func__, __LINE__, &tuple);
+			return rc;
+		}
+	}
+
+	trace_sw_fl_dump(__func__, __LINE__, &tuple);
+	sw_fl_add_to_list(nic, &tuple, f->cookie, true);
+	return 0;
+}
+
+static int sw_fl_del(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	sw_fl_add_to_list(nic, NULL, f->cookie, false);
+	return 0;
+}
+
+static int sw_fl_stats(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	struct fl_get_stats_req *req;
+	struct fl_get_stats_rsp *rsp;
+	u64 pkts_diff;
+	int rc = 0;
+
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_fl_get_stats(&nic->mbox);
+	if (!req) {
+		netdev_err(nic->netdev,
+			   "%s:%d Error happened while mcam alloc req\n",
+			   __func__, __LINE__);
+		rc = -ENOMEM;
+		goto fail;
+	}
+	req->cookie = f->cookie;
+
+	rc = otx2_sync_mbox_msg(&nic->mbox);
+	if (rc)
+		goto fail;
+
+	rsp = (struct fl_get_stats_rsp *)otx2_mbox_get_rsp
+		(&nic->mbox.mbox, 0, &req->hdr);
+	pkts_diff = rsp->pkts_diff;
+	mutex_unlock(&nic->mbox.lock);
+
+	if (pkts_diff) {
+		flow_stats_update(&f->stats, 0x0, pkts_diff,
+				  0x0, jiffies,
+				  FLOW_ACTION_HW_STATS_IMMEDIATE);
+	}
+	return 0;
+fail:
+	mutex_unlock(&nic->mbox.lock);
+	return rc;
+}
+
+static bool init_done;
+
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv)
+{
+	struct flow_cls_offload *cls = type_data;
+	struct otx2_nic *nic = cb_priv;
+
+	if (!init_done)
+		return 0;
+
+	switch (cls->command) {
+	case FLOW_CLS_REPLACE:
+		return sw_fl_add(nic, cls);
+	case FLOW_CLS_DESTROY:
+		return sw_fl_del(nic, cls);
+	case FLOW_CLS_STATS:
+		return sw_fl_stats(nic, cls);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int sw_fl_init(void)
 {
+	INIT_WORK(&sw_fl_work, sw_fl_wq_handler);
+	sw_fl_wq = alloc_workqueue("sw_fl_wq", 0, 0);
+	if (!sw_fl_wq)
+		return -ENOMEM;
+
+	init_done = true;
 	return 0;
 }
 
 void sw_fl_deinit(void)
 {
+	struct sw_fl_list_entry *entry;
+	LIST_HEAD(tlist);
+
+	cancel_work_sync(&sw_fl_work);
+	destroy_workqueue(sw_fl_wq);
+
+	spin_lock(&sw_fl_lock);
+	list_splice_init(&sw_fl_lh, &tlist);
+	spin_unlock(&sw_fl_lock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fl_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		dev_put(entry->pf->netdev);
+		kfree(entry);
+	}
 }
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
index cd018d770a8a..8dd816eb17d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -9,5 +9,7 @@
 
 void sw_fl_deinit(void);
 int sw_fl_init(void);
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv);
 
 #endif // SW_FL_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
new file mode 100644
index 000000000000..b01e7780ef12
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#define CREATE_TRACE_POINTS
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+#include "sw_trace.h"
+EXPORT_TRACEPOINT_SYMBOL(sw_fl_dump);
+EXPORT_TRACEPOINT_SYMBOL(sw_act_dump);
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
new file mode 100644
index 000000000000..5949e3dafaed
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rvu
+
+#if !defined(SW_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define SW_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+#include "mbox.h"
+
+TRACE_EVENT(sw_fl_dump,
+	    TP_PROTO(const char *fname, int line, struct fl_tuple *ftuple),
+	    TP_ARGS(fname, line, ftuple),
+	    TP_STRUCT__entry(__string(f, fname)
+			     __field(int, l)
+			     __array(u8, smac, ETH_ALEN)
+			     __array(u8, dmac, ETH_ALEN)
+			     __field(u16, eth_type)
+			     __field(u32, sip)
+			     __field(u32, dip)
+			     __field(u8, ip_proto)
+			     __field(u16, sport)
+			     __field(u16, dport)
+			     __field(u8, uni_di)
+			     __field(u16, in_pf)
+			     __field(u16, out_pf)
+	    ),
+	    TP_fast_assign(__assign_str(f);
+			   __entry->l = line;
+			   memcpy(__entry->smac, ftuple->smac, ETH_ALEN);
+			   memcpy(__entry->dmac, ftuple->dmac, ETH_ALEN);
+			   __entry->sip = (__force u32)(ftuple->ip4src);
+			   __entry->dip = (__force u32)(ftuple->ip4dst);
+			   __entry->eth_type = (__force u16)ftuple->eth_type;
+			   __entry->ip_proto = ftuple->proto;
+			   __entry->sport = (__force u16)(ftuple->sport);
+			   __entry->dport = (__force u16)(ftuple->dport);
+			   __entry->uni_di = ftuple->uni_di;
+			   __entry->in_pf = ftuple->in_pf;
+			   __entry->out_pf = ftuple->xmit_pf;
+	    ),
+	    TP_printk("[%s:%d] %pM %pI4:%u to %pM %pI4:%u eth_type=%#x proto=%u uni=%u in=%#x out=%#x",
+		      __get_str(f), __entry->l, __entry->smac, &__entry->sip, __entry->sport,
+		      __entry->dmac, &__entry->dip, __entry->dport,
+		      ntohs((__force __be16)__entry->eth_type), __entry->ip_proto, __entry->uni_di,
+		      __entry->in_pf, __entry->out_pf)
+);
+
+TRACE_EVENT(sw_act_dump,
+	    TP_PROTO(const char *fname, int line, u32 act),
+	    TP_ARGS(fname, line, act),
+	    TP_STRUCT__entry(__string(fname, fname)
+			     __field(int, line)
+			     __field(u32, act)
+	    ),
+
+	    TP_fast_assign(__assign_str(fname);
+			   __entry->line = line;
+			   __entry->act = act;
+	    ),
+
+	    TP_printk("[%s:%d] %u",
+		      __get_str(fname), __entry->line, __entry->act)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/net/ethernet/marvell/octeontx2/nic/switch/
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE sw_trace
+
+#include <trace/define_trace.h>
-- 
2.43.0


