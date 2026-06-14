Return-Path: <netdev+bounces-299164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9TiTErdXLmrltgQAu9opvQ
	(envelope-from <netdev+bounces-299164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3166808E5
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=MCz8YKHQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299164-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFE0302F0FC
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95F3932D1;
	Sun, 14 Jun 2026 07:25:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17618392C57
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421930; cv=none; b=JUicTk95VPjBH4Km/NP7bnLe0XmN4skTgTpnAli2s4EMchG9/9AZdLVP4u2oirPUOUu53ZV/StwrBvkFUmRsR7NMbYlDk3TOTGa8/9MNSZnHB++h7QmO3UqW5kjM2nRp2cNqcz4YNHpNqMe9GAP/sMiTj1LVq1X27qLrITf+NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421930; c=relaxed/simple;
	bh=HPeNj2VkQeWxx6lqN7rTPdIS/jEHHMWjaMJi8bheiIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1ppV0Iqg1B8Chygr5Fj/ngonoa9m/rZ8XK/VJMojuij09namoKBfIzX8NscRbzq/5tHaURY/b1PgsPiBo6tmbabnuGc63dzvZal2/XSa9jeIqeh1rYD+nmo/2+G2uoUvXVOJKrnmn5eDIMf46GhJ0xpbcWEq83W7bU9zlN9p+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MCz8YKHQ; arc=none smtp.client-ip=209.85.167.226
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-4864a5c83f1so1520519b6e.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421928; x=1782026728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+M2tzTdQDYTo9AWOWIdZL8T30IDS4n8O/5MfOBHCnU=;
        b=JuAUaYQZrc4NN2PP3J2DoiGr2siipeoecMtn8G2y2tEQMjbZW/oUV7PmoKvFtrTGrp
         yJNl6tuZSfa7Oalc2egi1wyeEYd2j2EZ8xeitXaGYgiFkC1W7rKfgyMttQ18MklI4v/o
         G4ougntTF5ytBggz6OnWOCqgw8Vh7lpLTVdU09nzt6XPuaWg9BvvV5GfLWEnXFNC9Us2
         DmF/pMarAnKZGX6MPWSdppPvqLJ5dN/qzVBA30x75iAA/7rvAUlOTWTyXPKj+8HTGJXf
         kM6k4qzIQWD0zxc11Xm3PJztwBePX04dr8bwMh7wyX6fVRxZ8vI4iqYl3yL6kfUmNKXZ
         nIlA==
X-Gm-Message-State: AOJu0Yzo75TAi8H+oi7U2t5JwIs/v2H2Q++ECQ4DsvYaJ1xNKVB5jfOK
	c8DFSVdE4MSLdsamnfj420G/MhT6FNXGORRgKCxmOdxGrW0XQQVDWrTqsKBksQtOgfiFpCbuXYt
	lYcPiSIq02klGtZViC8XKYH7v9C0Ks0I08V6R68gcqgOP6wOviUblEAKlhYW6FgrHz8yFmISgF4
	Zz+VVlNMTj8fTrcU6i+C8MHWh8ZKZuaRfr8bHqejWO7I1yJF03/zi3D320aLL+LO9G6F5/ljf3b
	e7/I0z0OIw=
X-Gm-Gg: Acq92OFtfTGRkLXvfud3MaUvCoafvY82UTo5J4FKSpxBFi81YVRxMgBB1DIufwfXKp5
	0TuujFQhOJKdfVUlTvXfPEj5vV+fiVn8SZ4En1W6S9sE1d4aIKoPRAFHHrJA5XD/gigyuam+Cpx
	xm+KuFanl5FhZVz8eRJ+DhzHYOE/1+g3fdIbH8KZatztzllP6arQOPVPMO6hc7phkwhI0/v8Krx
	Jx2E0LKny6fpFdT/6xtQ24SQTaxmDH8gGqvxd/caaiBcHSVlV0psK2ItAT0V5yfoSR5JiLr8UX2
	tKLWZ86OBlEaGP3WAGsRKVmuqzTi3qax1+vwy3Xr5nZH1DA8XUvzpxGZOd3XvB/J3K2E5gW9ZHJ
	TCfSf1mIzUN8z6jNc9kab3sWfE6Lm1WvcqNL8hG/ongDspbl5z+dTr+fgTqYpUkt12IrSSLHqEG
	yNidbNINuEkb4d9xF3zmOASjkuyD2j0XnhQGE0wOxRBA/jcN0HZG/HV5oQRnE=
X-Received: by 2002:a05:6808:4f4f:b0:485:6015:adcb with SMTP id 5614622812f47-4872f607be7mr6644024b6e.41.1781421927849;
        Sun, 14 Jun 2026 00:25:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4426aae12a9sm912181fac.5.2026.06.14.00.25.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-307fe856724so3470165eec.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421925; x=1782026725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+M2tzTdQDYTo9AWOWIdZL8T30IDS4n8O/5MfOBHCnU=;
        b=MCz8YKHQ0+s5m287g+UG1vcHqxI3RTCbyAjU0X16b7PODBcLZ1pWCdin21nHPnRmla
         XqaC/+c1Ss/ITe9vitGFWC9R4+H4K67cycAQ8IEot1WKWS0dUnNvGAZgObkTz2kdDSG+
         kh3ksmPB+bu5ZIArDll5A5VJ1O3XcuMeWA3zk=
X-Received: by 2002:a05:7301:5f0f:b0:304:eaa8:11ea with SMTP id 5a478bee46e88-308200e8d78mr5995343eec.34.1781421925394;
        Sun, 14 Jun 2026 00:25:25 -0700 (PDT)
X-Received: by 2002:a05:7301:5f0f:b0:304:eaa8:11ea with SMTP id 5a478bee46e88-308200e8d78mr5995327eec.34.1781421924780;
        Sun, 14 Jun 2026 00:25:24 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:23 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/15] bnxt_en: Allocate and free MPC channels from firmware
Date: Sun, 14 Jun 2026 00:23:58 -0700
Message-ID: <20260614072407.2761092-7-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-299164-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D3166808E5

Allocate and free the reserved MPC TX rings and completion rings from
firmware.  MPC backing store memory also needs to be configured in
order to successfully allocate the MPC TX rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 92 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 16 ++++
 4 files changed, 135 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ffedb9ee0454..0d6d4bb7fd6f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7473,8 +7473,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
-				      struct bnxt_cp_ring_info *cpr)
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	const u32 type = HWRM_RING_ALLOC_CMPL;
 	struct bnxt_napi *bnapi = cpr->bnapi;
@@ -7492,8 +7491,8 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	const u32 type = HWRM_RING_ALLOC_TX;
@@ -7578,6 +7577,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 				goto err_out;
 		}
 	}
+
+	rc = bnxt_hwrm_mpc_ring_alloc(bp);
+
 err_out:
 	return rc;
 }
@@ -7635,9 +7637,8 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
-static void bnxt_hwrm_tx_ring_free(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr,
-				   bool close_path)
+void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    bool close_path)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	u32 cmpl_ring_id;
@@ -7696,8 +7697,7 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
-static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
-				   struct bnxt_cp_ring_info *cpr)
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_struct *ring;
 
@@ -7731,6 +7731,8 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	if (!bp->bnapi)
 		return;
 
+	bnxt_hwrm_mpc_ring_free(bp, close_path);
+
 	for (i = 0; i < bp->tx_nr_rings; i++)
 		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
 
@@ -9368,12 +9370,21 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
 	u16 last_type = BNXT_CTX_INV;
 	int rc = 0;
 	u16 type;
 
+	if (mpc && mpc->mpc_chnls_cap) {
+		ctxm = &ctx->ctx_arr[BNXT_CTX_MTQM];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
+		if (rc)
+			return rc;
+		last_type = BNXT_CTX_MTQM;
+	}
+
 	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_QPC; type++) {
 		ctxm = &ctx->ctx_arr[type];
 		if (!bnxt_bs_trace_avail(bp, type))
@@ -11324,6 +11335,7 @@ static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 	bnxt_init_cp_rings(bp);
 	bnxt_init_rx_rings(bp);
 	bnxt_init_tx_rings(bp);
+	bnxt_init_mpc_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 083b95dcfd73..f875f130f070 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2997,6 +2997,12 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			 unsigned int start_rx_ring_idx,
 			 unsigned int nr_rings);
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx);
+void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    bool close_path);
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
 int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 7bf686459170..cd104b7ff1d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -313,3 +313,95 @@ void bnxt_free_mpc_rings(struct bnxt *bp)
 		}
 	}
 }
+
+void bnxt_init_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+			struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+
+			txr->tx_prod = 0;
+			txr->tx_cons = 0;
+			txr->tx_hw_cons = 0;
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
+static int bnxt_hwrm_one_mpc_ring_alloc(struct bnxt *bp,
+					struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_cp_ring_info *cpr = txr->tx_cpr;
+	struct bnxt_ring_struct *ring;
+	int rc;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID) {
+		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, cpr);
+		if (rc)
+			return rc;
+	}
+	/* tx_idx not used on P5_PLUS, so set it to 0 */
+	return bnxt_hwrm_tx_ring_alloc(bp, txr, 0);
+}
+
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j, rc = 0;
+
+	if (!mpc)
+		return 0;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+
+			rc = bnxt_hwrm_one_mpc_ring_alloc(bp, txr);
+			if (rc)
+				goto mpc_ring_alloc_exit;
+		}
+	}
+mpc_ring_alloc_exit:
+	if (rc)
+		bnxt_hwrm_mpc_ring_free(bp, false);
+	return rc;
+}
+
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_cp_ring_info *cpr;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++)
+			bnxt_hwrm_tx_ring_free(bp, &mpc->mpc_rings[i][j],
+					       close_path);
+	}
+	/* CP rings must be freed at the end to guarantee that the HWRM_DONE
+	 * responses for HWRM_RING_FREE can still be seen on the CP rings.
+	 */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++) {
+			cpr = mpc->mpc_rings[i][j].tx_cpr;
+			if (cpr && cpr->cp_ring_struct.fw_ring_id !=
+			    INVALID_HW_RING_ID)
+				bnxt_hwrm_cp_ring_free(bp, cpr);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index b54daf4ddd2f..cdc03a074963 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -58,6 +58,9 @@ int bnxt_alloc_mpcs(struct bnxt *bp);
 void bnxt_free_mpcs(struct bnxt *bp);
 int bnxt_alloc_mpc_rings(struct bnxt *bp);
 void bnxt_free_mpc_rings(struct bnxt *bp);
+void bnxt_init_mpc_rings(struct bnxt *bp);
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -116,5 +119,18 @@ static inline int bnxt_alloc_mpc_rings(struct bnxt *bp)
 static inline void bnxt_free_mpc_rings(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_init_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


