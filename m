Return-Path: <netdev+bounces-267202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB8xFlods2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:08:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CF2278875
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1738304AD0E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59A401A06;
	Thu, 12 Mar 2026 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OGvQK5Yu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9140242B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346127; cv=none; b=lshFOqSC8Xg8Tf56eu/szPjT+4LnHkdB8LAaIHfPCA9zJWmidmHyj36/vl/EJuxU7FU+/fCHtKNPXADYlUO7khQKBjstFiJFSweH1xJnLCIC0TGCh1l3j26QzeM6W1XoPaILP0XtJ5caZrXFVRf82DMkFg8bJ4r5GTuFF4zkLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346127; c=relaxed/simple;
	bh=asThX1l8tDd6l/+GF6UQs2U5lUc2VBLgn12nAaEGiHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnIyQDbXWjingGIOQU8F4/A7qOqXsxnp4yzepxTJQk5j+QuxUzU2wVqY6U7/VquYdBIJARgT16zbuumu+n+VpNbhAf/JRSi8RuajKNuKfTl5H4O4fSBfMkexLgMIu56aSFBT5BwIZkgeXJuP5RJ3uNZGwZM6kWJMquj9th0Ge5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OGvQK5Yu; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-4094b31a037so1068278fac.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346125; x=1773950925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wj5xPQzYKHKClh0NTAHjyT/9SZz4TT3jIl1wrDgGOc=;
        b=M+0rIhc/ft7UsqhmIsNF03q/u0WIAJmubGaMyBUhO/Ha0d+7WF3zUcOR97WXk+Xctm
         dqKXxksb0O1uMtc9ziZghWUCzC/pEyiShpcImt8wU/copIOVnqYUYgn21uWaam1Ha/sW
         SBp4A60iPwjZS3fISgVTPUcuZmAftvbCZDNz/ev5PHfw05oLGzhN/5b38DlRhLe1wpiK
         eqGzDd8dEFYbCkAaPsouwgeygcf6IiHsI0yufawrf3K4++ZEFF+B53ADnoWzvUMW3+Je
         OjysAsL8E3ok324p0VDSze92+sFnW2UZGSHMXdLTURI9b26Fpb5H3qecvfs4Qafjodlh
         mQKQ==
X-Gm-Message-State: AOJu0YyIcncCtabn3UBIIvtoSqJSWXnbhwOL6Qdy/eAhhCb5RTWKm9T3
	5tLjvAMFeu4OcH+Tq1ozCjpWfEM5ySIWF0uid2qQWkbN+JQQRaDzj5dvaWHCSMkqmRFIwRQPPkL
	gnujT8UakRHmimVtsyFJgpY5tFr53NkKVGbwnTEnP207xVp/kCWPCRJh3F4VFh3ZD/L1RWcGMIM
	lD+IqNH3DTa3fSbNxNnrHQ8TWBouAudrR9w5vBDEmkL0pso4WDgCk46+blF9V60IZ2LqrhsuLwG
	w3xjKOuiQ==
X-Gm-Gg: ATEYQzy+CK/xkCK3sH9aD8cI/h7woJVCJWG6765WxBw75Gi6L/HhxMAQtZ5x6NffseD
	sQKdhLTj6BFz1yuHomCIWZ7MONB5aMyXDcLdrmcmpvfriTmofUmF64/BQIY/TgWWP+aBfmPqX41
	7DU9bImdv8u0fLh380jFLow37h3p8LwVgTD9eyw88vf4HyThOBHds6yl0b2YAEw9UYCJf67Ikn5
	11f5/JBGwm3pU1hDLZzLDCZaHEKqh3mt2pyL4ED6RPbNXMZezjIPL2Jb3gaUTuFFh0xt+bLEEZM
	pRC9yAfcLj+yKgk/UfjtJR1wd5M4YX3xCSAe/ZZYoSH8hJNcK2sdoJHYyxeAYNAmy4DqPNuwTUN
	W6q8oK/ep2AsvcEi+uh2BtYKnXmd+hEHyT4LMGxk9Aji9l91pTo4bvgOvcuJwFH0pDz6fGLiRA8
	vH/STKCUwcRns0UkkfquFvAuoq3ddmvcg52wn+ekEjHfmvxHl8eBpUkzQ=
X-Received: by 2002:a05:6871:e708:b0:417:211:33ca with SMTP id 586e51a60fabf-417b946b07dmr500036fac.36.1773346124611;
        Thu, 12 Mar 2026 13:08:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4177e1fb7d3sm872308fac.3.2026.03.12.13.08.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 13:08:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-128edc72e5bso9779378c88.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773346123; x=1773950923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wj5xPQzYKHKClh0NTAHjyT/9SZz4TT3jIl1wrDgGOc=;
        b=OGvQK5YuukgwQ/Dz/b91XjqSS2yJUjcZZzZWm6d7EJeP3okcOZSuHr8PdkKAzxqzUx
         g03+F5e6FYxPlHkmTOUA+dsDRsUps7KRo2Rdh8T8Bs7A50W5MATlTocrym12hui/Q/T0
         ruGcif/CEdjuB1JyqXVPsoo2pybIBmd9Oe+IQ=
X-Received: by 2002:a05:7022:e1d:b0:11e:163:be60 with SMTP id a92af1059eb24-128f3deb72emr402568c88.31.1773346122757;
        Thu, 12 Mar 2026 13:08:42 -0700 (PDT)
X-Received: by 2002:a05:7022:e1d:b0:11e:163:be60 with SMTP id a92af1059eb24-128f3deb72emr402539c88.31.1773346121900;
        Thu, 12 Mar 2026 13:08:41 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cb558fsm10210195c88.10.2026.03.12.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:08:41 -0700 (PDT)
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
Subject: [PATCH net] net: bcmasp: fix double frees during remove
Date: Thu, 12 Mar 2026 13:08:14 -0700
Message-Id: <20260312200814.1977164-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-267202-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3CF2278875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

We have two double frees during remove.
- We do not need to free wol_irq since it was instantiated with
  devm_request_irq(). So devres will free for us.
- Switch to devm_clk_get_optional() instead of
  devm_clk_get_optional_enabled() so we can manage the clock ourselves.

Fixes: a2f0751206b0 ("net: bcmasp: Add support for WoL magic packet")
Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index aa6d8606849f..1bfc1f90cd62 100644
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
@@ -1255,11 +1249,15 @@ static int bcmasp_probe(struct platform_device *pdev)
 	if (priv->irq <= 0)
 		return -EINVAL;
 
-	priv->clk = devm_clk_get_optional_enabled(dev, "sw_asp");
+	priv->clk = devm_clk_get_optional(dev, "sw_asp");
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to request clock\n");
 
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to start clock\n");
+
 	/* Base from parent node */
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -1363,7 +1361,6 @@ static int bcmasp_probe(struct platform_device *pdev)
 	return ret;
 
 err_cleanup:
-	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 
 	return ret;
@@ -1376,7 +1373,6 @@ static void bcmasp_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 }
 
-- 
2.34.1


