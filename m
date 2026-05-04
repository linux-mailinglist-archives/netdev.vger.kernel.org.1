Return-Path: <netdev+bounces-284105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKgkLMUz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 531CF4C513D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6DF3057756
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380703FF8AA;
	Mon,  4 May 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GsJ0ywqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602263FFAB5
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939171; cv=none; b=T7OrxGYhYkfvoOPhmEdwsgWLImDWyQo2MsAhhupiZ5Fm+b3JVaOozJCcuula09DoS5iY+ZBHkKrLkg2hpnwTzJi6meLPi6WbbyvPUmaP5BoWeTeebNLAyeqYvAc+QMkR0xraQiKuF7lFwpN2VuHiPKBnXpRKoBAeSHPD2LWLoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939171; c=relaxed/simple;
	bh=KqgGP8686NEGrWHgIuZNwANQSsvDkVeGraKwGD4c5j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8cZBE9AmDaRGRCVoig/yiODEJm/UcTph3rasBOKl7jhQ33GGzVyRlPwIN6+T1eDYGUfjMF1Vm8iBbNspAJ5b0JRtnsCJJA32EDmBxgl12TZrE4iRX0Wn4DclgAbWuuUJr4vFtaVoBU6mvnmp1MLYUhEIaGdORJm7KROlhmyzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GsJ0ywqY; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-512f09ecc67so10752311cf.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939168; x=1778543968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tb8AgKhwdpa5EAdkQc/FJLfPUvUqCgu+Y7+lJJ77FD8=;
        b=Jl2h7bIJ7mPf7cmmlbTS1uSEuIpg8xCRaNw3eSKxXXii25uT7AZBW3XAGP8SiHFHqG
         tLs4BoDagc7X0d+yFHbZTKgMxlDbGIJ3diQCb8mr9KcTN4lyTQ6mW5DWKwkg15v6idwO
         /ZohEl7k8uTbDnQOusKbh8R5pPBBGXHpTmoRo8vqJhc2XmLJEkrxo+YdXoPMMQ5BtTqF
         aGdOMDkuQSEu6qJEV/NUGdUeePN6dp26JLHO49BGKTFV+IIHJLix4c57qWPXCqQblV/y
         xHf3tGahZ2Tp/MfHd+y8W4O08Z7RewMhbbzjGRWl4fdrR5Tl0K6lPMHyeI3AyG1q+PAw
         /a5w==
X-Gm-Message-State: AOJu0Yw+/PezZUo24+MB2WwQZqQyevbbzOD0VbIfMsm3w5yp3tvQCrCq
	2y/NRSLtRGZv+qO6tiHiYC78GRCcDM1mh2T/JS5lGVSn29jEaBuCwZ+2Eb1lStJDpRGhB/K3FRP
	RgL/ol4Lb8B02RHTJOFtijsYF/aVudrnMZMfV7MH1pcshNNEthaB0rsYZymUn0KfSlVcltDUiP/
	Mc0yZ3NokJPTCjgQdSgvUcIxuu7W7GWVIzjgslxDGO7oUzywAPZR2zIOJRarUnI+mSvHB7zKiS/
	9H4MdUN5OM=
X-Gm-Gg: AeBDieu/BJG0KPhzdUnOx7oCOLoex47l1yEFWJNg+FsZpaFP4OE4Uydr2TqjplWV8mT
	SAmh9Tq43erdy4F5Woq+lBwDzZW1AQP//eV2sD0A+amK49GDbkTskTZ9B1xx1J25nF8nJix7+qf
	qaLKEe47mFEyxmxxQbbePHM1lR1cx77cbcwHbsjxKPWzv4TfgszappRwlFGEnRverGv2JW8wI6G
	YM89l+UlwbmoY9eqH+63AnvnX5+6ipex/VyfjITUyZVXzFfof07TVEAoMiWERuTi22sWov32zRH
	2EXjuwYYX4NuSzonFVNlaRj1ifgATcK4HaxxsPX4Th1Ktz7OViA+aGZyDIkaZbie2jwbdgmr7Ke
	kraRZy/qGtz5JetJxu9iobn+PwtZmxfxov9Mo1lV+JizCSMCy65Wl6MmkY+N0FDoqlQ69qcbiPz
	gYNGb0nhRMkviKixds9u/4CMxpA2wx7HhuML+QKzEfTDUXUD2dz87wq9qlo6kteIxHNzs=
X-Received: by 2002:a05:622a:4d99:b0:50d:83d7:686c with SMTP id d75a77b69052e-5104bf98d55mr180997861cf.31.1777939168044;
        Mon, 04 May 2026 16:59:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b537e7c84csm10520516d6.1.2026.05.04.16.59.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8acb26fbbb2so75450646d6.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939166; x=1778543966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb8AgKhwdpa5EAdkQc/FJLfPUvUqCgu+Y7+lJJ77FD8=;
        b=GsJ0ywqYt3V7WbMozKJ0erg2jqyVAJYFgfWaU6sk6ThkefDO3SMAqjlOV9Dm7WXKvR
         mzO6fkObRedIlsPtSjg8PAz85YSeIU9Alu8I4zp9yoaBwMcIBinPVPNheKL1Ohf6LLm4
         L0ildRVXeb67lBnRZiydPHwDHQcTxbjAATcos=
X-Received: by 2002:a05:6214:301c:b0:8a7:1498:5f67 with SMTP id 6a1803df08f44-8b6667dff8fmr196411276d6.18.1777939166061;
        Mon, 04 May 2026 16:59:26 -0700 (PDT)
X-Received: by 2002:a05:6214:301c:b0:8a7:1498:5f67 with SMTP id 6a1803df08f44-8b6667dff8fmr196410996d6.18.1777939165586;
        Mon, 04 May 2026 16:59:25 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:24 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 07/15] bnxt_en: Allocate crypto structure and backing store
Date: Mon,  4 May 2026 16:58:28 -0700
Message-ID: <20260504235836.3019499-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260504235836.3019499-1-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 531CF4C513D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284105-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

If the chip and firmware support crypto (TLS) offload, allocate a
bp->crypto_info software structure and backing store to support the RX
and TX contexts.  Each offloaded TLS connection requires a backing
store context for each direction.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 78 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 47 +++++++++++
 include/linux/bnxt/hsi.h                      | 37 +++++++++
 6 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 0506574c007a..3acdb81fa958 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,4 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
-bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d81f96e7894d..225edc6fd1c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -77,6 +77,7 @@
 #include "bnxt_gso.h"
 #include <net/tso.h>
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9367,6 +9368,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
@@ -9374,6 +9376,19 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 	int rc = 0;
 	u16 type;
 
+	if (crypto) {
+		ctxm = &ctx->ctx_arr[BNXT_CTX_TCK];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+					     BNXT_TCK(crypto).max_ctx, 1);
+		if (rc)
+			return rc;
+		ctxm = &ctx->ctx_arr[BNXT_CTX_RCK];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm,
+					     BNXT_RCK(crypto).max_ctx, 1);
+		if (rc)
+			return rc;
+		last_type = BNXT_CTX_RCK;
+	}
 	if (mpc && mpc->mpc_chnls_cap) {
 		ctxm = &ctx->ctx_arr[BNXT_CTX_MTQM];
 		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
@@ -9916,6 +9931,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
 		bp->flags |= BNXT_FLAG_TX_COAL_CMPL;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_KTLS_SUPPORTED)
+		bnxt_alloc_crypto_info(bp, resp);
+	else
+		bnxt_free_crypto_info(bp);
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
@@ -16546,6 +16565,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
@@ -17225,6 +17245,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 72a0b511b7e9..f6ff55015ad0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2460,6 +2460,7 @@ struct bnxt {
 	u8			tph_mode;
 
 	struct bnxt_mpc_info	*mpc_info;
+	struct bnxt_crypto_info	*crypto_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
new file mode 100644
index 000000000000..a5fee08eaa67
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_crypto.h"
+
+static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
+{
+	u32 fw_maj = BNXT_FW_MAJ(bp);
+
+	if (key_type == BNXT_TX_CRYPTO_KEY_TYPE)
+		return (fw_maj < 233) ? BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW :
+		       BNXT_MAX_TX_CRYPTO_KEYS;
+
+	return (fw_maj < 233) ? BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW :
+	       BNXT_MAX_RX_CRYPTO_KEYS;
+}
+
+/**
+ * bnxt_alloc_crypto_info - Allocate and initialize crypto offload context
+ * @bp: pointer to bnxt device
+ * @resp: pointer to firmware capability response
+ *
+ * Allocates the main crypto info structure
+ *
+ * This function is called during device initialization when firmware
+ * reports crypto offload capability. If allocation fails, crypto offload
+ * will not be available but the device will still function.
+ *
+ * Context: Process context
+ */
+void bnxt_alloc_crypto_info(struct bnxt *bp,
+			    struct hwrm_func_qcaps_output *resp)
+{
+	u16 max_keys = le16_to_cpu(resp->max_key_ctxs_alloc);
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+
+	if (BNXT_VF(bp))
+		return;
+	if (!crypto) {
+		struct bnxt_kctx *kctx;
+		int i;
+
+		crypto = kzalloc_obj(*crypto);
+		if (!crypto) {
+			netdev_warn(bp->dev,
+				    "Unable to allocate crypto info\n");
+			return;
+		}
+		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+			kctx = &crypto->kctx[i];
+			kctx->type = i;
+			kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
+		}
+		bp->crypto_info = crypto;
+	}
+	crypto->max_key_ctxs_alloc = max_keys;
+}
+
+/**
+ * bnxt_free_crypto_info - Free crypto offload resources
+ * @bp: pointer to bnxt device
+ *
+ * Frees all resources associated with crypto offload
+ *
+ * Context: Process context during device shutdown/removal
+ */
+void bnxt_free_crypto_info(struct bnxt *bp)
+{
+	kfree(bp->crypto_info);
+	bp->crypto_info = NULL;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
new file mode 100644
index 000000000000..629388fe1e6d
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_CRYPTO_H
+#define BNXT_CRYPTO_H
+
+#define BNXT_MAX_TX_CRYPTO_KEYS		204800
+#define BNXT_MAX_RX_CRYPTO_KEYS		204800
+
+#define BNXT_MAX_TX_CRYPTO_KEYS_PRE_233FW	65535
+#define BNXT_MAX_RX_CRYPTO_KEYS_PRE_233FW	65535
+
+enum bnxt_crypto_type {
+	BNXT_TX_CRYPTO_KEY_TYPE = FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX,
+	BNXT_RX_CRYPTO_KEY_TYPE = FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX,
+	BNXT_MAX_CRYPTO_KEY_TYPE,
+};
+
+struct bnxt_kctx {
+	u8			type;
+	u32			max_ctx;
+};
+
+struct bnxt_crypto_info {
+	u16			max_key_ctxs_alloc;
+
+	struct bnxt_kctx	kctx[BNXT_MAX_CRYPTO_KEY_TYPE];
+};
+
+#define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
+#define BNXT_RCK(crypto)	((crypto)->kctx[BNXT_RX_CRYPTO_KEY_TYPE])
+
+#ifdef CONFIG_BNXT_TLS
+void bnxt_alloc_crypto_info(struct bnxt *bp,
+			    struct hwrm_func_qcaps_output *resp);
+void bnxt_free_crypto_info(struct bnxt *bp);
+#else
+static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
+					  struct hwrm_func_qcaps_output *resp)
+{
+}
+
+static inline void bnxt_free_crypto_info(struct bnxt *bp)
+{
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_CRYPTO_H */
diff --git a/include/linux/bnxt/hsi.h b/include/linux/bnxt/hsi.h
index 74a6bf278d88..03444b81beb0 100644
--- a/include/linux/bnxt/hsi.h
+++ b/include/linux/bnxt/hsi.h
@@ -3837,6 +3837,43 @@ struct hwrm_func_ptp_ext_qcfg_output {
 	u8	valid;
 };
 
+/* hwrm_func_key_ctx_alloc_input (size:384b/48B) */
+struct hwrm_func_key_ctx_alloc_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le16	fid;
+	__le16	num_key_ctxs;
+	__le32	dma_bufr_size_bytes;
+	u8	key_ctx_type;
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_TX      0x0UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_RX      0x1UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_TX 0x2UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX 0x3UL
+	#define FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_LAST   FUNC_KEY_CTX_ALLOC_REQ_KEY_CTX_TYPE_QUIC_RX
+	u8	unused_0[7];
+	__le64	host_dma_addr;
+	__le32	partition_start_xid;
+	u8	unused_1[4];
+};
+
+/* hwrm_func_key_ctx_alloc_output (size:192b/24B) */
+struct hwrm_func_key_ctx_alloc_output {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	__le16	num_key_ctxs_allocated;
+	u8	flags;
+	#define FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS     0x1UL
+	u8	unused_0;
+	__le32	partition_start_xid;
+	u8	unused_1[7];
+	u8	valid;
+};
+
 /* hwrm_func_backing_store_cfg_v2_input (size:512b/64B) */
 struct hwrm_func_backing_store_cfg_v2_input {
 	__le16	req_type;
-- 
2.51.0


