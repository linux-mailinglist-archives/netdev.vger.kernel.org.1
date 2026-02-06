Return-Path: <netdev+bounces-257470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEFOFZh8hWlQCQQAu9opvQ
	(envelope-from <netdev+bounces-257470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 624BCFA5AB
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F941301E97C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0ED288C08;
	Fri,  6 Feb 2026 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hEDn2m4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C01A01C6
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355850; cv=none; b=VShAY4cKFxxzxcjjUFC9Db87dP9l3+Z1TX8mTq1RssCfdVIkt9vs5G4nEmhaylzC9/+XUy0lfne0P6IrlfXoQNVBx348p1kII0+YXwT8piSZxxSpB5ean6Y2dknkpelq90feIBp2qw+QevLQOClbq7OfmciEF8qeCLt0aj40jJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355850; c=relaxed/simple;
	bh=tuE75+S/17HCrd3U2MT5kt15eXwfN60Ek1+La5U1yZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZa0C4cuLfbnGvwRZ6ofMxdcYrTLlK0bG7v+osRWOX3ttpu8i9Vt3OPQYLUWZXEIAUV1YwV3/2T24NBRZlAnsYWxDS+VE57ZsKRcYAXfDOiBfz+7nraJLlBZ51rVMm7Vk9rtW+NllhDIMcxF+CHezsFhU3L+AKf7qEfnHVzJ1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hEDn2m4t; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-409de4132b5so252068fac.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770355849; x=1770960649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/KMvR4XXUfM51MqXNT75FdNtnGXJ71jqIXy+OvFE3k=;
        b=viyUhkbCOsTysraKdvEPzb7g0cbH3dg6tMJQS9/pl+lwAXWWclqLGxPulPdF9t7csF
         1I+eEZsXkJw8GR94kfmrdaSVNxldpWtUlUWxjepvXsFbZH+0MIB65ndJ0TtuH2ubong7
         PuHwV8k97/CfVjJXsqFYLqbv1Ok4nPzRmxVuHtxiu4DwEnTImCvw7bTLhOFNn5frsPei
         jFdYLLfDC3BMyVteUAPlga/souq8Qx/xP/KR4NkzWnolh+MkWns4yMWUvKrWFkDssAyy
         zmFs+o4HwNhwIt2XUUzGWAgM5GUaOmXLb3YtCbNP1Wdwacb/usB2+SCtzZ4GxWxHUNd7
         UE1g==
X-Gm-Message-State: AOJu0Yy/ROotxEg/qah4G02tnuNqkPK4CcXoqMPjJZy9X3mWBnfxKhDp
	4vr/j6yatDSYgjhdF5oe31/3lDbjY1A99z7+IEoLvFa9SLiAlDCP/jECUZsYCAR2ag3WOtXW37Z
	JAQwLKuf8Pir28P0x8CTBkLd8AMAOff1F/v2l2QQcGaqaX4I//IPhlXoOaLEStAR7DSi+Gybhwx
	pYUPUb592I23SprntMPW894GqGZEfTPDLElz4r6Rn9EXH/boxPkqj3OFSU62lEntLMdia6w2gt3
	SmLnbyMZDk=
X-Gm-Gg: AZuq6aIkg5TMd6NL8VgrRccc2uVIQMGpAm3SU8SSZxv84XF1EQ7xNaUcu+j26P3KVVk
	wsqy80s7IeNnmIJ6YfyiMAxcE3RqHD7n7hcPUu4JIpOiN5NtaFu6A5oJS5nljRsdvO1OMcx4FbD
	yR7syvUJP2bL4PEt6LPSc8eIWbF+dr48W5GVt/6uwEfC2LPVj/JMQnBcCZgQ1so8B9Kkyo54Ukp
	aaaVR7dzbuteWx1hW3XMezuLdUa2jcJijr/pCh0IK1gzhIYcrmb2RMbxaJPoryiCytMsQssSzYf
	6W4S/94nssWXEj0AjU4n0TsloLsh6nO4v3yaOZQ30INhZ/DkgX7Pm5WzQeTrPHOXQVGCpdelZNd
	eTgLxn0Dj4IK0dj+V/vbXE2IFlMr+vbeWx7Ve4ILp7GfDMe9wEh3PM3lCYD6pD2Zl6EVxAOiVFe
	mPhhysE81/eLdzkGHuI/oA+NB14WiU/t1qTU9mYvOvuQ==
X-Received: by 2002:a05:6870:cb85:b0:3ec:565a:13a4 with SMTP id 586e51a60fabf-40a96fcce12mr882789fac.34.1770355849057;
        Thu, 05 Feb 2026 21:30:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40a989d8bd0sm191303fac.0.2026.02.05.21.30.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 21:30:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d186f4a1fdso835455a34.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770355847; x=1770960647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/KMvR4XXUfM51MqXNT75FdNtnGXJ71jqIXy+OvFE3k=;
        b=hEDn2m4tLfbHnDAEmmEjwPewFu4Ct70ihuxTrhGWDojaDa4WDDYJ3Z78VTQEwFr3iT
         N1kDGLxU/jgSUc6blHONieBL01YFlJx+NoWP3l7/honuNprZvtQTTTMI7MFcCGXYpg3H
         D+6i1MmdpzI8qZj58kd459E1Wtcp9Lqkrt1zE=
X-Received: by 2002:a05:6830:3c88:b0:7cf:cc2c:1d7b with SMTP id 46e09a7af769-7d464406bdamr846836a34.10.1770355846864;
        Thu, 05 Feb 2026 21:30:46 -0800 (PST)
X-Received: by 2002:a05:6830:3c88:b0:7cf:cc2c:1d7b with SMTP id 46e09a7af769-7d464406bdamr846827a34.10.1770355846511;
        Thu, 05 Feb 2026 21:30:46 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4647aa6cbsm903529a34.26.2026.02.05.21.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:30:45 -0800 (PST)
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
Subject: [PATCH net v2 1/4] bnxt_en: Fix RSS context delete logic
Date: Thu,  5 Feb 2026 21:29:27 -0800
Message-ID: <20260206052930.1882740-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260206052930.1882740-1-michael.chan@broadcom.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257470-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 624BCFA5AB
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


