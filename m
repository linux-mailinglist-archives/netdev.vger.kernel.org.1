Return-Path: <netdev+bounces-307314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id axDZLf2WVWojqgAAu9opvQ
	(envelope-from <netdev+bounces-307314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:55:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27B750337
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:55:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=GUidfA0d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307314-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC3930315C9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18505378D7D;
	Tue, 14 Jul 2026 01:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AD372B45;
	Tue, 14 Jul 2026 01:54:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994060; cv=none; b=hE6Pa7+iiKct7G4J53LO+K5c2H7Nhft7wi0eDinlGPYVoM6ySJj7W6y7X370HOwTCyoy3jFoMN4JBNKGI7TvhVTBd8uNJ09+zY6Nabc3D3l6Q7n1+EHtCZCxUGGDK1zmd8Dxv5QatI+DbkPULf7E9/G4nsiT25v7cenQ1kneuQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994060; c=relaxed/simple;
	bh=OEQ0tUMBYdXKd912Um8vSyV0b2WWq9GJQkDcg5dqWXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5pQ48cQRSw5OdpXTf/7hyoeKp6A/54hp8+WVN2CvoRt9XJxo3IaywBSLcVnZJpPzSh57WAJSruxEeGPjSYqs/XE7w9BeKYhoOxq9rtQgWXMN0z1Z+CgOT/8kYaPt0mVapupMZwa+cVK4Sv6fEEgV3i7/5bOgOYoBV2BkchbxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GUidfA0d; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnDqg2948220;
	Mon, 13 Jul 2026 18:54:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	eIidrvyXk99L7MZONzuy+T2RntMGuev4+mSkMzUX1s=; b=GUidfA0deeyI741nH
	K21/KNUthKbY6cxjcIxFAAv4OIa+/QHXpANVZMwqvDNTH0p9GYZqADVtq1v4UWom
	qJky4LGPdl+/aARSRITOgC0EJXOL3hDcKdw5tGaZMUiCdtNhGNlJ+yjkXQ7/rs6F
	hlmqQ6he4I/9zXPfuviIidrsYt4dM2kNtjvTsNDPzmAoppOT4y4I0JRxN5GxvTCJ
	juc9+f1wBBNh8Dmpyqj/HbrYekjkBWteY13ze5wMA9y+S4oyBA+Jkvq9meZ9yPqy
	Lw3weUKdj57NbRtH/ppab7RGCV3lq7HZI6wxRcGEmuu5nXKA0vjwTPrRLZ4ueGm3
	PB/Mg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fbnbex55k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:54:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 18:54:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 18:54:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CA5745E6867;
	Mon, 13 Jul 2026 18:54:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 8/9] octeontx2: switch: offload host FIB updates to switch via AF mailbox
Date: Tue, 14 Jul 2026 07:23:30 +0530
Message-ID: <20260714015331.1801922-9-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714015331.1801922-1-rkannoth@marvell.com>
References: <20260714015331.1801922-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TXbTwOOwXjUKoaqks7qyMgOCNZa2lu8d
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a5596c1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=y2oaCZTtkRP9fqhs6UgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: TXbTwOOwXjUKoaqks7qyMgOCNZa2lu8d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX+8JYY76eZ8Na
 qKKOne98EEyPAh1xzPzbsRoppkNhV5UYgX0/fTIJR9D7NGF3PevNCuKohokjXAcVIDrN4YgahBM
 6unZnF948thp1NbHrl4Q7i+Lsc2Cq4U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX/zIte87ggG/6
 U4IgyWt9PTGd4VRKTWXMrXqLbeJhEFTLKZUuHEA4ODxVDeUg7wbR/5q9/XyjobCPFrw2NEtZ0Ij
 Phb7mmj3Duh/ngR4SI2FEDO6H0YKWi4LXl/swA1TD3nxdUvEOS+aa6jyNGU/l1Bdg1QIvmrsxV1
 ww3+GO7d3Q4Wf3ZRZu9dgRKkljdsQ2y3wTSd88D/wUwOBx5StcTryTjI7jD1O0XjXcTEyFw4RQC
 2vTdQ+IjGjkt7+lXYAHtoE4RYLZLUCSvHQmTY0ia5DaBQcnBUaN6xDYhCYkDbw/NMb8igWVGXHp
 6cBeNvbc0yJZ5sOWaJi7Hv7F7eCgFLmpHMcsP2UW6jY1DRbYrDK0T20HyRlnrzKNcCzvyF8dTH2
 dVqScE2wE+7Fo3UsJthQFSOwh8l5YpmURuKPrxQ6jWbTS/SOwExcbE5UcdUTygtTU79qwO5Qqsm
 P4SZTxrqgjRZWZdR/UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-307314-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B27B750337

Queue IPv4/IPv6 FIB-derived updates from the switch notifier path
and handle fib_notify in the RVU AF by batching fib_entry
structures and sending them to the switch PF through the
AF-to-switchdev FIB_CMD. Require the switch firmware to
be ready before accepting offload work.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  22 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 245 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |   1 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 189 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |  10 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |  11 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 141 +++++-----
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   |  15 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  31 ++-
 9 files changed, 574 insertions(+), 91 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index b9cd7c7524b9..6c70d1d727c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -6,26 +6,23 @@
  */
 
 #include <linux/bitfield.h>
-
 #include "rvu.h"
 #include "rvu_sw.h"
 #include "rvu_sw_l2.h"
+#include "rvu_sw_l3.h"
 #include "rvu_sw_fl.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
+	u32 port_id;
 	u16 rep_id;
 
-	if (!rvu->rep2pfvf_map || !rvu->rep_cnt)
-		return RVU_SW_INVALID_PORT_ID;
+	rep_id  = rvu_rep_get_vlan_id(rvu, pcifunc);
 
-	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
-	if (rep_id >= rvu->rep_cnt ||
-	    rvu->rep2pfvf_map[rep_id] != pcifunc)
-		return RVU_SW_INVALID_PORT_ID;
+	port_id = FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+		  FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
 
-	return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
-	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+	return port_id;
 }
 
 static bool rvu_sw_swdev2af_msg_valid(u64 msg_type)
@@ -54,7 +51,7 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
 				     struct msg_rsp *rsp)
 {
-	int rc;
+	int rc = 0;
 
 	rc = rvu_sw_swdev2af_sender_check(rvu, req, req->msg_type);
 	if (rc)
@@ -68,10 +65,6 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
 		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
 		break;
-
-	default:
-		rc = -EOPNOTSUPP;
-		break;
 	}
 
 	return rc;
@@ -80,4 +73,5 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
+	rvu_sw_l3_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
index 2b798d5f0644..b9ba5ea1aaef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,256 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_l3.h"
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
+#define RVU_SW_L3_BATCH_MAX						\
+	((int)(sizeof_field(struct af2swdev_notify_req, entry) /	\
+	       sizeof(struct fib_entry)))
+
+struct l3_entry {
+	struct list_head list;
+	/* Always this AF driver's rvu; stored for clarity only (single RVU). */
+	struct rvu *rvu;
+	u32 port_id;
+	int cnt;
+	struct fib_entry entry[];
+};
+
+static DEFINE_MUTEX(l3_offl_llock);
+/*
+ * Pending FIB updates from host PFs on this RVU. The list is per-AF-module
+ * (one octeontx2-af instance / one RVU chip), not shared across RVU devices.
+ */
+static LIST_HEAD(l3_offl_lh);
+
+static struct workqueue_struct *sw_l3_offl_wq;
+static void sw_l3_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(l3_offl_work, sw_l3_offl_work_handler);
+
+/*
+ * FIB offload to the switch ASIC: one octeontx2 AF driver instance, one
+ * switch PF (switchdev), and one sw_l3_offl_wq per SoC.
+ */
+
+static void rvu_sw_l3_drain_list(struct list_head *lh)
+{
+	struct l3_entry *entry;
+
+	while ((entry = list_first_entry_or_null(lh, struct l3_entry, list))) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static void rvu_sw_l3_queue_work(void)
+{
+	if (sw_l3_offl_wq)
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(10));
+}
+
+static int rvu_sw_l3_ensure_wq(void)
+{
+	if (sw_l3_offl_wq)
+		return 0;
+
+	sw_l3_offl_wq = alloc_workqueue("sw_af_fib_wq", 0, 0);
+	if (!sw_l3_offl_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int rvu_sw_l3_offl_rule_push(struct list_head *lh)
+{
+	struct af2swdev_notify_req *req;
+	struct fib_entry *entry, *dst;
+	struct l3_entry *l3_entry;
+	struct rvu *rvu;
+	int tot_cnt = 0;
+	int swdev_pf;
+	int sz, cnt, i;
+	bool rc;
+
+	BUILD_BUG_ON(sizeof_field(struct af2swdev_notify_req, entry) !=
+		     sizeof(struct fib_entry) * RVU_SW_L3_BATCH_MAX);
+
+	l3_entry = list_first_entry_or_null(lh, struct l3_entry, list);
+	if (!l3_entry)
+		return 0;
+
+	/*
+	 * Octeontx2 has a single AF (one struct rvu) per RVU chip. All queued
+	 * entries therefore share the same rvu and the same switch PF below.
+	 * Host PF identity is carried per fib_entry (port_id), not by picking
+	 * a different switch PF here.
+	 */
+	rvu = l3_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	dst = &req->entry[0];
+	/*
+	 * Batch fib_entry records from multiple host PF notifies into one
+	 * af2swdev message. Safe on octeontx2: every l3_entry targets the
+	 * same switch PF; egress port is encoded in each fib_entry.port_id.
+	 */
+	while ((l3_entry =
+		list_first_entry_or_null(lh,
+					 struct l3_entry, list)) != NULL) {
+		entry = l3_entry->entry;
+		cnt = l3_entry->cnt;
+
+		/* af2swdev_notify_req.entry[] holds RVU_SW_L3_BATCH_MAX slots;
+		 * stop before copying the next l3_entry when the mbox buffer
+		 * would overflow. Leftovers stay on lh and are re-queued.
+		 */
+		if (tot_cnt + cnt > RVU_SW_L3_BATCH_MAX)
+			break;
+
+		sz = sizeof(*entry) * cnt;
+
+		memcpy(dst, entry, sz);
+		for (i = 0; i < cnt; i++)
+			dst[i].port_id = l3_entry->port_id;
+		tot_cnt += cnt;
+		dst += cnt;
+
+		list_del_init(&l3_entry->list);
+		kfree(l3_entry);
+	}
+	if (!tot_cnt) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -EINVAL;
+	}
+
+	req->flags = FIB_CMD;
+	req->cnt = tot_cnt;
+
+	rc = otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	if (rc)
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return rc ? 0 : -EFAULT;
+}
+
+static void sw_l3_offl_work_handler(struct work_struct *work)
+{
+	struct list_head l3lh;
+
+	INIT_LIST_HEAD(&l3lh);
+
+	mutex_lock(&l3_offl_llock);
+	if (list_empty(&l3_offl_lh)) {
+		mutex_unlock(&l3_offl_llock);
+		return;
+	}
+	list_splice_init(&l3_offl_lh, &l3lh);
+	mutex_unlock(&l3_offl_llock);
+
+	if (rvu_sw_l3_offl_rule_push(&l3lh))
+		pr_err("%s: Error to push rules\n", __func__);
+
+	/* rvu_sw_l3_offl_rule_push() may leave entries when a batch is full. */
+	if (!list_empty(&l3lh)) {
+		mutex_lock(&l3_offl_llock);
+		list_splice_tail(&l3lh, &l3_offl_lh);
+		mutex_unlock(&l3_offl_llock);
+		if (sw_l3_offl_wq)
+			queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+					   msecs_to_jiffies(100));
+		return;
+	}
+
+	mutex_lock(&l3_offl_llock);
+	if (!list_empty(&l3_offl_lh))
+		rvu_sw_l3_queue_work();
+	mutex_unlock(&l3_offl_llock);
+}
 
 int rvu_mbox_handler_fib_notify(struct rvu *rvu,
 				struct fib_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct l3_entry *l3_entry;
+	int sz, rc;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return -EAGAIN;
+
+	/* Reject single notifies larger than af2swdev_notify_req.entry[]. */
+	if (!req->cnt || req->cnt > RVU_SW_L3_BATCH_MAX)
+		return -EINVAL;
+
+	sz = req->cnt * sizeof(struct fib_entry);
+
+	l3_entry = kcalloc(1, sizeof(*l3_entry) + sz, GFP_KERNEL);
+	if (!l3_entry)
+		return -ENOMEM;
+
+	l3_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	l3_entry->rvu = rvu;
+	l3_entry->cnt = req->cnt;
+	INIT_LIST_HEAD(&l3_entry->list);
+	memcpy(l3_entry->entry, req->entry, sz);
+
+	/* Host PFs on this RVU share one AF and one switch PF offload path. */
+	mutex_lock(&l3_offl_llock);
+	rc = rvu_sw_l3_ensure_wq();
+	if (rc) {
+		mutex_unlock(&l3_offl_llock);
+		kfree(l3_entry);
+		return rc;
+	}
+
+	list_add_tail(&l3_entry->list, &l3_offl_lh);
+	if (sw_l3_offl_wq)
+		rvu_sw_l3_queue_work();
+	mutex_unlock(&l3_offl_llock);
+
 	return 0;
 }
+
+void rvu_sw_l3_shutdown(void)
+{
+	if (!sw_l3_offl_wq)
+		return;
+
+	cancel_delayed_work_sync(&l3_offl_work);
+	destroy_workqueue(sw_l3_offl_wq);
+	sw_l3_offl_wq = NULL;
+
+	mutex_lock(&l3_offl_llock);
+	rvu_sw_l3_drain_list(&l3_offl_lh);
+	mutex_unlock(&l3_offl_llock);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
index ac8c4f9ba5ac..153f1415466d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
@@ -8,4 +8,5 @@
 #ifndef RVU_SW_L3_H
 #define RVU_SW_L3_H
 
+void rvu_sw_l3_shutdown(void);
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
index 12ddf8119372..1c1f23d5d136 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -4,13 +4,202 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
 #include "sw_fib.h"
 
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+#define SW_FIB_BATCH_MAX 16
+
+/*
+ * One switch PF registers notifiers via sw_nb_register(); a second call
+ * returns -EBUSY. A single sw_fib_wq therefore serves the one switchdev
+ * instance on octeontx2, matching the FDB offload path.
+ */
+static DEFINE_SPINLOCK(sw_fib_llock);
+static LIST_HEAD(sw_fib_lh);
+
+static struct workqueue_struct *sw_fib_wq;
+static void sw_fib_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(sw_fib_work, sw_fib_work_handler);
+
+struct sw_fib_list_entry {
+	struct list_head lh;
+	struct otx2_nic *pf;
+	netdevice_tracker dev_tracker;
+	int cnt;
+	struct fib_entry *entry;
+};
+
+static int sw_fib_notify(struct otx2_nic *pf,
+			 int cnt,
+			 struct fib_entry *entry)
+{
+	struct fib_notify_req *req;
+	int rc;
+
+	if (cnt > SW_FIB_BATCH_MAX)
+		return -EINVAL;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fib_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	req->cnt = cnt;
+	memcpy(req->entry, entry, sizeof(*entry) * cnt);
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fib_work_handler(struct work_struct *work)
+{
+	struct sw_fib_list_entry *lentry;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock_bh(&sw_fib_llock);
+
+	while ((lentry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fib_list_entry, lh)) != NULL) {
+		list_del_init(&lentry->lh);
+		if (sw_fib_notify(lentry->pf, lentry->cnt, lentry->entry)) {
+			netdev_err(lentry->pf->netdev,
+				   "Failed to notify FIB update to AF, will retry\n");
+			spin_lock_bh(&sw_fib_llock);
+			if (sw_fib_wq) {
+				list_add_tail(&lentry->lh, &sw_fib_lh);
+				queue_delayed_work(sw_fib_wq, &sw_fib_work,
+						   msecs_to_jiffies(100));
+				spin_unlock_bh(&sw_fib_llock);
+				continue;
+			}
+			spin_unlock_bh(&sw_fib_llock);
+			netdev_put(lentry->pf->netdev, &lentry->dev_tracker);
+			kfree(lentry->entry);
+			kfree(lentry);
+			continue;
+		}
+		netdev_put(lentry->pf->netdev, &lentry->dev_tracker);
+		kfree(lentry->entry);
+		kfree(lentry);
+	}
+
+	spin_lock_bh(&sw_fib_llock);
+	if (!list_empty(&sw_fib_lh) && sw_fib_wq)
+		queue_delayed_work(sw_fib_wq, &sw_fib_work,
+				   msecs_to_jiffies(10));
+	spin_unlock_bh(&sw_fib_llock);
+}
+
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fib_list_entry *lentry;
+	struct workqueue_struct *wq;
+
+	if (cnt <= 0 || cnt > SW_FIB_BATCH_MAX) {
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	spin_lock_bh(&sw_fib_llock);
+	if (!sw_fib_wq) {
+		spin_unlock_bh(&sw_fib_llock);
+		kfree(entry);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&sw_fib_llock);
+
+	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);
+	if (!lentry) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+
+	lentry->pf = pf;
+	lentry->cnt = cnt;
+	lentry->entry = entry;
+	INIT_LIST_HEAD(&lentry->lh);
+	netdev_hold(dev, &lentry->dev_tracker, GFP_ATOMIC);
+
+	spin_lock_bh(&sw_fib_llock);
+	wq = sw_fib_wq;
+	if (wq) {
+		list_add_tail(&lentry->lh, &sw_fib_lh);
+		queue_delayed_work(wq, &sw_fib_work,
+				   msecs_to_jiffies(10));
+	}
+	spin_unlock_bh(&sw_fib_llock);
+
+	if (!wq) {
+		netdev_put(dev, &lentry->dev_tracker);
+		kfree(lentry);
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int sw_fib_init(void)
 {
+	sw_fib_wq = alloc_workqueue("sw_pf_fib_wq", 0, 0);
+	if (!sw_fib_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void sw_fib_deinit(void)
 {
+	struct sw_fib_list_entry *lentry;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fib_llock);
+	wq = sw_fib_wq;
+	sw_fib_wq = NULL;
+	spin_unlock_bh(&sw_fib_llock);
+
+	if (!wq)
+		return;
+
+	cancel_delayed_work_sync(&sw_fib_work);
+	destroy_workqueue(wq);
+
+	spin_lock_bh(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock_bh(&sw_fib_llock);
+
+	while ((lentry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fib_list_entry, lh)) != NULL) {
+		list_del_init(&lentry->lh);
+		netdev_put(lentry->pf->netdev, &lentry->dev_tracker);
+		kfree(lentry->entry);
+		kfree(lentry);
+	}
 }
+
+#endif /* CONFIG_OCTEONTX_SWITCH */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
index 9b72e95f2dd3..2e0e7a80c40c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -9,10 +9,20 @@
 
 #include <linux/kconfig.h>
 
+struct fib_entry;
+struct net_device;
+
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt);
 void sw_fib_deinit(void);
 int sw_fib_init(void);
 #else
+static inline int sw_fib_add_to_list(struct net_device *dev,
+				     struct fib_entry *entry, int cnt)
+{
+	return 0;
+}
 static inline void sw_fib_deinit(void) {}
 static inline int sw_fib_init(void) { return 0; }
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 8aa357e9db21..971af268ae93 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -140,6 +140,7 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	int rc = 0;
 
 	if (!sw_nb_is_valid_dev(dev))
 		return NOTIFY_DONE;
@@ -148,19 +149,22 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
-		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, true);
+		rc = sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, true);
 		break;
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
-		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, false);
+		rc = sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, false);
 		break;
 
 	default:
 		return NOTIFY_DONE;
 	}
 
+	if (rc)
+		netdev_err(dev, "%s: Error to add to list\n", __func__);
+
 	return NOTIFY_DONE;
 }
 
@@ -329,8 +333,8 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
 	if (idev)
 		sw_nb_v4_netdev_event(unused, event, ptr);
 
-#if IS_ENABLED(CONFIG_IPV6)
 	i6dev = __in6_dev_get(dev);
+#if IS_ENABLED(CONFIG_IPV6)
 	if (i6dev)
 		sw_nb_v6_netdev_event(unused, event, ptr);
 #endif
@@ -407,6 +411,7 @@ int sw_nb_register(struct net_device *netdev)
 {
 	int err;
 
+	/* One switch PF / switchdev instance registers system-wide notifiers. */
 	if (sw_nb_registered)
 		return -EBUSY;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
index 0e7006e507fd..c1e50bb0fbd3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -38,6 +38,9 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 	if (!idev || !idev->ifa_list)
 		return NOTIFY_DONE;
 
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
 	ifa = rtnl_dereference(idev->ifa_list);
 
 	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
@@ -73,7 +76,7 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %pI4, %pM, dev=%s\n",
 		   __func__, &entry->dst, entry->mac, dev->name);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 
 	return NOTIFY_DONE;
 }
@@ -136,7 +139,7 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %pI4, %pM, %s\n",
 		   __func__, &entry->dst, entry->mac, dev->name);
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
@@ -144,16 +147,18 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		       unsigned long event, void *ptr)
 {
 	struct fib_entry_notifier_info *fen_info = ptr;
-	struct net_device *dev, *pf_dev = NULL;
-	struct fib_entry *entries, *iter;
+	struct net_device *host_pf_dev = NULL;
 	struct netdev_hw_addr *dev_addr;
+	struct net_device *nh_pf_dev;
 	struct neighbour *neigh;
+	struct fib_entry *entry;
+	struct net_device *dev;
 	struct fib_nh *fib_nh;
 	struct fib_info *fi;
 	struct otx2_nic *pf;
 	__be32 *haddr;
 	int hcnt = 0;
-	int cnt, i;
+	int i, cnt;
 
 	/* Process only UNICAST routes add or del */
 	if (fen_info->type != RTN_UNICAST)
@@ -173,17 +178,10 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	}
 
-	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
-	if (!entries)
-		return NOTIFY_DONE;
-
 	haddr = kcalloc(fi->fib_nhs, sizeof(*haddr), GFP_ATOMIC);
-	if (!haddr) {
-		kfree(entries);
+	if (!haddr)
 		return NOTIFY_DONE;
-	}
 
-	iter = entries;
 	fib_nh = fi->fib_nh;
 	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
 		dev = fib_nh->fib_nh_dev;
@@ -197,37 +195,39 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		if (!sw_nb_is_valid_dev(dev))
 			continue;
 
-		iter->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
-		iter->dst = (__force __be32)fen_info->dst;
-		iter->dst_len = fen_info->dst_len;
-		iter->gw = fib_nh->fib_nh_gw4;
+		nh_pf_dev = sw_nb_resolve_pf_dev(dev);
+		if (!nh_pf_dev)
+			continue;
 
-		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4\n",
-			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw);
+		entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			break;
 
-		pf_dev = sw_nb_resolve_pf_dev(dev);
-		if (!pf_dev) {
-			iter++;
-			continue;
-		}
+		entry->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
+		entry->dst = (__force __be32)fen_info->dst;
+		entry->dst_len = fen_info->dst_len;
+		entry->gw = fib_nh->fib_nh_gw4;
 
 		if (netif_is_bridge_master(dev)) {
-			iter->bridge = 1;
+			entry->bridge = 1;
 		} else if (is_vlan_dev(dev)) {
-			iter->vlan_valid = 1;
-			iter->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
+			entry->vlan_valid = 1;
+			entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
 		}
 
-		pf = netdev_priv(pf_dev);
-		iter->port_id = pf->pcifunc;
+		pf = netdev_priv(nh_pf_dev);
+		entry->port_id = pf->pcifunc;
 
 		if (!fib_nh->fib_nh_gw4) {
-			if (iter->dst || iter->dst_len)
-				iter++;
-
+			if (!entry->dst && !entry->dst_len) {
+				kfree(entry);
+				continue;
+			}
+			sw_fib_add_to_list(nh_pf_dev, entry, 1);
 			continue;
 		}
-		iter->gw_valid = 1;
+
+		entry->gw_valid = 1;
 
 		if (fib_nh->nh_saddr)
 			haddr[hcnt++] = fib_nh->nh_saddr;
@@ -236,61 +236,63 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
 		if (!neigh) {
 			rcu_read_unlock();
-			iter++;
+			kfree(entry);
 			continue;
 		}
 
 		if (is_valid_ether_addr(neigh->ha)) {
-			iter->mac_valid = 1;
-			neigh_ha_snapshot(iter->mac, neigh, fib_nh->fib_nh_dev);
+			entry->mac_valid = 1;
+			neigh_ha_snapshot(entry->mac, neigh, fib_nh->fib_nh_dev);
 		}
-
-		iter++;
 		rcu_read_unlock();
-	}
 
-	cnt = iter - entries;
-	if (!cnt) {
-		kfree(entries);
-		kfree(haddr);
-		return NOTIFY_DONE;
+		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4\n",
+			   __func__, entry->cmd, &entry->dst, entry->dst_len,
+			   &entry->gw);
+		sw_fib_add_to_list(nh_pf_dev, entry, 1);
 	}
 
-	if (pf_dev)
-		netdev_dbg(pf_dev, "pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
-	kfree(entries);
-
 	if (!hcnt) {
 		kfree(haddr);
 		return NOTIFY_DONE;
 	}
 
-	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
-	if (!entries) {
-		kfree(haddr);
-		return NOTIFY_DONE;
-	}
+	for (i = 0; i < hcnt; i++) {
+		fib_nh = fi->fib_nh;
+		for (cnt = 0; cnt < fi->fib_nhs; cnt++, fib_nh++) {
+			if (fib_nh->nh_saddr == haddr[i]) {
+				host_pf_dev = sw_nb_resolve_pf_dev(fib_nh->fib_nh_dev);
+				break;
+			}
+		}
+
+		if (!host_pf_dev)
+			continue;
 
-	iter = entries;
+		entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			break;
 
-	for (i = 0; i < hcnt; i++, iter++) {
-		iter->cmd = sw_nb_fib_event_to_otx2_event(event, pf_dev);
-		iter->dst = haddr[i];
-		iter->dst_len = 32;
-		iter->mac_valid = 1;
-		iter->host = 1;
-		iter->port_id = pf->pcifunc;
+		pf = netdev_priv(host_pf_dev);
+		entry->cmd = sw_nb_fib_event_to_otx2_event(event, host_pf_dev);
+		entry->dst = haddr[i];
+		entry->dst_len = 32;
+		entry->mac_valid = 1;
+		entry->host = 1;
+		entry->port_id = pf->pcifunc;
 
-		for_each_dev_addr(pf_dev, dev_addr) {
-			ether_addr_copy(iter->mac, dev_addr->addr);
+		for_each_dev_addr(host_pf_dev, dev_addr) {
+			ether_addr_copy(entry->mac, dev_addr->addr);
 			break;
 		}
 
-		netdev_dbg(pf_dev, "%s: FIB host Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4 %s\n",
-			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw,
-			   pf_dev->name);
+		netdev_dbg(host_pf_dev,
+			   "%s: FIB host Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4 %s\n",
+			   __func__, entry->cmd, &entry->dst, entry->dst_len,
+			   &entry->gw, host_pf_dev->name);
+		sw_fib_add_to_list(host_pf_dev, entry, 1);
 	}
-	kfree(entries);
+
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -306,6 +308,9 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	if (n->tbl != &arp_tbl)
 		return NOTIFY_DONE;
 
+	if (!sw_nb_is_valid_dev(n->dev))
+		return NOTIFY_DONE;
+
 	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return NOTIFY_DONE;
@@ -333,6 +338,6 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
index 0d29c5526df8..0d94c33c53a6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -45,6 +45,9 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 	if (!i6dev)
 		return NOTIFY_DONE;
 
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
 	rcu_read_lock();
 	ifp = list_first_entry_or_null(&i6dev->addr_list,
 				       struct inet6_ifaddr, if_list);
@@ -89,15 +92,15 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "netdev event addr=%pI6c plen=%u mac=%pM\n",
 		   &addr, prefix_len, entry->mac);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
 int sw_nb_v6_fib_event(struct notifier_block *nb,
 		       unsigned long event, void *ptr)
 {
-	struct fib6_entry_notifier_info *f6_eni;
 	struct fib_notifier_info *info = ptr;
+	struct fib6_entry_notifier_info *f6_eni;
 	struct net_device *fib_dev, *pf_dev;
 	struct fib_entry *entry;
 	struct fib6_info *f6i;
@@ -174,8 +177,8 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	rcu_read_unlock();
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -216,9 +219,10 @@ int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
 	entry->mac_valid = 1;
 	entry->port_id = pf->pcifunc;
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(n->dev, "v6 neigh update %pI6c mac=%pM plen=%u\n",
 		   n->primary_key, entry->mac, n->tbl->key_len * 8);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -274,9 +278,10 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
 		break;
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(dev, "inetaddr addr=%pI6c len=%u %pM\n",
 		   &ifa6->addr, ifa6->prefix_len, entry->mac);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
index f73efc98c311..78c0df5eb880 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
@@ -7,6 +7,9 @@
 #ifndef SW_NB_V6_H_
 #define SW_NB_V6_H_
 
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
 int sw_nb_v6_fib_event(struct notifier_block *nb,
 		       unsigned long event, void *ptr);
 
@@ -18,4 +21,30 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
 
 int sw_nb_v6_netdev_event(struct notifier_block *unused,
 			  unsigned long event, void *ptr);
-#endif // SW_NB_V6_H__
+#else
+static inline int sw_nb_v6_fib_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static inline int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
+					    unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static inline int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
+					  unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static inline int sw_nb_v6_netdev_event(struct notifier_block *unused,
+					unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+#endif
+
+#endif /* SW_NB_V6_H_ */
-- 
2.43.0


