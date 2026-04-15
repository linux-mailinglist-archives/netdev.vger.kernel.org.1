Return-Path: <netdev+bounces-278823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHjYNWqs32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E58EE405CB9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4D66301A2D9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C5E3D4123;
	Wed, 15 Apr 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cUuLT/zH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F463D3D1E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266200; cv=none; b=Y2u1uHgNcl+F8jCUtzFJYHoOiFIv2iDb1LHPcZv6l+Tf0zrRAIZpyHIQn3ZG5XppoadoWPvnUKMIhbwkSx5zz5Ian4PpzuK5WfojphVyjdJ5z/q/x4aOGKO/eIZHrGvuylGDXXAtLOGD7+/tF6qKsY8YCx9idYg91UQjuZsTvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266200; c=relaxed/simple;
	bh=iJbHwGGTXYAXkn2h2ic7IXpD3QSIM1EdEh7LVvB1n7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhzFnoOhr1U6VOmVFxFxmvpwZsu5jqLYoA3jIv8nKLIWQDnP4/V+WRc8H2zkVItq0vcaV/Hru0XHoqe0quv0Pvi2bbmpvWrVG/6/b5SUI4Vnq4Lm60reEUxKdiaqvYYPUFovWfpGUD3e6KE/pMK/p1AITrOIg2+yXvY5ixoo6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cUuLT/zH; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-78fc4425b6bso66006277b3.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266198; x=1776870998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaoR7RdngMX6lWEV93aUXZBtx2WAn7CMT9IqNm+5uvc=;
        b=CB4CRuC02C757EQyH012KoJ5EZjiWCm2derR+eB8T1j4ngynDkWhgsXVWU5Jmu8ClJ
         qThRGz193+qnSnJqIlSfZcjz1epaGqLYFh+IkuyaKOdYYIU8WPx7eAOKlN7wZRCeJXJ/
         TzS3wn03tQxV4sDN3Jhjq0KoDK6yMw6XZiagjFotuMKabB9YxMdpYHOa4CbGTE+FAmUt
         z8Q7BcGGDiGZgZ92bYyonqOaoPgcjYsU4t8GWoYTjukT7jGbreWAPMGXr8l+oN5KIPQh
         1pQIcd6LuPwDs2JgylV2cCaWf78xZZ/DaV/FXsRnqA9vCags79KwZ9YnAiwlWQgSF3f6
         yMrg==
X-Gm-Message-State: AOJu0YxR2rAF+KcmqCzXLrJGHW/DPyEje6KP04sTF0NXeNfVYmNLZbdb
	XI6Ss96coI4fJzdqpBLH4Z8gYw0JaJj4NEkhf0TNLnMTwmVj/1SNPvEqj/9VW2IN7bv9SslIYXe
	lMPr651tC848dzxjpfN1Ul7mjJZ8TDLC1zKRZx3s1f4aSat9HGTFD+FSj+ANmoPi+5UjLOQvmtk
	6WX/sGwFWLvoBTBEws0jxq8YzHgXY36/WAfRaiBhm90uS4Qzg+Q6hP4MHPdjCuGgHtQDMTg1Igg
	3MDQzx6PQ==
X-Gm-Gg: AeBDietApUwPVpxnmLIiz3cHW35GTnrQVYIdhgGj0doD4DAlc1qlca6gEV0AM7DFdSE
	j9iTQQl8OMaBLCjz+B2Ch/2r/stYm45n+yDxmRRObdTPO/gMbHhzd6xsBSDZy8rBJkPyZdQbUKM
	nn1FOuM7PjSCvUg/+wAIcolrvz/elv10w8bFKESenEqaGfn4Q5nFgiYC/wRdzZopbRlBB1f8yLE
	iW7qaiRp3YOwROAM3d+6Nmirc+wLcgFY/i2SGoW0K9zwU3HGbOXky9pXzsErXe2j7sggzm+jqXa
	yRCTe8KUYLNZ8uMoxrfG/c/Y8kSXO/fq5NllHu1uWCaptC0GKPOgXSI+O7hodMUyh7aFFSXIxMk
	64wFwoQ8d6Qd0tTkyjaaxOp1VVJODkEU16DZkH1QLr/D+9hu4ySgWr4OMjk1DrK9PwOZhouvBW/
	fYQB+itaSjgtquuPNvcWJn/RxJrqccJhRq/qCYbGX/MkkfPhnYb+jgLQ4=
X-Received: by 2002:a05:690c:38b:b0:7af:6904:3f3f with SMTP id 00721157ae682-7af71e49f80mr249046597b3.45.1776266197668;
        Wed, 15 Apr 2026 08:16:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b76651050bsm1525907b3.6.2026.04.15.08.16.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:16:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f20963158so2402307b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776266196; x=1776870996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaoR7RdngMX6lWEV93aUXZBtx2WAn7CMT9IqNm+5uvc=;
        b=cUuLT/zHCJIg7OCusHUGaDfEHRXyrBYfY+4FZ+byOF0FIvVd1THH2KMEptYtplPYeU
         ojex7a00K7icsekHRyeOHBBjevwCKvSuHfIWEBpInD/a2mueYLAvJ4Q1qCG9AkBu9bWX
         FlXmcuQ6CMDMh7cJ6g3VfYnb12+R7AP7BTnng=
X-Received: by 2002:a05:6a00:94f5:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-82f44dcfb5dmr11585733b3a.34.1776266196276;
        Wed, 15 Apr 2026 08:16:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:94f5:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-82f44dcfb5dmr11585682b3a.34.1776266195618;
        Wed, 15 Apr 2026 08:16:35 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f673e0f15sm2996555b3a.35.2026.04.15.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:16:35 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] bnge: fix initial HWRM sequence
Date: Wed, 15 Apr 2026 20:46:20 +0530
Message-ID: <20260415151621.1104956-2-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278823-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E58EE405CB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Firmware may not advertize correct resources if backing store is not
enabled before resource information is queried.
Fix the initial sequence of HWRMs so that driver gets capabilities
and resource information correctly.

Fixes: 3fa9e977a0cd ("bng_en: Initialize default configuration")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 39 ++++++++++---------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index b4090283df0f..9f6a33b912a6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -73,25 +73,35 @@ static int bnge_func_qcaps(struct bnge_dev *bd)
 		return rc;
 	}
 
+	rc = bnge_alloc_ctx_mem(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed to allocate ctx mem rc: %d\n", rc);
+		goto err_free_ctx_mem;
+	}
+
 	rc = bnge_hwrm_func_resc_qcaps(bd);
 	if (rc) {
 		dev_err(bd->dev, "query resc caps failure rc: %d\n", rc);
-		return rc;
+		goto err_free_ctx_mem;
 	}
 
 	rc = bnge_hwrm_func_qcfg(bd);
 	if (rc) {
 		dev_err(bd->dev, "query config failure rc: %d\n", rc);
-		return rc;
+		goto err_free_ctx_mem;
 	}
 
 	rc = bnge_hwrm_vnic_qcaps(bd);
 	if (rc) {
 		dev_err(bd->dev, "vnic caps failure rc: %d\n", rc);
-		return rc;
+		goto err_free_ctx_mem;
 	}
 
 	return 0;
+
+err_free_ctx_mem:
+	bnge_free_ctx_mem(bd);
+	return rc;
 }
 
 static void bnge_fw_unregister_dev(struct bnge_dev *bd)
@@ -132,32 +142,25 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 
 	bnge_hwrm_fw_set_time(bd);
 
-	rc =  bnge_hwrm_func_drv_rgtr(bd);
+	/* Get the resources and configuration from firmware */
+	rc = bnge_func_qcaps(bd);
 	if (rc) {
-		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
+		dev_err(bd->dev, "Failed initial configuration rc: %d\n", rc);
 		return rc;
 	}
 
-	rc = bnge_alloc_ctx_mem(bd);
+	rc = bnge_hwrm_func_drv_rgtr(bd);
 	if (rc) {
-		dev_err(bd->dev, "Failed to allocate ctx mem rc: %d\n", rc);
-		goto err_func_unrgtr;
-	}
-
-	/* Get the resources and configuration from firmware */
-	rc = bnge_func_qcaps(bd);
-	if (rc) {
-		dev_err(bd->dev, "Failed initial configuration rc: %d\n", rc);
-		rc = -ENODEV;
-		goto err_func_unrgtr;
+		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
+		goto err_free_ctx_mem;
 	}
 
 	bnge_set_dflt_rss_hash_type(bd);
 
 	return 0;
 
-err_func_unrgtr:
-	bnge_fw_unregister_dev(bd);
+err_free_ctx_mem:
+	bnge_free_ctx_mem(bd);
 	return rc;
 }
 
-- 
2.47.1


