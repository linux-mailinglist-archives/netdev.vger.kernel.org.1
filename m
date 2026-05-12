Return-Path: <netdev+bounces-287311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDNTK++ZA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:21:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149452A37F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAADD302E946
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768F357D19;
	Tue, 12 May 2026 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YDoNMUOd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12A3672AF
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620904; cv=none; b=gfFNKxKYtP0MwCCKUnIwI0yQJ7Sx8JWKAA/CHRSmTXhcApilJ+6cdRZLilnMiAF0Un758m5YDtiSW5kFXe/0i7tfDRzCuIj+Wrn/NKQY+XYwKfXdkPLBlvJy8itlp9fpYRdR6eBMdGutii4o1tCeLsC3YAzBfXGx1TutJUOrL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620904; c=relaxed/simple;
	bh=/YHZ8x7C4L4vx407vgcwDNFhr2fJ/TZL3ZYS2ZIh4Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msWjRtuREsZp3ffDOB3qNVcAxfdsl365mbUEWd/Kr8zxnUT9V2WD/06P0st2ltUNXE9bLhHIIxUJMzNmf0MF8MjJ53wMbI/y09sREZWZodvfkFXpjhe/Q/24HEi9GNxZ6SjNw26gFTefOzovbMpWg/cq22+n2GnkwL5c1DvxEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YDoNMUOd; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-82748257f5fso4430897b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620902; x=1779225702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGFuaSxXuYvKA3RWiHBDocykapFMWvAnnXH3GlTeAhw=;
        b=AHhK6VcOzOA7YXgdTzeHBfjz7iY0p44nVksMW1AdsSF+yPoKfy94LtiyHveJe999c/
         QCMS9CsBspl5xxfgP9WWltSoh76YOZY7/Pwcn68hbCrPjTitFxBDtabScYBVhqr1d/D/
         ikjg0CShZYs8IerZirbcK9cWIFAYJY5IFNkHngcuIPNJ6Gc+0c8mQTm1X9GT59DIk9gs
         DGvUQJSH56nLhAagIvMQP5wNSydaZ+bK3x5r8oN7Yqclj+7SFazaRAqyyFaMqu+iDFJl
         AZLSkbZZ+4RaEtTuKR/Y6quUrjqwmDqd10faNP2vPjYfoYE/+VlNK3edUXIxTNZhwp9t
         ppLQ==
X-Gm-Message-State: AOJu0YzFSbjHnACekmZcioNK0C5F3s2LER9CwDHMCjCmo2JWaLaQCaW9
	DcXQD2u+RD6tpxqKgIBC45LD0E5nBLBWQCsMjPkg5siMWbVTmnez0cNXH4Q2UPsG4MFyM1EMIvs
	KVgbuRPJtjZmVEfCRICKv/es43BMNbx+z7ZMmXD4hEF/1fpsXbdBQa+edzv/9cD+v3d91ZY2qPo
	vtGck0aK7o3FNL/9wE+XpH8uNMPni01O3KB2J4whVmgVbmgGnyX/8R7oL+loUxZccmrf3EMSqbU
	WFjHrmZ30Q=
X-Gm-Gg: Acq92OELTJyR+qMPmCpLfDPNWTStI2igxPk4xpJUtePQjt2GqL9uWBteM3UyCTrt39q
	gy7YxmRXlhA5J5eJGHL/Lz5qW9TPsOaTp/D+LjnXPOyo2AvLsZW6Ux2NFIwLUq0B90QftUdmpvn
	kA5KEY3b3srv+ASF+kMr0s10BR1qAMvHaPAN1fRipfSJXkppoQVJy5D/CkiS/+C6J9BSDOwugq6
	mFrPEhXqnCa/56J9wr20xzUFmRAeMIKRaQBMU1e3dOFUhvYZDKQBPV+rFBsxm8Ai42ym9YwZYiV
	A/VDERGYaf0gHlaArKwsdxcRTnhTLOkCbRzMxTeFceFrSXuHOZs+hQKwPNug8+9C3nwgSwWgb6G
	9k2dA2PZLgV80kEZqtN2G8SvGPFqK0XU4eU3qh1l15sJ3RWGjYrdcLyYdrb6D64EdFyV/8vLeGL
	S6UgsdoJoJNnROCN3VanDhG2hY/+atcDK3VFyWWYhB5kITY+8AnUBdU53Q
X-Received: by 2002:a05:6a21:3397:b0:3a1:785:a567 with SMTP id adf61e73a8af0-3af66b2b416mr669145637.26.1778620901578;
        Tue, 12 May 2026 14:21:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c826767e5b9sm932716a12.2.2026.05.12.14.21.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f1383b7439so5094477eec.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620899; x=1779225699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGFuaSxXuYvKA3RWiHBDocykapFMWvAnnXH3GlTeAhw=;
        b=YDoNMUOd5FNNjhWnxDOs1sICUKLcznYuyNtY6V1jjstZZYaFcg2Sskt+WKvGaZIN8x
         of+s4zOWXxKCPvehoosgqOnysCveznq8T4JPGmXgoKSqv0UATuJvgIi6MSFqiOpbzLLp
         O68Hh196m/b9nKPRkrid0QetguqE/bh+3KXSc=
X-Received: by 2002:a05:7022:324:b0:130:8ed9:204c with SMTP id a92af1059eb24-1333b0b1afcmr3449960c88.10.1778620899404;
        Tue, 12 May 2026 14:21:39 -0700 (PDT)
X-Received: by 2002:a05:7022:324:b0:130:8ed9:204c with SMTP id a92af1059eb24-1333b0b1afcmr3449940c88.10.1778620898838;
        Tue, 12 May 2026 14:21:38 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:38 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v2 03/15] bnxt_en: Set default MPC ring count
Date: Tue, 12 May 2026 14:20:53 -0700
Message-ID: <20260512212105.3488258-4-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: 5149452A37F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
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
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287311-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

If the firmware supports MPC channels and CONFIG_BNXT_TLS is set, set
the default number of MPC channels.  These MPC rings will share MSIX
with the TX rings.  The number of MPC channels for each type must not
exceed the ethtool TX channel count.  bnxt_set_dflt_mpc_rings() will
determine the count for each MPC channel type and it cannot be directly
controlled by the user.

We also add bnxt_trim_mpc_rings() to make final adjustments in case
the number of reserved TX channels is less than expected.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  7 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 62 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 15 +++++
 4 files changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e02909511f54..8d5206c1ba8f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13147,6 +13147,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		return rc;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16681,6 +16682,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 }
 
 static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
@@ -16732,6 +16734,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_set_dflt_ulp_stat_ctxs(bp);
 	}
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -16746,6 +16750,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
+		bnxt_trim_mpc_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16780,6 +16785,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 		goto init_dflt_ring_err;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
@@ -17123,6 +17129,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * limited MSIX, so we re-initialize the TX rings per TC.
 	 */
 	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bnxt_trim_mpc_rings(bp);
 
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9b14134d62d2..11cb1b841359 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -37,6 +37,7 @@
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
+#include "bnxt_mpc.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -1050,6 +1051,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_set_cp_rings(bp, sh);
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 9859a5f86268..cce73d56e46e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/bnxt/hsi.h>
 
@@ -45,3 +46,64 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 		return 0;
 	return mpc->mpc_cp_rings;
 }
+
+void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int max = bp->tx_nr_rings_per_tc;
+	u8 max_cp = 0;
+	int i;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		mpc->mpc_ring_count[i] = min_t(u8, mpc->mpc_ring_count[i], max);
+		max_cp = max(max_cp, mpc->mpc_ring_count[i]);
+	}
+	mpc->mpc_cp_rings = max_cp;
+}
+
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int mpc_tce, mpc_rce, avail, mpc_cp, i;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	avail = hw_resc->max_tx_rings - bp->tx_nr_rings;
+	/* don't use more than 80% */
+	avail = avail * 4 / 5;
+
+	if (avail < (BNXT_MIN_MPC_TCE + BNXT_MIN_MPC_RCE))
+		goto disable_mpc;
+
+	mpc_tce = min_t(int, avail / 2, bp->tx_nr_rings_per_tc);
+	mpc_rce = mpc_tce;
+
+	mpc_tce = min_t(int, mpc_tce, BNXT_DFLT_MPC_TCE);
+	mpc_rce = min_t(int, mpc_rce, BNXT_DFLT_MPC_RCE);
+
+	avail = hw_resc->max_cp_rings - bp->tx_nr_rings -
+		bp->rx_nr_rings;
+
+	if (avail < BNXT_MIN_MPC_TCE || avail < BNXT_MIN_MPC_RCE)
+		goto disable_mpc;
+
+	mpc_tce = min(mpc_tce, avail);
+	mpc_rce = min(mpc_rce, avail);
+
+	mpc_cp = max(mpc_tce, mpc_rce);
+
+	mpc->mpc_ring_count[BNXT_MPC_TCE_TYPE] = mpc_tce;
+	mpc->mpc_ring_count[BNXT_MPC_RCE_TYPE] = mpc_rce;
+	mpc->mpc_cp_rings = mpc_cp;
+	return;
+
+disable_mpc:
+	mpc->mpc_cp_rings = 0;
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc->mpc_ring_count[i] = 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 7a7d81197ea6..4ff8cad75a23 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -17,6 +17,11 @@ enum bnxt_mpc_type {
 
 #define BNXT_MAX_MPC		8
 
+#define BNXT_MIN_MPC_TCE	1
+#define BNXT_MIN_MPC_RCE	1
+#define BNXT_DFLT_MPC_TCE	BNXT_MAX_MPC
+#define BNXT_DFLT_MPC_RCE	BNXT_MAX_MPC
+
 struct bnxt_mpc_info {
 	u8			mpc_chnls_cap;
 	u8			mpc_cp_rings;
@@ -37,6 +42,8 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+void bnxt_trim_mpc_rings(struct bnxt *bp);
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -55,5 +62,13 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


