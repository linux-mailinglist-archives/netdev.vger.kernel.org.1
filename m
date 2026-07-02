Return-Path: <netdev+bounces-303977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wXWxKt/uRWpmGwsAu9opvQ
	(envelope-from <netdev+bounces-303977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:53:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E436F378B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:53:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=MkDL5lWM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303977-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303977-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58CF130265E8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0BB36DA15;
	Thu,  2 Jul 2026 04:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2C3655E2;
	Thu,  2 Jul 2026 04:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967866; cv=none; b=oeJ+qurco7l/cNS8N8Dtu3MHmuHXqI3rQsTvvgUAo8/kjcVqYIP/iJYHU5yVfjXF7UXs9wL0FX9uhF/QDwR7QGjkfp4Ul2K5u+6HS2Tq4CikC1UL7dLenAVIbfsOTfBZb53WRv28lXNIuxeNoqCbkEgtcgsiALA4h+gBoa3K+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967866; c=relaxed/simple;
	bh=XiPwFW/4jL3+1tNpbMMRPJo6v5hsMbkX5cqlQQ6DKRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rayE9HGNhJIouIq3lBA5i0txGsYrWQG3ogsekym1Nt0MDYf4CoAmIfmXAMX0yAKFnx9Nsk4NaBu43zFB1kPMkY0Gz4RS64jojcvu8k0yJtqP7E2Js/ao2MkQ/Pn53SO3hVziOD7CnLlPFpuHCi4TlGX/Hgyuke4P1ZgYbcapQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MkDL5lWM; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MGZx213826;
	Wed, 1 Jul 2026 21:50:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	jWrPTr7SQMqJ+spfiPnmz8IHj6TmbbBv6F4QfGb8n0=; b=MkDL5lWMif2l0jD2k
	bEhBBQjqY+hUsRqyVW7V3R+1JKFDWIxU50CCODVxG9tilqRVUGxCmLkFH7i3hIO9
	pjZTZexjoq++Dooi6Ckc2uNmow3nXVuZt4Nh1NDWKDwzNKouiorVfttvYaNzH5e5
	UThAsEICwolFfCXmTP1guTYrLaP5SZGOvq/aTeZKUuJ6fzC6WMyDID++afvsguzO
	fA9ueSUnAvmGX6fvn+xuwza6O0bzs9eAcep/zWbhSkRo2b8D+onWPWZVf3Zq33EL
	ZBJdtlid6MMYn9DREZkSVYDBQXhDady4dH8XgDh+7wRaj8IYLdKxEGMSiBKJVk3k
	gyFug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f52krbdt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 21:50:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 21:50:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 21:50:55 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 57EC83F7090;
	Wed,  1 Jul 2026 21:50:52 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next 8/9] octeontx2: offload host FIB updates to switch via AF mailbox
Date: Thu, 2 Jul 2026 10:20:25 +0530
Message-ID: <20260702045026.2914748-9-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfXyBmCZskr+l69
 KD1IOHUmehQuWfVIc87PTl9qRqS1/Ngp7uwDTWmz49oB4qnNgDhoz4Lvdc7xKG4PEht1wIs3/qF
 DG76OPA0Xz6vZT5caonNJNd/jtqmw5k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0NSBTYWx0ZWRfX4TFXGpg7ahdc
 wRp1teoWdgO6F2slhkSSFEjM5/8hsJfVJ7y+u9cGLobVtX1fdB2hnNI5oHlT0iucMGwchBt7TJ7
 7iU7KLlK8uzPXffIMa86H64GQ1KhMyknBu1DPCu7JvHfGQwsGgLWLVcAzaa4b4fqJbIYaxJ3S6u
 RX93OqKstV6c9ehW8hegfsH9Z32yHfROZ/b7n7y31BWa3SplIf/h8iEuoJCr9gS7cIXD6OB2N7+
 uXdkFzGNEw57qXqMo61IdvY5IsOZ49yBJ6xyaPzZcKPSN9YTmXgKOlrlEDm4SgyRwgzS9qo+MZj
 woguO8rNH/uLEcdA/d3ASY2VRFffVsEcwJYxlBp6XjvJ/KuM83tsz8z7QctwFu5oFBW2p2TSY/8
 6ogE9X0/FRscv/g4nAlGvaTlzW/cvc1Fo1Bj8rTHP6oSWMkUf89pf+9TvwNrcRrODiXc8B83mf7
 9kHMkHDwbG7UvlMR0MA==
X-Proofpoint-GUID: fRFmW88EmTegrM8UyffyODgwaLGAqboO
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a45ee30 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ifqhsyMfDcTB9HSCsGoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: fRFmW88EmTegrM8UyffyODgwaLGAqboO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-303977-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4E436F378B

Queue IPv4/IPv6 FIB-derived updates from the switch notifier path
and handle fib_notify in the RVU AF by batching fib_entry
structures and sending them to the switch PF through the
AF-to-switchdev FIB_CMD).  Require the switch firmware to
be ready before accepting offload work.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +-
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   2 +
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 226 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |   1 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 123 ++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |   3 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |  10 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   |  24 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   |  10 +-
 9 files changed, 384 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 28ebf0a8d3d6..ae6f145a0db0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1968,7 +1968,7 @@ struct af2swdev_notify_req {
 		};
 		struct {
 			u8 cnt;
-			struct fib_entry entry[16];
+			struct fib_entry entry[12];
 		};
 
 		struct {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 6fc13aeff45f..6a2a3a03523d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -9,6 +9,7 @@
 #include "rvu.h"
 #include "rvu_sw.h"
 #include "rvu_sw_l2.h"
+#include "rvu_sw_l3.h"
 #include "rvu_sw_fl.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
@@ -46,4 +47,5 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
+	rvu_sw_l3_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
index 2b798d5f0644..bd4ec3b20d4a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,237 @@
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
+MBOX_UP_AF2SWDEV_MESSAGES
+#undef M
+
+static struct workqueue_struct *sw_l3_offl_wq;
+
+struct l3_entry {
+	struct list_head list;
+	struct rvu *rvu;
+	u32 port_id;
+	int cnt;
+	struct fib_entry entry[];
+};
+
+static DEFINE_MUTEX(l3_offl_llock);
+static LIST_HEAD(l3_offl_lh);
+static bool l3_offl_work_running;
+
+static struct workqueue_struct *sw_l3_offl_wq;
+static void sw_l3_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(l3_offl_work, sw_l3_offl_work_handler);
+
+static int rvu_sw_l3_offl_rule_push(struct list_head *lh)
+{
+	struct af2swdev_notify_req *req;
+	struct fib_entry *entry, *dst;
+	struct l3_entry *l3_entry;
+	struct rvu *rvu;
+	int tot_cnt = 0;
+	int swdev_pf;
+	int sz, cnt;
+	bool rc;
+
+	BUILD_BUG_ON(sizeof(*req) > 1024);
+
+	l3_entry = list_first_entry_or_null(lh, struct l3_entry, list);
+	if (!l3_entry)
+		return 0;
+
+	rvu = l3_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+
+		while ((l3_entry =
+			list_first_entry_or_null(lh,
+						 struct l3_entry, list)) != NULL) {
+			list_del_init(&l3_entry->list);
+			kfree(l3_entry);
+		}
+
+		return -ENOMEM;
+	}
+
+	dst = &req->entry[0];
+	while ((l3_entry =
+		list_first_entry_or_null(lh,
+					 struct l3_entry, list)) != NULL) {
+		entry = l3_entry->entry;
+		cnt = l3_entry->cnt;
+		sz = sizeof(*entry) * cnt;
+
+		memcpy(dst, entry, sz);
+		tot_cnt += cnt;
+		dst += cnt;
+
+		list_del_init(&l3_entry->list);
+		kfree(l3_entry);
+	}
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
+static atomic64_t req_cnt;
+static atomic64_t ack_cnt;
+static atomic64_t req_processed;
+static LIST_HEAD(l3_local_lh);
+static int lcnt;
+
+static void sw_l3_offl_work_handler(struct work_struct *work)
+{
+	struct l3_entry *l3_entry;
+	struct list_head l3lh;
+	u64 req, ack, proc;
+
+	INIT_LIST_HEAD(&l3lh);
+
+	mutex_lock(&l3_offl_llock);
+	while (1) {
+		l3_entry = list_first_entry_or_null(&l3_offl_lh, struct l3_entry, list);
+
+		if (!l3_entry)
+			break;
+
+		if (lcnt + l3_entry->cnt > 8 && !list_empty(&l3_local_lh)) {
+			req = atomic64_read(&req_cnt);
+			atomic64_set(&ack_cnt, req);
+			atomic64_set(&req_processed, req);
+			mutex_unlock(&l3_offl_llock);
+			goto process;
+		}
+
+		lcnt += l3_entry->cnt;
+
+		atomic64_inc(&req_cnt);
+		list_del_init(&l3_entry->list);
+		list_add_tail(&l3_entry->list, &l3_local_lh);
+	}
+	mutex_unlock(&l3_offl_llock);
+
+	req = atomic64_read(&req_cnt);
+	ack = atomic64_read(&ack_cnt);
+
+	if (req > ack) {
+		atomic64_set(&ack_cnt, req);
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(100));
+		return;
+	}
+
+	proc = atomic64_read(&req_processed);
+	if (req == proc) {
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(1000));
+		return;
+	}
+
+	atomic64_set(&req_processed, req);
+
+process:
+	lcnt = 0;
+
+	mutex_lock(&l3_offl_llock);
+	list_splice_init(&l3_local_lh, &l3lh);
+	mutex_unlock(&l3_offl_llock);
+
+	if (rvu_sw_l3_offl_rule_push(&l3lh))
+		pr_err("%s: Error to push rules\n", __func__);
+
+	queue_delayed_work(sw_l3_offl_wq, &l3_offl_work, msecs_to_jiffies(100));
+}
 
 int rvu_mbox_handler_fib_notify(struct rvu *rvu,
 				struct fib_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct l3_entry *l3_entry;
+	int sz;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return 0;
+
+	if (req->cnt > 16)
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
+	mutex_lock(&l3_offl_llock);
+	list_add_tail(&l3_entry->list, &l3_offl_lh);
+	mutex_unlock(&l3_offl_llock);
+
+	if (!l3_offl_work_running) {
+		sw_l3_offl_wq = alloc_workqueue("sw_af_fib_wq", 0, 0);
+		l3_offl_work_running = true;
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(1000));
+	}
+
 	return 0;
 }
+
+void rvu_sw_l3_shutdown(void)
+{
+	struct l3_entry *entry;
+	LIST_HEAD(tlist);
+
+	if (!sw_l3_offl_wq)
+		return;
+
+	cancel_delayed_work_sync(&l3_offl_work);
+	destroy_workqueue(sw_l3_offl_wq);
+
+	mutex_lock(&l3_offl_llock);
+	while (1) {
+		entry = list_first_entry_or_null(&l3_offl_lh,
+						 struct l3_entry, list);
+		if (!entry)
+			break;
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
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
index 12ddf8119372..54b854aa7ffa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -4,13 +4,136 @@
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
+	if (cnt > 16)
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
+		sw_fib_notify(lentry->pf, lentry->cnt, lentry->entry);
+		kfree(lentry->entry);
+		kfree(lentry);
+	}
+
+	spin_lock_bh(&sw_fib_llock);
+	if (!list_empty(&sw_fib_lh))
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
+
+	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);
+	if (!lentry)
+		return -ENOMEM;
+
+	lentry->pf = pf;
+	lentry->cnt = cnt;
+	lentry->entry = entry;
+	INIT_LIST_HEAD(&lentry->lh);
+
+	spin_lock(&sw_fib_llock);
+	list_add_tail(&lentry->lh, &sw_fib_lh);
+	queue_delayed_work(sw_fib_wq, &sw_fib_work,
+			   msecs_to_jiffies(10));
+	spin_unlock(&sw_fib_llock);
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
+	LIST_HEAD(tlist);
+
+	cancel_delayed_work_sync(&sw_fib_work);
+	destroy_workqueue(sw_fib_wq);
+
+	spin_lock_bh(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock_bh(&sw_fib_llock);
+
+	while ((lentry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fib_list_entry, lh)) != NULL) {
+		list_del_init(&lentry->lh);
+		kfree(lentry->entry);
+		kfree(lentry);
+	}
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
index a51d15c2b80e..50c4fbca81e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -7,6 +7,9 @@
 #ifndef SW_FIB_H_
 #define SW_FIB_H_
 
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt);
+
 void sw_fib_deinit(void);
 int sw_fib_init(void);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index 99b8b9fdfe8a..61f0ed26adfd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -112,6 +112,7 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	int rc = 0;
 
 	if (!sw_nb_is_valid_dev(dev))
 		return NOTIFY_DONE;
@@ -120,19 +121,22 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
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
 
@@ -301,11 +305,9 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
 	if (idev)
 		sw_nb_v4_netdev_event(unused, event, ptr);
 
-#if IS_ENABLED(CONFIG_IPV6)
 	i6dev = __in6_dev_get(dev);
 	if (i6dev)
 		sw_nb_v6_netdev_event(unused, event, ptr);
-#endif
 
 	return NOTIFY_DONE;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
index 947dafe586a0..8fd02edaa90e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -76,7 +76,7 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
 		   __func__, entry->dst, entry->mac, dev->name);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 
 	return NOTIFY_DONE;
 }
@@ -134,7 +134,7 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
 		   __func__, entry->dst, entry->mac, dev->name);
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
@@ -250,18 +250,26 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 	}
 
 	cnt = iter - entries;
-	if (!cnt)
+	if (!cnt) {
+		kfree(entries);
+		kfree(haddr);
 		return NOTIFY_DONE;
+	}
 
 	netdev_dbg(pf_dev, "pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
-	kfree(entries);
 
-	if (!hcnt)
+	sw_fib_add_to_list(pf_dev, entries, cnt);
+
+	if (!hcnt) {
+		kfree(haddr);
 		return NOTIFY_DONE;
+	}
 
 	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
-	if (!entries)
+	if (!entries) {
+		kfree(haddr);
 		return NOTIFY_DONE;
+	}
 
 	iter = entries;
 
@@ -281,7 +289,7 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		netdev_dbg(pf_dev, "%s: FIB host  Rule cmd=%lld dst=%#x dst_len=%d gw=%#x %s\n",
 			   __func__, iter->cmd, iter->dst, iter->dst_len, iter->gw, pf_dev->name);
 	}
-	kfree(entries);
+	sw_fib_add_to_list(pf_dev, entries, hcnt);
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -326,8 +334,8 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	rcu_read_unlock();
 
-	kfree(entry);
 	return NOTIFY_DONE;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
index cc908f565d24..49fd6bdf3df4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -72,8 +72,8 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "netdev event %pM plen=%u mac=%pM\n",
 		   &ifp->addr, ifp->prefix_len, entry->mac);
+	sw_fib_add_to_list(dev, entry, 1);
 	rcu_read_unlock();
-	kfree(entry);
 	return NOTIFY_DONE;
 }
 
@@ -154,8 +154,8 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
 	}
 
+	sw_fib_add_to_list(fib_dev, entry, 1);
 	rcu_read_unlock();
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -189,9 +189,10 @@ int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
 	entry->mac_valid = 1;
 	entry->port_id = pf->pcifunc;
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(n->dev, "v6 neigh update %pI6 mac=%pM plen=%u\n",
 		   n->primary_key, n->ha, n->tbl->key_len * 8);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -237,9 +238,10 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
 		break;
 	}
 
+	sw_fib_add_to_list(dev, entry, 1);
+
 	netdev_dbg(dev, "inetaddr addr=%pI6c len=%u %pM\n",
 		   &ifa6->addr, ifa6->prefix_len, entry->mac);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
-- 
2.43.0


