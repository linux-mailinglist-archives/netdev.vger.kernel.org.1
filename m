Return-Path: <netdev+bounces-258576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPaPBqzWjmmhFQEAu9opvQ
	(envelope-from <netdev+bounces-258576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF82133AE2
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E94F7306ABD9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44957310774;
	Fri, 13 Feb 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hcvxXAfX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5D3101A2
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968737; cv=none; b=fqvhOrOwpk0R42XxvQyKJfVxQYV6gxEXUajAFbqJKl1hov645XUBWsLK7ssgzZlUKf0PiMBvmDe7dGuM4g1/QsKqg++qPDfYrPXhdSQ3TCO3WffbDrZhtV+KXrFTirSMJNcnO5ZHhKMI3nuXV++jY2HKCpTX/L3UvE2SJT0Tjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968737; c=relaxed/simple;
	bh=LsMB9SRllzczMS3HC+p7mM3o+J9cAoiFuMf1XEC93xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax9LHrqbaCIxIJ9CAXTE7uH3RPVNV39vj9ikmzDQbF8phNQ8fWI0cGf1/9DQSBSDT40XLD0pzv9bcKjUIkA0Y1HnKx0Odjd+BAQyQ9P6JryHTEEVq7Jynbv1yNysyMOdJqv3wU8jlr0MlfJIuze94utVm0yCbOISVb1bWWAEryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hcvxXAfX; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8cb3dfb3461so74555785a.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968735; x=1771573535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruKECJu5IehNJ+XnEyXDnyDq4/riJcgy5+ywr6iuJI8=;
        b=VMJSo2rbrfa8wYm+GBh7/ec7SbNlVyMld4UVA3UBcLRyffis1W6rb36MZ6SoxRwK7r
         OiYxn2DSvgOMjqZPt+0UtVYYyuABhUrbylLzs6tSL6k9UAxbVvJbpoU2BY4S6S85034m
         0tVWRxqP4HMVMHSo6GuTbwRT5gEednG7eteqtRy8XU7zTLuzJqBHeGNzeGf6qlRzpC74
         TYHP9j0xT7XVjO3thL/AHLYK916KQN22HW912FG/hAU20stLgcSXHychHBjHr/tnB418
         z9De1KrnapRwERID0dRlJdPEkNMb03tGHsEQ68x8Yj4ZbJnIIVvoGAzBfxB1Tm/rAR5D
         Ms3A==
X-Gm-Message-State: AOJu0YyG43D2cdIEF/JrdU0iPlxMKKgHz13XWmbaU8qpgayqicASFCAz
	sMAnC3vXNdfySOrUNvbZvuDOSBepd/vh3vd72DWzRO9tdKtFolwvuwMeT65raioxbOwYz12QLiw
	HlA1A+k4nVlysd6z9ox6CAONDLe+zbnRD4ecXY2rLgWsPlYY8Q9dShgRsMhCWu1HCKWg2KldPqv
	mt/jHjRdWKFubu0my8Wrs7OvEvJ7OBC3xRiO35eH1lVeP4okL1Vx1lQVVXZR7Ey3AbQshDTQi39
	htfwOiFynQ=
X-Gm-Gg: AZuq6aKVEfUW8lgob5jxqQVZdhF42tY4wFd8gN4FD696t04nwtp6g2lKn2KvHgbjlMA
	bSlO1CA65UPGQWT29OK2c8jKwKH7O4v+VB3NoCAIxwK0yYswH9ZMM6gwHQ5xEfpDNEMrmBSq/rq
	tZxxe1hQFiwMLBfFuxT0lIN9deb+3GaErfeKuBkRWfPYtkHSduVLxwbIuNfSza/BzbhzzkDvn/6
	GEsjNNchcKNdHwTfJ/TEkf269AM+n+/wAXw0+50MKExnDeR7wFkl6GgQqX8ACJAFkTxtTSTn68d
	sf7MkKVFBcf4npSCAmSJqgWU2y7Ur4lQNyb+d6tHS0wUCWotXw77dnJ0FvK8FOrKcJjysKFxx7i
	AdU+goPgkxCqaPMYvsLx6OtQNurb63fywV62b+x0oTp2xEDwD2KEv+nYpm8fCNoxjYH+oS7N8ww
	DtMTFk5M2fGJfSkAYi3t0/oGFE0vGkVev+77cBuMyvDBT64LTd+5ihO3Xvh5M=
X-Received: by 2002:a05:620a:28c3:b0:8c7:7a3:501c with SMTP id af79cd13be357-8cb408d686emr171596185a.52.1770968734562;
        Thu, 12 Feb 2026 23:45:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cd73b39sm8958256d6.28.2026.02.12.23.45.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 23:45:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5033b4d599eso29233281cf.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770968734; x=1771573534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruKECJu5IehNJ+XnEyXDnyDq4/riJcgy5+ywr6iuJI8=;
        b=hcvxXAfXVpUiyK/C13QCfCjMpiWVbLd0Bn8qP2zkITcxPUqe3wUhDauTZSTNhAhd3R
         dyF++QSr61NDYQvgJmdVmX/gdvqmYW2L/6+Af+lzGvBhd3MUmDv4eYGYpgo0y07Pxb7L
         Cyy969yi2DbRQFlu/LJmEW0Km0X/ofDdvbE60=
X-Received: by 2002:ac8:7d44:0:b0:4e8:af8a:f951 with SMTP id d75a77b69052e-506a6b8b14bmr15562211cf.83.1770968733871;
        Thu, 12 Feb 2026 23:45:33 -0800 (PST)
X-Received: by 2002:ac8:7d44:0:b0:4e8:af8a:f951 with SMTP id d75a77b69052e-506a6b8b14bmr15562121cf.83.1770968733400;
        Thu, 12 Feb 2026 23:45:33 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b56bsm58882201cf.17.2026.02.12.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:45:32 -0800 (PST)
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
Subject: [PATCH net v3 1/4] bnxt_en: Fix RSS context delete logic
Date: Thu, 12 Feb 2026 23:45:00 -0800
Message-ID: <20260213074503.2302046-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260213074503.2302046-1-michael.chan@broadcom.com>
References: <20260213074503.2302046-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258576-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8BF82133AE2
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


