Return-Path: <netdev+bounces-254584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L1NIX37emlaAQIAu9opvQ
	(envelope-from <netdev+bounces-254584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEACAC2D6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E2FB3017FB6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35B2DB7AD;
	Thu, 29 Jan 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bAQSU18c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5552741DF
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667450; cv=none; b=ZG+RlONg0lVBwbvkqqEotUqxikds1lJSKBU57e5p5AGXjfLcVH+yqBYAy51kvs6FCIA2MR1r9ZDt3n5d7dKp3cuwdK3ndUuJSXo+ARqjw0GKDFRVFpHeMH96/o1TZAnbIevsmD+Ruadx6iKeEPvjkHblLzdf8cjWVZXvOXioSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667450; c=relaxed/simple;
	bh=tuE75+S/17HCrd3U2MT5kt15eXwfN60Ek1+La5U1yZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaGKyr2FuBKSkAzT/1mjNOk4V6RpmCsI0+EfQPIx/JjIZ6IT8l84aqc+bXCCuA9EcGw76gho4Fj0WeaGBlmOKl8ZIHseXpt3NHwKJn5ts/bABZV6KdSaywWkhN57zR2SAYw80aH1NmOYu4xJsR5zClrFJhgYuSqQLsZd5aOeYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bAQSU18c; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8c5349ba802so65892085a.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667448; x=1770272248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/KMvR4XXUfM51MqXNT75FdNtnGXJ71jqIXy+OvFE3k=;
        b=mN8MMdtJ/eIT4m7/BB0hIrKj98tQLcsv40vi4Sx2uDHtYQuF/eLlC9WdJ69BgCeHC4
         YeJQrvGNmGy6a4vYyUShCX4tSwKk4ze17rz4iOrBKQieSjTRNTi7IMEMn/n3v4IdWYnQ
         5+/eXOwaLe8LhVBGmdIZQLT1aHvTxYI+nQnurvEPRsAORuo0SHu2K/D7WZzn43Cwao0C
         olMKwSCzQHs+u2uEoPGoWLvMAh99TQjuVCMcDSefqToF/SgW+E5xlyZ5QxZ1SBA4DYY6
         cWaodQydLU6AKfuX1J2kEvdzlYuDOjavX2jbWpaZd+LDk71Rw0UFsnK2ZeMikZCjkGHh
         7iig==
X-Gm-Message-State: AOJu0Yw5rWUt3MEnVn6cO5XPhnqrtUuTU6pR889SyBOZvLJulGn9f/Q2
	EKXqxbR/Oq5vYALDgGTXoe4R6rJgmvAsCIMBzcS9irLrnbG0jfTIHMINkx8tLlSvy7xsNNlhPLe
	M6/CWCfdWrqOwuXM3BSWw0gVqT1l9ljZekJG3Dtw2+WUyezb73cM6v2d9jjbf3QSQyi6xEeCl9w
	SqTvyY2dRL9VO00s4h4U1nkQUYDRfiUE53X7gYzpT54PRGdQuqngTox0TWS3xrWRRNNFcJgIwNt
	NoPi221wMA=
X-Gm-Gg: AZuq6aJkkdIT0deG0PMhnhUtmZ+mFZdaDYdu/iAxizTHxwe0CAWfdae8ThL9iT496fE
	i4loteQtGIw8CuN15AUaAp4kuW3SgSPBM3EApVIyfpiOCZ5EIEw5MPT6s1J6TQ+AJaVH5YDnfUL
	BKO6w32nmmmxWWiyggCN7+r35Lnsm3osYPFEIF6hD2+zgtbtGLeSWTd3gnEqhU+nBm668dJbpGH
	X9TJx65Td7GJlrtvqqe0jcGtcyNEAUJIrtoLIvvLRqIafmpmjEM6qw4LAqN53kQZhwpE7tcXZ7Y
	wVe11/r1QbzRPnPWRiXungbL/UGszfjYe+YFliD0NaUx62+Ckav14BhGWnIvMmTlcxinjj8BrSG
	V+Xr3HB8jW/aLkMxiJCdc1v5fFNmXHRp4TdQ96kzpZe3tLg1wI0SuxblweJDI+Pob/qjeP/pu6H
	rKfyWmb36Om87JqJZ9l4USwyu87iyCMPs4PMId7x9eFQ==
X-Received: by 2002:a05:620a:40d5:b0:8c3:7e05:db01 with SMTP id af79cd13be357-8c70b84cee3mr999277685a.2.1769667447940;
        Wed, 28 Jan 2026 22:17:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d3756c6asm5928666d6.31.2026.01.28.22.17.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 22:17:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124ac76ea5bso3768377c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769667446; x=1770272246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/KMvR4XXUfM51MqXNT75FdNtnGXJ71jqIXy+OvFE3k=;
        b=bAQSU18cHFtHipY3iZtnWv66owCA205+QZWxsUv0+p+l6SLtTkQTY+wfzCQmVtA1H8
         0s0IdgesrgkeP38fhEKCzsEc6gO+MsFOYLi1EIOdEk222M1nHnQnXVJKfP0Xvx+fNqJv
         DNdr3Bzk/ABxTOGK1Lob6xOQiTt0pW/JKZvNU=
X-Received: by 2002:a05:7022:79e:b0:119:e569:fb9a with SMTP id a92af1059eb24-124a005f933mr5024143c88.9.1769667446549;
        Wed, 28 Jan 2026 22:17:26 -0800 (PST)
X-Received: by 2002:a05:7022:79e:b0:119:e569:fb9a with SMTP id a92af1059eb24-124a005f933mr5024131c88.9.1769667446019;
        Wed, 28 Jan 2026 22:17:26 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm5318226c88.14.2026.01.28.22.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:17:25 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Jakub Kicinski <kicinski@meta.com>
Subject: [PATCH net 1/4] bnxt_en: Fix RSS context delete logic
Date: Wed, 28 Jan 2026 22:16:43 -0800
Message-ID: <20260129061646.1417185-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260129061646.1417185-1-michael.chan@broadcom.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254584-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EEEACAC2D6
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
index 8419d1eb4035..64832289e18d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10827,12 +10827,10 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
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


