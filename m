Return-Path: <netdev+bounces-302801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bI8HL7u+QmrOAQoAu9opvQ
	(envelope-from <netdev+bounces-302801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359796DE25B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=R3WXMmdQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 750BF3061772
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F4421A13;
	Mon, 29 Jun 2026 18:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F73C0A05
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759022; cv=none; b=orcOBh3rLvvs+tFCnjrcwB9ZIGrfRnz67fkvhjKzS/s4XdAZ1aeyVBGT12qEfFf8oNJ0XN7OPOJpEDpGgfNYskocPFkusvM2MiAL2ceVJbi5hrtfVyccA3dQpzdn28m9AYdwuxCXZECs1EKe+OI+E22FEQ3AMSAzgPGFQprAbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759022; c=relaxed/simple;
	bh=ZcICDKB9t2FKyTqSIYgHENZp9zV1MY1m4l/QS2gtj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4XWEa4XCVLm7C7dG3a+Zy7Cx2pcUZfquw82DkjU+U2ReEGkIp+GtC7RpuVRGuN2qb2XBrcu40a5SLpUnO5+oxKJ4wkzhEcnsbV9ZLc7T+0LKWzbYV5N1HG3Q2Bx9FGzvidGRcy8oL6XWQxa7OTW3vv7TIKCKnuJQ1yE7QwqhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R3WXMmdQ; arc=none smtp.client-ip=209.85.160.97
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-448df16ab34so46352fac.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759020; x=1783363820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H0EuWosgFcVqxNq1vS3Pnz/zS7q2m+8SgGf1fCm6ZI=;
        b=LtIrK2A+oyqj69rb0NcW3gU/wHoJWw8w8KjddBN+UaxGVPCbekC5ramWuq0B2h5T/J
         QKRgfOCERfWA1d+ErL3lJJMZ7jliEqdpU3H9s/ZnsQFXfH+2IKkQwW4pFR8m94FdtEU6
         e1OzipcXcQZYnAk4yNSvyS7/EAlxTvL322rhAr+74V/vc/Q5K1oj38afEIULMejgKEPq
         WVfgl1B875BR7pPA+Idt5RDm3/95sB0vOT3uIFxPzstm7SONSZDS1ToobDbp85aCuH0U
         pF56z4g3wrw0hNY4Ry724WWf2aP0Biek1E+o6hmbEHEsN/HreZNyi0G6T9fBzCzUHFHD
         2fsA==
X-Gm-Message-State: AOJu0YwudjBDq3SjIlXNjCW5beQxskbFUbfV1Xz8gU9UhyownS2QxuWX
	/tQ9LgK608klFI9MTDC9ohl88AdM76X2lO1tDf/OyuQLjCer7BwlwZNaySxSd6W3tGb/EX0tC36
	sGa1HNc+T+HdjqI/usMXmUegHzQJ8TG8H06s2Yd0kJ6f50cd8kRMia4S91YFsF2zXR/7vu9a5+o
	U5tg08ni9cOnIfckIZhwymQS+Othk+pBgmZgzWZBHeVcRXQqqVWbUtPSj3N3ZJ3vYQExlrhpx2c
	phqN1D1f5g=
X-Gm-Gg: AfdE7clDa6sQyVFUSZDPvF1fpELyDEk6a80pFucWLuxXIrPRkIIYJ/X4KeL7dubkVdc
	nJxaYV5NPCXUvgbZmz2TeHzcJKLBKl62f036LJSifB3+ygDZjqvjrlcPVVwtmipIowmoh7Thhl9
	/XiHexwxdU9TztEW1XZgrfSqe7ku7pzvw/yKWq8YIgEW63XEakR/iE4CogCZAZyIY20MHcDPKcr
	IV9Rn3IIBLUtHDqLN6Ocbgzqj7DFds1j8TJJw/bQt4PBSEzovz9K5H03xT/+7WgczBk2RRkFjct
	GtNo3fS/u6PJMYIPNXcSNBvckww1SttWU8ULh9+SFROL7HRlEGvhtv2jfCNQ+EzvKYdDBnEYilT
	Ps61I6vTPZ/sryJ3odhnMUaWtOhqztMLB/24aH5aXu0AnsOwoAj1p0ie8B7bmLGYC+pzizH31vj
	/l8p7rtOJbCaZFiLBaUwNzYgrSV3VGLE4KyLcfI6FO3Hzm5Q==
X-Received: by 2002:a05:6870:548d:b0:43d:38f1:854e with SMTP id 586e51a60fabf-448dc66f4c8mr504702fac.16.1782759020009;
        Mon, 29 Jun 2026 11:50:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-448db98bf4dsm38809fac.3.2026.06.29.11.50.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0199faafso13993131cf.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759019; x=1783363819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H0EuWosgFcVqxNq1vS3Pnz/zS7q2m+8SgGf1fCm6ZI=;
        b=R3WXMmdQy9x0UsrsPjKNkmBy5EX+H+4y1lbx71CdD7cNsf0DF1ho6wLjv+YZg2eTq9
         3vzFg3KWKGID73MgrnZPSGUp24Vi82JMa48a08VTL2QG8L2gLURM3YSe2vaKHvSpyIJh
         yiH+uQZArrOusmKiy7V0DdcGKu/XFqg2hRXXY=
X-Received: by 2002:a05:622a:244a:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-51c1073fe68mr8738231cf.11.1782759018239;
        Mon, 29 Jun 2026 11:50:18 -0700 (PDT)
X-Received: by 2002:a05:622a:244a:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-51c1073fe68mr8736821cf.11.1782759017064;
        Mon, 29 Jun 2026 11:50:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:16 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Mon, 29 Jun 2026 11:49:14 -0700
Message-ID: <20260629184921.3496727-9-michael.chan@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-302801-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 359796DE25B

If kTLS crypto offload is supported, reserve RX and TX key contexts.
These keys will later be allocated during run-time to support offloading
TX and RX kTLS connections.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Add missing ASSETS_TEST flag when checking reserved crypto keys.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-9-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 11 +++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 32 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  7 ++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d1b546301742..38970fbcacc5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7791,6 +7791,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 static int bnxt_hwrm_get_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
 	int rc;
@@ -7851,6 +7852,10 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		}
 		hw_resc->resv_cp_rings = cp;
 		hw_resc->resv_stat_ctxs = stats;
+
+		crypto_resc = &hw_resc->crypto_resc;
+		crypto_resc->resv_tx_key_ctxs = le32_to_cpu(resp->num_ktls_tx_key_ctxs);
+		crypto_resc->resv_rx_key_ctxs = le32_to_cpu(resp->num_ktls_rx_key_ctxs);
 	}
 get_rings_exit:
 	hwrm_req_drop(bp, req);
@@ -7921,8 +7926,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
+		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
 	}
-	req->enables = cpu_to_le32(enables);
+	req->enables |= cpu_to_le32(enables);
 	return req;
 }
 
@@ -8324,7 +8330,7 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
-	u32 flags;
+	u32 flags, flags2 = 0;
 
 	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
@@ -8338,9 +8344,14 @@ static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 				 FUNC_CFG_REQ_FLAGS_NQ_ASSETS_TEST;
 		else
 			flags |= FUNC_CFG_REQ_FLAGS_RING_GRP_ASSETS_TEST;
+		if (req->enables &
+		    cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS |
+				FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS))
+			flags2 |= FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST;
 	}
 
 	req->flags = cpu_to_le32(flags);
+	req->flags2 = cpu_to_le32(flags2);
 	return hwrm_req_send_silent(bp, req);
 }
 
@@ -9754,6 +9765,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	struct hwrm_func_resource_qcaps_output *resp;
 	struct hwrm_func_resource_qcaps_input *req;
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_RESOURCE_QCAPS);
@@ -9791,6 +9803,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	    hw_resc->max_vnics * BNXT_LARGE_RSS_TO_VNIC_RATIO)
 		bp->rss_cap |= BNXT_RSS_CAP_LARGE_RSS_CTX;
 
+	crypto_resc = &hw_resc->crypto_resc;
+	crypto_resc->min_tx_key_ctxs = le32_to_cpu(resp->min_ktls_tx_key_ctxs);
+	crypto_resc->max_tx_key_ctxs = le32_to_cpu(resp->max_ktls_tx_key_ctxs);
+	crypto_resc->min_rx_key_ctxs = le32_to_cpu(resp->min_ktls_rx_key_ctxs);
+	crypto_resc->max_rx_key_ctxs = le32_to_cpu(resp->max_ktls_rx_key_ctxs);
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 max_msix = le16_to_cpu(resp->max_msix);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 501f8379427a..1a334885c982 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1363,6 +1363,15 @@ struct bnxt_hw_rings {
 	int rss_ctx;
 };
 
+struct bnxt_hw_crypto_resc {
+	u32	min_tx_key_ctxs;
+	u32	max_tx_key_ctxs;
+	u32	resv_tx_key_ctxs;
+	u32	min_rx_key_ctxs;
+	u32	max_rx_key_ctxs;
+	u32	resv_rx_key_ctxs;
+};
+
 struct bnxt_hw_resc {
 	u16	min_rsscos_ctxs;
 	u16	max_rsscos_ctxs;
@@ -1397,6 +1406,8 @@ struct bnxt_hw_resc {
 	u32	max_tx_wm_flows;
 	u32	max_rx_em_flows;
 	u32	max_rx_wm_flows;
+
+	struct bnxt_hw_crypto_resc	crypto_resc;
 };
 
 #define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 5bc31ee8d7fd..b2a96ac725ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -81,3 +81,35 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 	bp->crypto_info = NULL;
 	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 }
+
+/**
+ * bnxt_hwrm_reserve_pf_key_ctxs - Reserve key contexts with firmware
+ * @bp: pointer to bnxt device
+ * @req: pointer to HWRM function config request
+ *
+ * Populates the firmware request with key context reservation parameters
+ * for crypto offload based on current max settings and capabilities.
+ *
+ * Context: Process context during device configuration
+ */
+void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+				   struct hwrm_func_cfg_input *req)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
+	u32 tx, rx;
+
+	if (!crypto || !BNXT_SUPPORTS_KTLS(bp))
+		return;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	tx = min(BNXT_TCK(crypto).max_ctx, crypto_resc->max_tx_key_ctxs);
+	rx = min(BNXT_RCK(crypto).max_ctx, crypto_resc->max_rx_key_ctxs);
+	req->num_ktls_tx_key_ctxs = cpu_to_le32(tx);
+	req->num_ktls_rx_key_ctxs = cpu_to_le32(rx);
+	if (tx)
+		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS);
+	if (rx)
+		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index 629388fe1e6d..e090491006db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -34,6 +34,8 @@ struct bnxt_crypto_info {
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
 void bnxt_free_crypto_info(struct bnxt *bp);
+void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+				   struct hwrm_func_cfg_input *req);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
@@ -43,5 +45,10 @@ static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 static inline void bnxt_free_crypto_info(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+						 struct hwrm_func_cfg_input *req)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
-- 
2.51.0


