Return-Path: <netdev+bounces-299159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QnojB2lXLmrEtgQAu9opvQ
	(envelope-from <netdev+bounces-299159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:25:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B96808CB
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RElcbYQG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 996503006799
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038323932D1;
	Sun, 14 Jun 2026 07:25:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E638D687
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421919; cv=none; b=L2/0C6CNlUTkLgcBGzjJy5F5kyqI0U8XOqrL+Bv8c5YFV9XVkmCWjs1iOJ0qj5gSSog5vXdqJelAYqkyjPPmHkmIrewG/XFXHM8jVVZxCoBrKS0frKngYyc2fQ9bZ2THd01J+7HtTVK9QTL/8yVYd9/Vc72N87II2T4bGzUEDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421919; c=relaxed/simple;
	bh=fhn/OH8qqFJcq1ERonETLN9yyXKxR7C4KRnDWglUl+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJJ/O92Zp1FolZ5dop/rjzIbR2TC92Spu3ziffH0YTBG1wGkDu69AbCTdmzzAf8CfRQw8ActANnsYpNucW0JIVVDsBbJzH4vnda+rk2FDa8Jukc5ohUUkn9b3kjp89Ds5PclwXwtzJDikv04vm6Gu1ieIKnKXiCKME8YxfKUS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RElcbYQG; arc=none smtp.client-ip=209.85.210.100
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7e6e2d54d3dso1340380a34.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421917; x=1782026717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTnLmNgM/FYCSf+taQL3feB43yFy1oJySe8NK6dfhIw=;
        b=CKjV4WqjJ0lgDoWKNBeUPQ+aOrY1DBqT7oCfgI5cT0UY9bFtnjo5enyNDB9SUeIJZE
         avctqsjDO/KVE4UWwU45CUUnZ88qzgw1Gxt9CgbqHxQofUi84+daYRrFn8fAfh0Zhnbh
         p+hSPe4WjxLl+AWw95So6YO/UfHeTZnCJ1BrEwUltfiySqQSwayFQKqC/BoCnizZp0Jm
         camTPTDDvzXPxJ4yl32apv9CwCRQng4VEg36McByIw1Ghy9/ixu3xp9wvqmWSTNmopc7
         m6CQKeQcjP3wC8owog/eyayY1gK4WDDF7kT8r6HjmMrHdzpQLRTj/6K9XaQYwa6dKC4Z
         jkRA==
X-Gm-Message-State: AOJu0YyTa0aaNHAjL7KnhFZrxUrDAePBgxkNe6WZs3cZSFGy2RApqFtm
	5yzfo3TNakwXvOwWdJgxJF8AChFCK/twK5eWp9GW6c5to7kJymx1PjroroNxqPScEdMLq/540FO
	J6HwSwJ0JOVa/1r4J0kd4RMSTbJM8VDrehKsFdAUrFcm8I+uviUIZH/RlzRtxZxG3wdLTGQI3MZ
	koFDX7QUKr4TveWmUoEsIa0NxsUBu58pKhWiiNElrPoidNrIWNFPglu+UaAHN5WqOPYGiA6gQcH
	U86e+Hb10s=
X-Gm-Gg: Acq92OFVRA8QYB8HAPhvNpf3D/cgGA/6dSyyj3ZSm+U1XTCh5feWNP2k6VjkP1BvJpQ
	tlH3i1Ppmqp9Io65KxFJJdTGc6Z33ErsC/wAcRjpbQwmDlp9oB64NddiqqILX3aN4LuRQDrZvNS
	Akli79lpwMu5pXRjAmsfqv+t+LSGSdBeAxZv8sanXTipIKz+geqaLCPvzTmItmk+3qTDBKXYQka
	9RTmFEQO82GUUNIIIA9DG0lqYOLKeidLOjgSwUL6ZkIClvQ7EuMNFfhIcm2pRMDsQOUFp7rfLVi
	JNnAm5/SFxOGztmTEuFszWmkcsUNnxCkaSSRoKvE0uMpGrwQ2SzTLk1hf0thtzGX9aoeRokVgVs
	OGXv/ffeBiHyWCy0i4NrGGHj64d4GXVeW5gDh8i7zEyJlOMmtD+FatgrNHx303Q3FmrefYGaX9u
	0iD75a2L/mQrZctN5G5HWy2555WOaqjCRvsqjIWJaYiIyuj6cXpmC/Sv3XBAk=
X-Received: by 2002:a05:6830:4c18:b0:7e6:8955:c52d with SMTP id 46e09a7af769-7e78467babamr7276730a34.5.1781421917247;
        Sun, 14 Jun 2026 00:25:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7e79f5a105asm167696a34.1.2026.06.14.00.25.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30761ab3483so1618276eec.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421916; x=1782026716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTnLmNgM/FYCSf+taQL3feB43yFy1oJySe8NK6dfhIw=;
        b=RElcbYQGAkJwPZkujj+H8NZbKSAV2usPJyVgSjXhrXUbNYgQwp7O0fiAvChmheEWSj
         zXe+vwJBjALuCHEGSqFZDO2ndeUmFHzIU5yG0b8GaUh5lnRCebotjGRregKUIzSVo5Y3
         c7ggxSe568tqvqhg3F9+pqmEwoBMhnNiWLK2c=
X-Received: by 2002:a05:7300:430a:b0:304:188d:d0b0 with SMTP id 5a478bee46e88-30820054cf7mr6063567eec.20.1781421915759;
        Sun, 14 Jun 2026 00:25:15 -0700 (PDT)
X-Received: by 2002:a05:7300:430a:b0:304:188d:d0b0 with SMTP id 5a478bee46e88-30820054cf7mr6063548eec.20.1781421915168;
        Sun, 14 Jun 2026 00:25:15 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:14 -0700 (PDT)
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
Subject: [PATCH net-next v3 01/15] bnxt_en: Add Midpath channel information
Date: Sun, 14 Jun 2026 00:23:53 -0700
Message-ID: <20260614072407.2761092-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:ajit.khaparde@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F7B96808CB

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
index 1eb214e4b511..f06c6978dd71 100644
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
@@ -16495,6 +16501,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
@@ -17166,6 +17173,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 29ff5a584d16..f8bfe1a57af0 100644
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


