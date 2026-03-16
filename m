Return-Path: <netdev+bounces-268243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGCeEe1FuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA629EBC3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD987301DBA2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678B33ADAD;
	Mon, 16 Mar 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PBe44P2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8C33B95A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684151; cv=none; b=Na2ke6luFEdvpmHg8wIiWocJuc2NQL7MWZSKuU/Z8LfrRSjdQZWQmnE0jXYKS9YTwd1prq74J8CWqEsO66qJwOLP1ENE10nSUe7m5CeEYMcj+ICVOnaxgvM9YwBTJXLIhMZEvwzeLHLB+4RSARz/cDzaJGD3dtTAwmbL+pdkn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684151; c=relaxed/simple;
	bh=yhPCkquahL7WZSYcwrahzwjH/P9yi8cVens3TYwl/vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XgsWd9SGCf+W/BV+A61Qpi+gzCySMKyXuk1ZbZnlBjTawQtHCgKzrJc8d8kt/Dc5IM5CsY7zQ4VF8hl9zjewVGOvOCuXR0tv7Gf0Y1NTR2qSXGIi8BKvXt1/50kCLdgImYmQsTDDIVOSm98hCAjDYSQFZeJ75kaFhDQ1V4MH57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PBe44P2a; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so1291115241.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684149; x=1774288949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NppxaAva73PDxNG7D55fTsjSwbkwGtyx2/u5D6WkKCc=;
        b=QqcU6dqtHlpYG1SZ2QPZK8h/Hd0e0nCr2abUE8wIcQid1fEIatWP0WbJBrhO4cUgqA
         byR2i+KdyOODIdPj7lT3oalEsw3mXUwjlTpNY6eB9nPdmvapuPSavdehEtVBrVN40w9R
         c/jegO98lvbmksQ646ZtmZihkXC7SQtx1hTL8f/Ny+1DM4l4mguHaJxLYaGLPXIUnIiS
         EAhMhagTBzWIyoAsI6nkG0kbdc9emPCin7pnQgrOZMACgWWt2/Kxg+l1PaGEG1xNHq7q
         SiTztnjR5GObQ1Kn5Lc+mnnnCADuf4Msg7ThDPFPS0BNz36MexMdNvo9ULBkfyXLiJ0P
         +d7Q==
X-Gm-Message-State: AOJu0YwZee55Qygpih242Wocf3KV8WCQZdWaJ6Zsp7suBMDkiT/pvkKg
	0Uy/654PkExIBXD31byz9b911q0GSRNIbzVTIviAJz08/xAGriajKa8J+47fxQ4/BxQqcQnv9Zu
	VtysQOnyhDV5ELD3DWiqh5UbXllcPDsY/m+aBgwuKqZjakxsfmKskykV17mpxig6xX3ulchqf50
	GOpxveAPe9OpgQjjY0h5OBCIVMxYd7bf5T4uo/+tXJiDhAhDkI8GDtSCt2WT0/lbAGbMVmvJS6o
	rHQbcAH+w==
X-Gm-Gg: ATEYQzzMUO4c5bIAmH+7qPmc9d2GvyWoca0sZPfrtW7mhNqXuwQRbmxWUjvMokSUCQD
	z89+c+oUI09uoLHdWBsv7AQqcrBfPLBaiVCQ/hzrf+n6cZl2DlzlE/ZP/gndfCivbWycDr3ZgS+
	WuunlHC7vc6PPnlQaPjjx3ofxGgYg8G1sC1OSQMROFbDDRKuaLDQ6H75hmjKXni3qt3cCk3XCcU
	Mr/ZkSyNcJ1BU3I7KUiSd6ZpOunnlG2c/iA0rOQNQRsmIpm5GCS43UfodPngnkTddmPiYU5r5Mj
	MQE6BMr8nyZStu5JbMz7h2f205H9PI3FoSiAEoXwPoLZzu1q6gU2yyVFaUnlXm2T+YH3cAZE8M4
	UHlYAPUaixobXQ8B6lz6Sg4ifOXxURI8a6bOOxq1nlRbPYftqtWeHK/i0/wFnJ0ZFlXBhqm/q55
	+dTQqoGSZjpPQ/Cai4gPk0IsJ5zaYxtBzD3H017/7YwGPYylMT3T3sfZRRgg==
X-Received: by 2002:a05:6102:3a06:b0:5ff:fbe4:8a4 with SMTP id ada2fe7eead31-6020e586341mr4766313137.21.1773684133681;
        Mon, 16 Mar 2026 11:02:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c50180db0sm3852646d6.27.2026.03.16.11.02.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 11:02:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd773dd409so666533285a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773684131; x=1774288931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NppxaAva73PDxNG7D55fTsjSwbkwGtyx2/u5D6WkKCc=;
        b=PBe44P2abCaAP9d0shykCrenDSbcYw9+MzL44nuID+0pUnfuJzbZ7506O0G/0z0IIL
         U7AfThBFTdCmZL73OWhWmyFS1H+ZXAV+M9FcmnSudQYljoQJere7s4n0OUC1w8yu4eq6
         r5b2QsUpzKGDLtNjhoJELraJUAVayr53CpPNw=
X-Received: by 2002:a05:620a:170f:b0:8c9:e989:9d97 with SMTP id af79cd13be357-8cdb5b56e2fmr1730618285a.68.1773684131194;
        Mon, 16 Mar 2026 11:02:11 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:8c9:e989:9d97 with SMTP id af79cd13be357-8cdb5b56e2fmr1730608085a.68.1773684130245;
        Mon, 16 Mar 2026 11:02:10 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc474dsm1412460685a.6.2026.03.16.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:02:09 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2 1/2] net: bcmasp: fix double free of WoL irq
Date: Mon, 16 Mar 2026 11:02:01 -0700
Message-Id: <20260316180202.3371477-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316180202.3371477-1-justin.chen@broadcom.com>
References: <20260316180202.3371477-1-justin.chen@broadcom.com>
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
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-268243-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9EFA629EBC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

We do not need to free wol_irq since it was instantiated with
devm_request_irq(). So devres will free for us.

Fixes: a2f0751206b0 ("net: bcmasp: Add support for WoL magic packet")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
- Split into two patches.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index aa6d8606849f..2034a1593db7 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1152,12 +1152,6 @@ void bcmasp_enable_wol(struct bcmasp_intf *intf, bool en)
 	}
 }
 
-static void bcmasp_wol_irq_destroy(struct bcmasp_priv *priv)
-{
-	if (priv->wol_irq > 0)
-		free_irq(priv->wol_irq, priv);
-}
-
 static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
 {
 	u32 reg, phy_lpi_overwrite;
@@ -1363,7 +1357,6 @@ static int bcmasp_probe(struct platform_device *pdev)
 	return ret;
 
 err_cleanup:
-	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 
 	return ret;
@@ -1376,7 +1369,6 @@ static void bcmasp_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 }
 
-- 
2.34.1


