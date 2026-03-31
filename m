Return-Path: <netdev+bounces-273484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNuTKl5vy2k3HwYAu9opvQ
	(envelope-from <netdev+bounces-273484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:53:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A72364A5E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78EB4305F64E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55405370D6B;
	Tue, 31 Mar 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ro6yrOj0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC53B19A6
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939935; cv=none; b=Yy9s/6wFdev/WpnemJ7h2hPO1Gmsf1VU/LZlaslXffLaUSpkFxarOWbu0QkTVGYChxC8f3Pprsr3WBTyos4p7w9df0gFwBY2O6RdjKu4fhzzF5PGVnBGpvkVmze3zTNl9996c78GpNezrnGupPvQFKk2S0jgWI61hC78JaGDEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939935; c=relaxed/simple;
	bh=/1OgYLDwEHxJBpyAokMFCDp5vl+qmWYmsNfdrvzc++s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJwasdx3grB6C+k7AU5fLkr/iQcbnOaSes4MJ13V4IMpYnC8HtMuqCjQdyMEhxpcmhNt8zttg3LEwINSnH6mVpwDHs78nip6R4i1h3Q5DWn1A1FZ4IW/7wjmwIUfQprCVnSjvsRt/mzWSDhZT9d9ffUsoKbBGov5fr1kS1mHkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ro6yrOj0; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-604f834349cso1348479137.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939933; x=1775544733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgCmYxTMS32a0ezMQisHZWTCSW/iVBdMYQeWbZZiVhY=;
        b=fkVOjQ1/cWHq+d9Y5fI0EbMxXtpaR7zr/FAJCIUSvMgt7pbluGWrtwz6DAzyk+hlKS
         BE5so1bFbIKD4rXqKsYyqLVoUV3uPGp44TUO8ICukTIoY0JILgANAXB+pHlzfmXQDgFG
         DumjocyaOiPNNHJUOHfScDHEnHkc1qSqWkijbsesR0d/6DVc8XoJmvJGK4rKRi3uwFWY
         Yu7pPSb4Jzs2zqa995997cr5nnD/6K4LVBDR7PYDXIquxhPnPf9JLmrYqMP5sjs9VSo1
         AWTAxiW29/lelhouMt55GyJUNFZdb5W20wE/UNVS4Jlj3jHWR2NX1Dc5n+WQzgiQ5lRP
         RXZQ==
X-Gm-Message-State: AOJu0YxzmN/nOdQ82LCowORb2PA83eU28GQsluWKEQbNRjLRK7KcYM5/
	IOrVmUo7awrbp6DL1mrZo1/9IajuPQiDxBXkp2ms8NAiW/d3+FeHB4mlO5bmYxp6BWX3NqYuYfx
	CO6Esz2As4YQY3FPmSTIIokma1bKzMUjaGFCPYpj8f7Ft4V3Zxh7z4oHF8BPg0pE0jAi9JdHrB4
	iyHbfZDqAJ4LsfwdoWG7cMD5wTEWvhq5OnLdpjmE+CMglUs2VlE/pT8+YDQZurNjXfjIWqXmcZk
	YnazqYd148=
X-Gm-Gg: ATEYQzzduwbe0c7gt03lc6gS5459KJ6jbbBoWaV0V2caCVHSrTAWaUiGKI0evKoeKl+
	oI+NpOJP9m1reZ4xA//OYwiVKMR+/8wjSvc2IVMWNWaGXQ2FcpFhlxK1UpUhSAsXgbciU76lZpy
	DkrOsIB+pmRW5R1mOATg6MtruTyODU2vBnjhkuO8AtfJXX+cZ6rAsQbDuXOufgZWXUHr2MyQj21
	CfIIoqSL0oZSySRyY9dJwTI9ItafCCH7uc8axB7KrhoQzIjKmRWWrfOviOdnThF0YveolDHyc1i
	gPUkiC5EfSLV1ejZlV4Il086mzNNlhrg3a7wxim1ZRIyuBvnl6V0gqIlqNvyzPJPBjA+X9/WgLA
	3VtGUFNoAW2cJk9Z+NJFb+XgbelT0Lz/93k17nCCgkht6C35j0/Y3yx74tE7VrncKGXAqjFkPbf
	+VbuGf0k+QtQaV7mXGf5BDH/Ab5pRgSrV8u5rIu4oZ2/pZ+9abwyp+pU2G
X-Received: by 2002:a05:6102:5241:b0:604:ee6f:185 with SMTP id ada2fe7eead31-604f92dee03mr5576032137.34.1774939932495;
        Mon, 30 Mar 2026 23:52:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9539e3b226dsm703042241.4.2026.03.30.23.52.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:52:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89c4ec516e5so32930716d6.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774939931; x=1775544731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgCmYxTMS32a0ezMQisHZWTCSW/iVBdMYQeWbZZiVhY=;
        b=Ro6yrOj0pYpU1R5x9Rs7dleomNXUCTxGsAAYj0c7ZqJpOxeWC2eBj9hI2OJGbqICsB
         vMSDjs8NVSQ+rZkWOqc3gZf0CfcNFkU+EEX4sJRnSsCCAa9uarZ+CeGQP5dpgs6yTtXQ
         ZO9pkeeU0Rb6ilY4gqIS/gP4j8ZJR+i3dcPsc=
X-Received: by 2002:ad4:5ca7:0:b0:8a1:34df:bbe3 with SMTP id 6a1803df08f44-8a3b27d3255mr86366d6.28.1774939931232;
        Mon, 30 Mar 2026 23:52:11 -0700 (PDT)
X-Received: by 2002:ad4:5ca7:0:b0:8a1:34df:bbe3 with SMTP id 6a1803df08f44-8a3b27d3255mr86086d6.28.1774939930676;
        Mon, 30 Mar 2026 23:52:10 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbda4d50sm80543966d6.15.2026.03.30.23.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:52:10 -0700 (PDT)
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
Subject: [PATCH net v2 3/3] bnxt_en: Restore default stat ctxs for ULP when resource is available
Date: Mon, 30 Mar 2026 23:51:38 -0700
Message-ID: <20260331065138.948205-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260331065138.948205-1-michael.chan@broadcom.com>
References: <20260331065138.948205-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273484-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50A72364A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

During resource reservation, if the L2 driver does not have enough
MSIX vectors to provide to the RoCE driver, it sets the stat ctxs for
ULP also to 0 so that we don't have to reserve it unnecessarily.

However, subsequently the user may reduce L2 rings thereby freeing up
some resources that the L2 driver can now earmark for RoCE. In this
case, the driver should restore the default ULP stat ctxs to make
sure that all RoCE resources are ready for use.

The RoCE driver may fail to initialize in this scenario without this
fix.

Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f11f3a704da5..3f775196ef81 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8045,6 +8045,8 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
+		else
+			bnxt_set_dflt_ulp_stat_ctxs(bp);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
 			ulp_msix = bp->ulp_num_msix_want;
-- 
2.51.0


