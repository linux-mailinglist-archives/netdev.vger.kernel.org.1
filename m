Return-Path: <netdev+bounces-302904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id crxhB5EvQ2riTwoAu9opvQ
	(envelope-from <netdev+bounces-302904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:53:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B96DFE97
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:53:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Lrh4Mjg7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302904-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B021302EAA8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D863CFF6B;
	Tue, 30 Jun 2026 02:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490C3CF95E;
	Tue, 30 Jun 2026 02:47:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787681; cv=none; b=JlbVdeWg05jpK04LhAunK7wTTug+rtjx1iOyVLvixbfo23Z2YNEkxOAXVMKhNcpqKApZy0xxmx1o5r8GqquchlMkOPlis9D3khrv2bvPfJIaTJ4bxjjQ37BjB54x+vtnbZvpRPQ2/ijqjD2ccn7juaFmYPsmjvZ+XDXlI384SgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787681; c=relaxed/simple;
	bh=CFeK8uJqEt1U+VkuoIIzEaRCxQPj6UvT+TB47hqjXuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSuFRYW1ZhGIAxhl5kseIOLZFkYONvB6d4cBe3Cxn4di9OWcFTiF5DzsvNMQQ3iBi5cIJhNIqYL+do844ddf0KZuqiQTEyoF2z4jXUDIaqaTV9F7Pw2LzDLmW551eXbaSHX2tQEs+LvE/SMPqK4XQz/bkt3yg7ocPe2DX5tNkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lrh4Mjg7; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IFF93243929;
	Mon, 29 Jun 2026 19:47:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	d9K5EflVl/9aQhj5ymlni65HAiJyulVxbeamTMHOPQ=; b=Lrh4Mjg7rU0Om8TL6
	UQAP51DlM3TlRXXqmxp/JpB8jZoDJePY7oTuMlUct9XG+tIlGpULoflgm81B52Mn
	tcbW0sFuZqfnB9ifUkcyi6KNgcgYtNU1lQSuI4nUD+C2jga8GvKDdszdW7Pfu3IV
	J+zjr0LGfvkOL6bgJ5iLtOF+0pAiYiwtxUjIyMlGJWZg+livxIXGlphFb9qkyBCx
	e10/VNtzxSPhOSkyrNwVKEmIHrMmkFi4vcB1K2kryx+MY87mq3Na+97sNxYWt4z3
	Wo9ETQWcnKOGcXmjtK33ITZBu5K1AASjRo1KdBAcjexhwBA9RV5eGXgXrLEZsRWJ
	5NyIQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f32s6djk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 19:47:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 19:47:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 19:47:50 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C0F063F7041;
	Mon, 29 Jun 2026 19:47:47 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next 8/9] octeontx2: offload host FIB updates to switch via AF mailbox
Date: Tue, 30 Jun 2026 08:17:14 +0530
Message-ID: <20260630024715.4124281-9-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630024715.4124281-1-rkannoth@marvell.com>
References: <20260630024715.4124281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfXyAgJ1HUaQ/b9
 9rM9TfEAPzdkSt+nwEHEy14p4g//yQAwMId8BvR5MV1eTYCUuIvku2rPCy4IpAlSdStqbT+QOCn
 FS2CmNe7LAUDu2TWSApHM1tJfFqCYFinT8KXyEtGBlqT3fAO0FH87RN7AgXpT5l1dqH1oZMpIZv
 I2XZ63+oH0jtjc1eLdLV/ADppqMb44q0ZZvytUx4cvUVLvAtmD6gAA81XJH8GHleZ+T93sPCmxE
 CtvD8HxQPku48ZICSdPNGYjY7nZUV5ZIbMzeuJIP4D+bPJTovlpyHLaTShQO+YrdMMw0FpKdN3f
 V33xnpUKmnvfLc5+fDzauWjcp0+YlS+PqEeyrV0PjMAQCaYBtMDVOUFu7BcPhHDHXSVFT98jZ4v
 6tEO5cSj3bJRWnMrw8eIQihO2Fy8jCwwJcu/+ZnjaC/8Fn6LcqQVv2DhZNlvG16ZyOvtK9olEqO
 x0A604JedXyckXJWNng==
X-Proofpoint-ORIG-GUID: 68-E-WazsNGNZGcF252BBSxT7wG6aGgF
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a432e56 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=eIH3sYHsz6rwSDy_Z6cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX9VYCn4N7/NsB
 EoOrfQi1U3zHwU5dkWrKc128xL2zLRBz31woueKuYu0g1Q1nutaubauJ/W0s1w8aCweSUfoUTKN
 Ky2wrr6bKBQAdX86ueNWbdPfB8iWPnY=
X-Proofpoint-GUID: 68-E-WazsNGNZGcF252BBSxT7wG6aGgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-302904-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A77B96DFE97

Queue IPv4/IPv6 FIB-derived updates from the switch notifier path
and handle fib_notify in the RVU AF by batching fib_entry
structures and sending them to the switch PF through the
AF-to-switchdev FIB_CMD).  Require the switch firmware to
be ready before accepting offload work.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 187 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 103 ++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |   3 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |  10 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   |  26 ++-
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   |  10 +-
 7 files changed, 324 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 835fe2528f03..d3ee1f1904af 100644
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
index 2b798d5f0644..bd021e7258a1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,198 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
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
+	int swdev_pf;
+	int sz, cnt;
+	int tot_cnt = 0;
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
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
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
+		if (lcnt + l3_entry->cnt > 8) {
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
+	rvu_sw_l3_offl_rule_push(&l3lh);
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
index 12ddf8119372..384f11961b9d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -4,13 +4,116 @@
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
+	spin_lock(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock(&sw_fib_llock);
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
+	spin_lock(&sw_fib_llock);
+	if (!list_empty(&sw_fib_lh))
+		queue_delayed_work(sw_fib_wq, &sw_fib_work,
+				   msecs_to_jiffies(10));
+	spin_unlock(&sw_fib_llock);
+}
+
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fib_list_entry *lentry;
+
+	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);
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
+	cancel_delayed_work_sync(&sw_fib_work);
+	destroy_workqueue(sw_fib_wq);
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
index 62d8ff4e5085..2f88d2c2fbf3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -109,6 +109,7 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	int rc = 0;
 
 	if (!sw_nb_is_valid_dev(dev))
 		return NOTIFY_DONE;
@@ -117,19 +118,22 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
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
 
@@ -298,11 +302,9 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
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
index 14db824ddc06..1502e404d1e7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -71,9 +71,10 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 		break;
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %#x, %pM, dev=%s\n",
 		   __func__, entry->dst, entry->mac, dev->name);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -131,7 +132,7 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %#x, %pM, %s\n",
 		   __func__, entry->dst, entry->mac, dev->name);
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
@@ -243,18 +244,26 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
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
 
@@ -274,7 +283,7 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		netdev_dbg(pf_dev, "%s: FIB host  Rule cmd=%lld dst=%#x dst_len=%d gw=%#x %s\n",
 			   __func__, iter->cmd, iter->dst, iter->dst_len, iter->gw, pf_dev->name);
 	}
-	kfree(entries);
+	sw_fib_add_to_list(pf_dev, entries, hcnt);
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -315,7 +324,8 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	return NOTIFY_DONE;
 err:
 	kfree(entry);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
index e43c28d4f15c..80c386a4245d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -63,10 +63,10 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 		ether_addr_copy(entry->mac, dev_addr->addr);
 		break;
 	}
+	sw_fib_add_to_list(dev, entry, 1);
 
 	netdev_dbg(dev, "netdev event %pM plen=%u mac=%pM\n",
 		   &ifp->addr, ifp->prefix_len, entry->mac);
-	kfree(entry);
 	return NOTIFY_DONE;
 }
 
@@ -145,8 +145,8 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
 	}
 
+	sw_fib_add_to_list(fib_dev, entry, 1);
 	rcu_read_unlock();
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -180,9 +180,10 @@ int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
 	entry->mac_valid = 1;
 	entry->port_id = pf->pcifunc;
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(n->dev, "v6 neigh update %pI6 mac=%pM plen=%u\n",
 		   n->primary_key, n->ha, n->tbl->key_len * 8);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -228,9 +229,10 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
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


