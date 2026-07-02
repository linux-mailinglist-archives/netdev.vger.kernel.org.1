Return-Path: <netdev+bounces-303976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pxs8LevuRWpnGwsAu9opvQ
	(envelope-from <netdev+bounces-303976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D666F3790
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=hDV6eO4D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303976-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B12953088CBE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1B367F25;
	Thu,  2 Jul 2026 04:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF936C5A1;
	Thu,  2 Jul 2026 04:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967863; cv=none; b=Nwh8U7eCWWZu26bfPhbiqTRcfauqi7wbapeQmNd0YHpdMWH1uEQZJsEuavVpzHZuFFZKuX8hbYY37BH9Cr3MUPWTMPpY29FExbQevWcmGsijx4hK+pD3FNFvdmWRmrAjUgl9af8qHR9/yhlinGy3JmbHh8u7ipLrZX1EI1o0mRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967863; c=relaxed/simple;
	bh=eWDwatK2M0quvNRkjpumLbwYFKU/MgWv36tqgekLsOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppGNloijn9KLupR+IQV8lXbGc4VtjB0wS5o/v0vJTG0AcTu5xc3x0a2cQBucp4ubZeOEkR/BTINPtsqE3m6CElq/h4GW0X77n0NLst4tMO5DsjqFw9eKeoOYlkAkOlWOwNnnkQ+crbyi1wpgpfyYOEy218rIvVWuiRcZKjJvfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hDV6eO4D; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MiVi601526;
	Wed, 1 Jul 2026 21:50:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	gtZU8YulXNqz6MQ3PRn4PouU8ArZYSvDEBny5F/q9k=; b=hDV6eO4DkrNkIHNM/
	U/1rHWhiDRc0ylh+4JrLsL+iihLxxapRhB0dQIGNB9WvWyS+FaCZo6L5XIURXFQJ
	zscZSEslK40LQnUItrIJlt1GNmhN65vvWUJLsavs2D9aX2tvbpRAwTfDAo4xf+uY
	C9Tetp1H/At81R7Hy+juYb9k0aQHNIPjL2mc11FAzVC/TDTHTq5l7oJFTSuG0IY3
	X4V74yD3CC9rzqYTYJndUVU8LpPrGxtn+SVoEwK2shgrPhFThHWfsrNugqHYgcrq
	Yi+JQippd1vrJ2m2lRgHoxSc/kTd4VXL5PVQsDZ0m9YthkNDi0RXhyGBW04NCVce
	zZOwg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f50g3ksn2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:50:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:50:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:50:52 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6134F3F708F;
	Wed,  1 Jul 2026 21:50:49 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 7/9] octeontx2: plumb bridge FDB updates through AF and switchdev
Date: Thu, 2 Jul 2026 10:20:24 +0530
Message-ID: <20260702045026.2914748-8-rkannoth@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=Gf4nWwXL c=1 sm=1 tr=0 ts=6a45ee2c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=zjSZ3cS-AAAA:8
 a=4Gu7slldWrJdUSCZ14sA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ZdzWmiyDu4ucoLeQK2uw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfXx4EUd1vYmqV7
 er0OziNDQ6csIRH09SrBt/3pkvHbQ3IBeVUmJNtVHgRX15zRNIWJwd9F2S8zMNfjPqMnnZk7ESp
 a9i0o9tdVbI969VaNajhf+OF9Nk7QB+in/4QUfx/sJ7Cq3M22bu/LCRwBFCahF/tnYrYVKNwXDq
 rQ5XNcTnPsaUyJkPOSi2nLuxLeLL087EXBVrRCPJagYoxoB4WexeBb+Zz/57Dlx2TbX7PhGs4Go
 isvspkihRYphFO/kA37SdSf4uEt6a4ArNnRGsxdzIPCufaap6KETWhMjOX3qqTAJ/KpSCnYvhCx
 gMePCRCVUHcF0Guw0wmHvDIdXQ9+BwpOyfyyEMuME8c+Q7d7VBwRbWlGjQZ8CNEM0Ssr+B1owcn
 p8Kj0eZZfAtUM1D9Q+lMWZeUXd2EZTCXRel0yk0UmqBIuRAAPOGDLxn6EzEbgYHPY0GpzWnJI52
 8sLC/CWJLYLbxwLFL4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfXx99WNm4tiWYT
 Dy9ZaCi6QeSxfTH/P31JyF68GDFlFNgwOGuYf5GGiGhNDWlAJb5DWim4YmLW4AkR7gfjFhXCamE
 Gn5cnUPany2DiW1jV6AIlTF57CPVojE=
X-Proofpoint-GUID: FzBX6quGAQQBlmDn129qbE2IHt9NYtQ0
X-Proofpoint-ORIG-GUID: FzBX6quGAQQBlmDn129qbE2IHt9NYtQ0
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
	TAGGED_FROM(0.00)[bounces-303976-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,info.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22D666F3790

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
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   4 +
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  21 +-
 .../marvell/octeontx2/af/switch/rvu_sw.h      |   1 +
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 324 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  17 +
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 149 ++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |   1 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |   2 +
 9 files changed, 521 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 6e10a58a0421..0f751555338e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -23,6 +23,7 @@
 #include "cn20k/reg.h"
 #include "cn20k/api.h"
 #include "cn20k/npc.h"
+#include "switch/rvu_sw.h"
 
 #define DRV_NAME	"rvu_af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -2579,6 +2580,7 @@ static void __rvu_mbox_up_handler(struct rvu_work *mwork, int type)
 
 		switch (msg->id) {
 		case MBOX_MSG_CGX_LINK_EVENT:
+		case MBOX_MSG_AF2PF_FDB_REFRESH:
 			break;
 		default:
 			if (msg->rc)
@@ -3821,6 +3823,8 @@ static void rvu_remove(struct pci_dev *pdev)
 {
 	struct rvu *rvu = pci_get_drvdata(pdev);
 
+	rvu_sw_shutdown();
+
 	rvu_dbg_exit(rvu);
 	rvu_unregister_dl(rvu);
 	rvu_unregister_interrupts(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 28f8281e9219..6fc13aeff45f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -8,6 +8,8 @@
 #include <linux/bitfield.h>
 #include "rvu.h"
 #include "rvu_sw.h"
+#include "rvu_sw_l2.h"
+#include "rvu_sw_fl.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
@@ -26,5 +28,22 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
 				     struct msg_rsp *rsp)
 {
-	return 0;
+	int rc = 0;
+
+	switch (req->msg_type) {
+	case SWDEV2AF_MSG_TYPE_FW_STATUS:
+		rc = rvu_sw_l2_init_offl_wq(rvu, req->pcifunc, req->fw_up);
+		break;
+
+	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
+		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
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
index 847a8da60d0a..fb24e0a79ff9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -10,5 +10,6 @@
 
 /* RVU Switch */
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
+void rvu_sw_shutdown(void);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
index 5f805bfa81ed..bd0fe13b1fc9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -4,11 +4,335 @@
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
+struct l2_entry {
+	struct list_head list;
+	u64 flags;
+	u32 port_id;
+	u8  mac[ETH_ALEN];
+};
+
+static DEFINE_MUTEX(l2_offl_list_lock);
+static LIST_HEAD(l2_offl_lh);
+
+static DEFINE_MUTEX(fdb_refresh_list_lock);
+static LIST_HEAD(fdb_refresh_lh);
+
+struct rvu_sw_l2_work {
+	struct rvu *rvu;
+	struct work_struct work;
+};
+
+/* Work queue for switchdev message handling. There is only
+ * on switch HW per SoC, so one instance of each type of
+ * workqueue is enough.
+ */
+static struct rvu_sw_l2_work l2_offl_work;
+static struct workqueue_struct *rvu_sw_l2_offl_wq;
+
+static struct rvu_sw_l2_work fdb_refresh_work;
+static struct workqueue_struct *fdb_refresh_wq;
+
+/* High-frequency link state transitions or aggressive FDB
+ * aging intervals can induce rapid fdb churn. To prevent
+ * thrashing, inhibit hardware offloading of these transient
+ * forwarding states to the switching ASIC.
+ */
+static void rvu_sw_l2_offl_cancel_add_if_del_reqs_exist(u8 *mac)
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
+static int rvu_sw_l2_fdb_refresh(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct af2pf_fdb_refresh_req *req;
+	int pf, vidx;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+
+	if (pf) {
+		req = otx2_mbox_alloc_msg_af2pf_fdb_refresh(rvu, pf);
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+
+		otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+	} else {
+		vidx = pcifunc - 1;
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
+		mutex_unlock(&fdb_refresh_list_lock);
+
+		rvu_sw_l2_fdb_refresh(fdb_work->rvu, l2_entry->port_id, l2_entry->mac);
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
+		mutex_unlock(&l2_offl_list_lock);
+
+		add_fdb = !!(l2_entry->flags & FDB_ADD);
+
+		if (add_fdb)
+			rvu_sw_l2_offl_cancel_add_if_del_reqs_exist(l2_entry->mac);
+
+		if (rvu_sw_l2_offl_rule_push(offl_work->rvu, l2_entry))
+			dev_err(offl_work->rvu->dev,
+				"%s: Error to push l2 rule\n",
+				__func__);
+		kfree(l2_entry);
+	}
+
+	if (!list_empty(&l2_offl_lh))
+		queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
+}
+
+static bool fw_is_up;
+
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up)
+{
+	struct rvu_switch *rswitch;
+
+	rswitch = &rvu->rswitch;
+
+	if (fw_up && !fw_is_up) {
+		/* Switch HW sends an MBOX message to Host once it is ready */
+		rswitch->pcifunc = pcifunc;
+		fw_is_up = true;
+
+		l2_offl_work.rvu = rvu;
+		INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
+		rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
+		if (!rvu_sw_l2_offl_wq) {
+			dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
+			return -ENOMEM;
+		}
+
+		fdb_refresh_work.rvu = rvu;
+		INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
+		fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresg_wq", 0, 0);
+		if (!fdb_refresh_wq) {
+			dev_err(rvu->dev, "fdb refresh workqueue allocation failed\n");
+			return -ENOMEM;
+		}
+
+		rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
+		return 0;
+	}
+
+	rswitch->flags &= ~RVU_SWITCH_FLAG_FW_READY;
+	flush_work(&l2_offl_work.work);
+	rswitch->pcifunc = -1;
+	return 0;
+}
+
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct l2_entry *l2_entry;
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	l2_entry->port_id = pcifunc;
+	ether_addr_copy(l2_entry->mac, mac);
+
+	mutex_lock(&fdb_refresh_list_lock);
+	list_add_tail(&l2_entry->list, &fdb_refresh_lh);
+	mutex_unlock(&fdb_refresh_list_lock);
+
+	queue_work(fdb_refresh_wq, &fdb_refresh_work.work);
+	return 0;
+}
 
 int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
 				struct fdb_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct l2_entry *l2_entry;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return 0;
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
+	list_add_tail(&l2_entry->list, &l2_offl_lh);
+	mutex_unlock(&l2_offl_list_lock);
+
+	queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
+
 	return 0;
 }
+
+void rvu_sw_l2_shutdown(void)
+{
+	struct l2_entry *entry;
+	LIST_HEAD(tlist);
+
+	if (!fdb_refresh_wq)
+		return;
+
+	cancel_work_sync(&fdb_refresh_work.work);
+	destroy_workqueue(fdb_refresh_wq);
+
+	mutex_lock(&fdb_refresh_list_lock);
+	while (1) {
+		entry = list_first_entry_or_null(&fdb_refresh_lh,
+						 struct l2_entry, list);
+		if (!entry)
+			break;
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	mutex_unlock(&fdb_refresh_list_lock);
+
+	cancel_work_sync(&l2_offl_work.work);
+	destroy_workqueue(rvu_sw_l2_offl_wq);
+
+	mutex_lock(&l2_offl_list_lock);
+	while (1) {
+		entry = list_first_entry_or_null(&l2_offl_lh,
+						 struct l2_entry, list);
+		if (!entry)
+			break;
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	mutex_unlock(&l2_offl_list_lock);
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index b022f52c6845..4540ffacdddc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -15,6 +15,7 @@
 #include "otx2_ptp.h"
 #include "cn10k.h"
 #include "cn10k_ipsec.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_nicvf"
 #define DRV_STRING	"Marvell RVU NIC Virtual Function Driver"
@@ -141,6 +142,22 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
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
+		err = otx2_mbox_up_handler_af2pf_fdb_refresh(vf,
+							     (struct af2pf_fdb_refresh_req *)req,
+							     rsp);
+		return err;
+
 	default:
 		otx2_reply_invalid_msg(&vf->mbox.mbox_up, 0, 0, req->id);
 		return -ENODEV;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
index 6842c8d91ffc..327a6efeb526 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -4,13 +4,162 @@
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
+static DEFINE_SPINLOCK(sw_fdb_llock);
+static LIST_HEAD(sw_fdb_lh);
+
+struct sw_fdb_list_entry {
+	struct list_head list;
+	u64 flags;
+	struct otx2_nic *pf;
+	u8  mac[ETH_ALEN];
+	bool add_fdb;
+};
+
+static struct workqueue_struct *sw_fdb_wq;
+static struct work_struct sw_fdb_work;
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
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		if (sw_fdb_add_or_del(entry->pf, entry->mac, entry->add_fdb))
+			netdev_err(entry->pf->netdev,
+				   "Error to add/del fdb %pM entry\n",
+				   entry->mac);
+		dev_put(entry->pf->netdev);
+		kfree(entry);
+	}
+
+	spin_lock(&sw_fdb_llock);
+	if (!list_empty(&sw_fdb_lh))
+		queue_work(sw_fdb_wq, &sw_fdb_work);
+	spin_unlock(&sw_fdb_llock);
+}
+
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fdb_list_entry *entry;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	ether_addr_copy(entry->mac, mac);
+	entry->add_fdb = add_fdb;
+	entry->pf = pf;
+	dev_hold(dev);
+
+	spin_lock(&sw_fdb_llock);
+	list_add_tail(&entry->list, &sw_fdb_lh);
+	queue_work(sw_fdb_wq, &sw_fdb_work);
+	spin_unlock(&sw_fdb_llock);
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
+	LIST_HEAD(tlist);
+
+	cancel_work_sync(&sw_fdb_work);
+	destroy_workqueue(sw_fdb_wq);
+
+	spin_lock(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		dev_put(entry->pf->netdev);
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
+	call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+				 item.info.dev, &item.info, NULL);
+
+	return 0;
 }
+#endif
+EXPORT_SYMBOL(otx2_mbox_up_handler_af2pf_fdb_refresh);
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
index fb183265a9aa..99b8b9fdfe8a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -120,11 +120,13 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
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
-- 
2.43.0


