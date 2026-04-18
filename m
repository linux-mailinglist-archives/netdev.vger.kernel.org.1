Return-Path: <netdev+bounces-279450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBsLAH3u4mlLAQEAu9opvQ
	(envelope-from <netdev+bounces-279450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:37:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F27341FB2D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D26309C345
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E053242AC;
	Sat, 18 Apr 2026 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="de3mrvpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09F26056C
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776479703; cv=none; b=Jw5PhdTVZT/p8ss7bhKJZelvBmBnZvrFBCkyrBEdnl5qwOZleksdeKpVCINZb54uw1Hk7KYLEap2GwPQoJj+AB/5n8gwzH3fKWwEvKodou6AmNEEvXxAKxQXTCqnJqlEzmvyIlYeQYk/FNwURXzvrfrdmnR2tap8DpCMbKU8F7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776479703; c=relaxed/simple;
	bh=d3x2gNn1Bbyg1yw4s21emyIabKpOHh2eOaQ/OxOuP4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkWZ1+5T31sFP6U+GCxaJ2Q2qMHUneGfz4QTTrZOPPA/Ym6VCqlD5cz1xQCCObAl4WHSCtKrIWCGhTiY+lE14g4tmQSraJih7izF6GH4plIkXoOqm+yIY66gylygALPzGOutT+yTjmZhUaezMSs5xePKUB7gsfHJguYa7/w5z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=de3mrvpm; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c7980c060cfso5631a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776479701; x=1777084501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84sFWA5iPQtCuiPSRotWoZ/dQClTvY8wWRS2hHonCSY=;
        b=MTeT88Egyc9DeMkh8keSngQgY2dfPeRwQWnryNS8L+FTN3nmYhxlDVmaPwWd/ppJDZ
         ui8Rbz9ea4SLHm0Vs/kPSG2f0zqzLXIRtbUIMpYP2U5Bc+m1NFyQmD+SKXFYe23WqwaO
         VVnfXSJtQdL28KZMv9Z2vaLrJkLCakZ+vsJOTfOjW+Wg0hgsvIPT1UNn4XuBTF0pDInS
         a1lHlOqyNale5bbg1N9LHaXRyzvJPLKHUCA6wUPcGLTqNXbzu3o2u/4YmO/nn0kCmFc5
         vDk5WnntiTSbzNxqbtvX9s9pHjIaOaBz3D8N3YkUNB4DwI8H5YlG68E2K8jRtxCxuzCz
         /n6g==
X-Gm-Message-State: AOJu0YxQCq/wN+EXCgKgeKnMkrUkQ15GMqSRtAuu0FucuYy+mlU5V1XD
	7Yh1gbtuYAZs9xEl+ZlrluNe2xIunP7/pbZuaOdI2ChAXYbgakmKOdV3YtyHf9M/NUmajxxlRQC
	gez3oEkLJQ1mDAEnd+vINEJQYgH2sGQ9WTHADiJ41y/zLmUa7zua4VAXHH6wnCpBIKyOnC75SDm
	dZVSSb/ERRJKKTxduHCjvmwc5SVKOZGScxAAuykBQ5U9P/ycUahaExZ9caYLBv/NnJWJpEjqqCF
	i9m+Wt/qQ==
X-Gm-Gg: AeBDietSztlaG6CSZ0NsP4LEybwhqlLQ4mRgx0G7Volsp332TCYKTCgA+inc5iuK31C
	KYbzu4i2inXbxUEV96d3ORajpB4TO9CNGAAEYwUOQ8B+U9IErTXUsz7ghjQuOqHtIGqO4IddQvd
	SqrRC7nnS3NwQ22h05EieAKDwWw46kCGaMxEayLCAtd4W/o+kv855RrA5A0tvocwKFcpghimXqI
	S7EiuEJhcGHFd8/hcj8aHz2KH/aW6gDs6uIKnMyegfOWdgyvzbTqXpMH024Ehw4a7NmwZBF2kRD
	2ez8XzHV2MEUaS/AmNm4JzUYS0lMSHmo28oD9EqbILBLFW2ycQMQg1e3ILpEbAwaHXAme07hgyL
	VMh1B5K/8Xryrf7MBfUaruN4blHSGHSvIM/otjHtAqlKScaLkmRN/006EhxBOCxbzBw4M8n5UvT
	7pwuqX888K3Kizv/uXKDw5QGrfWvq1eCMHKUEZyLgUHvgrFEmHwxX+ld+b3WvPONuYeQ==
X-Received: by 2002:a17:903:88e:b0:2b2:ec46:dfed with SMTP id d9443c01a7336-2b5f9f79455mr37993545ad.31.1776479701234;
        Fri, 17 Apr 2026 19:35:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5fab20879sm2433115ad.53.2026.04.17.19.35.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 19:35:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b454cac322so11757785ad.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776479699; x=1777084499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84sFWA5iPQtCuiPSRotWoZ/dQClTvY8wWRS2hHonCSY=;
        b=de3mrvpmmxSFZNwk4NIVT77u4woXevJJlMoDtzgHspJQj+wTF79vIwfldl6goNO7qE
         XdKL6IHrC35WHCsM4BUCStBzSkOg5NKzjXVOZxGG020c6JE3oXb62Wk8hkxypBRKatY3
         9wrhXikkcpi84lZNi6d1VERPMgBtuWJC1r+Dk=
X-Received: by 2002:a17:902:e54c:b0:2b2:ece2:bc1b with SMTP id d9443c01a7336-2b5f9f63726mr57642485ad.26.1776479699356;
        Fri, 17 Apr 2026 19:34:59 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2b2:ece2:bc1b with SMTP id d9443c01a7336-2b5f9f63726mr57642195ad.26.1776479698916;
        Fri, 17 Apr 2026 19:34:58 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm33427715ad.20.2026.04.17.19.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 19:34:58 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] bnge: remove unsupported backing store type
Date: Sat, 18 Apr 2026 08:04:38 +0530
Message-ID: <20260418023438.1597876-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260418023438.1597876-1-vikas.gupta@broadcom.com>
References: <20260418023438.1597876-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279450-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6F27341FB2D
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


