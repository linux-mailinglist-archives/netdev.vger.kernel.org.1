Return-Path: <netdev+bounces-299166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTODANBXLmrttgQAu9opvQ
	(envelope-from <netdev+bounces-299166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:27:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EDA6808EE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=X6wDpGTc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299166-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029CB3021714
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D73932D1;
	Sun, 14 Jun 2026 07:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C433932EA
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421934; cv=none; b=ins+Lw+pCDKmJfhd15+70YrVV1qPKDVLp0qYcmro8A9a2IsrRiZlyvxEKjIGWoygZK1jfMwX+O4DcRVo2BBftK7FlwtdFlppNut9kujdZOZP/2tgototaUkCHr0y84eguQmUWrDG1kZjgyxzGfINCHwJHeverFkZUSESriCpfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421934; c=relaxed/simple;
	bh=nQCNXmnNybwCjMnEiWIO6gEr1knlTJ4G+NvjrDjluzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fN1vcm5Rxie5Bstnxa+m75UOHeAExvc/VJezhYVuMs4/kvaynXdXtv8CZP1YbZCYzBogCuPQGK/2HwpSPJBOc/l3HdI0Yk7vm/VZ8iFuQO0yegIeKX354PC/QYpudJw47k5ezpPuFslDVG50iduz4GR9LHtPlph2EKMlgBJR60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X6wDpGTc; arc=none smtp.client-ip=209.85.221.228
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-59d07df448bso1721215e0c.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421932; x=1782026732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFcoqWn/lqxmw0cgFIfBqn19kLr1bNllypCVcokWBUU=;
        b=RYtx68TY+xG/z6GquOqgNcf0ZN0ikv0agJHF4H1mChrK/sMKnhDqCIU9F78mOSvbEI
         6Z2wRLzygJldwUcoW3BzQhtUCcD3mQrWrE8sK+9hSJFRZkiTXWI02zJZ0cfatWZx82yc
         3CW3JKxyFdhPVeWRLiiL1zpGVkZsw8RfGf/rxbmGPVWlPdCdliaf/+89GdMQQQw2VQvf
         7quYBChdVPyqntgRhcIHCRRWV4s3TZfGOYC4+d0HIuH7G/2TL+xbGUvPlCnM8tlt0wOk
         iRB+ig0w2LWs9J+TR4h1PUCE2hb5CWzYhd9HHFAeZhsQAX+LPfhp9HxXwrG9a0Wjar0n
         5mzQ==
X-Gm-Message-State: AOJu0Yw3EO1YRAcnFwXFncRJus+PXT5qHetkUQs9w9llTvRHVr/GUyPG
	QlwikzPcqMA0A4YHUwGD7VPhVuEksCH2Ny09G2VyKuhkYEAZS6s9v61BzfogpBcfMvalHwxWr5d
	E+351HfwsUqqg7oKxpqHHRtUpJtoh7/kWMdIqd1P6WdXWN0LvD3O0JVpWGl8qSPRptOhtso/0r5
	ZEugs/Du1zCgCp49H4yor7nlvkcGSSETYXWtqmfv4gdXYPsZCRAJ/3osz7VrQZsoKboT56fqL0D
	wOwUuKEr4I=
X-Gm-Gg: Acq92OFkRn/TsVHb2kPmZHZbZH5bJ3B8c+AJDmXfiMu+eVVzbW7hWeg3Fl0l3IzxmVd
	p5GHhs35Aa1ATCcbkK0fIEGtoYm/G5sty2lk4gBDlMnBNHGEHvYkSF6DrYkv3Lt/w5d/gfJIQ4R
	ByqW067hYNNHWmG5oVlILPbpew71oWQX/6kErdP+POsI6Ii6K0HBlQyd9+YKWZVdh5s1anAonns
	GG4jeTJZ9MSiGfsc+DD5qRo6tbfwDF5Qy5DyloLh/8I31Z3eAPpJPCBvQetIIJ8285NBe8Hj4JR
	cWSZrxm5WbQIjax272oZJGpEMQsZzh7cBnhDYjh4fZRcWj1bN0fT/wQ5g8fg7cZFBO9NMLkvVDC
	N1ebU/D9c8RX6t8mINb448xcQcXpabkOPfbprOrv5TjEzAdy7X9zRFg0JBjRj3F6FM8+FFOgCCu
	oMR03zE3G/bjKRKSTkFubQhiWX7uzNcGqy/cOzgLCVIQfHHqGTG06HARrPRWg=
X-Received: by 2002:a05:6102:2929:b0:631:4580:6a33 with SMTP id ada2fe7eead31-71f60a17028mr3440235137.21.1781421931944;
        Sun, 14 Jun 2026 00:25:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7208725ac6csm90722137.23.2026.06.14.00.25.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3080bb0267dso5317240eec.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421930; x=1782026730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFcoqWn/lqxmw0cgFIfBqn19kLr1bNllypCVcokWBUU=;
        b=X6wDpGTcK6CG99dbru06dVccKuzGk6PCikwa9vra+ZJchE9M4yv326upju+dCbot01
         nT9IcVB0nbvRZG4dRRm0PqMRzu5KGqbcMBTMgyEI5N5IVih3Csvw16IL6JgBaj2qzGIT
         6L4kUkN8rdbcoSXts9P7WoR9b32t6g8U/GCYE=
X-Received: by 2002:a05:7300:80cb:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-3093bf08cd9mr3250127eec.20.1781421929627;
        Sun, 14 Jun 2026 00:25:29 -0700 (PDT)
X-Received: by 2002:a05:7300:80cb:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-3093bf08cd9mr3250110eec.20.1781421928997;
        Sun, 14 Jun 2026 00:25:28 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:28 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Sun, 14 Jun 2026 00:24:00 -0700
Message-ID: <20260614072407.2761092-9-michael.chan@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-299166-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57EDA6808EE

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
index dd8b3e09fd2d..730af6aee0c8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7785,6 +7785,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 static int bnxt_hwrm_get_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
 	int rc;
@@ -7845,6 +7846,10 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
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
@@ -7915,8 +7920,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
+		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
 	}
-	req->enables = cpu_to_le32(enables);
+	req->enables |= cpu_to_le32(enables);
 	return req;
 }
 
@@ -8318,7 +8324,7 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
-	u32 flags;
+	u32 flags, flags2 = 0;
 
 	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
@@ -8332,9 +8338,14 @@ static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
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
 
@@ -9748,6 +9759,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	struct hwrm_func_resource_qcaps_output *resp;
 	struct hwrm_func_resource_qcaps_input *req;
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_RESOURCE_QCAPS);
@@ -9785,6 +9797,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
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
index 954c679e0290..53fdc45f8020 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1362,6 +1362,15 @@ struct bnxt_hw_rings {
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
@@ -1396,6 +1405,8 @@ struct bnxt_hw_resc {
 	u32	max_tx_wm_flows;
 	u32	max_rx_em_flows;
 	u32	max_rx_wm_flows;
+
+	struct bnxt_hw_crypto_resc	crypto_resc;
 };
 
 #define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 0777a26600f5..e1047b4284ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -80,3 +80,35 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 	kfree(bp->crypto_info);
 	bp->crypto_info = NULL;
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


