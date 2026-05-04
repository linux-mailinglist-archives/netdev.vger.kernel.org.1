Return-Path: <netdev+bounces-284100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIk3FHUz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:01:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B41254C5119
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB788303E4CD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3543FE656;
	Mon,  4 May 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GNSanxp7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F643FF8AA
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939159; cv=none; b=eYUXESZE66bSmDoaXeG/iubMK3e8GBRvhn3wBxDX4IRf0As0UG4wMHQWVNhuRN6JgUt2eJROkBAFJA5KslFYopdKwQYezX5UOS18PGPSnKNhw9oY/WGhyASnAdAcHfcUwUqzb9FQSSGoE5OlRg3qPbrz5JIiHT9+gr1x3Kyk3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939159; c=relaxed/simple;
	bh=hpLMRfNfBiFMk8K6+flycahMklaNqqW/H8GezD7lsAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFF9gAB5DIhL+zm3tCa9ImwQ0QKeKqkIhyHGnSiAY84z9yKDI8MvA8tfffs3rHEJQPQzjo9nP1sPCgxJ06ciadiC+k2jxL7iX0dEbsjh8ZT//dcHSOVdC51mctAWPSwfDExD27pfi00RzyIwlai9q3Nmgher3le0PVp8oygygsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GNSanxp7; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7bd5c582c6cso44885267b3.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939156; x=1778543956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S11ZbJtOz1z93wUQGG+AobMaMoCJZtoyjzm+cLr7vrI=;
        b=PcYxhH7NhRSX8idih1LhPySRJIa5SvlYfz4msONw06ar4E0FhUH2ReItjT5aB7Kb8k
         dziTiXMpIFFiqLEYSFbbK/mI8y9BgcWSpQnP+kuGSaQbuu4bV9cKKfbFvGDaxwKjxvke
         ZbGPgD/kbeUmAgkUYMS80SxDphiuvkQA6mc6sgqTCd6at0+f7Rn2AvDOC4b8E6QZm+hm
         XBrPBUdmQoyVTBIPQH5VtNjCer3erBZRkfBweyWUYAFOmfnvkth862ssKhowz/K/5Zod
         5UG87UEmUEbH8ym9CMJKmoF1q5MX0eUg8cRZ4KFQyYMfoQyKAnCHQYEiurddkK9Hu9Uv
         Ufbw==
X-Gm-Message-State: AOJu0Yz6O6hQZV1eq6Y5Wwp6m2ZYCXp9LSdFj5YGQJc3bVNrqA54bsnW
	jDw/3uq1by1VeDgOIuOTBeZmaQ0Bdx+smy/zfvC8IKXs4KEPk2iEhM57CpfJ+YTV1lEtLWkxVtQ
	gbKHaot/SuEoCaU8mLxEpGn8qXaJa6J7wSS4Gv3RV9w/N6xr4r2yBEqIKl5rsoaOBbGrETQL34r
	sh3RmW352qQTb923AWPgP9vXqVDIQujmRd3oXu8LmxQeyTarw1OOFi4pA0ASNmccTwBXRotkRMq
	F01OCdvjNE=
X-Gm-Gg: AeBDietONYCQhXNwsu3grSRpPH7gBod1T2fq9d4c0Ok+uZDphxVTHuuMlM0N7C+jaLW
	W+RgqoIf5oqtVAgYfX9L5a68kN+yjLfz8WE9Z7uZCAHCEvoGv7k/FgzXz9lD0BfgY3jK2v5MGa7
	pC7iLf8QcwWrRxAI3irXwWIRlV7TEfaEee7XRaugz2LqhoWtikk4LoS9GesJfploqOFXiivM1N6
	fi+y8kxRMbgKMBTqy3sFGlJQ4oG6HmvbiohABYhMusg/E/MAhkPYWkki29jHv0WMeYw+oMjLVca
	Mybf3Utd0BBA44mKwTlUHYe/kfU7CYaO5TW0ZUgXzkJK72wQa7IVUOWDXx8GoT3W33+ZSydCRGp
	8mCKG46Sm97kSRK0xTwnJBNBcWyQWesfSh+qHq55v2Q3at5B9KrT/vhNuirU3TAlGofbmmMS7ry
	kTQyMxT+0oHnw8Pg8=
X-Received: by 2002:a05:690c:6c0a:b0:7b6:f4f:f05e with SMTP id 00721157ae682-7bdac60270bmr10055947b3.40.1777939156628;
        Mon, 04 May 2026 16:59:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7bd66526065sm6867407b3.8.2026.05.04.16.59.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8dd61e9d1faso1261893685a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939156; x=1778543956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S11ZbJtOz1z93wUQGG+AobMaMoCJZtoyjzm+cLr7vrI=;
        b=GNSanxp7O8d5yoNaAzCbj5eLOqYcZex2WZqrUtEGRVpr8klA00ecWH46i/5oh27rW0
         Msw+SDsc9dHDpiFVgYReN5C9heBDldGvRdaHgVnyGi5LSlORGPrxbs1+VKyX8bCefg5Z
         Qj58fyAcNTCd9XfuMfajjKnJHFcsHUxNOqRBU=
X-Received: by 2002:a05:620a:290e:b0:8cd:8938:f000 with SMTP id af79cd13be357-902e4c66736mr176487685a.28.1777939155765;
        Mon, 04 May 2026 16:59:15 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8cd:8938:f000 with SMTP id af79cd13be357-902e4c66736mr176485285a.28.1777939155273;
        Mon, 04 May 2026 16:59:15 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:14 -0700 (PDT)
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
Subject: [PATCH net-next 02/15] bnxt_en: Account for the MPC TX and CP rings
Date: Mon,  4 May 2026 16:58:23 -0700
Message-ID: <20260504235836.3019499-3-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: B41254C5119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284100-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

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
index 978c82a7a625..5c7dabef35e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7743,6 +7743,11 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
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
@@ -7783,19 +7788,28 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
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
@@ -7987,7 +8001,7 @@ static int bnxt_cp_rings_in_use(struct bnxt *bp)
 		return bnxt_nq_rings_in_use(bp);
 
 	cp = bp->tx_nr_rings + bp->rx_nr_rings;
-	return cp;
+	return cp + bnxt_mpc_cp_rings_in_use(bp);
 }
 
 static int bnxt_get_func_stat_ctxs(struct bnxt *bp)
@@ -8045,7 +8059,7 @@ static void bnxt_get_total_resources(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	hwr->cp_p5 = 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		hwr->cp_p5 = bnxt_cp_rings_in_use(bp);
-	hwr->tx = bp->tx_nr_rings;
+	hwr->tx = bnxt_total_tx_rings(bp);
 	hwr->rx = bp->rx_nr_rings;
 	hwr->grp = hwr->rx;
 	hwr->vnic = bnxt_get_total_vnics(bp, hwr->rx);
@@ -8151,8 +8165,10 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
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
 
@@ -8189,6 +8205,9 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (bnxt_ulp_registered(edev) && hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
+	hwr.tx -= bnxt_mpc_tx_rings_in_use(bp);
+	if (hwr.tx < 0)
+		return -ENOMEM;
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
@@ -11465,12 +11484,13 @@ unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp)
 
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
@@ -14865,8 +14885,10 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
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
@@ -16558,7 +16580,8 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
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


