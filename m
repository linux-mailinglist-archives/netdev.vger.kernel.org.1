Return-Path: <netdev+bounces-273035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCC0JjS1yWlO1gUAu9opvQ
	(envelope-from <netdev+bounces-273035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 204AF354681
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03D13300AEEE
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE42FE05C;
	Sun, 29 Mar 2026 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ALjBoXfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7176026
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774826788; cv=none; b=PTXLXZOMMyq04RDyoaFykBDO7BK8JEtOEHMGvhViUsJ32TKCZxBpBSNa/yXCmfKlPw1qd1lUiRUA7fpJLZyPt6P/+4zNga0nHWGj9daL/3fNdW3cp/U+/juBFURQwVD6SiV87b0Fd4d7HWayd0rZ/95kq2jzCftS3Zz62ga+P2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774826788; c=relaxed/simple;
	bh=OSWOvAZ/uD8khdb8o9AUgul7fPYyaIM0O6YJ7UgBO7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ8IXZdqfi9vDCLnANQLEZlweuj+iBKgFhxm3QW9iC7l+CJMM67ZUqvUnzoZU4/XW+eS30Q62rJZT0G/+1qQE4wLsx2ddTPOvMugN9VeKveCiTnSzRLQOKw9dzA4W5OG9HSzgHzwrMgD6DjQPAmYnFJ37cWnZs3v4hllm/vy02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ALjBoXfR; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50baafd6c4aso24598601cf.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774826786; x=1775431586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dS252EhPIpQFLMG3i/SbdRqruQqTR8JZytYv1QxT3p0=;
        b=abns6Cpl7veRdPNQ7YIK+y19U8Z4hSUwkbDYWvq1HxRGcF8smfi9ISOPiRP9h4zXat
         2LS2bXnN1ubPtGYhK42GtWRiHiFTkNkoQaQn9vxyk8vqdrpIbSrlcbPlUd3hBnKEeqJs
         jhf2SybKLV5SLW/u221Rs1RuQQg7xOHrFtpPYt8R0ZATxlDUtbsXuz8nHvBNiHE+XnE1
         +Xj9uLZvx7TKZB9+u15NLcsb8t9edNwIpe8vZBWFfbOjU0P7G6PMkDVBg/XbnP/KtnDR
         Ot1lA60hGYNZZLZZYFBAeU9P8t31Y7eNmmx0LS3NTfWnmIsu77DxwYh8BJSSj9JZXtk3
         w2Ww==
X-Gm-Message-State: AOJu0YyWkmQfv3cgMd58bk2VXyakvG7R9qvqJamernUPWuh/8ANhwj/B
	7MjlR6iNfBL3CF9o+qRP3oJohCzf/YRi5aydsk33xl/lSFEKbM3RhmoHwyWhNKUrk14pVMKgIBT
	1OS/odnCJDfIp2z6ZNu5HroX5ki4WUELpItycnFlg1D1LFp+CnD7I4/1FV3UjodL4JMT0tLRiQk
	o0Yc10GgivqrRP9azIPyVa8rFBO6xAwuXmC5QcoPKRJ5ofWQwzWcAYLyPomuSMza6pR8QCVuP+F
	otPeHugayE=
X-Gm-Gg: ATEYQzwdtqGfE0fpiUphDGhfQRVb+ZqieoZgqi+arZWWRcS5UhaWJehs3uOqiacRIhP
	j6B73GBoIVh8FaRJY4DK7emMikhVr9u9xRftIe4ianw0DzgmnlMfKuV6CXedO5ri4i5OBAAGZkU
	srkgkZBHadhfi6jJ7Uua2tTSYOnDvOPlDmMBeUggpXvAYcXF7kOZMzAnT47I1M9Y8sIT8GYCUye
	cI8dTUsPbgyx09T+fGIgWvME2aZSDH65EcjHS6LQMk4RF4xMq4hNjWXnLr1bDO/cXGTXr0W3ZOA
	RAM+zmcQmPzv8+GIgOa18qVyccLyQ3UUeSXWnWottPMTbZCPjBx0bZzSihkfoAyIRpM3SJh/rVj
	P1ELuWnIoTRBBjpLWo0ZJL+CDXZsgFdcUS22SDkNRb5mWznPIArXSid+UJPZWbJsSHPkQIgwdAF
	V7flQyyhm73qg5uCMz/oOf1EUFlLnPfiA21w0swgJCu80i4cV0ztx3Jy3w
X-Received: by 2002:a05:622a:4014:b0:50b:86f5:8fbb with SMTP id d75a77b69052e-50ba38eaff6mr143494141cf.38.1774826785617;
        Sun, 29 Mar 2026 16:26:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50bb2c5de6dsm7036521cf.1.2026.03.29.16.26.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2026 16:26:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b2cbe7223so128784171cf.2
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774826784; x=1775431584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS252EhPIpQFLMG3i/SbdRqruQqTR8JZytYv1QxT3p0=;
        b=ALjBoXfR9L84fxS4uAWBXSx7wNV1lLbbHyzTcq3Xxa+b5TSAjxiOv4n+grpeJtPc0p
         Lh/oL6J5tIie47DWfmNVVTZuE0O4NqzT8b90l4aB6wNbsfVxd/mvEtKERV0fW5H1VIyB
         3klAxbmcKm5josmTye4FeWE/CDXZ+lPHak9e0=
X-Received: by 2002:a05:622a:4014:b0:50b:86f5:8fbb with SMTP id d75a77b69052e-50ba38eaff6mr143493521cf.38.1774826784098;
        Sun, 29 Mar 2026 16:26:24 -0700 (PDT)
X-Received: by 2002:a05:622a:4014:b0:50b:86f5:8fbb with SMTP id d75a77b69052e-50ba38eaff6mr143493421cf.38.1774826783662;
        Sun, 29 Mar 2026 16:26:23 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb7729698sm41601531cf.29.2026.03.29.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 16:26:22 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 2/3] bnxt_en: Don't assume XDP is never enabled in bnxt_init_dflt_ring_mode()
Date: Sun, 29 Mar 2026 16:25:27 -0700
Message-ID: <20260329232528.870637-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260329232528.870637-1-michael.chan@broadcom.com>
References: <20260329232528.870637-1-michael.chan@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273035-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 204AF354681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The original code made the assumption that when we set up the initial
default ring mode, we must be just loading the driver and XDP cannot
be enabled yet.  This is not true when the FW goes through a resource
or capability change.  Resource reservations will be cancelled and
reinitialized with XDP already enabled.  devlink reload with XDP enabled
will also have the same issue.  This scenario will cause the ring
arithmetic to be all wrong in the bnxt_init_dflt_ring_mode() path
causing failure:

bnxt_en 0000:a1:00.0 ens2f0np0: bnxt_setup_int_mode err: ffffffea
bnxt_en 0000:a1:00.0 ens2f0np0: bnxt_request_irq err: ffffffea
bnxt_en 0000:a1:00.0 ens2f0np0: nic open fail (rc: ffffffea)

Fix it by properly accounting for XDP in the bnxt_init_dflt_ring_mode()
path by using the refactored helper functions in the previous patch.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Fixes: ec5d31e3c15d ("bnxt_en: Handle firmware reset status during IF_UP.")
Fixes: 93550a9c7939 ("bnxt_en: implement devlink dev reload driver_reinit")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fa44c86af67b..f7be1084b775 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16547,6 +16547,10 @@ static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
 	else
 		bp->cp_nr_rings = bp->tx_nr_rings_per_tc + bp->rx_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	if (sh && READ_ONCE(bp->xdp_prog)) {
+		bnxt_set_xdp_tx_rings(bp);
+		bnxt_set_cp_rings(bp, true);
+	}
 }
 
 static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
@@ -16588,16 +16592,17 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+
+	bnxt_adj_tx_rings(bp);
 	if (sh)
-		bnxt_trim_dflt_sh_rings(bp);
+		bnxt_adj_dflt_rings(bp, true);
 
 	/* Rings may have been trimmed, re-reserve the trimmed rings. */
 	if (bnxt_need_reserve_rings(bp)) {
 		rc = __bnxt_reserve_rings(bp);
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
-		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+		bnxt_adj_tx_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16631,7 +16636,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	if (rc)
 		goto init_dflt_ring_err;
 
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	bnxt_adj_tx_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
-- 
2.51.0


