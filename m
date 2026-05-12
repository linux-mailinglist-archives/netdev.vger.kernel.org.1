Return-Path: <netdev+bounces-287320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KaZHdOaA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:25:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3F52A3E8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B55307A3A0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9103803F7;
	Tue, 12 May 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OHjfFfuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD02D7BF
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620922; cv=none; b=RcWgjB5JKtrAQhjlEzJauYpEJBAfoVm6xWptpQJxdmUubwKtFEzkxrpByOQBAGnuDRskV5CpIEQziLabEtdrS9V9XHdt6b7fqBUa1KCX1iFDU3ipNbLFMYPqH2FFj8i5O7tSd56pqHZyw2UVOvJlx5wAAt4UzHYQuVB8OEomtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620922; c=relaxed/simple;
	bh=K6AGm4Ng2nd8kyfW3OG/nDq9thy585ulQhaNgTAFXDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOzE0mUIMJkYBCrMilDbJeHwBE7+ncyViWP/P5yjFxjk7qAaGyAU8PIt6RmCllj95tKHbi/CgJGkk88fGqrHt4RLJbffE1dzOTVyFf5c6zRaKReAsmbM7JJGZx5qqZ517bR8INPoPm+YsZJ5pBwj5pz8RR58ARJlicAabMyu5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OHjfFfuJ; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-57513a91514so1931948e0c.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620919; x=1779225719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmp2c9U5mVR3uGfOQENdi1jjJHd8+2P7ECgWsJM2RHM=;
        b=j6OK81kDZf8N00fzOkG74ZUVchXw4KFmA/O7mMdoIh2FbjG/b/HUGDZ92SD+agO8vE
         bRja1Ps+/BacFoaJAUMfWVCVfh13gj4y/byi4vf8Gg0F93rXJJIgm5xr2g28GCEX9DRN
         rISjbeL9RUXNRJtCJqAG71+yqLc7UPlyvCbFXrWok7D+0hkDhL22WMncQdlUMS8P7fdC
         HBQEAZZbnVe1ZB3FvlrAjzFGbzXLkb1mgUGowBtbgXZ12cHBysRPrM2RYD8c3ch6JAcQ
         uAWuWsCxchuxHuYB9UCY/ytyEQyaUhPc0RLI2mYOvMJme8d027QGn5w60i5+Z3AZjaDV
         Iqpw==
X-Gm-Message-State: AOJu0YyJjtB6QcUWPzuMr+db+ZXpvpyWnNsn5YKWFmUrW+QlH0rH9jCB
	DbJW0Vb65Joh/9pgb+CPIofe+oaeI3TohMz0fJ37weDG2f2RqCTUbqcafkg7PQAYZ4Jra3Tb0nm
	9MbaGAxA7QWD3WkyLYuC0/CFPFPy0pLO3BCXDaW1ds1YxhkA8FytyVseu9Ja5UYbCXclSMAOl5K
	e48Se8H7wvFkhoziwNMbXfuMpTmp7hWtK9d2aInHvxegtHZovr9ROMJ7RNQSBQsNVWLfyF+jPjo
	EO0glwWhvw=
X-Gm-Gg: Acq92OHxswwfK9sejcG4c+Q1Cgui2N0qSoiK/zJARKFvisC9rN6pX0lbUyl0mHyFvYY
	+0/QVW6oNALW0SLRtuqzj8sJ8jqVqv5CGQ1ljd77jBSqax7GMTDWtzXSEgqs0FuzV9OYeOyMg6/
	CQ11k0p4cIEGvDjiFj0v8XzZUcUOxwfyYFcJr30VpdkzUlaL7T6GMZ3exKOPly7twYv3t2mUYv0
	2R8SAGHZeXRwEgElXdWQ4/CiU5Eao5IlRW5O73/qWMrfVvBfBnNCRm7/p0PNA3wrg3aGVesKmPd
	qp2pp+NCvGX+V8yK51jfVBbkYOVs47E743eRJmVKC8fIdTtmmRUFtjOwgXBLSNjfLFGN3u42apJ
	LkKtuuG1sYO1ajUuJttPCYLhMNEhqGn9hnW7/hHaKnBT/0cZsfcDelv7hj5f3RI1DiU4OOOVOh2
	xafMWb
X-Received: by 2002:a05:6122:d29:b0:56e:e68e:9fc2 with SMTP id 71dfb90a1353d-575e7165099mr185291e0c.10.1778620919241;
        Tue, 12 May 2026 14:21:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-575b1f998f4sm861283e0c.1.2026.05.12.14.21.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-132d5ad9c32so15511823c88.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620916; x=1779225716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmp2c9U5mVR3uGfOQENdi1jjJHd8+2P7ECgWsJM2RHM=;
        b=OHjfFfuJsQyK9/bRGDt5qSaxL4CuW/kt2z/NrrMr9bbXnzatZ6QTs/o0Cdhr5OS8WW
         0R2Kil460c+LpD+eqg11WIewxdGNGZrvHhC5Ct0gdYM2coROPPqLHpeCwsZ8F4LNobni
         xWXvykMIzhMOaOQQ+lFlmo4PmWgvH6ff06pco=
X-Received: by 2002:a05:7022:420:b0:12a:7181:2f1c with SMTP id a92af1059eb24-1343193eb67mr391713c88.17.1778620915963;
        Tue, 12 May 2026 14:21:55 -0700 (PDT)
X-Received: by 2002:a05:7022:420:b0:12a:7181:2f1c with SMTP id a92af1059eb24-1343193eb67mr391686c88.17.1778620915276;
        Tue, 12 May 2026 14:21:55 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:53 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 12/15] bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
Date: Tue, 12 May 2026 14:21:02 -0700
Message-ID: <20260512212105.3488258-13-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: E2A3F52A3E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287320-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add basic infrastructure to allocate and free kTLS context IDs (KIDs)
to support kTLS TX offload.  To offload a connection in .tls_dev_add(),
the first step is to allocate a KID.  After that the kTLS offload
command is sent to the HW via MPC using the function
bnxt_xmit_crypto_cmd() introduced in the last patch.

In .tls_dev_del(), we send the delete command to the HW using the
same bnxt_xmit_crypto_cmd().  After that we free the KID, making it
available for new offload.

bnxt_ktls_init() assigns bnxt_ktls_ops to the netdev and sets up
the TLS TX offload feature.  bnxt_ktls_init() will be called in
the next patch.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
Fix unused variable warning
Fix error recovery issues

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-13-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  |  65 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 289 ++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    |  90 ++++++
 7 files changed, 463 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 3acdb81fa958..88e68248aad4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -5,4 +5,4 @@ bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
-bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o
+bnxt_en-$(CONFIG_BNXT_TLS) += bnxt_mpc.o bnxt_crypto.o bnxt_ktls.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 74935b119569..e26980814fe7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -78,6 +78,7 @@
 #include <net/tso.h>
 #include "bnxt_mpc.h"
 #include "bnxt_crypto.h"
+#include "bnxt_ktls.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -13411,7 +13412,8 @@ static int bnxt_open(struct net_device *dev)
 static bool bnxt_drv_busy(struct bnxt *bp)
 {
 	return (test_bit(BNXT_STATE_IN_SP_TASK, &bp->state) ||
-		test_bit(BNXT_STATE_READ_STATS, &bp->state));
+		test_bit(BNXT_STATE_READ_STATS, &bp->state) ||
+		bnxt_ktls_busy(bp));
 }
 
 static void bnxt_get_ring_stats(struct bnxt *bp,
@@ -13491,6 +13493,7 @@ static int bnxt_close(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
+	bnxt_crypto_del_all(bp);
 	bnxt_close_nic(bp, true, true);
 	bnxt_hwrm_shutdown_link(bp);
 	bnxt_hwrm_if_change(bp, false);
@@ -14567,6 +14570,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 			bp->fw_reset_min_dsecs = 0;
 		bnxt_fw_fatal_close(bp);
 	}
+	bnxt_crypto_del_all(bp);
 	__bnxt_close_nic(bp, true, false);
 	bnxt_vf_reps_free(bp);
 	bnxt_clear_int_mode(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fc9fec10e753..a947b9420a7a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2474,6 +2474,7 @@ struct bnxt {
 
 	struct bnxt_mpc_info	*mpc_info;
 	struct bnxt_crypto_info	*crypto_info;
+	struct bnxt_tls_info	*ktls_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 2cacce28676d..6e424eb80630 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -11,6 +11,7 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_mpc.h"
+#include "bnxt_ktls.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -78,6 +79,8 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		bp->crypto_info = crypto;
 	}
 	crypto->max_key_ctxs_alloc = max_keys;
+	if (!bp->ktls_info)
+		bnxt_alloc_ktls_info(bp);
 	return;
 
 alloc_err:
@@ -85,6 +88,67 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 	bp->crypto_info = NULL;
 }
 
+int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct ce_delete_cmd cmd = {};
+	u32 data;
+
+	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state) &&
+	    test_bit(BNXT_STATE_FW_FATAL_COND, &bp->state))
+		return 0;
+
+	txr = bnxt_select_mpc_ring(bp, type);
+	if (!txr)
+		return -ENODEV;
+	if (kind == BNXT_CTX_KIND_CK_TX)
+		data = CE_DELETE_CMD_CTX_KIND_CK_TX;
+	else if (kind == BNXT_CTX_KIND_CK_RX)
+		data = CE_DELETE_CMD_CTX_KIND_CK_RX;
+	else
+		return -EINVAL;
+
+	data |= CE_DELETE_CMD_OPCODE_DEL |
+		(BNXT_KID_HW(kid) << CE_DELETE_CMD_KID_SFT);
+
+	cmd.ctx_kind_kid_opcode = cpu_to_le32(data);
+	return bnxt_xmit_crypto_cmd(bp, txr, &cmd, sizeof(cmd),
+				    BNXT_MPC_TMO_MSECS);
+}
+
+static void bnxt_crypto_del_all_kids(struct bnxt *bp, struct bnxt_kid_info *kid)
+{
+	int i, rc;
+
+	for (i = 0; i < kid->count; i++) {
+		if (!test_bit(i, kid->ids)) {
+			rc = bnxt_crypto_del(bp, kid->type, kid->kind,
+					     kid->start_id + i);
+			if (!rc)
+				set_bit(i, kid->ids);
+		}
+	}
+}
+
+void bnxt_crypto_del_all(struct bnxt *bp)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_kid_info *kid;
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (!crypto)
+		return;
+
+	/* Shutting down, no need to protect the lists. */
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		list_for_each_entry(kid, &kctx->list, list)
+			bnxt_crypto_del_all_kids(bp, kid);
+		kctx->epoch++;
+	}
+}
+
 /**
  * bnxt_clear_crypto - Clear all crypto key contexts
  * @bp: pointer to bnxt device
@@ -132,6 +196,7 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 {
 	struct bnxt_crypto_info *crypto = bp->crypto_info;
 
+	bnxt_free_ktls_info(bp);
 	if (!crypto)
 		return;
 	bnxt_clear_crypto(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index 58e52516d932..232577a12169 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -40,7 +40,7 @@ struct bnxt_kctx {
 	wait_queue_head_t	alloc_pending_wq;
 };
 
-#define BNXT_KID_HW_MASK	0xffffff
+#define BNXT_KID_HW_MASK	0x0fffff
 #define BNXT_KID_HW(kid)	((kid) & BNXT_KID_HW_MASK)
 #define BNXT_KID_EPOCH_MASK	0xff000000
 #define BNXT_KID_EPOCH_SHIFT	24
@@ -141,6 +141,8 @@ struct bnxt_crypto_cmd_ctx {
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
+int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid);
+void bnxt_crypto_del_all(struct bnxt *bp);
 void bnxt_clear_crypto(struct bnxt *bp);
 void bnxt_free_crypto_info(struct bnxt *bp);
 void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
@@ -160,6 +162,15 @@ static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 {
 }
 
+static inline int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bnxt_crypto_del_all(struct bnxt *bp)
+{
+}
+
 static inline void bnxt_clear_crypto(struct bnxt *bp)
 {
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
new file mode 100644
index 000000000000..ac5d927ded1c
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#include <net/tls.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
+#include "bnxt_ktls.h"
+
+/**
+ * bnxt_alloc_ktls_info - Allocate and initialize kTLS offload context
+ * @bp: pointer to bnxt device
+ *
+ * Allocates the main kTLS crypto info structure
+ *
+ * This function is called during device initialization when firmware
+ * reports kTLS offload capability. If allocation fails, kTLS offload
+ * will not be available but the device will still function.
+ *
+ * Context: Process context
+ *
+ * Return: zero on success, negative error code otherwise:
+ *	ENOMEM: out of memory
+ */
+int bnxt_alloc_ktls_info(struct bnxt *bp)
+{
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+
+	if (BNXT_VF(bp))
+		return -EOPNOTSUPP;
+	if (ktls)
+		return 0;
+
+	ktls = kzalloc_obj(*ktls);
+	if (!ktls) {
+		netdev_warn(bp->dev, "Unable to allocate kTLS info\n");
+		return -ENOMEM;
+	}
+	ktls->counters = kzalloc_objs(*ktls->counters,
+				      BNXT_KTLS_MAX_CTRL_COUNTERS);
+	if (!ktls->counters)
+		goto ktls_err;
+
+	bp->ktls_info = ktls;
+	return 0;
+
+ktls_err:
+	kfree(ktls->counters);
+	kfree(ktls);
+	return -ENOMEM;
+}
+
+/**
+ * bnxt_free_ktls_info - Free kTLS crypto offload resources
+ * @bp: pointer to bnxt device
+ *
+ * Frees all resources associated with kTLS crypto offload
+ *
+ * Context: Process context during device shutdown/removal
+ */
+void bnxt_free_ktls_info(struct bnxt *bp)
+{
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+
+	if (!ktls)
+		return;
+	kfree(ktls->counters);
+	kfree(ktls);
+	bp->ktls_info = NULL;
+}
+
+/* Copy in reverse byte order */
+static void bnxt_copy_tls_mp_data(u8 *dst, u8 *src, int bytes)
+{
+	int i;
+
+	for (i = 0; i < bytes; i++)
+		dst[bytes - i - 1] = src[i];
+}
+
+static int bnxt_crypto_add(struct bnxt *bp, enum tls_offload_ctx_dir direction,
+			   struct tls_crypto_info *crypto_info, u32 tcp_seq_no,
+			   u32 kid)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct ce_add_cmd cmd = {0};
+	u32 data;
+
+	if (direction == TLS_OFFLOAD_CTX_DIR_TX) {
+		txr = bnxt_select_mpc_ring(bp, BNXT_MPC_TCE_TYPE);
+		cmd.ctx_kind = CE_ADD_CMD_CTX_KIND_CK_TX;
+	} else {
+		return -EOPNOTSUPP;
+	}
+	if (!txr)
+		return -ENODEV;
+
+	data = CE_ADD_CMD_OPCODE_ADD | (BNXT_KID_HW(kid) << CE_ADD_CMD_KID_SFT);
+	switch (crypto_info->cipher_type) {
+	case TLS_CIPHER_AES_GCM_128: {
+		struct tls12_crypto_info_aes_gcm_128 *aes;
+
+		aes = (void *)crypto_info;
+		data |= CE_ADD_CMD_ALGORITHM_AES_GCM_128;
+		if (crypto_info->version == TLS_1_3_VERSION)
+			data |= CE_ADD_CMD_VERSION_TLS1_3;
+		memcpy(&cmd.session_key, aes->key, sizeof(aes->key));
+		memcpy(&cmd.salt, aes->salt, sizeof(aes->salt));
+		memcpy(&cmd.addl_iv, aes->iv, sizeof(aes->iv));
+		bnxt_copy_tls_mp_data(cmd.record_seq_num, aes->rec_seq,
+				      sizeof(aes->rec_seq));
+		break;
+	}
+	case TLS_CIPHER_AES_GCM_256: {
+		struct tls12_crypto_info_aes_gcm_256 *aes;
+
+		aes = (void *)crypto_info;
+		data |= CE_ADD_CMD_ALGORITHM_AES_GCM_256;
+		if (crypto_info->version == TLS_1_3_VERSION)
+			data |= CE_ADD_CMD_VERSION_TLS1_3;
+		memcpy(&cmd.session_key, aes->key, sizeof(aes->key));
+		memcpy(&cmd.salt, aes->salt, sizeof(aes->salt));
+		memcpy(&cmd.addl_iv, aes->iv, sizeof(aes->iv));
+		bnxt_copy_tls_mp_data(cmd.record_seq_num, aes->rec_seq,
+				      sizeof(aes->rec_seq));
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+	cmd.ver_algo_kid_opcode = cpu_to_le32(data);
+	cmd.pkt_tcp_seq_num = cpu_to_le32(tcp_seq_no);
+	cmd.tls_header_tcp_seq_num = cmd.pkt_tcp_seq_num;
+	return bnxt_xmit_crypto_cmd(bp, txr, &cmd, sizeof(cmd),
+				    BNXT_MPC_TMO_MSECS);
+}
+
+static bool bnxt_ktls_cipher_supported(struct bnxt *bp,
+				       struct tls_crypto_info *crypto_info)
+{
+	u16 type = crypto_info->cipher_type;
+	u16 version = crypto_info->version;
+
+	if ((type == TLS_CIPHER_AES_GCM_128 ||
+	     type == TLS_CIPHER_AES_GCM_256) &&
+	    (version == TLS_1_2_VERSION ||
+	     version == TLS_1_3_VERSION))
+		return true;
+	return false;
+}
+
+static int bnxt_ktls_dev_add(struct net_device *dev, struct sock *sk,
+			     enum tls_offload_ctx_dir direction,
+			     struct tls_crypto_info *crypto_info,
+			     u32 start_offload_tcp_sn)
+{
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_crypto_info *crypto;
+	struct tls_context *tls_ctx;
+	struct bnxt_tls_info *ktls;
+	struct bnxt_kctx *kctx;
+	u32 kid;
+	int rc;
+
+	BUILD_BUG_ON(sizeof(struct bnxt_ktls_offload_ctx_tx) >
+		     TLS_DRIVER_STATE_SIZE_TX);
+
+	ktls = bp->ktls_info;
+	if (direction == TLS_OFFLOAD_CTX_DIR_RX)
+		return -EOPNOTSUPP;
+
+	if (!bnxt_ktls_cipher_supported(bp, crypto_info)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_INVALID_CIPHER]);
+		return -EOPNOTSUPP;
+	}
+
+	atomic_inc(&ktls->pending);
+	/* Make sure bnxt_close_nic() sees pending before we check the
+	 * BNXT_STATE_OPEN flag.
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_STATE_NOT_OPEN]);
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	crypto = bp->crypto_info;
+	tls_ctx = tls_get_ctx(sk);
+	kctx_tx = __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
+	rc = bnxt_key_ctx_alloc_one(bp, kctx, BNXT_CTX_KIND_CK_TX, &kid);
+	if (rc) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_KEY_CTX_ALLOC]);
+		goto exit;
+	}
+	rc = bnxt_crypto_add(bp, direction, crypto_info, start_offload_tcp_sn,
+			     kid);
+	if (rc) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_CRYPTO_CMD]);
+		goto free_kctx;
+	}
+	kctx_tx->kid = kid;
+	kctx_tx->tcp_seq_no = start_offload_tcp_sn;
+	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_ADD]);
+free_kctx:
+	if (rc)
+		bnxt_free_one_kctx(kctx, kid);
+exit:
+	atomic_dec(&ktls->pending);
+	return rc;
+}
+
+#define KTLS_RETRY_MAX	100
+
+static void bnxt_ktls_dev_del(struct net_device *dev,
+			      struct tls_context *tls_ctx,
+			      enum tls_offload_ctx_dir direction)
+{
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_crypto_info *crypto;
+	struct bnxt_tls_info *ktls;
+	struct bnxt_kctx *kctx;
+	int retry_cnt = 0;
+	u8 kind;
+	u32 kid;
+
+	ktls = bp->ktls_info;
+retry:
+	while (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		if (!netif_running(dev))
+			return;
+		/* Prevent infinite loop if device is down but netif_running()
+		 * returns true.
+		 */
+		if (retry_cnt > KTLS_RETRY_MAX) {
+			atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_RETRY_EXCEEDED]);
+			netdev_warn(dev, "%s retry max %d exceeded, state %lx\n",
+				    __func__, retry_cnt, bp->state);
+			return;
+		}
+		retry_cnt++;
+		msleep(100);
+	}
+	atomic_inc(&ktls->pending);
+	/* Make sure bnxt_close_nic() sees pending before we check the
+	 * BNXT_STATE_OPEN flag.
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		atomic_dec(&ktls->pending);
+		goto retry;
+	}
+
+	crypto = bp->crypto_info;
+	kctx_tx = __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	kid = kctx_tx->kid;
+	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
+	kind = BNXT_CTX_KIND_CK_TX;
+	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_DEL]);
+	if (bnxt_kid_valid(kctx, kid) &&
+	    !bnxt_crypto_del(bp, kctx->type, kind, kid))
+		bnxt_free_one_kctx(kctx, kid);
+
+	atomic_dec(&ktls->pending);
+}
+
+static const struct tlsdev_ops bnxt_ktls_ops = {
+	.tls_dev_add = bnxt_ktls_dev_add,
+	.tls_dev_del = bnxt_ktls_dev_del,
+};
+
+int bnxt_ktls_init(struct bnxt *bp)
+{
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+	struct net_device *dev = bp->dev;
+
+	if (!ktls)
+		return 0;
+
+	dev->tlsdev_ops = &bnxt_ktls_ops;
+	dev->hw_features |= NETIF_F_HW_TLS_TX;
+	dev->features |= NETIF_F_HW_TLS_TX;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
new file mode 100644
index 000000000000..6b8a1b1eeb24
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_KTLS_H
+#define BNXT_KTLS_H
+
+/* Control plane counters */
+enum bnxt_ktls_ctrl_counters {
+	BNXT_KTLS_TX_ADD = 0,
+	BNXT_KTLS_TX_DEL,
+
+	/* Error counters for debugging */
+	BNXT_KTLS_ERR_NO_MEM,			/* Memory allocation failure */
+	BNXT_KTLS_ERR_KEY_CTX_ALLOC,		/* Key context alloc failure */
+	BNXT_KTLS_ERR_CRYPTO_CMD,		/* Crypto command failure */
+	BNXT_KTLS_ERR_DEVICE_BUSY,		/* Device not ready */
+	BNXT_KTLS_ERR_INVALID_CIPHER,		/* Unsupported cipher */
+	BNXT_KTLS_ERR_STATE_NOT_OPEN,		/* Device not open */
+	BNXT_KTLS_ERR_RETRY_EXCEEDED,		/* Retry limit exceeded */
+
+	BNXT_KTLS_MAX_CTRL_COUNTERS,
+};
+
+struct bnxt_tls_info {
+	atomic_t		pending;
+
+	/* Atomic counters for control path */
+	atomic64_t		*counters;
+};
+
+struct bnxt_ktls_offload_ctx_tx {
+	u32		tcp_seq_no;
+	u32		kid;
+};
+
+struct ce_add_cmd {
+	__le32	ver_algo_kid_opcode;
+	#define CE_ADD_CMD_OPCODE_MASK			0xfUL
+	#define CE_ADD_CMD_OPCODE_SFT			0
+	#define CE_ADD_CMD_OPCODE_ADD			 0x1UL
+	#define CE_ADD_CMD_KID_MASK			0xfffff0UL
+	#define CE_ADD_CMD_KID_SFT			4
+	#define CE_ADD_CMD_ALGORITHM_MASK		0xf000000UL
+	#define CE_ADD_CMD_ALGORITHM_SFT		24
+	#define CE_ADD_CMD_ALGORITHM_AES_GCM_128	 0x1000000UL
+	#define CE_ADD_CMD_ALGORITHM_AES_GCM_256	 0x2000000UL
+	#define CE_ADD_CMD_VERSION_MASK			0xf0000000UL
+	#define CE_ADD_CMD_VERSION_SFT			28
+	#define CE_ADD_CMD_VERSION_TLS1_2		 (0x0UL << 28)
+	#define CE_ADD_CMD_VERSION_TLS1_3		 (0x1UL << 28)
+	u8	ctx_kind;
+	#define CE_ADD_CMD_CTX_KIND_MASK		0x1fUL
+	#define CE_ADD_CMD_CTX_KIND_SFT			0
+	#define CE_ADD_CMD_CTX_KIND_CK_TX		 0x11UL
+	#define CE_ADD_CMD_CTX_KIND_CK_RX		 0x12UL
+	u8	unused0[3];
+	u8	salt[4];
+	u8	unused1[4];
+	__le32	pkt_tcp_seq_num;
+	__le32	tls_header_tcp_seq_num;
+	u8	record_seq_num[8];
+	u8	session_key[32];
+	u8	addl_iv[8];
+};
+
+static inline bool bnxt_ktls_busy(struct bnxt *bp)
+{
+	return bp->ktls_info && atomic_read(&bp->ktls_info->pending) > 0;
+}
+
+#ifdef CONFIG_BNXT_TLS
+int bnxt_alloc_ktls_info(struct bnxt *bp);
+void bnxt_free_ktls_info(struct bnxt *bp);
+int bnxt_ktls_init(struct bnxt *bp);
+#else
+static inline int bnxt_alloc_ktls_info(struct bnxt *bp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bnxt_free_ktls_info(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_ktls_init(struct bnxt *bp)
+{
+	return -EOPNOTSUPP;
+}
+#endif	/* CONFIG_BNXT_TLS */
+#endif	/* BNXT_KTLS_H */
-- 
2.51.0


