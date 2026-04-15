Return-Path: <netdev+bounces-278824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFQgL3at32lCXwAAu9opvQ
	(envelope-from <netdev+bounces-278824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D6405DA0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 157CA314CE50
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA893DA5CF;
	Wed, 15 Apr 2026 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fWUa4DjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C13D9DA6
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266204; cv=none; b=JpUKT7N30SGsvEv4D3TKA2GncddyT1uULLxNt77EvHd7ZH+jGU9a1im/7nBxrDUwHw25aFA5aE66tdoFsGpcs4pxm1gmVlBczSFglXsmTCNBLHEFJJAhDLFL6Dxq/bmIy4YqYvb5a4McAejeJDSwJFfoLPKGA1Y28La0/rEeybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266204; c=relaxed/simple;
	bh=d3x2gNn1Bbyg1yw4s21emyIabKpOHh2eOaQ/OxOuP4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgjVdzRp0QKKv6RiW5s+SoW2PbB5b4RSxCO5sCMpxrOMLJgW3XGZb+Uscu/3xTPKEQV8ZtQcspQfeHSySbBgEsjI9er2kix1b+W1wQKUNeWcRHBYJwrT4VlVfUoVI4WrUobcw7prfg29DfoHYpWGyMwv714cA81d7X++tpjsQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fWUa4DjV; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-953acf7ae20so3866841241.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266202; x=1776871002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84sFWA5iPQtCuiPSRotWoZ/dQClTvY8wWRS2hHonCSY=;
        b=aTL9x/4KrrJW4pr5roWvxzZEV7PZ2e1l3a5628+vV+0yWTiCkAtk0ZOSfDBaAuybhO
         NSQGn7BoiG+RYqJZCg1+tsID9mVkDYrwyenuPPMZFWuQ7t28XcP02vpoaXGVlqMkWK8H
         HnmcyTWSremIG5DmECOw2uYEYX6JA2vJbnVN4tpL7r3mmDqmUe7t83dfzL72Zqr8JVOI
         OYs3YrZdOj+4rwZjMn4t91n3VnA3LBaik8nIo3ULRmRJqrOFKN/Sg0kEcSk3XviwMSMf
         PoBW5EvLYmByw/mNIFLwiq7s5NDo/UTRoX83o8F23NZcD4au6A/3Uu4boX1K/QXidLVA
         9+Lw==
X-Gm-Message-State: AOJu0YxHjFa0FX18YnlBfRTCggmkavT+ITsLlm6qn1q0/YV7ZyyvixZY
	/9PD/dRAlOAYNt799uZ10DiVm9two7VEJgAt4JJwYCEcyfPjPoPM4OhYmbqm1Wha2huZIK0DnnT
	1BY1+937WmECqpJC5P41aKXYLs9bnVZszqZcoTPxJTCLQodanp3L4ZH2MTgxm4Dr7adiHxo/VEA
	jJq/zN1JctamvjLxP32MOIPSfTAdGpiCDdDsVP5AS4eRv57+I0A/kEEi0Wmvostq/6XpO5QRE/C
	prsN0JtaQ==
X-Gm-Gg: AeBDieuRX0zAL8+bl/MIPZj672ogFafVSgKq/w1tlmhXw3YrxYf94kMf+F7dF1HK+Mc
	MTEKmFNE27KIg5kgYj03ytiACr4KJkaMTwoPoEDHoFqmKm60pJ+N0QvkwdlphUFX17Ex4Hkf1vo
	zO8hIDWwiiPuHeCbFM/K7/pqSYpQprlDSwNi8EtO7C9LrztOCGzRS/cCKm6mEe3URzm9VPSGaHk
	5R29kY73wfDdbkeZ+RwHsZjVHFiNb3UqMR2iF3zxx3kPIxoez2JteOkz3330RyLbpgnI3jy7Xuf
	D3NRd0S3iwrJGE0dcVbY/iCJv3eQdsth9SoLjMN9qLynCN+aMOmMdUCoIiqBsWD1bxvfkkTCHiR
	UCLy2OznM+3gAzVuDZZziitugPyVrLpec9sE5DgRWRG3AQDRHujV41Zx8fzuSL7IygdWv05zfSJ
	VSkBiPD8Mznxp1/JU3lKyUhmytGzLCYognIkzgky0jr51cvy+oV161dJdOpQ==
X-Received: by 2002:a05:6102:1623:b0:613:3fff:febc with SMTP id ada2fe7eead31-613400002cbmr685304137.2.1776266202336;
        Wed, 15 Apr 2026 08:16:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-612ce7247e5sm130244137.13.2026.04.15.08.16.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:16:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f5baa5418so1256236b3a.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776266201; x=1776871001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84sFWA5iPQtCuiPSRotWoZ/dQClTvY8wWRS2hHonCSY=;
        b=fWUa4DjVoDCngqsV12avUtWs0yoRu1r9e9lMWGUZRDHAZUQGmPp4y/d3jxd1+/oFya
         KdabwsWySKKFcS0FuYFgpC9pQm7TbpLzC08NpHY3gDiC71pHsN1klkZ//GilEwAICzcQ
         /6wWPBm0jBtQGIPNU8Ri53C7/tR4f6vBEVqjA=
X-Received: by 2002:a05:6a00:8c0d:b0:82f:4bcb:a9d5 with SMTP id d2e1a72fcca58-82f4bcbaf89mr5810536b3a.14.1776266201018;
        Wed, 15 Apr 2026 08:16:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c0d:b0:82f:4bcb:a9d5 with SMTP id d2e1a72fcca58-82f4bcbaf89mr5810515b3a.14.1776266200579;
        Wed, 15 Apr 2026 08:16:40 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e0f15sm2996555b3a.35.2026.04.15.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:16:40 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsrama-krishna.nemani@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v2 2/2] bnge: remove unsupported backing store type
Date: Wed, 15 Apr 2026 20:46:21 +0530
Message-ID: <20260415151621.1104956-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260415151621.1104956-1-vikas.gupta@broadcom.com>
References: <20260415151621.1104956-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278824-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 220D6405DA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The backing store type, BNGE_CTX_MRAV, is not applicable in Thor Ultra
devices. Remove it from the backing store configuration, as the firmware
will not populate entities in this backing store type, due to which the
driver load fails.

Fixes: 29c5b358f385 ("bng_en: Add backing store support")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 94f15e08a88c..b066ee887a09 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -324,7 +324,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 	u32 l2_qps, qp1_qps, max_qps;
 	u32 ena, entries_sp, entries;
 	u32 srqs, max_srqs, min;
-	u32 num_mr, num_ah;
 	u32 extra_srqs = 0;
 	u32 extra_qps = 0;
 	u32 fast_qpmd_qps;
@@ -390,21 +389,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 	if (!bnge_is_roce_en(bd))
 		goto skip_rdma;
 
-	ctxm = &ctx->ctx_arr[BNGE_CTX_MRAV];
-	/* 128K extra is needed to accommodate static AH context
-	 * allocation by f/w.
-	 */
-	num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
-	num_ah = min_t(u32, num_mr, 1024 * 128);
-	ctxm->split_entry_cnt = BNGE_CTX_MRAV_AV_SPLIT_ENTRY + 1;
-	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
-		ctxm->mrav_av_entries = num_ah;
-
-	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, num_mr + num_ah, 2);
-	if (rc)
-		return rc;
-	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
-
 	ctxm = &ctx->ctx_arr[BNGE_CTX_TIM];
 	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, l2_qps + qp1_qps + extra_qps, 1);
 	if (rc)
-- 
2.47.1


