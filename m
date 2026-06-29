Return-Path: <netdev+bounces-302796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xdtaNWu+Qmq7AQoAu9opvQ
	(envelope-from <netdev+bounces-302796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734566DE23A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Dd33ah4t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302796-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302796-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D3F03011A75
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690424219F6;
	Mon, 29 Jun 2026 18:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C64419311
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759010; cv=none; b=n5tCnPyh3lTba+ty0dWACF0ysz8diRd6qStDw5FUdKHwLKss3GsP1C5G1rDCCUBLjVPHD3OWnsn+oNwNuffi6MPr+3yezUXWpEm7kyFLJO0tncpJc+Je8YULLuKWUooClOfxSN3Yf1+6N8QRGlbI6Bvqb0MDAvH5gVcugMsETsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759010; c=relaxed/simple;
	bh=O2y2n37r1WLjd49XfmjNE0+ImA0fgsE7FUXsa49XIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOEVPJeoTkfZWbYsilXwfQhpInYpWFfww3EoG4rgV+HQ2uKnPSpXuiSkbgWkJ9rcq/FWkcc41aG6yKI9ahGE0hRkTlJOe0AMQqHHYQAmOyf2B9yIQvYAaZ780yh7JB6LhaofcBWVgz9ekHLVGPU6G6p4vo6kNyaZPUh1ekikJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dd33ah4t; arc=none smtp.client-ip=209.85.219.100
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso20759546d6.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759008; x=1783363808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCutg79kWQKha2rYose4I5FgRePNxSN+W9/PUWMuYkQ=;
        b=ltjSChsmEtirBheCiMhYeVtUBg6Gu0Yp3D9nP+I/9YaLHyqnPge23N1i+PI3fNQQ5F
         mPJFqpzj2G/ewqJsaRnk3aIM2Y/2toEoV9kQ04QeI+LYAd+iT9nCPQ5iw39boRtvhJhT
         pLH/dPzklekwAU6Ltwl92PodNQYvPb8Nnpqm036eTquYlmWFt2tkaRKbvcDR0csawqdL
         PUMNBpcEfhvhkTtFiUnJzdztBWD9Hnl1M6kGWsJU5sEgsadQ0xFQGSmjOW07NfC/IoW3
         +nURAeUBfIffpuF+Zi6PZYGo3dLhXl5oWJsWGDG5gju7YCj5CqvtUD4b0JFY1apztkg5
         hY+Q==
X-Gm-Message-State: AOJu0Yzs8ktH8xmW6y3XXcKKAl96JgI//4M90z+q6d7LkSqWLjewgk9L
	emO9nfU8qS2k/D+BrWBYuRNK17iw7DygaZax7J08cH+F59tW/NPwL3jH7Kr2mJu6Ki6FxbfVbE1
	1W6/KMJ6rQT+CQ7TzemkiCSPpkgKeUnThAs+kQrLqIvYSpWjNVF4rY7x6TAEQCH7mWLh2jP+ldB
	aLFkEOAEb9QyYmyeMX2Mvcu4iidQqdaQFp9AeHvYK0ZdPjJG3CSwYxDvqGfVgsxPJKQuxdieFsh
	wsbp3AIqg0=
X-Gm-Gg: AfdE7ckSleEKgtU29wNp91daZqbMDr53D6lLkOjm++EzlBxnGnY3pDF2IVxUJ05IAdO
	9TGZqciQDE8otMpTRr8xUoNPlooUVCnUR1CBC9ceQYGh6lLI0kYMYgUJsVtVWESMrnjN/Dr9mpH
	NCMZbRS1Erm5DH5BltSfn/32FJ1CVRJTx0hbx0vAp4tfW8RNm44+L9ZnutEwMPxAEMqFt8JLz3x
	pa6tjKmI9Ng680ZqHSPprulxGJ4OoxIXmEQi85wWtc/ZWCl+DTzMgTmaQDofcgm73N5WpIenxJ6
	2ObQrrN0soI3tZVkM97zvrIdr97yhh4SvtEvb83evM7AFgCV9whXc9xCBZT2lkuKXYwO7WFMnk7
	zIA6/7qfhZrqjPGbI5Wf5vJcqyuro8Bkp85s+ocoQ3GAIaf0UYaabz0tknnt9YRM5VyLaS7BUpO
	rJgpsIqwfOxZmLI7jFe3Xyzq1iDTE17/ZlSxbNuxq63NGRmg==
X-Received: by 2002:a05:6214:1fce:b0:8ea:7785:f3e6 with SMTP id 6a1803df08f44-8f1bbdcb6b5mr7183606d6.42.1782759007541;
        Mon, 29 Jun 2026 11:50:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8f1a3196c9esm435156d6.9.2026.06.29.11.50.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a854e8336so62872261cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759006; x=1783363806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCutg79kWQKha2rYose4I5FgRePNxSN+W9/PUWMuYkQ=;
        b=Dd33ah4tXyoVl7Fn67LKQVKMQK5tn9zz1GsaUewYyL/sRp2iLOcOgtR9jyjdfCV3ES
         9fmJuJVzcaP+l0DmwrDtQMVMB/bi/vB3xjg/64iDg0q66Agnwf+56fS45nb+EhB4+TIU
         IyI5/7SYixW1fYQYuFLP3XkypMdJyMr9xwmgg=
X-Received: by 2002:ac8:5fcd:0:b0:517:8069:8afb with SMTP id d75a77b69052e-51c1081fe4amr7796821cf.33.1782759006126;
        Mon, 29 Jun 2026 11:50:06 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:517:8069:8afb with SMTP id d75a77b69052e-51c1081fe4amr7796471cf.33.1782759005458;
        Mon, 29 Jun 2026 11:50:05 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:04 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/15] bnxt_en: Set default MPC ring count
Date: Mon, 29 Jun 2026 11:49:09 -0700
Message-ID: <20260629184921.3496727-4-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-302796-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:ajit.khaparde@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 734566DE23A

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
v3:
Use proper int type for min_t().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  7 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 63 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 15 +++++
 4 files changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2a737e7d7921..02c234b18a06 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13196,6 +13196,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		return rc;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16743,6 +16744,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 }
 
 static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
@@ -16794,6 +16796,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_set_dflt_ulp_stat_ctxs(bp);
 	}
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -16808,6 +16812,7 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
+		bnxt_trim_mpc_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16842,6 +16847,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 		goto init_dflt_ring_err;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
@@ -17185,6 +17191,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * limited MSIX, so we re-initialize the TX rings per TC.
 	 */
 	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bnxt_trim_mpc_rings(bp);
 
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 62bc9cae613c..a498dc1fe0d4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -37,6 +37,7 @@
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
+#include "bnxt_mpc.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -1051,6 +1052,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_set_cp_rings(bp, sh);
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 9859a5f86268..183f1a3726c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/bnxt/hsi.h>
 
@@ -45,3 +46,65 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
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
+		mpc->mpc_ring_count[i] = min_t(int, mpc->mpc_ring_count[i],
+					       max);
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


