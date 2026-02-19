Return-Path: <netdev+bounces-259567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDFJD0lcl2lexQIAu9opvQ
	(envelope-from <netdev+bounces-259567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:54:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D60161CCD
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1976F300C39C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300002E7162;
	Thu, 19 Feb 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G57U77cs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957F2773CC
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527227; cv=none; b=ISEq+QuT4ErzjT1r0SyC5oz2WfMVdzIVHhbTg26GN+qTvaHMbNtOEvIzZSDdB/3LMoFzcG70mM1omI7AFuYG9JW2Uo2Ydbh2EurWhsgZ5P/opeVQFzuG0EQzp5wO5JVGth18l7dHHPV2kXiVE7hNPwcjkNwGCFxALn0HFzwJVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527227; c=relaxed/simple;
	bh=LsMB9SRllzczMS3HC+p7mM3o+J9cAoiFuMf1XEC93xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGLlPA8wWUW+nhRjlZl0PTHF6uMz5tkSgHt2kV8oYxBD6WfjC8rgccCw8erae/iFftD+0z2dJd1xqTpimwqYoS8a9yo7T0OAyUn00nkb2AO5DqJt46j2nYApKL2fbNO8sX+Caa4iwZvh/icAvBeiPfUIB8I61kDyF9z1zFzl1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G57U77cs; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3566af9900eso691511a91.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527225; x=1772132025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruKECJu5IehNJ+XnEyXDnyDq4/riJcgy5+ywr6iuJI8=;
        b=qAxZtN2Ts2otntB1vrtHtl/lKx7R67/l/2AprXZBNHEJL5ovSE86tqrLMC47s04RRA
         sWUtjie9aOj9CFOWRHrOg4jYAPFYHViUTl3Z7p86AsqQ1nx7uIAWMd6D41AgEIgFCK0+
         FzC1nkxM6U2vW8Tam3Gwmth3843x3L9RGqR6ZyRuNaEIudC3oealDN30n5xI0e2dEHvi
         mPZ+gncAgZBDtEgjit1SxOLoCxrbvuuSxqlbHtOmNUjNIKr37B2eF7p/ETckVILTMqdS
         GCP08OKi56Ax3TCZzU9tBZZwv5PNqXD+A1jAlLnPyaonjhvGfcbVrKN84+IKLm+Rlh5G
         WN8g==
X-Gm-Message-State: AOJu0Ywo+x+Jg3bc7uzj8XrtdSMpTYzKipLLtaQVea/ptGeyZ2/SqI2c
	6JNuK1869x5cB0SFC02ZskVvUROHSVcVwTB59TZSCzMmw1MVbuUh88Ep809AXkB48XXA4GlxLva
	A+YKbDmqlDoBYl1xwvK91tFqYW4NVyyyyJ4/heP/DUg6t4/gSGkvwCkwi1k1GjsOqQpQlWuhx4C
	y0+sRg1p+1DBaB9LFE74CFm9tyO8Di6kkt1hbPwu+9NU07AKPlPFEjFCLN7d0tHMk4lOlf4wly1
	IDsb1M/stc=
X-Gm-Gg: AZuq6aJp1NvLD9aWgMgU9zby6quG65VLlP+KITAuWkwccuujk/0WIPaqngOofCcm5tc
	qhQ9PPuzxkhQn9t7HoVW61Tfq0Te3bJo0FtrSc/8dG7dJ9ePzAebozXB1VUHJOfgJoUsZG6gZ4S
	rFZzCwUAlm0DwhOW0aiaQa0C1vig6bNU276IUt1LIIxmoHSMvuf5SRXrHA36icfy/z3KlV8yWjh
	zbFygl5cTlbbTG8VpEYuqWCm4CaFi0ErUoBHc8j/k1uRTAy2GbVX9umnpJ8VgNWjcUpDjwGTba8
	QQz/0XW+AZtiNHFaCN5EA4xQIF6qVaFm+ExKXAUXav2qemU16irZZuzCUbuOXGNu5rifrhyaTKQ
	6i+8qmr30meKKNMBH4i8tou2QnLBjKH9ORVlavVZXaUsWQt/G1ZQHZ9h5M/8IqHC/Lm/4Fsm9mo
	y8Pvr/Wu+1LvuGBlO748kGv3RTVvUI0AM1u1Om4y42TTf3heOdqBBR/hiNNrQ=
X-Received: by 2002:a17:90b:28ce:b0:341:2150:4856 with SMTP id 98e67ed59e1d1-358891302f8mr5820229a91.17.1771527225146;
        Thu, 19 Feb 2026 10:53:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3589d837752sm130426a91.5.2026.02.19.10.53.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:53:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba9a159437so1061208eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771527223; x=1772132023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruKECJu5IehNJ+XnEyXDnyDq4/riJcgy5+ywr6iuJI8=;
        b=G57U77csqLvxPbnzlqe9cvOtEkW3XEqDiXFL0VNtH1LVrGtSPezIHox4V2E57WiVji
         qeyhZS5T8k0T17u0sDA+H0Y+kK2yLhuSU5LjV3rqzU+6N6/rtRa0ImjQ2qy6uxGbqe/m
         xYA8yHQgbk3MLyzsjQxfihpTAD/Q9iTWRLWRI=
X-Received: by 2002:a05:7300:6c2b:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2bd4fece111mr3356716eec.4.1771527223124;
        Thu, 19 Feb 2026 10:53:43 -0800 (PST)
X-Received: by 2002:a05:7300:6c2b:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2bd4fece111mr3356698eec.4.1771527222486;
        Thu, 19 Feb 2026 10:53:42 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm21488155eec.29.2026.02.19.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:53:42 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	Jakub Kicinski <kicinski@meta.com>
Subject: [PATCH net v4 1/3] bnxt_en: Fix RSS context delete logic
Date: Thu, 19 Feb 2026 10:53:11 -0800
Message-ID: <20260219185313.2682148-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260219185313.2682148-1-michael.chan@broadcom.com>
References: <20260219185313.2682148-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259567-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 44D60161CCD
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

We need to free the corresponding RSS context VNIC
in FW everytime an RSS context is deleted in driver.
Commit 667ac333dbb7 added a check to delete the VNIC
in FW only when netif_running() is true to help delete
RSS contexts with interface down.

Having that condition will make the driver leak VNICs
in FW whenever close() happens with active RSS contexts.
On the subsequent open(), as part of RSS context restoration,
we will end up trying to create extra VNICs for which we
did not make any reservation. FW can fail this request,
thereby making us lose active RSS contexts.

Suppose an RSS context is deleted already and we try to
process a delete request again, then the HWRM functions
will check for validity of the request and they simply
return if the resource is already freed. So, even for
delete-when-down cases, netif_running() check is not
necessary.

Remove the netif_running() condition check when deleting
an RSS context.

Reported-by: Jakub Kicinski <kicinski@meta.com>
Fixes: 667ac333dbb7 ("eth: bnxt: allow deleting RSS contexts when the device is down")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fb45e1dd1dd7..7768d9753e2d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10889,12 +10889,10 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	struct bnxt_ntuple_filter *ntp_fltr;
 	int i;
 
-	if (netif_running(bp->dev)) {
-		bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
-		for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
-			if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
-				bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
-		}
+	bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
+	for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
+		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
+			bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
 	}
 	if (!all)
 		return;
-- 
2.51.0


