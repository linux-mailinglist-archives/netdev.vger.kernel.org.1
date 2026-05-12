Return-Path: <netdev+bounces-287310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LN7Dh2aA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:22:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F552A39B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6826308A340
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8744B37A4B8;
	Tue, 12 May 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HIMRsQrg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3A3815D1
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620902; cv=none; b=E02EPzjeRfvIgAVla+6Oo3GgUQZTCbh1oVtSK2VG0biLzqf5Zc1qTydUvO6pA3sRhsl4hrJbGZqUgGEh192aB4/ploN7qEk6S4voQrvKPKPj4+NLzpKHWOEt8dAublx30yojizd0OO+Ud5ZXlBDoBuK8QzvC1Li7e46VY/EOTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620902; c=relaxed/simple;
	bh=2z9u6la06NyCWZNhsCaeXQLj1p6bWLKKa/35r0NOnII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryGum1KRD86CelF8OxcwhRTnQdBtb1Ypj7jo/Mid/SKFqLNGh27uAdys1SJa85DmaaRhsX6rre+dXbuVWX51CzmS1AXJba0OLLXFwzMAkaMnt4sEidn7KXbFEymoa2/dGq0R8Twtx5Vl2tbkG9dynOktiYaQfnfFAzAj0ENXBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HIMRsQrg; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7bd810cdc5dso64981167b3.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620900; x=1779225700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9efxHgwiBfskAW5BGIEpBMW0XxGuDiW0P4RhoFjaHY4=;
        b=TTF6CPg3Admq1RBdFV0HBoWNUfW3m31nV0WFbrGNXz7q2wDETI2IDVOoMzQHhmZKjT
         8HjbfyQef1/xL6InHnfLfHHttJ1+wl1d+MqYPRIgHUYP+Xl3/V8sBfSpyjPe6U+nL21h
         kN543XbSerYtp8dyy0r4l52ctypwEQtJJVHsez/E6M0/IeBCNrqjQpAQkzEJAEpl1yp7
         WHIIiG1BQp6vH/OXeOjXWd0qgyCzzup9rg55coyk06OnHdwg92XeYSfBG3fxAhVGVRTn
         IETvFqV72TB+qJ0KYGRNYv4PnYQA/PQMRFi81Ja4qrEBs7dU9MhDdsrcjQl+d9HFU72q
         sbZw==
X-Gm-Message-State: AOJu0YywePYf8Nl0XR7pPOmJuvT4Lq5nGGV5kXX/2A8Xc98C/oVsHNWr
	hGpDNUjrRLCyTJkDOdFtosgCr5pSSHz9cooYOSrcIZbBc2yxdWmibEvVHJPjkdGk94scIRtGrlN
	jes2UoXAPpy0D2W00DdSMjgIENPtqPNsPuWVvBubNRZLNalcIYuq8lFsI9BUsRoiQ6e1E1QcdZ3
	xPIqPtpQWTiQ+htG2f9AV1Cph05DOCM70bQJSOcS+H3ZYLAfGnSjt7kVQMSDmJRDahBnxIgzguV
	t0KiMPUbA8=
X-Gm-Gg: Acq92OEYbD+7RCOTWcj4uDuvpkpSWe5h4oorCShpatCUebKzZmNCctSa1gToYQo9w4A
	9HTBUbCImhb6/C5PEJFxRQJAfMfxgEmMrr6jlvsTQUXCwTu9JG2O3i16vCvPgMCmUyukU+H85AW
	lEFaUSzpnOhAd1IxVUL9iOZ781v5x4m4PeL9OLru4jylsPuLn2tOe3DiAbNz4IYEhw86jyNdG2G
	FZO6+/BECD/XBi+HlqZMPtaIXrVoWYmKfKvLrcsIfZX72IUzDvt1Ab/vRPl2DTNHawicXDxhFuV
	BfhHecE0tK7ebY0MaVBKZQkuu5JrhJJRFrLloizCHfJiNbdj6Aq3b1wdSWF+5Lf3/K93CzxXfso
	fuTVYrLvspP7Tlj1VWHlhc0H9pjmHPjA3ehUYp7rPBOgxof4AtFAGcUrLZGRUEmg7S0efY6g5cX
	0yFLWRJbvn5zff7bhTUp+OoDcraOSmJ/A3SU/bQvcg+E1MaKV2Chmkmz4z
X-Received: by 2002:a05:690c:ed4:b0:79a:cc18:19c6 with SMTP id 00721157ae682-7c6abbcd3cemr6072187b3.34.1778620899404;
        Tue, 12 May 2026 14:21:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7bdbbbb7ee9sm12634877b3.7.2026.05.12.14.21.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-132a99125f8so6992120c88.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620898; x=1779225698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9efxHgwiBfskAW5BGIEpBMW0XxGuDiW0P4RhoFjaHY4=;
        b=HIMRsQrgAkBGKXk9UrLBjlGKo8sLUKIw8QDm/zlFIy48cZK/zDYa1GFFGwIJRz6biI
         w2L1y0Xl5/80AQQ67ElGDp5uQ+DlWBI9l3+lbpwJdNFWm3uk1QifK7huuUP3wL+XvhpI
         I6WEK/0QoiCvOTWfsJ6U9GxINJ6ZWvFFZjHg4=
X-Received: by 2002:a05:7022:6b9b:b0:133:3bd2:d63b with SMTP id a92af1059eb24-1343698f501mr384633c88.26.1778620898058;
        Tue, 12 May 2026 14:21:38 -0700 (PDT)
X-Received: by 2002:a05:7022:6b9b:b0:133:3bd2:d63b with SMTP id a92af1059eb24-1343698f501mr384603c88.26.1778620897138;
        Tue, 12 May 2026 14:21:37 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:35 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/15] bnxt_en: Account for the MPC TX and CP rings
Date: Tue, 12 May 2026 14:20:52 -0700
Message-ID: <20260512212105.3488258-3-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: 9F8F552A39B
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
	TAGGED_FROM(0.00)[bounces-287310-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Modify bnxt_cp_rings_in_use(), bnxt_get_max_func_cp_rings_for_en(),
and _bnxt_get_max_rings() to account for any TX rings and CP rings
used by MPCs.  Add a new helper bnxt_total_tx_rings() to include
MPC TX rings.  Ring reservations will now include the MPC rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 45 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 21 +++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 12 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  6 +--
 5 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 06d0c82b4022..e02909511f54 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7746,6 +7746,11 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	}
 }
 
+int bnxt_total_tx_rings(struct bnxt *bp)
+{
+	return bp->tx_nr_rings + bnxt_mpc_tx_rings_in_use(bp);
+}
+
 static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 			     bool shared);
 static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
@@ -7786,19 +7791,28 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		stats = le16_to_cpu(resp->alloc_stat_ctx);
 		hw_resc->resv_irqs = cp;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+			int mpc_tx = bnxt_mpc_tx_rings_in_use(bp);
+			int mpc_cp = bnxt_mpc_cp_rings_in_use(bp);
 			int rx = hw_resc->resv_rx_rings;
 			int tx = hw_resc->resv_tx_rings;
+			int cp_p5;
 
+			if (tx <= mpc_tx || cp <= mpc_cp) {
+				rc = -ENOMEM;
+				goto get_rings_exit;
+			}
+			tx -= mpc_tx;
+			cp_p5 = cp - mpc_cp;
 			if (bp->flags & BNXT_FLAG_AGG_RINGS)
 				rx >>= 1;
-			if (cp < (rx + tx)) {
-				rc = __bnxt_trim_rings(bp, &rx, &tx, cp, false);
+			if (cp_p5 < (rx + tx)) {
+				rc = __bnxt_trim_rings(bp, &rx, &tx, cp_p5, false);
 				if (rc)
 					goto get_rings_exit;
 				if (bp->flags & BNXT_FLAG_AGG_RINGS)
 					rx <<= 1;
 				hw_resc->resv_rx_rings = rx;
-				hw_resc->resv_tx_rings = tx;
+				hw_resc->resv_tx_rings = tx + mpc_tx;
 			}
 			hw_resc->resv_irqs = le16_to_cpu(resp->alloc_msix);
 			hw_resc->resv_hw_ring_grps = rx;
@@ -7990,7 +8004,7 @@ static int bnxt_cp_rings_in_use(struct bnxt *bp)
 		return bnxt_nq_rings_in_use(bp);
 
 	cp = bp->tx_nr_rings + bp->rx_nr_rings;
-	return cp;
+	return cp + bnxt_mpc_cp_rings_in_use(bp);
 }
 
 static int bnxt_get_func_stat_ctxs(struct bnxt *bp)
@@ -8048,7 +8062,7 @@ static void bnxt_get_total_resources(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	hwr->cp_p5 = 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		hwr->cp_p5 = bnxt_cp_rings_in_use(bp);
-	hwr->tx = bp->tx_nr_rings;
+	hwr->tx = bnxt_total_tx_rings(bp);
 	hwr->rx = bp->rx_nr_rings;
 	hwr->grp = hwr->rx;
 	hwr->vnic = bnxt_get_total_vnics(bp, hwr->rx);
@@ -8154,8 +8168,10 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	hwr.rx = bp->rx_nr_rings;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.rx + hwr.tx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.rx + hwr.tx + bnxt_mpc_cp_rings_in_use(bp);
+		hwr.tx += bnxt_mpc_tx_rings_in_use(bp);
+	}
 
 	hwr.vnic = bnxt_get_total_vnics(bp, hwr.rx);
 
@@ -8192,6 +8208,9 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (bnxt_ulp_registered(edev) && hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
+	hwr.tx -= bnxt_mpc_tx_rings_in_use(bp);
+	if (hwr.tx < 0)
+		return -ENOMEM;
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
@@ -11468,12 +11487,13 @@ unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp)
 
 static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp)
 {
+	unsigned int mpc_cp = (unsigned int)bnxt_mpc_cp_rings_in_use(bp);
 	unsigned int cp = bp->hw_resc.max_cp_rings;
 
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		cp -= bnxt_get_ulp_msix_num(bp);
 
-	return cp;
+	return mpc_cp >= cp ? 0 : cp - mpc_cp;
 }
 
 static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
@@ -14868,8 +14888,10 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.grp = rx;
 		hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	}
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.tx + rx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.tx + rx + bnxt_mpc_cp_rings_in_use(bp);
+		hwr.tx += bnxt_mpc_tx_rings_in_use(bp);
+	}
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
 		if (!bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA])) {
@@ -16561,7 +16583,8 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	int max_ring_grps = 0, max_irq;
 
-	*max_tx = hw_resc->max_tx_rings;
+	*max_tx = max(0, (int)hw_resc->max_tx_rings -
+			 bnxt_mpc_tx_rings_in_use(bp));
 	*max_rx = hw_resc->max_rx_rings;
 	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp);
 	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ab88d96f807c..beea928d8c49 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2989,6 +2989,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			 unsigned int start_rx_ring_idx,
 			 unsigned int nr_rings);
+int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 86087e538550..9859a5f86268 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -24,3 +24,24 @@ void bnxt_free_mpc_info(struct bnxt *bp)
 	kfree(bp->mpc_info);
 	bp->mpc_info = NULL;
 }
+
+int bnxt_mpc_tx_rings_in_use(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, mpc_tx = 0;
+
+	if (!mpc)
+		return 0;
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc_tx += mpc->mpc_ring_count[i];
+	return mpc_tx;
+}
+
+int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+
+	if (!mpc)
+		return 0;
+	return mpc->mpc_cp_rings;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index cd3f268a3a29..7a7d81197ea6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -35,6 +35,8 @@ struct bnxt_mpc_info {
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
+int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
+int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -43,5 +45,15 @@ static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 static inline void bnxt_free_mpc_info(struct bnxt *bp)
 {
 }
+
+static inline int bnxt_mpc_tx_rings_in_use(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index edcc002e4ca3..d57059722f5b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -640,7 +640,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings * 2;
 	else
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings;
-	vf_tx_rings = hw_resc->max_tx_rings - bp->tx_nr_rings;
+	vf_tx_rings = hw_resc->max_tx_rings - bnxt_total_tx_rings(bp);
 	vf_vnics = hw_resc->max_vnics - bp->nr_vnics;
 	vf_rss = hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs;
 
@@ -903,8 +903,8 @@ static int bnxt_sriov_enable(struct bnxt *bp, int *num_vfs)
 		    avail_cp < min_rx_rings)
 			rx_ok = 0;
 
-		if (hw_resc->max_tx_rings - bp->tx_nr_rings >= min_tx_rings &&
-		    avail_cp >= min_tx_rings)
+		if (hw_resc->max_tx_rings - bnxt_total_tx_rings(bp) >=
+		    min_tx_rings && avail_cp >= min_tx_rings)
 			tx_ok = 1;
 
 		if (hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs >=
-- 
2.51.0


