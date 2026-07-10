Return-Path: <netdev+bounces-306433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e5EpCyR0UGoqzQIAu9opvQ
	(envelope-from <netdev+bounces-306433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A67371F0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RPa4Xxnw;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306433-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306433-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 645373010BD9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22236CE04;
	Fri, 10 Jul 2026 04:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3E36D9E6
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657506; cv=none; b=Jl+LZpvKgIOu2hyn5L0noVVpNb7mQoKbdUMG2B5y6xGL/Oc2Y8lyxlAwsSQfrWRRv+8ePQm3omqPSJtGpGUAyIu4fQYcQVjeYq2CQTpzeW8OIhEH7d2mfbvilz6rZj/dtNIbywkO/s+3AvZX2tXA+J3v8ADPWkg1zx66BNRnons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657506; c=relaxed/simple;
	bh=3aLzDwJav0e346QkVRnKiZIbH+SaiPXu7BC0d1BCnlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKNYHcRWddhJTVWB5g1MOwSQ/mPjfzv0UYa9XuyNI0xviIr0h9BgU2sTpxwBes2ZF+7EXjHGVxFXvjZgXvkODd+HSHhja3wkRWqZzO+SAM0DUoz9ADWq0Hvb6GBU1Tl2ZkN4MHr9nENID3CGbrHudLrLa5LvTfcJOICXPDNESfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RPa4Xxnw; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so4644365ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657504; x=1784262304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idq8Alw4dfcOpnvxip9O/QnfNAoSuHnxXybicCeHZbg=;
        b=HUeqd3Lg8cyp829GmSmPObPc73+GVKCe5ZoBXIXbJ4vQsccSO3Xtql9yzaS4vJ3bz3
         fYvv1s8Gcs8oVFXiyENY2Ywf9ZvIVbrbrY5gmP0SDW2GFhn9AMtx39cBsSSmA2UBRUe/
         DOZLIAxXz0g/bGdf3aBsyY9mPCHqsglIKLMmTwVJX9tvffOWzLbwA6IgZ1iPOp4jg/8C
         4HP3MD9dDeqIMV4j8I36cIwh1ox+eDvYNlD0NIaakmd5g/roEOU9inY4U/2wUNO58Roo
         qqokQlVTC6pyLyDb9qWmb+H8f0V8o+9abcsOQXAkZyraD2JXQk7jN/k53kGROKkLZCBu
         bn1w==
X-Gm-Message-State: AOJu0Yz/f9XwJ1kXpZYWs5mZiN+VAuhFNrDS7kd9oookQyZmoe23ElOg
	+8O1y1xICI3h6TW4Cfw11zlZ0qOHrXmnJ2CmWQ4JQ73VzgFdaXFhnoNTdb3H4dhXlt6hLaUezC4
	aPcShPHRHKAUnLQnuaVZ/Bh+AAdvizYuersSoQMyaNfpFzgnv0eUEmzw0w0GOze+1jAZCtl/NzQ
	Yj6B3gmTM/4e+RH9MkuHPaLo9Y7bKM7Hy8evitx5STfermi5CvQjMN6q5bO/Mx4VO72oMLcqNfu
	FN4E6HZvOc=
X-Gm-Gg: AfdE7cm1HFN/2KpFrjy/GovKNSyTkdcfZlPjO7abAvemA8zdwYdHoiraSGmHtnJCRMq
	mGgTQpumqG2mfUhaTKvGXmYFAos+3o10HADYdoAyjQLlt37hARbHg3nei6rQgum+Gxh0MX76UWq
	nY28b5UIDS8YfpysWe6rP7CRxEvT6bWggTH7ZtBdEaiEevj2IwqMusE8gW8FnxgIMLhPMhl8pJU
	oGev6fx/E6oqM799+PFYyZo9SfUDPdESJPQiZVX/7NSbmhUjmkw2/EEQPcPdMn1UlJpmoEJ3uUY
	sFh9soi78FqUM+xRALKCb9QwK/PraBMAUXB9icO1qL245Uh2somQ4KVv38lBkuvzuKUPzb6f85A
	SdDBZTO6Sp0B5TSLJq6nZVWyRrf3w9sGxDAp7o6uzBCLDqPU3hJ2b+eGEz0GZux64vbpcU/OZo7
	6W47Jog0BdO4Ax6KUZ7kZ7CX8z8yoXlwUTxWkzOo6D35QPrw==
X-Received: by 2002:a17:902:ef06:b0:2c6:9d3d:dfbd with SMTP id d9443c01a7336-2ccea38c85amr108282185ad.16.1783657504079;
        Thu, 09 Jul 2026 21:25:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9bc5620sm10127075ad.7.2026.07.09.21.25.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:25:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c890bac374eso892201a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657502; x=1784262302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idq8Alw4dfcOpnvxip9O/QnfNAoSuHnxXybicCeHZbg=;
        b=RPa4XxnwD34u+Psz9IJ6gahX4hasB9KkAwUl/LJeT0eMEGkoEcULJsTIgp5+usIzA2
         lxTjxuPOSIgGuwvvXQKKUF0/qr3yh0xs3T5T7bF/XBZUudh2D9rPso/HiTeKHtlPPpTA
         A6MzY019bLzOglwvvxZSVF07vj93Xc+HpMU/Y=
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id adf61e73a8af0-3c0bcbc5172mr11845732637.47.1783657501866;
        Thu, 09 Jul 2026 21:25:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id adf61e73a8af0-3c0bcbc5172mr11845688637.47.1783657501186;
        Thu, 09 Jul 2026 21:25:01 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:25:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 12/15] bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
Date: Thu,  9 Jul 2026 21:23:57 -0700
Message-ID: <20260710042400.3996847-13-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-306433-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E70A67371F0

Add basic infrastructure to allocate and free kTLS context IDs (KIDs)
to support kTLS TX offload.  To offload a connection in .tls_dev_add(),
the first step is to allocate a KID.  After that the kTLS offload
command is sent to the HW via MPC using the function
bnxt_xmit_crypto_cmd() introduced in the last patch.

In .tls_dev_del(), we send the delete command to the HW using the
same bnxt_xmit_crypto_cmd().  After that we free the KID, making it
available for new offload.  There is extra logic to handle ifdown,
FW reset, and device reconfiguration while deleting the connection.

bnxt_ktls_init() assigns bnxt_ktls_ops to the netdev and sets up
the TLS TX offload feature.  bnxt_ktls_init() will be called in
the next patch.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
Fix uninitialized kctx_tx variable warning.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-13-michael.chan@broadcom.com/

Use wait_event() in bnxt_ktls_dev_del() in case the device is in transient
reconfig state instead of poll wait.

Call bnxt_crypto_del_all() after BNXT_STATE_OPEN is cleared as documented.

Use memzero_explicit() to clear sensitive TLS parameters.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-13-michael.chan@broadcom.com/

Fix unused variable warning
Fix error recovery issues

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-13-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  |  82 ++++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  11 +
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 345 ++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 112 ++++++
 7 files changed, 566 insertions(+), 3 deletions(-)
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
index 316733299e23..ef73e992756b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -78,6 +78,7 @@
 #include <net/tso.h>
 #include "bnxt_mpc.h"
 #include "bnxt_crypto.h"
+#include "bnxt_ktls.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -13326,6 +13327,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		static_branch_disable(&bnxt_xdp_locking_key);
 	}
 	set_bit(BNXT_STATE_OPEN, &bp->state);
+	bnxt_ktls_wake(bp);
 	bnxt_enable_int(bp);
 	/* Enable TX queues */
 	bnxt_tx_enable(bp);
@@ -13467,7 +13469,8 @@ static int bnxt_open(struct net_device *dev)
 static bool bnxt_drv_busy(struct bnxt *bp)
 {
 	return (test_bit(BNXT_STATE_IN_SP_TASK, &bp->state) ||
-		test_bit(BNXT_STATE_READ_STATS, &bp->state));
+		test_bit(BNXT_STATE_READ_STATS, &bp->state) ||
+		bnxt_ktls_busy(bp));
 }
 
 static void bnxt_get_ring_stats(struct bnxt *bp,
@@ -13485,9 +13488,20 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 
 	clear_bit(BNXT_STATE_OPEN, &bp->state);
 	smp_mb__after_atomic();
+	/* Wake any kTLS delete waiting on a reconfig so it re-evaluates and
+	 * either keeps waiting for the reopen or aborts (ifdown / FW reset).
+	 */
+	bnxt_ktls_wake(bp);
 	while (bnxt_drv_busy(bp))
 		msleep(20);
 
+	/* Delete all crypto connections and KIDs only on ifdown and FW reset,
+	 * not ethtool config changes.
+	 */
+	if (!netif_running(bp->dev) ||
+	    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
+		bnxt_crypto_del_all(bp);
+
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
 		bnxt_clear_rss_ctxs(bp);
 	/* Flush rings and disable interrupts */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b65538fda3bd..b7ad665b47ae 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2475,6 +2475,7 @@ struct bnxt {
 
 	struct bnxt_mpc_info	*mpc_info;
 	struct bnxt_crypto_info	*crypto_info;
+	struct bnxt_tls_info	*ktls_info;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 27a61173dd7c..6376a85d4b83 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -11,6 +11,7 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_mpc.h"
+#include "bnxt_ktls.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -80,13 +81,91 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
 	}
 	crypto->max_key_ctxs_alloc = max_keys;
-	bp->fw_cap |= BNXT_FW_CAP_KTLS;
+	if (!bp->ktls_info)
+		bnxt_alloc_ktls_info(bp);
+	if (bp->ktls_info)
+		bp->fw_cap |= BNXT_FW_CAP_KTLS;
 	return;
 
 alloc_err:
 	kfree(crypto);
 }
 
+int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct ce_delete_cmd cmd = {};
+	u32 data;
+
+	if (BNXT_NO_FW_ACCESS(bp))
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
+/**
+ * bnxt_crypto_del_all - Delete all crypto connections
+ * @bp: pointer to bnxt device
+ *
+ * Delete all crypto connections and free all KIDs for re-use during
+ * shutdown.  Increment the epoch counter to invalidate any outstanding
+ * key references.
+ *
+ * Locking: the caller must have cleared BNXT_STATE_OPEN and waited for all
+ * in-flight kTLS control ops to drain.  Under these preconditions there are
+ * no concurrent readers or writers of the KID lists, so the lists can be
+ * walked without rcu_read_lock() or the kctx lock.
+ *
+ * Context: Process context during shutdown/reset
+ */
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
+	/* No concurrent access; see the locking note above. */
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		list_for_each_entry(kid, &kctx->list, list)
+			bnxt_crypto_del_all_kids(bp, kid);
+		kctx->epoch = BNXT_NEXT_EPOCH(kctx->epoch);
+	}
+}
+
 /**
  * bnxt_clear_crypto - Clear all crypto key contexts
  * @bp: pointer to bnxt device
@@ -137,6 +216,7 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 {
 	struct bnxt_crypto_info *crypto = bp->crypto_info;
 
+	bnxt_free_ktls_info(bp);
 	if (!crypto)
 		return;
 	bnxt_clear_crypto(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index 8a2cbb7603a8..d4759059a6d2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -148,6 +148,8 @@ struct bnxt_crypto_cmd_ctx {
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
+int bnxt_crypto_del(struct bnxt *bp, u8 type, u8 kind, u32 kid);
+void bnxt_crypto_del_all(struct bnxt *bp);
 void bnxt_clear_crypto(struct bnxt *bp);
 void bnxt_free_crypto_info(struct bnxt *bp);
 void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
@@ -167,6 +169,15 @@ static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
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
index 000000000000..cec877075b16
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -0,0 +1,345 @@
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
+	init_waitqueue_head(&ktls->open_wq);
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
+	int rc;
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
+	rc = bnxt_xmit_crypto_cmd(bp, txr, &cmd, sizeof(cmd),
+				  BNXT_MPC_TMO_MSECS);
+	memzero_explicit(&cmd, sizeof(cmd));
+	return rc;
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
+static void bnxt_set_ktls_ctx_tx(struct tls_context *tls_ctx,
+				 struct bnxt_ktls_offload_ctx_tx *kctx_tx)
+{
+	struct bnxt_ktls_tx_driver_state *tx =
+		__tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+
+	tx->ctx_tx = kctx_tx;
+}
+
+static struct bnxt_ktls_offload_ctx_tx *
+bnxt_get_ktls_ctx_tx(struct tls_context *tls_ctx)
+{
+	struct bnxt_ktls_tx_driver_state *tx =
+		__tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+
+	return tx->ctx_tx;
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
+	BUILD_BUG_ON(sizeof(struct bnxt_ktls_tx_driver_state) >
+		     TLS_DRIVER_STATE_SIZE_TX);
+
+	ktls = bp->ktls_info;
+	if (direction == TLS_OFFLOAD_CTX_DIR_RX)
+		return -EOPNOTSUPP;
+
+	if (!BNXT_SUPPORTS_KTLS(bp)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_NO_CAP]);
+		return -EOPNOTSUPP;
+	}
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
+	if (!bnxt_ktls_cipher_supported(bp, crypto_info)) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_INVALID_CIPHER]);
+		rc = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	kctx_tx = kzalloc_obj(*kctx_tx);
+	if (!kctx_tx) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_NO_MEM]);
+		rc = -ENOMEM;
+		goto exit;
+	}
+	tls_ctx = tls_get_ctx(sk);
+	crypto = bp->crypto_info;
+	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
+	rc = bnxt_key_ctx_alloc_one(bp, kctx, BNXT_CTX_KIND_CK_TX, &kid);
+	if (rc) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_KEY_CTX_ALLOC]);
+		goto free_ctx;
+	}
+	rc = bnxt_crypto_add(bp, direction, crypto_info, start_offload_tcp_sn,
+			     kid);
+	if (rc) {
+		atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_CRYPTO_CMD]);
+		goto free_kctx;
+	}
+	kctx_tx->kid = kid;
+	kctx_tx->tcp_seq_no = start_offload_tcp_sn;
+	bnxt_set_ktls_ctx_tx(tls_ctx, kctx_tx);
+	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_ADD]);
+	goto exit;
+
+free_kctx:
+	/* This KID was just allocated while holding ktls->pending, so epoch
+	 * check is unnecessary.
+	 */
+	bnxt_free_one_kctx(kctx, kid);
+free_ctx:
+	kfree(kctx_tx);
+exit:
+	atomic_dec(&ktls->pending);
+	return rc;
+}
+
+#define KTLS_RETRY_MAX		100
+#define KTLS_WAIT_TMO_MS	100
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
+	kctx_tx = bnxt_get_ktls_ctx_tx(tls_ctx);
+retry:
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
+		/* During ifdown or FW reset, all connections will be torn
+		 * down by bnxt_crypto_del_all() / FUNC_RESET, so nothing to
+		 * do here.  Only a reconfiguration is transient and
+		 * __bnxt_open_nic() will set BNXT_STATE_OPEN again and wake us.
+		 */
+		if (!netif_running(dev) ||
+		    test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
+			goto free;
+		/* Bound the wait so a wedged reconfig can't block the kTLS
+		 * destruct work indefinitely.
+		 */
+		if (retry_cnt++ > KTLS_RETRY_MAX) {
+			atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_RETRY_EXCEEDED]);
+			netdev_warn(dev, "%s timed out waiting for device, state %lx\n",
+				    __func__, bp->state);
+			goto free;
+		}
+		wait_event_timeout(ktls->open_wq,
+				   test_bit(BNXT_STATE_OPEN, &bp->state) ||
+				   !netif_running(dev) ||
+				   test_bit(BNXT_STATE_IN_FW_RESET, &bp->state),
+				   msecs_to_jiffies(KTLS_WAIT_TMO_MS));
+		goto retry;
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
+	kid = kctx_tx->kid;
+	kctx = &crypto->kctx[BNXT_TX_CRYPTO_KEY_TYPE];
+	kind = BNXT_CTX_KIND_CK_TX;
+	atomic64_inc(&ktls->counters[BNXT_KTLS_TX_DEL]);
+	/* This KID was allocated by an earlier add and may have outlived a FW
+	 * reset, so validate its epoch before deleting/freeing it.
+	 */
+	if (bnxt_kid_valid(kctx, kid) &&
+	    !bnxt_crypto_del(bp, kctx->type, kind, kid))
+		bnxt_free_one_kctx(kctx, kid);
+
+	atomic_dec(&ktls->pending);
+free:
+	bnxt_set_ktls_ctx_tx(tls_ctx, NULL);
+	kfree(kctx_tx);
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
index 000000000000..5a4f39f15e80
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Broadcom Inc. */
+
+#ifndef BNXT_KTLS_H
+#define BNXT_KTLS_H
+
+#include <linux/wait.h>
+
+/* Control plane counters */
+enum bnxt_ktls_ctrl_counters {
+	BNXT_KTLS_TX_ADD = 0,
+	BNXT_KTLS_TX_DEL,
+
+	/* Error counters for debugging */
+	BNXT_KTLS_ERR_NO_MEM,			/* Memory allocation failure */
+	BNXT_KTLS_ERR_NO_CAP,			/* Capability lost after FW reset */
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
+	/* Woken from __bnxt_open_nic()/__bnxt_close_nic() when
+	 * BNXT_STATE_OPEN changes, so a kTLS delete can wait out a ring
+	 * reconfiguration instead of polling the state bit.
+	 */
+	wait_queue_head_t	open_wq;
+
+	/* Atomic counters for control path */
+	atomic64_t		*counters;
+};
+
+struct bnxt_ktls_offload_ctx_tx {
+	u32		tcp_seq_no;	/* tcp seq no in sync with HW */
+	u32		next_tcp_seq_no;/* staged tcp seq no */
+	u32		kid;
+	u32		pending_bytes;	/* staged payload bytes */
+};
+
+struct bnxt_ktls_tx_driver_state {
+	struct bnxt_ktls_offload_ctx_tx *ctx_tx;
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
+/* Wake any kTLS control op waiting for a BNXT_STATE_OPEN transition. */
+static inline void bnxt_ktls_wake(struct bnxt *bp)
+{
+	if (bp->ktls_info)
+		wake_up_all(&bp->ktls_info->open_wq);
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


