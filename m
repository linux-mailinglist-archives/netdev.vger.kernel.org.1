Return-Path: <netdev+bounces-306428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bejKKB10UGofzQIAu9opvQ
	(envelope-from <netdev+bounces-306428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E9F7371DF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=YEtcOhHL;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306428-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306428-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C8DE300D4D6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CDB36D9EB;
	Fri, 10 Jul 2026 04:25:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1536C5AC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657500; cv=none; b=XcS4jqPq8yAMCXheTlNmSSyyWRCIDiNCe8z2dVnYr2riw6GpOCwymfgWjWks2HaGzc9Ky2awV56yDqXuFvny4n6w0qs1I0ubPD9Cj95GoXUH8kavm9BQuysY0/bK7VuzikiB6/6edFdEW8l0fciZ4H2FG6Bh+opJdM0fqQFu0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657500; c=relaxed/simple;
	bh=6QmovLqmhqNteKcBNanYYBSfTe9ZpJs6/I4ixZTGm44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyBAa6rbqpWdKO1AdeTsmuyvj2Sl/MoUVquHPduDttSdWg+KkwtY5XbFIErxc0ujivHbiQ+/VF8gE5fOJmb7U4BPc0N0iddGYbZXJDKjHTBa1RNYG5abzT7xUySnxkng8cLI+TsdvTE2Eeq2VD5yITRAqmHrgi4Xv2YSLpt8yeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YEtcOhHL; arc=none smtp.client-ip=209.85.210.97
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7e6b554044fso498177a34.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657497; x=1784262297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Ni5Jky59scPxGj1v36Vbs4Nnd7O7RO3UHFfw5+KmRw=;
        b=aeA6vq5PLqEiQdkvN5dsvVq3lpBsUIggqFPgwwrnXlTrB0wa9G4ahLxE+PC1fARCvA
         JsgwxXeWGd2r8iF01ZyLSzsuqbjmio46hxix9h/NiHo2W1KvKsmA6bZT9skUdZS6ZlXc
         Wth4bovMMv4fPVdZhXs60xNeFmkEX+V16t46Mp7VSBOkR6zjqtQoH7gAR0Hiry02G0p9
         Op/rF50lrsxzVTwovdK8bosUWBP0MK1zjohe/sHRYCW0w1sNuxtSfpTQPjFni3A1ePhg
         uuiT4q12p370lBflyGV4wlcyw6nslbIz3+1HxDCcxcBwYk6bCQERMPvRMYm62d8lHWxh
         UvJQ==
X-Gm-Message-State: AOJu0YwDsvAhLX3rZQtyzB0lF1BqStsh5sdsIBeDT/Rd+JDzTSsxuS4c
	InuWjz/lyR0qEokqqsJpLYVyUnnQ1IZ5cCnFoxlQjTMQKqRFOgvgkEFVFtGJgb25EUWMZEPnQlZ
	y3GyFaoADAVWHke7u+mhHzya5IF16oRLjfFs85sv7+7qWgsrFn4ICD9vogNVWczxdWaDwfTixS1
	GQHGgadqRU5HtaeMw3GEkFDVvecL44RIpQeIWLajrg9Q3HvpUm7X8ar35mqRvNZ4PIt5ztC6Djr
	y625dr1eSM=
X-Gm-Gg: AfdE7clC4KZsRVFLzqsCXek5BL41NWPIbns2GAuVuwhu6ZhSt2yEidMi8mKxq8enz/t
	frhqAgiC6Up2kLtuyHhAYfMIULRoo6dM2opZSo1NG6dfs3NKAciD3b5hEA0BoCwBTJLbbJvn3iq
	bWlmEH80TUOfAbmZoKsWoidmcXJNi5IrhiwJxUd5TFB0tee6BK8m+E1ZnyuMcL4UTMiv6rpkP74
	RALDuC+LQQQ2xbzbo25posnT4u9I+lEQPMF+Y2k1yvUQATaeVwHLUPq/rCHEpE7PIyfP/iDFARc
	UyyGtl/MwkIoe1JupXh/uH0ASjDt7QTQr6DizQz6W+FdFPQENjspF+XvxAkCspbN5XGHQQnGjuU
	zmDNZbPyDQhnseltEZpi47fEPWuUHOrBDNhwFTQ3oxUXqt1dVW1mJHXbLH0+9WXvuxx4jZ+l7Lz
	qLbTvqbbo5n8kJCc5RwJNvPe1dw4wqv5peRMcv3bmNtXShcQ==
X-Received: by 2002:a05:6830:82e3:b0:7eb:3af8:8c09 with SMTP id 46e09a7af769-7ebd00cf7afmr7412099a34.3.1783657497088;
        Thu, 09 Jul 2026 21:24:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ebcb1db1d7sm454769a34.7.2026.07.09.21.24.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38827cee19eso658082a91.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657494; x=1784262294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Ni5Jky59scPxGj1v36Vbs4Nnd7O7RO3UHFfw5+KmRw=;
        b=YEtcOhHLDfabkRD7odiAusHlNngsiuWm3mI03YHIjO79UFdzn525uN75mJlO3TFvce
         2yOpTpdotmYKFgZdQI8T/xxq73pvctM3SpTPPak1Nuw7EJ47/u1hP0eo5eNs0HUIjDcQ
         5i2RxcYBz5CpSuTbtdOiZnuFxUlZI3Txb5jBo=
X-Received: by 2002:a17:90b:584e:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-3893f694d3amr9206914a91.2.1783657494508;
        Thu, 09 Jul 2026 21:24:54 -0700 (PDT)
X-Received: by 2002:a17:90b:584e:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-3893f694d3amr9206890a91.2.1783657494032;
        Thu, 09 Jul 2026 21:24:54 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:52 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 07/15] bnxt_en: Allocate crypto structure and backing store
Date: Thu,  9 Jul 2026 21:23:52 -0700
Message-ID: <20260710042400.3996847-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306428-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30E9F7371DF

If the chip and firmware support crypto (TLS) offload, allocate a
bp->crypto_info software structure and backing store to support the RX
and TX contexts.  Each offloaded TLS connection requires a backing
store context for each direction.

bp->crypto_info will stay persistent even if kTLS is no longer
supported after a FW reset.  This makes it easier to avoid NULL
dereference of bp->crypto_info during FW reset and kTLS offload
race conditions.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
Clear BNXT_FW_CAP_KTLS in bnxt_free_cryto_info()

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-8-michael.chan@broadcom.com/

bp->crypto_info and bp->ktls_info now stay persistent for the driver's
lifetime.  max keys are refreshed after re-init.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-8-michael.chan@broadcom.
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 83 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 47 +++++++++++
 include/linux/bnxt/hsi.h                      | 37 +++++++++
 6 files changed, 193 insertions(+), 1 deletion(-)
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
index e68b970bf21b..b663824cb559 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -77,6 +77,7 @@
 #include "bnxt_gso.h"
 #include <net/tso.h>
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -9376,6 +9377,7 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
@@ -9383,6 +9385,19 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 	int rc = 0;
 	u16 type;
 
+	if (BNXT_SUPPORTS_KTLS(bp)) {
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
@@ -9925,6 +9940,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
 		bp->flags |= BNXT_FLAG_TX_COAL_CMPL;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_KTLS_SUPPORTED)
+		bnxt_alloc_crypto_info(bp, resp);
+	else
+		bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 
 	flags_ext2 = le32_to_cpu(resp->flags_ext2);
 	if (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_RX_ALL_PKTS_TIMESTAMPS_SUPPORTED)
@@ -16613,6 +16632,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->ptp_cfg = NULL;
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
@@ -17296,6 +17316,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
+	bnxt_free_crypto_info(bp);
 	bnxt_free_mpc_info(bp);
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 416ae86111fa..621f275b49fd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2461,6 +2461,7 @@ struct bnxt {
 	u8			tph_mode;
 
 	struct bnxt_mpc_info	*mpc_info;
+	struct bnxt_crypto_info	*crypto_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
@@ -2548,6 +2549,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 	#define BNXT_FW_CAP_PTP_PTM			BIT_ULL(44)
+	#define BNXT_FW_CAP_KTLS			BIT_ULL(45)
 
 	u32			fw_dbg_cap;
 
@@ -2573,6 +2575,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
 #define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
 	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
+#define BNXT_SUPPORTS_KTLS(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_KTLS)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
new file mode 100644
index 000000000000..5bc31ee8d7fd
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -0,0 +1,83 @@
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
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (BNXT_VF(bp))
+		return;
+	if (!crypto) {
+		crypto = kzalloc_obj(*crypto);
+		if (!crypto) {
+			netdev_warn(bp->dev,
+				    "Unable to allocate crypto info\n");
+			return;
+		}
+		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+			kctx = &crypto->kctx[i];
+			kctx->type = i;
+		}
+		bp->crypto_info = crypto;
+	}
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
+	}
+	crypto->max_key_ctxs_alloc = max_keys;
+	bp->fw_cap |= BNXT_FW_CAP_KTLS;
+}
+
+/**
+ * bnxt_free_crypto_info - Free crypto offload resources
+ * @bp: pointer to bnxt device
+ *
+ * Frees all resources associated with crypto offload.  Call this function
+ * only when it is idle with nothing in-flight.
+ *
+ * Context: Process context during device shutdown/removal
+ */
+void bnxt_free_crypto_info(struct bnxt *bp)
+{
+	kfree(bp->crypto_info);
+	bp->crypto_info = NULL;
+	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
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


