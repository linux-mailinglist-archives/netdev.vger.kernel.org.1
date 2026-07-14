Return-Path: <netdev+bounces-307320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cLAOAYSXVWpGqgAAu9opvQ
	(envelope-from <netdev+bounces-307320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5FF750377
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:57:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=jesHlNvS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307320-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6DB3006B4C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3A373BF1;
	Tue, 14 Jul 2026 01:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD06372B3D;
	Tue, 14 Jul 2026 01:57:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994241; cv=none; b=g/nk7suk03p/qFu5Ha2XQJ/sP5EU7m7Dz658OwIIDk2nISRpSQ1KdJwzqIYA4/3Y1tfG4etpehd2OvH+EVFkwHFNSmmbaf4zBnaKXVSwxa7chcFp5vEs3Wrwb/mldcEt9Df3rekP+5kmy7aZ4zWyRCI6LrTezyl5+0ue3iZICGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994241; c=relaxed/simple;
	bh=2pd/jOd3m94G2ffElgqgOwWW1PqQLVMsM79EzeqXvVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxQOvYauQAWHjsfggJXK2NmUtvq7jgQHv8UXvatRKLuXesl31LE3RFwzlmYNQO7Sz7MTvDbtmTwEFHUaD/7oaePUaqP2RxDqNIbMTOl/qDCcgnCHv6FpKwEORNr9PapXu5ayVrxliMPC7tB4vL/5w2FL6pXz78ereHA7xQRXKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jesHlNvS; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnFvc2948253;
	Mon, 13 Jul 2026 18:53:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	pKlsqVPVFd+G4Lenm1Bjnq3B4WzXlSIZDNSJ/cJXQU=; b=jesHlNvSV9Kpy8ltf
	8t/v2xBrFulwVO2otElbdv1K9pwbB4XsjM58U854vrTRDnQAGOmRVIy8FbHydqON
	Y/vzNJiXr1VPhGmmU6dGCq+de34RhDZj/sYEwDIcpEVCo58MjafvtwaOG+OCaUVV
	W8POeYs6TF2HQYDzCOsnNwQTJriJvkn9m5QqgKZZWx30bWeNQeEWGfX3ESiUocdw
	U+z7YIYIi6BitIlB33xkYX2SigSsPJg56hBqdfAZkIheJ/NcQqamANxxyR8UEYvM
	D/Vz1LTPdOvwbUBgE9Y6BTIbiyTtCePV9hAZORvNacQCPk25rZPPPYoxcoYO9R1a
	S/Xag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fbnbex552-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:53:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 18:53:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 18:53:53 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E48AE5E6867;
	Mon, 13 Jul 2026 18:53:50 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 3/9] octeontx2-pf: switch: Add pf files hierarchy
Date: Tue, 14 Jul 2026 07:23:25 +0530
Message-ID: <20260714015331.1801922-4-rkannoth@marvell.com>
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
X-Proofpoint-GUID: 4xoAhfzOF69F2vsiHH_IUjdl08qwlx2O
X-Authority-Analysis: v=2.4 cv=WOdPmHsR c=1 sm=1 tr=0 ts=6a5596b2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=Tbk3QSKcrk8eJG6noeMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4xoAhfzOF69F2vsiHH_IUjdl08qwlx2O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfXza4L5RkTLJt8
 vX9nXXR10Nz/GDyIc8iybBeWSssOb+pLyrFm6rW6pGo1Jgie+3VykxGe1BB9/CJSi+i+OalnKs9
 bp1EaRcuWRFw9owg2uKv1g2rA4xyzLE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxNiBTYWx0ZWRfX9PSjmwA3TF4e
 hUoY0UL5ZvFu+/thf/j3w3kb6occCqtY40QppVEljLgWyhCQSQ1EJSYKfcbMOlJJ6puYKzZInoO
 iLqO+T1cE5QClOTFHKQT5EUqxHOi724yfLODp/Oog5YXOt/78Dni4dvmk4NqlVeSLcALTTm8MgG
 MtuzDZFKUxlQU6G35LPjSK/2Uqi1zM13/OE0r0Y1i8X9G+KQy98ChAAm/MAYqEGWFrsqGG9Jtv2
 1ubN456vAWR1UJ5/fRZ5SAKEpzEYEbjKuvRdTPVIrQSSbaH6vmLUseIARhreMr6tNr0KQDJrQmt
 toRaw6sOHsGPE4sTQLKtcvKW5ceMyT8FTuYa8UuoAMA6hCcZg0qBa9ZQOg8KR6WPHSgMVOMR8OI
 DfIuZPllO7iWQJR5wClpmyEyJHvjPQrNqedsS2TYQuJZRwTbVhzuoEy0MafWTyWn+nAlwcxaASp
 4x6bJ6gHju1k1NCVWtA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307320-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E5FF750377

Adds CONFIG_OCTEONTX_SWITCH, links stub switch objects into the PF
module, and introduces empty sw_* init/deinit and notifier hooks for
later patches.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/Kconfig    | 10 ++++++++++
 .../ethernet/marvell/octeontx2/nic/Makefile   |  5 ++++-
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 16 +++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     | 13 ++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 16 +++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     | 20 +++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 16 +++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      | 13 ++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 17 ++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      | 20 +++++++++++++++++++
 10 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index 47e549c581f0..e2fb6dd71078 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -28,6 +28,16 @@ config NDC_DIS_DYNAMIC_CACHING
 	  , NPA stack pages etc in NDC. Also locks down NIX SQ/CQ/RQ/RSS and
 	  NPA Aura/Pool contexts.
 
+config OCTEONTX_SWITCH
+	bool "Marvell OcteonTX2 switch driver"
+	depends on (64BIT && COMPILE_TEST) || ARM64
+	depends on OCTEONTX2_PF
+	default n
+	help
+	  This driver supports Marvell's OcteonTX2 switch.
+	  Marvell SWITCH HW can offload L2, L3 flow. ARM core interacts
+	  with Marvell SW HW thru mbox.
+
 config OCTEONTX2_PF
 	tristate "Marvell OcteonTX2 NIC Physical Function driver"
 	select OCTEONTX2_MBOX
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 883e9f4d601c..123b0af23abd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,7 +9,10 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
-               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
+               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o \
+	       switch/sw_fdb.o switch/sw_fl.o
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o
+
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
new file mode 100644
index 000000000000..6842c8d91ffc
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fdb.h"
+
+int sw_fdb_init(void)
+{
+	return 0;
+}
+
+void sw_fdb_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
new file mode 100644
index 000000000000..d4314d6d3ee4
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FDB_H_
+#define SW_FDB_H_
+
+void sw_fdb_deinit(void);
+int sw_fdb_init(void);
+
+#endif // SW_FDB_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
new file mode 100644
index 000000000000..12ddf8119372
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fib.h"
+
+int sw_fib_init(void)
+{
+	return 0;
+}
+
+void sw_fib_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
new file mode 100644
index 000000000000..9b72e95f2dd3
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FIB_H_
+#define SW_FIB_H_
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+void sw_fib_deinit(void);
+int sw_fib_init(void);
+#else
+static inline void sw_fib_deinit(void) {}
+static inline int sw_fib_init(void) { return 0; }
+#endif
+
+#endif /* SW_FIB_H_ */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
new file mode 100644
index 000000000000..36a2359a0a48
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fl.h"
+
+int sw_fl_init(void)
+{
+	return 0;
+}
+
+void sw_fl_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
new file mode 100644
index 000000000000..cd018d770a8a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FL_H_
+#define SW_FL_H_
+
+void sw_fl_deinit(void);
+int sw_fl_init(void);
+
+#endif // SW_FL_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
new file mode 100644
index 000000000000..2d14a0590c5d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_nb.h"
+
+int sw_nb_unregister(void)
+{
+	return 0;
+}
+
+int sw_nb_register(void)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
new file mode 100644
index 000000000000..73cc1e99b8ec
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_H_
+#define SW_NB_H_
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_nb_register(void);
+int sw_nb_unregister(void);
+#else
+static inline int sw_nb_register(void) { return 0; }
+static inline int sw_nb_unregister(void) { return 0; }
+#endif
+
+#endif /* SW_NB_H_ */
-- 
2.43.0


