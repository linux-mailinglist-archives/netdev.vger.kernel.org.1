Return-Path: <netdev+bounces-302794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WBI7KmK+Qmq6AQoAu9opvQ
	(envelope-from <netdev+bounces-302794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E06DE234
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=VKRF68oQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302794-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302794-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A169A300360B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C0B4219E1;
	Mon, 29 Jun 2026 18:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC51397342
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759006; cv=none; b=WVZ3FmkOyTLfxnfJvGv8CAqEX+HsF09fU4vfWRGTmjFtrrBmc+fDlRUmpBBsimCPLLBLAwXoC0bfnIdgITmBMlFA6iPVEXQHnvY7pp/6ku8yffdrozhSBS0RSq8cdYKV2gdoGbeOfPIRS9faptutOlnOstcWSqdEii+4j8zMQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759006; c=relaxed/simple;
	bh=N9phANCuLzO7ILq2T/Sh69NM4wAQSM8C1G4EDiU+hlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBbE/QlYFEMlm06X08ciO/CUiqs2Ggf8iG6JWHre4GE/6JfDsSVJMPnK3d/hbLsq16SBxkUqA0s6QyRMztBsJME3r0moee8JByNYKvaitHfcLSVMr2w2si6OTNFCr+YM1ybhV0JRy3QvTC0n8DC5yWqiSIGbHcTWq13WbW3dRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VKRF68oQ; arc=none smtp.client-ip=209.85.217.100
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-6cf48482ddeso1252946137.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759004; x=1783363804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDTeO85AST2V8EHIEyHEFUN5UtWmoFmyT5msHpaa+ug=;
        b=s2Dgu3MgHDt5OJXbF2v1hyxSRVmVuQRb9WsNSsU8EWTfW/CPh916zPU19mH69bqCCp
         wBVoam2XScl1U7naTNcmYDlMw3WhdO5jSQGjJp4rJn16HUDm+iMttx46DIqs9qfHDzr0
         QQG+nCYMgsevuCNOW34RzwfBSPWf+v0pr3Ho7ZNYczwfzUGPnKUu5rX1mO4i6942qRHJ
         0GZCpD9VGnXgsXg4o8L5YjnMFMi25QaBeiN9ZI7k/d1OBS3yLspXMziki4w2RveatROf
         JxpmaVzHwBbBKonQgSDibdZQOaA3i7qtVoVxqPLDsiDzR+E7Up8YhzjEun9pF9DUL6Sr
         dizw==
X-Gm-Message-State: AOJu0YyWrwn6pIAuUKhdIylfEzCJeNjvsA8WzX+WsJ1kJ9D4ksG0pZH4
	9dlp+HTBXwUzGc0+5qVCvrXESynLCfPWjyx+osjUpjqBBUHWSlqa/SXckKjcYBBaQUpxHH3DBZG
	ibxjfycHPQh81qGUccqBhiZ5WSkE0xsYjtmkfigjo+JjPUiYbTuOgRElX4ad/ojhYDqGTE7LCxF
	ps7YLUR5nax6flAOgPPOO/FLaDXwg5S6jce91vMdBii6bj/SHuSmfIzu9iafbeCcx/MbGeRnfxW
	BNA+g549tQ=
X-Gm-Gg: AfdE7cluSkChqDxLqD+ufPb478zMWPOj2Vf1vAyQx1etghzm0M7ZqDjmsmS1A/Og7Wh
	cWf/JUBSGgkAS4wMBI2hnARq3GwcqkygdBVuAL8HLmbsb6mhqRHzwicy1O+sr6KaIhAU2jNGXDJ
	4m4tSVeT81P8gtfG9j4iN5C/6k+Dsdy56GTXbU9Or6ecDFUyCh14rPeDk542SwQDdUtfmuE6gFo
	9eTJoXxa70F0oKbukTgIISdGWyeEQM7YIjWvFugd2n9VvO0CKET1PSTUMPfn21ODz1aJBjhh+eM
	xA4tBFvLV+KoVLb62Qc08Wx9iQjfSVXpK0TCE2lTLyFqk4EprIrWSIN6+YgjsEBwU7E4jSHdbfa
	DGjkQJvFD7rLXoTsMrIGB5/CjkNTugcRJHQvpM2esgHidLPaR9/LkWIg+p4YUVx4gXq9Yeu+3Zs
	Roddx/I80RWtpqcLWFcYbtNKjMYJBopZAoGemRtoS1Iu1Wow==
X-Received: by 2002:a05:6102:4414:b0:62f:522f:5b2a with SMTP id ada2fe7eead31-73a38a368bdmr541889137.22.1782759003565;
        Mon, 29 Jun 2026 11:50:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-737d21faa97sm525605137.14.2026.06.29.11.50.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8b0a08d2so41829451cf.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759002; x=1783363802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDTeO85AST2V8EHIEyHEFUN5UtWmoFmyT5msHpaa+ug=;
        b=VKRF68oQ6Cw58i6cwhzMSA1vdd/6ymhilJi0QQGI+rrxNCazO3KfJW4wD8Y5dUKyVf
         DdanIhOErKCLUCzDkWsBZ9EMUdC15YYcrrt+4NAW7zXq+CEqNuuhdeAJ+pdi4+hp76vc
         jMWlkr7/JaCzF1lwO3ciWSBdVmLWdijj9IhTo=
X-Received: by 2002:a05:622a:4d0:b0:51c:20:aea7 with SMTP id d75a77b69052e-51c10713c0emr8094631cf.9.1782759002263;
        Mon, 29 Jun 2026 11:50:02 -0700 (PDT)
X-Received: by 2002:a05:622a:4d0:b0:51c:20:aea7 with SMTP id d75a77b69052e-51c10713c0emr8094191cf.9.1782759001742;
        Mon, 29 Jun 2026 11:50:01 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:01 -0700 (PDT)
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
Subject: [PATCH net-next v4 01/15] bnxt_en: Add Midpath channel information
Date: Mon, 29 Jun 2026 11:49:07 -0700
Message-ID: <20260629184921.3496727-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629184921.3496727-1-michael.chan@broadcom.com>
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302794-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 685E06DE234

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
index f0bac0dd1439..b33b66f038b8 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -255,6 +255,15 @@ config BNXT_HWMON
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
index 7513618793da..8faab85d66d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -76,6 +76,7 @@
 #include "bnxt_hwmon.h"
 #include "bnxt_gso.h"
 #include <net/tso.h>
+#include "bnxt_mpc.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9943,6 +9944,11 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
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
@@ -16547,6 +16553,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
@@ -17218,6 +17225,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
 	bnxt_free_crash_dump_mem(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6335dfc14c98..77b1748d12d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2452,6 +2452,8 @@ struct bnxt {
 
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


