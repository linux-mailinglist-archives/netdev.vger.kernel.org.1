Return-Path: <netdev+bounces-279449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5Wk1Cd7t4mlLAQEAu9opvQ
	(envelope-from <netdev+bounces-279449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:35:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF341FB0E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0003E3023EFA
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBAA2D0615;
	Sat, 18 Apr 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IMs5RT8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7226B973
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776479697; cv=none; b=XFHHBqq1Btrynlqrda4siWPNGfQKkoarjeT733Gn2Fl1E+3+wtRkjI+yQVDPDyogqcvtq5A0ZsQezT6rQVzzlpUdEX2+aFnTaWNdPi2Nrt40hNH9I4ofmqYtivahXFdxwWPKfi1kpp1ZcXnDknZGdR4UZcwF+m63cNX51cPdznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776479697; c=relaxed/simple;
	bh=3tkkBV15w4hNQvuBZUeTgHSyQ++M9S1KubEArpwQCfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM+wfwfd5E+1DVQNUFcaH431YVfqEkztlUSJbZde+p1SMfEJ0ErFPYZv9KQol8ln/FIQk0hz3DpzPIpRfmn0aSWNeTmawY4FHAaA82kslG1+kQJb1kLfGOpkn058fceSRrcKMvGYl/4FETm9ddLjbfhrn9EeA+JSNSbW0jhoTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IMs5RT8B; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7d7f92bde91so741849a34.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776479695; x=1777084495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XX/jjgB0yDPp7+iQrPKvMXw4kJjyI/95lE2PEUSPwQc=;
        b=m95BsWROC7nG3ovNUOLWDViXKO/ZbVSlqXg+Xr3oHfhM1EYE/IRq5pThZ9DTcCZxLG
         R16vsmwQBDtwnNi0BUlYmHBEzgV1aeXsxzGT4Bq8HxY+zjj+o1F3WWxilVAGjGHYlmDH
         QNeSabmYrtbn9TwpcUQ2sW/Y6fhSnVHUYAYhj0Y/n7Czq1W7wDAzCifAA0A9TZoVdehw
         a7B1bhn0Q6H3ciXSndY4sAxnycT/3DHWIlHlW7f9SulflAlSMR/YVLdOc1Zt1EdZgEmf
         oinKCWgS8VBcSsTPZNvw6Mvcg93HaxXQIgHCDVswZmFg4Y1xjnPQ+WeOyLRNT8qpkQ+n
         f6ww==
X-Gm-Message-State: AOJu0YwkCAv9YXzexyuYaKLdt6MgL+ARXV+LHikOvkcL6JhU0WX8FpYu
	CTCK14g0lxtSegWuY11V5NquDWa99KTPGsWuPI28Ol7mjiAhgYh1bmwYaJ+20t/p4Blf162++NX
	oTTDPfVIFmkwXpqSXmkVdbLO4p4LXHl3KiQ08hTB8tHkukJjLwolEe7VItRwBu9Wp3lQRO3aCDb
	u/6tQZ1bd38cxW47gAyh3iVDUytrk6LBTyDI9XpBcsjHyfzn41WWLJ/283Gx1JR1FxKqmbRArRN
	vorVMbfRA==
X-Gm-Gg: AeBDieuHXTuRiOagNbUXQ2ahV9et6s7PR8GqxNRnXw6ITtbb0GpcSkmjPWcEPsBqEmJ
	ZjJoCfIf9hOvkKzgrGBmFi1HnqCwodwVT+Z3NfTAFpO8f7fCS8QtRvHS3HVRtUgDxx8WXUAbMyI
	F7cQIvd637NH/CeTAE+kQxkfq9DTJmF+SS2P8zLR+0DSToHGVYbo5paF/OJP5F3LpkbpJ0UZgZX
	CnnhqjkCYnsJFJo/7PSg3UJhVfzCIPqrfDu/vbUeW1+DIjZKOoaB4H+sSuaj7DOJ8gR3Qc3aaYM
	YWmDajX0QdKv9nR2iLDlTOAlZ8K5ZxQ3n7z9EcIER/zkCSOG5KAQP6RvXCOni81+Iv3oeQiMef2
	P43qwHb1DP2nLq7O3d7vkYG8hEiI0jjM6T39fcsLGIQU4NFzNaz07/xw/dwzEMnWYLoM4yS+mUl
	KJ9f2eNiOhR2N/AW0oGRpF9CWzq18yvPnXAHa7N9DweW24oB8vhmAMYb1uGGMbIdaUjA==
X-Received: by 2002:a05:6820:83c4:20b0:68d:804:55d7 with SMTP id 006d021491bc7-69462e66c4cmr2258831eaf.17.1776479695346;
        Fri, 17 Apr 2026 19:34:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69464e61c3dsm196167eaf.8.2026.04.17.19.34.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 19:34:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so26492635ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776479694; x=1777084494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX/jjgB0yDPp7+iQrPKvMXw4kJjyI/95lE2PEUSPwQc=;
        b=IMs5RT8BIIciKKP+47D5FZllGB1FRqtNtKP55kcfsiYxBvo22SpWOojTIomRlXoL5t
         IMQEd4+LrVxAxECr9H5pR2rN6A0K7mRmPYEZoHr0So5ohSiYKjxiwZSkUST2XeAQ+qX2
         RaKJmVbi7o7aq6xtt7qAaKmSslgmc9I5nnxXA=
X-Received: by 2002:a17:903:32c8:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2b5f9f4df97mr59588685ad.19.1776479693719;
        Fri, 17 Apr 2026 19:34:53 -0700 (PDT)
X-Received: by 2002:a17:903:32c8:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2b5f9f4df97mr59588425ad.19.1776479693309;
        Fri, 17 Apr 2026 19:34:53 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm33427715ad.20.2026.04.17.19.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 19:34:52 -0700 (PDT)
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
Subject: [PATCH net v3 1/2] bnge: fix initial HWRM sequence
Date: Sat, 18 Apr 2026 08:04:37 +0530
Message-ID: <20260418023438.1597876-2-vikas.gupta@broadcom.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C7FF341FB0E
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
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 1c14c5fe8d61..68b74eb2c3a2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -74,6 +74,13 @@ static int bnge_func_qcaps(struct bnge_dev *bd)
 		return rc;
 	}
 
+	return 0;
+}
+
+static int bnge_func_qrcaps_qcfg(struct bnge_dev *bd)
+{
+	int rc;
+
 	rc = bnge_hwrm_func_resc_qcaps(bd);
 	if (rc) {
 		dev_err(bd->dev, "query resc caps failure rc: %d\n", rc);
@@ -133,23 +140,28 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 
 	bnge_hwrm_fw_set_time(bd);
 
-	rc =  bnge_hwrm_func_drv_rgtr(bd);
+	/* Get the resources and configuration from firmware */
+	rc = bnge_func_qcaps(bd);
 	if (rc) {
-		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
+		dev_err(bd->dev, "Failed querying caps rc: %d\n", rc);
 		return rc;
 	}
 
 	rc = bnge_alloc_ctx_mem(bd);
 	if (rc) {
 		dev_err(bd->dev, "Failed to allocate ctx mem rc: %d\n", rc);
-		goto err_func_unrgtr;
+		goto err_free_ctx_mem;
 	}
 
-	/* Get the resources and configuration from firmware */
-	rc = bnge_func_qcaps(bd);
+	rc = bnge_hwrm_func_drv_rgtr(bd);
 	if (rc) {
-		dev_err(bd->dev, "Failed initial configuration rc: %d\n", rc);
-		rc = -ENODEV;
+		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
+		goto err_free_ctx_mem;
+	}
+
+	rc = bnge_func_qrcaps_qcfg(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed querying resources rc: %d\n", rc);
 		goto err_func_unrgtr;
 	}
 
@@ -158,7 +170,9 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 	return 0;
 
 err_func_unrgtr:
-	bnge_fw_unregister_dev(bd);
+	bnge_hwrm_func_drv_unrgtr(bd);
+err_free_ctx_mem:
+	bnge_free_ctx_mem(bd);
 	return rc;
 }
 
-- 
2.47.1


