Return-Path: <netdev+bounces-247208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53115CF5BF4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03D1A300E621
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65D63126A3;
	Mon,  5 Jan 2026 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RKOh6zkE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113A3126D7
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650360; cv=none; b=UeF1opaNjoQMLcmy8kz7B04TE8WmuteonxzqT5f3qlJtE4lFaxHJKy0ExEsG1cu3SGxCFN4sWlNR4z3GQLTBhcZ7EURBhvJhf1ER2cR3AgCCv//ojk34EBEG9+16g04aVPWqOluA7riDMG7K/vwhbBuanVEk5poGsTVu5YBaGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650360; c=relaxed/simple;
	bh=ul1Ac3V/B60/F2WMkTXYIjv0mwsahIkaQoG0gRQ6OjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaDK470JVh6ywrGx2neClq8ytnXAL98DKuQ8UlJ6pOslJSjbkyNZPIh/A8ZOfNHcfanCylaowN5zjicJr1EKIlxzrKDE5HSDTB4zh+KijoPa78Rxon8Ri5RR5lUXTZsooiL4Wo9bH71PN950N2DVWXsWQ9Xx+iFfzqFxZZ6TJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RKOh6zkE; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a12ebe4b74so5225935ad.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650358; x=1768255158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te25MviDlrxzlq2B2duHSN+1gL9C//NivqToMQtg1Ow=;
        b=Sy1i+Vsgtv1yzNcnlnUxZSPN+WzU7sGUptgvQbllPuLNiXn2aK1JPkywOy4SwTFplB
         i9MOLVqH2z3PEh27HluD62TXOrhIy7RPSOC4lZ6htQ192R4FKNr42m0gzLTeaIOt5zOt
         KLLlkyDRdm1+ASkz8USXoXFamLo+wlaYxYGUcwa6c87+q7XC0Jiq4Pbr1wCYUOWoHMZk
         npAD26ZuQhT+VeF2HQNT03COtGvWXvDQk5asm0O2mD3GkqhbMN3dzuCda+f+FPyTsx2A
         QBiidii/0vsgdx2yh/OcstsqJxsYoOdrfNuovkJ6ZUzyHUfYkqsHog48tmySsMXy4V3U
         YRMQ==
X-Gm-Message-State: AOJu0YxplkopwENzFhBYOJbclgQFgttCsnrD863deHe5zucgdOMqJlWk
	WWOrrzESnrgexqCjrBbRGurz+HP8Py2AwNus/hu6Ca8agb+thoekTYk5JXe+FTlPLpXDubr+2N6
	FFdmf9ntieE7Er/TGqBIUD1T6TvhfKGqMxkFXwX+wmdBQrpQNBMurV+x3icx7TqQjLyUUJjHyCm
	1TBRIDO0Fz+HDwUEYvecqwb91n4N5ehWqf9DEkJTd5U1RVoE/q8YRIAsiSdtVKVv+DtsUg7mLdZ
	P1Qfpuh/pE=
X-Gm-Gg: AY/fxX73GJeeEawDsWEvUgxKiL6ILsN0Y4WND4e6TizXcGCad1EzbaUeTrwVnhJdAV/
	N+OzxsMFM/CW3KpRvs6M1u62nnK79LAmU3DjJcpoAxJm4s0uVZ7iYGPEPVjs1440BlaQZCNAZHE
	17Hr+We/vxOQNPrBWQ3+WhTKutHtV5KDMI4WfcucSzSngq+CbJ4w9esew7N8KiPB0lrRGY1Dyh/
	6e6vMGMeXIhWKiJD28msmELuRI8SjqPDV4ME+ql1+XaVO0m8gSMaZxfFHYbxAQXudk/Gvpj0oSV
	FkPy/zQ8tfS2wDiKJISGUYP4IYHHKqI+rmBZr5GwKN9ZuL+bc7nm+baUnsCO0W0ZW5ZomQcTIAr
	Aak6BXe2WtZw4xGNWstlONPsAIYz+r9zgH6/2b3DQB/Hi2Ae11tml+ORQrs98/Izp6/ZeMSXb2t
	ixiLCRIHOqSvkpdbTSAIbsZbGFPjgAnuJ6BUbswiNY3Q==
X-Google-Smtp-Source: AGHT+IGiJvWqe4SLcVfq96oW9mdXRzRiSlLatUfRxFBgo2F0tqTY3y8DwOJjUh6fzytciBvJ6fYV4Xd1wG7y
X-Received: by 2002:a17:902:e88d:b0:295:5da6:600c with SMTP id d9443c01a7336-2a3e2d789dbmr10846545ad.2.1767650358530;
        Mon, 05 Jan 2026 13:59:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae700sm412715ad.34.2026.01.05.13.59.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee416413a8so4565761cf.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650357; x=1768255157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te25MviDlrxzlq2B2duHSN+1gL9C//NivqToMQtg1Ow=;
        b=RKOh6zkEOysGxi5rWjF8PuS2gLj1OdEY8yHKeD+61cljUxrpc42OaIop8/tPJH7vCk
         rXvhRNQeJ4fYJl4071Xd19f8ezdMkPkqMP3PoxJbBEXa7Rx3lf0ojNjtI3wXftm7lmsD
         k1wRt+K3v65PtFY3VQSOMTqXxm9SiuCh4pLJY=
X-Received: by 2002:a05:622a:2447:b0:4f1:bdba:8cfc with SMTP id d75a77b69052e-4ffa77dfa39mr13972011cf.65.1767650357323;
        Mon, 05 Jan 2026 13:59:17 -0800 (PST)
X-Received: by 2002:a05:622a:2447:b0:4f1:bdba:8cfc with SMTP id d75a77b69052e-4ffa77dfa39mr13971871cf.65.1767650356904;
        Mon, 05 Jan 2026 13:59:16 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:16 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 5/6] bnxt_en: Use a larger RSS indirection table on P5_PLUS chips
Date: Mon,  5 Jan 2026 13:58:32 -0800
Message-ID: <20260105215833.46125-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260105215833.46125-1-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver currently uses a chip supported RSS indirection table size
just big enough to cover the number of RX rings.  Each table with 64
entries requires one HW RSS context.  The HW supported table sizes are
64, 128, 256, and 512 entries.  Using the smallest table size can cause
unbalanced RSS packet distributions.  For example, if the number of
rings is 48, the table size using existing logic will be 64.  32 rings
will have a weight of 1 and 16 rings will have a weight of 2 when
set to default even distribution.  This represents a 100% difference in
weights between some of the rings.

Newer FW has increased the RSS indirection table resource.  When the
increased resource is detected, use the largest RSS indirection table
size (512 entries) supported by the chip.  Using the same example
above, the weights of the 48 rings will be either 10 or 11 when set to
default even distribution.  The weight difference is only 10%.

If there are thousands of VFs, there is a possiblity that we may not
be able to allocate this larger RSS indirection table from the FW, so
we add a check to fall back to the legacy scheme.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9ab9ebd57367..9efdc382ebd7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6558,6 +6558,9 @@ int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (!rx_rings)
 			return 0;
+		if (bp->rss_cap & BNXT_RSS_CAP_LARGE_RSS_CTX)
+			return BNXT_RSS_TABLE_MAX_TBL_P5;
+
 		return bnxt_calc_nr_ring_pages(rx_rings - 1,
 					       BNXT_RSS_TABLE_ENTRIES_P5);
 	}
@@ -8068,6 +8071,11 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	bp->rx_nr_rings = rx_rings;
 	bp->cp_nr_rings = hwr.cp;
 
+	/* Fall back if we cannot reserve enough HW RSS contexts */
+	if ((bp->rss_cap & BNXT_RSS_CAP_LARGE_RSS_CTX) &&
+	    hwr.rss_ctx < bnxt_get_total_rss_ctxs(bp, &hwr))
+		bp->rss_cap &= ~BNXT_RSS_CAP_LARGE_RSS_CTX;
+
 	if (!bnxt_rings_ok(bp, &hwr))
 		return -ENOMEM;
 
@@ -9558,6 +9566,10 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	hw_resc->min_stat_ctxs = le16_to_cpu(resp->min_stat_ctx);
 	hw_resc->max_stat_ctxs = le16_to_cpu(resp->max_stat_ctx);
 
+	if (hw_resc->max_rsscos_ctxs >=
+	    hw_resc->max_vnics * BNXT_LARGE_RSS_TO_VNIC_RATIO)
+		bp->rss_cap |= BNXT_RSS_CAP_LARGE_RSS_CTX;
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 max_msix = le16_to_cpu(resp->max_msix);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2a2d172fa6ed..476c5684a1eb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1369,6 +1369,8 @@ struct bnxt_hw_resc {
 	u32	max_rx_wm_flows;
 };
 
+#define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
+
 #if defined(CONFIG_BNXT_SRIOV)
 struct bnxt_vf_info {
 	u16	fw_fid;
@@ -2412,6 +2414,7 @@ struct bnxt {
 #define BNXT_RSS_CAP_ESP_V6_RSS_CAP		BIT(7)
 #define BNXT_RSS_CAP_MULTI_RSS_CTX		BIT(8)
 #define BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP	BIT(9)
+#define BNXT_RSS_CAP_LARGE_RSS_CTX		BIT(10)
 
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
-- 
2.51.0


