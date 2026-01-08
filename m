Return-Path: <netdev+bounces-248239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C0D0599E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDC53051B7E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AB331A07C;
	Thu,  8 Jan 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hssYumxP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2B30DEC0
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897369; cv=none; b=TzhRtRTyD8YvZhWHNbPCrhIPSTNZ3RrvmgCNPpyxMMM/JrPB12B9BARIuqJXhXk14xVIqcB3XSFhxLWuhEJBGdvZWKSqw0SPGnDeUS3R1OobzGESHRFF2OMcU5FIegXCSYbGtzQA9qoUXyXDQyf8IM3KJm9BZDxNyDm/9w/lxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897369; c=relaxed/simple;
	bh=KYkptGmkhPtA7qF+rSTOLQ8GbeWeUjh0uwXZfkQ8y+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV5bH/LV8ekxytq2I0NOIsHQU1aLPoAauI3cusISaHBu9IizcSy8F5VzbDl+2hzAYwaK73+ed8GNRd+Bo1boyNDHDUnnbYYeyx/IFQPJ2Ny0rLs1Kr7z6jE1FOFtQcupuDqO+bjfiJr2lQDWTRb5K58kLx+lHb8SdZ3jOh9XOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hssYumxP; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so24412645ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897367; x=1768502167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3jdLozbBaCOuCy+2fPMaFduIkZPhQUP5mxNmDGX6fk=;
        b=HqgC6eYpjHAN9HH0wszy9pFMNnLvhLh2gXSYmemuC1aVy0wx0mvIHdpZTiAIvln1mD
         +mOz4BTuAt/IcFVHib+4/FKsq1hR9jseuqbA9DNc3kbJ2yOj48bkKwrDg5wowrN8MYEX
         i3wkDJI42FB6Uz7xDsidOGSpKqpKk39+9Du+fjQyb03wbq8JifjLvSlr8ab6v5Le2Njl
         Y80fheBnne/JvCEVdiwH1YqCk1u6oYk6QLV5GxwysD3ky5IvU8CCjksjqliyqUuBCZLQ
         vX/I9F6+JAqIB07/a/EOehOoffra6WgLTc3v5CXLPjW2nx5JtobUvUf9Me3Rzwhf3IOu
         gN7A==
X-Gm-Message-State: AOJu0YzoBDP/UgHcBLFAsCxmI/aUcG7evcRV+pCNegiFlKF58P0pokwl
	awajHxVxBPgvB4KFChop/E8WEoZ4jbXvjPiBxTgkKMD27Ta4Npa9INvH1mGscsyYg+v61+MvZka
	wfCH7LAVMMQqAyYZo5P56ShcF2T6Ap83qK8Fic7bijPzHHuib8R94cs+wkGLGY0cIek+uhczMEz
	tbCCsV6WR+S266jOWhYPypPW6zMPeoWssm8APrI7cf9sj1Zvp1qJplZlEp8CTSOsR4EiVdEKAD4
	sGKQVbATAI=
X-Gm-Gg: AY/fxX7Ys/wxu0g7s19Nz0Ie/Z6QA1Yyzb5C+PJaLKGqJUiA5Jy+Q84SyckNQOOr9/t
	h6n01CIMNYGv3ePhF160RCqbW3OSYJebP5uKik/rz/2qAy4itQPogm9MPvZZ8RsanijhxfZP+4m
	QCmClhUgiq7F/eMEFCayBkU5o7jB1Q+xUndoQq1Mwpyp9gIpCf/HudMGVqnsbDdd9qhUZclHNcX
	QG8Raesq8fZibpsPK2GQpdLivFgCan5ICTYEjlIHnw2PJ0WSJD3B/Cth/k4F1g/o//QgXEAQvg/
	qAtzzIDH/daz4rAKNb0LswyvJZpP1fsVRmzM0LStOWmy1ogpe2G/pT4E1ER6mKXDU1QGxbc8bP6
	0+hE/2Yxt3PPQwEAWover+DC/8MfqX36uTALlVpnIj02eLZMPpg63DuvEpxau7rXvXswEtzuurm
	vxpPrE/mF9gmjnARrHvbq5pbNRA01VPOhEvCJfI8hovQ==
X-Google-Smtp-Source: AGHT+IHyhmz3KxCRe9g/VsV9sm2rOTqV/b9iUGhAIbODD/MoWNJUXepfaDYV5xFQoRoGXybx/oHhuog/PKIY
X-Received: by 2002:a17:902:f552:b0:2a3:1b33:ae11 with SMTP id d9443c01a7336-2a3ee4c1534mr63006035ad.53.1767897367008;
        Thu, 08 Jan 2026 10:36:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc49b5sm9992445ad.43.2026.01.08.10.36.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:36:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f4d60d1fbdso64950301cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767897366; x=1768502166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3jdLozbBaCOuCy+2fPMaFduIkZPhQUP5mxNmDGX6fk=;
        b=hssYumxPm9DZbggStvxiLQAnUK5l/VKi9LzWFgV1v9psfjk0gr5DXzWGrCy17bKdgm
         wyd/qtb8qXx+J+a97cgqcdJ4NNPQMchNRuXw9vN1p5/dgMfh0VT529OOaGNmVctR9kSx
         2HOFcKXz53aGnZayJwN4Iq7VkwlAe+ITJj5XQ=
X-Received: by 2002:a05:622a:2505:b0:4ec:f452:4ec0 with SMTP id d75a77b69052e-4ffb4a5857amr99436191cf.69.1767897365895;
        Thu, 08 Jan 2026 10:36:05 -0800 (PST)
X-Received: by 2002:a05:622a:2505:b0:4ec:f452:4ec0 with SMTP id d75a77b69052e-4ffb4a5857amr99435861cf.69.1767897365500;
        Thu, 08 Jan 2026 10:36:05 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm15973721cf.32.2026.01.08.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:36:05 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 2/6] bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
Date: Thu,  8 Jan 2026 10:35:17 -0800
Message-ID: <20260108183521.215610-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260108183521.215610-1-michael.chan@broadcom.com>
References: <20260108183521.215610-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

.getcrosststamp() helps the applications to obtain a snapshot of
device and host time almost taken at the same time. This function
will report PCIe PTM device and host times to any application using
the ioctl PTP_SYS_OFFSET_PRECISE. The device time from the HW is
48-bit and needs to be converted to 64-bit.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Add check for x86 support

v1: https://lore.kernel.org/netdev/20251126215648.1885936-8-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 47 +++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..9ab9ebd57367 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9691,6 +9691,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_EXT_HW_STATS_SUPPORTED;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_PTP_PPS_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_PTP_PPS;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_PTP_PTM_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_PTP_PTM;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_PTP_64BIT_RTC_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_PTP_RTC;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_HOT_RESET_IF_SUPPORT))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f5f07a7e6b29..08d9adf52ec6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2518,6 +2518,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
+	#define BNXT_FW_CAP_PTP_PTM			BIT_ULL(44)
 
 	u32			fw_dbg_cap;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a8a74f07bb54..75ad385f5f79 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -882,6 +882,49 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 	}
 }
 
+static int bnxt_phc_get_syncdevicetime(ktime_t *device,
+				       struct system_counterval_t *system,
+				       void *ctx)
+{
+	struct bnxt_ptp_cfg *ptp = (struct bnxt_ptp_cfg *)ctx;
+	struct hwrm_func_ptp_ts_query_output *resp;
+	struct hwrm_func_ptp_ts_query_input *req;
+	struct bnxt *bp = ptp->bp;
+	u64 ptm_local_ts;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_PTP_TS_QUERY);
+	if (rc)
+		return rc;
+	req->flags = cpu_to_le32(FUNC_PTP_TS_QUERY_REQ_FLAGS_PTM_TIME);
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (rc) {
+		hwrm_req_drop(bp, req);
+		return rc;
+	}
+	ptm_local_ts = le64_to_cpu(resp->ptm_local_ts);
+	*device = ns_to_ktime(bnxt_timecounter_cyc2time(ptp, ptm_local_ts));
+	/* ptm_system_ts is 64-bit */
+	system->cycles = le64_to_cpu(resp->ptm_system_ts);
+	system->cs_id = CSID_X86_ART;
+	system->use_nsecs = true;
+
+	hwrm_req_drop(bp, req);
+
+	return 0;
+}
+
+static int bnxt_ptp_getcrosststamp(struct ptp_clock_info *ptp_info,
+				   struct system_device_crosststamp *xtstamp)
+{
+	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
+						ptp_info);
+
+	return get_device_system_crosststamp(bnxt_phc_get_syncdevicetime,
+					     ptp, NULL, xtstamp);
+}
+
 static const struct ptp_clock_info bnxt_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "bnxt clock",
@@ -1094,6 +1137,10 @@ int bnxt_ptp_init(struct bnxt *bp)
 		if (bnxt_ptp_pps_init(bp))
 			netdev_err(bp->dev, "1pps not initialized, continuing without 1pps support\n");
 	}
+	if ((bp->fw_cap & BNXT_FW_CAP_PTP_PTM) && pcie_ptm_enabled(bp->pdev) &&
+	    boot_cpu_has(X86_FEATURE_ART))
+		ptp->ptp_info.getcrosststamp = bnxt_ptp_getcrosststamp;
+
 	ptp->ptp_clock = ptp_clock_register(&ptp->ptp_info, &bp->pdev->dev);
 	if (IS_ERR(ptp->ptp_clock)) {
 		int err = PTR_ERR(ptp->ptp_clock);
-- 
2.51.0


