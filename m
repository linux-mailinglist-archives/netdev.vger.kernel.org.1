Return-Path: <netdev+bounces-268242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCoJMMJFuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332C29EBA5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C6430480E6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C533C1B2;
	Mon, 16 Mar 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L3mS2Qrs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6733B6F8
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684137; cv=none; b=X1/7yqqxsGzf5CPYaqGTsYky0W+FwGD0YrGKvmPgyxxfwvEsVOC4bTrDeyqCFbOuoUtN8yTkP1l0ovx95d0sujqHK8/mc1BrVf3xSmJTISAql9LTvLK8iWEww2m5fLosl3YpoEbvA++1jFrMjLrCGSBNn1oB738T7b1dhPrDE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684137; c=relaxed/simple;
	bh=oyuj7t71LQjj1egom5dKyZPOH94Xoz5efKssUxQsga8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhzCj2aPaATuj5c7/lGoduY9H/R5uUocadoDWI95t/P/43QuLIriEysE2je2BjUiq2a7LROYZ4VbKcnMCG2YEgTKS8jTcAb/vAuYaVPRdilpJwHl224tWE0SDjbdIgylKtXHAuLA97Qp5s8ukFrqFRcHDnOI8fpHsvBP4OmJTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L3mS2Qrs; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ab39b111b9so20713975ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684136; x=1774288936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zysSS8H60q+7QyxVieKzw0LalHW4e1jRZejA+TirTLk=;
        b=K16feRNQEcNbIHM/DVkTqnuBsHOAvLZ3uAikiyr3pNwgc8p3wv8N5Vpih32F0DSn3/
         eca2mdTVeXrQ/jy8zeuE9haQpDJKUcudr04+LUINL5zZQx9uPi2gC/bpG+jt9kzM+9Dc
         UYWeI1qsFylbn01m3cbzuRvoO+sLzm6xEkSBgRvX6frYfsPqYKgerQDXjGgYoIlv3pE7
         GG/TdJXZlQRBk7h1QzXFG5CEeXo8sbzPrukJOImkXavdNxUWn4C+X5V0K/AfLf8OicyC
         xxgL9BdZZzbg8tAW3kVDL5gvZk8JR+1z8rIULTc8nFnckZMytz8G2IfMvAr4GVY7cUTA
         eAeg==
X-Gm-Message-State: AOJu0YyRpvMwpiFFtHYHV3K6vKqIwyXkFMI0nNOy4QzTYK+Gva9cepLn
	FDH175Pk86pOSD579vA6z43ZjxIcdC6xoFtYuG6P4fSJ8wOh02yvMX1681Q/3q+WDE3mIC6Vo54
	DzT3mLDa1HFVAGBdN5H/eH7o5y84QvbmqsNJ/Hi7C+ghB7npz9gnRNDCcKbiSUUTyiZ9deiuveB
	KONvuOI7emBDydDSeG9R/ARL31s68qIAuzhs4IteqrQ/FPhmbNIc+DcXCalhXhP+j5eaJX4fhwr
	gY85QDYMQ==
X-Gm-Gg: ATEYQzxtI2IztL04ox+GpsuKuCiq7dyslrWtWZqOPvJLuNr0tcF9WUpE9BbDc0L8v2h
	DhDGf8eB5M94GXKhdts9hwS/tBsrJwaxBMW6LXOPxv/mLe3YstAdLZNmIZ3EYianIJrHWobMawD
	wpsudFUYo1QaVjUC5NkrgK50N1baWydtJoVjP4BW3AkVxZMotsBRPbCmJSX4pnC3+8fFVsBoHvc
	N0r6YK2mj8YBcePRZtm7GuxXTRkaRUZIrQrNfOqvHlhhHOG79zH1gRcaRJyLElrt6T+0gsBWq7A
	J0rIccrXyu6g+g+fPHiI6UNwaw3s9aWveCWM/JeEkr7UAiaxx88Oq+rPYuoH4T/TnBC7iIsH8n3
	8Wt5TLPCCi34WNmZiDkdUtRNrwP5MmUMQuoLuHz+yhwYLla24UOTZ33skCtMPLmZQnvIE6vtvd+
	hkY8Kj5ZPt2Iu37rwwrkPWmjuptKtGesThhRpfYqdQxC1VAKzVx6HYEaI=
X-Received: by 2002:a17:902:d548:b0:2ae:5f65:171 with SMTP id d9443c01a7336-2aecab1ee59mr154818855ad.33.1773684135809;
        Mon, 16 Mar 2026 11:02:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aece81cc9fsm14274525ad.50.2026.03.16.11.02.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 11:02:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd81ce6fdcso4830291885a.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773684134; x=1774288934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zysSS8H60q+7QyxVieKzw0LalHW4e1jRZejA+TirTLk=;
        b=L3mS2QrsOp57fy7Mf5doohT4eo/jGXtQIRDtJGV1SbFAe5cLTLmzuZOpytPNA+DKWj
         Yw95GmlAb59kTP4TvxPIGoxjo3cwZ2UB8DyhU43jFf52skAaFL+uhE/FLe7MhzLLpqYX
         D7lLxsbwCstvWowMHmrJWydJih5bAUcH+/7Yg=
X-Received: by 2002:a05:620a:1a19:b0:8cd:b315:6af6 with SMTP id af79cd13be357-8cdb59fe4f5mr1794591085a.8.1773684134074;
        Mon, 16 Mar 2026 11:02:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:8cd:b315:6af6 with SMTP id af79cd13be357-8cdb59fe4f5mr1794585085a.8.1773684133342;
        Mon, 16 Mar 2026 11:02:13 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc474dsm1412460685a.6.2026.03.16.11.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:02:12 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] net: bcmasp: fix double disable of clk
Date: Mon, 16 Mar 2026 11:02:02 -0700
Message-Id: <20260316180202.3371477-3-justin.chen@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-268242-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 5332C29EBA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

Switch to devm_clk_get_optional() so we can manage the clock ourselves.
We dynamically control the clocks depending on the state of the interface
for power savings. The default state is clock disabled, so unbinding the
driver causes a double disable.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
- Split into two patches.
- Add error path to disable clock if we fail during probe.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 29 +++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 2034a1593db7..dda89afb2917 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1249,7 +1249,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	if (priv->irq <= 0)
 		return -EINVAL;
 
-	priv->clk = devm_clk_get_optional_enabled(dev, "sw_asp");
+	priv->clk = devm_clk_get_optional(dev, "sw_asp");
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to request clock\n");
@@ -1277,6 +1277,10 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	bcmasp_set_pdata(priv, pdata);
 
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to start clock\n");
+
 	/* Enable all clocks to ensure successful probing */
 	bcmasp_core_clock_set(priv, ASP_CTRL_CLOCK_CTRL_ASP_ALL_DISABLE, 0);
 
@@ -1288,8 +1292,10 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, priv->irq, bcmasp_isr, 0,
 			       pdev->name, priv);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to request ASP interrupt: %d", ret);
+	if (ret) {
+		dev_err(dev, "Failed to request ASP interrupt: %d", ret);
+		goto err_clock_disable;
+	}
 
 	/* Register mdio child nodes */
 	of_platform_populate(dev->of_node, bcmasp_mdio_of_match, NULL, dev);
@@ -1301,13 +1307,17 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	priv->mda_filters = devm_kcalloc(dev, priv->num_mda_filters,
 					 sizeof(*priv->mda_filters), GFP_KERNEL);
-	if (!priv->mda_filters)
-		return -ENOMEM;
+	if (!priv->mda_filters) {
+		ret = -ENOMEM;
+		goto err_clock_disable;
+	}
 
 	priv->net_filters = devm_kcalloc(dev, priv->num_net_filters,
 					 sizeof(*priv->net_filters), GFP_KERNEL);
-	if (!priv->net_filters)
-		return -ENOMEM;
+	if (!priv->net_filters) {
+		ret = -ENOMEM;
+		goto err_clock_disable;
+	}
 
 	bcmasp_core_init_filters(priv);
 
@@ -1316,7 +1326,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_clock_disable;
 	}
 
 	i = 0;
@@ -1358,6 +1369,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 err_cleanup:
 	bcmasp_remove_intfs(priv);
+err_clock_disable:
+	clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
-- 
2.34.1


