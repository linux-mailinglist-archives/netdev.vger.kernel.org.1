Return-Path: <netdev+bounces-307313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ChesCtmWVWoZqgAAu9opvQ
	(envelope-from <netdev+bounces-307313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:54:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B279B750321
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:54:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=QdJt536C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307313-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307313-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5E9E301EF52
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCD65192;
	Tue, 14 Jul 2026 01:54:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1A376A16;
	Tue, 14 Jul 2026 01:54:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994058; cv=none; b=l2CcTll2pLFZOmQwEQnxfQZMmXqHSXm+VWEJetnLbU5Ux3PsfvaYNcBpq7yvTjLIF74iVwMwpewKih677gPK1iT1NIV+WzYAF5yoeNpbWxJcgb+G+QRDK5qUk6ORGm7I2JdhldEHnzafdgjs0lopzQxFszjREC9ro7nEbmXHCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994058; c=relaxed/simple;
	bh=VK85HX3FdSo87OerIQyi7JKYoXsSEVpORqM2qrOgpn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ1iInpZr/AEQZn62ldEVB4JxP5l8J9ZegnO9ixC4Kc4YzojMUe/OWqzVOlxziMgva/UqBWIUS6rCy+ZPMZ2WdYbHp86eWrq6jQzSwNorHmXDaBUC4NPGQiDwV8+f9UIJmOFgkGkGQ7Xw+SrhbeGTKpcfTJfM6cxzvzau0PE44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QdJt536C; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnt9H2949351;
	Mon, 13 Jul 2026 18:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	DNet0Ffmezm2LG0l9kyyHHLF+qY8YwtJoS0WKAKiCg=; b=QdJt536CHYJST7/Dz
	bSwBXU/fB0mNB0ThSQCXC8Os2PUomZAKfHUzKpypEFG3AYue9dP6Tt9qB56D/z+u
	lyiW7MgeX4GP0Wiw/evO3ZekHxUZMtAQ/JrGMXKz3wVZqCpQ4pwYrmlakGmNQVh/
	AHBTNWLZ4luHjyTQAtkljAu3mDo7QU5XDJn8IEdlC9F/VbBpcd0G+GqoH5IFHjTh
	SAY4xlcDfvk8dZU/6zKlO2HMI8HcwnSdFxLzCDl70Dke02/aEeDcxgTn5Hgk74qw
	G3HBfZL9O+b4/5AmFLEs3OcN/QMfALj4uOgSKgpPKSWOCtNJXD4UOQU2y2kApL+9
	ITa2Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fbnbex55g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:54:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 18:54:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 18:54:05 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E57515E6867;
	Mon, 13 Jul 2026 18:54:02 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 7/9] octeontx2: switch: plumb bridge FDB updates through AF and switchdev
Date: Tue, 14 Jul 2026 07:23:29 +0530
Message-ID: <20260714015331.1801922-8-rkannoth@marvell.com>
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
X-Proofpoint-GUID: dIKOkNMlypy39isuUpA1OyT4uMWASiB7
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a5596bf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=zjSZ3cS-AAAA:8
 a=LDXgJI-UBwZQo5QA3ZgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ZdzWmiyDu4ucoLeQK2uw:22
X-Proofpoint-ORIG-GUID: dIKOkNMlypy39isuUpA1OyT4uMWASiB7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX0aLCEy+GU162
 DFL1QZcvYfAwfCDddnY2Jp1UO+b6hs1src6XKWGWFsCWCLULe0ECsxFRTt5QqLlUe6RHSIvurk6
 YAI5J7eLZgEgPLra6M2+PKqaPXNnsmM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX/imyrvmtXdiS
 baf+F0Qjn/h964xQtNlMwyjAW3vJ+RfQhH/VshKrUQW721bV8C11F2+LJD0t9WvArGKAFsji6sb
 Zjm2djr52TROJGAzMk+ipJmvSHyFY3Km5ga4BI1rVHq7mW8rL9AbaI4MXqpF2dei7UAjYkd1UuE
 UovUuAwrtLNmJvK2Nlso5vLBzpY2dVkeHPD7h4dvBn+EnBJl24qQ6VIgd+1O2x86g0agbDnAFs+
 eS/2PPI6rQj/AlHD76D6M/oy+mWH/3V0xuI8pOV/l1zt6NQge4MGR8lp3aUkwKvGG+Y8mlzaAg7
 GE3IopNa+beeF3PtMvCK9JIPcEoP3SqXjSMM4Qh1MTF2D/TPQsTuJfUGSbNs5i9YroPP/K8kr/n
 ZjdrZ1Qr1UpUmrbxyvAKEiR0ob8WpWgyZeSIlgYzJTMS+2K6MrCHiKZ9EJHT8FE4fPGKAVF8DxC
 F4uCTIjVcdpjQ+VqBYg==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307313-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B279B750321

Handle switchdev FDB add and delete notifications on the PF by queuing
work that sends fdb_notify mailbox messages to the AF. The AF queues
those updates and pushes L2 rules toward the switchdev image with
af2swdev notify messages when firmware is ready.
Teach the AF swdev2af path to initialize L2 offload workqueues on
firmware up/down and to accept refresh requests that enqueue FDB
entries for AF to PF mailbox delivery. Add an AF to PF (and VF) upstream
message for FDB refresh, handle it in the VF driver, and treat it like
the CGX link event when acknowledging mailbox completion in the AF.
On refresh, invoke the switchdev notifier so the host bridge can learn
the updated FDB entry.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   2 +
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  51 +-
 .../marvell/octeontx2/af/switch/rvu_sw.h      |   1 +
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 486 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  44 ++
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 218 ++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |   1 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |   2 +
 .../marvell/octeontx2/nic/switch/sw_nb.h      |   8 +-
 12 files changed, 815 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index bf8edab569b1..e8cc7b68ad75 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1996,6 +1996,7 @@ struct af2pf_fdb_refresh_req {
 	struct mbox_msghdr hdr;
 	u16 pcifunc;
 	u8 mac[6];
+	u64 flags;
 };
 
 struct iface_info {
@@ -2035,6 +2036,7 @@ struct fl_info {
 struct swdev2af_notify_req {
 	struct  mbox_msghdr hdr;
 	u64 msg_type;
+/* Mutually exclusive message selectors (not a combinable bitmask). */
 #define SWDEV2AF_MSG_TYPE_FW_STATUS BIT_ULL(0)
 #define	SWDEV2AF_MSG_TYPE_REFRESH_FDB BIT_ULL(1)
 #define	SWDEV2AF_MSG_TYPE_REFRESH_FL BIT_ULL(2)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 532c2b69fb85..217ce85033ac 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -23,6 +23,7 @@
 #include "cn20k/reg.h"
 #include "cn20k/api.h"
 #include "cn20k/npc.h"
+#include "switch/rvu_sw.h"
 
 #define DRV_NAME	"rvu_af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -3859,6 +3860,7 @@ static void rvu_remove(struct pci_dev *pdev)
 	rvu_cgx_exit(rvu);
 	rvu_fwdata_exit(rvu);
 	rvu_mcs_exit(rvu);
+	rvu_sw_shutdown();
 	rvu_mbox_destroy(&rvu->afpf_wq_info);
 	rvu_disable_sriov(rvu);
 	rvu_reset_all_blocks(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 403d57870efe..b9cd7c7524b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -9,6 +9,8 @@
 
 #include "rvu.h"
 #include "rvu_sw.h"
+#include "rvu_sw_l2.h"
+#include "rvu_sw_fl.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
@@ -26,9 +28,56 @@ u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
 }
 
+static bool rvu_sw_swdev2af_msg_valid(u64 msg_type)
+{
+	return msg_type == SWDEV2AF_MSG_TYPE_FW_STATUS ||
+	       msg_type == SWDEV2AF_MSG_TYPE_REFRESH_FDB ||
+	       msg_type == SWDEV2AF_MSG_TYPE_REFRESH_FL;
+}
+
+static int rvu_sw_swdev2af_sender_check(struct rvu *rvu,
+					struct swdev2af_notify_req *req,
+					u64 msg_type)
+{
+	u16 sender = req->hdr.pcifunc;
+
+	if (!rvu_sw_swdev2af_msg_valid(msg_type))
+		return -EINVAL;
+
+	if (!rvu_is_switch_pcifunc(rvu, sender))
+		return -EPERM;
+
+	return 0;
+}
+
 int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
 				     struct msg_rsp *rsp)
 {
-	return 0;
+	int rc;
+
+	rc = rvu_sw_swdev2af_sender_check(rvu, req, req->msg_type);
+	if (rc)
+		return rc;
+
+	switch (req->msg_type) {
+	case SWDEV2AF_MSG_TYPE_FW_STATUS:
+		rc = rvu_sw_l2_init_offl_wq(rvu, req->hdr.pcifunc, req->fw_up);
+		break;
+
+	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
+		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
+		break;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
+void rvu_sw_shutdown(void)
+{
+	rvu_sw_l2_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
index e9ad32c84576..a0cb2a9ce7ab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -12,5 +12,6 @@
 #define RVU_SW_INVALID_PORT_ID	((u32)~0U)
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
+void rvu_sw_shutdown(void);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
index 5f805bfa81ed..f61b2d15768b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -4,11 +4,497 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_l2.h"
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
+MBOX_UP_AF2SWDEV_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
+#undef M
+
+#define RVU_SW_L2_LIST_MAX 4096
+
+struct l2_entry {
+	struct list_head list;
+	u64 flags;
+	u32 port_id;
+	u8  mac[ETH_ALEN];
+};
+
+static DEFINE_MUTEX(l2_offl_list_lock);
+static LIST_HEAD(l2_offl_lh);
+static atomic_t l2_offl_list_cnt = ATOMIC_INIT(0);
+
+static DEFINE_MUTEX(fdb_refresh_list_lock);
+static LIST_HEAD(fdb_refresh_lh);
+static atomic_t fdb_refresh_list_cnt = ATOMIC_INIT(0);
+
+struct rvu_sw_l2_work {
+	struct rvu *rvu;
+	struct work_struct work;
+};
+
+/* Work queue for switchdev message handling. There is only
+ * one switch HW per SoC, so one instance of each type of
+ * workqueue is enough.
+ */
+static struct rvu_sw_l2_work l2_offl_work;
+static struct workqueue_struct *rvu_sw_l2_offl_wq;
+
+static struct rvu_sw_l2_work fdb_refresh_work;
+static struct workqueue_struct *fdb_refresh_wq;
+
+static bool fw_is_up;
+static DEFINE_SPINLOCK(rvu_sw_l2_state_lock);
+
+static void rvu_sw_l2_list_cnt_warn(struct device *dev, atomic_t *cnt,
+				    const char *name)
+{
+	int n = atomic_read(cnt);
+
+	if (n < 0)
+		dev_warn(dev, "L2 %s list count underflow: %d\n", name, n);
+	else if (n > RVU_SW_L2_LIST_MAX)
+		dev_warn(dev, "L2 %s list count overflow: %d (max %d)\n",
+			 name, n, RVU_SW_L2_LIST_MAX);
+}
+
+static void rvu_sw_l2_list_cnt_inc(struct device *dev, atomic_t *cnt,
+				   const char *name)
+{
+	atomic_inc(cnt);
+	rvu_sw_l2_list_cnt_warn(dev, cnt, name);
+}
+
+static void rvu_sw_l2_list_cnt_dec(struct device *dev, atomic_t *cnt,
+				   const char *name)
+{
+	atomic_dec(cnt);
+	rvu_sw_l2_list_cnt_warn(dev, cnt, name);
+}
+
+static void rvu_sw_l2_destroy_wqs(struct rvu *rvu)
+{
+	struct workqueue_struct *offl_wq, *refresh_wq;
+	struct l2_entry *entry;
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	rvu->rswitch.flags &= ~RVU_SWITCH_FLAG_FW_READY;
+	rvu->rswitch.pcifunc = 0;
+	fw_is_up = false;
+	offl_wq = rvu_sw_l2_offl_wq;
+	refresh_wq = fdb_refresh_wq;
+	rvu_sw_l2_offl_wq = NULL;
+	fdb_refresh_wq = NULL;
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (refresh_wq) {
+		cancel_work_sync(&fdb_refresh_work.work);
+		destroy_workqueue(refresh_wq);
+
+		mutex_lock(&fdb_refresh_list_lock);
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &fdb_refresh_list_cnt,
+					"fdb refresh");
+		while (1) {
+			entry = list_first_entry_or_null(&fdb_refresh_lh,
+							 struct l2_entry, list);
+			if (!entry)
+				break;
+
+			list_del_init(&entry->list);
+			kfree(entry);
+		}
+		atomic_set(&fdb_refresh_list_cnt, 0);
+		mutex_unlock(&fdb_refresh_list_lock);
+	}
+
+	if (offl_wq) {
+		cancel_work_sync(&l2_offl_work.work);
+		destroy_workqueue(offl_wq);
+
+		mutex_lock(&l2_offl_list_lock);
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
+		while (1) {
+			entry = list_first_entry_or_null(&l2_offl_lh,
+							 struct l2_entry, list);
+			if (!entry)
+				break;
+
+			list_del_init(&entry->list);
+			kfree(entry);
+		}
+		atomic_set(&l2_offl_list_cnt, 0);
+		mutex_unlock(&l2_offl_list_lock);
+	}
+}
+
+/* High-frequency link state transitions or aggressive FDB
+ * aging intervals can induce rapid fdb churn. To prevent
+ * thrashing, inhibit hardware offloading of these transient
+ * forwarding states to the switching ASIC.  When processing an ADD,
+ * drop a queued DELETE for the same MAC that has not yet been sent to
+ * hardware; the ADD reflects the desired final state and supersedes it.
+ */
+static void rvu_sw_l2_offl_drop_pending_del(u8 *mac)
+{
+	struct l2_entry *entry, *tmp;
+
+	mutex_lock(&l2_offl_list_lock);
+	list_for_each_entry_safe(entry, tmp, &l2_offl_lh, list) {
+		if (!ether_addr_equal(mac, entry->mac))
+			continue;
+
+		if (!(entry->flags & FDB_DEL))
+			continue;
+
+		list_del_init(&entry->list);
+		rvu_sw_l2_list_cnt_dec(l2_offl_work.rvu->dev, &l2_offl_list_cnt,
+				       "offload");
+		kfree(entry);
+		break;
+	}
+	mutex_unlock(&l2_offl_list_lock);
+}
+
+static int rvu_sw_l2_offl_rule_push(struct rvu *rvu, struct l2_entry *l2_entry)
+{
+	struct af2swdev_notify_req *req;
+	int swdev_pf;
+
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	ether_addr_copy(req->mac, l2_entry->mac);
+	req->flags = l2_entry->flags;
+	req->port_id = l2_entry->port_id;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static int rvu_sw_l2_fdb_refresh_send(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct af2pf_fdb_refresh_req *req;
+	int pf, vidx;
+
+	if (!is_pf_func_valid(rvu, pcifunc))
+		return -EINVAL;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+
+	if (pf) {
+		if (pf >= rvu->afpf_wq_info.mbox_up.ndevs) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -EINVAL;
+		}
+
+		req = otx2_mbox_alloc_msg_af2pf_fdb_refresh(rvu, pf);
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+		req->flags = FDB_ADD;
+
+		otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+	} else {
+		vidx = pcifunc - 1;
+
+		if (vidx < 0 || vidx >= rvu->afvf_wq_info.mbox_up.ndevs) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -EINVAL;
+		}
+
+		req = (struct af2pf_fdb_refresh_req *)
+			otx2_mbox_alloc_msg_rsp(&rvu->afvf_wq_info.mbox_up, vidx,
+						sizeof(*req), sizeof(struct msg_rsp));
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+		req->hdr.sig = OTX2_MBOX_REQ_SIG;
+		req->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+		req->flags = FDB_ADD;
+
+		otx2_mbox_wait_for_zero(&rvu->afvf_wq_info.mbox_up, vidx);
+		otx2_mbox_msg_send_up(&rvu->afvf_wq_info.mbox_up, vidx);
+	}
+
+	mutex_unlock(&rvu->mbox_lock);
+
+	return 0;
+}
+
+static void rvu_sw_l2_fdb_refresh_wq_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_work *fdb_work;
+	struct l2_entry *l2_entry;
+
+	fdb_work = container_of(work, struct rvu_sw_l2_work, work);
+
+	while (1) {
+		mutex_lock(&fdb_refresh_list_lock);
+		l2_entry = list_first_entry_or_null(&fdb_refresh_lh,
+						    struct l2_entry, list);
+		if (!l2_entry) {
+			mutex_unlock(&fdb_refresh_list_lock);
+			return;
+		}
+
+		list_del_init(&l2_entry->list);
+		rvu_sw_l2_list_cnt_dec(fdb_work->rvu->dev, &fdb_refresh_list_cnt,
+				       "fdb refresh");
+		mutex_unlock(&fdb_refresh_list_lock);
+
+		rvu_sw_l2_fdb_refresh_send(fdb_work->rvu, l2_entry->port_id,
+					   l2_entry->mac);
+		kfree(l2_entry);
+	}
+}
+
+static void rvu_sw_l2_offl_rule_wq_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_work *offl_work;
+	struct l2_entry *l2_entry;
+	int budget = 16;
+	bool add_fdb;
+
+	offl_work = container_of(work, struct rvu_sw_l2_work, work);
+
+	while (budget--) {
+		mutex_lock(&l2_offl_list_lock);
+		l2_entry = list_first_entry_or_null(&l2_offl_lh, struct l2_entry, list);
+		if (!l2_entry) {
+			mutex_unlock(&l2_offl_list_lock);
+			return;
+		}
+
+		list_del_init(&l2_entry->list);
+		rvu_sw_l2_list_cnt_dec(offl_work->rvu->dev, &l2_offl_list_cnt,
+				       "offload");
+		mutex_unlock(&l2_offl_list_lock);
+
+		add_fdb = !!(l2_entry->flags & FDB_ADD);
+
+		if (add_fdb)
+			rvu_sw_l2_offl_drop_pending_del(l2_entry->mac);
+
+		if (rvu_sw_l2_offl_rule_push(offl_work->rvu, l2_entry))
+			dev_err(offl_work->rvu->dev,
+				"%s: Error to push l2 rule\n",
+				__func__);
+		kfree(l2_entry);
+	}
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	if (rvu_sw_l2_offl_wq && atomic_read(&l2_offl_list_cnt))
+		queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+}
+
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up)
+{
+	struct rvu_switch *rswitch = &rvu->rswitch;
+
+	if (!fw_up) {
+		rvu_sw_l2_destroy_wqs(rvu);
+		return 0;
+	}
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	if (fw_is_up && rvu_sw_l2_offl_wq && fdb_refresh_wq) {
+		rswitch->pcifunc = pcifunc;
+		rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
+		spin_unlock_bh(&rvu_sw_l2_state_lock);
+		return 0;
+	}
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (rvu_sw_l2_offl_wq || fdb_refresh_wq)
+		rvu_sw_l2_destroy_wqs(rvu);
+
+	l2_offl_work.rvu = rvu;
+	INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
+	rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
+	if (!rvu_sw_l2_offl_wq) {
+		dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
+		return -ENOMEM;
+	}
+
+	fdb_refresh_work.rvu = rvu;
+	INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
+	fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresh_wq", 0, 0);
+	if (!fdb_refresh_wq) {
+		dev_err(rvu->dev, "fdb refresh workqueue allocation failed\n");
+		destroy_workqueue(rvu_sw_l2_offl_wq);
+		rvu_sw_l2_offl_wq = NULL;
+		return -ENOMEM;
+	}
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	fw_is_up = true;
+	rswitch->pcifunc = pcifunc;
+	rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	return 0;
+}
+
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct workqueue_struct *wq;
+	struct l2_entry *l2_entry;
+
+	if (!is_pf_func_valid(rvu, pcifunc))
+		return -EINVAL;
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	if (!fdb_refresh_wq) {
+		spin_unlock_bh(&rvu_sw_l2_state_lock);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (atomic_read(&fdb_refresh_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &fdb_refresh_list_cnt,
+					"fdb refresh");
+		return -ENOMEM;
+	}
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	l2_entry->port_id = pcifunc;
+	ether_addr_copy(l2_entry->mac, mac);
+
+	mutex_lock(&fdb_refresh_list_lock);
+	if (atomic_read(&fdb_refresh_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &fdb_refresh_list_cnt,
+					"fdb refresh");
+		mutex_unlock(&fdb_refresh_list_lock);
+		kfree(l2_entry);
+		return -ENOMEM;
+	}
+	list_add_tail(&l2_entry->list, &fdb_refresh_lh);
+	rvu_sw_l2_list_cnt_inc(rvu->dev, &fdb_refresh_list_cnt, "fdb refresh");
+	mutex_unlock(&fdb_refresh_list_lock);
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	wq = fdb_refresh_wq;
+	if (wq)
+		queue_work(wq, &fdb_refresh_work.work);
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (!wq) {
+		mutex_lock(&fdb_refresh_list_lock);
+		list_del_init(&l2_entry->list);
+		rvu_sw_l2_list_cnt_dec(rvu->dev, &fdb_refresh_list_cnt,
+				       "fdb refresh");
+		mutex_unlock(&fdb_refresh_list_lock);
+		kfree(l2_entry);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
 				struct fdb_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct workqueue_struct *wq;
+	struct l2_entry *l2_entry;
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY) ||
+	    !rvu_sw_l2_offl_wq) {
+		spin_unlock_bh(&rvu_sw_l2_state_lock);
+		return 0;
+	}
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (atomic_read(&l2_offl_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
+		return -ENOMEM;
+	}
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	l2_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	ether_addr_copy(l2_entry->mac, req->mac);
+	l2_entry->flags = req->flags;
+
+	mutex_lock(&l2_offl_list_lock);
+	if (atomic_read(&l2_offl_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
+		mutex_unlock(&l2_offl_list_lock);
+		kfree(l2_entry);
+		return -ENOMEM;
+	}
+	list_add_tail(&l2_entry->list, &l2_offl_lh);
+	rvu_sw_l2_list_cnt_inc(rvu->dev, &l2_offl_list_cnt, "offload");
+	mutex_unlock(&l2_offl_list_lock);
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	wq = rvu_sw_l2_offl_wq;
+	if (wq)
+		queue_work(wq, &l2_offl_work.work);
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (!wq) {
+		mutex_lock(&l2_offl_list_lock);
+		list_del_init(&l2_entry->list);
+		rvu_sw_l2_list_cnt_dec(rvu->dev, &l2_offl_list_cnt, "offload");
+		mutex_unlock(&l2_offl_list_lock);
+		kfree(l2_entry);
+	}
+
 	return 0;
 }
+
+void rvu_sw_l2_shutdown(void)
+{
+	if (!fdb_refresh_wq && !rvu_sw_l2_offl_wq)
+		return;
+
+	rvu_sw_l2_destroy_wqs(l2_offl_work.rvu);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
index ff28612150c9..6685431d60a2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
@@ -8,4 +8,7 @@
 #ifndef RVU_SW_L2_H
 #define RVU_SW_L2_H
 
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up);
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac);
+void rvu_sw_l2_shutdown(void);
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 2e33b33ec993..0cd6049c637e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -28,6 +28,7 @@
 #include <rvu_trace.h>
 #include "cn10k_ipsec.h"
 #include "otx2_xsk.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_nicpf"
 #define DRV_STRING	"Marvell RVU NIC Physical Function Driver"
@@ -993,6 +994,7 @@ static int otx2_process_mbox_msg_up(struct otx2_nic *pf,
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_MCS_MESSAGES
 MBOX_UP_REP_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
 #undef M
 		break;
 	default:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index b022f52c6845..6f2fc4caf70c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/net_tstamp.h>
+#include <net/switchdev.h>
 
 #include "otx2_common.h"
 #include "otx2_reg.h"
@@ -114,6 +115,33 @@ static void otx2vf_vfaf_mbox_handler(struct work_struct *work)
 	}
 }
 
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+static int otx2vf_mbox_af2pf_fdb_refresh(struct otx2_nic *vf,
+					 struct af2pf_fdb_refresh_req *req,
+					 struct msg_rsp *rsp)
+{
+	struct switchdev_notifier_fdb_info item = {0};
+
+	item.addr = req->mac;
+	item.info.dev = vf->netdev;
+	if (req->flags & FDB_DEL)
+		call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+	else
+		call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+
+	return 0;
+}
+#else
+static int otx2vf_mbox_af2pf_fdb_refresh(struct otx2_nic *vf,
+					 struct af2pf_fdb_refresh_req *req,
+					 struct msg_rsp *rsp)
+{
+	return 0;
+}
+#endif
+
 static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 				      struct mbox_msghdr *req)
 {
@@ -141,6 +169,22 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 		err = otx2_mbox_up_handler_cgx_link_event(
 				vf, (struct cgx_link_info_msg *)req, rsp);
 		return err;
+
+	case MBOX_MSG_AF2PF_FDB_REFRESH:
+		rsp = (struct msg_rsp *)otx2_mbox_alloc_msg(&vf->mbox.mbox_up, 0,
+							    sizeof(struct msg_rsp));
+		if (!rsp)
+			return -ENOMEM;
+
+		rsp->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
+		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
+		rsp->hdr.pcifunc = req->pcifunc;
+		rsp->hdr.rc = 0;
+		err = otx2vf_mbox_af2pf_fdb_refresh(vf,
+						    (struct af2pf_fdb_refresh_req *)req,
+						    rsp);
+		return err;
+
 	default:
 		otx2_reply_invalid_msg(&vf->mbox.mbox_up, 0, 0, req->id);
 		return -ENODEV;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
index 6842c8d91ffc..eb5e2ce44ca2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -4,13 +4,231 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
 #include "sw_fdb.h"
 
+#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp)
+{
+	return 0;
+}
+
+#else
+
+#define SW_FDB_LIST_MAX 4096
+
+static DEFINE_SPINLOCK(sw_fdb_llock);
+static LIST_HEAD(sw_fdb_lh);
+static atomic_t sw_fdb_list_cnt = ATOMIC_INIT(0);
+
+struct sw_fdb_list_entry {
+	struct list_head list;
+	u64 flags;
+	struct otx2_nic *pf;
+	netdevice_tracker dev_tracker;
+	u8  mac[ETH_ALEN];
+	bool add_fdb;
+};
+
+static struct workqueue_struct *sw_fdb_wq;
+static struct work_struct sw_fdb_work;
+
+static void sw_fdb_list_cnt_warn(struct net_device *netdev)
+{
+	int n = atomic_read(&sw_fdb_list_cnt);
+
+	if (n < 0)
+		netdev_warn(netdev, "FDB list count underflow: %d\n", n);
+	else if (n > SW_FDB_LIST_MAX)
+		netdev_warn(netdev, "FDB list count overflow: %d (max %d)\n",
+			    n, SW_FDB_LIST_MAX);
+}
+
+static int sw_fdb_list_count(void)
+{
+	return atomic_read(&sw_fdb_list_cnt);
+}
+
+static void sw_fdb_list_cnt_inc(struct net_device *netdev)
+{
+	atomic_inc(&sw_fdb_list_cnt);
+	sw_fdb_list_cnt_warn(netdev);
+}
+
+static void sw_fdb_list_cnt_dec(struct net_device *netdev)
+{
+	atomic_dec(&sw_fdb_list_cnt);
+	sw_fdb_list_cnt_warn(netdev);
+}
+
+static int sw_fdb_add_or_del(struct otx2_nic *pf,
+			     const unsigned char *addr,
+			     bool add_fdb)
+{
+	struct fdb_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fdb_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	ether_addr_copy(req->mac, addr);
+	req->flags = add_fdb ? FDB_ADD : FDB_DEL;
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fdb_wq_handler(struct work_struct *work)
+{
+	struct sw_fdb_list_entry *entry;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock_bh(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fdb_list_cnt_dec(entry->pf->netdev);
+		if (sw_fdb_add_or_del(entry->pf, entry->mac, entry->add_fdb))
+			netdev_err(entry->pf->netdev,
+				   "Error to add/del fdb %pM entry\n",
+				   entry->mac);
+		netdev_put(entry->pf->netdev, &entry->dev_tracker);
+		kfree(entry);
+	}
+
+	spin_lock_bh(&sw_fdb_llock);
+	wq = sw_fdb_wq;
+	if (wq && !list_empty(&sw_fdb_lh))
+		queue_work(wq, &sw_fdb_work);
+	spin_unlock_bh(&sw_fdb_llock);
+}
+
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fdb_list_entry *entry;
+	struct workqueue_struct *wq;
+
+	spin_lock_bh(&sw_fdb_llock);
+	if (!sw_fdb_wq) {
+		spin_unlock_bh(&sw_fdb_llock);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&sw_fdb_llock);
+
+	if (sw_fdb_list_count() >= SW_FDB_LIST_MAX)
+		return -ENOMEM;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	ether_addr_copy(entry->mac, mac);
+	entry->add_fdb = add_fdb;
+	entry->pf = pf;
+	netdev_hold(dev, &entry->dev_tracker, GFP_ATOMIC);
+
+	spin_lock_bh(&sw_fdb_llock);
+	wq = sw_fdb_wq;
+	if (wq) {
+		list_add_tail(&entry->list, &sw_fdb_lh);
+		sw_fdb_list_cnt_inc(dev);
+		queue_work(wq, &sw_fdb_work);
+	}
+	spin_unlock_bh(&sw_fdb_llock);
+
+	if (!wq) {
+		netdev_put(dev, &entry->dev_tracker);
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int sw_fdb_init(void)
 {
+	INIT_WORK(&sw_fdb_work, sw_fdb_wq_handler);
+	sw_fdb_wq = alloc_workqueue("sw_fdb_wq", 0, 0);
+	if (!sw_fdb_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void sw_fdb_deinit(void)
 {
+	struct sw_fdb_list_entry *entry;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fdb_llock);
+	wq = sw_fdb_wq;
+	sw_fdb_wq = NULL;
+	spin_unlock_bh(&sw_fdb_llock);
+
+	if (!wq)
+		return;
+
+	cancel_work_sync(&sw_fdb_work);
+	destroy_workqueue(wq);
+
+	spin_lock_bh(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock_bh(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fdb_list_cnt_dec(entry->pf->netdev);
+		netdev_put(entry->pf->netdev, &entry->dev_tracker);
+		kfree(entry);
+	}
+}
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp)
+{
+	struct switchdev_notifier_fdb_info item = {0};
+
+	item.addr = req->mac;
+	item.info.dev = pf->netdev;
+	if (req->flags & FDB_DEL)
+		call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+	else
+		call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+
+	return 0;
 }
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
index d4314d6d3ee4..3b06a77e6b56 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -7,6 +7,7 @@
 #ifndef SW_FDB_H_
 #define SW_FDB_H_
 
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb);
 void sw_fdb_deinit(void);
 int sw_fdb_init(void);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index bffe2af003c7..8aa357e9db21 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -148,11 +148,13 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
+		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, true);
 		break;
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
+		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr, false);
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index e995c0e6046b..a701574de1e4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -14,6 +14,10 @@ struct otx2_nic;
 struct af2pf_fdb_refresh_req;
 struct msg_rsp;
 
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
 enum {
 	OTX2_DEV_UP = 1,
@@ -32,10 +36,6 @@ int sw_nb_unregister(struct net_device *netdev);
 bool sw_nb_is_valid_dev(struct net_device *netdev);
 struct net_device *sw_nb_resolve_pf_dev(struct net_device *dev);
 
-int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
-					   struct af2pf_fdb_refresh_req *req,
-					   struct msg_rsp *rsp);
-
 bool sw_nb_is_cavium_dev(struct net_device *netdev);
 int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev);
 int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev);
-- 
2.43.0


