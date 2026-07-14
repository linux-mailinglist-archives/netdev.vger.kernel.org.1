Return-Path: <netdev+bounces-307316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id winSLUKXVWo1qgAAu9opvQ
	(envelope-from <netdev+bounces-307316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:56:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90875035B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:56:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=YCZGbRgd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307316-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E947F301FB1A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59048373BF1;
	Tue, 14 Jul 2026 01:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB5370D7C;
	Tue, 14 Jul 2026 01:56:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994174; cv=none; b=rnKXCFY+dyhDGwlR44YlKTmFMUi7pofGimW4hwUaw+mvRR0nmHJILFipXXxidP2miKve5eMn2B7ghnYQCjCFb8Awpdyzbsjfb/I97gub8yZ+DuwmURpwG7zEbPxTUlQVdtunE15T/cYwOJZ9QfArHJ9ezcvc2zBlFohGq3y4o8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994174; c=relaxed/simple;
	bh=Q7U3bjrqdi8Rw86PhvwL7r3Uti0HA29+JAItJ2c3ZHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Linp0HmD9Q6bw2QaghgtnhOgNHVjeoisjlpggM83kLhQVVEPun5AEOyAHn+YLvzo2Fz7/hzM6KUNQYf0ZYdEPwasVT8RHREoWNYbhw1PPT1tIZz4UdcXgSdnWywGXoNktHke1KgAGwkCWA96zvwulaJ+qo/NGXNDuu+lMpsgOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YCZGbRgd; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNmw5B1678285;
	Mon, 13 Jul 2026 18:53:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	EjCTs8fsYndKO+EktnzTJMS3VnByE1H/MeTIU7lqtM=; b=YCZGbRgd3ymGC8asH
	m6qks6t0xWbJSFENAoS9zQ0JZi2ya8tEGG2HmMVDxBPk6s+F70t1SGX+LQgvHhr1
	iQiptNGFtaV3pRVERz8oZsNn4CaXrUAzV26fun8CORxWoWp8Pc+McppXVzo88EMQ
	Ygkg2pQ69D+Lk22INcJ93Z4EYd4HR6oxbI0xmoBgzDmyLvDcilpy2icuJSOyZrGS
	H72xdtpwmowS0H2Sry3lJ2cqNoht9JLL99+NY0ditBsV50/j6t4gpONusNoapPkt
	NnE9g1BcEar/pEE0W+AMaD4T6ZzJDVkf71fVv2dA2Fxufam5d3BCD95FtLe7+A55
	UwfWA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fc6k9mjjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:53:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 18:53:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 18:53:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E74E55E6866;
	Mon, 13 Jul 2026 18:53:44 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 1/9] octeontx2-af: switch: Add AF to switch mbox and skeleton files
Date: Tue, 14 Jul 2026 07:23:23 +0530
Message-ID: <20260714015331.1801922-2-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: _ZkJFH_7aVjOfJQrVcf207tEv3dxL5zx
X-Proofpoint-GUID: _ZkJFH_7aVjOfJQrVcf207tEv3dxL5zx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX4BsWwcZBuyOt
 TDNaM+5SOLnf02QD3hkBLw5Q6jnvC6Ak0PuZt5MMGdybF0onGTHqkGYv05ERi2xb3M+5te2Hef0
 8kpjv/kQPooRLHnGhkR1JJ6pQAgM2fs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfXwma5KU6mAoWr
 +LSITjbS8711Ba+uZrAekRD82Zx9KJaeZcA49IBWLQUoBQUEndeDvqTCd2Bxg+JL+3BYOcQZmC3
 f12UKantT10oXdEbdGfw+z/qv9mjagLijMnCztYIpgrFyIJBv8peOoV4X2TGAivZrvGR5SbzvhC
 cazkU/IEdJhXWXyTzRN+bqdK49QmyActYaxJN8LxODyKmp5pKw5YRVFQrpmu5eZ6oRMzWPJy3aU
 oUEWcF4n7jZptWFsRhg2YWZlzl1q8qgbllTh1NzgWYbuMqNlJi+nHXYNUjMHcenXvIhZaOe+Wyf
 zIK5iIYKOGv6N5OHdjy7/EffIX5QVLfuU+WNjDNlYk2PFFlhS0KlMrhmvgJ7B0VSEG4HtP8g0B7
 o92sZdN7hqI39qPJfAo/uSVrt65y1tabipdep6MqZFXn6+SoKkq8yT2kd8ThUo8wbCscgHGfFKx
 /8Xdix5hY0eRSA9zHSQ==
X-Authority-Analysis: v=2.4 cv=ULLt2ify c=1 sm=1 tr=0 ts=6a5596ac cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Q9e_prp1UuIZLeogYfEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	TAGGED_FROM(0.00)[bounces-307316-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E90875035B

The Marvell switch hardware runs on a Linux OS. This OS receives
various messages, which are parsed to create flow rules that can be
installed on HW. The switch is capable of accelerating both L2 and
L3 flows.

This commit adds various mailbox messages used by the Linux OS
(on arm64) to send events to the switch hardware.

fdb messages:     Linux bridge FDB messages
fib messages:     Linux routing table messages
status messages:  Packet status updates sent to Host
                  Linux to keep flows active
                  for connection-tracked flows.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 107 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   |  21 ++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   |  14 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   |  14 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |  11 ++
 8 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 91b7d6e96a61..82dd387308c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Marvell's RVU Admin Function driver
 #
 
-ccflags-y += -I$(src)
+ccflags-y += -I$(src) -I$(src)/switch/
 obj-$(CONFIG_OCTEONTX2_MBOX) += rvu_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += rvu_af.o
 
@@ -12,5 +12,6 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
+		  switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o\
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
 		  cn20k/npa.o cn20k/npc.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index f87cdf1b971d..2867da47d9f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -164,6 +164,14 @@ M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
 M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
 M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
+M(FDB_NOTIFY,		0x010,  fdb_notify,				\
+				fdb_notify_req, msg_rsp)		\
+M(FIB_NOTIFY,		0x011,  fib_notify,				\
+				fib_notify_req, msg_rsp)		\
+M(FL_NOTIFY,		0x012,  fl_notify,				\
+				fl_notify_req, msg_rsp)		\
+M(FL_GET_STATS,		0x013,  fl_get_stats,				\
+				fl_get_stats_req, fl_get_stats_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1807,6 +1815,105 @@ struct rep_event {
 	struct rep_evt_data evt_data;
 };
 
+#define FDB_ADD  BIT_ULL(0)
+#define FDB_DEL	 BIT_ULL(1)
+#define FIB_CMD	 BIT_ULL(2)
+#define FL_ADD	 BIT_ULL(3)
+#define FL_DEL	 BIT_ULL(4)
+#define DP_ADD	 BIT_ULL(5)
+
+struct fdb_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 flags;
+	u8  mac[ETH_ALEN];
+};
+
+struct fib_entry {
+	u64 cmd;
+	u64 gw_valid : 1;
+	u64 mac_valid : 1;
+	u64 vlan_valid: 1;
+	u64 host    : 1;
+	u64 bridge  : 1;
+	u64 ipv6  : 1;
+	__be16 vlan_tag;
+	u32 dst_len;
+	u8 dst6_plen;
+	u8 gw6_plen;
+	union {
+		__be32 dst;
+		__be32 dst6[4];
+	};
+	union {
+		__be32 gw;
+		__be32 gw6[4];
+	};
+	u16 port_id;
+	u8 nud_state;
+	u8 mac[ETH_ALEN];
+};
+
+struct fib_notify_req {
+	struct  mbox_msghdr hdr;
+	u16 cnt;
+	u16 rsvd[3]; /* explicit padding for entry[] 8-byte alignment */
+	struct fib_entry entry[16];
+};
+
+struct fl_tuple {
+	__be32 ip4src;
+	__be32 m_ip4src;
+	__be32 ip4dst;
+	__be32 m_ip4dst;
+	__be16 sport;
+	__be16 m_sport;
+	__be16 dport;
+	__be16 m_dport;
+	__be16 eth_type;
+	__be16 m_eth_type;
+	u8 proto;
+	u8 smac[6];
+	u8 m_smac[6];
+	u8 dmac[6];
+	u8 m_dmac[6];
+	u64 is_xdev_br : 1;
+	u64 is_indev_br : 1;
+	u64 uni_di  : 1;
+	u16 in_pf;
+	u16 xmit_pf;
+	u16 rsvd;
+	u64 features;
+	struct {				/* FLOW_ACTION_MANGLE */
+		u8		offset;
+		u8		type;
+		u16		rsvd;
+		u32		mask;
+		u32		val;
+#define MANGLE_ARR_SZ 9
+	} mangle[MANGLE_ARR_SZ]; /* 2 for ETH, 1 for VLAN, 4 for IPv6, 2 for L4. */
+#define MANGLE_LAYER_CNT 4
+	u8 mangle_map[MANGLE_LAYER_CNT]; /* 1 for ETH,  1 for VLAN, 1 for L3, 1 for L4 */
+	u8 mangle_cnt;
+};
+
+struct fl_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 cookie;
+	u64 flags;
+	u64 features;
+	struct fl_tuple tuple;
+};
+
+struct fl_get_stats_req {
+	struct  mbox_msghdr hdr;
+	u64 cookie;
+};
+
+struct fl_get_stats_rsp {
+	struct  mbox_msghdr hdr;
+	u64 pkts_diff;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
new file mode 100644
index 000000000000..1f8b82a84a5d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
+				  struct fl_get_stats_req *req,
+				  struct fl_get_stats_rsp *rsp)
+{
+	return 0;
+}
+
+int rvu_mbox_handler_fl_notify(struct rvu *rvu,
+			       struct fl_notify_req *req,
+			       struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
new file mode 100644
index 000000000000..cf3e5b884f77
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_FL_H
+#define RVU_SW_FL_H
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
new file mode 100644
index 000000000000..5f805bfa81ed
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
+				struct fdb_notify_req *req,
+				struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
new file mode 100644
index 000000000000..ff28612150c9
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_L2_H
+#define RVU_SW_L2_H
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
new file mode 100644
index 000000000000..2b798d5f0644
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fib_notify(struct rvu *rvu,
+				struct fib_notify_req *req,
+				struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
new file mode 100644
index 000000000000..ac8c4f9ba5ac
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_L3_H
+#define RVU_SW_L3_H
+
+#endif
-- 
2.43.0


