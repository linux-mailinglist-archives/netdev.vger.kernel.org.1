Return-Path: <netdev+bounces-287309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHLhBfKZA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:21:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00152A386
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BDB306BFF3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F937E315;
	Tue, 12 May 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AhXCnMXq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0233672AF
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620899; cv=none; b=XyGOgAopH6l4NyjNslBSDHxmv5K0dlmCaWmdE+wgqn+2e5Vi3i3nD3+37onbzAPnn2Sc2AmqOUWSIuu4rNx2CsnLBj9iJvq5aWxtECmFo66uWIwatYknpIoVputFcDR0aXLGyCY8VshlkqYZN6YBetvkw/93GZA3VoZrGdS5GDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620899; c=relaxed/simple;
	bh=MYfUX7nVRS6pf3lnmkAUYbDgSLt9atzzzeNCyQqx+tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaElLLTwAebmSyykViJJ6jfKPqHtij9q9NsQoRlUDtlUGLef3+7qqIca87fFIuPotVyPQ3ZAjyJhw67HpbjHcvkr8IseM0rZ0wG0jGSfSdRzvNSYTfjw7bV7wCIFfjyOVHGoaJbb1b5TJE2fKVE4bJB363w4dpAxriJuZfiTWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AhXCnMXq; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-631ca15d35aso2566831137.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620897; x=1779225697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R27fOis4DF8HyMQM62Kr4pdWO10vRmCRq/RQxqD9m6A=;
        b=ghdnxTifPx66QGy1c78s2M3v9JYqYVBHnTJVcO3IKgu9X01aiIqZFalMdlyFfV6joQ
         lUNoaI6+LO+8pC6AHxri5m7nIzDisN0Hv23zKLJiF2+CHVnDJuIraaR/X1xF9Yb3X/J0
         a/xdjuI7xWHq75lGotSVDZNQmRGbJnIE61NuhBUTJ1+agXW+IT2BOIoHAjjvP0Ecv1DK
         5rQJtVchxlCADW6yFxWrpIHK162KiREwtMq3f+UCPUnMHLSym2V0/pTrwPFhNWg3Hyut
         xLZRV+aOFuVt/U3HdhvpMI/xJ+8wwR6VkgM7Hx8UcR8zclpT+YJ516EUvX+gX7PjDPQi
         HMrg==
X-Gm-Message-State: AOJu0YyUlHP+G7vYw4vHb9YGmbClXsgah166pBEv2brAxtB/8cZrDM4G
	Gec+Fb8/aCYsMsvS5wsIBLPGQgyzN40WN2PTBkfdxdmXx0eSZn92ui16wxm7ewr1vPqB0RVejrQ
	cI1g7/Xvs6R6uGaQgqJ/46y0vyKk1zTV8yAm/Hvt3ShSffB9BSqh4pIrmjU/bn4qEcqcF9PXarG
	tVbKnsizCKnVfDhH5qaW755LJlz6P4ZaDZDMr6OcUxmc92FnGWINZKfOZ5x+Oaw9+Lo3XUzHc4W
	iZ5kY8uk1Q=
X-Gm-Gg: Acq92OGseCcSAk268vc10tPY9WviFkD1qFk0A+dyxqoBWUiY1T9wIQKkoo2NPThtW65
	x9Rtf34KBV+jSxwYl0AQqofb5eSi2Dfxs4kyzLhBQPvSWN8xom25QCcWy3ODq4z65ZgZpoLNQ/m
	lSBGoL0LWgYYwQGErGkVkM4oRPeMdGM61zym/O6PLRX9hZmyREYDVhPpxxyzihwtxEPV96G33cO
	jcwEJTzn5usYXfgwEpbT2sZWA9HlOrhLdu6R6Dfy0OdfYUzv6gzr02LzB9iKRyInUOHb2CxGI27
	dO2tBKJDLHqeof97NiLMC55f/Po47drKY6K9LlIjiiMiB+C++RLZX2x46EDW+BIrwBfea6DdFv+
	GabrezM9fM0GcIJuF92BypKajyL4pCmCo6iFxau+QUKxIbDS1Hm2MQrmDpaeNBJzKm4iL3ihVJQ
	bjyEZpWXPOZ21UsBGhtrzYW8rHrfrhgry+Q804kalGinLljJRmI+AAgsT55ps=
X-Received: by 2002:a05:6102:5e86:b0:613:3fff:febc with SMTP id ada2fe7eead31-6376103f75bmr320563137.2.1778620897263;
        Tue, 12 May 2026 14:21:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6313ffac8ebsm1150102137.11.2026.05.12.14.21.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12df8bc580cso3704716c88.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620896; x=1779225696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R27fOis4DF8HyMQM62Kr4pdWO10vRmCRq/RQxqD9m6A=;
        b=AhXCnMXq3AUeHdwcgINtVqoj4z5ydXzxOaXUEc5hC8rCWqhCk7Jq28dzbzTvnqgw35
         GSdXFphUKvODM51SAxmeRF3WZ5JZlxYgUwynhYXTrRV52S2Wnuzmjg5eQuggePVSqfs9
         I4BAdtbQn2CJGuOjcuseNU//ifCavbgjFmIak=
X-Received: by 2002:a05:7022:ec14:b0:12d:b8e5:5e2 with SMTP id a92af1059eb24-1333b4e811bmr2781934c88.23.1778620895815;
        Tue, 12 May 2026 14:21:35 -0700 (PDT)
X-Received: by 2002:a05:7022:ec14:b0:12d:b8e5:5e2 with SMTP id a92af1059eb24-1333b4e811bmr2781923c88.23.1778620895247;
        Tue, 12 May 2026 14:21:35 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:34 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 01/15] bnxt_en: Add Midpath channel information
Date: Tue, 12 May 2026 14:20:51 -0700
Message-ID: <20260512212105.3488258-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260512212105.3488258-1-michael.chan@broadcom.com>
References: <20260512212105.3488258-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 6C00152A386
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287309-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Midpath channels (MPCs) are rings for hardware control paths.  These
control paths are used to offload kTLS directly to the hardware
without going through firmware.  This patch adds the basic information
structures for these MPCs.

An MPC is basically a TX and completion ring pair with a HW TLS block
as the destination.  Two MPC channel types are used to offload
connections to the TX crypto engine (TCE) and the RX crypto
engine (RCE) respectively.  In the driver, we re-use the
bnxt_tx_ring_info and bnxt_cp_ring_info control structs for the MPCs.

This patch also adds the CONFIG_BNXT_TLS Kconfig option to conditionally
include the MPC logic.  The first few patches in the series add the MPC
support.  kTLS support will be added later in the series.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig         |  9 ++++
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 26 ++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 47 +++++++++++++++++++
 6 files changed, 93 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 4287edc7ddd6..0114760c3ac4 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -254,6 +254,15 @@ config BNXT_HWMON
 	  Say Y if you want to expose the thermal sensor data on NetXtreme-C/E
 	  devices, via the hwmon sysfs interface.
 
+config BNXT_TLS
+	bool "Broadcom NetXtreme-C/E TLS offload support"
+	default y
+	depends on BNXT && TLS_DEVICE
+	depends on TLS=y || BNXT=m
+	help
+	  Say Y if you want to enable Transport Layer Security (TLS) hardware
+	  encryption and decryption offload on supported NetXtreme-C/E devices.
+
 config BNGE
 	tristate "Broadcom ThorUltra Ethernet device support"
 	depends on PCI
diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index debef78c8b6d..0506574c007a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,3 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 945a86696f2f..06d0c82b4022 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -76,6 +76,7 @@
 #include "bnxt_hwmon.h"
 #include "bnxt_gso.h"
 #include <net/tso.h>
+#include "bnxt_mpc.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9937,6 +9938,11 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	}
 	bp->tso_max_segs = le16_to_cpu(resp->max_tso_segs);
 
+	if (resp->mpc_chnls_cap)
+		bnxt_alloc_mpc_info(bp, resp->mpc_chnls_cap);
+	else
+		bnxt_free_mpc_info(bp);
+
 hwrm_func_qcaps_exit:
 	hwrm_req_drop(bp, req);
 	return rc;
@@ -16485,6 +16491,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
@@ -17156,6 +17163,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 61c847b36b9f..ab88d96f807c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2451,6 +2451,8 @@ struct bnxt {
 
 	u8			tph_mode;
 
+	struct bnxt_mpc_info	*mpc_info;
+
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
new file mode 100644
index 000000000000..86087e538550
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_mpc.h"
+
+void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
+{
+	if (!bp->mpc_info)
+		bp->mpc_info = kzalloc_obj(*bp->mpc_info);
+	if (bp->mpc_info)
+		bp->mpc_info->mpc_chnls_cap = mpc_chnls_cap;
+	else
+		netdev_warn(bp->dev, "Unable to allocate MPC info\n");
+}
+
+void bnxt_free_mpc_info(struct bnxt *bp)
+{
+	kfree(bp->mpc_info);
+	bp->mpc_info = NULL;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
new file mode 100644
index 000000000000..cd3f268a3a29
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_MPC_H
+#define BNXT_MPC_H
+
+/* Mid path channel (MPC) definitions.  An MPC is special TX/completion
+ * ring pair to send/receive control plane data to the TCE and RCE
+ * (Transmit/Receive Crypto Engine) HW blocks.
+ */
+
+enum bnxt_mpc_type {
+	BNXT_MPC_TCE_TYPE = RING_ALLOC_REQ_MPC_CHNLS_TYPE_TCE,
+	BNXT_MPC_RCE_TYPE = RING_ALLOC_REQ_MPC_CHNLS_TYPE_RCE,
+	BNXT_MPC_TYPE_MAX,
+};
+
+#define BNXT_MAX_MPC		8
+
+struct bnxt_mpc_info {
+	u8			mpc_chnls_cap;
+	u8			mpc_cp_rings;
+	u8			mpc_ring_count[BNXT_MPC_TYPE_MAX];
+	struct bnxt_tx_ring_info *mpc_rings[BNXT_MPC_TYPE_MAX];
+};
+
+#define BNXT_MPC_CRYPTO_CAP    \
+	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
+
+#define BNXT_MPC_CRYPTO_CAPABLE(bp)					\
+	((bp)->mpc_info ?						\
+	 ((bp)->mpc_info->mpc_chnls_cap & BNXT_MPC_CRYPTO_CAP) ==	\
+	  BNXT_MPC_CRYPTO_CAP : false)
+
+#ifdef CONFIG_BNXT_TLS
+void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
+void bnxt_free_mpc_info(struct bnxt *bp);
+#else
+static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
+{
+}
+
+static inline void bnxt_free_mpc_info(struct bnxt *bp)
+{
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_MPC_H */
-- 
2.51.0


