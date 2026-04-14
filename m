Return-Path: <netdev+bounces-278539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIIBL5Jq3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:25:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFF3FC8AD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A351830AAEA8
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666E3ED11C;
	Tue, 14 Apr 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WWlvS0sp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9193ED119
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183521; cv=none; b=tXEgv+SUsmEYMgFKXaIH6dS4iGwCwTigzmsNNlMiks5n8yrChTLoxmOt76vYUKo0pDkgPuMTuqfWS6qT+kDHOtzRjbgDgjmYiE8kUyawtJ53XXKNFGreDQC43UyIR5jiFlUfk7PmJN6OLVV21PkOefssAC65A5Y7d01zLHP0QHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183521; c=relaxed/simple;
	bh=gVUdKEjON4GA1G9b6SufP7uAK/hQYTLytLaP+RLUQYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAj6N2RhMiVxjD2kF2PJTCksjuJA9IZQZTq4YUA/4EY9b29jLN8Ri6GRkiw4AWaktwfaVYWLct9GTWiScGv167xVlCiKQEeKZCDznHWYjc1iT/KDDchFPT7gtnZXSoEWNYQH5LPc9InzjhSzOf//5mQQy+FX6tonrkoMPRNhkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WWlvS0sp; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7d7e9b97a73so2992583a34.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183519; x=1776788319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqUaI1gG2i65OAenHNZpqv4pjVB97JUWDtLoDJL/AVI=;
        b=KaMElIQQQ+lL6KbzVoVSEVFnKWiRLBrytJ0bxKy++znQS5ya6/jpr8n9cXYfJ/Q8ul
         dAgMwlGaVFbTgxTC3aAaTDXZYvCN5+M9arBZNtK3a5XHpx6SnaL4Xu1M267VfYCGJAin
         lKC3e5HuCI5FoDKIvC1NNbeiGjqyzPP0T0MH3K2VxRXA/AsUTTTs/ql7ROIaXTT12Uyy
         9+9Om+kraseMLIy94dx0lshc3yNTIXMg+JYT2mph2l3bXK33RkW6p9iv8p1IycezqKBg
         cSp4uzIlNs5rCCVqtaJBY7QuVmjjURlCrYst+BwQ0EjGQNNxvLAMFKbo5P5xNOweMia0
         c1Eg==
X-Gm-Message-State: AOJu0YwBxXp05NbQEWFxmE3yI7WSZ3nNB9Mgp/pBfaRKu/ZlJbq+3dKC
	zsntjnW6tjuIFl7KvHNZx3kJXkyOO1ZtZEwR0bpmB2LUa2vDLBEv9+V3D0OXUCu2KCEe6qicHW2
	fGUJ8FzoeYPUShUiAAGaoWQLQOftMybRsfuVmFt7p0p7TYVBXbuqLtsFCSJ5FcYBDy9rdv0TSgw
	pEu1CrEHGo2f8b0feYwIH67uLY8rn6PQpvMOXUTBy158XnwtYMXCylvqd8SYfBFXbqBAspJ4PpE
	PXno+x3DQ==
X-Gm-Gg: AeBDieuRl26xScVu/I7gl2jx8xtWHbbCZo671At3wOIFWUMG15corV+WF3lZybqURbb
	BaBkR2nlWjMDSG63E2/e6RZD2+oL3A4idxzUsm0COG1l9TvQNluWjArRotFyikNg3YwuJGfm99Q
	7SNIpsS7lJVi49oP+0xLVXiHz/yj1149dN/bErdSUbjMUj4k122vdS4AByww2UKcNGweG+jNXBy
	NbCNUieC8y2kEjbxgRCbzRItff0HeD4SY3nqtX6ql2nzIHPPGisUUDLZUyVMBE3QAzxmERjqiNA
	9W886vVneXgaL2uZggrYfimBhNhb03zW0MfCuXEzLZmMSPKl/70tfY7l5iaoJCZ0JuSfYdSU4b7
	11n7DERL/K0I0MhsKwZDybnJCUUrcfmfpMBOJwUGU8gTPxm6+nVyx41EOoLPV2ZSRzx59Gu+UsP
	gK3Mw3Rn2C+NsMsn64XXY5BVDRFcodCOmQlK6Lv6QpEDZOi+T5d9LpRl8=
X-Received: by 2002:a05:6820:2226:b0:688:7731:8d7a with SMTP id 006d021491bc7-68bf66e368fmr8107403eaf.11.1776183519054;
        Tue, 14 Apr 2026 09:18:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-68bcacc6010sm941302eaf.23.2026.04.14.09.18.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 09:18:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so3370018b3a.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776183517; x=1776788317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqUaI1gG2i65OAenHNZpqv4pjVB97JUWDtLoDJL/AVI=;
        b=WWlvS0spkenruSM3zrLOjAIbcf+gCVc/VNSd10uEq2YLw9bUJ3MILyzMmdwMT1uAz1
         4MyxqP7cdrcjoUabFMOOCWXaR9DZsslWIkMJrIAb/1IO9xT2INq9WlZjga9QY+5qAKC+
         ZTD7CNoGZ3nzz6N9y7c3Mlg6QBm8oJXfnsYsI=
X-Received: by 2002:a05:6a21:32a1:b0:39b:b7cb:ee32 with SMTP id adf61e73a8af0-39fe46a2e79mr16518984637.24.1776183517534;
        Tue, 14 Apr 2026 09:18:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a1:b0:39b:b7cb:ee32 with SMTP id adf61e73a8af0-39fe46a2e79mr16518944637.24.1776183516960;
        Tue, 14 Apr 2026 09:18:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219cbc21sm12042656a12.17.2026.04.14.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:18:36 -0700 (PDT)
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
Subject: [PATCH net 1/2] bnge: fix initial HWRM sequence
Date: Tue, 14 Apr 2026 21:48:21 +0530
Message-ID: <20260414161822.742382-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260414161822.742382-1-vikas.gupta@broadcom.com>
References: <20260414161822.742382-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278539-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 25CFF3FC8AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Firmware may not advertize correct resources if backing store is not
enabled before resource information is queried.
Fix the initial sequence of HWRMs so that driver gets capabilities
and resource information correctly.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 40 ++++++++++---------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index b4090283df0f..2b13c552a2f6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -73,30 +73,39 @@ static int bnge_func_qcaps(struct bnge_dev *bd)
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
 {
-	/* ctx mem free after unrgtr only */
 	bnge_hwrm_func_drv_unrgtr(bd);
 	bnge_free_ctx_mem(bd);
 }
@@ -132,32 +141,25 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 
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


