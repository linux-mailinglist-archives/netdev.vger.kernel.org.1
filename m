Return-Path: <netdev+bounces-266339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEGTI3qMsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:26:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44D2583F0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F21631C1026
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB53EE1DC;
	Tue, 10 Mar 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="0zp2CYzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CE3EC2EB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177782; cv=none; b=G7mbiM9DKRS+PzLpilJuCRb60b1lYcTS4DKXdZ23B1AK8fFl8TjuridPGHPRZkobVhus9py4llTQeWagdgfua0SCTUO4oS6eGYoLwe3gHUz0Ki/+5ZDr5ZzHNKtKjcI18rqeyUoOhweXVGxzRXBDyaA+RDESBP8Kkw8NuZGnoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177782; c=relaxed/simple;
	bh=1cSenaADeYpz69y+fz8kGgIfSyE1YZ/fkoMWAV5wOF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cC4mfie2BegShsZFx+sb256e3kZ9weySeSi+iWB3xIZhQPhviMxgV6oYR8/e3/MbBnpjkp7Vxg1hRfdlviS30mgbPGRmLSGt83w2eurm1oPYAeRQISKdbKwHq2eYCfCMXLa1Gm5VmqTa4pJu0qCxd+GiS671Yn28Yb+W+pUjLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=0zp2CYzS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab39b111b9so59979625ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177775; x=1773782575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISfec1K3jJo2AiWUBgbx3JM6HbVDacr1Hr+xolgCOdc=;
        b=0zp2CYzS2lwnfkEZrNLLH6la9soJi22sQXk/kpy9H3/1w7ODf6CR30ZjC0g73X5/gs
         NqSKNHUomU5qcSniqcnrBCviuqT1LhYsfIoZ4P5jQ82rXqy+QlBIqAGFIuZ/8Wh1/Gv0
         +OerGvjQ6HrPRe9tafWar4NGeY1HpTkTGH0/901nCAeOf9MNmxve0kOlgkL0J/SxDvq8
         m55FasPP8g5ExZH8xh26nq5ik0eXDCbMv/CjMt/LJ84T2XNQucZ4rtEHji6sDeiRk7hA
         oqnKfaBDFed+cP5XWpfVK8/QhY8giqL4DuGxjQg8hDaxnLsJE9fUX91ozKsW2qEADCdF
         vQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177775; x=1773782575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISfec1K3jJo2AiWUBgbx3JM6HbVDacr1Hr+xolgCOdc=;
        b=h4wDdCoqbFFI8htoV9e8IloH5D1fSxjOSCEpOd3xHmmmzC6uAvyjPuVC65cD2DzA/i
         C1jz25uwR8sjz++LdxJiJ+xFb/QpZO1RRiFPMBOlmNvO/vI1R0BnpMIEsENqqgfpgBke
         7njsCpEpz6nSGzWp531c6XdLu+y/TjUdnoUiax/ISev3WOMW41KGyhYXYEA3znXNZngL
         t93G7+ttbwvzR7Et2ip43K7/3LuocYKO5ak7Uj+m2nJACkv5SoeVlYHJyjqkw/9tNJyv
         qzVZfTW57robHPp/1TLhE4fdY/lLBwzO3YCK1AaECxUPCVgT1rwlWFAAdmuQkaQrcV74
         ynxw==
X-Gm-Message-State: AOJu0Yz6VwhdQEtaP41tjc3ln6CTXUEDiBI5L0rErO/7oiUCPxVh98ps
	fBC0zixMkxr4CmddO/ROBjL5nR6unzxLLA6tj35tyzrLYbYkCHP1vu2dr9FHLLyi6kQZ9bgiNmR
	5kp4L690=
X-Gm-Gg: ATEYQzziuP+GpwcIkcC968ixpJ0v2LpAUIVYuiphI2BcL/DrAslYa47SAQLv951c21S
	ibFinzeUsTAIT1/I10btxUpAnAjOtTVyBXmdM9dRmZRpjJ7YbRaTQy7UhMUzWbxFkGLsmrrypq6
	foMrw1gwhiZzFY2mRKDwTWGdxTYhYtGV9y4yOylaEd5Hbw58gXTJt7GVm+sNFC+3uw+rTOB1MV0
	EizqyebRoMxFDfvZkCF22F7WmSUzq067KLADp+ly5PzvPaNjQ/6Q7atE8KnHlzOoGon1jcRdjVC
	ieycV25+JPzUdAHmYyOBNVMvMSZCvytCST/6z75fDkhAFrt6CfggvyeCMR2ZFY4Q6jR55e61ZU+
	0lUeGnYiRP0wcKCw62k2hMN8bS+AocOfEOUeNAVzCsDGjYz7abl+rnjhKe1hui1W0VEm+G71lMi
	gCkcyqwSH9vDXFt6s=
X-Received: by 2002:a17:902:cec1:b0:2ae:483f:b239 with SMTP id d9443c01a7336-2aeae876363mr1855375ad.30.1773177775172;
        Tue, 10 Mar 2026 14:22:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222ab6sm2417595ad.10.2026.03.10.14.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:54 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	bpf@vger.kernel.org
Subject: [RFC net-next 07/10] net: bnxt: Add boilerplate GSO code
Date: Tue, 10 Mar 2026 14:21:55 -0700
Message-ID: <20260310212209.2263939-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D44D2583F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266339-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

Add bnxt_gso.c and bnxt_gso.h with a stub bnxt_sw_udp_gso_xmit()
function, SW USO constants (BNXT_SW_USO_MAX_SEGS,
BNXT_SW_USO_MAX_DESCS), and the is_sw_gso field in bnxt_sw_tx_bd
with BNXT_SW_GSO_MID/LAST markers.

The full SW USO implementation will be added in a future commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 30 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 31 +++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index ba6c239d52fa..debef78c8b6d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BNXT) += bnxt_en.o
 
-bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o
+bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o bnxt_gso.o
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 41d933a4c282..99c625b954d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -889,6 +889,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_ts_pkt;
 	u8			is_push;
 	u8			action;
+	u8			is_sw_gso;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
@@ -896,6 +897,9 @@ struct bnxt_sw_tx_bd {
 	};
 };
 
+#define BNXT_SW_GSO_MID		1
+#define BNXT_SW_GSO_LAST	2
+
 struct bnxt_sw_rx_bd {
 	void			*data;
 	u8			*data_ptr;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
new file mode 100644
index 000000000000..b296769ee4fe
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/netdev_queues.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+#include <net/tso.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_gso.h"
+
+netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
+				 struct bnxt_tx_ring_info *txr,
+				 struct netdev_queue *txq,
+				 struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	dev_core_stats_tx_dropped_inc(bp->dev);
+	return NETDEV_TX_OK;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
new file mode 100644
index 000000000000..f01e8102dcd7
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Broadcom NetXtreme-C/E network driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef BNXT_GSO_H
+#define BNXT_GSO_H
+
+/* Maximum segments the stack may send in a single SW USO skb.
+ * This caps gso_max_segs for NICs without HW USO support.
+ */
+#define BNXT_SW_USO_MAX_SEGS	64
+
+/* Worst-case TX descriptors consumed by one SW USO packet:
+ * Each segment: 1 long BD + 1 ext BD + payload BDs.
+ * Total payload BDs across all segs <= num_segs + nr_frags (each frag
+ * boundary crossing adds at most 1 extra BD).
+ * So: 3 * max_segs + MAX_SKB_FRAGS + 1 = 3 * 64 + 17 + 1 = 210.
+ */
+#define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
+
+netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
+				 struct bnxt_tx_ring_info *txr,
+				 struct netdev_queue *txq,
+				 struct sk_buff *skb);
+
+#endif
-- 
2.52.0


